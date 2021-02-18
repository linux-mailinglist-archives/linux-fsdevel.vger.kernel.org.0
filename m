Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCB6031E5B8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Feb 2021 06:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbhBRFgQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Feb 2021 00:36:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbhBRFdu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Feb 2021 00:33:50 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDE2C061574;
        Wed, 17 Feb 2021 21:33:09 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id jt13so2493731ejb.0;
        Wed, 17 Feb 2021 21:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bfuOJS8lgxWZH7dJ+1WGdaYmsVNg/21G79qyhVcWBw0=;
        b=Ueks7CYqVzJYz+c0+PKlVY/ToJAlyyI2wtwHTUxPVS1ccWyVEFDH+EU8LnSY9KQ90G
         3yx4MQGp3Zfn1Q0+k+rfVQ5tBU+2nQ2XoJGJbJQYi31SQS7Rq4pnrTJof6lNLpNWfUr/
         npULIjoEVo5StEJWeSN4KyY9ZQLSLMQE1Nq9bVK4pGNzeMTn35EkWGpVs4WIJyg6gZfB
         vaGqJHRd9aH6iNh0ZnwXHL6K5I0OOijrOVnyPEdxXo+6+IE0a6iX1mtwadyoT7IO6Md1
         FFvv6OoXr+3SS9XZMoFBLNFamgr2cqwU9lCjBEOwCY7v4W2etziMDwG6ZctE410OPrfo
         KJkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bfuOJS8lgxWZH7dJ+1WGdaYmsVNg/21G79qyhVcWBw0=;
        b=g2lxWAGdyaBa+tjwFQC+ni4QEgNsqfoL6zC28OiVjZwOqhMulAC8vObPB8xZ8WgDcV
         CJYXhILpYd2bgOIHC6j9petwyI1W3Pf+J5YgaxjnuPb24j/azEkyrYEx+Mlp4KNGa1BN
         bpudxZ/IBlMvbrUyl4KMj7LHKMRquOrwUo3tekKPf0LzycIQx4ryZzJ68PDMH2d+lPeu
         Qgi0UyWKS++M6oCbm7OEvV4ank3hgQO5Wd/br41uya/v4FWrQjVUHbLQpFjWLQInpz9N
         pi8Ej4nO4CDEheq1WeIyoJZGGHbjSWBDG3WYbPaKcBwxFDYYX7fRREzJOLiKh55k4y9U
         SiiA==
X-Gm-Message-State: AOAM532UyCpjj2QvcMPoBLAyHFTFMjKhjzWlXQh9kXM3Ti0EClrSro9R
        1kkYIXmDbMRVteiXS/xLu3Ria5V6c4o+IoHLgXg=
X-Google-Smtp-Source: ABdhPJw/Cq1bIa8QFXppx4jN2cleBQ6HDRXCuE1WMvNNkIhUy7kGKdaiPdys7q0uX0vXbfTX3ew8Q2h1LOtKD0bfLF0=
X-Received: by 2002:a17:907:35ca:: with SMTP id ap10mr2288228ejc.451.1613626388452;
 Wed, 17 Feb 2021 21:33:08 -0800 (PST)
MIME-Version: 1.0
References: <CAOQ4uxii=7KUKv1w32VbjkwS+Z1a0ge0gezNzpn_BiY6MFWkpA@mail.gmail.com>
 <20210217172654.22519-1-lhenriques@suse.de>
In-Reply-To: <20210217172654.22519-1-lhenriques@suse.de>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Thu, 18 Feb 2021 00:32:57 -0500
Message-ID: <CAN-5tyHVOphSkp3n+V=1gGQ40WNZGHQURSMMdFBS3jRVGfEXhA@mail.gmail.com>
Subject: Re: [PATCH v3] vfs: fix copy_file_range regression in cross-fs copies
To:     Luis Henriques <lhenriques@suse.de>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Steve French <sfrench@samba.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <dchinner@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Ian Lance Taylor <iant@google.com>,
        Luis Lozano <llozano@chromium.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, CIFS <linux-cifs@vger.kernel.org>,
        samba-technical@lists.samba.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 17, 2021 at 3:30 PM Luis Henriques <lhenriques@suse.de> wrote:
>
> A regression has been reported by Nicolas Boichat, found while using the
> copy_file_range syscall to copy a tracefs file.  Before commit
> 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices") the
> kernel would return -EXDEV to userspace when trying to copy a file across
> different filesystems.  After this commit, the syscall doesn't fail anymore
> and instead returns zero (zero bytes copied), as this file's content is
> generated on-the-fly and thus reports a size of zero.
>
> This patch restores some cross-filesystems copy restrictions that existed
> prior to commit 5dae222a5ff0 ("vfs: allow copy_file_range to copy across
> devices").  It also introduces a flag (COPY_FILE_SPLICE) that can be used
> by filesystems calling directly into the vfs copy_file_range to override
> these restrictions.  Right now, only NFS needs to set this flag.
>
> Fixes: 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices")
> Link: https://lore.kernel.org/linux-fsdevel/20210212044405.4120619-1-drinkcat@chromium.org/
> Link: https://lore.kernel.org/linux-fsdevel/CANMq1KDZuxir2LM5jOTm0xx+BnvW=ZmpsG47CyHFJwnw7zSX6Q@mail.gmail.com/
> Link: https://lore.kernel.org/linux-fsdevel/20210126135012.1.If45b7cdc3ff707bc1efa17f5366057d60603c45f@changeid/
> Reported-by: Nicolas Boichat <drinkcat@chromium.org>
> Signed-off-by: Luis Henriques <lhenriques@suse.de>
> ---
> Ok, I've tried to address all the issues and comments.  Hopefully this v3
> is a bit closer to the final fix.
>
> Changes since v2
> - do all the required checks earlier, in generic_copy_file_checks(),
>   adding new checks for ->remap_file_range
> - new COPY_FILE_SPLICE flag
> - don't remove filesystem's fallback to generic_copy_file_range()
> - updated commit changelog (and subject)
> Changes since v1 (after Amir review)
> - restored do_copy_file_range() helper
> - return -EOPNOTSUPP if fs doesn't implement CFR
> - updated commit description

In my testing, this patch breaks NFS server-to-server copy file.

>
>  fs/nfsd/vfs.c      |  3 ++-
>  fs/read_write.c    | 44 +++++++++++++++++++++++++++++++++++++++++---
>  include/linux/fs.h |  7 +++++++
>  3 files changed, 50 insertions(+), 4 deletions(-)
>
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 04937e51de56..14e55822c223 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -578,7 +578,8 @@ ssize_t nfsd_copy_file_range(struct file *src, u64 src_pos, struct file *dst,
>          * limit like this and pipeline multiple COPY requests.
>          */
>         count = min_t(u64, count, 1 << 22);
> -       return vfs_copy_file_range(src, src_pos, dst, dst_pos, count, 0);
> +       return vfs_copy_file_range(src, src_pos, dst, dst_pos, count,
> +                                  COPY_FILE_SPLICE);
>  }
>
>  __be32 nfsd4_vfs_fallocate(struct svc_rqst *rqstp, struct svc_fh *fhp,
> diff --git a/fs/read_write.c b/fs/read_write.c
> index 75f764b43418..40a16003fb05 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1410,6 +1410,33 @@ static ssize_t do_copy_file_range(struct file *file_in, loff_t pos_in,
>                                        flags);
>  }
>
> +/*
> + * This helper function checks whether copy_file_range can actually be used,
> + * depending on the source and destination filesystems being the same.
> + *
> + * In-kernel callers may set COPY_FILE_SPLICE to override these checks.
> + */
> +static int fops_copy_file_checks(struct file *file_in, struct file *file_out,
> +                                unsigned int flags)
> +{
> +       if (WARN_ON_ONCE(flags & ~COPY_FILE_SPLICE))
> +               return -EINVAL;
> +
> +       if (flags & COPY_FILE_SPLICE)
> +               return 0;
> +       /*
> +        * We got here from userspace, so forbid copies if copy_file_range isn't
> +        * implemented or if we're doing a cross-fs copy.
> +        */
> +       if (!file_out->f_op->copy_file_range)
> +               return -EOPNOTSUPP;
> +       else if (file_out->f_op->copy_file_range !=
> +                file_in->f_op->copy_file_range)
> +               return -EXDEV;
> +
> +       return 0;
> +}
> +
>  /*
>   * Performs necessary checks before doing a file copy
>   *
> @@ -1427,6 +1454,14 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
>         loff_t size_in;
>         int ret;
>
> +       /* Only check f_ops if we're not trying to clone */
> +       if (!file_in->f_op->remap_file_range ||
> +           (file_inode(file_in)->i_sb == file_inode(file_out)->i_sb)) {
> +               ret = fops_copy_file_checks(file_in, file_out, flags);
> +               if (ret)
> +                       return ret;
> +       }
> +
>         ret = generic_file_rw_checks(file_in, file_out);
>         if (ret)
>                 return ret;
> @@ -1474,9 +1509,6 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
>  {
>         ssize_t ret;
>
> -       if (flags != 0)
> -               return -EINVAL;
> -
>         ret = generic_copy_file_checks(file_in, pos_in, file_out, pos_out, &len,
>                                        flags);
>         if (unlikely(ret))
> @@ -1511,6 +1543,9 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
>                         ret = cloned;
>                         goto done;
>                 }
> +               ret = fops_copy_file_checks(file_in, file_out, flags);
> +               if (ret)
> +                       return ret;
>         }
>
>         ret = do_copy_file_range(file_in, pos_in, file_out, pos_out, len,
> @@ -1543,6 +1578,9 @@ SYSCALL_DEFINE6(copy_file_range, int, fd_in, loff_t __user *, off_in,
>         struct fd f_out;
>         ssize_t ret = -EBADF;
>
> +       if (flags != 0)
> +               return -EINVAL;
> +
>         f_in = fdget(fd_in);
>         if (!f_in.file)
>                 goto out2;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index fd47deea7c17..6f604926d955 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1815,6 +1815,13 @@ struct dir_context {
>   */
>  #define REMAP_FILE_ADVISORY            (REMAP_FILE_CAN_SHORTEN)
>
> +/*
> + * This flag control the behavior of copy_file_range from internal (kernel)
> + * users.  It can be used to override the policy of forbidding copies when
> + * source and destination filesystems are different.
> + */
> +#define COPY_FILE_SPLICE               (1 << 0)
> +
>  struct iov_iter;
>
>  struct file_operations {
