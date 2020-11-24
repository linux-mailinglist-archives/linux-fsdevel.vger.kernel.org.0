Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3C62C1FE4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 09:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730474AbgKXI2V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 03:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728890AbgKXI2U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 03:28:20 -0500
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C330C0613CF
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2020 00:28:19 -0800 (PST)
Received: by mail-vs1-xe43.google.com with SMTP id f7so10639781vsh.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2020 00:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ToEaxtUbw69LyRlwYIrQ/t78YuNKL4Iflv4hoOcV4MA=;
        b=L+lurf/KDoDNOwGPT0NXZE1v3q+TvUKjwODsT2BCxel3dfOkwphdadtVuoXwOiuAqV
         d+Us05REk1LiZDIurxcsh8oIaVit/65hsfpaSifi0JRhFn+9dPNWK5KIcLs6xANd9FOV
         x7wSfH23rsIMS7Ojmwz+GGoi4EeCmoxNA+pIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ToEaxtUbw69LyRlwYIrQ/t78YuNKL4Iflv4hoOcV4MA=;
        b=lneE8nEv3xYfKGjaKcMZZx/0CmqU81qc2wTSd/hJbAl3uzkER6nkEH8L5h/0va1rHC
         I98SbZ0ThGyAR5bHLvu9s2aeI7zx7kd3PuX4qQiloClV6axZT9cqO8oTb5uLk+ckEZiY
         +k6SZm6GGpfHaw+H+pNH2ruO3jr35pdBpNN18WoDEwoeHyq6iLoi1nYLpG3OqCXZB/Zz
         NDCTYJIhnq516fgGQmJISqvS68iskqzhr4AwEhL7lsZpAbDTYPXoWxobFkNQEVaJbJS5
         vKv4s+9gsqWReJeaouyJ1kvf8SeVsI0Xe9CxyGVsdoXq6mg5EAqWVdRYsUtYQALIpkEz
         uueQ==
X-Gm-Message-State: AOAM533l7u86w0Fb5kJSsljk3JMK/a3q7JEe44UGJvRYJPiT/y4sH60j
        ENR6iR1aCOUt0CXcayOEHm9yDMuIeNWQK3LAUUhp+rPY+4zSBA==
X-Google-Smtp-Source: ABdhPJwqSML4Dbb0A/GAWrxziESe2yVTRusngtzXd6EphJ9wC6astmA7DFCY8bz9Q7HZnOoMrOcWagpQfD7C4oCP550=
X-Received: by 2002:a05:6102:126c:: with SMTP id q12mr2925963vsg.9.1606206498638;
 Tue, 24 Nov 2020 00:28:18 -0800 (PST)
MIME-Version: 1.0
References: <20201123141207.GC327006@miu.piliscsaba.redhat.com> <8728CF2B-8460-43FC-BED1-A46ADB1E8838@dilger.ca>
In-Reply-To: <8728CF2B-8460-43FC-BED1-A46ADB1E8838@dilger.ca>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 24 Nov 2020 09:28:07 +0100
Message-ID: <CAJfpeguc3uAoPzAv_cggZr4a-3cX_DV6ofQ4hjMxDnSfBDwYEw@mail.gmail.com>
Subject: Re: [RFC PATCH] vfs: fs{set,get}attr iops
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-fsdevel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 23, 2020 at 10:06 PM Andreas Dilger <adilger@dilger.ca> wrote:
>
> On Nov 23, 2020, at 7:12 AM, Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > Dmitry found an issue with overlayfs's FS_IOC_SETFLAGS/FS_IOC_FSSETXATTR
> > implementation:
> >
> >  https://lore.kernel.org/linux-unionfs/CACT4Y+bUfavwMVv2SEMve5pabE_AwsDO0YsRBGZtYqX59a77vA@mail.gmail.com/
> >
> > I think the only proper soltuion is to move these into inode operations, which
> > should be a good cleanup as well.
> >
> > This is a first cut, the FS_IOC_SETFLAGS conversion is not complete, and only
> > lightly tested on ext4 and xfs.
> >
> > There are minor changes in behavior, like the exact errno value in case of
> > multiple error conditions.
> >
> > 34 files changed, 668 insertions(+), 1170 deletions(-)
>
>
> Hi Miklos,
> this looks like a good reduction in code duplication (-500 LOC is nice).
>
> One issues I have with this patch is that it spreads the use of "fsxattr"
> asthe name for these inode flags further into the VFS.  That was inherited
> from XFS because of the ioctl name, but is very confusing with "real"
> extended attributes, also using get/setxattr names but totally differently.
>
> It would be better to use function/variable names with "xflags" and "iflags"
> that are already used in several filesystems to separate this from xattrs.

Makes sense.

>
> It wouldn't be terrible to also rename the ioctl to FS_IOC_FSSETXFLAGS and
> keep a #define for FS_IOC_FSSETXATTR for compatibility, but that is less
> critical if that is now only used in one place in the code.
>
> Some more comments inline...
>
> > --- a/fs/ioctl.c
> > +++ b/fs/ioctl.c
> > +/*
> > + * Generic function to check FS_IOC_FSSETXATTR/FS_IOC_SETFLAGS values and reject
> > + * any invalid configurations.
> > + *
> > + * Note: must be called with inode lock held.
> > + */
> > +static int fssetxattr_prepare(struct inode *inode,
> > +                           const struct kfsxattr *old_fa,
> > +                           struct kfsxattr *fa)
>
> > +{
> > +       /*
> > +        * The IMMUTABLE and APPEND_ONLY flags can only be changed by
> > +        * the relevant capability.
> > +     */
> > +     if ((fa->fsx_flags ^ old_fa->fsx_flags) & (FS_APPEND_FL | FS_IMMUTABLE_FL) &&
> > +         !capable(CAP_LINUX_IMMUTABLE))
> > +             return -EPERM;
> > +
> > +     if (fa->flags_valid)
> > +             return fscrypt_prepare_setflags(inode, old_fa->fsx_flags, fa->fsx_flags);
>
> This doesn't seem right?  It means if iflags are set, the rest of the checks are
> skipped *even if* there are no problems with the fscrypt flags?  That bypasses
> the DAX and PROJINHERIT checks later in this function, but it is also possible to
> set/clear those flags via FS_IOC_SETFLAGS, and is not very obvious for the code
> flow.  I'd think this should be something more like:

>
>         if (IS_ENCRYPTED(inode) && fa->flags_valid) {
>                 rc = fscrypt_prepare_setflags(...);
>                 if (rc)
>                         return rc;
>         }
>
> and continue on to the rest of the checks, and maybe skip the xflags-specific
> checks (EXTSIZE, EXTSZINHERIT, COWEXTSIZE) if xflags_valid is not set, though
> they would just be no-ops in that case since the iflags interface will not
> set those flags.
>
> Alternately, move the DAX and PROJINHERIT checks above "flags_valid", but add
> a comment that the remaining checks are only for xflags-specific values.

Good point.   I wasn't actually looking at the code, just converting
the old one to the new, and apparently the DAX and PROJINHERIT checks
were missing for the FS_IOC_SETFLAGS case (see
vfs_ioc_setflags_prepare).

> > +int vfs_fssetxattr(struct dentry *dentry, struct kfsxattr *fa)
> > +{
> > +     struct inode *inode = d_inode(dentry);
> > +     struct kfsxattr old_fa;
> > +     int err;
> > +
> > +     if (d_is_special(dentry))
> > +             return -ENOTTY;
> > +
> > +     if (!inode->i_op->fssetxattr)
> > +             return -ENOIOCTLCMD;
> > +
> > +     if (!inode_owner_or_capable(inode))
> > +             return -EPERM;
> > +
> > +     inode_lock(inode);
> > +     err = vfs_fsgetxattr(dentry, &old_fa);
> > +     if (!err) {
> > +             /* initialize missing bits from old_fa */
> > +             if (fa->flags_valid) {
> > +                     fa->fsx_xflags |= old_fa.fsx_xflags & ~FS_XFLAG_COMMON;
> > +                     fa->fsx_extsize = old_fa.fsx_extsize;
> > +                     fa->fsx_nextents = old_fa.fsx_nextents;
> > +                     fa->fsx_projid = old_fa.fsx_projid;
> > +                     fa->fsx_cowextsize = old_fa.fsx_cowextsize;
> > +             } else {
> > +                     fa->fsx_flags |= old_fa.fsx_flags & ~FS_COMMON_FL;
> > +             }
>
> This extra call to vfs_fsgetxattr() is adding pure overhead for the case of
> FS_IOC_GETFLAGS and is totally unnecessary.  If iflags_valid is set, then
> none of these other fields should be accessed in the ->fssetxattr() method,
> and they can check for iflags_valid vs. xflags_valid themselves to see which
> ioctl is being called and only access fields which are valid.

The extra call is needed for fssetxattr_prepare() for the the checks
anyway.   Filling in the other fields is a bonus that makes fs code
simpler in some cases (e.g. xfs which mainly just looks at xflags).

Also ->fsgetxattr() is cheap for all filesystems (and this syscall
shouldn't be performance sensitive anyway) so I don't see why we'd
need to optimize this at all.

Thanks,
Miklos
