Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCBBA27F1A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Sep 2020 20:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729322AbgI3SyP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Sep 2020 14:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728679AbgI3SyP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Sep 2020 14:54:15 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FB3C061755
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2020 11:54:15 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id w11so1439345vsw.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2020 11:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N2Atg0nwqil3CgBKoVorL+M9yJnmhZns2R4gE+7lVFU=;
        b=JApnnR/2Y5mntj/oYjVcB3SzT3WVFZfmvREkja+Y8cZtnI/8HEkwWIbz1nC9aLrFq+
         1nk63fQYtJKR/5+OGMqXIAcO/4sBF7Z1NLqmQtekSVptYsR2N7HOU4uZ09oQZbFjJwZO
         pzaTSKC1HsnFMn8d5no5ve2hSFD/IkgnJJOns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N2Atg0nwqil3CgBKoVorL+M9yJnmhZns2R4gE+7lVFU=;
        b=XQ4wLYlKzMm331IPzucUPZzcfekMSeqpNGlvoS/FbYm6rM1ueftjH+AYvhkH2shqPp
         JB/WLjm5B3QwMYB5RIQvdzeSfLFiEdebDcWZNOdErAs61CDbffJtxxN36lL+F+6zkX2U
         mA+pudh6WbVjapytZSDsjrUP/ifq/8B215HZismE0TY6zdJdxkWhyklU9yNrN9R91qJl
         mOHLseYc2JMIGt82c8nlyr7SuLSZhxAz8R4h2EkOooMsvUGUjz/F0v2CaoT2LbKybkvF
         PhC9K5Y1HvPTTuOSl85o5CJMT77iUC0K4Nlu8GNKxn6TsoO/fQgHrqkIrMRtUBQtp+q8
         qcrQ==
X-Gm-Message-State: AOAM530D2e96fdBzMeooRq1Gs1KlImGvEJYPIKoILP5Ezwvq9oJgbcaL
        ZvaJSe0fLWksu3NsCUGf0+HVx3g1RUIYRVtRqvBlYg==
X-Google-Smtp-Source: ABdhPJyC0KIkF3hvSvituW4D+X0R46cy8sNgocr2+N+sPBwVzxNfCJ8C3PJwdP2Gd9HIO+AkiAJdFn+kHpPSXcSxco4=
X-Received: by 2002:a67:6952:: with SMTP id e79mr2901081vsc.4.1601492054633;
 Wed, 30 Sep 2020 11:54:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200924131318.2654747-1-balsini@android.com> <20200924131318.2654747-5-balsini@android.com>
In-Reply-To: <20200924131318.2654747-5-balsini@android.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 30 Sep 2020 20:54:03 +0200
Message-ID: <CAJfpegueAXqrfdu5WD+WKKmH9cg0BCQd6Q2bHJNS5XUKuxsmtg@mail.gmail.com>
Subject: Re: [PATCH V9 4/4] fuse: Handle asynchronous read and write in passthrough
To:     Alessio Balsini <balsini@android.com>
Cc:     Akilesh Kailash <akailash@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Antonio SJ Musumeci <trapexit@spawn.link>,
        David Anderson <dvander@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Stefano Duo <stefanoduo@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        kernel-team <kernel-team@android.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 24, 2020 at 3:13 PM Alessio Balsini <balsini@android.com> wrote:
>
> Extend the passthrough feature by handling asynchronous IO both for read
> and write operations.
>
> When an AIO request is received, if the request targets a FUSE file with
> the passthrough functionality enabled, a new identical AIO request is
> created. The new request targets the lower file system file, and gets
> assigned a special FUSE passthrough AIO completion callback.
> When the lower file system AIO request is completed, the FUSE passthrough
> AIO completion callback is executed and propagates the completion signal to
> the FUSE AIO request by triggering its completion callback as well.

This ends up with almost identical code in fuse and overlayfs, right?
Maybe it's worth looking into moving these into common helpers.

Thanks,
Miklos


>
> Signed-off-by: Alessio Balsini <balsini@android.com>
> ---
>  fs/fuse/passthrough.c | 64 +++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 62 insertions(+), 2 deletions(-)
>
> diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
> index f70c0ef6945b..b7d1a5517ffd 100644
> --- a/fs/fuse/passthrough.c
> +++ b/fs/fuse/passthrough.c
> @@ -4,6 +4,11 @@
>
>  #include <linux/uio.h>
>
> +struct fuse_aio_req {
> +       struct kiocb iocb;
> +       struct kiocb *iocb_fuse;
> +};
> +
>  static void fuse_copyattr(struct file *dst_file, struct file *src_file)
>  {
>         struct inode *dst = file_inode(dst_file);
> @@ -39,6 +44,32 @@ fuse_passthrough_override_creds(const struct file *fuse_filp)
>         return override_creds(fc->creator_cred);
>  }
>
> +static void fuse_aio_cleanup_handler(struct fuse_aio_req *aio_req)
> +{
> +       struct kiocb *iocb = &aio_req->iocb;
> +       struct kiocb *iocb_fuse = aio_req->iocb_fuse;
> +
> +       if (iocb->ki_flags & IOCB_WRITE) {
> +               __sb_writers_acquired(file_inode(iocb->ki_filp)->i_sb,
> +                                     SB_FREEZE_WRITE);
> +               file_end_write(iocb->ki_filp);
> +               fuse_copyattr(iocb_fuse->ki_filp, iocb->ki_filp);
> +       }
> +
> +       iocb_fuse->ki_pos = iocb->ki_pos;
> +       kfree(aio_req);
> +}
> +
> +static void fuse_aio_rw_complete(struct kiocb *iocb, long res, long res2)
> +{
> +       struct fuse_aio_req *aio_req =
> +               container_of(iocb, struct fuse_aio_req, iocb);
> +       struct kiocb *iocb_fuse = aio_req->iocb_fuse;
> +
> +       fuse_aio_cleanup_handler(aio_req);
> +       iocb_fuse->ki_complete(iocb_fuse, res, res2);
> +}
> +
>  ssize_t fuse_passthrough_read_iter(struct kiocb *iocb_fuse,
>                                    struct iov_iter *iter)
>  {
> @@ -56,7 +87,18 @@ ssize_t fuse_passthrough_read_iter(struct kiocb *iocb_fuse,
>                 ret = vfs_iter_read(passthrough_filp, iter, &iocb_fuse->ki_pos,
>                                     iocbflags_to_rwf(iocb_fuse->ki_flags));
>         } else {
> -               ret = -EIO;
> +               struct fuse_aio_req *aio_req;
> +
> +               aio_req = kmalloc(sizeof(struct fuse_aio_req), GFP_KERNEL);
> +               if (!aio_req)
> +                       return -ENOMEM;
> +
> +               aio_req->iocb_fuse = iocb_fuse;
> +               kiocb_clone(&aio_req->iocb, iocb_fuse, passthrough_filp);
> +               aio_req->iocb.ki_complete = fuse_aio_rw_complete;
> +               ret = call_read_iter(passthrough_filp, &aio_req->iocb, iter);
> +               if (ret != -EIOCBQUEUED)
> +                       fuse_aio_cleanup_handler(aio_req);
>         }
>         revert_creds(old_cred);
>
> @@ -72,6 +114,7 @@ ssize_t fuse_passthrough_write_iter(struct kiocb *iocb_fuse,
>         struct fuse_file *ff = fuse_filp->private_data;
>         struct inode *fuse_inode = file_inode(fuse_filp);
>         struct file *passthrough_filp = ff->passthrough_filp;
> +       struct inode *passthrough_inode = file_inode(passthrough_filp);
>
>         if (!iov_iter_count(iter))
>                 return 0;
> @@ -87,8 +130,25 @@ ssize_t fuse_passthrough_write_iter(struct kiocb *iocb_fuse,
>                 if (ret > 0)
>                         fuse_copyattr(fuse_filp, passthrough_filp);
>         } else {
> -               ret = -EIO;
> +               struct fuse_aio_req *aio_req;
> +
> +               aio_req = kmalloc(sizeof(struct fuse_aio_req), GFP_KERNEL);
> +               if (!aio_req) {
> +                       ret = -ENOMEM;
> +                       goto out;
> +               }
> +
> +               file_start_write(passthrough_filp);
> +               __sb_writers_release(passthrough_inode->i_sb, SB_FREEZE_WRITE);
> +
> +               aio_req->iocb_fuse = iocb_fuse;
> +               kiocb_clone(&aio_req->iocb, iocb_fuse, passthrough_filp);
> +               aio_req->iocb.ki_complete = fuse_aio_rw_complete;
> +               ret = call_write_iter(passthrough_filp, &aio_req->iocb, iter);
> +               if (ret != -EIOCBQUEUED)
> +                       fuse_aio_cleanup_handler(aio_req);
>         }
> +out:
>         revert_creds(old_cred);
>         inode_unlock(fuse_inode);
>
> --
> 2.28.0.681.g6f77f65b4e-goog
>
