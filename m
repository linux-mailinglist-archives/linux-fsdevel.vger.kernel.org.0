Return-Path: <linux-fsdevel+bounces-27176-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD2095F2A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 15:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 174C81F249DB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 13:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83AE187870;
	Mon, 26 Aug 2024 13:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Wa823DeW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090BC171E76;
	Mon, 26 Aug 2024 13:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724678259; cv=none; b=g5Xe4IghPfCTwQ/LAqiYqAMTLuis33mySQIBS44HZ9zHOs0IPbFC88FMayUlEfQhE5LhRNHdqYSTkFrf13sqef4fFklneyMdafZTwvCq9aGwW/iGlEn/lPiPR0FfI9rMVk9AUefSSgaGdUVARrEFDI53gYkLR1dONEi7TASbpwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724678259; c=relaxed/simple;
	bh=y4h+UhYvwkkoLB08HaRdPZs7NTd/kmnpi3vrcRel22g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HrTao3KhDRbArjTAk1P993AgmcuFzUX5C7O8qYtUw5D1mPenilJVhntnTQNQ/zwATEhJOblmcozk5iDwP6W7FKm8opTjBYJw14OhxmZitcF42uBftcGhG0Dl/qyfFgDeSz6E6uZwwLhlth+wKam9xs6tQgYyd2GdtoiDy/9VkSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=Wa823DeW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FCF2C581A8;
	Mon, 26 Aug 2024 13:17:36 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Wa823DeW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1724678254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OUCY//gcsGifesZ1olnZEnGellJ2FsUj9xgqUPmJgSw=;
	b=Wa823DeWZM9H6FLazF9Mr7TU1lpT7Ca2BQGMHRpVMu5+STfZJ5yOG7/csTW2UT9kZ/KBWj
	m4Pcyxf1F3yWLOjqfmxbtEC+RXdMlDtMhdJ18zwVpt75LqV+IwhUjmTamCySjlInVeSQ2M
	Z/Qj8HfmknEyBTYjbzrvjxsG25vCJRA=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7d5cb29d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Aug 2024 13:17:33 +0000 (UTC)
Date: Mon, 26 Aug 2024 15:17:32 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
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
Subject: Re: [PATCH v2 02/17] vdso: Clean header inclusion in getrandom
Message-ID: <ZsyAbP4GOP1eCSI8@zx2c4.com>
References: <cover.1724309198.git.christophe.leroy@csgroup.eu>
 <2a081f1fff5e40f496153f8e0162fc7ec5adab2e.1724309198.git.christophe.leroy@csgroup.eu>
 <Zsw3xMoX2EI5UUs1@zx2c4.com>
 <7e519ba2-0293-4320-84bf-44f930fc286d@csgroup.eu>
 <ZsxDssNPbLkcPetJ@zx2c4.com>
 <51adbe91-3c3a-4baa-bb39-29df98a6eea5@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <51adbe91-3c3a-4baa-bb39-29df98a6eea5@csgroup.eu>

On Mon, Aug 26, 2024 at 12:45:40PM +0200, Christophe Leroy wrote:
> 
> 
> Le 26/08/2024 à 10:58, Jason A. Donenfeld a écrit :
> > On Mon, Aug 26, 2024 at 10:37:49AM +0200, Christophe Leroy wrote:
> >>
> >>
> >> Le 26/08/2024 à 10:07, Jason A. Donenfeld a écrit :
> >>> On Thu, Aug 22, 2024 at 09:13:10AM +0200, Christophe Leroy wrote:
> >>>>    
> >>>> +#define _PAGE_SIZE (1UL << CONFIG_PAGE_SHIFT)
> >>>> +#define _PAGE_MASK (~(_PAGE_SIZE - 1))
> >>>
> >>> If PAGE_SIZE isn't defined at this point, why not just call it PAGE_SIZE
> >>> instead of _PAGE_SIZE? But if that's the case, why not put the vdso
> >>> definition of PAGE_SIZE into some vdso header included by this file?
> >>
> >> It was working ok on powerpc but on x86 I got:
> > 
> > Seems like there might be some more fiddling to do, then? Or did you
> > conclude it's impossible?
> 
> Maybe someone who knows x86 in details could helps but after a first 
> look I gave up because it looks very x86 specific, indeed that's 
> x86/asm/vdso/gettimeofday.h that pulls several x86/asm/ headers , and 
> the same type of issue might arise for any new architecture coming in.
> 
> For me it looked cleaner to just do as commit cffaefd15a8f ("vdso: Use 
> CONFIG_PAGE_SHIFT in vdso/datapage.h") and not use PAGE_SIZE at all. But 
> I didn't want to directly use (1UL << CONFIG_PAGE_SHIFT) and (~(1UL << 
> (CONFIG_PAGE_SHIFT - 1))) in the code directly hence the new macros with 
> a leading underscore to avoid any conflict with existing macros.

If that's the case and you can't sort it out or it's impossible, then it
seems like adding #ifndef PAGE_SIZE, #define... inside of some vdso header
(not inside getrandom.c) would make sense.

Jason

