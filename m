Return-Path: <linux-fsdevel+bounces-27606-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE80962C99
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 17:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91169287652
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 15:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7ECB1A2C0A;
	Wed, 28 Aug 2024 15:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDdad5/I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0430114831D;
	Wed, 28 Aug 2024 15:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724859638; cv=none; b=rdTunW4YN6UjEgrj0fswHayCuUacgWq9q/7Bplk9WwrcJdnofyzf5whkBP+PWpq5hDqBZVvLmMflJ/qkanLxaU7Ybxy7p2wtRtrjQ/YWgaHbdLBBQ7mxKeVyU6KrUowgUl1eD6eVxY3BUPmIP6rI1H9vJ5KBg8pRMAjOT5B4Ae4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724859638; c=relaxed/simple;
	bh=+z7/VLAc5zAKqxwt9kQI0vxm8x7sulgvUDeMTRfB+wo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PRedaW+VPkSXEZiXQm/b7MiqpdY6PJQpleAa0t0DXb44Xms0VE2kBJv/v4oDujlSejYTT0oShgIalDrWiTSryjKxtsxt90pz97jPaMiAwT3lvkaOAWSWqhGOI/Dp+IUta4NdauZr6VsIqC0tazew2hsdaLctPgO+a6G1JBtb4OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDdad5/I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 781E7C4CEC9;
	Wed, 28 Aug 2024 15:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724859637;
	bh=+z7/VLAc5zAKqxwt9kQI0vxm8x7sulgvUDeMTRfB+wo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hDdad5/IY68zkrft/92YWfFtjDz6TFndSmnpp5pqAtaDdhgaQHXnMYujF2CwZtAvo
	 s1dVBctohqByWUo15KsHC1yXOsb3CsxrVYgXiTlMrxSNBqKSRHb2u/dgFnWDlyP45P
	 kmzBzCQlLYmgzPMvmTlIEcYXhkLufuTJDpchreYUAd0yoHp8hJGCENnAbHqZR1NUMB
	 63ZyNil+E22vWl4w+ZhugE7V8Y5RiBnHkIJ248WfFc80AZtPJMZpvtsLhvJEQmQQ7b
	 rjS4mie2g2VPxttgup163SLxFXlpDbWSy4ple6kkn/VZnDNkSEFpYi5cJmSqRwT5Qa
	 F/BVlj/jrU5iw==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f3e071eb64so94243731fa.1;
        Wed, 28 Aug 2024 08:40:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV05xct5gfUJ2WZGILTjXAdPU1k8W3sJVDHX0yp56hujCJuB0om51JlDpME3pndc1JSGNNhTppmsXal/h0gRg==@vger.kernel.org, AJvYcCWCZcSHufCGoUAdCMPQp0fRVxzYrmJVjlDzwf0cxRS/AVusgr5YsPCWVlftT7yGyfOU/wqCrlcjbhFN6Cmn@vger.kernel.org, AJvYcCWJc0C107/wSVlSw7lu1Aj6ndpsarTY6yOGjRRO4HE/t98Ijb6jv9LZCMI7jFCd7FcjbgtKAFMoWKnBMAHGhHxd@vger.kernel.org, AJvYcCWjqeQIr7Tp60H/3mg3ypNTH87qpaqx7Qo/ZbC9RsxV1WEmgE6ye0ccCcN7C8UoAVsL5VQxbixOBVqhyYtSNozUr6l3@vger.kernel.org, AJvYcCXXwvItc36YPp8dou+RaeRRAFMMDrdJ/AutmCKqlkH8WFKpoWipIYNKclPx/lM6JATUIbrBztf3eUOk@vger.kernel.org
X-Gm-Message-State: AOJu0YxdD0WqGot810jQ21YEOxntFmOYzJGRAgRGKnttnKWwoA4o9Ruq
	remfgM00GECRUV8PLUP2W7qAfs+qOrF6p2t/1b537Jptf0jXTwVFEddbyUz0ByKKmqRPPkNMiJR
	cm0v6Z7nuSvrjE8S7emkgFHCZQ7k=
X-Google-Smtp-Source: AGHT+IHIXIHDcxvkoioWarqDfEAwvoOHHvvDveL69dLtIdivksLO7ybL0XqtoFeExKbS+796rHsbT/SXItR1tBLUGxI=
X-Received: by 2002:a2e:461a:0:b0:2f3:f182:49f3 with SMTP id
 38308e7fff4ca-2f6106e36e6mr594741fa.22.1724859635743; Wed, 28 Aug 2024
 08:40:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1724309198.git.christophe.leroy@csgroup.eu>
 <5deb67090b214f0e6eae96b7c406546d1a16f89b.1724309198.git.christophe.leroy@csgroup.eu>
 <20240827180819.GB2049@sol.localdomain> <20240827225330.GC29862@gate.crashing.org>
 <Zs8HirKLk-SrwTIu@zx2c4.com> <fc19bf63-d519-46e2-be70-80202c85ff92@app.fastmail.com>
 <20240828124519.GE29862@gate.crashing.org>
In-Reply-To: <20240828124519.GE29862@gate.crashing.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 28 Aug 2024 17:40:23 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGmDmxy75eP=rf_fzKmg0g_FeKV43jk2G_gibnKZBtVww@mail.gmail.com>
Message-ID: <CAMj1kXGmDmxy75eP=rf_fzKmg0g_FeKV43jk2G_gibnKZBtVww@mail.gmail.com>
Subject: Re: [PATCH v2 05/17] vdso: Avoid call to memset() by getrandom
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Arnd Bergmann <arnd@arndb.de>, "Jason A . Donenfeld" <Jason@zx2c4.com>, Eric Biggers <ebiggers@kernel.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>, Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, "Theodore Ts'o" <tytso@mit.edu>, Andrew Morton <akpm@linux-foundation.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, shuah <shuah@kernel.org>, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Aug 2024 at 14:57, Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> On Wed, Aug 28, 2024 at 12:24:12PM +0000, Arnd Bergmann wrote:
> > On Wed, Aug 28, 2024, at 11:18, Jason A. Donenfeld wrote:
> > > On Tue, Aug 27, 2024 at 05:53:30PM -0500, Segher Boessenkool wrote:
> > >> On Tue, Aug 27, 2024 at 11:08:19AM -0700, Eric Biggers wrote:
> > >> >
> > >> > Is there a compiler flag that could be used to disable the generation of calls
> > >> > to memset?
> > >>
> > >> -fno-tree-loop-distribute-patterns .  But, as always, read up on it, see
> > >> what it actually does (and how it avoids your problem, and mostly: learn
> > >> what the actual problem *was*!)
> > >
> > > This might help with various loops, but it doesn't help with the matter
> > > that this patch fixes, which is struct initialization. I just tried it
> > > with the arm64 patch to no avail.
> >
> > Maybe -ffreestanding can help here? That should cause the vdso to be built
> > with the assumption that there is no libc, so it would neither add nor
> > remove standard library calls. Not sure if that causes other problems,
> > e.g. if the calling conventions are different.
>
> "GCC requires the freestanding
> environment provide 'memcpy', 'memmove', 'memset' and 'memcmp'."
>
> This is precisely to implement things like struct initialisation.  Maybe
> we should have a "-ffreeerstanding" or "-ffreefloating" or think of
> something funnier still environment as well, this problem has been there
> since the -ffreestanding flag has existed, but the problem is as old as
> the night.
>
> -fno-builtin might help a bit more, but just attack the problem at
> its root, like I suggested?
>

In my experience, this is likely to do the opposite: it causes the
compiler to 'forget' the semantics of memcpy() and memset(), so that
explicit trivial calls will no longer be elided and replaced with
plain loads and stores (as it can no longer guarantee the equivalence)

> (This isn't a new problem, originally it showed up as "GCC replaces
> (part of) my memcpy() implementation by a (recursive) call to memcpy()"
> and, well, that doesn't quite work!)
>

This needs to be fixed for Clang as well, so throwing GCC specific
flags at it will at best be a partial solution.

Omitting the struct assignment is a reasonable way to reduce the
likelihood that a memset() will be emitted, so for this patch

Acked-by: Ard Biesheuvel <ardb@kernel.org>

It is not a complete solution, unfortunately, and I guess there may be
other situations (compiler/arch combinations) where this might pop up
again.

