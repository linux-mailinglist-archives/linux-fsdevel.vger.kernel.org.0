Return-Path: <linux-fsdevel+bounces-27116-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E6E95EB27
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 10:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B0FB1F25366
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 08:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F0013C693;
	Mon, 26 Aug 2024 07:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="kQHi3+H3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAE413B58F;
	Mon, 26 Aug 2024 07:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724658633; cv=none; b=jDk9KQDDE7842X/Hopo0DJMEiu+pJN13CbzrBJST+3/540uykiZ2NGSNEtmwP8yAdFT5z25H4DRQM6283m0HSiTkkSVVmyCVvR+HbZK9vCUa+EFeMGKM2rT5hKs6340xZBscykcVRgR0VZMe+QTdj1k5Ma7z6UyxH77KyT78Ph0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724658633; c=relaxed/simple;
	bh=KeABgBOSoLm17wZZI/r7qcPmjAXdHdKZRqOmKOrrI6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MzCLWH6FD5dgI+UZi39H5m2tdFvOS9mA59XjbsPvxgEvU1HjyNJg8fRaC9Dzpb0Z1+ZAl5JDch1l+fTNzDIlWlY90/m3Ejy3ACW8b2VsPsRK6I4hg5CY1anuaoEIs3AIJIwMNI8g6ooIl0xtwYuoCVRPNErypaF18JWjK2c1CQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=kQHi3+H3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D6AEC4DE00;
	Mon, 26 Aug 2024 07:50:30 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="kQHi3+H3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1724658628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5QLg9tCESPGWijcOQ8JKikCNIoatGO4axd4GWvhdYYE=;
	b=kQHi3+H3+KvCec2w2M7PlU9vKWJw4MmxxAJGd8KaVakXHO8fuSwuvQEqHIKMXDXig3bKh+
	ifsFzp2/VTZPMw2Xlzn3wncTqsCSsCMf5EeNfxJMaXsiP8wA6aGHQYqp29D4T5aekQPuNp
	d0TD8Rv85cFT6vXrvtP1KLsRK1jqaR4=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8cf2c087 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Aug 2024 07:50:28 +0000 (UTC)
Date: Mon, 26 Aug 2024 09:50:19 +0200
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
Message-ID: <Zswzu1l3xO99KN3I@zx2c4.com>
References: <cover.1724309198.git.christophe.leroy@csgroup.eu>
 <525b48eb79978ddba2d1b8ee23b27bd6c5b0b4ee.1724309198.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <525b48eb79978ddba2d1b8ee23b27bd6c5b0b4ee.1724309198.git.christophe.leroy@csgroup.eu>

On Thu, Aug 22, 2024 at 09:13:14AM +0200, Christophe Leroy wrote:
> Performing SMP atomic operations on u64 fails on powerpc32.
> 
> Random driver generation is handled as unsigned long not u64,
> see for instance base_cnrg or struct crng.
> 
> Use the same type for vDSO's getrandom as it gets copied
> from the above. This is also in line with the local
> current_generation which is already an unsigned long.

This isn't going to work when 32-bit userspace tries to access a 64-bit
kernel.

I had "fixed" this with a vdso_kernel_ulong type way back in an earlier
version: https://lore.kernel.org/lkml/20240528122352.2485958-5-Jason@zx2c4.com/#Z31include:vdso:types.h

But tglx pointed out in that thread that this actually isn't necessary:

| All of this is pointless because if a 32-bit application runs on a
| 64-bit kernel it has to use the 64-bit 'generation'. So why on earth do
| we need magic here for a 32-bit kernel?
| 
| Just use u64 for both and spare all this voodoo. We're seriously not
| "optimizing" for 32-bit kernels.
|
| All what happens on a 32-bit kernel is that the RNG will store the
| unsigned long (32bit) generation into a 64bit variable:
| 
| 	smp_store_release(&_vdso_rng_data.generation, next_gen + 1);
| 
| As the upper 32bit are always zero, there is no issue vs. load store
| tearing at all. So there is zero benefit for this aside of slightly
| "better" user space code when running on a 32-bit kernel. Who cares?

So I just got rid of it and used a u64 as he suggested.

However, there's also an additional reason why it's not worth churning
further over this - because VM_DROPPABLE is 64-bit only (due to flags in
vma bits), likely so is vDSO getrandom() for the time being. So I think
it makes more sense to retool this series to be ppc64, and then if you
really really want 32-bit and can convince folks it matters, then all of
these parts (for example, here, the fact that the smp helper doesn't
want to tear) can be fixed up in a separate series.

Jason

