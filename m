Return-Path: <linux-fsdevel+bounces-70694-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 432FACA4A72
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 18:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E012A31022C3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 16:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449392F6160;
	Thu,  4 Dec 2025 16:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2rWkL1Xy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fx0jXRJ2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F3928507B;
	Thu,  4 Dec 2025 16:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764867385; cv=none; b=odVAH7rXmfE8Uu3CF/Tbf/3tfHAy/Mul1QW8Fou3XTpnqRNypRe6mUffFf8aePEPLnC6gjemBIaWwcgxWuAMLiowgTk0Hhy1Vs3rklI3YHQhjac3nAWtDNOQpezo1qqSPiBnxobMHQmvdDgRNgBSjK+gd4Mp2Zh0vjm+eu08Fio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764867385; c=relaxed/simple;
	bh=oVcBQiFZcKRVuwvSyvgfomBoopJQhYg989rFbF09SvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nBqLLQ82k5jNfHKL89wxy7MZvF3hB+muHunN+fAs1p6viWoQ6SdkDfb8OgCyWUviYbr7fQpp7ZKFUrCUzi+plwi/GFwryKmo66rXrrB3jPBda84ZmnrqDreC9SxPTH/r6I7ekkNZQQ9E8TQZtHV5Ypx+8FmrAWODQMnilXcZlQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2rWkL1Xy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fx0jXRJ2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 4 Dec 2025 17:56:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764867381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c9+6XlmLlKbjUhjn7O7UGpoRgL/0BI1e50erzPzpDlQ=;
	b=2rWkL1XyAhcgyqrW14MMF3qaUQSr8YYDNiCKry0x0QBsV4l5x3+Ycw5+Jmi0h0i54S8RRK
	E+E1i9Sf249ovLQIsdHJYJbyeELFizphpxVyW0iv3gMQVsNLZQNI3+0uo8gMM5+J8gdwAU
	TQlFxaGVQAKpquAo5xJmu7Sg3eUNUg0oqHbXewl81F1jiHSx62cUQYCc3/lDBDD9nZaXUb
	D0kNhjyLt3Lx6Iynot+ksQqb9CYSPxpgVVg03P7IjPAK3p6UMbKbdvfL0mIG0Mr+TozaUc
	Idwaz543w+GDt5FHrMnfh8wFNTyTtt6ss8MbiHwTTQI9/sWdQYGNRLif/kaz1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764867381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c9+6XlmLlKbjUhjn7O7UGpoRgL/0BI1e50erzPzpDlQ=;
	b=fx0jXRJ2uwCZoiAF6TP+4b8/8ynViDEX2+cIYHls3j9u/NOxevNN3FgjINA/To4UgHgvMH
	l2OPXdUE9HBBQkCw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Deepak Gupta <debug@rivosinc.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Oleg Nesterov <oleg@redhat.com>, Eric Biederman <ebiederm@xmission.com>, 
	Kees Cook <kees@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
	Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Benno Lossin <lossin@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
	andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, atishp@rivosinc.com, 
	evan@rivosinc.com, cleger@rivosinc.com, alexghiti@rivosinc.com, 
	samitolvanen@google.com, broonie@kernel.org, rick.p.edgecombe@intel.com, 
	rust-for-linux@vger.kernel.org, Charles Mirabile <cmirabil@redhat.com>
Subject: Re: [PATCH v23 24/28] arch/riscv: dual vdso creation logic and
 select vdso based on hw
Message-ID: <20251204175055-fefb76ff-2ff2-48b8-b92c-3d3ce33ec9f5@linutronix.de>
References: <20251112-v5_user_cfi_series-v23-0-b55691eacf4f@rivosinc.com>
 <20251112-v5_user_cfi_series-v23-24-b55691eacf4f@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112-v5_user_cfi_series-v23-24-b55691eacf4f@rivosinc.com>

On Wed, Nov 12, 2025 at 04:43:22PM -0800, Deepak Gupta via B4 Relay wrote:
> From: Deepak Gupta <debug@rivosinc.com>
> 
> Shadow stack instructions are taken from zimop (mandated on RVA23).
> Any hardware prior to RVA23 profile will fault on shadow stack instruction.
> Any userspace with shadow stack instruction in it will fault on such
> hardware. Thus such userspace can't be brought onto such a hardware.
> 
> It's not known how userspace will respond to such binary fragmentation.
> However in order to keep kernel portable across such different hardware,
> `arch/riscv/kernel/vdso_cfi` is created which has logic (Makefile) to
> compile `arch/riscv/kernel/vdso` sources with cfi flags and then changes
> in `arch/riscv/kernel/vdso.c` for selecting appropriate vdso depending
> on whether underlying hardware(cpu) implements zimop extension. Offset
> of vdso symbols will change due to having two different vdso binaries,
> there is added logic to include new generated vdso offset header and
> dynamically select offset (like for rt_sigreturn).

If the used vDSO variant only depends on the hardware and nothing else,
why not use alternative patching and avoid the complexity?
I see that RISCV_ALTERNATIVE depends on !XIP_KERNEL but the vDSO code is
moved to dynamically allocated memory in any case, so it is patchable.

> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> Acked-by: Charles Mirabile <cmirabil@redhat.com>

(...)

