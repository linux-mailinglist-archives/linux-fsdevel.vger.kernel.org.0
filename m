Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9848842ED77
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Oct 2021 11:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236492AbhJOJXZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Oct 2021 05:23:25 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58254 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234769AbhJOJXY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Oct 2021 05:23:24 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6BF821FD39;
        Fri, 15 Oct 2021 09:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634289677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dVv9mIFIib0sh5t49gp7uep8alWhoBfhNtu2aGFmLLU=;
        b=DqOKCFvXjtgc5FPO8YgWkyRkHEwUWdWjYVWxdo+X2s8z0X9rdXiOMZ4hXxagkdGn2Xns80
        U28nAFX+WrNNzxv3XVTulY/QWtZVdOkDCdCyVolQmQVxe6uozrMrXqds7JGMr77N5GTIZd
        /GkXah2Ix2b17a3dZb9rRI+Sl/rglG0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634289677;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dVv9mIFIib0sh5t49gp7uep8alWhoBfhNtu2aGFmLLU=;
        b=kKfnIOi2SLvkFJlw1i7zq51TE3sZ2V1PKHFoPJw+IH2mBhN88WtSgVmUIrIS9yOWJjsouS
        eZ0fMl6J1T4p8eDw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 5A45DA3B88;
        Fri, 15 Oct 2021 09:21:17 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3C3881E0A40; Fri, 15 Oct 2021 11:21:17 +0200 (CEST)
Date:   Fri, 15 Oct 2021 11:21:17 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     jack@suse.com, amir73il@gmail.com, djwong@kernel.org,
        tytso@mit.edu, dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-api@vger.kernel.org, repnop@google.com, kernel@collabora.com
Subject: Re: [PATCH v7 03/28] fsnotify: clarify contract for create event
 hooks
Message-ID: <20211015092117.GC23102@quack2.suse.cz>
References: <20211014213646.1139469-1-krisman@collabora.com>
 <20211014213646.1139469-4-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014213646.1139469-4-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 14-10-21 18:36:21, Gabriel Krisman Bertazi wrote:
> From: Amir Goldstein <amir73il@gmail.com>
> 
> Clarify argument names and contract for fsnotify_create() and
> fsnotify_mkdir() to reflect the anomaly of kernfs, which leaves dentries
> negavite after mkdir/create.
> 
> Remove the WARN_ON(!inode) in audit code that were added by the Fixes
> commit under the wrong assumption that dentries cannot be negative after
> mkdir/create.
> 
> Fixes: aa93bdc5500c ("fsnotify: use helpers to access data by data_type")
> Link: https://lore.kernel.org/linux-fsdevel/87mtp5yz0q.fsf@collabora.com/
> Reported-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> ---
>  include/linux/fsnotify.h | 22 ++++++++++++++++------
>  kernel/audit_fsnotify.c  |  3 +--
>  kernel/audit_watch.c     |  3 +--
>  3 files changed, 18 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> index df0fa4687a18..1e5f7435a4b5 100644
> --- a/include/linux/fsnotify.h
> +++ b/include/linux/fsnotify.h
> @@ -192,16 +192,22 @@ static inline void fsnotify_inoderemove(struct inode *inode)
>  
>  /*
>   * fsnotify_create - 'name' was linked in
> + *
> + * Caller must make sure that dentry->d_name is stable.
> + * Note: some filesystems (e.g. kernfs) leave @dentry negative and instantiate
> + * ->d_inode later
>   */
> -static inline void fsnotify_create(struct inode *inode, struct dentry *dentry)
> +static inline void fsnotify_create(struct inode *dir, struct dentry *dentry)
>  {
> -	audit_inode_child(inode, dentry, AUDIT_TYPE_CHILD_CREATE);
> +	audit_inode_child(dir, dentry, AUDIT_TYPE_CHILD_CREATE);
>  
> -	fsnotify_dirent(inode, dentry, FS_CREATE);
> +	fsnotify_dirent(dir, dentry, FS_CREATE);
>  }
>  
>  /*
>   * fsnotify_link - new hardlink in 'inode' directory
> + *
> + * Caller must make sure that new_dentry->d_name is stable.
>   * Note: We have to pass also the linked inode ptr as some filesystems leave
>   *   new_dentry->d_inode NULL and instantiate inode pointer later
>   */
> @@ -230,12 +236,16 @@ static inline void fsnotify_unlink(struct inode *dir, struct dentry *dentry)
>  
>  /*
>   * fsnotify_mkdir - directory 'name' was created
> + *
> + * Caller must make sure that dentry->d_name is stable.
> + * Note: some filesystems (e.g. kernfs) leave @dentry negative and instantiate
> + * ->d_inode later
>   */
> -static inline void fsnotify_mkdir(struct inode *inode, struct dentry *dentry)
> +static inline void fsnotify_mkdir(struct inode *dir, struct dentry *dentry)
>  {
> -	audit_inode_child(inode, dentry, AUDIT_TYPE_CHILD_CREATE);
> +	audit_inode_child(dir, dentry, AUDIT_TYPE_CHILD_CREATE);
>  
> -	fsnotify_dirent(inode, dentry, FS_CREATE | FS_ISDIR);
> +	fsnotify_dirent(dir, dentry, FS_CREATE | FS_ISDIR);
>  }
>  
>  /*
> diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
> index 60739d5e3373..02348b48447c 100644
> --- a/kernel/audit_fsnotify.c
> +++ b/kernel/audit_fsnotify.c
> @@ -160,8 +160,7 @@ static int audit_mark_handle_event(struct fsnotify_mark *inode_mark, u32 mask,
>  
>  	audit_mark = container_of(inode_mark, struct audit_fsnotify_mark, mark);
>  
> -	if (WARN_ON_ONCE(inode_mark->group != audit_fsnotify_group) ||
> -	    WARN_ON_ONCE(!inode))
> +	if (WARN_ON_ONCE(inode_mark->group != audit_fsnotify_group))
>  		return 0;
>  
>  	if (mask & (FS_CREATE|FS_MOVED_TO|FS_DELETE|FS_MOVED_FROM)) {
> diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
> index 2acf7ca49154..223eed7b39cd 100644
> --- a/kernel/audit_watch.c
> +++ b/kernel/audit_watch.c
> @@ -472,8 +472,7 @@ static int audit_watch_handle_event(struct fsnotify_mark *inode_mark, u32 mask,
>  
>  	parent = container_of(inode_mark, struct audit_parent, mark);
>  
> -	if (WARN_ON_ONCE(inode_mark->group != audit_watch_group) ||
> -	    WARN_ON_ONCE(!inode))
> +	if (WARN_ON_ONCE(inode_mark->group != audit_watch_group))
>  		return 0;
>  
>  	if (mask & (FS_CREATE|FS_MOVED_TO) && inode)
> -- 
> 2.33.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
