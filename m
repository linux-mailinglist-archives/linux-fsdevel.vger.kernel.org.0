Return-Path: <linux-fsdevel+bounces-53579-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4EFAF03FC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 21:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F4A844591A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 19:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA6C283680;
	Tue,  1 Jul 2025 19:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GB4etYzy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113C313774D;
	Tue,  1 Jul 2025 19:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751398804; cv=none; b=oArsS/EXROll4EGdVjWo4Jn6L88k1Y+6hMyWgnNot1h+MlQxwG59zIjkmEbobHEA8f9KlMmdlxJd3N0jkhOb9UiHhqrxW3XOrxQ99OeMEAjhQrsovyxLltpPqbaCT/eLEVH57ocZfZxTxEh/C/Ih9Bxnjzpgh5vwnpWpgVP7xuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751398804; c=relaxed/simple;
	bh=P2caZe334Rdl+21mNw9S4lQ5Nz7oIHW5wOU0XL+c00o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h3xrO8jVoj11yzPIhTi2SgEeCto0JQH03v9S56ix1LZbL62e7s6I+2hxbWWcCqUSsNV/sUBnkcZgZMINTWcsiJt4zMp6/mLQUcnYRfdIsYyYOt8BXoL007b7ceIVM4lIEr+v4MZYorcJv/4sX3Ohi82UDpNDWKxDdONBwLU6nME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GB4etYzy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7734FC4CEEB;
	Tue,  1 Jul 2025 19:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751398803;
	bh=P2caZe334Rdl+21mNw9S4lQ5Nz7oIHW5wOU0XL+c00o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GB4etYzyzcqEhr4xdM+j6WcJRYpYEmZhlsUhRqN/glHIHGyAuykjgue/iNFjGYRLk
	 8PnF8yVXDHnmM8qtk4qA+ApUQxZYXVHpAG786Td6E4oxi5PRoNzD5pUgJF/mIlNSJN
	 0fz3OGyJyjT1FnkA/lB7UOBOYtPPF0ToiGs9o44kmTcf6mivw+vPI6maow9/O3FbpE
	 hCvzgoc+h8P44+Bqvv8Cg5lFe7RQ4+RxDTkHO2PnvuPE5sgp2XzBc226YRfdJxx2sg
	 lycQnYut6aVFTDdyfZqsUegmeEqkiccSXIGSIpTXsJlGtxYfAfxPgSsm7kS2qtnIF9
	 HSZECfCWs8y4w==
Date: Tue, 1 Jul 2025 12:40:02 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Andrey Albershteyn <aalbersh@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Paul Moore <paul@paul-moore.com>, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, selinux@vger.kernel.org,
	Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH v6 5/6] fs: prepare for extending file_get/setattr()
Message-ID: <20250701194002.GS10009@frogsfrogsfrogs>
References: <20250630-xattrat-syscall-v6-0-c4e3bc35227b@kernel.org>
 <20250630-xattrat-syscall-v6-5-c4e3bc35227b@kernel.org>
 <20250701183105.GP10009@frogsfrogsfrogs>
 <CAOQ4uxiCpGcZ7V8OqssP2xKsN0ZiAO7mQ_1Qt705BrcHeSPmBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxiCpGcZ7V8OqssP2xKsN0ZiAO7mQ_1Qt705BrcHeSPmBg@mail.gmail.com>

On Tue, Jul 01, 2025 at 09:27:38PM +0200, Amir Goldstein wrote:
> On Tue, Jul 1, 2025 at 8:31 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Mon, Jun 30, 2025 at 06:20:15PM +0200, Andrey Albershteyn wrote:
> > > From: Amir Goldstein <amir73il@gmail.com>
> > >
> > > We intend to add support for more xflags to selective filesystems and
> > > We cannot rely on copy_struct_from_user() to detect this extension.
> > >
> > > In preparation of extending the API, do not allow setting xflags unknown
> > > by this kernel version.
> > >
> > > Also do not pass the read-only flags and read-only field fsx_nextents to
> > > filesystem.
> > >
> > > These changes should not affect existing chattr programs that use the
> > > ioctl to get fsxattr before setting the new values.
> > >
> > > Link: https://lore.kernel.org/linux-fsdevel/20250216164029.20673-4-pali@kernel.org/
> > > Cc: Pali Rohár <pali@kernel.org>
> > > Cc: Andrey Albershteyn <aalbersh@redhat.com>
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> > > ---
> > >  fs/file_attr.c           |  8 +++++++-
> > >  include/linux/fileattr.h | 20 ++++++++++++++++++++
> > >  2 files changed, 27 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/fs/file_attr.c b/fs/file_attr.c
> > > index 4e85fa00c092..62f08872d4ad 100644
> > > --- a/fs/file_attr.c
> > > +++ b/fs/file_attr.c
> > > @@ -99,9 +99,10 @@ EXPORT_SYMBOL(vfs_fileattr_get);
> > >  int copy_fsxattr_to_user(const struct fileattr *fa, struct fsxattr __user *ufa)
> > >  {
> > >       struct fsxattr xfa;
> > > +     __u32 mask = FS_XFLAGS_MASK;
> > >
> > >       memset(&xfa, 0, sizeof(xfa));
> > > -     xfa.fsx_xflags = fa->fsx_xflags;
> > > +     xfa.fsx_xflags = fa->fsx_xflags & mask;
> >
> > I wonder, should it be an error if a filesystem sets an fsx_xflags bit
> > outside of FS_XFLAGS_MASK?  I guess that's one way to prevent
> > filesystems from overriding the VFS bits. ;)
> 
> I think Pali has a plan on how to ensure that later
> when the mask is provided via the API.
> 
> >
> > Though couldn't that be:
> >
> >         xfa.fsx_xflags = fa->fsx_xflags & FS_XFLAGS_MASK;
> >
> > instead?  And same below?
> >
> 
> Indeed. There is a reason for the var, because the next series
> by Pali will use a user provided mask, which defaults to FS_XFLAGS_MASK,
> so I left it this way.
> 
> I don't see a problem with it keeping as is, but if it bothers you
> I guess we can re-add the var later.

Nah, it doesn't bother me that much.

> > >       xfa.fsx_extsize = fa->fsx_extsize;
> > >       xfa.fsx_nextents = fa->fsx_nextents;
> > >       xfa.fsx_projid = fa->fsx_projid;
> > > @@ -118,11 +119,16 @@ static int copy_fsxattr_from_user(struct fileattr *fa,
> > >                                 struct fsxattr __user *ufa)
> > >  {
> > >       struct fsxattr xfa;
> > > +     __u32 mask = FS_XFLAGS_MASK;
> > >
> > >       if (copy_from_user(&xfa, ufa, sizeof(xfa)))
> > >               return -EFAULT;
> > >
> > > +     if (xfa.fsx_xflags & ~mask)
> > > +             return -EINVAL;
> >
> > I wonder if you want EOPNOTSUPP here?  We don't know how to support
> > unknown xflags.  OTOH if you all have beaten this to death while I was
> > out then don't start another round just for me. :P
> 
> We have beaten this API almost to death for sure ;)
> I don't remember if we discussed this specific aspect,
> but I am personally in favor of
> EOPNOTSUPP := the fs does not support the set/get operation
> EINVAL := some flags provided as value is invalid
> 
> For example, if the get API provides you with a mask of the
> valid flags that you can set, if you try to set flags outside of
> that mask you get EINVAL.
> 
> That's my interpretation, but I agree that EOPNOTSUPP can also
> make sense in this situation.

<nod> I think I'd rather EOPNOTSUPP for "bits are set that the kernel
doesn't recognize" and EINVAL (or maybe something else like
EPROTONOSUPPORT) for "fs driver will not let you change this bit".
At least for the syscall interface; we probably have to flatten that to
EOPNOTSUPP for both legacy ioctls.

--D

> Thanks,
> Amir.
> 

