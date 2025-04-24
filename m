Return-Path: <linux-fsdevel+bounces-47215-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E9DA9A764
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 11:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19B23188393E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 09:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBC221CC6C;
	Thu, 24 Apr 2025 09:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qPzQ2EtO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FED1210F5A;
	Thu, 24 Apr 2025 09:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745485582; cv=none; b=DVkg+p5KTiuu7hbo0J270jYBlHaaA5sQLXR2MSAqbbf+iPojEN1KXE5nz2m0KdlloqR3Az+1k9+n50cVr/PwRqHvIRZ1RbYGsAH3fm04jJxyDspoNijz+7xs78TCwjS2U1CfuvyqGHDmGgHf0RGHKchBbReRSXp1ioPk0m54Q/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745485582; c=relaxed/simple;
	bh=g6bxeBGFz+ZfAiISf78nYF5d6OuqVi+zKYMYmkzuYww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HK3T3zdIGDpGO/TCXAxWRf0iQ/zar0OLW4YFttAblOUqXirChYvfmI8uemjkoQnmB6Vb3JnpDDLRlHt/MQVAv4OdHrWLF9sIeVyQmLcJCpCAkh54AH3oLhumaQtjEc8H20yVMyUPIJyfy3E+2mYHzKTMOazaBeYbpRqxd4/g8Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qPzQ2EtO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF029C4CEEB;
	Thu, 24 Apr 2025 09:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745485581;
	bh=g6bxeBGFz+ZfAiISf78nYF5d6OuqVi+zKYMYmkzuYww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qPzQ2EtOhRHjvqeIqmfEs41n41+fPOpo5wVb0WXRA0Y64JK63Z0piOH/6q1TuKDwD
	 WTI9c9BorspnKyVAu3DQkYsACDPHLJTqVVPTN6kTMVKEScUaCBv3GdtHESuUO5NqC6
	 pqjqzGFZkOK5FpMLm1+UNv77/mYGep1Zag5d47x0b6vZpoHTEkoNH1VrlBp4U0AaKU
	 qsF/Vn2vnRvvp1Kn7/YXcOkrtYa0w4Ynlqq5gkE0B8hjxnGwh/iyaywzNfxrIZA9z+
	 2pzSBGKxX+TFKn8wOJih4WXcFzFXNu3Sjb1AkS/krSZea9kudjKkOe+16Pk7titbWK
	 ch3/3zyDdzWnA==
Date: Thu, 24 Apr 2025 11:06:07 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Andrey Albershteyn <aalbersh@redhat.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH v4 3/3] fs: introduce getfsxattrat and setfsxattrat
 syscalls
Message-ID: <20250424-zuspielen-luxus-3d49b600c3bf@brauner>
References: <20250321-xattrat-syscall-v4-0-3e82e6fb3264@kernel.org>
 <20250321-xattrat-syscall-v4-3-3e82e6fb3264@kernel.org>
 <20250422-abbekommen-begierde-bcf48dd74a2e@brauner>
 <rbzlwvecvrp4xawwp5nywdq6wp5hgjhrtrabpszv74xmfqbj4f@x7v6eqfc5gcd>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <rbzlwvecvrp4xawwp5nywdq6wp5hgjhrtrabpszv74xmfqbj4f@x7v6eqfc5gcd>

On Wed, Apr 23, 2025 at 11:53:25AM +0200, Jan Kara wrote:
> On Tue 22-04-25 16:59:02, Christian Brauner wrote:
> > On Fri, Mar 21, 2025 at 08:48:42PM +0100, Andrey Albershteyn wrote:
> > > From: Andrey Albershteyn <aalbersh@redhat.com>
> > > 
> > > Introduce getfsxattrat and setfsxattrat syscalls to manipulate inode
> > > extended attributes/flags. The syscalls take parent directory fd and
> > > path to the child together with struct fsxattr.
> > > 
> > > This is an alternative to FS_IOC_FSSETXATTR ioctl with a difference
> > > that file don't need to be open as we can reference it with a path
> > > instead of fd. By having this we can manipulated inode extended
> > > attributes not only on regular files but also on special ones. This
> > > is not possible with FS_IOC_FSSETXATTR ioctl as with special files
> > > we can not call ioctl() directly on the filesystem inode using fd.
> > > 
> > > This patch adds two new syscalls which allows userspace to get/set
> > > extended inode attributes on special files by using parent directory
> > > and a path - *at() like syscall.
> > > 
> > > CC: linux-api@vger.kernel.org
> > > CC: linux-fsdevel@vger.kernel.org
> > > CC: linux-xfs@vger.kernel.org
> > > Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> > > Acked-by: Arnd Bergmann <arnd@arndb.de>
> ...
> > > +		struct fsxattr __user *, ufsx, size_t, usize,
> > > +		unsigned int, at_flags)
> > > +{
> > > +	struct fileattr fa = {};
> > > +	struct path filepath;
> > > +	int error;
> > > +	unsigned int lookup_flags = 0;
> > > +	struct filename *name;
> > > +	struct fsxattr fsx = {};
> > > +
> > > +	BUILD_BUG_ON(sizeof(struct fsxattr) < FSXATTR_SIZE_VER0);
> > > +	BUILD_BUG_ON(sizeof(struct fsxattr) != FSXATTR_SIZE_LATEST);
> > > +
> > > +	if ((at_flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)) != 0)
> > > +		return -EINVAL;
> > > +
> > > +	if (!(at_flags & AT_SYMLINK_NOFOLLOW))
> > > +		lookup_flags |= LOOKUP_FOLLOW;
> > > +
> > > +	if (at_flags & AT_EMPTY_PATH)
> > > +		lookup_flags |= LOOKUP_EMPTY;
> > > +
> > > +	if (usize > PAGE_SIZE)
> > > +		return -E2BIG;
> > > +
> > > +	if (usize < FSXATTR_SIZE_VER0)
> > > +		return -EINVAL;
> > > +
> > > +	name = getname_maybe_null(filename, at_flags);
> > > +	if (!name) {
> > 
> > This is broken as it doesn't handle AT_FDCWD correctly. You need:
> > 
> >         name = getname_maybe_null(filename, at_flags);
> >         if (IS_ERR(name))
> >                 return PTR_ERR(name);
> > 
> >         if (!name && dfd >= 0) {
> > 		CLASS(fd, f)(dfd);
> 
> Ah, you're indeed right that if dfd == AT_FDCWD and filename == NULL, the
> we should operate on cwd but we'd bail with error here. I've missed that
> during my review. But as far as I've checked the same bug is there in
> path_setxattrat() and path_getxattrat() so we should fix this there as
> well?

Yes, please!

