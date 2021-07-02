Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C39B3B9F8A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jul 2021 13:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbhGBLPN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jul 2021 07:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbhGBLPM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jul 2021 07:15:12 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0CBC061762;
        Fri,  2 Jul 2021 04:12:41 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id y76so11159049iof.6;
        Fri, 02 Jul 2021 04:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=29mqB4d/0JGo1jbK5BbrdHh+6Rbk+2mvbm3FjqAEBQg=;
        b=pV9cy2OfhtSEXcuGY1aqZLuCiqd112B3UHzcR/m2fa90m1CjCXH5RgKzQLyMu6BpFH
         yjvjtuqG0BijGIl8pBD8ukLJUpp3aROvkdpWi3WX3tJSlI60uI5u6011QpJCuaXfZSR8
         cEV1Bm1PotU5ePgpC+3X3xSh1Ehzfr7HS3qvkRmG2t5F2dJQnA2K/3FLMdcXQdhlU+e7
         yDa8x6P+ROyyadwYuTR8LimkM64mkZY67c8bEqGEpYYqFYt/0NEgKnVy409dzBIvpRcL
         4W2963B1d9My2BT/3wRb/dHVzfDk7ZIlBgyhsm5K1GTwwNHK4JJP5X8XuBwAXwDoJ8lW
         Dskg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=29mqB4d/0JGo1jbK5BbrdHh+6Rbk+2mvbm3FjqAEBQg=;
        b=nEHkbRZGqbfBFwxxDjDV0SthXjqnR7TI+zk0d20VMTGAJsG+xUOQSt2tRQGC7IoVo/
         mUo3H2PYFUF86UdocTswovKrSs0+2UD5+qftwbjlgCqT2IJILRgeyqbRCKP0ByhV7Xzk
         aWhLSj2/BPHED5XLw3EAuqkn2hoVjygpg9p5Fs7on4stUqVLxbNSZQJfoZoOfOOxZJK3
         myGOYfZ6rtQ/3P2470s2upeVd/WqgIDBGD9onF7mnNsudTeTR9x1qLDoEwQxLH9+XklC
         kO5+Kqbq/FDm0n3ZlsWMC9FVws279JELjZs5zCQjomgrlrvE1DhLG5Pu1ufTXP+7IkNE
         bX7w==
X-Gm-Message-State: AOAM532mwpIRwICx0HHR8ueGwPeujUDNjpIjQWYtzheHq4D99IFigJW1
        SspD3dj5bf4a2xL6sb8+Omn4PFdTOujzKzAOtk0=
X-Google-Smtp-Source: ABdhPJwcPcrxy04I1LZUe45F2SYG/h6tMc1rGytBq1rxZ1KLGESeiK1+ugbpX5DHmJb5VMvoiPdpqDMIJ2Y8RnrQx4g=
X-Received: by 2002:a5d:8b03:: with SMTP id k3mr393471ion.203.1625224360491;
 Fri, 02 Jul 2021 04:12:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210702090012.28458-1-lhenriques@suse.de>
In-Reply-To: <20210702090012.28458-1-lhenriques@suse.de>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 2 Jul 2021 14:12:29 +0300
Message-ID: <CAOQ4uxhQciJ=r5E2yvM2zafhnBO4nZNVzUfEU9-tj9SAKAYwGg@mail.gmail.com>
Subject: Re: [PATCH v12] vfs: fix copy_file_range regression in cross-fs copies
To:     Luis Henriques <lhenriques@suse.de>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Olga Kornievskaia <aglo@umich.edu>,
        Petr Vorel <pvorel@suse.cz>, Steve French <sfrench@samba.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 2, 2021 at 12:00 PM Luis Henriques <lhenriques@suse.de> wrote:
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
> The short-circuit code for the case where the copy length is zero has also
> been dropped from the VFS code.  This is because a zero size copy between
> two files shall provide a clear indication on whether or not the
> filesystem supports non-zero copies.
>
> nfsd is also modified to fall-back into generic_copy_file_range() in case
> vfs_copy_file_range() fails with -EOPNOTSUPP or -EXDEV.
>
> Fixes: 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices")
> Link: https://lore.kernel.org/linux-fsdevel/20210212044405.4120619-1-drinkcat@chromium.org/
> Link: https://lore.kernel.org/linux-fsdevel/CANMq1KDZuxir2LM5jOTm0xx+BnvW=ZmpsG47CyHFJwnw7zSX6Q@mail.gmail.com/
> Link: https://lore.kernel.org/linux-fsdevel/20210126135012.1.If45b7cdc3ff707bc1efa17f5366057d60603c45f@changeid/
> Link: https://lore.kernel.org/linux-fsdevel/20210630161320.29006-1-lhenriques@suse.de/
> Reported-by: Nicolas Boichat <drinkcat@chromium.org>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Luis Henriques <lhenriques@suse.de>
> ---
> Changes since v11
> - added note about zero-size copies and a link to the corresponding
>   mailing-list discussion
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

I guess there was miscommunication

As Olga wrote, you have to place this short-circuit in
nfs4_copy_file_range() if you remove it from here.
It is NOT SAFE to pass zero length to nfs4_copy_file_range().

I apologize if you inferred from my response that you don't need to
do that.

My intention was, not knowing if and when your patch will be picked up,
(a volunteer to pick it pick never showed up...)
I think that nfs client developers should make sure that the zero length
check is added to nfs code as fail safety, because the semantics
of the vfs method and the NFS protocol command do not match.

Thanks,
Amir.
