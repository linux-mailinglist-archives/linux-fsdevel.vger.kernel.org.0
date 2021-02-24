Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6B643234FC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Feb 2021 02:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234560AbhBXBKR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Feb 2021 20:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234220AbhBXBCV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Feb 2021 20:02:21 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FF7C061574;
        Tue, 23 Feb 2021 17:01:07 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id t11so366975ejx.6;
        Tue, 23 Feb 2021 17:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vm9xBe5PM6MmRSaKGqIJs8poTm+3t4yGBEisapYD5Es=;
        b=dGGZqD8uEQMQldGOZLMsGwyC7niw3puMdqHnPAxUHKf3rGy3qhLT8qzgL0iDVOGlKH
         QKIfQ/uHbrOlnlMn50zmWwI5zc77s+AI1w2XeT+zGVF1/sLb52X5eRbQUWnAucYGsjtz
         XG3rEZT5eyk8/CsqVk7SSq/6G+h7qe1EiJvP5ktT6Pmv+C8gpZ7Pa+kprtadO5W83Xi1
         M4iAtmR/sp9owb722NsqThG0Nx0+5Pd3q2yGxVk6gaq+F2jIG4AfJcogvGhwMi8mUSc4
         g0ZzbDq6f1AJgkkLiRvCHAqQkbaeg8kSr2Ydea4Kfod3TQu1inakVLKC0RavYN+2CzDo
         nfbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vm9xBe5PM6MmRSaKGqIJs8poTm+3t4yGBEisapYD5Es=;
        b=CyHdbCo/OXTh7BnoC1e16WtzXtvWeWNTflOtsNdvFPly+hmUzmLQHkzlU1jf+8vjx0
         YZIYE/D9Qk0YJRUVUuku4BQi9Y2XY3zZ/4tS0FwswqP56jwKdW9c0MPMo+daq1knNnGV
         dnteB3JE+YY2psAdwQxDrnsM9G0nWSCYo0xo/JmQuW3jgJI35xs0Swjr7+jCJX5G1MWJ
         ysFdjiJ2myT7jhxhTzQbdW2bHDraUchOMUVqqrJ4HAIPx6nD+1+H/3Q/HmQOJo4vurkQ
         fJZ3qDw7kvMD9vkQhgO/yPNi1bTDZT7tim3Hw65Aozl2s9AuHmtKLmbhZudcJuMt0zpZ
         AIxQ==
X-Gm-Message-State: AOAM533lbcIRQWaJXUrKmOiJlCPnyD5peAo/RsP8kXqPJhI0+GMl5fL7
        Dree8OKt0DM3uQjh4rPD4LuliGHq6uAuE9FPLd4=
X-Google-Smtp-Source: ABdhPJyVSJT8Om5osq9q1Ui7W36kFAT6ebJRWvHvxf7JsVbb976GBLC1faTNjLpl7oPk6lxQ1nx5MF7+IUO0QXHTKLs=
X-Received: by 2002:a17:906:c08e:: with SMTP id f14mr29826415ejz.388.1614128465592;
 Tue, 23 Feb 2021 17:01:05 -0800 (PST)
MIME-Version: 1.0
References: <20210221195833.23828-1-lhenriques@suse.de> <20210222102456.6692-1-lhenriques@suse.de>
In-Reply-To: <20210222102456.6692-1-lhenriques@suse.de>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Tue, 23 Feb 2021 20:00:54 -0500
Message-ID: <CAN-5tyELMY7b7CKO-+an47ydq8r_4+SOyhuvdH0qE0-JmdZ44Q@mail.gmail.com>
Subject: Re: [PATCH v8] vfs: fix copy_file_range regression in cross-fs copies
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

On Mon, Feb 22, 2021 at 5:25 AM Luis Henriques <lhenriques@suse.de> wrote:
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

I tested v8 and I believe it works for NFS.

> ---
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
>  fs/read_write.c | 49 ++++++++++++++++++++++++-------------------------
>  2 files changed, 31 insertions(+), 26 deletions(-)
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
> index 75f764b43418..5a26297fd410 100644
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
> @@ -1495,6 +1492,7 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
>
>         file_start_write(file_out);
>
> +       ret = -EOPNOTSUPP;
>         /*
>          * Try cloning first, this is supported by more file systems, and
>          * more efficient if both clone and copy are supported (e.g. NFS).
> @@ -1513,9 +1511,10 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
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
