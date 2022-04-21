Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0262550A3EB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Apr 2022 17:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390005AbiDUPZp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 11:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390001AbiDUPZn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 11:25:43 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9A2403FA
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Apr 2022 08:22:52 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id ks6so10810225ejb.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Apr 2022 08:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W7sdUe6UGI1MUgXeeKMqz/sxi74dvJZ2t/vNjnFVumI=;
        b=HeBf4TLFuc8OnH6fg36XShaqo8AR2TJDvXu98gOWPK/clgJkG8F9Y8vNtRM+DryVGD
         KgraMVuUBfRYFuczhKtkSF8Bmi7AZgYZZkitnA5Xbkf1zwUq1majlTqyM9XGWu1N2X8s
         kuv9T+D4alRQobJ6iWCoe+mwwm2BFWRm8Rbt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W7sdUe6UGI1MUgXeeKMqz/sxi74dvJZ2t/vNjnFVumI=;
        b=umQhgBaFyyTJ/cccgkdUG/i4qLSRTo58emP9TPN+tQP/gfsOl8y9ef988fUoTgCU8m
         BPJogVeQ1TA368txL1wr+hfX6UBnkE//FVZ4AzjTSJhWSv23dlvO5UaL8ya6Cq7kwkZt
         ljqPT/ptXUtuA2HHePwnLIBm6UwVLe0wpqTTJALjpqjgl9lvj7DRSi9qULfmgj8gaYGe
         SeVy2sXoWZ5olxNAC3Zln3N1s4ev1dzMHSsdZXXCPXSPwm//yr05v0sLtyBxjEUKf5Y6
         3d4V5bHrOix3JpxkyHEMIXHk02RT/J8kNS9sEtppgrsJq1uR+7B98UoZH28GbPjHCOMF
         9lrg==
X-Gm-Message-State: AOAM5312R0yFn6EDtpYJVKzg7jashmIgsOfrAogladZCB/1rI0FJLovV
        yGjoFHZjEZhGystc91FELhheKKqqOTQfx4uNbtJcHg==
X-Google-Smtp-Source: ABdhPJyh0gH/iKbmrOc2ycwaYv8+P3N7urCPet5d7gm8oGowUmUcfv4pZok975xL87IhT1Lv/pPFx9EdmtN5aIWKzJE=
X-Received: by 2002:a17:906:280b:b0:6ce:f3c7:688f with SMTP id
 r11-20020a170906280b00b006cef3c7688fmr68184ejc.468.1650554571384; Thu, 21 Apr
 2022 08:22:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220408061809.12324-1-dharamhans87@gmail.com> <20220408061809.12324-2-dharamhans87@gmail.com>
In-Reply-To: <20220408061809.12324-2-dharamhans87@gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 21 Apr 2022 17:22:40 +0200
Message-ID: <CAJfpegvU+y+WRhWrgWfc_7O5BdVi=N+3RUuVdBFFoyYVr9MDeg@mail.gmail.com>
Subject: Re: [PATCH 1/1] FUSE: Allow parallel direct writes on the same file
To:     Dharmendra Singh <dharamhans87@gmail.com>
Cc:     Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org, Dharmendra Singh <dsingh@ddn.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 8 Apr 2022 at 08:18, Dharmendra Singh <dharamhans87@gmail.com> wrote:
>
> As of now, in Fuse, direct writes on the same file are serialized
> over inode lock i.e we hold inode lock for the whole duration of
> the write request. This serialization works pretty well for the FUSE
> user space implementations which rely on this inode lock for their
> cache/data integrity etc. But it hurts badly such FUSE implementations
> which has their own ways of mainting data/cache integrity and does not
> use this serialization at all.
>
> This patch allows parallel direct writes on the same file with the
> help of a flag called FOPEN_PARALLEL_WRITES. If this flag is set on
> the file (flag is passed from libfuse to fuse kernel as part of file
> open/create), we do not hold inode lock for the whole duration of the
> request, instead acquire it only to protect updates on certain fields
> of the inode. FUSE implementations which rely on this inode lock can
> continue to do so and this is default behaviour.
>
> Signed-off-by: Dharmendra Singh <dsingh@ddn.com>
> ---
>  fs/fuse/file.c            | 38 ++++++++++++++++++++++++++++++++++----
>  include/uapi/linux/fuse.h |  2 ++
>  2 files changed, 36 insertions(+), 4 deletions(-)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 37eebfb90500..d3e8f44c1228 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1465,6 +1465,8 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
>         int err = 0;
>         struct fuse_io_args *ia;
>         unsigned int max_pages;
> +       bool p_write = write &&
> +               (ff->open_flags & FOPEN_PARALLEL_WRITES) ? true : false;
>
>         max_pages = iov_iter_npages(iter, fc->max_pages);
>         ia = fuse_io_alloc(io, max_pages);
> @@ -1472,10 +1474,11 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
>                 return -ENOMEM;
>
>         if (!cuse && fuse_range_is_writeback(inode, idx_from, idx_to)) {
> -               if (!write)
> +               /* Parallel write does not come with inode lock held */
> +               if (!write || p_write)

Probably would be good to add an inode_is_locked() assert in
fuse_sync_writes() to make sure we don't miss cases silently.

>                         inode_lock(inode);
>                 fuse_sync_writes(inode);
> -               if (!write)
> +               if (!write || p_write)
>                         inode_unlock(inode);
>         }
>
> @@ -1568,22 +1571,36 @@ static ssize_t fuse_direct_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  {
>         struct inode *inode = file_inode(iocb->ki_filp);
> +       struct file *file = iocb->ki_filp;
> +       struct fuse_file *ff = file->private_data;
>         struct fuse_io_priv io = FUSE_IO_PRIV_SYNC(iocb);
>         ssize_t res;
> +       bool p_write = ff->open_flags & FOPEN_PARALLEL_WRITES ? true : false;
> +       bool unlock_inode = true;
>
>         /* Don't allow parallel writes to the same file */
>         inode_lock(inode);
>         res = generic_write_checks(iocb, from);

I don't think this needs inode lock.  At least nfs_file_direct_write()
doesn't have it.

What it does have, however is taking the inode lock for shared for the
actual write operation, which is probably something that fuse needs as
well.

Also I worry about size extending writes not holding the inode lock
exclusive.  Would that be a problem in your use case?

>         if (res > 0) {
> +               /* Allow parallel writes on the inode by unlocking it */
> +               if (p_write) {
> +                       inode_unlock(inode);
> +                       unlock_inode = false;
> +               }
>                 if (!is_sync_kiocb(iocb) && iocb->ki_flags & IOCB_DIRECT) {
>                         res = fuse_direct_IO(iocb, from);
>                 } else {
>                         res = fuse_direct_io(&io, from, &iocb->ki_pos,
>                                              FUSE_DIO_WRITE);
> +                       if (p_write) {
> +                               inode_lock(inode);
> +                               unlock_inode = true;
> +                       }
>                         fuse_write_update_attr(inode, iocb->ki_pos, res);

This doesn't need the inode lock either if the actual write wasn't locked.

>                 }
>         }
> -       inode_unlock(inode);
> +       if (unlock_inode)
> +               inode_unlock(inode);
>
>         return res;
>  }
> @@ -2850,10 +2867,16 @@ fuse_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
>         size_t count = iov_iter_count(iter), shortened = 0;
>         loff_t offset = iocb->ki_pos;
>         struct fuse_io_priv *io;
> -
> +       bool p_write = (iov_iter_rw(iter) == WRITE &&
> +                       ff->open_flags & FOPEN_PARALLEL_WRITES);
>         pos = offset;
>         inode = file->f_mapping->host;
> +
> +       if (p_write)
> +               inode_lock(inode);
>         i_size = i_size_read(inode);

Neither this.

> +       if (p_write)
> +               inode_unlock(inode);
>
>         if ((iov_iter_rw(iter) == READ) && (offset >= i_size))
>                 return 0;
> @@ -2924,9 +2947,16 @@ fuse_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
>         kref_put(&io->refcnt, fuse_io_release);
>
>         if (iov_iter_rw(iter) == WRITE) {
> +
> +               if (p_write)
> +                       inode_lock(inode);
> +
>                 fuse_write_update_attr(inode, pos, ret);
>                 if (ret < 0 && offset + count > i_size)
>                         fuse_do_truncate(file);
> +
> +               if (p_write)
> +                       inode_unlock(inode);

Truncation needs the inode lock, though I'm not completely
understanding why this truncation is needed.  But for example here it
is assumed that file size won't change, which means that non-extending
writes should hold inode lock shared and extending writes should hold
inode lock exculsive to meet this assumption.

Thanks,
Miklos
