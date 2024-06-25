Return-Path: <linux-fsdevel+bounces-22293-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B157F915EB7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 08:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D62A31C21A3F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 06:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5E7145FF1;
	Tue, 25 Jun 2024 06:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="kMKIkUXC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAEE1B806;
	Tue, 25 Jun 2024 06:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719295934; cv=none; b=oony8bf1leb2i0a+rNk6DQBSKtXGz5DNI6IYKC2ur6Z0/jWqci1KKN5JPWas++U85XX9rmVPepcek2j2AmnaHe8cN4yYTlriplgQJwJ8yat6h5Uul+K2Rb+kyl2n954h0/hzHOkvXqCxJGAfqD5TUzISTEMLygF8IyIFn00caSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719295934; c=relaxed/simple;
	bh=A9l5QJ5wVUxN0j1TWgVqhhHFCdASWZMj33PGqLt6VA0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b4nabD8O1g8vM98AvMhvOhz9h+88q3ljAqTLSNGcMKUVfZvwrT25sAMFwvZwokWMEEwu5NHB8R3oMFQUWmMg+4WqsLCLCEn3ELvLin/syKK1hX3DLGjwCByhaavGQqf0BCBl/tyofMvFe5XU4qFkW5Z2uOzpZxy5SDfGe8tRDLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=kMKIkUXC; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=QR3y2Y/czPDzz8uhrOTX+qZKGKnv9qtlOLRYnVuIPwY=; t=1719295930; x=1719900730; 
	b=kMKIkUXCpW4k/lh4bfIHLQJ7yXaQaua42W5My0YpiNHiilmaG69pdb5IiE9StEvH36UYTlg2wfF
	Tdb/CPgfLOpILqYOWYZS7k0EvxHiB4Yz6K+AIaa5OtXhE9YR5RjGJ4STuCmmYTd8HRVm+pACcRawL
	EVS4LdZZkx88lnlVGO7hwGqOdh0gF+Kg22Ipn2MdidppsNRFw/yqNvlnXtamDkZEYlONN/1b8Vl0s
	oPBAMYWW7go097qgb9r16qmHKOvCsm2PLjS56KL1M/z+bU8T/eKUNkYZNAKl9ItLFseIrud1TmZ9t
	Ci3ZLg7RBgLYlLuJny8/YueTY14197NeyvAA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1sLzPJ-00000002pcY-2WGY; Tue, 25 Jun 2024 08:11:58 +0200
Received: from p5b13a475.dip0.t-ipconnect.de ([91.19.164.117] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1sLzPJ-00000001jTk-3HF5; Tue, 25 Jun 2024 08:11:57 +0200
Message-ID: <b7e20a2dbf5bad8cae0227644b2f78531dd6ef5a.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2 08/13] sh: rework sync_file_range ABI
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Arnd Bergmann <arnd@kernel.org>, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Thomas Bogendoerfer
 <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org, Helge Deller
 <deller@gmx.de>, linux-parisc@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
 sparclinux@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Nicholas
 Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Brian Cain <bcain@quicinc.com>,
 linux-hexagon@vger.kernel.org, Guo Ren <guoren@kernel.org>, 
 linux-csky@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, 
 linux-s390@vger.kernel.org, Rich Felker <dalias@libc.org>, 
 linux-sh@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
 linux-fsdevel@vger.kernel.org, libc-alpha@sourceware.org, 
 musl@lists.openwall.com, stable@vger.kernel.org
Date: Tue, 25 Jun 2024 08:11:56 +0200
In-Reply-To: <20240624163707.299494-9-arnd@kernel.org>
References: <20240624163707.299494-1-arnd@kernel.org>
	 <20240624163707.299494-9-arnd@kernel.org>
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

On Mon, 2024-06-24 at 18:37 +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> The unusual function calling conventions on SuperH ended up causing
> sync_file_range to have the wrong argument order, with the 'flags'
> argument getting sorted before 'nbytes' by the compiler.
>=20
> In userspace, I found that musl, glibc, uclibc and strace all expect the
> normal calling conventions with 'nbytes' last, so changing the kernel
> to match them should make all of those work.
>=20
> In order to be able to also fix libc implementations to work with existin=
g
> kernels, they need to be able to tell which ABI is used. An easy way
> to do this is to add yet another system call using the sync_file_range2
> ABI that works the same on all architectures.
>=20
> Old user binaries can now work on new kernels, and new binaries can
> try the new sync_file_range2() to work with new kernels or fall back
> to the old sync_file_range() version if that doesn't exist.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 75c92acdd5b1 ("sh: Wire up new syscalls.")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/sh/kernel/sys_sh32.c           | 11 +++++++++++
>  arch/sh/kernel/syscalls/syscall.tbl |  3 ++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/sh/kernel/sys_sh32.c b/arch/sh/kernel/sys_sh32.c
> index 9dca568509a5..d6f4afcb0e87 100644
> --- a/arch/sh/kernel/sys_sh32.c
> +++ b/arch/sh/kernel/sys_sh32.c
> @@ -59,3 +59,14 @@ asmlinkage int sys_fadvise64_64_wrapper(int fd, u32 of=
fset0, u32 offset1,
>  				 (u64)len0 << 32 | len1, advice);
>  #endif
>  }
> +
> +/*
> + * swap the arguments the way that libc wants them instead of
> + * moving flags ahead of the 64-bit nbytes argument
> + */
> +SYSCALL_DEFINE6(sh_sync_file_range6, int, fd, SC_ARG64(offset),
> +                SC_ARG64(nbytes), unsigned int, flags)
> +{
> +        return ksys_sync_file_range(fd, SC_VAL64(loff_t, offset),
> +                                    SC_VAL64(loff_t, nbytes), flags);
> +}
> diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscall=
s/syscall.tbl
> index bbf83a2db986..c55fd7696d40 100644
> --- a/arch/sh/kernel/syscalls/syscall.tbl
> +++ b/arch/sh/kernel/syscalls/syscall.tbl
> @@ -321,7 +321,7 @@
>  311	common	set_robust_list			sys_set_robust_list
>  312	common	get_robust_list			sys_get_robust_list
>  313	common	splice				sys_splice
> -314	common	sync_file_range			sys_sync_file_range
> +314	common	sync_file_range			sys_sh_sync_file_range6
>  315	common	tee				sys_tee
>  316	common	vmsplice			sys_vmsplice
>  317	common	move_pages			sys_move_pages
> @@ -395,6 +395,7 @@
>  385	common	pkey_alloc			sys_pkey_alloc
>  386	common	pkey_free			sys_pkey_free
>  387	common	rseq				sys_rseq
> +388	common	sync_file_range2		sys_sync_file_range2
>  # room for arch specific syscalls
>  393	common	semget				sys_semget
>  394	common	semctl				sys_semctl

Acked-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

