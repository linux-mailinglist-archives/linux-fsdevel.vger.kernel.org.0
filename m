Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170BE54202E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 02:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354462AbiFHATC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jun 2022 20:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385507AbiFGWp7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jun 2022 18:45:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 69A0413F413
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jun 2022 12:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654630471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9+sYf66B4lYQqHTknd+qv+uMRNzYbE5y/YbQ6KE2xzc=;
        b=fGQIqA9nqf6Z08piPZBez5+qlml71hBEYKX9rt4tIPe/taGOc6iBXllTZRSYmafKNGctja
        gOZPKPJw6oPHwWx6gbkB/UCO3jIvcyihzYLGdn5SpAKkgI29Tfz4THca0Fhq+FnhLpVxMi
        Tk+N1XXhXGvHZLx5eeUwUGCitRSbUQM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-256-ozahxQXJMqS3hN5j6NST7Q-1; Tue, 07 Jun 2022 15:34:30 -0400
X-MC-Unique: ozahxQXJMqS3hN5j6NST7Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0B183101E165;
        Tue,  7 Jun 2022 19:33:55 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.9.106])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 94F53D28BFA;
        Tue,  7 Jun 2022 19:33:37 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 4B9B8220882; Tue,  7 Jun 2022 15:33:36 -0400 (EDT)
Date:   Tue, 7 Jun 2022 15:33:36 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     miklos@szeredi.hu, stefanha@redhat.com,
        zhangjiachen.jaycee@bytedance.com, linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] fuse: allow skipping abort interface for virtiofs
Message-ID: <Yp+oEPGnisNx+Nzo@redhat.com>
References: <20220607110504.198-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607110504.198-1-xieyongji@bytedance.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 07, 2022 at 07:05:04PM +0800, Xie Yongji wrote:
> The commit 15c8e72e88e0 ("fuse: allow skipping control
> interface and forced unmount") tries to remove the control
> interface for virtio-fs since it does not support aborting
> requests which are being processed. But it doesn't work now.

Aha.., so "no_control" basically has no effect? I was looking at
the code and did not find anybody using "no_control" and I was
wondering who is making use of "no_control" variable.

I mounted virtiofs and noticed a directory named "40" showed up
under /sys/fs/fuse/connections/. That must be belonging to
virtiofs instance, I am assuming.

BTW, if there are multiple fuse connections, how will one figure
out which directory belongs to which instance. Because without knowing
that, one will be shooting in dark while trying to read/write any
of the control files.

So I think a separate patch should be sent which just gets rid of
"no_control" saying nobody uses. it.

> 
> This commit fixes the bug, but only remove the abort interface
> instead since other interfaces should be useful.

Hmm.., so writing to "abort" file is bad as it ultimately does.

fc->connected = 0;

So getting rid of this file till we support aborting the pending
requests properly, makes sense.

I think this probably should be a separate patch which explains
why adding "no_abort_control" is a good idea.

Thanks
Vivek

> 
> Fixes: 15c8e72e88e0 ("fuse: allow skipping control interface and forced unmount")
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>  fs/fuse/control.c   | 4 ++--
>  fs/fuse/fuse_i.h    | 6 +++---
>  fs/fuse/inode.c     | 2 +-
>  fs/fuse/virtio_fs.c | 2 +-
>  4 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/fuse/control.c b/fs/fuse/control.c
> index 7cede9a3bc96..d93d8ea3a090 100644
> --- a/fs/fuse/control.c
> +++ b/fs/fuse/control.c
> @@ -272,8 +272,8 @@ int fuse_ctl_add_conn(struct fuse_conn *fc)
>  
>  	if (!fuse_ctl_add_dentry(parent, fc, "waiting", S_IFREG | 0400, 1,
>  				 NULL, &fuse_ctl_waiting_ops) ||
> -	    !fuse_ctl_add_dentry(parent, fc, "abort", S_IFREG | 0200, 1,
> -				 NULL, &fuse_ctl_abort_ops) ||
> +	    (!fc->no_abort_control && !fuse_ctl_add_dentry(parent, fc, "abort",
> +			S_IFREG | 0200, 1, NULL, &fuse_ctl_abort_ops)) ||
>  	    !fuse_ctl_add_dentry(parent, fc, "max_background", S_IFREG | 0600,
>  				 1, NULL, &fuse_conn_max_background_ops) ||
>  	    !fuse_ctl_add_dentry(parent, fc, "congestion_threshold",
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 488b460e046f..e29a4e2f2b35 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -507,7 +507,7 @@ struct fuse_fs_context {
>  	bool default_permissions:1;
>  	bool allow_other:1;
>  	bool destroy:1;
> -	bool no_control:1;
> +	bool no_abort_control:1;
>  	bool no_force_umount:1;
>  	bool legacy_opts_show:1;
>  	enum fuse_dax_mode dax_mode;
> @@ -766,8 +766,8 @@ struct fuse_conn {
>  	/* Delete dentries that have gone stale */
>  	unsigned int delete_stale:1;
>  
> -	/** Do not create entry in fusectl fs */
> -	unsigned int no_control:1;
> +	/** Do not create abort entry in fusectl fs */
> +	unsigned int no_abort_control:1;
>  
>  	/** Do not allow MNT_FORCE umount */
>  	unsigned int no_force_umount:1;
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 8c0665c5dff8..02a16cd35f42 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1564,7 +1564,7 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
>  	fc->legacy_opts_show = ctx->legacy_opts_show;
>  	fc->max_read = max_t(unsigned int, 4096, ctx->max_read);
>  	fc->destroy = ctx->destroy;
> -	fc->no_control = ctx->no_control;
> +	fc->no_abort_control = ctx->no_abort_control;
>  	fc->no_force_umount = ctx->no_force_umount;
>  
>  	err = -ENOMEM;
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 8db53fa67359..af369bea6dbb 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -1287,7 +1287,7 @@ static inline void virtio_fs_ctx_set_defaults(struct fuse_fs_context *ctx)
>  	ctx->max_read = UINT_MAX;
>  	ctx->blksize = 512;
>  	ctx->destroy = true;
> -	ctx->no_control = true;
> +	ctx->no_abort_control = true;
>  	ctx->no_force_umount = true;
>  }
>  
> -- 
> 2.20.1
> 

