Return-Path: <linux-fsdevel+bounces-45275-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F19A756C8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Mar 2025 15:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 973813AFBED
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Mar 2025 14:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16961D90C8;
	Sat, 29 Mar 2025 14:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkpEWTqn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAA9179A7
	for <linux-fsdevel@vger.kernel.org>; Sat, 29 Mar 2025 14:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743259475; cv=none; b=KpJzm4btwkylS6L9HF94UauUvYpQxCoXh3rcncYeKHrTU9DUNH09bf+NM3Fj0TU6vyQwIQF+0B8wvweB3LKbJfmJ+iYhg+DIpWCwFfbwtyWhfzcqWY+WuRq1mAyK9rlUuNH1JtVwbyPXHNvSkULS2+zBIH9C7Yb0C467aRZs6xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743259475; c=relaxed/simple;
	bh=7hkQevDkInnk0+3JT8nJKnSfAuwwXYVzvC8aG2wIgdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ja/NcgwCi4am//MTgSuPQGOdxaqBHunX8hp+rPQsEp0TxrftrwoyRjvFKdbtBFhAAi6SL9nRndTJkoIMZzxeELCBs0CzQmpPWLtZuxf5H20yXX5XB+JZXMv8IPF0EI1smB8Innw93tbvbIs87gM5SU9aHMOSoaTrU2fdsINltQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkpEWTqn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC12C4CEE2;
	Sat, 29 Mar 2025 14:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743259474;
	bh=7hkQevDkInnk0+3JT8nJKnSfAuwwXYVzvC8aG2wIgdY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dkpEWTqnsxv2wl0nPaShh4wyXW4SsuohWjN1uVZogqn4foMFiQbXAG+6jkddjS5E8
	 GkiKX3jSlGNQ/p9dWy8JWdqrdU4v71b6oWSPVPTAHs7ifGFB0NT6Df6TLNoDR/oDMF
	 bBHbSW5E7ECkiOKgTCv2E8NXhDj0C0d/iRyxW6MADQ92OOM+msmIigBNVQXYZ2Ne4w
	 y3i/RbBcySYa+5EfpumRl/kZejyrptS73U9uFNh231ZQNO6jQ8AxIA4AzhJHGkZnly
	 BOxwiewXAPyqImyCxsP3VSIjcuwDM8wRDthgKy2EESDd3CUO8zON8nbFKJSza3QhyU
	 QOR7+neZgWwuw==
Received: by pali.im (Postfix)
	id 29EF0B12; Sat, 29 Mar 2025 15:44:19 +0100 (CET)
Date: Sat, 29 Mar 2025 15:44:19 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Andrey Albershteyn <aalbersh@redhat.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] fs: add support for custom fsx_xflags_mask
Message-ID: <20250329144419.sgrp5wet5uwmtul3@pali>
References: <20250329143312.1350603-1-amir73il@gmail.com>
 <20250329143312.1350603-3-amir73il@gmail.com>
 <CAOQ4uxhf6WPN-MCFy125Ot6fCGM4vTyh25zYC2+4srtOBA_HUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhf6WPN-MCFy125Ot6fCGM4vTyh25zYC2+4srtOBA_HUg@mail.gmail.com>
User-Agent: NeoMutt/20180716

On Saturday 29 March 2025 15:43:06 Amir Goldstein wrote:
> On Sat, Mar 29, 2025 at 3:33 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > With getfsxattrat() syscall, filesystem may use this field to report
> > its supported xflags.  Zero mask value means that supported flags are
> > not advertized.
> >
> > With setfsxattrat() syscall, userspace may use this field to declare
> > which xflags and fields are being set.  Zero mask value means that
> > all known xflags and fields are being set.
> >
> > Programs that call getfsxattrat() to fill struct fsxattr before calling
> > setfsxattrat() will not be affected by this change, but it allows
> > programs that call setfsxattrat() without calling getfsxattrat() to make
> > changes to some xflags and fields without knowing or changing the values
> > of unrelated xflags and fields.
> >
> > Link: https://lore.kernel.org/linux-fsdevel/20250216164029.20673-4-pali@kernel.org/
> > Cc: Pali Rohár <pali@kernel.org>
> > Cc: Andrey Albershteyn <aalbersh@redhat.com>
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  fs/ioctl.c               | 35 +++++++++++++++++++++++++++++------
> >  include/linux/fileattr.h |  1 +
> >  include/uapi/linux/fs.h  |  3 ++-
> >  3 files changed, 32 insertions(+), 7 deletions(-)
> >
> > diff --git a/fs/ioctl.c b/fs/ioctl.c
> > index b19858db4c432..a4838b3e7de90 100644
> > --- a/fs/ioctl.c
> > +++ b/fs/ioctl.c
> > @@ -540,10 +540,13 @@ EXPORT_SYMBOL(vfs_fileattr_get);
> >
> >  void fileattr_to_fsxattr(const struct fileattr *fa, struct fsxattr *fsx)
> >  {
> > -       __u32 mask = FS_XFALGS_MASK;
> > +       /* Filesystem may or may not advertize supported xflags */
> > +       __u32 fs_mask = fa->fsx_xflags_mask & FS_XFALGS_MASK;
> > +       __u32 mask = fs_mask ?: FS_XFALGS_MASK;
> >
> >         memset(fsx, 0, sizeof(struct fsxattr));
> >         fsx->fsx_xflags = fa->fsx_xflags & mask;
> > +       fsx->fsx_xflags_mask = fs_mask;
> >         fsx->fsx_extsize = fa->fsx_extsize;
> >         fsx->fsx_nextents = fa->fsx_nextents;
> >         fsx->fsx_projid = fa->fsx_projid;
> > @@ -562,6 +565,8 @@ int copy_fsxattr_to_user(const struct fileattr *fa, struct fsxattr __user *ufa)
> >         struct fsxattr xfa;
> >
> >         fileattr_to_fsxattr(fa, &xfa);
> > +       /* FS_IOC_FSGETXATTR ioctl does not report supported fsx_xflags_mask */
> > +       xfa.fsx_xflags_mask = 0;
> >
> >         if (copy_to_user(ufa, &xfa, sizeof(xfa)))
> >                 return -EFAULT;
> > @@ -572,16 +577,30 @@ EXPORT_SYMBOL(copy_fsxattr_to_user);
> >
> >  int fsxattr_to_fileattr(const struct fsxattr *fsx, struct fileattr *fa)
> >  {
> > -       __u32 mask = FS_XFALGS_MASK;
> > +       /* User may or may not provide custom xflags mask */
> > +       __u32 mask = fsx->fsx_xflags_mask ?: FS_XFALGS_MASK;
> >
> > -       if (fsx->fsx_xflags & ~mask)
> > +       if ((fsx->fsx_xflags & ~mask) || (mask & ~FS_XFALGS_MASK))
> >                 return -EINVAL;
> >
> >         fileattr_fill_xflags(fa, fsx->fsx_xflags);
> >         fa->fsx_xflags &= ~FS_XFLAG_RDONLY_MASK;
> > -       fa->fsx_extsize = fsx->fsx_extsize;
> > -       fa->fsx_projid = fsx->fsx_projid;
> > -       fa->fsx_cowextsize = fsx->fsx_cowextsize;
> > +       fa->fsx_xflags_mask = fsx->fsx_xflags_mask;
> > +       /*
> > +        * If flags mask is specified, we copy the fields value only if the
> > +        * relevant flag is set in the mask.
> > +        */
> > +       if (!mask || (mask & (FS_XFLAG_EXTSIZE | FS_XFLAG_EXTSZINHERIT)))
> > +               fa->fsx_extsize = fsx->fsx_extsize;
> > +       if (!mask || (mask & FS_XFLAG_COWEXTSIZE))
> > +               fa->fsx_cowextsize = fsx->fsx_cowextsize;
> > +       /*
> > +        * To save a mask flag (i.e. FS_XFLAG_PROJID), require setting values
> > +        * of fsx_projid and FS_XFLAG_PROJINHERIT flag values together.
> > +        * For a non-directory, FS_XFLAG_PROJINHERIT flag value should be 0.
> > +        */
> > +       if (!mask || (mask & FS_XFLAG_PROJINHERIT))
> > +               fa->fsx_projid = fsx->fsx_projid;
> 
> Sorry, I ended up initializing the mask without a user provided mask
> to FS_XFALGS_MASK, so these (!mask ||) conditions are not needed.
> 
> Thanks,
> Amir.

And there is a typo: FS_XFLAGS_MASK

