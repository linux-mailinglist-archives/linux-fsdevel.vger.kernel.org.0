Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29BAB310A33
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 12:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbhBELYo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 06:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhBELWP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 06:22:15 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C345C06178B
        for <linux-fsdevel@vger.kernel.org>; Fri,  5 Feb 2021 03:21:35 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id p15so7233295wrq.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Feb 2021 03:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+Pu2dRMIRwpPR9qhbMs+pqWNrvm5d2PGl86R4BA7oH0=;
        b=A2iJZnRn7+BDwz6p5b2DECfosa1vn7RxL9AwH+6vu11EKYWH4SJ70UsNmViWGgz6i8
         C19CUniK3vNqvfwuGnDcyKP18tsmjpyERU6awEIUtDMG60HaQCM/tBkISzqgsPaybrPj
         CZrIunYM3MmPFMg383SJR3Bjh6T64f4xjhfWXhb4i3C80IM7CrRYVCEnhh4B+PgEYWBS
         UOJvQD+5f2ndLY/BDlSRe8x8p9sMDrcMCF1gwYHTnFN6geA+mXrJKoC8R8PAJJYOppIL
         MfdaRLf/4YXlfF5iqqjagMHKru824pnGFFxxIm1WuWO1TcZbHiikaAMW7/3juO4B9rOD
         OEDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+Pu2dRMIRwpPR9qhbMs+pqWNrvm5d2PGl86R4BA7oH0=;
        b=iy48Tg0a7ddeFPx5n2L14qNM+7GGw8SBWE2cjZH+3p/DgUOk24EhGXHEYuProLG4Nm
         KO7fjYHQX3Dnd8aeMq7a/kaeCho5vWcbHgOWYvrgMnuy7qltHgb0j0bsjZ5KZgczYERa
         o+ztig1XIVdwKLqP42vXBVfhYrKZVcQHgbm+68jF/88vyIks63Jo3PgbUvP3nC6pGhDn
         Zcso2Nn+65KLZAhAaIefgk1ZmQ9MU261+09DdmgIlhb8ROuPFGIYC+7DOjyG7A3PVV3p
         ypPEiJ4aTfUoOT/6Tp8Tw3tlMcASpXOgViWejcArOMF/hSRNjQPb4GkKoVa8UNyWsA9S
         DhlQ==
X-Gm-Message-State: AOAM533NUGX2ppnF0l6PCJFZJCIOxF//YXxX2SzKB1JoDNnaVCAwBmCL
        2spyLqzyJ41YjbQOdVYYsnntTw==
X-Google-Smtp-Source: ABdhPJwK1MxXHlRk4kJGuhciLBR6WY4TCeUL97PalNZH+SLn5dOFF498ZIQaboYuHhdTM89l3Eh0ew==
X-Received: by 2002:a5d:4010:: with SMTP id n16mr4547232wrp.222.1612524094007;
        Fri, 05 Feb 2021 03:21:34 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:48d2:69e5:c1c:4a83])
        by smtp.gmail.com with ESMTPSA id d3sm12288142wrp.79.2021.02.05.03.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 03:21:33 -0800 (PST)
Date:   Fri, 5 Feb 2021 11:21:32 +0000
From:   Alessio Balsini <balsini@android.com>
To:     Peng Tao <bergwolf@gmail.com>
Cc:     Alessio Balsini <balsini@android.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Akilesh Kailash <akailash@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Antonio SJ Musumeci <trapexit@spawn.link>,
        David Anderson <dvander@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Stefano Duo <duostefano93@gmail.com>,
        Zimuzo Ezeozue <zezeozue@google.com>, wuyan <wu-yan@tcl.com>,
        fuse-devel@lists.sourceforge.net, kernel-team@android.com,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND V12 7/8] fuse: Use daemon creds in passthrough mode
Message-ID: <YB0qPHVORq7bJy6G@google.com>
References: <20210125153057.3623715-1-balsini@android.com>
 <20210125153057.3623715-8-balsini@android.com>
 <CA+a=Yy71JUwWwAPEi0Ngn_kt7Gt3KZwJgx_u=CBefJJTE_mYYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+a=Yy71JUwWwAPEi0Ngn_kt7Gt3KZwJgx_u=CBefJJTE_mYYw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 05, 2021 at 05:23:56PM +0800, Peng Tao wrote:
> On Mon, Jan 25, 2021 at 11:31 PM Alessio Balsini <balsini@android.com> wrote:
> >
> > When using FUSE passthrough, read/write operations are directly
> > forwarded to the lower file system file through VFS, but there is no
> > guarantee that the process that is triggering the request has the right
> > permissions to access the lower file system. This would cause the
> > read/write access to fail.
> >
> > In passthrough file systems, where the FUSE daemon is responsible for
> > the enforcement of the lower file system access policies, often happens
> > that the process dealing with the FUSE file system doesn't have access
> > to the lower file system.
> > Being the FUSE daemon in charge of implementing the FUSE file
> > operations, that in the case of read/write operations usually simply
> > results in the copy of memory buffers from/to the lower file system
> > respectively, these operations are executed with the FUSE daemon
> > privileges.
> >
> > This patch adds a reference to the FUSE daemon credentials, referenced
> > at FUSE_DEV_IOC_PASSTHROUGH_OPEN ioctl() time so that they can be used
> > to temporarily raise the user credentials when accessing lower file
> > system files in passthrough.
> > The process accessing the FUSE file with passthrough enabled temporarily
> > receives the privileges of the FUSE daemon while performing read/write
> > operations. Similar behavior is implemented in overlayfs.
> > These privileges will be reverted as soon as the IO operation completes.
> > This feature does not provide any higher security privileges to those
> > processes accessing the FUSE file system with passthrough enabled. This
> > is because it is still the FUSE daemon responsible for enabling or not
> > the passthrough feature at file open time, and should enable the feature
> > only after appropriate access policy checks.
> >
> > Signed-off-by: Alessio Balsini <balsini@android.com>
> > ---
> >  fs/fuse/fuse_i.h      |  5 ++++-
> >  fs/fuse/passthrough.c | 11 +++++++++++
> >  2 files changed, 15 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > index c4730d893324..815af1845b16 100644
> > --- a/fs/fuse/fuse_i.h
> > +++ b/fs/fuse/fuse_i.h
> > @@ -182,10 +182,13 @@ struct fuse_release_args;
> >
> >  /**
> >   * Reference to lower filesystem file for read/write operations handled in
> > - * passthrough mode
> > + * passthrough mode.
> > + * This struct also tracks the credentials to be used for handling read/write
> > + * operations.
> >   */
> >  struct fuse_passthrough {
> >         struct file *filp;
> > +       struct cred *cred;
> >  };
> >
> >  /** FUSE specific file data */
> > diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
> > index c7fa1eeb7639..24866c5fe7e2 100644
> > --- a/fs/fuse/passthrough.c
> > +++ b/fs/fuse/passthrough.c
> > @@ -52,6 +52,7 @@ ssize_t fuse_passthrough_read_iter(struct kiocb *iocb_fuse,
> >                                    struct iov_iter *iter)
> >  {
> >         ssize_t ret;
> > +       const struct cred *old_cred;
> >         struct file *fuse_filp = iocb_fuse->ki_filp;
> >         struct fuse_file *ff = fuse_filp->private_data;
> >         struct file *passthrough_filp = ff->passthrough.filp;
> > @@ -59,6 +60,7 @@ ssize_t fuse_passthrough_read_iter(struct kiocb *iocb_fuse,
> >         if (!iov_iter_count(iter))
> >                 return 0;
> >
> > +       old_cred = override_creds(ff->passthrough.cred);
> >         if (is_sync_kiocb(iocb_fuse)) {
> >                 ret = vfs_iter_read(passthrough_filp, iter, &iocb_fuse->ki_pos,
> >                                     iocb_to_rw_flags(iocb_fuse->ki_flags,
> > @@ -77,6 +79,7 @@ ssize_t fuse_passthrough_read_iter(struct kiocb *iocb_fuse,
> >                 if (ret != -EIOCBQUEUED)
> >                         fuse_aio_cleanup_handler(aio_req);
> >         }
> > +       revert_creds(old_cred);
> cred should be reverted when kmalloc() fails above.
> 
> Cheers,
> Tao
> -- 
> Into Sth. Rich & Strange

Thanks Tao, definitely!

Please find the fixup at the bottom of this email.
I keep the WIP V13 here:

  https://github.com/balsini/linux/tree/fuse-passthrough-v13-v5.11-rc5

Thanks,
Alessio

---8<---
From 63797a2cc6b3946bce59989adcb8f39f70f27643 Mon Sep 17 00:00:00 2001
From: Alessio Balsini <balsini@android.com>
Date: Fri, 5 Feb 2021 10:58:49 +0000
Subject: [PATCH] fuse: Fix crediantials leak in passthrough read_iter

If the system doesn't have enough memory when fuse_passthrough_read_iter
is requested in asynchronous IO, an error is directly returned without
restoring the caller's credentials.
Fix by always ensuring credentials are restored.

Fixes: 20210125153057.3623715-8-balsini@android.com ("fuse: Use daemon creds in passthrough mode")
Signed-off-by: Alessio Balsini <balsini@android.com>
---
 fs/fuse/passthrough.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
index 284979f87747..1df94c1d8a00 100644
--- a/fs/fuse/passthrough.c
+++ b/fs/fuse/passthrough.c
@@ -69,8 +69,10 @@ ssize_t fuse_passthrough_read_iter(struct kiocb *iocb_fuse,
                struct fuse_aio_req *aio_req;

                aio_req = kmalloc(sizeof(struct fuse_aio_req), GFP_KERNEL);
-               if (!aio_req)
-                       return -ENOMEM;
+               if (!aio_req) {
+                       ret = -ENOMEM;
+                       goto out;
+               }

                aio_req->iocb_fuse = iocb_fuse;
                kiocb_clone(&aio_req->iocb, iocb_fuse, passthrough_filp);
@@ -79,6 +81,7 @@ ssize_t fuse_passthrough_read_iter(struct kiocb *iocb_fuse,
                if (ret != -EIOCBQUEUED)
                        fuse_aio_cleanup_handler(aio_req);
        }
+out:
        revert_creds(old_cred);

        return ret;
--
2.30.0.365.g02bc693789-goog
