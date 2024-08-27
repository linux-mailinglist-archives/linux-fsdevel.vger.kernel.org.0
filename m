Return-Path: <linux-fsdevel+bounces-27470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B348961A33
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 01:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECB13284749
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 23:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443E31D45EB;
	Tue, 27 Aug 2024 23:00:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8981618D62D;
	Tue, 27 Aug 2024 23:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.228.1.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724799651; cv=none; b=NFVpYFAX7he7VvHBDFtkxT9T4a4pn4/WWHDjjMQx88YPfuAXx7Dgj8UpWIxwk48ok/yf98/jeg1xtnnJ+hq5Ng7r5f6iwIfvi130X5fnrB2f8KoTbQE4YhjsHDV/ylE/FTnl/bjQsYxvPUlHBK51OdN9kdTXowO9uEyrMDYCZfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724799651; c=relaxed/simple;
	bh=zVR+j9/Y69HgPcEEApJAHkp51d4U9AleXPztiiA++P8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qMfYUGrkEh5D+cYXn60iktOmbQFaII36/YhbucpyAbpuhG+0VoXxMr74S88I2cX34A195t1FKUompzeC478534Z5Mc1/MWvCaq45s1vYv77xl/R/XF7k+hL2hVh42MFJG0VqBmDWvTt/NJZ4S29Vv9ojfiB2/XmHLDkeNg0vxHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass smtp.mailfrom=kernel.crashing.org; arc=none smtp.client-ip=63.228.1.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.crashing.org
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 47RMrWeM032045;
	Tue, 27 Aug 2024 17:53:32 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 47RMrUKh032044;
	Tue, 27 Aug 2024 17:53:30 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Tue, 27 Aug 2024 17:53:30 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, "Theodore Ts'o" <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Shuah Khan <shuah@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 05/17] vdso: Avoid call to memset() by getrandom
Message-ID: <20240827225330.GC29862@gate.crashing.org>
References: <cover.1724309198.git.christophe.leroy@csgroup.eu> <5deb67090b214f0e6eae96b7c406546d1a16f89b.1724309198.git.christophe.leroy@csgroup.eu> <20240827180819.GB2049@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827180819.GB2049@sol.localdomain>
User-Agent: Mutt/1.4.2.3i

On Tue, Aug 27, 2024 at 11:08:19AM -0700, Eric Biggers wrote:
> On Thu, Aug 22, 2024 at 09:13:13AM +0200, Christophe Leroy wrote:
> > With the current implementation, __cvdso_getrandom_data() calls
> > memset(), which is unexpected in the VDSO.
> > 
> > Rewrite opaque data initialisation to avoid memset().
> > 
> > Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> > ---
> >  lib/vdso/getrandom.c | 15 ++++++++++-----
> >  1 file changed, 10 insertions(+), 5 deletions(-)
> > 
> > diff --git a/lib/vdso/getrandom.c b/lib/vdso/getrandom.c
> > index cab153c5f9be..4a56f45141b4 100644
> > --- a/lib/vdso/getrandom.c
> > +++ b/lib/vdso/getrandom.c
> > @@ -4,6 +4,7 @@
> >   */
> >  
> >  #include <linux/minmax.h>
> > +#include <linux/array_size.h>
> >  #include <vdso/datapage.h>
> >  #include <vdso/getrandom.h>
> >  #include <vdso/unaligned.h>
> > @@ -74,11 +75,15 @@ __cvdso_getrandom_data(const struct vdso_rng_data *rng_info, void *buffer, size_
> >  	u32 counter[2] = { 0 };
> >  
> >  	if (unlikely(opaque_len == ~0UL && !buffer && !len && !flags)) {
> > -		*(struct vgetrandom_opaque_params *)opaque_state = (struct vgetrandom_opaque_params) {
> > -			.size_of_opaque_state = sizeof(*state),
> > -			.mmap_prot = PROT_READ | PROT_WRITE,
> > -			.mmap_flags = MAP_DROPPABLE | MAP_ANONYMOUS
> > -		};
> > +		struct vgetrandom_opaque_params *params = opaque_state;
> > +		int i;
> > +
> > +		params->size_of_opaque_state = sizeof(*state);
> > +		params->mmap_prot = PROT_READ | PROT_WRITE;
> > +		params->mmap_flags = MAP_DROPPABLE | MAP_ANONYMOUS;
> > +		for (i = 0; i < ARRAY_SIZE(params->reserved); i++)
> > +			params->reserved[i] = 0;
> > +
> >  		return 0;
> >  	}
> 
> Is there a compiler flag that could be used to disable the generation of calls
> to memset?

-fno-tree-loop-distribute-patterns .  But, as always, read up on it, see
what it actually does (and how it avoids your problem, and mostly: learn
what the actual problem *was*!)

Have fun,


Segher

