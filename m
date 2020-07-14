Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2219321EE0D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 12:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbgGNKe7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 06:34:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:49638 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725841AbgGNKe6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 06:34:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 16570ACDB;
        Tue, 14 Jul 2020 10:34:58 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3D8411E12C9; Tue, 14 Jul 2020 12:34:55 +0200 (CEST)
Date:   Tue, 14 Jul 2020 12:34:55 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 03/10] fsnotify: send event to parent and child with
 single callback
Message-ID: <20200714103455.GD23073@quack2.suse.cz>
References: <20200702125744.10535-1-amir73il@gmail.com>
 <20200702125744.10535-4-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702125744.10535-4-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 02-07-20 15:57:37, Amir Goldstein wrote:
> Instead of calling fsnotify() twice, once with parent inode and once
> with child inode, if event should be sent to parent inode, send it
> with both parent and child inodes marks in object type iterator and call
> the backend handle_event() callback only once.
> 
> The parent inode is assigned to the standard "inode" iterator type and
> the child inode is assigned to the special "child" iterator type.
> 
> In that case, the bit FS_EVENT_ON_CHILD will be set in the event mask,
> the dir argment to handle_event will be the parent inode, the file_name
> argument to handle_event is non NULL and refers to the name of the child
> and the child inode can be accessed with fsnotify_data_inode().
> 
> This will allow fanotify to make decisions based on child or parent's
> ignored mask.  For example, when a parent is interested in a specific
> event on its children, but a specific child wishes to ignore this event,
> the event will not be reported.  This is not what happens with current
> code, but according to man page, it is the expected behavior.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

I like the direction where this is going. But can't we push it even a bit
further? I like the fact that we now have "one fs event" -> "one fsnotify()
call". Ideally I'd like to get rid of FS_EVENT_ON_CHILD in the event mask
because it's purpose seems very weak now and it complicates code (and now
it became even a bit of a misnomer) - intuitively, ->handle_event is now
passed sb, mnt, parent, child so it should have all the info to decide
where the event should be reported and I don't see a need for
FS_EVENT_ON_CHILD flag. With fsnotify() call itself we still use
FS_EVENT_ON_CHILD to determine what the arguments mean but can't we just
mandate that 'data' always points to the child, 'to_tell' is always the
parent dir if watching or NULL (and I'd rename that argument to 'dir' and
maybe move it after 'data_type' argument). What do you think?

Some further comments about the current implementation are below...

> ---
>  fs/kernfs/file.c     | 10 ++++++----
>  fs/notify/fsnotify.c | 40 ++++++++++++++++++++++++++--------------
>  2 files changed, 32 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
> index e23b3f62483c..5b1468bc509e 100644
> --- a/fs/kernfs/file.c
> +++ b/fs/kernfs/file.c
> @@ -883,6 +883,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
>  
>  	list_for_each_entry(info, &kernfs_root(kn)->supers, node) {
>  		struct kernfs_node *parent;
> +		struct inode *p_inode = NULL;
>  		struct inode *inode;
>  		struct qstr name;
>  
> @@ -899,8 +900,6 @@ static void kernfs_notify_workfn(struct work_struct *work)
>  		name = (struct qstr)QSTR_INIT(kn->name, strlen(kn->name));
>  		parent = kernfs_get_parent(kn);
>  		if (parent) {
> -			struct inode *p_inode;
> -
>  			p_inode = ilookup(info->sb, kernfs_ino(parent));
>  			if (p_inode) {
>  				fsnotify(p_inode, FS_MODIFY | FS_EVENT_ON_CHILD,
> @@ -911,8 +910,11 @@ static void kernfs_notify_workfn(struct work_struct *work)
>  			kernfs_put(parent);
>  		}
>  
> -		fsnotify(inode, FS_MODIFY, inode, FSNOTIFY_EVENT_INODE,
> -			 NULL, 0);
> +		if (!p_inode) {
> +			fsnotify(inode, FS_MODIFY, inode, FSNOTIFY_EVENT_INODE,
> +				 NULL, 0);
> +		}
> +
>  		iput(inode);
>  	}
>  
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 51ada3cfd2ff..7c6e624b24c9 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -145,15 +145,17 @@ void __fsnotify_update_child_dentry_flags(struct inode *inode)
>  /*
>   * Notify this dentry's parent about a child's events with child name info
>   * if parent is watching.
> - * Notify also the child without name info if child inode is watching.
> + * Notify only the child without name info if parent is not watching.
>   */
>  int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
>  		      int data_type)
>  {
> +	struct inode *inode = d_inode(dentry);
>  	struct dentry *parent;
>  	struct inode *p_inode;
>  	int ret = 0;
>  
> +	parent = NULL;
>  	if (!(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED))
>  		goto notify_child;
>  
> @@ -165,23 +167,23 @@ int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
>  	} else if (p_inode->i_fsnotify_mask & mask & ALL_FSNOTIFY_EVENTS) {
>  		struct name_snapshot name;
>  
> -		/*
> -		 * We are notifying a parent, so set a flag in mask to inform
> -		 * backend that event has information about a child entry.
> -		 */
> +		/* When notifying parent, child should be passed as data */
> +		WARN_ON_ONCE(inode != fsnotify_data_inode(data, data_type));
> +
> +		/* Notify both parent and child with child name info */
>  		take_dentry_name_snapshot(&name, dentry);
>  		ret = fsnotify(p_inode, mask | FS_EVENT_ON_CHILD, data,
>  			       data_type, &name.name, 0);
>  		release_dentry_name_snapshot(&name);
> +	} else {
> +notify_child:
> +		/* Notify child without child name info */
> +		ret = fsnotify(inode, mask, data, data_type, NULL, 0);
>  	}

AFAICT this will miss notifying the child if the condition
	!fsnotify_inode_watches_children(p_inode)
above is true... And I've noticed this because jumping into a branch in an
if block is usually a bad idea and so I gave it a closer look. Exactly
because of problems like this. Usually it's better to restructure
conditions instead.

In this case I think we could structure the code like:
	struct name_snapshot name
	struct qstr *namestr = NULL;

	if (!(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED))
		goto notify;
	parent = dget_parent(dentry);
	p_inode = parent->d_inode;

	if (unlikely(!fsnotify_inode_watches_children(p_inode))) {
		__fsnotify_update_child_dentry_flags(p_inode);
	} else if (p_inode->i_fsnotify_mask & mask & ALL_FSNOTIFY_EVENTS) {
		take_dentry_name_snapshot(&name, dentry);
		namestr = &name.name;
		mask |= FS_EVENT_ON_CHILD;
	}
notify:
	ret = fsnotify(p_inode, mask, data, data_type, namestr, 0);
	if (namestr)
		release_dentry_name_snapshot(&name);
	dput(parent);
	return ret;
>  
>  	dput(parent);
>  
> -	if (ret)
> -		return ret;
> -
> -notify_child:
> -	return fsnotify(d_inode(dentry), mask, data, data_type, NULL, 0);
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(__fsnotify_parent);
>  
> @@ -322,12 +324,16 @@ int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_type,
>  	struct super_block *sb = to_tell->i_sb;
>  	struct inode *dir = S_ISDIR(to_tell->i_mode) ? to_tell : NULL;
>  	struct mount *mnt = NULL;
> +	struct inode *child = NULL;
>  	int ret = 0;
>  	__u32 test_mask, marks_mask;
>  
>  	if (path)
>  		mnt = real_mount(path->mnt);
>  
> +	if (mask & FS_EVENT_ON_CHILD)
> +		child = fsnotify_data_inode(data, data_type);
> +
>  	/*
>  	 * Optimization: srcu_read_lock() has a memory barrier which can
>  	 * be expensive.  It protects walking the *_fsnotify_marks lists.
> @@ -336,21 +342,23 @@ int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_type,
>  	 * need SRCU to keep them "alive".
>  	 */
>  	if (!to_tell->i_fsnotify_marks && !sb->s_fsnotify_marks &&
> -	    (!mnt || !mnt->mnt_fsnotify_marks))
> +	    (!mnt || !mnt->mnt_fsnotify_marks) &&
> +	    (!child || !child->i_fsnotify_marks))
>  		return 0;
>  
>  	/* An event "on child" is not intended for a mount/sb mark */
>  	marks_mask = to_tell->i_fsnotify_mask;
> -	if (!(mask & FS_EVENT_ON_CHILD)) {
> +	if (!child) {
>  		marks_mask |= sb->s_fsnotify_mask;
>  		if (mnt)
>  			marks_mask |= mnt->mnt_fsnotify_mask;
> +	} else {
> +		marks_mask |= child->i_fsnotify_mask;
>  	}

I don't think this is correct. The FS_EVENT_ON_CHILD events should
also be reported to sb & mnt marks because we now generate only
FS_EVENT_ON_CHILD if parent is watching but that doesn't mean e.g. sb
shouldn't receive the event. Am I missing something? If I'm indeed right,
maybe we should extend our LTP coverage a bit to catch breakage like
this...

>  	/*
>  	 * if this is a modify event we may need to clear the ignored masks
> -	 * otherwise return if neither the inode nor the vfsmount/sb care about
> -	 * this type of event.
> +	 * otherwise return if none of the marks care about this type of event.
>  	 */
>  	test_mask = (mask & ALL_FSNOTIFY_EVENTS);
>  	if (!(mask & FS_MODIFY) && !(test_mask & marks_mask))
> @@ -366,6 +374,10 @@ int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_type,
>  		iter_info.marks[FSNOTIFY_OBJ_TYPE_VFSMOUNT] =
>  			fsnotify_first_mark(&mnt->mnt_fsnotify_marks);
>  	}
> +	if (child) {
> +		iter_info.marks[FSNOTIFY_OBJ_TYPE_CHILD] =
> +			fsnotify_first_mark(&child->i_fsnotify_marks);
> +	}
>  
>  	/*
>  	 * We need to merge inode/vfsmount/sb mark lists so that e.g. inode mark
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
