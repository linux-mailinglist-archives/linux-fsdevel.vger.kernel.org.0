Return-Path: <linux-fsdevel+bounces-63058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AB0BAAAD6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 00:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1270F192172B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 22:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929AC221FAC;
	Mon, 29 Sep 2025 22:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gQwUWzxe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ly9OMH4j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2AF139D;
	Mon, 29 Sep 2025 22:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759183550; cv=none; b=C9amo7ZZobRkRixAxHdeDm1FcDR6xJKPYKo0RMiVsU8Sv1Kk67GqphVNlh6oGJK9FAgQAMHtPcw/hbjHd//XBNtGT22eay7G6ajnqQenPsUkzz4Langza/mnRG0ITDXvT42qvXO5HSXoKW3jKJjLcEKeZMl9gUvxT+byZj11Eo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759183550; c=relaxed/simple;
	bh=rOsdL/ySNLyc6G/qhgkHuZFK9oYRYqVacf1O//uzT6w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D5vnRQ/9v4U0jXPw6nrXDqp1Qo4FelaP84K9dACQlcWWF+mlhoze/nVx9FXERPPkQptrq5aYhsY8wLnb41PWDLosRRsDwLo3y8lz8NOnhEkcXnB+mNt2vJdx6WB0P5q1vF9kwlK07AZJfLAeM7ACSKyiWrY+n4kQ2Y7HJUZfmvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gQwUWzxe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ly9OMH4j; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1759183545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FJuiFlK+/0gZsXP4o7JYtSO7IuSV4/7Gt5reigitHHY=;
	b=gQwUWzxeYhEtgDVeU7AFLFiTvqPA/t8/CVreyWg9hookFTLbl5d1p3chrPo0kdQP4aJYsg
	f88RP4R6WoD0NaZPN/8illU88mNkaCXiVxVuGVzGC4ENq5WOy3L7DO/z2Xr8pBx+tIfLQI
	ddewEF4utQ8DakSCVbwU7Hib589snTbcDr+ZFdezzSQA8cduwKY9fYMwbiLRAv8EKTo126
	HydbhDBkooGA1JLbYfmeyj3ZKis1ZvGdjUt6HUv7jPfo9vEahb+LMgaX+MAvbhooG/Ad58
	nA6tmYetPas1K92fc9a2cCM0mbaLrsoF4ikCU7tyQYZMVw+IjNlYBRfmmIrXjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1759183545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FJuiFlK+/0gZsXP4o7JYtSO7IuSV4/7Gt5reigitHHY=;
	b=ly9OMH4jtXHbxSRZbH90LuofY4jRb5hJH+PURo3Jqa7oX1J/36nMhA6wh8CuBkzkKQsVbt
	r3Qn/TVxygB37OCg==
To: Peter Zijlstra <peterz@infradead.org>, Geert Uytterhoeven
 <geert@linux-m68k.org>
Cc: Nathan Chancellor <nathan@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, kernel test robot <lkp@intel.com>,
 Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, =?utf-8?Q?Andr=C3=A9?= Almeida
 <andrealmeid@igalia.com>, x86@kernel.org, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [patch V2a 2/6] kbuild: Disable CC_HAS_ASM_GOTO_OUTPUT on clang
 < version 17
In-Reply-To: <20250929110400.GL3419281@noisy.programming.kicks-ass.net>
References: <20250916163004.674341701@linutronix.de>
 <20250916163252.100835216@linutronix.de> <20250916184440.GA1245207@ax162>
 <87ikhi9lhg.ffs@tglx> <87frcm9kvv.ffs@tglx>
 <CAMuHMdVvAQbN8g7TJyK2MCLusGPwDbzrQJHw8uxDhOvjAh7_Pw@mail.gmail.com>
 <20250929100852.GD3245006@noisy.programming.kicks-ass.net>
 <CAMuHMdW_5QOw69Uyrrw=4BPM3DffG2=k5BAE4Xr=gfei7vV=+g@mail.gmail.com>
 <20250929110400.GL3419281@noisy.programming.kicks-ass.net>
Date: Tue, 30 Sep 2025 00:05:44 +0200
Message-ID: <87qzvo3oef.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Sep 29 2025 at 13:04, Peter Zijlstra wrote:
> On Mon, Sep 29, 2025 at 12:58:14PM +0200, Geert Uytterhoeven wrote:
>> On Mon, 29 Sept 2025 at 12:09, Peter Zijlstra <peterz@infradead.org> wrote:
>> > On Mon, Sep 29, 2025 at 11:38:17AM +0200, Geert Uytterhoeven wrote:
>> >
>> > > > +       # Detect buggy clang, fixed in clang-17
>> > > > +       depends on $(success,echo 'void b(void **);void* c();int f(void){{asm goto("jmp %l0"::::l0);return 0;l0:return 1;}void *x __attribute__((cleanup(b))) = c();{asm goto("jmp %l0"::::l1);return 2;l1:return 1;}}' | $(CC) -x c - -c -o /dev/null)
>> > >
>> > > This is supposed to affect only clang builds, right?  I am using
>> > > gcc version 13.3.0 (Ubuntu 13.3.0-6ubuntu2~24.04) to build for
>> > > arm32/arm64/riscv, and thus have:
>> > >
>> > >     CONFIG_CC_IS_GCC=y
>> > >
>> > > Still, this commit causes
>> > >
>> > >     CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
>> > >     CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT=y
>> > >
>> > > to disappear from my configs? Is that expected?
>> >
>> > Not expected -- that means your GCC is somehow failing that test case.
>> > Ideally some GCC person will investigate why this is so.
>> 
>> Oh, "jmp" is not a valid mnemonic on arm and riscv, and several other
>> architectures...
>
> Ah, d'0h indeed.
>
> void b(void **);void* c();int f(void){{asm goto(""::::l0);return 0;l0:return 1;}void *x __attribute__((cleanup(b))) = c();{asm goto(""::::l1);return 2;l1:return 1;}}
>
> Seems to still finger the issue on x86_64. That should build on !x86
> too, right?

Ooops.

Thanks for the quick fix!

       tglx

