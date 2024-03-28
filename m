Return-Path: <linux-fsdevel+bounces-15507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B40E088F86F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 08:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55D5C1F2653E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 07:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB80A51C40;
	Thu, 28 Mar 2024 07:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAmN/m71"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD9822EED;
	Thu, 28 Mar 2024 07:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711610169; cv=none; b=BXE428iIXpSTk2JsvdtKCyNXB91bsmr+ucHMqRQ1HUyMAgAP3XbDFQNaK1ux03u4L6O4erMYuuMrWSSKamxrLf7f5cLOkJioQQl61hkczlsY7zwCks8pqsn2Hw/cqbiHYim/ZiykTLtVUlaAYhncnTWmy9lejcrefYA8YfRlA7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711610169; c=relaxed/simple;
	bh=r1JsHv6zvguqW90jyEY0U/U4DMDGMKwYQjCJCqIjmk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7OQ/qSronR2jM6NmP59ZEgEk57TYrWQmo8NeUC1Og0SVylxp8nxV5+KvcbZiFchW7hYj+2kq7ki6/i7QIBZYfEBtHmFzoa+IAdGE+66XtlcBhJ8sLbXrwMCpoLkwMz+GYzNmrAl4OzstnbCLzOLof8ZZmdxNpm5yxqp5yqrd84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAmN/m71; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13A23C433F1;
	Thu, 28 Mar 2024 07:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711610168;
	bh=r1JsHv6zvguqW90jyEY0U/U4DMDGMKwYQjCJCqIjmk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NAmN/m71xn3ib012g07l8sC+gyJIzFt9fFK3jdDigIHga4g8Fy0g4u0A9zMTn2G8y
	 Hz/ArW+aqXuqTPb2fPpftu20+1RkDRzP/XFJQhHXJMj8KYnoe5TCRWhoGwSsNg3v4T
	 H3jfZDkvrEoo5QMLri7RoQDmFW3FyBYt4qgxPfkHDpAB+8Ajo8fibnxufZyqfjrguR
	 dBNlncXj4g94p9pzTUeGHFe+ZO+Z9/1/QE5YeVvQ97AoXIN+LsdR2yhA69cvKvdLXt
	 K7hfz3k4p687HCWjsBvcGXgtiDBmENV6h+EZI1V7LNtQhQ+nyZGFPEfci2N6376cIj
	 b9N3P6mb8dHLA==
Date: Thu, 28 Mar 2024 09:15:20 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Vineet Gupta <vgupta@kernel.org>, David Hildenbrand <david@redhat.com>,
	peterx <peterx@redhat.com>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, x86@kernel.org,
	Ryan Roberts <ryan.roberts@arm.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Matt Turner <mattst88@gmail.com>,
	Alexey Brodkin <abrodkin@synopsys.com>
Subject: Re: [PATCH RFC 0/3] mm/gup: consistently call it GUP-fast
Message-ID: <ZgUZCBNloC-grPWJ@kernel.org>
References: <20240327130538.680256-1-david@redhat.com>
 <ZgQ5hNltQ2DHQXps@x1n>
 <3922460a-4d01-4ecb-b8c5-7c57fd46f3fd@redhat.com>
 <dc1433ea-4e59-4ab7-83fb-23b393020980@app.fastmail.com>
 <3360dba8-0fac-4126-b72b-abc036957d6a@kernel.org>
 <10da3ced-9a79-4ebb-a77d-1aa49cc61952@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <10da3ced-9a79-4ebb-a77d-1aa49cc61952@app.fastmail.com>

On Thu, Mar 28, 2024 at 07:09:13AM +0100, Arnd Bergmann wrote:
> On Thu, Mar 28, 2024, at 06:51, Vineet Gupta wrote:
> > On 3/27/24 09:22, Arnd Bergmann wrote:
> >> On Wed, Mar 27, 2024, at 16:39, David Hildenbrand wrote:
> >>> On 27.03.24 16:21, Peter Xu wrote:
> >>>> On Wed, Mar 27, 2024 at 02:05:35PM +0100, David Hildenbrand wrote:
> >>>>
> >>>> I'm not sure what config you tried there; as I am doing some build tests
> >>>> recently, I found turning off CONFIG_SAMPLES + CONFIG_GCC_PLUGINS could
> >>>> avoid a lot of issues, I think it's due to libc missing.  But maybe not the
> >>>> case there.
> >>> CCin Arnd; I use some of his compiler chains, others from Fedora directly. For
> >>> example for alpha and arc, the Fedora gcc is "13.2.1".
> >>> But there is other stuff like (arc):
> >>>
> >>> ./arch/arc/include/asm/mmu-arcv2.h: In function 'mmu_setup_asid':
> >>> ./arch/arc/include/asm/mmu-arcv2.h:82:9: error: implicit declaration of 
> >>> function 'write_aux_reg' [-Werro
> >>> r=implicit-function-declaration]
> >>>     82 |         write_aux_reg(ARC_REG_PID, asid | MMU_ENABLE);
> >>>        |         ^~~~~~~~~~~~~
> >> Seems to be missing an #include of soc/arc/aux.h, but I can't
> >> tell when this first broke without bisecting.
> >
> > Weird I don't see this one but I only have gcc 12 handy ATM.
> >
> >     gcc version 12.2.1 20230306 (ARC HS GNU/Linux glibc toolchain -
> > build 1360)
> >
> > I even tried W=1 (which according to scripts/Makefile.extrawarn) should
> > include -Werror=implicit-function-declaration but don't see this still.
> >
> > Tomorrow I'll try building a gcc 13.2.1 for ARC.
> 
> David reported them with the toolchains I built at
> https://mirrors.edge.kernel.org/pub/tools/crosstool/
> I'm fairly sure the problem is specific to the .config
> and tree, not the toolchain though.

This happens with defconfig and both gcc 12.2.0 and gcc 13.2.0 from your
crosstools. I also see these on the current Linus' tree:

arc/kernel/ptrace.c:342:16: warning: no previous prototype for 'syscall_trace_enter' [-Wmissing-prototypes]
arch/arc/kernel/kprobes.c:193:15: warning: no previous prototype for 'arc_kprobe_handler' [-Wmissing-prototypes]

This fixed the warning about write_aux_reg for me, probably Vineet would
want this include somewhere else...

diff --git a/arch/arc/include/asm/mmu-arcv2.h b/arch/arc/include/asm/mmu-arcv2.h
index ed9036d4ede3..0fca342d7b79 100644
--- a/arch/arc/include/asm/mmu-arcv2.h
+++ b/arch/arc/include/asm/mmu-arcv2.h
@@ -69,6 +69,8 @@
 
 #ifndef __ASSEMBLY__
 
+#include <asm/arcregs.h>
+
 struct mm_struct;
 extern int pae40_exist_but_not_enab(void);
 
 
> >>> or (alpha)
> >>>
> >>> WARNING: modpost: "saved_config" [vmlinux] is COMMON symbol
> >>> ERROR: modpost: "memcpy" [fs/reiserfs/reiserfs.ko] undefined!
> >>> ERROR: modpost: "memcpy" [fs/nfs/nfs.ko] undefined!
> >>> ERROR: modpost: "memcpy" [fs/nfs/nfsv3.ko] undefined!
> >>> ERROR: modpost: "memcpy" [fs/nfsd/nfsd.ko] undefined!
> >>> ERROR: modpost: "memcpy" [fs/lockd/lockd.ko] undefined!
> >>> ERROR: modpost: "memcpy" [crypto/crypto.ko] undefined!
> >>> ERROR: modpost: "memcpy" [crypto/crypto_algapi.ko] undefined!
> >>> ERROR: modpost: "memcpy" [crypto/aead.ko] undefined!
> >>> ERROR: modpost: "memcpy" [crypto/crypto_skcipher.ko] undefined!
> >>> ERROR: modpost: "memcpy" [crypto/seqiv.ko] undefined!
> >
> > Are these from ARC build or otherwise ?
> 
> This was arch/alpha.
> 
>       Arnd

-- 
Sincerely yours,
Mike.

