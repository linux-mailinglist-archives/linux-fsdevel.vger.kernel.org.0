Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52F7B3B89F5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jun 2021 23:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234268AbhF3VJd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Jun 2021 17:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233777AbhF3VJc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Jun 2021 17:09:32 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3A1C061756;
        Wed, 30 Jun 2021 14:07:02 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id df12so5220066edb.2;
        Wed, 30 Jun 2021 14:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xfP/hKAjFP/Q4qet7eiCRJC07N5zt+VL0I8Gaz9dNWI=;
        b=GC2M8ncF8rvkITbOzGgBhi86EoeCm/DvwJuC6myEAaKpnFbSvWe7Ix/XWdlIdKR2kF
         ss427yXoyoXHOz0e7oX1EvAioCOlsacIFyEU918zlOtGDEdBH8Qzo4s6kWPgwdMfergh
         0xLjvCovyNo4j5Hv0220mUltZgPzVjhI3eQANIjm+3lcLbKCyhU30STuDCnIwJs/laOu
         y5kCuiAkSCgvwcXknMxpPJAawKF31hLTyJ8/h+G4SYZ/AXl9I8SnM5uiA4PVBYH5N2hb
         D80H4cg+3GddVWl7qsZVjZDDba8dSHO2RDFsCymIgEDdCDGdTvFJfItH4UwCB8bpyz+/
         L/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xfP/hKAjFP/Q4qet7eiCRJC07N5zt+VL0I8Gaz9dNWI=;
        b=CN9Bh8iX2bnTpehKadygiNMoWFeITprESqyvZoPs+1tG8Q5ZfoTGnuz8lwcr60ndaG
         3pOu91pvH4wL/T68T97Ka5/BEaRJXBwNoSCiXALl7n4mWkLJARxd8fd5vKDaXj8Cxzh/
         GQqESI9CptYxW9H/seZHcxeV/XXsmClm8WMz23wYOng3UPnzBiA52IliM/Q+gQGKFBZP
         Qr+P3iS6s4NofjclNxVJ5frRxV8zi5RMVB8zqu0RskJnnlYIjnGZoie7giXlYOfB5xDX
         9pJROevwXN5IKFsFstXnHsuNvlPoYc+4mOJmasIV16xtDW2QnGHK5vDWqytvLQ6OmbYI
         sI6Q==
X-Gm-Message-State: AOAM530bpNWlOAjmX+YiD/qxOBemuNsV6Zi24JfMBlVicnSc51zSdpKA
        qUF35b9KFdljWxfNZzHdsS6LapYOvPL3jnn9UNw=
X-Google-Smtp-Source: ABdhPJzy4IHXXRT+p2Tx5ALFxzngcfHnd0XSHipT4CFOeG4wbwL5bgxld5x0jEYOgMhklAc0niaU6hJXyHac/BxR9jw=
X-Received: by 2002:a05:6402:2927:: with SMTP id ee39mr51092804edb.367.1625087220900;
 Wed, 30 Jun 2021 14:07:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210630161320.29006-1-lhenriques@suse.de>
In-Reply-To: <20210630161320.29006-1-lhenriques@suse.de>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 30 Jun 2021 17:06:49 -0400
Message-ID: <CAN-5tyGXZWQgdaWG5GWJn1mZhA23PR-KEv1-EW=tGRJLL4PUWA@mail.gmail.com>
Subject: Re: [PATCH v11] vfs: fix copy_file_range regression in cross-fs copies
To:     Luis Henriques <lhenriques@suse.de>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Petr Vorel <pvorel@suse.cz>,
        kernel test robot <oliver.sang@intel.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

adding linux-nfs to the recipients as well (seems to have been dropped)

On Wed, Jun 30, 2021 at 12:22 PM Luis Henriques <lhenriques@suse.de> wrote:
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

Can somebody please explain this change to me? Is this an attempt to
support "whole" file copy?  I believe previously file systems relied
on the fact that they don't need to handle 0 size copy_file_range size
call. If this is being changed why not individual implementors (nfs,
etc) were modified to keep the same behavior? I mean is CIFS ok with
getting count=0 copy_file_range request?

In the NFS spec of COPY (copy_file_range), length of 0 means (or could
mean) "whole file" copy. While the linux NFS server did put in support
for doing "whole file" copy, it's not present before 5.13 in the linux
server. It makes it now confusing that a copy of length 0 previously
would return 0 and now it could copy whole file.


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
