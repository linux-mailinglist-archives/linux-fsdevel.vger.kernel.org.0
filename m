Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32B152D2FA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 14:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238204AbiESMum (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 08:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238136AbiESMud (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 08:50:33 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67259BCE85
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 May 2022 05:50:30 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id tk15so9740511ejc.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 May 2022 05:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vRE/oJtdGWdN444bPnrord4cMpAoUxxz8a+T8mrufqA=;
        b=N4bXORpvmxzJvDMuETcmC63g8ePtxhxyMv7u7BDJcpfMrcfpL8QhERL80OsjtI3tpv
         gIKsZRpervYUxhOP1C1U1qhYkgOikh/xXxjuSrfHTC6Do/8AHAVA8eq5AKfzgqhPJNXS
         tVg67vgiAyzU6JLVN3PmghCkb7gaEtgqYLprU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vRE/oJtdGWdN444bPnrord4cMpAoUxxz8a+T8mrufqA=;
        b=qUOfKfigGuiap9bTj1OiE33x48tuvbN0mJuNhvvRKKY/5/itTM5S/0hOhtuaRyApbY
         vUW7avir1FaKv43wiQMSV5wQ8LXA7PY0V14GjI1S8fVgUTfVNqa2Hhz0S+ygoS0fWhKa
         gx95NtyfpagtGbFyeATNnRdjniar3Gb5kp3FXLk3g5zC13T6mVNPBujdtiCz4XKFu5oj
         ji3UqQrfgo1EocOkCJ+BOjFOsUoP0RuQRC0+EBrVlMkcZMX4LVHO95P6mfN3K8891ig3
         HMuuQVy2WLbUBfSCsAn9RUhPAqBh6WYt84sB+LOjTmetn4FxVQ7aisicgYasL47BkkQ5
         tG2g==
X-Gm-Message-State: AOAM530/QuLOfgqANg38k9Iw4H0aSGnVnT5Ag8aPj1l25/kvDrWbxDTd
        vvmon43/djZTI6Lw0zCqnlqL+zzjsdnHpl42fxc6jw==
X-Google-Smtp-Source: ABdhPJyigk/9qiR/DyzziY2RHs7Q1+TAfNZLV9nE6P5Zl0DrH+Z38HOA5BLPFbtuO4a/ughxjMuvbpiYu8tNyTpAujo=
X-Received: by 2002:a17:907:6e0f:b0:6fe:382a:6657 with SMTP id
 sd15-20020a1709076e0f00b006fe382a6657mr4117416ejc.192.1652964628871; Thu, 19
 May 2022 05:50:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220509105847.8238-1-dharamhans87@gmail.com> <20220509105847.8238-2-dharamhans87@gmail.com>
In-Reply-To: <20220509105847.8238-2-dharamhans87@gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 19 May 2022 14:50:17 +0200
Message-ID: <CAJfpeguEHFTk9u2h8-Le5aQYYPdSdTNY0nUj440YJUR8V3jY-Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] Allow non-extending parallel direct writes
To:     Dharmendra Singh <dharamhans87@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org, Bernd Schubert <bschubert@ddn.com>,
        Dharmendra Singh <dsingh@ddn.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 9 May 2022 at 12:59, Dharmendra Singh <dharamhans87@gmail.com> wrote:
>
> From: Dharmendra Singh <dsingh@ddn.com>
>
> In general, as of now, in FUSE, direct writes on the same file are
> serialized over inode lock i.e we hold inode lock for the full duration
> of the write request. I could not found in fuse code a comment which
> clearly explains why this exclusive lock is taken for direct writes.
> Our guess is some USER space fuse implementations might be relying
> on this lock for seralization and also it protects for the issues
> arising due to file size assumption or write failures.  This patch
> relaxes this exclusive lock in some cases of direct writes.
>
> With these changes, we allows non-extending parallel direct writes
> on the same file with the help of a flag called FOPEN_PARALLEL_WRITES.
> If this flag is set on the file (flag is passed from libfuse to fuse
> kernel as part of file open/create), we do not take exclusive lock instead
> use shared lock so that all non-extending writes can run in parallel.
>
> Best practise would be to enable parallel direct writes of all kinds
> including extending writes as well but we see some issues such as
> when one write completes and other fails, how we should truncate(if
> needed) the file if underlying file system does not support holes
> (For file systems which supports holes, there might be a possibility
> of enabling parallel writes for all cases).
>
> FUSE implementations which rely on this inode lock for serialisation
> can continue to do so and this is default behaviour i.e no parallel
> direct writes.
>
> Signed-off-by: Dharmendra Singh <dsingh@ddn.com>
> ---
>  fs/fuse/file.c            | 45 ++++++++++++++++++++++++++++++++++++---
>  include/uapi/linux/fuse.h |  2 ++
>  2 files changed, 44 insertions(+), 3 deletions(-)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 829094451774..495138a68306 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1541,14 +1541,48 @@ static ssize_t fuse_direct_read_iter(struct kiocb *iocb, struct iov_iter *to)
>         return res;
>  }
>
> +static bool fuse_direct_write_extending_i_size(struct kiocb *iocb,
> +                                              struct iov_iter *iter)
> +{
> +       struct inode *inode = file_inode(iocb->ki_filp);
> +       loff_t i_size;
> +       loff_t offset;
> +       size_t count;
> +
> +       if (iocb->ki_flags & IOCB_APPEND)
> +               return true;
> +
> +       offset = iocb->ki_pos;
> +       count = iov_iter_count(iter);
> +       i_size = i_size_read(inode);
> +
> +       return offset + count <= i_size ? false : true;
> +}

This could be rewritten in much fewer lines:

static bool fuse_is_extending_write(struct kiocb *iocb, struct iov_iter *iter)
{
    struct inode *inode = file_inode(iocb->ki_filp);

    return (iocb->ki_flags & IOCB_APPEND) ||
        iocb->ki_pos + iov_iter_count(iter) > i_size_read(inode);
}


> +
>  static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  {
>         struct inode *inode = file_inode(iocb->ki_filp);
> +       struct file *file = iocb->ki_filp;
> +       struct fuse_file *ff = file->private_data;
>         struct fuse_io_priv io = FUSE_IO_PRIV_SYNC(iocb);
>         ssize_t res;
> +       bool p_write = ff->open_flags & FOPEN_PARALLEL_WRITES ? true : false;

Please just use "bool v = expr" instead of "bool v = expr ? true :
false" as they are equivalent.

> +       bool exclusive_lock = !p_write ||
> +                              fuse_direct_write_extending_i_size(iocb, from) ?
> +                              true : false;

Same.

> +
> +       /*
> +        * Take exclusive lock if
> +        * - parallel writes are disabled.
> +        * - parallel writes are enabled and i_size is being extended
> +        * Take shared lock if
> +        * - parallel writes are enabled but i_size does not extend.
> +        */
> +       if (exclusive_lock)
> +               inode_lock(inode);
> +       else
> +               inode_lock_shared(inode);
>
> -       /* Don't allow parallel writes to the same file */
> -       inode_lock(inode);
>         res = generic_write_checks(iocb, from);
>         if (res > 0) {
>                 if (!is_sync_kiocb(iocb) && iocb->ki_flags & IOCB_DIRECT) {
> @@ -1559,7 +1593,10 @@ static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
>                         fuse_write_update_attr(inode, iocb->ki_pos, res);
>                 }
>         }
> -       inode_unlock(inode);
> +       if (exclusive_lock)
> +               inode_unlock(inode);
> +       else
> +               inode_unlock_shared(inode);
>
>         return res;
>  }
> @@ -2900,7 +2937,9 @@ fuse_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
>         kref_put(&io->refcnt, fuse_io_release);
>
>         if (iov_iter_rw(iter) == WRITE) {
> +

Unnecessary empty line.

>                 fuse_write_update_attr(inode, pos, ret);
> +               /* For extending writes we already hold exclusive lock */
>                 if (ret < 0 && offset + count > i_size)
>                         fuse_do_truncate(file);
>         }
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index d6ccee961891..ee5379d41906 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -301,6 +301,7 @@ struct fuse_file_lock {
>   * FOPEN_CACHE_DIR: allow caching this directory
>   * FOPEN_STREAM: the file is stream-like (no file position at all)
>   * FOPEN_NOFLUSH: don't flush data cache on close (unless FUSE_WRITEBACK_CACHE)
> + * FOPEN_PARALLEL_WRITES: Allow concurrent writes on the same inode
>   */
>  #define FOPEN_DIRECT_IO                (1 << 0)
>  #define FOPEN_KEEP_CACHE       (1 << 1)
> @@ -308,6 +309,7 @@ struct fuse_file_lock {
>  #define FOPEN_CACHE_DIR                (1 << 3)
>  #define FOPEN_STREAM           (1 << 4)
>  #define FOPEN_NOFLUSH          (1 << 5)
> +#define FOPEN_PARALLEL_WRITES  (1 << 6)
>
>  /**
>   * INIT request/reply flags
> --
> 2.17.1
>
