Return-Path: <linux-fsdevel+bounces-22221-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAED914292
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 08:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 198411C22A12
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 06:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82E222615;
	Mon, 24 Jun 2024 06:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="dQ9BR6as"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1164225D9;
	Mon, 24 Jun 2024 06:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719209688; cv=none; b=BCDSkad1t9VpPpO8fEHnAEQfZj6jru9UokItF4ZPJxVyxMV/d6N6IDAVXlKlPj1GQdpAcGQfnbl3u3TqB77A2/NnV8Igf+SUjeikV10oEy4i6CLyANce57Ok0YwQu6g+T6v3p5r5Or4pt/yOjkoAik3PPAMlfcYZcK6gmCFCfI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719209688; c=relaxed/simple;
	bh=pRGt+YpMPsKjwZfW86V837WN4JGPkKGnorvBXTL/O2g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TJsUk8aKDtPzhpBKSkCP/knB9+oPmUw0UxXznm8RQjDRHObd+n9AwdJTEAIA3DEfE2GdBMcAextzEVpMKL2aRAk7eDd7tNxo4B0GAkS3VtnH4HVRh0DBV1zDpPZbrBV/gNlher+gpFdt21luf3gVKT8hgGH/SrSsMc04eArXobA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=dQ9BR6as; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ew1xoLiUEpaRO/Rd2+BU3bX5mn9fF1xUB9iaO1b3Vho=; t=1719209684; x=1719814484; 
	b=dQ9BR6asAKMN2pqrPhzQT4pEo2OWxYr6vtX66xZ8kyycsc/u1IVh2RwUhv6K9mQu2KybYllWwPR
	PCpBe6uSEwnvDJqPCmaOBYlF/Ztg+NcI09GK2cXDHqG8CNAwK5I67wKXaXP/TrUEg5/LUkGitqz4M
	FjueDU0/MeYJV45J1ji5bCX8MAinSm/9TYjOFQ0PBLiQkOh+PDyJ8bs5CQNTG5C4I4J6TSLweF2Hg
	BpfnO/2K3VGc0NJHulI0qn5eGL55Com37tDttEiS+kaSFzLhuxmSkwwwlGJ5WZqthjQbNzk82CNhY
	nmUkL9vGte34g0uS6eVfqRFHRk58pTg/tcDA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1sLcyL-00000003SnY-21KD; Mon, 24 Jun 2024 08:14:37 +0200
Received: from dynamic-077-191-015-086.77.191.pool.telefonica.de ([77.191.15.86] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1sLcyL-00000002KF0-2nE0; Mon, 24 Jun 2024 08:14:37 +0200
Message-ID: <e0e373fa13636a403322fd0ba96915fd25dbbefa.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 09/15] sh: rework sync_file_range ABI
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org
Cc: Rich Felker <dalias@libc.org>, Andreas Larsson <andreas@gaisler.com>, 
 guoren <guoren@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 linux-s390@vger.kernel.org, Helge Deller <deller@gmx.de>,
 linux-sh@vger.kernel.org, "linux-csky@vger.kernel.org"
 <linux-csky@vger.kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
  Heiko Carstens <hca@linux.ibm.com>, "musl@lists.openwall.com"
 <musl@lists.openwall.com>, Nicholas Piggin <npiggin@gmail.com>, Alexander
 Viro <viro@zeniv.linux.org.uk>, LTP List <ltp@lists.linux.it>, Brian Cain
 <bcain@quicinc.com>, Christian Brauner <brauner@kernel.org>, Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>, Xi Ruoyao
 <libc-alpha@sourceware.org>, linux-parisc@vger.kernel.org,
 linux-mips@vger.kernel.org,  stable@vger.kernel.org,
 linux-hexagon@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, "David S . Miller" <davem@davemloft.net>
Date: Mon, 24 Jun 2024 08:14:36 +0200
In-Reply-To: <9d4ba5e5-bb7f-432e-9354-47cc84eaa9e1@app.fastmail.com>
References: <20240620162316.3674955-1-arnd@kernel.org>
	 <20240620162316.3674955-10-arnd@kernel.org>
	 <366548c1a0d9749e42c0d0c993414a353c9b0b02.camel@physik.fu-berlin.de>
	 <9d4ba5e5-bb7f-432e-9354-47cc84eaa9e1@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Arnd,

On Fri, 2024-06-21 at 11:41 +0200, Arnd Bergmann wrote:
> On Fri, Jun 21, 2024, at 10:44, John Paul Adrian Glaubitz wrote:
> > On Thu, 2024-06-20 at 18:23 +0200, Arnd Bergmann wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > >=20
> > > The unusual function calling conventions on superh ended up causing
> >                                               ^^^^^^
> >                                        It's spelled SuperH
>=20
> Fixed now.
>=20
> > > diff --git a/arch/sh/kernel/sys_sh32.c b/arch/sh/kernel/sys_sh32.c
> > > index 9dca568509a5..d5a4f7c697d8 100644
> > > --- a/arch/sh/kernel/sys_sh32.c
> > > +++ b/arch/sh/kernel/sys_sh32.c
> > > @@ -59,3 +59,14 @@ asmlinkage int sys_fadvise64_64_wrapper(int fd, u3=
2 offset0, u32 offset1,
> > >  				 (u64)len0 << 32 | len1, advice);
> > >  #endif
> > >  }
> > > +
> > > +/*
> > > + * swap the arguments the way that libc wants it instead of
> >=20
> > I think "swap the arguments to the order that libc wants them" would
> > be easier to understand here.
>=20
> Done

Thanks for the two improvements!

> > > diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/sys=
calls/syscall.tbl
> > > index bbf83a2db986..c55fd7696d40 100644
> > > --- a/arch/sh/kernel/syscalls/syscall.tbl
> > > +++ b/arch/sh/kernel/syscalls/syscall.tbl
> > > @@ -321,7 +321,7 @@
> > >  311	common	set_robust_list			sys_set_robust_list
> > >  312	common	get_robust_list			sys_get_robust_list
> > >  313	common	splice				sys_splice
> > > -314	common	sync_file_range			sys_sync_file_range
> > > +314	common	sync_file_range			sys_sh_sync_file_range6
> >                                                                  ^^^^^^=
=20
> > Why the suffix 6 here?
>=20
> In a later part of my cleanup, I'm consolidating all the
> copies of this function (arm64, mips, parisc, powerpc,
> s390, sh, sparc, x86) and picked the name
> sys_sync_file_range6() for common implementation.
>=20
> I end up with four entry points here, so the naming is a bit
> confusing:
>=20
> - sys_sync_file_range() is only used on 64-bit architectures,
>   on x32 and on mips-n32. This uses four arguments, including
>   two 64-bit wide ones.
>=20
> - sys_sync_file_range2() continues to be used on arm, powerpc,
>   xtensa and now on sh, hexagon and csky. I change the
>   implementation to take six 32-bit arguments, but the ABI
>   remains the same as before, with the flags before offset.
>=20
> - sys_sync_file_range6() is used for most other 32-bit ABIs:
>   arc, m68k, microblaze, nios2, openrisc, parisc, s390, sh, sparc
>   and x86. This also has six 32-bit arguments but in the
>   default order (fd, offset, nbytes, flags).
>=20
> - sys_sync_file_range7() is exclusive to mips-o32, this one
>   has an unused argument and is otherwise the same as
>   sys_sync_file_range6().
>=20
> My plan is to then have some infrastructure to ensure
> userspace tools (libc, strace, qemu, rust, ...) use the
> same calling conventions as the kernel. I'm doing the
> same thing for all other syscalls that have architecture
> specific calling conventions, so far I'm using
>=20
> fadvise64_64_7
> fanotify_mark6
> truncate3
> truncate4
> ftruncate3
> ftruncate4
> fallocate6
> pread5
> pread6
> pwrite5
> pwrite6
> preadv5
> preadv6
> pwritev5
> pwritev6
> sync_file_range6
> fadvise64_64_2
> fadvise64_64_6
> fadvise64_5
> fadvise64_6
> readahead4
> readahead5
>=20
> The last number here is usually the number of 32-bit
> arguments, except for fadvise64_64_2 that uses the
> same argument reordering trick as sync_file_range2.
>=20
> I'm not too happy with the naming but couldn't come up with
> anything clearer either, so let me know if you have any
> ideas there.

OK, gotcha. I thought the 6 suffix was for SH only. I'm fine
with the naming scheme.

> > >  315	common	tee				sys_tee
> > >  316	common	vmsplice			sys_vmsplice
> > >  317	common	move_pages			sys_move_pages
> > > @@ -395,6 +395,7 @@
> > >  385	common	pkey_alloc			sys_pkey_alloc
> > >  386	common	pkey_free			sys_pkey_free
> > >  387	common	rseq				sys_rseq
> > > +388	common	sync_file_range2		sys_sync_file_range2
> > >  # room for arch specific syscalls
> > >  393	common	semget				sys_semget
> > >  394	common	semctl				sys_semctl
> >=20
> > I wonder how you discovered this bug. Did you look up the calling=20
> > convention on SuperH
> > and compare the argument order for the sys_sync_file_range system call=
=20
> > documented there
> > with the order in the kernel?
>=20
> I had to categorize all architectures based on their calling
> conventions to see if 64-bit arguments need aligned pairs or
> not, so I wrote a set of simple C files that I compiled for
> all architectures to see in which cases they insert unused
> arguments or swap the order of the upper and lower halves.
>=20
> SuperH, parisc and s390 are each slightly different from all the
> others here, so I ended up reading the ELF psABI docs and/or
> the compiler sources to be sure.
> I also a lot of git history.

Great job, thanks for doing the extra work to verify the ABI.

> > Did you also check what order libc uses? I would expect libc on SuperH=
=20
> > misordering the
> > arguments as well unless I am missing something. Or do we know that the=
=20
> > code is actually
> > currently broken?
>=20
> Yes, I checked glibc, musl and uclibc-ng for all the cases in
> which the ABI made no sense, as well as to check that my analysis
> of the kernel sources matches the expectations of the libc.

OK, awesome.

Will you send a v2 so I can ack the updated version of the patch?

I'm also fine with the patch going through your tree, as I would
like to start with the changes for v6.11 this week.

Thanks,
Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

