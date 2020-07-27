Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D40C22F517
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jul 2020 18:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730149AbgG0Q1B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jul 2020 12:27:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:58944 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728398AbgG0Q1A (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jul 2020 12:27:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2FA17AB99;
        Mon, 27 Jul 2020 16:27:09 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 619BB1E12C5; Mon, 27 Jul 2020 18:26:58 +0200 (CEST)
Date:   Mon, 27 Jul 2020 18:26:58 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/9] fsnotify: create helper fsnotify_inode()
Message-ID: <20200727162658.GG5284@quack2.suse.cz>
References: <20200722125849.17418-1-amir73il@gmail.com>
 <20200722125849.17418-5-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722125849.17418-5-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 22-07-20 15:58:44, Amir Goldstein wrote:
> Simple helper to consolidate biolerplate code.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Applied. Thanks!

								Honza

> ---
>  fs/kernfs/file.c         |  6 ++----
>  fs/notify/fsnotify.c     |  2 +-
>  include/linux/fsnotify.h | 26 +++++++++++---------------
>  kernel/trace/trace.c     |  3 +--
>  4 files changed, 15 insertions(+), 22 deletions(-)
> 
> diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
> index 5b1468bc509e..1d185bffc52f 100644
> --- a/fs/kernfs/file.c
> +++ b/fs/kernfs/file.c
> @@ -910,10 +910,8 @@ static void kernfs_notify_workfn(struct work_struct *work)
>  			kernfs_put(parent);
>  		}
>  
> -		if (!p_inode) {
> -			fsnotify(inode, FS_MODIFY, inode, FSNOTIFY_EVENT_INODE,
> -				 NULL, 0);
> -		}
> +		if (!p_inode)
> +			fsnotify_inode(inode, FS_MODIFY);
>  
>  		iput(inode);
>  	}
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index efa5c1c4908a..277af3d5efce 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -74,7 +74,7 @@ static void fsnotify_unmount_inodes(struct super_block *sb)
>  			iput(iput_inode);
>  
>  		/* for each watch, send FS_UNMOUNT and then remove it */
> -		fsnotify(inode, FS_UNMOUNT, inode, FSNOTIFY_EVENT_INODE, NULL, 0);
> +		fsnotify_inode(inode, FS_UNMOUNT);
>  
>  		fsnotify_inode_delete(inode);
>  
> diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> index fe4f2bc5b4c2..01b71ad91339 100644
> --- a/include/linux/fsnotify.h
> +++ b/include/linux/fsnotify.h
> @@ -38,6 +38,14 @@ static inline void fsnotify_dirent(struct inode *dir, struct dentry *dentry,
>  	fsnotify_name(dir, mask, d_inode(dentry), &dentry->d_name, 0);
>  }
>  
> +static inline void fsnotify_inode(struct inode *inode, __u32 mask)
> +{
> +	if (S_ISDIR(inode->i_mode))
> +		mask |= FS_ISDIR;
> +
> +	fsnotify(inode, mask, inode, FSNOTIFY_EVENT_INODE, NULL, 0);
> +}
> +
>  /* Notify this dentry's parent about a child's events. */
>  static inline int fsnotify_parent(struct dentry *dentry, __u32 mask,
>  				  const void *data, int data_type)
> @@ -111,12 +119,7 @@ static inline int fsnotify_perm(struct file *file, int mask)
>   */
>  static inline void fsnotify_link_count(struct inode *inode)
>  {
> -	__u32 mask = FS_ATTRIB;
> -
> -	if (S_ISDIR(inode->i_mode))
> -		mask |= FS_ISDIR;
> -
> -	fsnotify(inode, mask, inode, FSNOTIFY_EVENT_INODE, NULL, 0);
> +	fsnotify_inode(inode, FS_ATTRIB);
>  }
>  
>  /*
> @@ -131,7 +134,6 @@ static inline void fsnotify_move(struct inode *old_dir, struct inode *new_dir,
>  	u32 fs_cookie = fsnotify_get_cookie();
>  	__u32 old_dir_mask = FS_MOVED_FROM;
>  	__u32 new_dir_mask = FS_MOVED_TO;
> -	__u32 mask = FS_MOVE_SELF;
>  	const struct qstr *new_name = &moved->d_name;
>  
>  	if (old_dir == new_dir)
> @@ -140,7 +142,6 @@ static inline void fsnotify_move(struct inode *old_dir, struct inode *new_dir,
>  	if (isdir) {
>  		old_dir_mask |= FS_ISDIR;
>  		new_dir_mask |= FS_ISDIR;
> -		mask |= FS_ISDIR;
>  	}
>  
>  	fsnotify_name(old_dir, old_dir_mask, source, old_name, fs_cookie);
> @@ -149,7 +150,7 @@ static inline void fsnotify_move(struct inode *old_dir, struct inode *new_dir,
>  	if (target)
>  		fsnotify_link_count(target);
>  
> -	fsnotify(source, mask, source, FSNOTIFY_EVENT_INODE, NULL, 0);
> +	fsnotify_inode(source, FS_MOVE_SELF);
>  	audit_inode_child(new_dir, moved, AUDIT_TYPE_CHILD_CREATE);
>  }
>  
> @@ -174,12 +175,7 @@ static inline void fsnotify_vfsmount_delete(struct vfsmount *mnt)
>   */
>  static inline void fsnotify_inoderemove(struct inode *inode)
>  {
> -	__u32 mask = FS_DELETE_SELF;
> -
> -	if (S_ISDIR(inode->i_mode))
> -		mask |= FS_ISDIR;
> -
> -	fsnotify(inode, mask, inode, FSNOTIFY_EVENT_INODE, NULL, 0);
> +	fsnotify_inode(inode, FS_DELETE_SELF);
>  	__fsnotify_inode_delete(inode);
>  }
>  
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index bb62269724d5..0c655c039506 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -1543,8 +1543,7 @@ static void latency_fsnotify_workfn(struct work_struct *work)
>  {
>  	struct trace_array *tr = container_of(work, struct trace_array,
>  					      fsnotify_work);
> -	fsnotify(tr->d_max_latency->d_inode, FS_MODIFY,
> -		 tr->d_max_latency->d_inode, FSNOTIFY_EVENT_INODE, NULL, 0);
> +	fsnotify_inode(tr->d_max_latency->d_inode, FS_MODIFY);
>  }
>  
>  static void latency_fsnotify_workfn_irq(struct irq_work *iwork)
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
