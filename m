Return-Path: <linux-fsdevel+bounces-42609-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30742A44DD9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 21:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADB6A7AE4A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 20:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF98919E7F8;
	Tue, 25 Feb 2025 20:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCTyihQ/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308941448E3;
	Tue, 25 Feb 2025 20:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740515686; cv=none; b=F2p5tOjySuBqv/hN/G4l2YDNnrmnI0WymtaqX2Mt/TW4K+E/ad/4hWPECJ26fN/mE06jPlqCirBU6IHiEK4nMBcd2XqIQU+wdwKmhyFiC1djM8i6sFOXE8mp0ifMZsGHF6yh4ZLS73uvxzxI8vwL8LyVei3uwqp8W03Z0P1oUjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740515686; c=relaxed/simple;
	bh=BRDE49GDK1WZQtOVWzMxOTVjKgnZs4mLJeGOsJR4KcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ni1RrSHaKfp711JMMLwThXNesiPTzabJSRHR7R29m4FMdHRgAl5MnZB+9sJZL2r04gvYvRzXMXbqJAggNm0ms7qeJEW2PLEFquQJPTCCE9U8gS8knwIkZhz0+X+9uPQoKemH+L1FU9XTWw6sm9QuSkApA+2eXJrJ3B7/NL4QJ40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCTyihQ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A12C4CEDD;
	Tue, 25 Feb 2025 20:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740515685;
	bh=BRDE49GDK1WZQtOVWzMxOTVjKgnZs4mLJeGOsJR4KcY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GCTyihQ/b2fTjWjL/w3eMUhECoP7pQUVh6qE6TXIEJ1BjHjigwTdvaXZ8aa1oOZW9
	 oKgOEDdFkHlCFZJGO4qmPSlQfmqTMdR4q6AaRRkwLGJ3tn5IsA6CVTfZngMu04uwvU
	 USQQvX2Ui2Py5GmeTon0UPIp4jb3Kllog7qTR84ZVlGPWnNhBglvmgANXSDfz/nF8C
	 fe6Ei8S+wY4QXqwkmTNtltifZ28vYDexOBzcB6Jx/JDAMQqYWr6bIziStGJLhdUGBs
	 KFr35I0nEjHgGeGnYKE+sCz27ig69d53549TBv6xK6RZKoaFrkcXukrE4yB0TGFtgY
	 hJMWUKlbR87Lg==
Received: by pali.im (Postfix)
	id 5A20189B; Tue, 25 Feb 2025 21:34:32 +0100 (CET)
Date: Tue, 25 Feb 2025 21:34:32 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Amir Goldstein <amir73il@gmail.com>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Michal Simek <monstr@monstr.eu>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>,
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
	Linux-Arch <linux-arch@vger.kernel.org>, linux-xfs@vger.kernel.org,
	Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v3] fs: introduce getfsxattrat and setfsxattrat syscalls
Message-ID: <20250225203432.o2lxjbimka4jldrx@pali>
References: <20250211-xattrat-syscall-v3-1-a07d15f898b2@kernel.org>
 <20250221181135.GW21808@frogsfrogsfrogs>
 <CAOQ4uxgyYBFqkq6cQsso4LxJsPJ4uECOdskXmz-nmGhhV5BQWg@mail.gmail.com>
 <20250224-klinke-hochdekoriert-3f6be89005a8@brauner>
 <6b51ffa2-9d67-4466-865e-e703c1243352@app.fastmail.com>
 <20250225-strom-kopflos-32062347cd13@brauner>
 <3c860dc0-ba8d-4324-b286-c160b7d8d2c4@app.fastmail.com>
 <20250225-testfahrt-seilwinde-64e6f44c01ce@brauner>
 <20250225155926.GD6265@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225155926.GD6265@frogsfrogsfrogs>
User-Agent: NeoMutt/20180716

On Tuesday 25 February 2025 07:59:26 Darrick J. Wong wrote:
> On Tue, Feb 25, 2025 at 12:24:08PM +0100, Christian Brauner wrote:
> > On Tue, Feb 25, 2025 at 11:40:51AM +0100, Arnd Bergmann wrote:
> > > On Tue, Feb 25, 2025, at 11:22, Christian Brauner wrote:
> > > > On Tue, Feb 25, 2025 at 09:02:04AM +0100, Arnd Bergmann wrote:
> > > >> On Mon, Feb 24, 2025, at 12:32, Christian Brauner wrote:
> > > >> 
> > > >> The ioctl interface relies on the existing behavior, see
> > > >> 0a6eab8bd4e0 ("vfs: support FS_XFLAG_COWEXTSIZE and get/set of
> > > >> CoW extent size hint") for how it was previously extended
> > > >> with an optional flag/word. I think that is fine for the syscall
> > > >> as well, but should be properly documented since it is different
> > > >> from how most syscalls work.
> > > >
> > > > If we're doing a new system call I see no reason to limit us to a
> > > > pre-existing structure or structure layout.
> > > 
> > > Obviously we could create a new structure, but I also see no
> > > reason to do so. The existing ioctl interface was added in
> > > in 2002 as part of linux-2.5.35 with 16 bytes of padding, half
> > > of which have been used so far.
> > > 
> > > If this structure works for another 23 years before we run out
> > > of spare bytes, I think that's good enough. Building in an
> > > incompatible way to handle potential future contents would
> > > just make it harder to use for any userspace that wants to
> > > use the new syscalls but still needs a fallback to the
> > > ioctl version.
> > 
> > The fact that this structure has existed since the dawn of time doesn't
> > mean it needs to be retained when adding a completely new system call.
> > 
> > People won't mix both. They either switch to the new interface because
> > they want to get around the limitations of the old interface or they
> > keep using the old interface and the associated workarounds.
> > 
> > In another thread they keep arguing about new extensions for Windows
> > that are going to be added to the ioctl interface and how to make it fit
> > into this. That just shows that it's very hard to predict from the
> > amount of past changes how many future changes are going to happen. And
> > if an interface is easy to extend it might well invite new changes that
> > people didn't want to or couldn't make using the old interface.
> 
> Agreed, I don't think it's hard to enlarge struct fsxattr in the
> existing ioctl interface; either we figure out how to make the kernel
> fill out the "missing" bytes with an internal getfsxattr call, or we
> make it return some errno if we would be truncating real output due to
> struct size limits and leave a note in the manpage that "EL3HLT means
> use a bigger structure definition"
> 
> Then both interfaces can plod along for another 30 years. :)
> 
> --D

For Windows attributes, there are for sure needed new 11 bits for
attributes which can be both get and set, additional 4 bits for get-only
attributes, and plus there are 9 reserved bits (which Windows can start
using it and exporting over NTFS or SMB). And it is possible that
Windows can reuse some bits which were previously assigned for things
which today does not appear on NTFS.

I think that fsx_xflags does not have enough free bits for all these
attributes. So it would be really nice to design API/ABI in away which
can be extended for new fields.

Also another two points, for this new syscalls. I have not looked at the
current changes (I was added to CC just recently), but it would be nice:

1) If syscall API allows to operate on the symlink itself. This is
   because NTFS and also SMB symlink also contains attributes. ioctl
   interface currently does not support to get/set these symlink
   attributes.

2) If syscall API contains ability to just change subset of attributes.
   And provide an error reporting to userspace if userspace application
   is trying to set attribute which is not supported by the filesystem.
   This error reporting is needed for possible "cp -a" or possible
   "rsync" implementation which informs when some metadata cannot be
   backup/restored. There are more filesystems which supports only
   subset of attributes, this applies also for windows attributes.
   For example UDF fs supports only "hidden" attribute.

