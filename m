Return-Path: <linux-fsdevel+bounces-42564-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 200DFA43BA3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 11:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F2DF174407
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 10:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C830268683;
	Tue, 25 Feb 2025 10:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLdVe9QX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B46E267F6E;
	Tue, 25 Feb 2025 10:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740478953; cv=none; b=gU0X2jbBotf4O+UZXRoLT3r+wW2ChV/PIDX5L1bsgNUqHh9pS0FBb2fdQm1Ut+IcH/g9KdZ1Ojpp5M27TJEDAqeefjKjUVx8OILKnhCfNQmpsNte42effAhP+ajLNQ9CHSlpGmYHbSM74GDaE85ZDCeGSCc7DHVk5XgRDgvj2qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740478953; c=relaxed/simple;
	bh=5HOkE2YqQG0nj7GKm31VM9cru6617nBuKvCY1GMnDrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EUneP6Ybxe55qtdPa+mxyT/qeIJfev0wzLKS9rqATdj9W+JG282UM7GCxIofyR1HmFgu3qpQSpjQRN48RCvnpdqe6D6knpmjC7M/BXFgB+B1N22pu7iZr1sVfbAvhhNNvV5qnuAWUrAw7MZti12Vuzt0946DiVhtyPiKb99hkYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLdVe9QX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F22EC4CEDD;
	Tue, 25 Feb 2025 10:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740478952;
	bh=5HOkE2YqQG0nj7GKm31VM9cru6617nBuKvCY1GMnDrc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QLdVe9QX36ZATBZopGaFS7xncV75FrVifGUmO8YFcq0fsqRsaJ22u5r4/RZQOJ3Sp
	 yMEl/oKfTZihFmWVtEKikhl/HfJsgdlkCrNq55W9eyV/njTytIaMD9k7zFgv1x4TaI
	 I2IADYz/CQiWBy3kUYdqd4/6a+d9wa1OJ63tEswPaPSmhJ9mvyvjSLPOfrMnC+lJSK
	 LaosnjwljP1fU1QllOJcPmhDfG/AbY9BKKl5qhnGon0GvGM+IMN1WKFPOeumOwG/Tb
	 8wfL7+oJ4DopnrX8olKXaLI8joRoQgVk7Ykgfi+0FSJvIaTDPVShiCTVbRLd3HNrPp
	 6XmUqt0gTmi9g==
Date: Tue, 25 Feb 2025 11:22:17 +0100
From: Christian Brauner <brauner@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Amir Goldstein <amir73il@gmail.com>, 
	Andrey Albershteyn <aalbersh@redhat.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "David S . Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-api@vger.kernel.org, 
	Linux-Arch <linux-arch@vger.kernel.org>, linux-xfs@vger.kernel.org, 
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v3] fs: introduce getfsxattrat and setfsxattrat syscalls
Message-ID: <20250225-strom-kopflos-32062347cd13@brauner>
References: <20250211-xattrat-syscall-v3-1-a07d15f898b2@kernel.org>
 <20250221181135.GW21808@frogsfrogsfrogs>
 <CAOQ4uxgyYBFqkq6cQsso4LxJsPJ4uECOdskXmz-nmGhhV5BQWg@mail.gmail.com>
 <20250224-klinke-hochdekoriert-3f6be89005a8@brauner>
 <6b51ffa2-9d67-4466-865e-e703c1243352@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6b51ffa2-9d67-4466-865e-e703c1243352@app.fastmail.com>

On Tue, Feb 25, 2025 at 09:02:04AM +0100, Arnd Bergmann wrote:
> On Mon, Feb 24, 2025, at 12:32, Christian Brauner wrote:
> > On Fri, Feb 21, 2025 at 08:15:24PM +0100, Amir Goldstein wrote:
> >> On Fri, Feb 21, 2025 at 7:13 PM Darrick J. Wong <djwong@kernel.org> wrote:
> 
> >> > > @@ -23,6 +23,9 @@
> >> > >  #include <linux/rw_hint.h>
> >> > >  #include <linux/seq_file.h>
> >> > >  #include <linux/debugfs.h>
> >> > > +#include <linux/syscalls.h>
> >> > > +#include <linux/fileattr.h>
> >> > > +#include <linux/namei.h>
> >> > >  #include <trace/events/writeback.h>
> >> > >  #define CREATE_TRACE_POINTS
> >> > >  #include <trace/events/timestamp.h>
> >> > > @@ -2953,3 +2956,75 @@ umode_t mode_strip_sgid(struct mnt_idmap *idmap,
> >> > >       return mode & ~S_ISGID;
> >> > >  }
> >> > >  EXPORT_SYMBOL(mode_strip_sgid);
> >> > > +
> >> > > +SYSCALL_DEFINE4(getfsxattrat, int, dfd, const char __user *, filename,
> >> > > +             struct fsxattr __user *, fsx, unsigned int, at_flags)
> >> >
> >> > Should the kernel require userspace to pass the size of the fsx buffer?
> >> > That way we avoid needing to rev the interface when we decide to grow
> >> > the structure.
> >
> > Please version the struct by size as we do for clone3(),
> > mount_setattr(), listmount()'s struct mnt_id_req, sched_setattr(), all
> > the new xattrat*() system calls and a host of others. So laying out the
> > struct 64bit and passing a size alongside it.
> >
> > This is all handled by copy_struct_from_user() and copy_struct_to_user()
> > so nothing to reinvent. And it's easy to copy from existing system
> > calls.
> 
> I don't think that works in this case, because 'struct fsxattr'
> is an existing structure that is defined with a fixed size of
> 28 bytes. If we ever need more than 8 extra bytes, then the
> existing ioctl commands are also broken.
> 
> Replacing fsxattr with an extensible structure of the same contents
> would work, but I feel that just adds more complication for little
> gain.
> 
> On the other hand, there is an open question about how unknown
> flags and fields in this structure. FS_IOC_FSSETXATTR/FS_IOC_FSGETXATTR
> treats them as optional and just ignores anything it doesn't
> understand, while copy_struct_from_user() would treat any unknown
> but set bytes as -E2BIG.
> 
> The ioctl interface relies on the existing behavior, see
> 0a6eab8bd4e0 ("vfs: support FS_XFLAG_COWEXTSIZE and get/set of
> CoW extent size hint") for how it was previously extended
> with an optional flag/word. I think that is fine for the syscall
> as well, but should be properly documented since it is different
> from how most syscalls work.

If we're doing a new system call I see no reason to limit us to a
pre-existing structure or structure layout.

