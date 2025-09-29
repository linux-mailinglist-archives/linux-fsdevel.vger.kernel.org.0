Return-Path: <linux-fsdevel+bounces-63014-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D10EBA8D1B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 12:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F8FD189813F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 10:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38D62FABFA;
	Mon, 29 Sep 2025 10:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WsnY2zux"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB0D2E06E6;
	Mon, 29 Sep 2025 10:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759140547; cv=none; b=ihk++YKj/6dK4LPwCtCWIAAgW1UuFjXnCLJQiu484f/9fDGY+iQSxlMfLOFdgyuqVMg+xsL5ga1C+W1iNbHxF5XZPDfJuPpk/lI9SyoJJFYeqxb2qyccZ1GNtfzextzEFLBa5n3aYqAu0QlX+Wyf7x0jRhP2tYfTqi1d7+rXis4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759140547; c=relaxed/simple;
	bh=PF5ehtjQUpKClLEL2ZeAj2mPYI53kL7T3qDiANs061M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SPzRGFh+KigbCxQYQ3Y6IRicCmzy0IgayrOd86+FxSroGGCqrGGXdns0yy4PDHFmV6cvX5j6PE0PlvDpU46rEyNaJF0FbCvM/e4ehUo2hE1bCpCglwbWsFaAYCv7dJ7rk16AlDgIdvG670I1n0xqSlPgwspOvQ7d7oORHAThuHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WsnY2zux; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XnJhiN601P3ew198/i9MwVOF6i7+38zU2SJEfw4YPKo=; b=WsnY2zux4CAPir1U6HXtb1DJ8Z
	44lwryJj3mziO8Wkb/2id+nIx5+ITV4KcHimY9dJd5z3/Bp/YMWjHB6xLc80D6fO9IjP7OYLTXMkJ
	HXLrHsA2+epLKqTOGXQMfz2gTiWc7D6dF37ClT0LljfqhM8CJe/kBnl5tH6OwJ2LaFHj7duQ9A6iM
	N4P517Rnw/gb6Ulp6QRZjTqiK3e/YDACh49l129LdijDKavqxc2VOzEksx+vgut/HNfnJaEGwWfkq
	JQCl9r4o2RhCvOx71tXLHUJaTTwO0rm2KOnGkl7UsvEGuofMlSWjX4jr7ZQR6E0oW48Egrm59sKq8
	7Wt7H1Rw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3AoP-0000000Bz2f-2aYv;
	Mon, 29 Sep 2025 10:08:54 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 35245300359; Mon, 29 Sep 2025 12:08:52 +0200 (CEST)
Date: Mon, 29 Sep 2025 12:08:52 +0200
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
Message-ID: <20250929100852.GD3245006@noisy.programming.kicks-ass.net>
References: <20250916163004.674341701@linutronix.de>
 <20250916163252.100835216@linutronix.de>
 <20250916184440.GA1245207@ax162>
 <87ikhi9lhg.ffs@tglx>
 <87frcm9kvv.ffs@tglx>
 <CAMuHMdVvAQbN8g7TJyK2MCLusGPwDbzrQJHw8uxDhOvjAh7_Pw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVvAQbN8g7TJyK2MCLusGPwDbzrQJHw8uxDhOvjAh7_Pw@mail.gmail.com>

On Mon, Sep 29, 2025 at 11:38:17AM +0200, Geert Uytterhoeven wrote:

> > +       # Detect buggy clang, fixed in clang-17
> > +       depends on $(success,echo 'void b(void **);void* c();int f(void){{asm goto("jmp %l0"::::l0);return 0;l0:return 1;}void *x __attribute__((cleanup(b))) = c();{asm goto("jmp %l0"::::l1);return 2;l1:return 1;}}' | $(CC) -x c - -c -o /dev/null)
> 
> This is supposed to affect only clang builds, right?  I am using
> gcc version 13.3.0 (Ubuntu 13.3.0-6ubuntu2~24.04) to build for
> arm32/arm64/riscv, and thus have:
> 
>     CONFIG_CC_IS_GCC=y
> 
> Still, this commit causes
> 
>     CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
>     CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT=y
> 
> to disappear from my configs? Is that expected?

Not expected -- that means your GCC is somehow failing that test case.
Ideally some GCC person will investigate why this is so.

