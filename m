Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D53821F084
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 14:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbgGNMNd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 08:13:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:35560 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728872AbgGNMNc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 08:13:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B6CBFB1CD;
        Tue, 14 Jul 2020 12:13:32 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E9CEB1E12C9; Tue, 14 Jul 2020 14:13:29 +0200 (CEST)
Date:   Tue, 14 Jul 2020 14:13:29 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 05/10] fsnotify: send MOVE_SELF event with parent/name
 info
Message-ID: <20200714121329.GF23073@quack2.suse.cz>
References: <20200702125744.10535-1-amir73il@gmail.com>
 <20200702125744.10535-6-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702125744.10535-6-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 02-07-20 15:57:39, Amir Goldstein wrote:
> MOVE_SELF event does not get reported to a parent watching children
> when a child is moved, but it can be reported to sb/mount mark with
> parent/name info if group is interested in parent/name info.
> 
> Use the fsnotify_parent() helper to send a MOVE_SELF event and adjust
> fsnotify() to handle the case of an event "on child" that should not
> be sent to the watching parent's inode mark.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/notify/fsnotify.c             | 21 +++++++++++++++++----
>  include/linux/fsnotify.h         |  5 +----
>  include/linux/fsnotify_backend.h |  2 +-
>  3 files changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 6683c77a5b13..0faf5b09a73e 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -352,6 +352,7 @@ int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_type,
>  	struct super_block *sb = to_tell->i_sb;
>  	struct inode *dir = S_ISDIR(to_tell->i_mode) ? to_tell : NULL;
>  	struct mount *mnt = NULL;
> +	struct inode *inode = NULL;
>  	struct inode *child = NULL;
>  	int ret = 0;
>  	__u32 test_mask, marks_mask;
> @@ -362,6 +363,14 @@ int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_type,
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

I'm now confused. Don't you want to fill in FSNOTIFY_OBJ_TYPE_INODE below
for FS_MOVE_SELF event? But this condition is false for it so you won't do
it?

> +
>  	/*
>  	 * Optimization: srcu_read_lock() has a memory barrier which can
>  	 * be expensive.  It protects walking the *_fsnotify_marks lists.
> @@ -369,14 +378,17 @@ int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_type,
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
> @@ -390,14 +402,15 @@ int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_type,
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
> +	if (inode)
> +		iter_info.marks[FSNOTIFY_OBJ_TYPE_INODE] =
> +			fsnotify_first_mark(&inode->i_fsnotify_marks);
>  	if (child) {
>  		iter_info.marks[FSNOTIFY_OBJ_TYPE_CHILD] =
>  			fsnotify_first_mark(&child->i_fsnotify_marks);
> diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> index 044cae3a0628..61dccaf21e7b 100644
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
> @@ -149,8 +147,7 @@ static inline void fsnotify_move(struct inode *old_dir, struct inode *new_dir,
>  	if (target)
>  		fsnotify_link_count(target);
>  
> -	if (source)
> -		fsnotify(source, mask, source, FSNOTIFY_EVENT_INODE, NULL, 0);
> +	fsnotify_dentry(moved, FS_MOVE_SELF);

I'm somewhat unsure about this. Does this mean that 'moved' is guaranteed
to be positive or that you've made sure that all the code below
fsnotify_dentry() is actually fine with a negative dentry? I don't find
either trivial to verify so some note in a changelog or maybe even a
separate patch for this would be useful.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
