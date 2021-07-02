Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C566A3B9B4E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jul 2021 06:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbhGBEXk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jul 2021 00:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhGBEXk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jul 2021 00:23:40 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AB6C061762;
        Thu,  1 Jul 2021 21:21:08 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id v3so10133053ioq.9;
        Thu, 01 Jul 2021 21:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2fPvHDBEaFEUUo4oDgmRFPwaYBTPBap70Qbx9HwS18M=;
        b=AiseGGvRimqMvZwOilhA8wxnNDsaTpzpUYTdvFxVfbqB62LMolmldKjmN2O+mUj/Pc
         beUpJnlApcb5RQHJSMi2Uxryhwly7vwTuRnw+D7L78i0ZYDIXQxIsqOKdPuZsEFip2dr
         PLPfFI6uL0SRrs9JWztluMAqIa2BVL7MuU3ctKJhI4AaOn58hPL23EEZD5iBt/YDuwdA
         XBLluMF5Gi+U5+NYNGLeLw+sERQ+8UgaYGG+yAUbRqe6Bbc1PbTS0Y/cklRA8jqXr3lM
         J90Lhh43zNs7JeKCBNzXpL61j5N+2go67AidRml6l2NM0qgDgq4x76Z1FOmJoLbV0ZES
         +3Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2fPvHDBEaFEUUo4oDgmRFPwaYBTPBap70Qbx9HwS18M=;
        b=S/OHnkEKvbjAJrRdvrKfm9s9Je3tUoRm/4cegIfACFoMzWGOlbBY6CCF3vd6jj3s0j
         Nk3xvbJgCXgBzaMOAwJ8jv89hO5YruQIF8QTSqLt9UCvS2Mf+pBDo5U55F0gq1hN9MSl
         MT5nP6fxuVUoil6SefKo4fa9GM5HMn+8wqXiFjyJb2iDvvjXQazrI0JPnbAQeumlo6Vy
         GqKy4zMhF1nLLOAZ4JDt9j4q/j1ABFTqBrwPlpmO6YGbwutzFSCWIkM5I5s9XGEngbBU
         9WXGo2f3sb7RHes2OBTrnUfeUjDmMTWolyKv7WOQlmgzbjdTe0tpIY0NQxg12utZd9PT
         4TEg==
X-Gm-Message-State: AOAM530fLSjg6emTA+MVj78wDz3Pk5AdmZMqvOs13D4GBsLQD+U9skAh
        m898VElskOG6hrosiaubx3nrB9e0IgfRFt5eY+A=
X-Google-Smtp-Source: ABdhPJzK9ODUBxiA3kJDUiuZWANEoEhuta1UyBe/4JffVZaHZgA8+rcqgRwypvWTBWghpueBonytvjdVU3D09AVrW3Q=
X-Received: by 2002:a5d:8b03:: with SMTP id k3mr148186ion.203.1625199668263;
 Thu, 01 Jul 2021 21:21:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210630161320.29006-1-lhenriques@suse.de> <CAN-5tyGXZWQgdaWG5GWJn1mZhA23PR-KEv1-EW=tGRJLL4PUWA@mail.gmail.com>
 <YN2FhweR8MXABae5@suse.de> <CAN-5tyGO1-21HTU4TjXiE9dF3rD_vVt9owd0-8y=S8HeMuf9mA@mail.gmail.com>
In-Reply-To: <CAN-5tyGO1-21HTU4TjXiE9dF3rD_vVt9owd0-8y=S8HeMuf9mA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 2 Jul 2021 07:20:57 +0300
Message-ID: <CAOQ4uxgwcNwWEqYKBg3fMHD3aXOsYUmPeexBe9EVP9Nb53b-Hw@mail.gmail.com>
Subject: Re: [PATCH v11] vfs: fix copy_file_range regression in cross-fs copies
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     Luis Henriques <lhenriques@suse.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Petr Vorel <pvorel@suse.cz>, Steve French <sfrench@samba.org>,
        kernel test robot <oliver.sang@intel.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 1, 2021 at 9:07 PM Olga Kornievskaia <aglo@umich.edu> wrote:
>
> On Thu, Jul 1, 2021 at 5:06 AM Luis Henriques <lhenriques@suse.de> wrote:
> >
> > On Wed, Jun 30, 2021 at 05:06:49PM -0400, Olga Kornievskaia wrote:
> > > adding linux-nfs to the recipients as well (seems to have been dropped)
> > >
> > > On Wed, Jun 30, 2021 at 12:22 PM Luis Henriques <lhenriques@suse.de> wrote:
> > > >
> > > > A regression has been reported by Nicolas Boichat, found while using the
> > > > copy_file_range syscall to copy a tracefs file.  Before commit
> > > > 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices") the
> > > > kernel would return -EXDEV to userspace when trying to copy a file across
> > > > different filesystems.  After this commit, the syscall doesn't fail anymore
> > > > and instead returns zero (zero bytes copied), as this file's content is
> > > > generated on-the-fly and thus reports a size of zero.
> > > >
> > > > This patch restores some cross-filesystem copy restrictions that existed
> > > > prior to commit 5dae222a5ff0 ("vfs: allow copy_file_range to copy across
> > > > devices").  Filesystems are still allowed to fall-back to the VFS
> > > > generic_copy_file_range() implementation, but that has now to be done
> > > > explicitly.
> > > >
> > > > nfsd is also modified to fall-back into generic_copy_file_range() in case
> > > > vfs_copy_file_range() fails with -EOPNOTSUPP or -EXDEV.
> > > >
> > > > Fixes: 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices")
> > > > Link: https://lore.kernel.org/linux-fsdevel/20210212044405.4120619-1-drinkcat@chromium.org/
> > > > Link: https://lore.kernel.org/linux-fsdevel/CANMq1KDZuxir2LM5jOTm0xx+BnvW=ZmpsG47CyHFJwnw7zSX6Q@mail.gmail.com/
> > > > Link: https://lore.kernel.org/linux-fsdevel/20210126135012.1.If45b7cdc3ff707bc1efa17f5366057d60603c45f@changeid/
> > > > Reported-by: Nicolas Boichat <drinkcat@chromium.org>
> > > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > > > Signed-off-by: Luis Henriques <lhenriques@suse.de>
> > > > ---
> > > > Changes since v10
> > > > - simply remove the "if (len == 0)" short-circuit instead of checking if
> > > >   the filesystem implements the syscall.  This is because a filesystem may
> > > >   implement it but a particular instance (hint: overlayfs!) may not.
> > > > Changes since v9
> > > > - the early return from the syscall when len is zero now checks if the
> > > >   filesystem is implemented, returning -EOPNOTSUPP if it is not and 0
> > > >   otherwise.  Issue reported by test robot.
> > > >   (obviously, dropped Amir's Reviewed-by and Olga's Tested-by tags)
> > > > Changes since v8
> > > > - Simply added Amir's Reviewed-by and Olga's Tested-by
> > > > Changes since v7
> > > > - set 'ret' to '-EOPNOTSUPP' before the clone 'if' statement so that the
> > > >   error returned is always related to the 'copy' operation
> > > > Changes since v6
> > > > - restored i_sb checks for the clone operation
> > > > Changes since v5
> > > > - check if ->copy_file_range is NULL before calling it
> > > > Changes since v4
> > > > - nfsd falls-back to generic_copy_file_range() only *if* it gets -EOPNOTSUPP
> > > >   or -EXDEV.
> > > > Changes since v3
> > > > - dropped the COPY_FILE_SPLICE flag
> > > > - kept the f_op's checks early in generic_copy_file_checks, implementing
> > > >   Amir's suggestions
> > > > - modified nfsd to use generic_copy_file_range()
> > > > Changes since v2
> > > > - do all the required checks earlier, in generic_copy_file_checks(),
> > > >   adding new checks for ->remap_file_range
> > > > - new COPY_FILE_SPLICE flag
> > > > - don't remove filesystem's fallback to generic_copy_file_range()
> > > > - updated commit changelog (and subject)
> > > > Changes since v1 (after Amir review)
> > > > - restored do_copy_file_range() helper
> > > > - return -EOPNOTSUPP if fs doesn't implement CFR
> > > > - updated commit description
> > > >
> > > >  fs/nfsd/vfs.c   |  8 +++++++-
> > > >  fs/read_write.c | 52 +++++++++++++++++++++++--------------------------
> > > >  2 files changed, 31 insertions(+), 29 deletions(-)
> > > >
> > > > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > > > index 15adf1f6ab21..f54a88b3b4a2 100644
> > > > --- a/fs/nfsd/vfs.c
> > > > +++ b/fs/nfsd/vfs.c
> > > > @@ -569,6 +569,7 @@ __be32 nfsd4_clone_file_range(struct nfsd_file *nf_src, u64 src_pos,
> > > >  ssize_t nfsd_copy_file_range(struct file *src, u64 src_pos, struct file *dst,
> > > >                              u64 dst_pos, u64 count)
> > > >  {
> > > > +       ssize_t ret;
> > > >
> > > >         /*
> > > >          * Limit copy to 4MB to prevent indefinitely blocking an nfsd
> > > > @@ -579,7 +580,12 @@ ssize_t nfsd_copy_file_range(struct file *src, u64 src_pos, struct file *dst,
> > > >          * limit like this and pipeline multiple COPY requests.
> > > >          */
> > > >         count = min_t(u64, count, 1 << 22);
> > > > -       return vfs_copy_file_range(src, src_pos, dst, dst_pos, count, 0);
> > > > +       ret = vfs_copy_file_range(src, src_pos, dst, dst_pos, count, 0);
> > > > +
> > > > +       if (ret == -EOPNOTSUPP || ret == -EXDEV)
> > > > +               ret = generic_copy_file_range(src, src_pos, dst, dst_pos,
> > > > +                                             count, 0);
> > > > +       return ret;
> > > >  }
> > > >
> > > >  __be32 nfsd4_vfs_fallocate(struct svc_rqst *rqstp, struct svc_fh *fhp,
> > > > diff --git a/fs/read_write.c b/fs/read_write.c
> > > > index 9db7adf160d2..049a2dda29f7 100644
> > > > --- a/fs/read_write.c
> > > > +++ b/fs/read_write.c
> > > > @@ -1395,28 +1395,6 @@ ssize_t generic_copy_file_range(struct file *file_in, loff_t pos_in,
> > > >  }
> > > >  EXPORT_SYMBOL(generic_copy_file_range);
> > > >
> > > > -static ssize_t do_copy_file_range(struct file *file_in, loff_t pos_in,
> > > > -                                 struct file *file_out, loff_t pos_out,
> > > > -                                 size_t len, unsigned int flags)
> > > > -{
> > > > -       /*
> > > > -        * Although we now allow filesystems to handle cross sb copy, passing
> > > > -        * a file of the wrong filesystem type to filesystem driver can result
> > > > -        * in an attempt to dereference the wrong type of ->private_data, so
> > > > -        * avoid doing that until we really have a good reason.  NFS defines
> > > > -        * several different file_system_type structures, but they all end up
> > > > -        * using the same ->copy_file_range() function pointer.
> > > > -        */
> > > > -       if (file_out->f_op->copy_file_range &&
> > > > -           file_out->f_op->copy_file_range == file_in->f_op->copy_file_range)
> > > > -               return file_out->f_op->copy_file_range(file_in, pos_in,
> > > > -                                                      file_out, pos_out,
> > > > -                                                      len, flags);
> > > > -
> > > > -       return generic_copy_file_range(file_in, pos_in, file_out, pos_out, len,
> > > > -                                      flags);
> > > > -}
> > > > -
> > > >  /*
> > > >   * Performs necessary checks before doing a file copy
> > > >   *
> > > > @@ -1434,6 +1412,25 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
> > > >         loff_t size_in;
> > > >         int ret;
> > > >
> > > > +       /*
> > > > +        * Although we now allow filesystems to handle cross sb copy, passing
> > > > +        * a file of the wrong filesystem type to filesystem driver can result
> > > > +        * in an attempt to dereference the wrong type of ->private_data, so
> > > > +        * avoid doing that until we really have a good reason.  NFS defines
> > > > +        * several different file_system_type structures, but they all end up
> > > > +        * using the same ->copy_file_range() function pointer.
> > > > +        */
> > > > +       if (file_out->f_op->copy_file_range) {
> > > > +               if (file_in->f_op->copy_file_range !=
> > > > +                   file_out->f_op->copy_file_range)
> > > > +                       return -EXDEV;
> > > > +       } else if (file_in->f_op->remap_file_range) {
> > > > +               if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
> > > > +                       return -EXDEV;
> > > > +       } else {
> > > > +                return -EOPNOTSUPP;
> > > > +       }
> > > > +
> > > >         ret = generic_file_rw_checks(file_in, file_out);
> > > >         if (ret)
> > > >                 return ret;
> > > > @@ -1497,11 +1494,9 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
> > > >         if (unlikely(ret))
> > > >                 return ret;
> > > >
> > > > -       if (len == 0)
> > > > -               return 0;
> > >
> > > Can somebody please explain this change to me? Is this an attempt to
> > > support "whole" file copy?
> >
> > No, this was a bug reported in this thread:
> >
> > https://lore.kernel.org/linux-fsdevel/877dk1zibo.fsf@suse.de/
> >
> > (I'm also adding back Steve to the Cc: list.)
>
> Ok so this is a problem. As I mentioned a zero size copy means in NFS
> copy the whole file.  Current copy_file_range system doesn't have the
> same semantics. I don't expect the same semantics exist in other file
> systems but, if they do, then perhaps semantics of copy_file_range can
> be changed to reflect that.

That is not going to happen.

> If not, then I would like to put back the
> return 0 if len=0 somehow or you need to put it explicitly in all file
> systems (or at least in NFS).
>

Wow! We definitely need to put this check in nfs4_copy_file_range()
before it translates the system call to protocol command with
different semantics.

This change is needed regardless of Luis's patch, because nfs should
not rely on vfs to make that optimization and never pass 0 size copy to
filesystem method, so Olga, if Luis' patch does not go through, please
make that change in nfs.

Luis, please make a note about the zero size copy case in the commit
message (not only in change log) including a link to this conversation,
mentioning that the intention of the code is that a result of a CFR syscall
with zero size between two files should provide an indication of non-zero
CFR support between the same two files.

Thanks,
Amir.
