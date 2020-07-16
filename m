Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF91222432
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 15:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbgGPNp7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 09:45:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:41092 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726986AbgGPNp7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 09:45:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D2197B1E2;
        Thu, 16 Jul 2020 13:46:00 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C39171E12C9; Thu, 16 Jul 2020 15:45:56 +0200 (CEST)
Date:   Thu, 16 Jul 2020 15:45:56 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 17/22] fsnotify: send MOVE_SELF event with parent/name
 info
Message-ID: <20200716134556.GE5022@quack2.suse.cz>
References: <20200716084230.30611-1-amir73il@gmail.com>
 <20200716084230.30611-18-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716084230.30611-18-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 16-07-20 11:42:25, Amir Goldstein wrote:
> MOVE_SELF event does not get reported to a parent watching children
> when a child is moved, but it can be reported to sb/mount mark or to
> the moved inode itself with parent/name info if group is interested
> in parent/name info.
> 
> Use the fsnotify_parent() helper to send a MOVE_SELF event and adjust
> fsnotify() to handle the case of an event "on child" that should not
> be sent to the watching parent's inode mark.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

What I find strange about this is that the MOVE_SELF event will be reported
to the new parent under the new name (just due to the way how dentry
handling in vfs_rename() works). That seems rather arbitrary and I'm not
sure it would be useful? I guess anybody needing dir info with renames
will rather use FS_MOVED_FROM / FS_MOVED_TO where it is well defined?

So can we leave FS_MOVE_SELF as one of those cases that doesn't report
parent + name info?

								Honza


> ---
>  fs/notify/fsnotify.c             | 22 ++++++++++++++++++----
>  include/linux/fsnotify.h         |  4 +---
>  include/linux/fsnotify_backend.h |  2 +-
>  3 files changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index efa5c1c4908a..fa84aea47b20 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -367,6 +367,7 @@ int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_type,
>  	struct super_block *sb = to_tell->i_sb;
>  	struct inode *dir = S_ISDIR(to_tell->i_mode) ? to_tell : NULL;
>  	struct mount *mnt = NULL;
> +	struct inode *inode = NULL;
>  	struct inode *child = NULL;
>  	int ret = 0;
>  	__u32 test_mask, marks_mask;
> @@ -377,6 +378,14 @@ int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_type,
>  	if (mask & FS_EVENT_ON_CHILD)
>  		child = fsnotify_data_inode(data, data_type);
>  
> +	/*
> +	 * If event is "on child" then to_tell is a watching parent.
> +	 * An event "on child" may be sent to mount/sb mark with parent/name
> +	 * info, but not appropriate for watching parent (e.g. FS_MOVE_SELF).
> +	 */
> +	if (!child || (mask & FS_EVENTS_POSS_ON_CHILD))
> +		inode = to_tell;
> +
>  	/*
>  	 * Optimization: srcu_read_lock() has a memory barrier which can
>  	 * be expensive.  It protects walking the *_fsnotify_marks lists.
> @@ -384,14 +393,17 @@ int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_type,
>  	 * SRCU because we have no references to any objects and do not
>  	 * need SRCU to keep them "alive".
>  	 */
> -	if (!to_tell->i_fsnotify_marks && !sb->s_fsnotify_marks &&
> +	if (!sb->s_fsnotify_marks &&
>  	    (!mnt || !mnt->mnt_fsnotify_marks) &&
> +	    (!inode || !inode->i_fsnotify_marks) &&
>  	    (!child || !child->i_fsnotify_marks))
>  		return 0;
>  
> -	marks_mask = to_tell->i_fsnotify_mask | sb->s_fsnotify_mask;
> +	marks_mask = sb->s_fsnotify_mask;
>  	if (mnt)
>  		marks_mask |= mnt->mnt_fsnotify_mask;
> +	if (inode)
> +		marks_mask |= inode->i_fsnotify_mask;
>  	if (child)
>  		marks_mask |= child->i_fsnotify_mask;
>  
> @@ -406,14 +418,16 @@ int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_type,
>  
>  	iter_info.srcu_idx = srcu_read_lock(&fsnotify_mark_srcu);
>  
> -	iter_info.marks[FSNOTIFY_OBJ_TYPE_INODE] =
> -		fsnotify_first_mark(&to_tell->i_fsnotify_marks);
>  	iter_info.marks[FSNOTIFY_OBJ_TYPE_SB] =
>  		fsnotify_first_mark(&sb->s_fsnotify_marks);
>  	if (mnt) {
>  		iter_info.marks[FSNOTIFY_OBJ_TYPE_VFSMOUNT] =
>  			fsnotify_first_mark(&mnt->mnt_fsnotify_marks);
>  	}
> +	if (inode) {
> +		iter_info.marks[FSNOTIFY_OBJ_TYPE_INODE] =
> +			fsnotify_first_mark(&inode->i_fsnotify_marks);
> +	}
>  	if (child) {
>  		iter_info.marks[FSNOTIFY_OBJ_TYPE_CHILD] =
>  			fsnotify_first_mark(&child->i_fsnotify_marks);
> diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> index fe4f2bc5b4c2..61dccaf21e7b 100644
> --- a/include/linux/fsnotify.h
> +++ b/include/linux/fsnotify.h
> @@ -131,7 +131,6 @@ static inline void fsnotify_move(struct inode *old_dir, struct inode *new_dir,
>  	u32 fs_cookie = fsnotify_get_cookie();
>  	__u32 old_dir_mask = FS_MOVED_FROM;
>  	__u32 new_dir_mask = FS_MOVED_TO;
> -	__u32 mask = FS_MOVE_SELF;
>  	const struct qstr *new_name = &moved->d_name;
>  
>  	if (old_dir == new_dir)
> @@ -140,7 +139,6 @@ static inline void fsnotify_move(struct inode *old_dir, struct inode *new_dir,
>  	if (isdir) {
>  		old_dir_mask |= FS_ISDIR;
>  		new_dir_mask |= FS_ISDIR;
> -		mask |= FS_ISDIR;
>  	}
>  
>  	fsnotify_name(old_dir, old_dir_mask, source, old_name, fs_cookie);
> @@ -149,7 +147,7 @@ static inline void fsnotify_move(struct inode *old_dir, struct inode *new_dir,
>  	if (target)
>  		fsnotify_link_count(target);
>  
> -	fsnotify(source, mask, source, FSNOTIFY_EVENT_INODE, NULL, 0);
> +	fsnotify_dentry(moved, FS_MOVE_SELF);
>  	audit_inode_child(new_dir, moved, AUDIT_TYPE_CHILD_CREATE);
>  }
>  
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index 6f0df110e9f8..acce2ec17edf 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -89,7 +89,7 @@
>   * It may include events that can be sent to an inode/sb/mount mark, but cannot
>   * be sent to a parent watching children.
>   */
> -#define FS_EVENTS_POSS_TO_PARENT (FS_EVENTS_POSS_ON_CHILD)
> +#define FS_EVENTS_POSS_TO_PARENT (FS_EVENTS_POSS_ON_CHILD | FS_MOVE_SELF)
>  
>  /* Events that can be reported to backends */
>  #define ALL_FSNOTIFY_EVENTS (ALL_FSNOTIFY_DIRENT_EVENTS | \
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
