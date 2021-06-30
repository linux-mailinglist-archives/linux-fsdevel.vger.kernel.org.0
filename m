Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09CD83B8591
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jun 2021 16:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235540AbhF3O7U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Jun 2021 10:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235878AbhF3O7P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Jun 2021 10:59:15 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B249C061756;
        Wed, 30 Jun 2021 07:56:46 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id a11so3137003ilf.2;
        Wed, 30 Jun 2021 07:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dv9jkp86fXSKSx20JWjmDX6xNXAVdw7od/sU3lZFAoQ=;
        b=MwqeGBksBPmAtuBHgbyxehDzNHzhkKWDlxgWyFRQgvKaIwCPh0D9X3wEosr64Cn+A9
         eQ1lBz4iNJsvxnTe0m99+EQgZzg2Y66fm4r4LH3zxrY7AwsuybAvQy38n97VNA6/kje7
         G47xo3CgO9TD27O8H1JywsluohxGzdNzaXeCjoXfcn5AlB8/Ys6Wz9BpTRGAUMAU8Qh9
         NmyMsiEA/SCVEzGDLLCXx1oLN6Zw7RU4ATwQa1ejFO7iK9fYQlFsEDUNfwiyi7Ry/qWl
         9BFDDfrxIqWm6MVHmxQ478xJ2gcx5ExIy0LNOBLVse7If/SsEi1yOPUn7MOzEY0GDWqu
         QudQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dv9jkp86fXSKSx20JWjmDX6xNXAVdw7od/sU3lZFAoQ=;
        b=NdSIUwgeS3bI7JphwY3hihtyU86FWivhnBj27CUDWCpLvfXQR8Qs53E8n3aZmJJScG
         6LncHh2H9PNOU4Y2lDYbT0TotWzftMLWL21myYOlG8d/7D5eNlubBny4D7QR68j497or
         6tBI6Q6W9HAr0npvLw2x7cNIXko+dfV2cCYKQK8mKYKWvLo2BNReSAgBJuoVdU5RsM4K
         liYzMRGLUNDboJKgauqL/TxuxngZsfsfF0UbOOV8aMHjlrg1b2yo0Z/Fcuhm3Ajy2YDG
         JaJif7xx3Dg9reqojAVwjYA5dqkd0FlFBT+EfFzJiekeQuRy8HaTHDQPJugyBUpzEOCS
         yOOA==
X-Gm-Message-State: AOAM530fyvauRG8etfn14s0ZksfeOp17I+L1142gR9b13WVi6DvGEKf2
        1RdiFFB/ENaM+GUuAf2ei0eW7fplqr6anM28kIA=
X-Google-Smtp-Source: ABdhPJxHw759duf+mgVKmKqMs+WTChWLRbcezyYVpHjs8TbhcoOuHx8nkwFu5WFeXGPC4FOsWpn34XvUmiaSpte24TA=
X-Received: by 2002:a92:874b:: with SMTP id d11mr25247009ilm.137.1625065005507;
 Wed, 30 Jun 2021 07:56:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210630134449.16851-1-lhenriques@suse.de>
In-Reply-To: <20210630134449.16851-1-lhenriques@suse.de>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 30 Jun 2021 17:56:34 +0300
Message-ID: <CAOQ4uxi6pMEehkXWAk=vzx3mZAfcxwVPvFs9W7LM2CfgBkZWxQ@mail.gmail.com>
Subject: Re: [PATCH v10] vfs: fix copy_file_range regression in cross-fs copies
To:     Luis Henriques <lhenriques@suse.de>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Olga Kornievskaia <aglo@umich.edu>,
        Petr Vorel <pvorel@suse.cz>,
        kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 30, 2021 at 4:44 PM Luis Henriques <lhenriques@suse.de> wrote:
>
> A regression has been reported by Nicolas Boichat, found while using the
> copy_file_range syscall to copy a tracefs file.  Before commit
> 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices") the
> kernel would return -EXDEV to userspace when trying to copy a file across
> different filesystems.  After this commit, the syscall doesn't fail anymore
> and instead returns zero (zero bytes copied), as this file's content is
> generated on-the-fly and thus reports a size of zero.
>
> This patch restores some cross-filesystem copy restrictions that existed
> prior to commit 5dae222a5ff0 ("vfs: allow copy_file_range to copy across
> devices").  Filesystems are still allowed to fall-back to the VFS
> generic_copy_file_range() implementation, but that has now to be done
> explicitly.
>
> nfsd is also modified to fall-back into generic_copy_file_range() in case
> vfs_copy_file_range() fails with -EOPNOTSUPP or -EXDEV.
>
> Fixes: 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices")
> Link: https://lore.kernel.org/linux-fsdevel/20210212044405.4120619-1-drinkcat@chromium.org/
> Link: https://lore.kernel.org/linux-fsdevel/CANMq1KDZuxir2LM5jOTm0xx+BnvW=ZmpsG47CyHFJwnw7zSX6Q@mail.gmail.com/
> Link: https://lore.kernel.org/linux-fsdevel/20210126135012.1.If45b7cdc3ff707bc1efa17f5366057d60603c45f@changeid/
> Reported-by: Nicolas Boichat <drinkcat@chromium.org>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Luis Henriques <lhenriques@suse.de>
> ---
> Changes since v9
> - the early return from the syscall when len is zero now checks if the
>   filesystem is implemented, returning -EOPNOTSUPP if it is not and 0
>   otherwise.  Issue reported by test robot.

What issue was reported?

>   (obviously, dropped Amir's Reviewed-by and Olga's Tested-by tags)
> Changes since v8
> - Simply added Amir's Reviewed-by and Olga's Tested-by
> Changes since v7
> - set 'ret' to '-EOPNOTSUPP' before the clone 'if' statement so that the
>   error returned is always related to the 'copy' operation
> Changes since v6
> - restored i_sb checks for the clone operation
> Changes since v5
> - check if ->copy_file_range is NULL before calling it
> Changes since v4
> - nfsd falls-back to generic_copy_file_range() only *if* it gets -EOPNOTSUPP
>   or -EXDEV.
> Changes since v3
> - dropped the COPY_FILE_SPLICE flag
> - kept the f_op's checks early in generic_copy_file_checks, implementing
>   Amir's suggestions
> - modified nfsd to use generic_copy_file_range()
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
>
>  fs/nfsd/vfs.c   |  8 +++++++-
>  fs/read_write.c | 51 ++++++++++++++++++++++++-------------------------
>  2 files changed, 32 insertions(+), 27 deletions(-)
>
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 15adf1f6ab21..f54a88b3b4a2 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -569,6 +569,7 @@ __be32 nfsd4_clone_file_range(struct nfsd_file *nf_src, u64 src_pos,
>  ssize_t nfsd_copy_file_range(struct file *src, u64 src_pos, struct file *dst,
>                              u64 dst_pos, u64 count)
>  {
> +       ssize_t ret;
>
>         /*
>          * Limit copy to 4MB to prevent indefinitely blocking an nfsd
> @@ -579,7 +580,12 @@ ssize_t nfsd_copy_file_range(struct file *src, u64 src_pos, struct file *dst,
>          * limit like this and pipeline multiple COPY requests.
>          */
>         count = min_t(u64, count, 1 << 22);
> -       return vfs_copy_file_range(src, src_pos, dst, dst_pos, count, 0);
> +       ret = vfs_copy_file_range(src, src_pos, dst, dst_pos, count, 0);
> +
> +       if (ret == -EOPNOTSUPP || ret == -EXDEV)
> +               ret = generic_copy_file_range(src, src_pos, dst, dst_pos,
> +                                             count, 0);
> +       return ret;
>  }
>
>  __be32 nfsd4_vfs_fallocate(struct svc_rqst *rqstp, struct svc_fh *fhp,
> diff --git a/fs/read_write.c b/fs/read_write.c
> index 9db7adf160d2..7ad07063c551 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1395,28 +1395,6 @@ ssize_t generic_copy_file_range(struct file *file_in, loff_t pos_in,
>  }
>  EXPORT_SYMBOL(generic_copy_file_range);
>
> -static ssize_t do_copy_file_range(struct file *file_in, loff_t pos_in,
> -                                 struct file *file_out, loff_t pos_out,
> -                                 size_t len, unsigned int flags)
> -{
> -       /*
> -        * Although we now allow filesystems to handle cross sb copy, passing
> -        * a file of the wrong filesystem type to filesystem driver can result
> -        * in an attempt to dereference the wrong type of ->private_data, so
> -        * avoid doing that until we really have a good reason.  NFS defines
> -        * several different file_system_type structures, but they all end up
> -        * using the same ->copy_file_range() function pointer.
> -        */
> -       if (file_out->f_op->copy_file_range &&
> -           file_out->f_op->copy_file_range == file_in->f_op->copy_file_range)
> -               return file_out->f_op->copy_file_range(file_in, pos_in,
> -                                                      file_out, pos_out,
> -                                                      len, flags);
> -
> -       return generic_copy_file_range(file_in, pos_in, file_out, pos_out, len,
> -                                      flags);
> -}
> -
>  /*
>   * Performs necessary checks before doing a file copy
>   *
> @@ -1434,6 +1412,25 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
>         loff_t size_in;
>         int ret;
>
> +       /*
> +        * Although we now allow filesystems to handle cross sb copy, passing
> +        * a file of the wrong filesystem type to filesystem driver can result
> +        * in an attempt to dereference the wrong type of ->private_data, so
> +        * avoid doing that until we really have a good reason.  NFS defines
> +        * several different file_system_type structures, but they all end up
> +        * using the same ->copy_file_range() function pointer.
> +        */
> +       if (file_out->f_op->copy_file_range) {
> +               if (file_in->f_op->copy_file_range !=
> +                   file_out->f_op->copy_file_range)
> +                       return -EXDEV;
> +       } else if (file_in->f_op->remap_file_range) {
> +               if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
> +                       return -EXDEV;
> +       } else {
> +                return -EOPNOTSUPP;
> +       }
> +
>         ret = generic_file_rw_checks(file_in, file_out);
>         if (ret)
>                 return ret;
> @@ -1498,10 +1495,11 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
>                 return ret;
>
>         if (len == 0)
> -               return 0;
> +               return file_out->f_op->copy_file_range ? 0 : -EOPNOTSUPP;

What is this supposed to do?
Please add a comment.
It seems to me that following the checks in generic_copy_file_checks()
this can only return -EOPNOTSUPP
if (!file_out->f_op->copy_file_range && file_in->f_op->remap_file_range)

Was that really the intention? Why?

Thanks,
Amir.
