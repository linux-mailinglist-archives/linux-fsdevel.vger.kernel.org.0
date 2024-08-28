Return-Path: <linux-fsdevel+bounces-27625-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 057C8962E3D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 19:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A004E281309
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 17:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0188B1A7052;
	Wed, 28 Aug 2024 17:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFar5KJc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478CF4D108;
	Wed, 28 Aug 2024 17:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724865189; cv=none; b=Butdw3tk9OBvaayASeXyiF2jDrK5eruWqSDH0zEk4iuWtvevHJn/NW3wsN1sK5byIaoXqcac2S+C82k+7oyRAgFsaNRuiHvLmQBOhSOcVGffmKfY72SFOaXT/M2iagyylae7KBMSCjYBd9K7Ud9wD3bsodCr8q8xMPJz48ZJlPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724865189; c=relaxed/simple;
	bh=wTRLnPlAZutCpvLR9R0pglZtR1qgqcPfis4YRXDGlYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sd5mDTnPhZZbVSoBsv/vdW7iysEvZ4B5G7zMhnCtJAIQrKiNfGLlKPe++bsKP1kMs/iglQotWL20rN0oILA8a3Zbfh77CjpS6sJf9oEs2i+Igmb7kjtoojX2A4KVsuFkGKGhqlPY3pVdlvuVKDN5IuBPlwbnTMoq+aJxBWu68oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SFar5KJc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE0BC4CECD;
	Wed, 28 Aug 2024 17:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724865188;
	bh=wTRLnPlAZutCpvLR9R0pglZtR1qgqcPfis4YRXDGlYs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SFar5KJcyOOqLxwhcaGjzk/s+2JLgrGwjQyRUqMnq6qFBlWFPPLW87QI6cfGTmo/s
	 kTVZAokZ2cisPjdcnUa3o49tV1Mw1SpGBGSGUcYilXuMO9Efm1NJJ5zCWyc1Tt2Hzm
	 lNCW48SmTnuXeiI0kQ7hshKa57+I34WmOj4Hs7S81TVeAqFWJ+xVjZqUuI0mSAO995
	 Iq9KaCwlEo1MddLN2KZngqRFwoh2+BZIWdXuoIxh32ggUPof8YLd8aatTgjH5SX1m+
	 77gnG1IU3Jm1Xrpe8VgMpb4xQNmxAy8A/Nn9dhjj9hgXea2lYFDEJuJm/71JAeV9HL
	 rP2cvKtthC9KQ==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-533de5a88f8so6545155e87.3;
        Wed, 28 Aug 2024 10:13:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU+P2qlF24YkJxueyjHkcwkKg84GfjzlVxcwONc0jiQI7qBplZx5frXVIAV5oYpoj9fXm6XFa11dC+V4dCRMO2Y@vger.kernel.org, AJvYcCUi1nLSWPcLirdQZS9Zb35uHve3dcYWHMtEvUy67C65h42yQIp9h3cm9CMOcKgAAniKzaDPo8CWp7xsak6hHw==@vger.kernel.org, AJvYcCW9uR44BVHP0f+zlg2iieZe28SYE8a1hV6urtW3mLh9Uf4iIU84edzu7w5plMXuxQoAC7Qx++bv3jDD@vger.kernel.org, AJvYcCXBX5TPRX/ZBhCinkFUECNYcT2szdOKk5Q8fRyR5rNKWpYflMsvw6mPIzkDJIS04AFxNo5fi1myzKQeA5Gr@vger.kernel.org, AJvYcCXDf7o2Pg5l3qK+mH0+rNjbFLepmOGdNv7GIqSTMNjrYVbKt8JLuBX35goNt9/reyeJQDPucDVF/xxfXdU8y573x0Z8@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb6b8LmTm+GE5EjsR3a7UWfNkoYQWxcj/m+0UBc+wM5cH6AtYB
	CYOyz4Gxe4lwmjLNcW17M0BraembDbTmK9HPhoBad0Aq8mRM62aqETHmYVCGva3VD1PmE5Kooo+
	/kd4wZg0CxaygJtjODWpot49POXQ=
X-Google-Smtp-Source: AGHT+IGT9a5qWQBtajQWghZ5b1FsgrYGjXl26AJMqNqo5EHBiRSmkhizffOxvoPuUqVl91lIQUxQnoyI/1L7KXA3rkA=
X-Received: by 2002:a05:6512:131e:b0:533:4689:9750 with SMTP id
 2adb3069b0e04-5346c626565mr2097762e87.26.1724865187012; Wed, 28 Aug 2024
 10:13:07 -0700 (PDT)
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
 <20240828124519.GE29862@gate.crashing.org> <CAMj1kXGmDmxy75eP=rf_fzKmg0g_FeKV43jk2G_gibnKZBtVww@mail.gmail.com>
 <20240828162025.GG29862@gate.crashing.org>
In-Reply-To: <20240828162025.GG29862@gate.crashing.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 28 Aug 2024 19:12:55 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHZPfr2Sz78UrgsdX-2uBp0D1sCnznQnz5ZyMdiJq6rAA@mail.gmail.com>
Message-ID: <CAMj1kXHZPfr2Sz78UrgsdX-2uBp0D1sCnznQnz5ZyMdiJq6rAA@mail.gmail.com>
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

On Wed, 28 Aug 2024 at 18:24, Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> Hi!
>
> On Wed, Aug 28, 2024 at 05:40:23PM +0200, Ard Biesheuvel wrote:
> > On Wed, 28 Aug 2024 at 14:57, Segher Boessenkool
> > <segher@kernel.crashing.org> wrote:
> > >
> > > On Wed, Aug 28, 2024 at 12:24:12PM +0000, Arnd Bergmann wrote:
> > > > On Wed, Aug 28, 2024, at 11:18, Jason A. Donenfeld wrote:
> > > > > On Tue, Aug 27, 2024 at 05:53:30PM -0500, Segher Boessenkool wrote:
> > > > >> On Tue, Aug 27, 2024 at 11:08:19AM -0700, Eric Biggers wrote:
> > > > >> >
> > > > >> > Is there a compiler flag that could be used to disable the generation of calls
> > > > >> > to memset?
> > > > >>
> > > > >> -fno-tree-loop-distribute-patterns .  But, as always, read up on it, see
> > > > >> what it actually does (and how it avoids your problem, and mostly: learn
> > > > >> what the actual problem *was*!)
> > > > >
> > > > > This might help with various loops, but it doesn't help with the matter
> > > > > that this patch fixes, which is struct initialization. I just tried it
> > > > > with the arm64 patch to no avail.
> > > >
> > > > Maybe -ffreestanding can help here? That should cause the vdso to be built
> > > > with the assumption that there is no libc, so it would neither add nor
> > > > remove standard library calls. Not sure if that causes other problems,
> > > > e.g. if the calling conventions are different.
> > >
> > > "GCC requires the freestanding
> > > environment provide 'memcpy', 'memmove', 'memset' and 'memcmp'."
> > >
> > > This is precisely to implement things like struct initialisation.  Maybe
> > > we should have a "-ffreeerstanding" or "-ffreefloating" or think of
> > > something funnier still environment as well, this problem has been there
> > > since the -ffreestanding flag has existed, but the problem is as old as
> > > the night.
> > >
> > > -fno-builtin might help a bit more, but just attack the problem at
> > > its root, like I suggested?
> > >
> >
> > In my experience, this is likely to do the opposite: it causes the
> > compiler to 'forget' the semantics of memcpy() and memset(), so that
> > explicit trivial calls will no longer be elided and replaced with
> > plain loads and stores (as it can no longer guarantee the equivalence)
>
> No, the compiler will never forget those semantics.  But if you tell it
> your function named memset() is not the actual standard memset -- via
> -fno-builtin-memset for example -- the compiler won't optimise things
> involving it quite as much.  You told it so eh?
>

That is exactly the point I am making. So how would this help in this case?

> You can also tell it not to have a __builtin_memset function, but in
> this particular case that won;t quite work, since the compiler does need
> to have that builtin available to do struct and array initialisations
> and the like.
>
> > > (This isn't a new problem, originally it showed up as "GCC replaces
> > > (part of) my memcpy() implementation by a (recursive) call to memcpy()"
> > > and, well, that doesn't quite work!)
> > >
> >
> > This needs to be fixed for Clang as well, so throwing GCC specific
> > flags at it will at best be a partial solution.
>
> clang says it is a 100% plug-in replacement for GCC, so they will have
> to accept all GCC flags.  And in many cases they do.  Cases where they
> don't are bugs.
>

Even if this were true, we support Clang versions today that do not
support -fno-tree-loop-distribute-patterns so my point stands.

> > It is not a complete solution, unfortunately, and I guess there may be
> > other situations (compiler/arch combinations) where this might pop up
> > again.
>
> Why do mem* not work in VDSOs?  Fix that, and all these problems
> disappear, and you do not need workrarounds :-)
>

Good point. We should just import memcpy and memset in the VDSO ELF metadata.

Not sure about static binaries, though: do those even use the VDSO?

