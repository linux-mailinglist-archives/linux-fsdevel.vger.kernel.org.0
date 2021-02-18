Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E12531ECF5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Feb 2021 18:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhBRRK6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Feb 2021 12:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbhBRO7f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Feb 2021 09:59:35 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051D2C061786;
        Thu, 18 Feb 2021 06:58:55 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id a7so2241835iok.12;
        Thu, 18 Feb 2021 06:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rjlevDrW4OZzaJeZlfYX1axSKM93REeuyrbtDZTITNA=;
        b=OFKoSOEfP9CwHtqp/X1xVwcBxdZEiqcVxbGdFe2MfJxSWiZ+UFQQf8+cTF0vdWIOys
         YA6ElP8FI8Gnk3H0DNRgZbnlNO/LFuF69gUwkn9TPFqJHu8LN8Ub1cexfv+/CtuseElT
         LfojCmxhtVMZj3MVrUis9Agywenn509uvi+Eagyfyc+0bbDKWoL+uLY8lRgAqgMTwV1A
         EOE0xvHsoEZT0p/zPpdEEQUYbfDCE7P8h4AzfkexMLpIrrcPRszRtWhcm+Ljo6iRTu0n
         O2iCqJZtXqwS5BIy6/jUYdxopjte/KHnQUhoOUlSQuvF9bP5u9+j+1v0NN1ibxDvYq3Z
         o9Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rjlevDrW4OZzaJeZlfYX1axSKM93REeuyrbtDZTITNA=;
        b=r8geIG2LII8Tl/hbQBZNMdBF0sF1NKyvCDyWZ/s/46yhYPjCRuWgGg0+AP9hZo9ubH
         iOj0EOVuRpLFfkvXeXKP1ohUrMf4XJCVt0gIl4N9nLBbMkdoNKKlTBRhrFfVsDtWYm+Y
         wKIunCaJcX9PkrJa9j+kYm0N9ifboNoAu1+4Fu2xL8Kw3GrgwCNR50eMN6DlkeHbIEGS
         h8fNshaHKSYO2EeOPhpPzJn/fVusYtGClSur5M3AIR/JSnc6mDiwR0MCnYnL44QvngQ4
         4cb5Oy7YCFQXttsr+praMJck2/yd5FC1lwe3dYBRO7y5FMiAjtNXP+N3NbX2nxgcB745
         IICQ==
X-Gm-Message-State: AOAM530CDVUvyzAx2FHipOm5LJWzQ4Lw1Yc4syZTdlPgLLy710RBs2xz
        tkLxDWRI1C/+S7X0nZn3/AXnneIfSkiHNboWJvQ=
X-Google-Smtp-Source: ABdhPJzL7EV0A8f5riQ48ktdYmi6oVdZT3UzQJkyuI1GcyiWXeOO3yvAXtcHtwab2dLpmu6Omtjo4hpi92nP1fjmLQg=
X-Received: by 2002:a02:660b:: with SMTP id k11mr4923250jac.120.1613660334289;
 Thu, 18 Feb 2021 06:58:54 -0800 (PST)
MIME-Version: 1.0
References: <CAOQ4uxjGkm0Pn84UW6JKSK3mFkrPKykfkXDLL1V4YPSgAOXULA@mail.gmail.com>
 <20210218143635.24916-1-lhenriques@suse.de>
In-Reply-To: <20210218143635.24916-1-lhenriques@suse.de>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 18 Feb 2021 16:58:42 +0200
Message-ID: <CAOQ4uxj=ZeJ0HYtivP=pg5mSDaiQGU8Fz8qw0Egfa2Ert5Ra7A@mail.gmail.com>
Subject: Re: [PATCH v4] vfs: fix copy_file_range regression in cross-fs copies
To:     Luis Henriques <lhenriques@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>, Steve French <sfrench@samba.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <dchinner@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Ian Lance Taylor <iant@google.com>,
        Luis Lozano <llozano@chromium.org>,
        Andreas Dilger <adilger@dilger.ca>,
        Olga Kornievskaia <aglo@umich.edu>,
        Christoph Hellwig <hch@infradead.org>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 18, 2021 at 4:35 PM Luis Henriques <lhenriques@suse.de> wrote:
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
> nfsd is also modified to use generic_copy_file_range() instead of
> vfs_copy_file_range() so that it can still fall-back to splice without going
> through all the checks.
>
> Fixes: 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices")
> Link: https://lore.kernel.org/linux-fsdevel/20210212044405.4120619-1-drinkcat@chromium.org/
> Link: https://lore.kernel.org/linux-fsdevel/CANMq1KDZuxir2LM5jOTm0xx+BnvW=ZmpsG47CyHFJwnw7zSX6Q@mail.gmail.com/
> Link: https://lore.kernel.org/linux-fsdevel/20210126135012.1.If45b7cdc3ff707bc1efa17f5366057d60603c45f@changeid/
> Reported-by: Nicolas Boichat <drinkcat@chromium.org>
> Signed-off-by: Luis Henriques <lhenriques@suse.de>
> ---
> And here's v4.  I'd like to request help for testing.  I know Nicolas is
> doing that (thanks!  and thanks for the reviews).  But it would be great to
> get at least the nfs code tested.  Olga, can you help here?
>
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
>  fs/nfsd/vfs.c   |  2 +-
>  fs/read_write.c | 50 +++++++++++++++++++++++--------------------------
>  2 files changed, 24 insertions(+), 28 deletions(-)
>
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 04937e51de56..49dd28ee2602 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -578,7 +578,7 @@ ssize_t nfsd_copy_file_range(struct file *src, u64 src_pos, struct file *dst,
>          * limit like this and pipeline multiple COPY requests.
>          */
>         count = min_t(u64, count, 1 << 22);
> -       return vfs_copy_file_range(src, src_pos, dst, dst_pos, count, 0);
> +       return generic_copy_file_range(src, src_pos, dst, dst_pos, count, 0);

That is not the desired change.
It should try vfs_copy_file_range() and fallback to generic_copy_file_range()
for EXDEV and EOPNOTSUPP.
I will explain why.
This code runs on nfs server.
The nfs client requested remote server side copy offload using
nfs4_copy_file_range() and remote request is handled here.
It is not enough to generic_copy_file_range() on the server because
the source and destination themselves can be on yet another remote
location (cifs/ceph/nfs), so this is why calling vfs_copy_file_range()
here is important.
At least that is my understanding.
Unlike userspace copy fallback, if the server returns -EXDEV the client
will need to transfer the data over the network.
That is why the generic_copy_file_range() fallback is important.


>  }
>
>  __be32 nfsd4_vfs_fallocate(struct svc_rqst *rqstp, struct svc_fh *fhp,
> diff --git a/fs/read_write.c b/fs/read_write.c
> index 75f764b43418..214d44f7cbfa 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1388,28 +1388,6 @@ ssize_t generic_copy_file_range(struct file *file_in, loff_t pos_in,
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
> @@ -1427,6 +1405,25 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
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
> @@ -1499,8 +1496,7 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
>          * Try cloning first, this is supported by more file systems, and
>          * more efficient if both clone and copy are supported (e.g. NFS).
>          */
> -       if (file_in->f_op->remap_file_range &&
> -           file_inode(file_in)->i_sb == file_inode(file_out)->i_sb) {
> +       if (file_in->f_op->remap_file_range) {
>                 loff_t cloned;
>
>                 cloned = file_in->f_op->remap_file_range(file_in, pos_in,
> @@ -1513,9 +1509,9 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
>                 }
>         }
>
> -       ret = do_copy_file_range(file_in, pos_in, file_out, pos_out, len,
> -                               flags);
> -       WARN_ON_ONCE(ret == -EOPNOTSUPP);
> +       ret = file_out->f_op->copy_file_range(file_in, pos_in,
> +                                             file_out, pos_out,
> +                                             len, flags);

I see you have made an assumption here that if we did not clone then
file_out->f_op->copy_file_range must be valid.
It is not true.
file_out->f_op->copy_file_range could be NULL and we got here becauses
remap_file_range was attempted and failed.
So you still need to check for non-NULL file_out->f_op->copy_file_range
here just like it was before the regressing commit.

Otherwise, looks ok to me, but without NFS testing we won't know for sure
It's a tricky one...

Thanks,
Amir.
