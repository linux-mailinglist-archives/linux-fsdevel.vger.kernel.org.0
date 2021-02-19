Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E66A432006D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Feb 2021 22:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhBSVxC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Feb 2021 16:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhBSVw7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Feb 2021 16:52:59 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50575C061574;
        Fri, 19 Feb 2021 13:52:19 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id f6so7166556iop.11;
        Fri, 19 Feb 2021 13:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qXjaslBxdfmIZPmq5jE/iDmwu+D6B3K+SABeP3Z2zrY=;
        b=Wocz0LCQRMm68T4WSphrnPA8Cm93EKKBzodQGv9tyiCpUF0DkBbV36bIp9EqfmOPn/
         cpRNYxlPe2YFutw+DBT/x78K4w0rPZP2daXj1ExIFGjAh9+G1PuNjjfg//6nm7tGIDdm
         p9lG21AulZtgSXlvrmf+q1Br62L9yg9BQ5F77mgu3sYuGvIyTTo7T6xLbJ5B5mhKyfJ+
         x0FSSN2KWc79R3dR39VzI7nXT8xoFaFsTL61bnsOD4mnUn3ei7JJsQ7FQ/TltRUMkcH4
         4rZmuoDlgareU3FTTYvWbbFJelAvFsatd9wQ0CWy4GJw/XLYKtBbLrh0F7x/cpesZGmV
         Udfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qXjaslBxdfmIZPmq5jE/iDmwu+D6B3K+SABeP3Z2zrY=;
        b=kgAt3P/5xml/5trpuzt7o0rjDqLXcgS9eQmo/lkhlKzpy1vyWlHAqWqjxCM7SkqaEr
         kSvifZ/6Ic9hp/kAYs7mQLC0vx3BYwCqk3KImp7x5rwJZpoek/YmZe3GO/C27kj4jlSp
         /amzcFEws+i/MVxLZ1TUahrjNwq61Lk2h29SddB9oo9ah4A03s3FxIKzH9h+VNVyjd/W
         jVgJoWhONNLULvJvd2HJRo2GqHr5lu9YWNKT49wubevjGdj4U8SJvBGao6xal24oySAp
         FF5dhhThgu5QMqNzo+fpflMIC7QKJiHI8cKedPiTLRVqP4SnVIkGDVYN89wAuEJjZbMd
         4V3w==
X-Gm-Message-State: AOAM532bmdDZTrHWAyKQiIl/IUPgGCI45E1ST257AIl3KLukFE+5gKg8
        mj1nSVgfQo3IYw5//VDwfzbuaqsFyvlt+2t9zdc=
X-Google-Smtp-Source: ABdhPJw7u7ImGzxpuhQ5dMzPMNbdisI0OgkFAQgBSkSmlC3fMgxfOCPAWornbAr3evbufoKZtRzBLRoOUT/tdFySNm4=
X-Received: by 2002:a05:6602:2c52:: with SMTP id x18mr5758191iov.5.1613771538479;
 Fri, 19 Feb 2021 13:52:18 -0800 (PST)
MIME-Version: 1.0
References: <87blchibaf.fsf@suse.de> <20210218171806.26930-1-lhenriques@suse.de>
 <CAN-5tyGs9skFZ=ghd8Vz2F35S70QYi+kujdyRYLSkcEi8Jm9gw@mail.gmail.com>
In-Reply-To: <CAN-5tyGs9skFZ=ghd8Vz2F35S70QYi+kujdyRYLSkcEi8Jm9gw@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 19 Feb 2021 23:52:07 +0200
Message-ID: <CAOQ4uxgeDx9M5YJJvxzJkbLEEyL0GioGFBggvvPEcpdjOoYSeA@mail.gmail.com>
Subject: Re: [PATCH v6] vfs: fix copy_file_range regression in cross-fs copies
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     Luis Henriques <lhenriques@suse.de>,
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

On Fri, Feb 19, 2021 at 11:18 PM Olga Kornievskaia <aglo@umich.edu> wrote:
>
> On Thu, Feb 18, 2021 at 12:33 PM Luis Henriques <lhenriques@suse.de> wrote:
> >
> > A regression has been reported by Nicolas Boichat, found while using the
> > copy_file_range syscall to copy a tracefs file.  Before commit
> > 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices") the
> > kernel would return -EXDEV to userspace when trying to copy a file across
> > different filesystems.  After this commit, the syscall doesn't fail anymore
> > and instead returns zero (zero bytes copied), as this file's content is
> > generated on-the-fly and thus reports a size of zero.
> >
> > This patch restores some cross-filesystem copy restrictions that existed
> > prior to commit 5dae222a5ff0 ("vfs: allow copy_file_range to copy across
> > devices").  Filesystems are still allowed to fall-back to the VFS
> > generic_copy_file_range() implementation, but that has now to be done
> > explicitly.
> >
> > nfsd is also modified to fall-back into generic_copy_file_range() in case
> > vfs_copy_file_range() fails with -EOPNOTSUPP or -EXDEV.
> >
> > Fixes: 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices")
> > Link: https://lore.kernel.org/linux-fsdevel/20210212044405.4120619-1-drinkcat@chromium.org/
> > Link: https://lore.kernel.org/linux-fsdevel/CANMq1KDZuxir2LM5jOTm0xx+BnvW=ZmpsG47CyHFJwnw7zSX6Q@mail.gmail.com/
> > Link: https://lore.kernel.org/linux-fsdevel/20210126135012.1.If45b7cdc3ff707bc1efa17f5366057d60603c45f@changeid/
> > Reported-by: Nicolas Boichat <drinkcat@chromium.org>
> > Signed-off-by: Luis Henriques <lhenriques@suse.de>
> > ---
> > And v6 is upon us.  Behold!
>
>
> > Changes since v5
> > - check if ->copy_file_range is NULL before calling it
> > Changes since v4
> > - nfsd falls-back to generic_copy_file_range() only *if* it gets -EOPNOTSUPP
> >   or -EXDEV.
> > Changes since v3
> > - dropped the COPY_FILE_SPLICE flag
> > - kept the f_op's checks early in generic_copy_file_checks, implementing
> >   Amir's suggestions
> > - modified nfsd to use generic_copy_file_range()
> > Changes since v2
> > - do all the required checks earlier, in generic_copy_file_checks(),
> >   adding new checks for ->remap_file_range
> > - new COPY_FILE_SPLICE flag
> > - don't remove filesystem's fallback to generic_copy_file_range()
> > - updated commit changelog (and subject)
> > Changes since v1 (after Amir review)
> > - restored do_copy_file_range() helper
> > - return -EOPNOTSUPP if fs doesn't implement CFR
> > - updated commit description
> >
> >  fs/nfsd/vfs.c   |  8 +++++++-
> >  fs/read_write.c | 53 ++++++++++++++++++++++++-------------------------
> >  2 files changed, 33 insertions(+), 28 deletions(-)
> >
> > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > index 04937e51de56..23dab0fa9087 100644
> > --- a/fs/nfsd/vfs.c
> > +++ b/fs/nfsd/vfs.c
> > @@ -568,6 +568,7 @@ __be32 nfsd4_clone_file_range(struct nfsd_file *nf_src, u64 src_pos,
> >  ssize_t nfsd_copy_file_range(struct file *src, u64 src_pos, struct file *dst,
> >                              u64 dst_pos, u64 count)
> >  {
> > +       ssize_t ret;
> >
> >         /*
> >          * Limit copy to 4MB to prevent indefinitely blocking an nfsd
> > @@ -578,7 +579,12 @@ ssize_t nfsd_copy_file_range(struct file *src, u64 src_pos, struct file *dst,
> >          * limit like this and pipeline multiple COPY requests.
> >          */
> >         count = min_t(u64, count, 1 << 22);
> > -       return vfs_copy_file_range(src, src_pos, dst, dst_pos, count, 0);
> > +       ret = vfs_copy_file_range(src, src_pos, dst, dst_pos, count, 0);
> > +
> > +       if (ret == -EOPNOTSUPP || ret == -EXDEV)
> > +               ret = generic_copy_file_range(src, src_pos, dst, dst_pos,
> > +                                             count, 0);
> > +       return ret;
> >  }
> >
> >  __be32 nfsd4_vfs_fallocate(struct svc_rqst *rqstp, struct svc_fh *fhp,
> > diff --git a/fs/read_write.c b/fs/read_write.c
> > index 75f764b43418..0348aaa9e237 100644
> > --- a/fs/read_write.c
> > +++ b/fs/read_write.c
> > @@ -1388,28 +1388,6 @@ ssize_t generic_copy_file_range(struct file *file_in, loff_t pos_in,
> >  }
> >  EXPORT_SYMBOL(generic_copy_file_range);
> >
> > -static ssize_t do_copy_file_range(struct file *file_in, loff_t pos_in,
> > -                                 struct file *file_out, loff_t pos_out,
> > -                                 size_t len, unsigned int flags)
> > -{
> > -       /*
> > -        * Although we now allow filesystems to handle cross sb copy, passing
> > -        * a file of the wrong filesystem type to filesystem driver can result
> > -        * in an attempt to dereference the wrong type of ->private_data, so
> > -        * avoid doing that until we really have a good reason.  NFS defines
> > -        * several different file_system_type structures, but they all end up
> > -        * using the same ->copy_file_range() function pointer.
> > -        */
> > -       if (file_out->f_op->copy_file_range &&
> > -           file_out->f_op->copy_file_range == file_in->f_op->copy_file_range)
> > -               return file_out->f_op->copy_file_range(file_in, pos_in,
> > -                                                      file_out, pos_out,
> > -                                                      len, flags);
> > -
> > -       return generic_copy_file_range(file_in, pos_in, file_out, pos_out, len,
> > -                                      flags);
> > -}
> > -
> >  /*
> >   * Performs necessary checks before doing a file copy
> >   *
> > @@ -1427,6 +1405,25 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
> >         loff_t size_in;
> >         int ret;
> >
> > +       /*
> > +        * Although we now allow filesystems to handle cross sb copy, passing
> > +        * a file of the wrong filesystem type to filesystem driver can result
> > +        * in an attempt to dereference the wrong type of ->private_data, so
> > +        * avoid doing that until we really have a good reason.  NFS defines
> > +        * several different file_system_type structures, but they all end up
> > +        * using the same ->copy_file_range() function pointer.
> > +        */
> > +       if (file_out->f_op->copy_file_range) {
> > +               if (file_in->f_op->copy_file_range !=
> > +                   file_out->f_op->copy_file_range)
> > +                       return -EXDEV;
> > +       } else if (file_in->f_op->remap_file_range) {
> > +               if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
> > +                       return -EXDEV;
> > +       } else {
> > +                return -EOPNOTSUPP;
> > +       }
> > +
> >         ret = generic_file_rw_checks(file_in, file_out);
> >         if (ret)
> >                 return ret;
> > @@ -1499,8 +1496,7 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
> >          * Try cloning first, this is supported by more file systems, and
> >          * more efficient if both clone and copy are supported (e.g. NFS).
> >          */
> > -       if (file_in->f_op->remap_file_range &&
> > -           file_inode(file_in)->i_sb == file_inode(file_out)->i_sb) {
> > +       if (file_in->f_op->remap_file_range) {
> >                 loff_t cloned;
>
> This chunk breaks NFS. You are removing the check that the source and
> destination for the CLONE operation are the same superblock and that
> leads to the fact that when NFS does a copy between 2 different NFS
> servers, it would try CLONE first which is not allowed. NFS relied on
> this check to be done by the VFS layer. Either don't remove it or,
> otherwise, fix the NFS clone's code to not send the CLONE and error
> accordingly so that the COPY is done as it should have been.
>

Right, we need to add this check back (not only for NFS).

However, I was looking at the change that introduced this opportunistic
call for clone_file_range() into copy_file_range():

commit a76b5b04375f974579c83433b06466758c0c552c
Author: Christoph Hellwig <hch@lst.de>
Date:   Fri Dec 9 16:17:19 2016 -0800

    fs: try to clone files first in vfs_copy_file_range

    A clone is a perfectly fine implementation of a file copy, so most
    file systems just implement the copy that way.  Instead of duplicating
    this logic move it to the VFS.  Currently btrfs and XFS implement copies
    the same way as clones and there is no behavior change for them, cifs
    only implements clones and grow support for copy_file_range with this
    patch.  NFS implements both, so this will allow copy_file_range to work
    on servers that only implement CLONE and be lot more efficient on servers
    that implements CLONE and COPY.

And I was thinking to myself that like the change that brought us here
("vfs: allow copy_file_range to copy across devices"), this change was done
for a certain purpose (serve copy_file_range() by fs that implement CLONE),
but that last part (prefer CLONE over COPY) also sounds like an optimization
that nobody asked for and could lead to unexpected behavior down the road.

I think that if a filesystem implements both methods (COPY and CLONE)
and user called to COPY API, we need to call the more specialized COPY
method and not try the CLONE method, because filesystem should be very
capable of making this optimization internally.

This could have been a hypothetical question, but there are actually
two filesystems that implement both COPY and CLONE, so let's ask the
developers what they think VFS should call.

Olga, Trond, Steve, which methods of your filesystem do you think that
vfs_copy_file_range() should call?
1. Only copy_file_range()?
2. Both copy_file_range() and remap_file_range()?
3. CLONE before COPY or the other way around?

Thanks,
Amir.
