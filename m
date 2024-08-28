Return-Path: <linux-fsdevel+bounces-27575-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB0E9627D1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 14:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92FACB23919
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 12:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818F5187FE7;
	Wed, 28 Aug 2024 12:52:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3833C17BEC6;
	Wed, 28 Aug 2024 12:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.228.1.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724849524; cv=none; b=jSz6EkZDlHxNceCV9EcQwLrpy3i8naIecgXqAyOfjUhRpvnlixEeyw0uQIiH1FTz8GQcST+nNtkG8QLYXu5CFXVS2tf2UVumApj8rcamJ13ucx0qQ/OB6CbSGKerv2/wEx70ckh4XGytNjNIWaPDuoSQPPx/+YwT46TPmqF/6vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724849524; c=relaxed/simple;
	bh=z7QBJwrDqdm5+RXcwT0mLKPUzajm3VYvAwjbZSHkH6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aFO2CmvpJwinSwXIJsYB9rfcswv3OoJYTT7f1eSGdkUtCMfhwBiRAUy0AEMd3FtHXfj9eR7zb3gNqUpzaUHCtU7QbDWyWWAmLPCjS/2YoPM63R7TUEQH+R5yl9QIvkSiZyXmSjke2RfZEt+N/F/QQ1HXH5igemFFwigUcfFcxuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass smtp.mailfrom=kernel.crashing.org; arc=none smtp.client-ip=63.228.1.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.crashing.org
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 47SCjLrv031636;
	Wed, 28 Aug 2024 07:45:21 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 47SCjJbM031635;
	Wed, 28 Aug 2024 07:45:19 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Wed, 28 Aug 2024 07:45:19 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Jason A . Donenfeld" <Jason@zx2c4.com>,
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
Message-ID: <20240828124519.GE29862@gate.crashing.org>
References: <cover.1724309198.git.christophe.leroy@csgroup.eu> <5deb67090b214f0e6eae96b7c406546d1a16f89b.1724309198.git.christophe.leroy@csgroup.eu> <20240827180819.GB2049@sol.localdomain> <20240827225330.GC29862@gate.crashing.org> <Zs8HirKLk-SrwTIu@zx2c4.com> <fc19bf63-d519-46e2-be70-80202c85ff92@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc19bf63-d519-46e2-be70-80202c85ff92@app.fastmail.com>
User-Agent: Mutt/1.4.2.3i

On Wed, Aug 28, 2024 at 12:24:12PM +0000, Arnd Bergmann wrote:
> On Wed, Aug 28, 2024, at 11:18, Jason A. Donenfeld wrote:
> > On Tue, Aug 27, 2024 at 05:53:30PM -0500, Segher Boessenkool wrote:
> >> On Tue, Aug 27, 2024 at 11:08:19AM -0700, Eric Biggers wrote:
> >> > 
> >> > Is there a compiler flag that could be used to disable the generation of calls
> >> > to memset?
> >> 
> >> -fno-tree-loop-distribute-patterns .  But, as always, read up on it, see
> >> what it actually does (and how it avoids your problem, and mostly: learn
> >> what the actual problem *was*!)
> >
> > This might help with various loops, but it doesn't help with the matter
> > that this patch fixes, which is struct initialization. I just tried it
> > with the arm64 patch to no avail.
> 
> Maybe -ffreestanding can help here? That should cause the vdso to be built
> with the assumption that there is no libc, so it would neither add nor
> remove standard library calls. Not sure if that causes other problems,
> e.g. if the calling conventions are different.

"GCC requires the freestanding
environment provide 'memcpy', 'memmove', 'memset' and 'memcmp'."

This is precisely to implement things like struct initialisation.  Maybe
we should have a "-ffreeerstanding" or "-ffreefloating" or think of
something funnier still environment as well, this problem has been there
since the -ffreestanding flag has existed, but the problem is as old as
the night.

-fno-builtin might help a bit more, but just attack the problem at
its root, like I suggested?

(This isn't a new problem, originally it showed up as "GCC replaces
(part of) my memcpy() implementation by a (recursive) call to memcpy()"
and, well, that doesn't quite work!)


Segher

