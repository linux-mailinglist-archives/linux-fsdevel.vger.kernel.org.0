Return-Path: <linux-fsdevel+bounces-27120-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA1B95EB93
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 10:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DE761C2157D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 08:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4247B13B59E;
	Mon, 26 Aug 2024 08:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="G+es6dtJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6B1286A8;
	Mon, 26 Aug 2024 08:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724660227; cv=none; b=D88tFrDtpcJLWryTMDFXDbmZl7OQRsbwDskSl+MMl9Bs6DAzdaAhHDFVO0v6bh5a1Cx1ZEDTjIdjqFlemR1mNedgvWXmYAhTvo2OCNvsQf7uGNo2CHnq1r2ZpbeKwi428ZRGSNhMBES7swUdm1TuuJNvKBzo0+7819/VONayN+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724660227; c=relaxed/simple;
	bh=IvEpShGxn6iKlFKmrYxW8NwT/Hu8i42cJKA1HH2M8xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JmBAkN7fs+oyg5dUCVNoQ+qUuTM9pqqe8anR+bK2SESCDDeJwp6ub7vvheuPsMYV6fxLxLGacYITkvQs7gT2y5UF10KHX0uJWvHrfiRY9/uYL29OpWabaRJSFcdpXKZLhANRibG+GqJr1EhgCuL6lrChi7OCGGfzVhBhX4wkeUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=G+es6dtJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1164C8CDD3;
	Mon, 26 Aug 2024 08:17:04 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="G+es6dtJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1724660223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HBUmQTDhGzpRlPPsawchQxtsrEP7CCWrGrVX0xuqkFU=;
	b=G+es6dtJI+WdfXP/RQZRpJVmw+L7y4//5XG1cNyFbgtT4lVYwh1zPdS8zRYE7pYEOQOEki
	TsL3YKWBg+PZmKHNR6I88paWRAUxfSXKDLMR4TfUocs2r4RP+Vb9eYYFuZRfwZEIQam7j3
	UacCwC9xjKUV4ZgUbKdPU2VtnWlD9kk=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id cf114949 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Aug 2024 08:17:02 +0000 (UTC)
Date: Mon, 26 Aug 2024 10:16:54 +0200
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
Subject: Re: [PATCH v2 06/17] vdso: Change getrandom's generation to unsigned
 long
Message-ID: <Zsw59hqqbixw3A66@zx2c4.com>
References: <cover.1724309198.git.christophe.leroy@csgroup.eu>
 <525b48eb79978ddba2d1b8ee23b27bd6c5b0b4ee.1724309198.git.christophe.leroy@csgroup.eu>
 <Zswzu1l3xO99KN3I@zx2c4.com>
 <7d58be73-a8e5-4ec7-bbdc-238b0c25c77b@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7d58be73-a8e5-4ec7-bbdc-238b0c25c77b@csgroup.eu>

On Mon, Aug 26, 2024 at 10:01:17AM +0200, Christophe Leroy wrote:
> 
> 
> Le 26/08/2024 à 09:50, Jason A. Donenfeld a écrit :
> > On Thu, Aug 22, 2024 at 09:13:14AM +0200, Christophe Leroy wrote:
> >> Performing SMP atomic operations on u64 fails on powerpc32.
> >>
> >> Random driver generation is handled as unsigned long not u64,
> >> see for instance base_cnrg or struct crng.
> >>
> >> Use the same type for vDSO's getrandom as it gets copied
> >> from the above. This is also in line with the local
> >> current_generation which is already an unsigned long.
> > 
> > This isn't going to work when 32-bit userspace tries to access a 64-bit
> > kernel.
> > 
> > I had "fixed" this with a vdso_kernel_ulong type way back in an earlier
> > version: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flkml%2F20240528122352.2485958-5-Jason%40zx2c4.com%2F%23Z31include%3Avdso%3Atypes.h&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C41747dd989164267c1cc08dcc5a3c424%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638602554376441761%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=Tf9ShSN6aOOFZ1HymAmHhj0xhQ6BUtHJX95t50gsp9k%3D&reserved=0
> > 
> > But tglx pointed out in that thread that this actually isn't necessary:
> > 
> > | All of this is pointless because if a 32-bit application runs on a
> > | 64-bit kernel it has to use the 64-bit 'generation'. So why on earth do
> > | we need magic here for a 32-bit kernel?
> > |
> > | Just use u64 for both and spare all this voodoo. We're seriously not
> > | "optimizing" for 32-bit kernels.
> > |
> > | All what happens on a 32-bit kernel is that the RNG will store the
> > | unsigned long (32bit) generation into a 64bit variable:
> > |
> > | 	smp_store_release(&_vdso_rng_data.generation, next_gen + 1);
> > |
> > | As the upper 32bit are always zero, there is no issue vs. load store
> > | tearing at all. So there is zero benefit for this aside of slightly
> > | "better" user space code when running on a 32-bit kernel. Who cares?
> > 
> > So I just got rid of it and used a u64 as he suggested.
> > 
> > However, there's also an additional reason why it's not worth churning
> > further over this - because VM_DROPPABLE is 64-bit only (due to flags in
> > vma bits), likely so is vDSO getrandom() for the time being. So I think
> > it makes more sense to retool this series to be ppc64, and then if you
> > really really want 32-bit and can convince folks it matters, then all of
> > these parts (for example, here, the fact that the smp helper doesn't
> > want to tear) can be fixed up in a separate series.
> 
> So yes I really really want it on ppc32 because this is the only type of 
> boards I have and this is really were we need getrandom() to be 
> optimised, indeed ppc64 was sherry-on-the-cake in my series, I just 
> added it because it was easy to do after doing ppc32.

I saw that you did in fact find a bit on ppc32 for VM_DROPPABLE. So it
looks at least possible. Because of this generation counter business, I
still think it might make sense to do in two steps, though, first doing
64-bit, and then doing 32-bit after.

As for the generation counter error you're seeing, I guess what we want
is smp_store_release memory ordering semantics, but letting tearing
happen (since the upper 32-bits will be zero anyway). I'm not sure the
best way to do this, whether it's a new helper, or doing a WRITE_ONCE
together with an smp barrier, or what. But I imagine it's something like
that.

Jason

