Return-Path: <linux-fsdevel+bounces-63022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 140F9BA8F77
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 13:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A064116FAB4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 11:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44CA2FF67B;
	Mon, 29 Sep 2025 11:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RO7GZ0if"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2E92E7F08;
	Mon, 29 Sep 2025 11:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759143853; cv=none; b=skgYh9L9KqE893SqZqBv1t+fz+Qlv6UEK/8TBuIoVskFxKzOWg7+djByebDnOzHr5Um8k4W1Id6k+TJydTqCMao3SkuUxahALMbiEpnURp0BhnMBMLzlUnwX64V3Tmuj5wVvEKDN4gDpbWGU9mobNjs5MVVVE0JxdzVOrQLZy3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759143853; c=relaxed/simple;
	bh=g57aRuPp47bsdG23g5OwqcDQ0YJ7IWpQzyJBHR/uGq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rEKpKb4LQqHBvHWCimRTRX1bqcg/Rv/hFJhqneCNC6o5bIfk2kpREY/ifW7wyjvEXRzgn8AWcQBshOt/JzWT58PFMaP441QeE3Wf7gDwEwg1O1JOMn+mRLxaEgoHr+aBK3C9ET99Vhvs0vpGXclk0DeuCPvrLdLFtANLlSiqJ/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RO7GZ0if; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kZxsy4ehieQIjfLWTzJ+0WnOyHLVTM4StVaGaTf2H2M=; b=RO7GZ0ifeCyolkGY1Y7ATx6sss
	e//DjYdx0nRYSUIreaoUR++VLt+tyLZ1Eb/Hxlu4pY1uiwp8PPy6P8Koex0e43ru9hP/6zV2+ku/O
	8qVYKgQyCOXxjTSHhKVW5yDFQ+fmxIZaIeAKdp6MOyNkL17jgP9wO0lbGXgBm5ZohhpN1NeYbTnTU
	tB0u/XlKTRloBeLGuHUNINGnoMIDrPUaql9LQfDaNK8baXt5fxfVJ3HhoE12p+ELHvx/7vupEtwL8
	DWhI/M5s9ZguDkUvDKrxaXoc9Is7GsJFlY0ELM9nt/OLIY7nrGA9ubRFiBDcMx6mzU+toyK/faqbg
	gTdUlCsQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3Bfk-0000000C4Ix-3xC7;
	Mon, 29 Sep 2025 11:04:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 10F5830039F; Mon, 29 Sep 2025 13:04:00 +0200 (CEST)
Date: Mon, 29 Sep 2025 13:04:00 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Nathan Chancellor <nathan@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	kernel test robot <lkp@intel.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	x86@kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [patch V2a 2/6] kbuild: Disable CC_HAS_ASM_GOTO_OUTPUT on clang
 < version 17
Message-ID: <20250929110400.GL3419281@noisy.programming.kicks-ass.net>
References: <20250916163004.674341701@linutronix.de>
 <20250916163252.100835216@linutronix.de>
 <20250916184440.GA1245207@ax162>
 <87ikhi9lhg.ffs@tglx>
 <87frcm9kvv.ffs@tglx>
 <CAMuHMdVvAQbN8g7TJyK2MCLusGPwDbzrQJHw8uxDhOvjAh7_Pw@mail.gmail.com>
 <20250929100852.GD3245006@noisy.programming.kicks-ass.net>
 <CAMuHMdW_5QOw69Uyrrw=4BPM3DffG2=k5BAE4Xr=gfei7vV=+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdW_5QOw69Uyrrw=4BPM3DffG2=k5BAE4Xr=gfei7vV=+g@mail.gmail.com>

On Mon, Sep 29, 2025 at 12:58:14PM +0200, Geert Uytterhoeven wrote:
> On Mon, 29 Sept 2025 at 12:09, Peter Zijlstra <peterz@infradead.org> wrote:
> > On Mon, Sep 29, 2025 at 11:38:17AM +0200, Geert Uytterhoeven wrote:
> >
> > > > +       # Detect buggy clang, fixed in clang-17
> > > > +       depends on $(success,echo 'void b(void **);void* c();int f(void){{asm goto("jmp %l0"::::l0);return 0;l0:return 1;}void *x __attribute__((cleanup(b))) = c();{asm goto("jmp %l0"::::l1);return 2;l1:return 1;}}' | $(CC) -x c - -c -o /dev/null)
> > >
> > > This is supposed to affect only clang builds, right?  I am using
> > > gcc version 13.3.0 (Ubuntu 13.3.0-6ubuntu2~24.04) to build for
> > > arm32/arm64/riscv, and thus have:
> > >
> > >     CONFIG_CC_IS_GCC=y
> > >
> > > Still, this commit causes
> > >
> > >     CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
> > >     CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT=y
> > >
> > > to disappear from my configs? Is that expected?
> >
> > Not expected -- that means your GCC is somehow failing that test case.
> > Ideally some GCC person will investigate why this is so.
> 
> Oh, "jmp" is not a valid mnemonic on arm and riscv, and several other
> architectures...

Ah, d'0h indeed.

void b(void **);void* c();int f(void){{asm goto(""::::l0);return 0;l0:return 1;}void *x __attribute__((cleanup(b))) = c();{asm goto(""::::l1);return 2;l1:return 1;}}

Seems to still finger the issue on x86_64. That should build on !x86
too, right?

