Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8A43E588F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 12:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239903AbhHJKr6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 06:47:58 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58422 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236505AbhHJKr5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 06:47:57 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 016A520096;
        Tue, 10 Aug 2021 10:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628592455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3J83bcO0i1dHIsOo7hfq+MCoQEef3eTo0VJ8omEls64=;
        b=0m6sOIZJLcfgeL6bA1sfbJaeP7ZazbHOFK6E9Kwt1pGeDwRfhltJOiZQ+YKmMtIky2RT/M
        KKI/BzXhDU/+VR5+x5Umr8JiPIMlH8JoF8lsg0Ic0V0bBR+3LdRu20GMFVQHRzTOiIRPZh
        1jt4PVV62vqLd62Sjbxy7nyRUoAWt5k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628592455;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3J83bcO0i1dHIsOo7hfq+MCoQEef3eTo0VJ8omEls64=;
        b=n6G3l2/Ij7We0XtQWgy6+MTE4gXWkmms3wCykAD/+FOKk6a0ky1A4aOUIRw/831qSwzw9J
        aN6uPQ4Bh9gH5JDQ==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id AD9A9A3C69;
        Tue, 10 Aug 2021 10:47:34 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 86FE21E3BFC; Tue, 10 Aug 2021 12:47:34 +0200 (CEST)
Date:   Tue, 10 Aug 2021 12:47:34 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/4] fsnotify: count all objects with attached connectors
Message-ID: <20210810104734.GC18722@quack2.suse.cz>
References: <20210803180344.2398374-1-amir73il@gmail.com>
 <20210803180344.2398374-4-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803180344.2398374-4-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 03-08-21 21:03:43, Amir Goldstein wrote:
> Rename s_fsnotify_inode_refs to s_fsnotify_conectors and count all
> objects with attached connectors, not only inodes with attached
> connectors.
> 
> This will be used to optimize fsnotify() calls on sb without any
> type of marks.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/notify/fsnotify.c |  6 +++---
>  fs/notify/mark.c     | 45 +++++++++++++++++++++++++++++++++++++++++---
>  include/linux/fs.h   |  4 ++--
>  3 files changed, 47 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 30d422b8c0fc..a5de7f32c493 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -87,9 +87,9 @@ static void fsnotify_unmount_inodes(struct super_block *sb)
>  
>  	if (iput_inode)
>  		iput(iput_inode);
> -	/* Wait for outstanding inode references from connectors */
> -	wait_var_event(&sb->s_fsnotify_inode_refs,
> -		       !atomic_long_read(&sb->s_fsnotify_inode_refs));
> +	/* Wait for outstanding object references from connectors */
> +	wait_var_event(&sb->s_fsnotify_connectors,
> +		       !atomic_long_read(&sb->s_fsnotify_connectors));
>  }

I think this is wrong and will deadlock unmount if there's pending sb mark
because s_fsnotify_connectors won't drop to 0. I think you need to move
this wait to fsnotify_sb_delete() after fsnotify_clear_marks_by_sb().

Otherwise the patch looks good to me.

								Honza

>  
>  void fsnotify_sb_delete(struct super_block *sb)
> diff --git a/fs/notify/mark.c b/fs/notify/mark.c
> index 2d8c46e1167d..622bcbface4f 100644
> --- a/fs/notify/mark.c
> +++ b/fs/notify/mark.c
> @@ -172,7 +172,7 @@ static void fsnotify_connector_destroy_workfn(struct work_struct *work)
>  static void fsnotify_get_inode_ref(struct inode *inode)
>  {
>  	ihold(inode);
> -	atomic_long_inc(&inode->i_sb->s_fsnotify_inode_refs);
> +	atomic_long_inc(&inode->i_sb->s_fsnotify_connectors);
>  }
>  
>  static void fsnotify_put_inode_ref(struct inode *inode)
> @@ -180,8 +180,45 @@ static void fsnotify_put_inode_ref(struct inode *inode)
>  	struct super_block *sb = inode->i_sb;
>  
>  	iput(inode);
> -	if (atomic_long_dec_and_test(&sb->s_fsnotify_inode_refs))
> -		wake_up_var(&sb->s_fsnotify_inode_refs);
> +	if (atomic_long_dec_and_test(&sb->s_fsnotify_connectors))
> +		wake_up_var(&sb->s_fsnotify_connectors);
> +}
> +
> +static void fsnotify_get_sb_connectors(struct fsnotify_mark_connector *conn)
> +{
> +	struct super_block *sb;
> +
> +	if (conn->type == FSNOTIFY_OBJ_TYPE_DETACHED)
> +		return;
> +
> +	if (conn->type == FSNOTIFY_OBJ_TYPE_INODE)
> +		sb = fsnotify_conn_inode(conn)->i_sb;
> +	else if (conn->type == FSNOTIFY_OBJ_TYPE_VFSMOUNT)
> +		sb = fsnotify_conn_mount(conn)->mnt.mnt_sb;
> +	else if (conn->type == FSNOTIFY_OBJ_TYPE_SB)
> +		sb = fsnotify_conn_sb(conn);
> +
> +	atomic_long_inc(&sb->s_fsnotify_connectors);
> +}
> +
> +static void fsnotify_put_sb_connectors(struct fsnotify_mark_connector *conn)
> +{
> +	struct super_block *sb;
> +
> +	if (conn->type == FSNOTIFY_OBJ_TYPE_DETACHED)
> +		return;
> +
> +	if (conn->type == FSNOTIFY_OBJ_TYPE_INODE)
> +		sb = fsnotify_conn_inode(conn)->i_sb;
> +	else if (conn->type == FSNOTIFY_OBJ_TYPE_VFSMOUNT)
> +		sb = fsnotify_conn_mount(conn)->mnt.mnt_sb;
> +	else if (conn->type == FSNOTIFY_OBJ_TYPE_SB)
> +		sb = fsnotify_conn_sb(conn);
> +	else
> +		return;
> +
> +	if (atomic_long_dec_and_test(&sb->s_fsnotify_connectors))
> +		wake_up_var(&sb->s_fsnotify_connectors);
>  }
>  
>  static void *fsnotify_detach_connector_from_object(
> @@ -203,6 +240,7 @@ static void *fsnotify_detach_connector_from_object(
>  		fsnotify_conn_sb(conn)->s_fsnotify_mask = 0;
>  	}
>  
> +	fsnotify_put_sb_connectors(conn);
>  	rcu_assign_pointer(*(conn->obj), NULL);
>  	conn->obj = NULL;
>  	conn->type = FSNOTIFY_OBJ_TYPE_DETACHED;
> @@ -504,6 +542,7 @@ static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
>  		inode = fsnotify_conn_inode(conn);
>  		fsnotify_get_inode_ref(inode);
>  	}
> +	fsnotify_get_sb_connectors(conn);
>  
>  	/*
>  	 * cmpxchg() provides the barrier so that readers of *connp can see
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 640574294216..d48d2018dfa4 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1507,8 +1507,8 @@ struct super_block {
>  	/* Number of inodes with nlink == 0 but still referenced */
>  	atomic_long_t s_remove_count;
>  
> -	/* Pending fsnotify inode refs */
> -	atomic_long_t s_fsnotify_inode_refs;
> +	/* Number of inode/mount/sb objects that are being watched */
> +	atomic_long_t s_fsnotify_connectors;
>  
>  	/* Being remounted read-only */
>  	int s_readonly_remount;
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
