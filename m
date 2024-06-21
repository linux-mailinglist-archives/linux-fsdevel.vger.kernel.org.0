Return-Path: <linux-fsdevel+bounces-22156-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C63E912E49
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 22:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE6991F2676E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 20:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E5A17B4E0;
	Fri, 21 Jun 2024 20:12:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from brightrain.aerifal.cx (brightrain.aerifal.cx [104.156.224.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B92B16D4D8
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Jun 2024 20:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.156.224.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719000736; cv=none; b=eqLtserACuc/7Lyp7DJuivhblujmJQbMInDaRYTHF7NYwPsw9jJvSHzuvGSiu0JU5iS8KOV0sfVlf36/PuURa7Fus1hKCTKUh5upJ72wl7aqQYderUbM16nMz/UVSgk3u8V+Ti9BkmlXu0Sllp2pV673ER6Loh8bQo1w7bYtKWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719000736; c=relaxed/simple;
	bh=vhcmxHuEfXQE4obMPoKgf5UPHRF9VVw2LNmHi4WI0f8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WkJYS0okNIRxnNtqvRsBmzP01LdB3EuH/hxjtn68ebhqRtha9Rivs2UGNV03yKGvPZMDDlni+Dgtd8yPG3ywEyLMIDaKCtkVcLv83S4IcayP4Y7Wmdl5EMnqamebyoyFQeIx7el53Lv7G1JdmNdb8bYGNXhCXmFvA86bdLlSag8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org; spf=pass smtp.mailfrom=aerifal.cx; arc=none smtp.client-ip=104.156.224.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aerifal.cx
Date: Fri, 21 Jun 2024 15:57:23 -0400
From: Rich Felker <dalias@libc.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Arnd Bergmann <arnd@kernel.org>, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org, Helge Deller <deller@gmx.de>,
	linux-parisc@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, Brian Cain <bcain@quicinc.com>,
	linux-hexagon@vger.kernel.org, Guo Ren <guoren@kernel.org>,
	linux-csky@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, libc-alpha@sourceware.org,
	musl@lists.openwall.com, ltp@lists.linux.it, stable@vger.kernel.org
Subject: Re: [musl] Re: [PATCH 09/15] sh: rework sync_file_range ABI
Message-ID: <20240621195723.GB10433@brightrain.aerifal.cx>
References: <20240620162316.3674955-1-arnd@kernel.org>
 <20240620162316.3674955-10-arnd@kernel.org>
 <366548c1a0d9749e42c0d0c993414a353c9b0b02.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <366548c1a0d9749e42c0d0c993414a353c9b0b02.camel@physik.fu-berlin.de>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Fri, Jun 21, 2024 at 10:44:39AM +0200, John Paul Adrian Glaubitz wrote:
> Hi Arnd,
> 
> thanks for your patch!
> 
> On Thu, 2024-06-20 at 18:23 +0200, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > The unusual function calling conventions on superh ended up causing
>                                               ^^^^^^
>                                        It's spelled SuperH
> 
> > sync_file_range to have the wrong argument order, with the 'flags'
> > argument getting sorted before 'nbytes' by the compiler.
> > 
> > In userspace, I found that musl, glibc, uclibc and strace all expect the
> > normal calling conventions with 'nbytes' last, so changing the kernel
> > to match them should make all of those work.
> > 
> > In order to be able to also fix libc implementations to work with existing
> > kernels, they need to be able to tell which ABI is used. An easy way
> > to do this is to add yet another system call using the sync_file_range2
> > ABI that works the same on all architectures.
> > 
> > Old user binaries can now work on new kernels, and new binaries can
> > try the new sync_file_range2() to work with new kernels or fall back
> > to the old sync_file_range() version if that doesn't exist.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 75c92acdd5b1 ("sh: Wire up new syscalls.")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  arch/sh/kernel/sys_sh32.c           | 11 +++++++++++
> >  arch/sh/kernel/syscalls/syscall.tbl |  3 ++-
> >  2 files changed, 13 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/sh/kernel/sys_sh32.c b/arch/sh/kernel/sys_sh32.c
> > index 9dca568509a5..d5a4f7c697d8 100644
> > --- a/arch/sh/kernel/sys_sh32.c
> > +++ b/arch/sh/kernel/sys_sh32.c
> > @@ -59,3 +59,14 @@ asmlinkage int sys_fadvise64_64_wrapper(int fd, u32 offset0, u32 offset1,
> >  				 (u64)len0 << 32 | len1, advice);
> >  #endif
> >  }
> > +
> > +/*
> > + * swap the arguments the way that libc wants it instead of
> 
> I think "swap the arguments to the order that libc wants them" would
> be easier to understand here.
> 
> > + * moving flags ahead of the 64-bit nbytes argument
> > + */
> > +SYSCALL_DEFINE6(sh_sync_file_range6, int, fd, SC_ARG64(offset),
> > +                SC_ARG64(nbytes), unsigned int, flags)
> > +{
> > +        return ksys_sync_file_range(fd, SC_VAL64(loff_t, offset),
> > +                                    SC_VAL64(loff_t, nbytes), flags);
> > +}
> > diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
> > index bbf83a2db986..c55fd7696d40 100644
> > --- a/arch/sh/kernel/syscalls/syscall.tbl
> > +++ b/arch/sh/kernel/syscalls/syscall.tbl
> > @@ -321,7 +321,7 @@
> >  311	common	set_robust_list			sys_set_robust_list
> >  312	common	get_robust_list			sys_get_robust_list
> >  313	common	splice				sys_splice
> > -314	common	sync_file_range			sys_sync_file_range
> > +314	common	sync_file_range			sys_sh_sync_file_range6
>                                                                  ^^^^^^ Why the suffix 6 here?
> 
> >  315	common	tee				sys_tee
> >  316	common	vmsplice			sys_vmsplice
> >  317	common	move_pages			sys_move_pages
> > @@ -395,6 +395,7 @@
> >  385	common	pkey_alloc			sys_pkey_alloc
> >  386	common	pkey_free			sys_pkey_free
> >  387	common	rseq				sys_rseq
> > +388	common	sync_file_range2		sys_sync_file_range2
> >  # room for arch specific syscalls
> >  393	common	semget				sys_semget
> >  394	common	semctl				sys_semctl
> 
> I wonder how you discovered this bug. Did you look up the calling convention on SuperH
> and compare the argument order for the sys_sync_file_range system call documented there
> with the order in the kernel?
> 
> Did you also check what order libc uses? I would expect libc on SuperH misordering the
> arguments as well unless I am missing something. Or do we know that the code is actually
> currently broken?

No, there's no reason libc would misorder them because syscalls aren't
function calls, and aren't subject to function call ABI. We have to
explicitly bind the arguments to registers and make a syscall
instruction.

The only reason this bug happened on the kernel side is that someone
thought it would be a smart idea to save maybe 10 instructions by
treating the register state on entry as directly suitable to jump from
asm to a C function rather than explicitly marshalling the arguments
out of the user-kernel syscall ABI positions into actual arguments to
a C function call.

Rich

