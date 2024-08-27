Return-Path: <linux-fsdevel+bounces-27424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A1D9616DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 20:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 560BF2881E9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 18:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74C61D2F51;
	Tue, 27 Aug 2024 18:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="aRXc2LCc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDA61CF291;
	Tue, 27 Aug 2024 18:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724782976; cv=none; b=e3vOcLPx+gWocr6ErgmnOagY/ij7E+YfoAbEEJ6vdaJZE1icp74gRQz3EDthOQO2xvCm5q4RMixHQw9rNzzqbfea+YnnQ/KGB8TU8vMBO+a20z8gkKYC67hersVnjj5tsP0CzLsgKQxll0ZCZvJOojdWd27P19WlbK4Uo/upSgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724782976; c=relaxed/simple;
	bh=XcCF67VGTMPngNt+jYyzJLf3XPAFCBiDSQn0MARRYNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YtXu7wtRFJ4Cq8D39agUYy8LTr2T+ImKzwCKDbfv6XlnfNiqmVLytQNDgvmduqKD6KnmPotIF/djR4YwpCi2QPQ3lrmoOtrajdESRFubzfYPW4Jq0rjlj9lUqxpJ0cyL4f+0+FgKoqDZwzGTOxWU9ZQy4OzoWR4YZ7aoX9ot3sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=aRXc2LCc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2858C4AF09;
	Tue, 27 Aug 2024 18:22:52 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="aRXc2LCc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1724782970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6IIlC4dKeX0MR+87wiXBKWBHYPvMuntBVfDv8HHvaKU=;
	b=aRXc2LCcclXS0jZM2Er3xb+9/MC6tyTrnANQKQqiX8JchcC5Hct3PDriYN6bmQyyvpVrZu
	SoRTJ7lKlZu8bysVWJFpmMCUsDdL0JJSqO5l7LQ2QGh4MGWrRpFxxzDVBg/4dd6rTXgykh
	bzknrtr7GCDH1d4bP7p3h1ixzFFzzvI=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 82078a25 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Aug 2024 18:22:50 +0000 (UTC)
Date: Tue, 27 Aug 2024 20:22:44 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
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
Message-ID: <Zs4ZdAtnm2UEr5cd@zx2c4.com>
References: <cover.1724309198.git.christophe.leroy@csgroup.eu>
 <5deb67090b214f0e6eae96b7c406546d1a16f89b.1724309198.git.christophe.leroy@csgroup.eu>
 <20240827180819.GB2049@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240827180819.GB2049@sol.localdomain>

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

Apparently not: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=90701

-ffreestanding disables the most but still can generate calls to memcpy
and memset, and the bug was closed as "RESOLVED INVALID". Surprising,
but maybe it's one of those "functions are part of language" things.

