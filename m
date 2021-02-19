Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 428BD320041
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Feb 2021 22:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbhBSVTe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Feb 2021 16:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhBSVT2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Feb 2021 16:19:28 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE24DC061574;
        Fri, 19 Feb 2021 13:18:47 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id n13so16005856ejx.12;
        Fri, 19 Feb 2021 13:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qpiK1eBI0JH4fXJaDNdYBec2kwtlwlrLH5l2qwbU48E=;
        b=BgUvBjZ0dBKGyL/A+0c3x7nKESw3o2u6jWXCxCXFjxXgQqRzMzD5lXi+RualLobuNJ
         HJRJk7uDx+RYeLp3woC7TF2BiVhw5luZOiFbU6owlNGj9RAfsCPdRX1ew1omNrjegPMX
         jtpAwGb64n+TfmRYrQ3e+wGy+d3/3pKxJIDj3ZkT9gMUFTDbGCDrX1H5M5E6mOTQuy0N
         8O/JkH3Yy54orKAxskn+A8KDt2TWBSd91hrg+FYVOimH21huB++R3w4aBXMYCLyLoCj6
         kxq9RKj+6xKXT9+qwjSptk7rabm6iU8gs6KjpxuHBOWrliccAPR4NR+xXG7gAQBa0V0E
         MoaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qpiK1eBI0JH4fXJaDNdYBec2kwtlwlrLH5l2qwbU48E=;
        b=gTqfveSnyfMezqTMqPlxVMuRzsaigdgK8aY2YnsMIl6n+cHv24fXR4ujU0Z8AY6Gs4
         tGy7e+ep4AzqqHX9zi9+JrNeuXQpVhJS0lhPCATEnaEe+LaQRIc6lyiQ4VP6r6ovfDlb
         dc4/LCQuYMaAClKI/kJh6B0tWae+XfRX1xG6Ak+YQTuvBPZRM1LyXfXr33L7aUrxZT0P
         xLyZ5jLQEVEjfVPft7dYx9V2oiWLFqxOCl4OreH5ocsSNy1rCzWec9Qa9nbtippHutaz
         QWKcWRIdiP77XpcmNrDBg7SafKbmUa/mPztXmCo3uJZLdfsFunD+SwU1hFVe/oe6a3cf
         825w==
X-Gm-Message-State: AOAM532gStmXjrQZmrR3NFNqNVcC+tNlDyviNGj2v7RJU3EaNdsJderz
        FPhf1mLM6z0/tGYw5kIHe8TZxLrvyZjk/1zxZJk=
X-Google-Smtp-Source: ABdhPJyrt30hl968yFjbmr8YBcPMTwCpQsN9tK3+5AHXqpyHJBg2FHYMqVsr8C7G9o2LC3P1Wbf4Y5jBQxwqyg6msrY=
X-Received: by 2002:a17:907:1b1f:: with SMTP id mp31mr10515874ejc.348.1613769526395;
 Fri, 19 Feb 2021 13:18:46 -0800 (PST)
MIME-Version: 1.0
References: <87blchibaf.fsf@suse.de> <20210218171806.26930-1-lhenriques@suse.de>
In-Reply-To: <20210218171806.26930-1-lhenriques@suse.de>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Fri, 19 Feb 2021 16:18:34 -0500
Message-ID: <CAN-5tyGs9skFZ=ghd8Vz2F35S70QYi+kujdyRYLSkcEi8Jm9gw@mail.gmail.com>
Subject: Re: [PATCH v6] vfs: fix copy_file_range regression in cross-fs copies
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
        Luis Lozano <llozano@chromium.org>,
        Andreas Dilger <adilger@dilger.ca>,
        Christoph Hellwig <hch@infradead.org>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 18, 2021 at 12:33 PM Luis Henriques <lhenriques@suse.de> wrote:
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
> Signed-off-by: Luis Henriques <lhenriques@suse.de>
> ---
> And v6 is upon us.  Behold!


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
>  fs/read_write.c | 53 ++++++++++++++++++++++++-------------------------
>  2 files changed, 33 insertions(+), 28 deletions(-)
>
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 04937e51de56..23dab0fa9087 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -568,6 +568,7 @@ __be32 nfsd4_clone_file_range(struct nfsd_file *nf_src, u64 src_pos,
>  ssize_t nfsd_copy_file_range(struct file *src, u64 src_pos, struct file *dst,
>                              u64 dst_pos, u64 count)
>  {
> +       ssize_t ret;
>
>         /*
>          * Limit copy to 4MB to prevent indefinitely blocking an nfsd
> @@ -578,7 +579,12 @@ ssize_t nfsd_copy_file_range(struct file *src, u64 src_pos, struct file *dst,
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
> index 75f764b43418..0348aaa9e237 100644
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

This chunk breaks NFS. You are removing the check that the source and
destination for the CLONE operation are the same superblock and that
leads to the fact that when NFS does a copy between 2 different NFS
servers, it would try CLONE first which is not allowed. NFS relied on
this check to be done by the VFS layer. Either don't remove it or,
otherwise, fix the NFS clone's code to not send the CLONE and error
accordingly so that the COPY is done as it should have been.

>                 cloned = file_in->f_op->remap_file_range(file_in, pos_in,
> @@ -1511,11 +1507,14 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
>                         ret = cloned;
>                         goto done;
>                 }
> +               /* Resort to copy_file_range if implemented. */
> +               ret = -EOPNOTSUPP;
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
