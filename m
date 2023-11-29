Return-Path: <linux-fsdevel+bounces-4209-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF827FDD40
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 17:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FFCF1C209AE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 16:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083D53B29D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 16:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="VMnS7o2o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236ADA3
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 07:04:23 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9fa2714e828so931636366b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 07:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1701270261; x=1701875061; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SqxRUrjATm/2cKe0NnAPPHgWM1sI4L0XTC/VWDVT5wE=;
        b=VMnS7o2o0bi+BFxvUWYq04cg8M0w8dO5C0Xv8jI5N3yd51HlsFZBZPkrcQ8vKJ1aee
         +h56Czq0wDMG1aQKwjM1PDMNYk0iiDbZcasbfJ8izvP7ZAylNHrAHqbVz9bvUQd3fyUM
         wbiOvapMRZT12pxg9wdXt7b4z+mPa3FJrYhFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701270261; x=1701875061;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SqxRUrjATm/2cKe0NnAPPHgWM1sI4L0XTC/VWDVT5wE=;
        b=Q1pgxyraWF8XR2gndSdqxSB93ZHe3wuMrerHCtmy/X+xBXggY93FDnbnhroSIVMh5x
         mspDgPQsNvbyoAqKXDfIRIQunAbb116wgT/xStzrYWIVz8E+UdiPD+L9qEzl46PmAKCn
         mUkcr9IYMY4qYikfZXU5KrucyHE4UzZ4/31igALnkj8y+Wefl1j2niW4nF7VfdX9bsCf
         lcnTog1jAdRxEpgWgtaNTAk7V0wmganAGY85PcI7txM6yITiu+ty/Pue5TMQqYPtJtj8
         AoqRVKiv+zc1sCEzYgQLXorxgLRoT6fqjOKHHY9T4aasppYZtZ+sMJ49hirbHekf0vYr
         KEXg==
X-Gm-Message-State: AOJu0Yz83RaV8KfI1LWSLB2+G383ZYOxU7eTV1HGpuYJYa0rwfsx1hBx
	e2EnbwQA1PG2vh0ymmAxXe1j6jPITPPHR00V7NB3XQ==
X-Google-Smtp-Source: AGHT+IEJzw9iKtbwJLFNY/AnNxVJyCUpW2IXswREdVfrWQAR70RQmq4VpxpLJ8ugK5zzKPs1tXaM3bLhlOrrleupTLY=
X-Received: by 2002:a17:907:c18:b0:a02:9c3d:6de7 with SMTP id
 ga24-20020a1709070c1800b00a029c3d6de7mr16506251ejc.13.1701270261625; Wed, 29
 Nov 2023 07:04:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129094317.453025-1-winters.zc@antgroup.com> <20231129094317.453025-3-winters.zc@antgroup.com>
In-Reply-To: <20231129094317.453025-3-winters.zc@antgroup.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 29 Nov 2023 16:04:10 +0100
Message-ID: <CAJfpegtbhTRVDbRXvMf6jNnCU23HdYFWqKMSzQNcKN5QKrw9AA@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND 2/2] fuse: Use the high bit of request ID for
 indicating resend requests
To: Zhao Chen <winters.zc@antgroup.com>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 Nov 2023 at 10:43, Zhao Chen <winters.zc@antgroup.com> wrote:
>
> Some FUSE daemons want to know if the received request is a resend
> request, after writing to the sysfs resend API. The high bit of the fuse
> request id is utilized for indicating this, enabling the receiver to
> perform appropriate handling.
>
> An init flag is added to indicate this feature.
>
> Signed-off-by: Zhao Chen <winters.zc@antgroup.com>
> ---
>  fs/fuse/dev.c             | 11 +++++++----
>  fs/fuse/inode.c           |  3 ++-
>  include/uapi/linux/fuse.h | 11 +++++++++++
>  3 files changed, 20 insertions(+), 5 deletions(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index c91cb2bd511b..8a90a41b9a17 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -28,6 +28,7 @@ MODULE_ALIAS("devname:fuse");
>  /* Ordinary requests have even IDs, while interrupts IDs are odd */
>  #define FUSE_INT_REQ_BIT (1ULL << 0)
>  #define FUSE_REQ_ID_STEP (1ULL << 1)
> +#define FUSE_REQ_ID_MASK (~(FUSE_INT_REQ_BIT | FUSE_REQ_ID_RESEND_BIT))
>
>  static struct kmem_cache *fuse_req_cachep;
>
> @@ -194,14 +195,14 @@ EXPORT_SYMBOL_GPL(fuse_len_args);
>
>  u64 fuse_get_unique(struct fuse_iqueue *fiq)
>  {
> -       fiq->reqctr += FUSE_REQ_ID_STEP;
> +       fiq->reqctr = (fiq->reqctr + FUSE_REQ_ID_STEP) & FUSE_REQ_ID_MASK;
>         return fiq->reqctr;
>  }
>  EXPORT_SYMBOL_GPL(fuse_get_unique);
>
>  static unsigned int fuse_req_hash(u64 unique)
>  {
> -       return hash_long(unique & ~FUSE_INT_REQ_BIT, FUSE_PQ_HASH_BITS);
> +       return hash_long(unique & FUSE_REQ_ID_MASK, FUSE_PQ_HASH_BITS);

Possible simplification if FUSE_REQ_ID_RESEND_BIT is not used as a
separate flag, but as a part of the unique request ID.  That way
there's no need to mask it out.

>  }
>
>  /*
> @@ -1813,7 +1814,7 @@ static struct fuse_req *request_find(struct fuse_pqueue *fpq, u64 unique)
>         struct fuse_req *req;
>
>         list_for_each_entry(req, &fpq->processing[hash], list) {
> -               if (req->in.h.unique == unique)
> +               if ((req->in.h.unique & FUSE_REQ_ID_MASK) == unique)

Same here.


>                         return req;
>         }
>         return NULL;
> @@ -1884,7 +1885,7 @@ static ssize_t fuse_dev_do_write(struct fuse_dev *fud,
>         spin_lock(&fpq->lock);
>         req = NULL;
>         if (fpq->connected)
> -               req = request_find(fpq, oh.unique & ~FUSE_INT_REQ_BIT);
> +               req = request_find(fpq, oh.unique & FUSE_REQ_ID_MASK);
>
>         err = -ENOENT;
>         if (!req) {
> @@ -2274,6 +2275,8 @@ void fuse_resend_pqueue(struct fuse_conn *fc)
>
>         list_for_each_entry_safe(req, next, &to_queue, list) {
>                 __set_bit(FR_PENDING, &req->flags);
> +               /* mark the request as resend request */
> +               req->in.h.unique |= FUSE_REQ_ID_RESEND_BIT;
>         }
>
>         spin_lock(&fiq->lock);
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 2a6d44f91729..e774865fbfa3 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1330,7 +1330,8 @@ void fuse_send_init(struct fuse_mount *fm)
>                 FUSE_NO_OPENDIR_SUPPORT | FUSE_EXPLICIT_INVAL_DATA |
>                 FUSE_HANDLE_KILLPRIV_V2 | FUSE_SETXATTR_EXT | FUSE_INIT_EXT |
>                 FUSE_SECURITY_CTX | FUSE_CREATE_SUPP_GROUP |
> -               FUSE_HAS_EXPIRE_ONLY | FUSE_DIRECT_IO_ALLOW_MMAP;
> +               FUSE_HAS_EXPIRE_ONLY | FUSE_DIRECT_IO_ALLOW_MMAP |
> +               FUSE_UID_HAS_RESEND_BIT;
>  #ifdef CONFIG_FUSE_DAX
>         if (fm->fc->dax)
>                 flags |= FUSE_MAP_ALIGNMENT;
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index e7418d15fe39..ecfb7cbcfe30 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -410,6 +410,8 @@ struct fuse_file_lock {
>   *                     symlink and mknod (single group that matches parent)
>   * FUSE_HAS_EXPIRE_ONLY: kernel supports expiry-only entry invalidation
>   * FUSE_DIRECT_IO_ALLOW_MMAP: allow shared mmap in FOPEN_DIRECT_IO mode.
> + * FUSE_UID_HAS_RESEND_BIT: use high bit of request ID for indicating resend
> + *                         requests
>   */
>  #define FUSE_ASYNC_READ                (1 << 0)
>  #define FUSE_POSIX_LOCKS       (1 << 1)
> @@ -449,6 +451,7 @@ struct fuse_file_lock {
>  #define FUSE_CREATE_SUPP_GROUP (1ULL << 34)
>  #define FUSE_HAS_EXPIRE_ONLY   (1ULL << 35)
>  #define FUSE_DIRECT_IO_ALLOW_MMAP (1ULL << 36)
> +#define FUSE_UID_HAS_RESEND_BIT (1ULL << 37)

"FUSE_HAS_RESEND" should be sufficiently descriptive.

>
>  /* Obsolete alias for FUSE_DIRECT_IO_ALLOW_MMAP */
>  #define FUSE_DIRECT_IO_RELAX   FUSE_DIRECT_IO_ALLOW_MMAP
> @@ -960,6 +963,14 @@ struct fuse_fallocate_in {
>         uint32_t        padding;
>  };
>
> +/**
> + * FUSE request unique ID flag
> + *
> + * Indicates whether this is a resend request. The receiver should handle this
> + * request accordingly.
> + */
> +#define FUSE_REQ_ID_RESEND_BIT (1ULL << 63)

How about "FUSE_UNIQUE_RESEND"?

Thanks,
Miklos

