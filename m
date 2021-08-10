Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC3B3E85AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 23:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234902AbhHJVu2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 17:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234531AbhHJVu2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 17:50:28 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944A8C061765
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Aug 2021 14:50:05 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id g12-20020a17090a7d0cb0290178f80de3d8so1159128pjl.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Aug 2021 14:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Oqlru8HAmPm8bzLsXC721r+X6wLVc2gPZI+W2Qp39mE=;
        b=BHfMe31wNIDcP6wFnz5YRkxx/DaCBhHYF3JnChzLIpLuFTBaUf1gYOvaiLxja0spGp
         8wVYpzTJN7TI1mHnnLCv+OnC753sErzSIOuNm8w/DVWnpVV5sW+bViTcODIgKk5I9Uc3
         tiBM6H1fKAR8ZPmFbtI1YRPeLlkQZQXhQ6/OSyZXqqb7Pe06+giDYJQzSIMvP94XPTgO
         AkVnFwnxlStLiAKLGbCx22OZPqWcrp/uzDuzScjB4ALJnAjJfphmcvyDJHIzf1KBP8Hw
         peb/K+vJXmVkigiDdpPZ3HFIMwPBqeqY9kPtZi08NKyyaYSKfqy3aCa8SQdBHglIkZtP
         hA6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Oqlru8HAmPm8bzLsXC721r+X6wLVc2gPZI+W2Qp39mE=;
        b=UINC+hzXyDoy2MLHDesuw9qXteoe57/1M7qw4r6tp+7qrLBZuo8zTeWVnLuv9flu51
         tTVsx4bsQiF4zr8js+rljKs/ak+FeIsGKSV0GmnIiv0RDH6Jcb/mIvsJJNBoRLPFMeCS
         1V0uOwGqYFpx31Tckt8j30dKMBlq5L5wzcGALLuMrxYk5TPXDCJW1mG20LbYEXJC3oLC
         NeYNwu3VQJreqMl9rCQ0x2dSiEVHlE77SZKcm+8AEYO03cNJ7aE4N9/kU6mdQiPBMCGB
         4skKVTHWFGmmRgNMHVT6GG4g7uTylyOx5L7dB8QEPbtMjeW49W5GRBg2CU/hLa4U0Xq2
         9Xiw==
X-Gm-Message-State: AOAM530RaoGMYu2jCCn34IKQTSUGFDu5Jxq6/J4fWV2lECz+eplrnUfl
        FaI/bgJfn7+8ZCXRlry8NAOjeg==
X-Google-Smtp-Source: ABdhPJxDOFYnLAYfXVfGzpskX5xUqTb/xxMWcRigQNxA3joqvN+kRGhb9PeqA9/PGzHmqK8PYBBH+g==
X-Received: by 2002:aa7:9828:0:b029:3bd:dc3d:de5f with SMTP id q8-20020aa798280000b02903bddc3dde5fmr31024075pfl.47.1628632204896;
        Tue, 10 Aug 2021 14:50:04 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:46f7:f8ea:5192:59e7])
        by smtp.gmail.com with ESMTPSA id ns18sm22165403pjb.31.2021.08.10.14.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 14:50:04 -0700 (PDT)
Date:   Wed, 11 Aug 2021 07:49:51 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] fsnotify: count all objects with attached
 connectors
Message-ID: <YRL0fwN4kCvBD9fw@google.com>
References: <20210810151220.285179-1-amir73il@gmail.com>
 <20210810151220.285179-4-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210810151220.285179-4-amir73il@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 10, 2021 at 06:12:19PM +0300, Amir Goldstein wrote:
> Rename s_fsnotify_inode_refs to s_fsnotify_connectors and count all
> objects with attached connectors, not only inodes with attached
> connectors.
> 
> This will be used to optimize fsnotify() calls on sb without any
> type of marks.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

LGTM.

Reviewed-by: Matthew Bobrowski <repnop@google.com>

> ---
>  fs/notify/fsnotify.c |  6 +++---
>  fs/notify/fsnotify.h | 15 +++++++++++++++
>  fs/notify/mark.c     | 24 +++++++++++++++++++++---
>  include/linux/fs.h   |  4 ++--
>  4 files changed, 41 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 30d422b8c0fc..963e6ce75b96 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -87,15 +87,15 @@ static void fsnotify_unmount_inodes(struct super_block *sb)
>  
>  	if (iput_inode)
>  		iput(iput_inode);
> -	/* Wait for outstanding inode references from connectors */
> -	wait_var_event(&sb->s_fsnotify_inode_refs,
> -		       !atomic_long_read(&sb->s_fsnotify_inode_refs));
>  }
>  
>  void fsnotify_sb_delete(struct super_block *sb)
>  {
>  	fsnotify_unmount_inodes(sb);
>  	fsnotify_clear_marks_by_sb(sb);
> +	/* Wait for outstanding object references from connectors */
> +	wait_var_event(&sb->s_fsnotify_connectors,
> +		       !atomic_long_read(&sb->s_fsnotify_connectors));
>  }
>  
>  /*
> diff --git a/fs/notify/fsnotify.h b/fs/notify/fsnotify.h
> index ff2063ec6b0f..87d8a50ee803 100644
> --- a/fs/notify/fsnotify.h
> +++ b/fs/notify/fsnotify.h
> @@ -27,6 +27,21 @@ static inline struct super_block *fsnotify_conn_sb(
>  	return container_of(conn->obj, struct super_block, s_fsnotify_marks);
>  }
>  
> +static inline struct super_block *fsnotify_connector_sb(
> +				struct fsnotify_mark_connector *conn)
> +{
> +	switch (conn->type) {
> +	case FSNOTIFY_OBJ_TYPE_INODE:
> +		return fsnotify_conn_inode(conn)->i_sb;
> +	case FSNOTIFY_OBJ_TYPE_VFSMOUNT:
> +		return fsnotify_conn_mount(conn)->mnt.mnt_sb;
> +	case FSNOTIFY_OBJ_TYPE_SB:
> +		return fsnotify_conn_sb(conn);
> +	default:
> +		return NULL;
> +	}
> +}
> +
>  /* destroy all events sitting in this groups notification queue */
>  extern void fsnotify_flush_notify(struct fsnotify_group *group);
>  
> diff --git a/fs/notify/mark.c b/fs/notify/mark.c
> index 2d8c46e1167d..95006d1d29ab 100644
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
> @@ -180,8 +180,24 @@ static void fsnotify_put_inode_ref(struct inode *inode)
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
> +	struct super_block *sb = fsnotify_connector_sb(conn);
> +
> +	if (sb)
> +		atomic_long_inc(&sb->s_fsnotify_connectors);
> +}
> +
> +static void fsnotify_put_sb_connectors(struct fsnotify_mark_connector *conn)
> +{
> +	struct super_block *sb = fsnotify_connector_sb(conn);
> +
> +	if (sb && atomic_long_dec_and_test(&sb->s_fsnotify_connectors))
> +		wake_up_var(&sb->s_fsnotify_connectors);
>  }
>  
>  static void *fsnotify_detach_connector_from_object(
> @@ -203,6 +219,7 @@ static void *fsnotify_detach_connector_from_object(
>  		fsnotify_conn_sb(conn)->s_fsnotify_mask = 0;
>  	}
>  
> +	fsnotify_put_sb_connectors(conn);
>  	rcu_assign_pointer(*(conn->obj), NULL);
>  	conn->obj = NULL;
>  	conn->type = FSNOTIFY_OBJ_TYPE_DETACHED;
> @@ -504,6 +521,7 @@ static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
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
> 2.32.0
> 
/M
