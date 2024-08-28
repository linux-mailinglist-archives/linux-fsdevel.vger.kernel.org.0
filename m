Return-Path: <linux-fsdevel+bounces-27556-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 023C19625D0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 13:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 353061C220CB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 11:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC56F16D4CD;
	Wed, 28 Aug 2024 11:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ie1ZgaJb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C024D108;
	Wed, 28 Aug 2024 11:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724843921; cv=none; b=Oqgj5/ACQ7Fvv6r7pu3kkW66XXUBu1rjYJJpougXBsixisMN9Tee01pdzgJHwqDV0llaqr4TcBjh+X1nugzuAHbZQddLHJqBSgZciYjW3WAzCrUkMHIJtjRosLTDEqhgf5fr0WTPnCkK29ufnkFSkMnsHLaUQff1hMOTC6zjtP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724843921; c=relaxed/simple;
	bh=K4ffkU1d24Lo6Vpr60xC27K+SzTzNldohctsI0B5LAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NvqefsuWo035y194PtUONVMgnmYQJAH3ApfPJuBS5KIXz14Q5YZsoz6upH3K6vGG76QAvoit8P4dmU+R/O/3qu94ODB+6KMJUrG0uO6FVhkVadeIN3IGEknS6btoUUPNZkM2Wo3v2vMX63WD6hR0g+K5AqyYvv9BsFvT5CUSL+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=ie1ZgaJb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0F77C98EC1;
	Wed, 28 Aug 2024 11:18:37 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ie1ZgaJb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1724843916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TaIlxacxM0cvax8nGT0Wo3sn3OzyvoPLEHrLd84XeNU=;
	b=ie1ZgaJbmdO0NFZiWnbQxMHvES+WVoJwzMG9ptpU3Emt2rn3BokeH+49oxcj4dV6dn2A7R
	OZIoYXalY4Ws4iv74BUjZGRKqr/jYLeyEjR6fhELEgh04xz8/D5eJuiLFmdCA7UTqCRd8K
	hMYFoVGZZlHMLnB3FsT4kBzzeg3/4HU=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8e8b7172 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 28 Aug 2024 11:18:35 +0000 (UTC)
Date: Wed, 28 Aug 2024 13:18:34 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Eric Biggers <ebiggers@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>, Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Theodore Ts'o <tytso@mit.edu>,
	Arnd Bergmann <arnd@arndb.de>,
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
Message-ID: <Zs8HirKLk-SrwTIu@zx2c4.com>
References: <cover.1724309198.git.christophe.leroy@csgroup.eu>
 <5deb67090b214f0e6eae96b7c406546d1a16f89b.1724309198.git.christophe.leroy@csgroup.eu>
 <20240827180819.GB2049@sol.localdomain>
 <20240827225330.GC29862@gate.crashing.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240827225330.GC29862@gate.crashing.org>

On Tue, Aug 27, 2024 at 05:53:30PM -0500, Segher Boessenkool wrote:
> On Tue, Aug 27, 2024 at 11:08:19AM -0700, Eric Biggers wrote:
> > On Thu, Aug 22, 2024 at 09:13:13AM +0200, Christophe Leroy wrote:
> > > With the current implementation, __cvdso_getrandom_data() calls
> > > memset(), which is unexpected in the VDSO.
> > > 
> > > Rewrite opaque data initialisation to avoid memset().
> > > 
> > > Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> > > ---
> > >  lib/vdso/getrandom.c | 15 ++++++++++-----
> > >  1 file changed, 10 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/lib/vdso/getrandom.c b/lib/vdso/getrandom.c
> > > index cab153c5f9be..4a56f45141b4 100644
> > > --- a/lib/vdso/getrandom.c
> > > +++ b/lib/vdso/getrandom.c
> > > @@ -4,6 +4,7 @@
> > >   */
> > >  
> > >  #include <linux/minmax.h>
> > > +#include <linux/array_size.h>
> > >  #include <vdso/datapage.h>
> > >  #include <vdso/getrandom.h>
> > >  #include <vdso/unaligned.h>
> > > @@ -74,11 +75,15 @@ __cvdso_getrandom_data(const struct vdso_rng_data *rng_info, void *buffer, size_
> > >  	u32 counter[2] = { 0 };
> > >  
> > >  	if (unlikely(opaque_len == ~0UL && !buffer && !len && !flags)) {
> > > -		*(struct vgetrandom_opaque_params *)opaque_state = (struct vgetrandom_opaque_params) {
> > > -			.size_of_opaque_state = sizeof(*state),
> > > -			.mmap_prot = PROT_READ | PROT_WRITE,
> > > -			.mmap_flags = MAP_DROPPABLE | MAP_ANONYMOUS
> > > -		};
> > > +		struct vgetrandom_opaque_params *params = opaque_state;
> > > +		int i;
> > > +
> > > +		params->size_of_opaque_state = sizeof(*state);
> > > +		params->mmap_prot = PROT_READ | PROT_WRITE;
> > > +		params->mmap_flags = MAP_DROPPABLE | MAP_ANONYMOUS;
> > > +		for (i = 0; i < ARRAY_SIZE(params->reserved); i++)
> > > +			params->reserved[i] = 0;
> > > +
> > >  		return 0;
> > >  	}
> > 
> > Is there a compiler flag that could be used to disable the generation of calls
> > to memset?
> 
> -fno-tree-loop-distribute-patterns .  But, as always, read up on it, see
> what it actually does (and how it avoids your problem, and mostly: learn
> what the actual problem *was*!)

This might help with various loops, but it doesn't help with the matter
that this patch fixes, which is struct initialization. I just tried it
with the arm64 patch to no avail.

