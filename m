Return-Path: <linux-fsdevel+bounces-27578-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A46962803
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 14:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04A3A1C23F41
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 12:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45426184114;
	Wed, 28 Aug 2024 12:58:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE42537F5;
	Wed, 28 Aug 2024 12:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.228.1.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724849915; cv=none; b=WuXiHufp/p1NjI8gFvfN/2SeqxtCHJ8QPjBry9fMVH4U5HEB09CjyiEnt0oId0RHirVhnOh8OXcx2ms3ov1fJBoI0dbtpMpWxLjDi8ejJi2p3SfmUSMHEDExAdaMvaswMYYZFDh9K1CJc/lNEjn4RZrwegKYUiRczFGC7SbA9HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724849915; c=relaxed/simple;
	bh=Vsy8ov7YycJAvMDRkUjOS6q4lvRBacsBGTW0GdcGV0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MyO+kwK+A+UIiuoUTF3ug6/w+GbdhYLxG5bc0XJjzI23wlPvDhXuHV2LkBMQ+SjhI1N+fzD3XGCt+2KGFmuh31OeOQAuaYrp+H6u/1Si4a9FNaH+yPENLqL6qahJedUtGmF5uqrL1T+5GG80/HzDAO8ewO9a9H8mx8L8Iw0nUa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass smtp.mailfrom=kernel.crashing.org; arc=none smtp.client-ip=63.228.1.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.crashing.org
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 47SCptJf031924;
	Wed, 28 Aug 2024 07:51:55 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 47SCpru5031923;
	Wed, 28 Aug 2024 07:51:53 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Wed, 28 Aug 2024 07:51:53 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Eric Biggers <ebiggers@kernel.org>,
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
Message-ID: <20240828125153.GF29862@gate.crashing.org>
References: <cover.1724309198.git.christophe.leroy@csgroup.eu> <5deb67090b214f0e6eae96b7c406546d1a16f89b.1724309198.git.christophe.leroy@csgroup.eu> <20240827180819.GB2049@sol.localdomain> <20240827225330.GC29862@gate.crashing.org> <Zs8HirKLk-SrwTIu@zx2c4.com> <fc19bf63-d519-46e2-be70-80202c85ff92@app.fastmail.com> <CAHmME9rjH4Ek3e8jmBvRp3wy+mrzJAeYxk5=o+OHjoT5sTOQPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHmME9rjH4Ek3e8jmBvRp3wy+mrzJAeYxk5=o+OHjoT5sTOQPg@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i

On Wed, Aug 28, 2024 at 02:26:08PM +0200, Jason A. Donenfeld wrote:
> On Wed, Aug 28, 2024 at 2:24 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
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
> >From https://gcc.gnu.org/bugzilla/show_bug.cgi?id=90701:
> 
> | You need -ffreestanding but that is documented to emit memset and
> memcpy still.

Yeah.

'-nostdlib'
     Do not use the standard system startup files or libraries when
     linking.

This won't help a bit, the compiler will still optimise your
initialisation loop to a memset() call, it just won't link to libgcc.a
and crt*.o and its ilk (which is not where mem* are implemented in the
first place!)


Segher

