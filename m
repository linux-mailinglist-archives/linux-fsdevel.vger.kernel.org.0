Return-Path: <linux-fsdevel+bounces-27626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8F0962E96
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 19:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B21E1C217C4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 17:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE151A706B;
	Wed, 28 Aug 2024 17:32:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1809F142633;
	Wed, 28 Aug 2024 17:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.228.1.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724866353; cv=none; b=nLXAjrUDuJoFTbpBk7ZI6QV8oiBf8G8w6RJoCBe4zEFj1gxDR7jrmDE0eBadB4qAUvRTgMX08FBcJowxNE61uLiLf5gLLaJva7fRK3M/oeejIsUDOm9lIL2hh3WSLCauQk0AF3Um/qnMAnzyxDdCIl9K7LE39J6sHvBMiCuTS88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724866353; c=relaxed/simple;
	bh=oxW2+MTjMrJ+ZeeK8Liz6ctDws6qsgf5Ch9PI4RjS2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tip5iUbohSgFAXsqTbsZHvRNF9f2zcI7uexSQ5rRqywz82a9XM5ZuBBVjeJjmcPuLH4EM0JNbLQLO/GDGK5tvffo+8WPznJ4seh65/TbvDGXVrIF5DprV8YwBLbXuFSH1yciMp9DRWiYn4+1nrH54s8A+71GF41QOtQrTtfQdqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass smtp.mailfrom=kernel.crashing.org; arc=none smtp.client-ip=63.228.1.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.crashing.org
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 47SHPeo9010804;
	Wed, 28 Aug 2024 12:25:40 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 47SHPc5F010803;
	Wed, 28 Aug 2024 12:25:38 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Wed, 28 Aug 2024 12:25:38 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, "Theodore Ts'o" <tytso@mit.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        shuah <shuah@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 05/17] vdso: Avoid call to memset() by getrandom
Message-ID: <20240828172538.GI29862@gate.crashing.org>
References: <cover.1724309198.git.christophe.leroy@csgroup.eu> <5deb67090b214f0e6eae96b7c406546d1a16f89b.1724309198.git.christophe.leroy@csgroup.eu> <20240827180819.GB2049@sol.localdomain> <20240827225330.GC29862@gate.crashing.org> <Zs8HirKLk-SrwTIu@zx2c4.com> <fc19bf63-d519-46e2-be70-80202c85ff92@app.fastmail.com> <20240828124519.GE29862@gate.crashing.org> <CAMj1kXGmDmxy75eP=rf_fzKmg0g_FeKV43jk2G_gibnKZBtVww@mail.gmail.com> <20240828162025.GG29862@gate.crashing.org> <CAMj1kXHZPfr2Sz78UrgsdX-2uBp0D1sCnznQnz5ZyMdiJq6rAA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHZPfr2Sz78UrgsdX-2uBp0D1sCnznQnz5ZyMdiJq6rAA@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i

On Wed, Aug 28, 2024 at 07:12:55PM +0200, Ard Biesheuvel wrote:
> On Wed, 28 Aug 2024 at 18:24, Segher Boessenkool
> <segher@kernel.crashing.org> wrote:
> > > In my experience, this is likely to do the opposite: it causes the
> > > compiler to 'forget' the semantics of memcpy() and memset(), so that
> > > explicit trivial calls will no longer be elided and replaced with
> > > plain loads and stores (as it can no longer guarantee the equivalence)
> >
> > No, the compiler will never forget those semantics.  But if you tell it
> > your function named memset() is not the actual standard memset -- via
> > -fno-builtin-memset for example -- the compiler won't optimise things
> > involving it quite as much.  You told it so eh?
> 
> That is exactly the point I am making. So how would this help in this case?

I think we agree?  :-)

> > > This needs to be fixed for Clang as well, so throwing GCC specific
> > > flags at it will at best be a partial solution.
> >
> > clang says it is a 100% plug-in replacement for GCC, so they will have
> > to accept all GCC flags.  And in many cases they do.  Cases where they
> > don't are bugs.
> 
> Even if this were true, we support Clang versions today that do not
> support -fno-tree-loop-distribute-patterns so my point stands.

It is true.  Yes, this cause problems for their users.

> > > It is not a complete solution, unfortunately, and I guess there may be
> > > other situations (compiler/arch combinations) where this might pop up
> > > again.
> >
> > Why do mem* not work in VDSOs?  Fix that, and all these problems
> > disappear, and you do not need workrarounds :-)
> 
> Good point. We should just import memcpy and memset in the VDSO ELF metadata.

Yeah.  In many cases GCC will replace such calls by (faster and/or
smaller) inline code anyway, but when it does leave a call, there needs
to be an external function implementing it :-)

> Not sure about static binaries, though: do those even use the VDSO?

With "static binary" people usually mean "a binary not using any DSOs",
I think the VDSO is a DSO, also in this respect?  As always, -static
builds are *way* less problematic (and faster and smaller :-) )


Segher

