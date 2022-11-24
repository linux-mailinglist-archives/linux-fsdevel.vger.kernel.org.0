Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E1663759F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Nov 2022 10:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbiKXJyp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Nov 2022 04:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiKXJye (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Nov 2022 04:54:34 -0500
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660821255C5;
        Thu, 24 Nov 2022 01:54:33 -0800 (PST)
Received: by mail-vk1-xa35.google.com with SMTP id j24so611699vkk.0;
        Thu, 24 Nov 2022 01:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=znZLdhUtS0rOajRMXtdBuYUM81G8XYp3wNm06MpyRAQ=;
        b=Tu67bb6ygx0vUkZ+2K8StD1SuiJCiBl9tNobBdlL0q7mfLM4TbIC0TaC1hBOJGtWzD
         3xWKSO7JUsHoV9daGNIgoy5fr5ddDO2N+kRlO67T/X7CJRJIT6/8H/8g3qVj4Vjni/PO
         +atqFRy8Nksjqqeh66VShN+A+Wk7DiTKrT4XUcuLzzzLYFvsxsClPP5c3SDmXTZF7OcN
         E2g6wAktS1Nz+0zkloTKTjNaoE4lZ5YTKbikeCItzKpKHHVMA+g8QPxFyNPEeGcTwUy0
         wNVPeKITW+FtTd7XRN3v/tamUsNhZvhp53rgyyMB+ZKVA8JaUqoqqc5K2e+YfUX99Fb/
         yDOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=znZLdhUtS0rOajRMXtdBuYUM81G8XYp3wNm06MpyRAQ=;
        b=cHiFb9QNGiq62HlT4A17Qe+oaiZKwYe4rv4IxP0BuQFTtt5vRAJ2IyYSiAZ298CdLi
         1ublzRgpuv5d8JXSFG4P8nI+L5oh4qlkxe3wVr3xde+sCz0xCjwFF9poERy0mvTAdsa0
         SE15/Jlg1oZU0uRpIGXIRCc2PZMqp34K+4VMvx685G6OUlwuXYUk7Yl88p4I1KgEnxou
         oXFIAERTtQkZnpRSc6o2Tu9lhjLf67YxTLgjv8xfZG97I3HuJS4FlX27YCDuRrCQWJQy
         sAKKb/Tm/lC/MEy7MWMc4CqsyHd9gOJ33Sv4BY/0/sODqYx2nvlu0vlKXv3Rb2X3PpF2
         ozSA==
X-Gm-Message-State: ANoB5pnoA8dtP3e3FUa2hiRL42dYIBUclM1DslBnX2kcAAIwSgObgXGL
        87ryQ2pVPRmNn9TjgRf6Ea82M92M5uqkXIdmuvq3VVl6
X-Google-Smtp-Source: AA0mqf4Mbu+taHe6j0moXui6AgZL8RVU2aQ/HargOrIRs439zbH5DSvCFHypYiTrNX0xB/4l7yrk2ySUhDqal4C/AtM=
X-Received: by 2002:a1f:120b:0:b0:3bc:8497:27fd with SMTP id
 11-20020a1f120b000000b003bc849727fdmr7856792vks.15.1669283672400; Thu, 24 Nov
 2022 01:54:32 -0800 (PST)
MIME-Version: 1.0
References: <20221117205249.1886336-1-amir73il@gmail.com>
In-Reply-To: <20221117205249.1886336-1-amir73il@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 24 Nov 2022 11:54:20 +0200
Message-ID: <CAOQ4uxhzuZ+5+ZARwRLrZhz7tVt19AST982CEpZnUaKGuBokcw@mail.gmail.com>
Subject: Re: [PATCH v2] vfs: fix copy_file_range() averts filesystem freeze protection
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Luis Henriques <lhenriques@suse.com>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
        Luis Henriques <lhenriques@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 17, 2022 at 10:53 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> Commit 868f9f2f8e00 ("vfs: fix copy_file_range() regression in cross-fs
> copies") removed fallback to generic_copy_file_range() for cross-fs
> cases inside vfs_copy_file_range().
>
> To preserve behavior of nfsd and ksmbd server-side-copy, the fallback to
> generic_copy_file_range() was added in nfsd and ksmbd code, but that
> call is missing sb_start_write(), fsnotify hooks and more.
>
> Ideally, nfsd and ksmbd would pass a flag to vfs_copy_file_range() that
> will take care of the fallback, but that code would be subtle and we got
> vfs_copy_file_range() logic wrong too many times already.
>
> Instead, add a flag to explicitly request vfs_copy_file_range() to
> perform only generic_copy_file_range() and let nfsd and ksmbd use this
> flag only in the fallback path.
>
> This choise keeps the logic changes to minimum in the non-nfsd/ksmbd code
> paths to reduce the risk of further regressions.
>
> Fixes: 868f9f2f8e00 ("vfs: fix copy_file_range() regression in cross-fs copies")
> Tested-by: Namjae Jeon <linkinjeon@kernel.org>
> Tested-by: Luis Henriques <lhenriques@suse.de>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>
> Hi Linus,
>
> I've tried Al, but he seems to be AFK, so since you ended up applying
> the regressing commit, I might as well send you the fix as well.
>
> I intentionally chose a fix "for dummies", because I'd like to end this
> copy_file_range() regression streak.
>
> I ran the copy_range fstests group on ext4/xfs/overlay to verify no
> regressions in local fs and nfsv3/nfsv4 to test server-side-copy.
>
> I also patched copy_file_range() locally to test the "dumb" fallback
> code on local fs.
>
> Namje tested ksmbd.
>
> Please apply.
>

Ping.

Happy Thanksgiving!
Amir.

>
> Changes since v1:
> - Added Tested-by's
>
>  fs/ksmbd/vfs.c     |  6 +++---
>  fs/nfsd/vfs.c      |  4 ++--
>  fs/read_write.c    | 19 +++++++++++++++----
>  include/linux/fs.h |  8 ++++++++
>  4 files changed, 28 insertions(+), 9 deletions(-)
>
> diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
> index 8de970d6146f..94b8ed4ef870 100644
> --- a/fs/ksmbd/vfs.c
> +++ b/fs/ksmbd/vfs.c
> @@ -1794,9 +1794,9 @@ int ksmbd_vfs_copy_file_ranges(struct ksmbd_work *work,
>                 ret = vfs_copy_file_range(src_fp->filp, src_off,
>                                           dst_fp->filp, dst_off, len, 0);
>                 if (ret == -EOPNOTSUPP || ret == -EXDEV)
> -                       ret = generic_copy_file_range(src_fp->filp, src_off,
> -                                                     dst_fp->filp, dst_off,
> -                                                     len, 0);
> +                       ret = vfs_copy_file_range(src_fp->filp, src_off,
> +                                                 dst_fp->filp, dst_off, len,
> +                                                 COPY_FILE_SPLICE);
>                 if (ret < 0)
>                         return ret;
>
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index f650afedd67f..5cf11cde51f8 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -596,8 +596,8 @@ ssize_t nfsd_copy_file_range(struct file *src, u64 src_pos, struct file *dst,
>         ret = vfs_copy_file_range(src, src_pos, dst, dst_pos, count, 0);
>
>         if (ret == -EOPNOTSUPP || ret == -EXDEV)
> -               ret = generic_copy_file_range(src, src_pos, dst, dst_pos,
> -                                             count, 0);
> +               ret = vfs_copy_file_range(src, src_pos, dst, dst_pos, count,
> +                                         COPY_FILE_SPLICE);
>         return ret;
>  }
>
> diff --git a/fs/read_write.c b/fs/read_write.c
> index 328ce8cf9a85..24b9668d6377 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1388,6 +1388,8 @@ ssize_t generic_copy_file_range(struct file *file_in, loff_t pos_in,
>                                 struct file *file_out, loff_t pos_out,
>                                 size_t len, unsigned int flags)
>  {
> +       lockdep_assert(sb_write_started(file_inode(file_out)->i_sb));
> +
>         return do_splice_direct(file_in, &pos_in, file_out, &pos_out,
>                                 len > MAX_RW_COUNT ? MAX_RW_COUNT : len, 0);
>  }
> @@ -1424,7 +1426,9 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
>          * and several different sets of file_operations, but they all end up
>          * using the same ->copy_file_range() function pointer.
>          */
> -       if (file_out->f_op->copy_file_range) {
> +       if (flags & COPY_FILE_SPLICE) {
> +               /* cross sb splice is allowed */
> +       } else if (file_out->f_op->copy_file_range) {
>                 if (file_in->f_op->copy_file_range !=
>                     file_out->f_op->copy_file_range)
>                         return -EXDEV;
> @@ -1474,8 +1478,9 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
>                             size_t len, unsigned int flags)
>  {
>         ssize_t ret;
> +       bool splice = flags & COPY_FILE_SPLICE;
>
> -       if (flags != 0)
> +       if (flags & ~COPY_FILE_SPLICE)
>                 return -EINVAL;
>
>         ret = generic_copy_file_checks(file_in, pos_in, file_out, pos_out, &len,
> @@ -1501,14 +1506,14 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
>          * same sb using clone, but for filesystems where both clone and copy
>          * are supported (e.g. nfs,cifs), we only call the copy method.
>          */
> -       if (file_out->f_op->copy_file_range) {
> +       if (!splice && file_out->f_op->copy_file_range) {
>                 ret = file_out->f_op->copy_file_range(file_in, pos_in,
>                                                       file_out, pos_out,
>                                                       len, flags);
>                 goto done;
>         }
>
> -       if (file_in->f_op->remap_file_range &&
> +       if (!splice && file_in->f_op->remap_file_range &&
>             file_inode(file_in)->i_sb == file_inode(file_out)->i_sb) {
>                 ret = file_in->f_op->remap_file_range(file_in, pos_in,
>                                 file_out, pos_out,
> @@ -1528,6 +1533,8 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
>          * consistent story about which filesystems support copy_file_range()
>          * and which filesystems do not, that will allow userspace tools to
>          * make consistent desicions w.r.t using copy_file_range().
> +        *
> +        * We also get here if caller (e.g. nfsd) requested COPY_FILE_SPLICE.
>          */
>         ret = generic_copy_file_range(file_in, pos_in, file_out, pos_out, len,
>                                       flags);
> @@ -1582,6 +1589,10 @@ SYSCALL_DEFINE6(copy_file_range, int, fd_in, loff_t __user *, off_in,
>                 pos_out = f_out.file->f_pos;
>         }
>
> +       ret = -EINVAL;
> +       if (flags != 0)
> +               goto out;
> +
>         ret = vfs_copy_file_range(f_in.file, pos_in, f_out.file, pos_out, len,
>                                   flags);
>         if (ret > 0) {
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index e654435f1651..59ae95ddb679 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2089,6 +2089,14 @@ struct dir_context {
>   */
>  #define REMAP_FILE_ADVISORY            (REMAP_FILE_CAN_SHORTEN)
>
> +/*
> + * These flags control the behavior of vfs_copy_file_range().
> + * They are not available to the user via syscall.
> + *
> + * COPY_FILE_SPLICE: call splice direct instead of fs clone/copy ops
> + */
> +#define COPY_FILE_SPLICE               (1 << 0)
> +
>  struct iov_iter;
>  struct io_uring_cmd;
>
> --
> 2.25.1
>
