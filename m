Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4F093B8753
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jun 2021 19:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbhF3REe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Jun 2021 13:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhF3REd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Jun 2021 13:04:33 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C12C061756;
        Wed, 30 Jun 2021 10:02:04 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id i17so3527949ilj.11;
        Wed, 30 Jun 2021 10:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uDMH1ofvbahbIAwpcPMuU1OKw8HI1Z/fX2NzlSDSFtE=;
        b=Ubc4OdJMHEKAsz+x339i5DdWwjwKVO9i88dtqBTNPglMcCkDhgkYA2sF4iCTnEFQCS
         kPLKnZ4uyLJh5kwHQYcBrPuuHmGwCfFvH+UoPYs2AVcOttZixYDvKYT25C/kdsxKaQFR
         eywoEz7azO+qqvavX9pLvujAhmuB6oxlBKxpulv3skgoJJmfS7KooIEyZogx5aASz73Q
         SfolA+M3tTxYGhvB4uvu7QxGJtUPfCwwq6Lp4Qw1rTJTKCXyp1iilSOP8WVtHJ3V5l5E
         tXdHcgE7/jaeHd8+F3Bmnu7OidqjeXqrZEuv/ZmLhcuyyC/rLJQBM0IiPMsmPSSgQoVJ
         WUNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uDMH1ofvbahbIAwpcPMuU1OKw8HI1Z/fX2NzlSDSFtE=;
        b=pv2f+3OQhlQq9wk9vWvolUQ6pX5QwP+IsFbtjBmUR/tXOHiCb8eGEfB/4Wf1E1YxQN
         1OG28CfBNpdfz/x5LWA3lpDMDXkzjri9zjlCuCQs2FqZKdUoNUa4s+3bJPyvRt5+JFCO
         dzkcUTKVGnoU3vO6jjYejf7/XEmxPMuQn1RDGpVjMNkYIOI3eVHiyiSDC6j2yw/JOVTL
         DyKmQCFVnr0UllpeE5aZjHeVnPJlV+rsasJXF5TRw3hjSESQOFfblPQXVsT3FyucreAk
         8chve+YVGvRYJGGI6qWrJYhFeqJdCC45VmL3JRzvR7emS6F0BEqRzPoQoi3Qzs+4wyai
         Y50A==
X-Gm-Message-State: AOAM531y57GnictHlc3B4r+V+T3ZywjUTI8Qslx/fKx/jxnfs0O8YXBE
        vj4K3U62PTI84oafTlKBgxoZqKl+iINeEU9ZMhE=
X-Google-Smtp-Source: ABdhPJx2TGmhIywd88QsSk0srgelYWP7k/Mj1ZL4wL70NN/rqpo6Erd5+CPf6ToFmkaY7Py9VGl0Iuqrdi5nkp9UkmI=
X-Received: by 2002:a92:4446:: with SMTP id a6mr27097200ilm.9.1625072524081;
 Wed, 30 Jun 2021 10:02:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210630161320.29006-1-lhenriques@suse.de>
In-Reply-To: <20210630161320.29006-1-lhenriques@suse.de>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 30 Jun 2021 20:01:53 +0300
Message-ID: <CAOQ4uxhtsVc3kn14Z7VV0xGLsmKvZQVxDoUnSA5X1oL4UQzcxQ@mail.gmail.com>
Subject: Re: [PATCH v11] vfs: fix copy_file_range regression in cross-fs copies
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

On Wed, Jun 30, 2021 at 7:13 PM Luis Henriques <lhenriques@suse.de> wrote:
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

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> Changes since v10
> - simply remove the "if (len == 0)" short-circuit instead of checking if
>   the filesystem implements the syscall.  This is because a filesystem may
>   implement it but a particular instance (hint: overlayfs!) may not.
> Changes since v9
> - the early return from the syscall when len is zero now checks if the
>   filesystem is implemented, returning -EOPNOTSUPP if it is not and 0
>   otherwise.  Issue reported by test robot.
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
>  fs/read_write.c | 52 +++++++++++++++++++++++--------------------------
>  2 files changed, 31 insertions(+), 29 deletions(-)
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
> index 9db7adf160d2..049a2dda29f7 100644
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
> @@ -1497,11 +1494,9 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
>         if (unlikely(ret))
>                 return ret;
>
> -       if (len == 0)
> -               return 0;
> -
>         file_start_write(file_out);
>
> +       ret = -EOPNOTSUPP;
>         /*
>          * Try cloning first, this is supported by more file systems, and
>          * more efficient if both clone and copy are supported (e.g. NFS).
> @@ -1520,9 +1515,10 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
>                 }
>         }
>
> -       ret = do_copy_file_range(file_in, pos_in, file_out, pos_out, len,
> -                               flags);
> -       WARN_ON_ONCE(ret == -EOPNOTSUPP);
> +       if (file_out->f_op->copy_file_range)
> +               ret = file_out->f_op->copy_file_range(file_in, pos_in,
> +                                                     file_out, pos_out,
> +                                                     len, flags);
>  done:
>         if (ret > 0) {
>                 fsnotify_access(file_in);
