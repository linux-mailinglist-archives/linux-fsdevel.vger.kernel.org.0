Return-Path: <linux-fsdevel+bounces-66624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BEE8C26DDA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 21:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F02E18927B9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 20:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C70327203;
	Fri, 31 Oct 2025 20:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEbaFUeP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525A02222A0;
	Fri, 31 Oct 2025 20:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761941259; cv=none; b=c6tHZ3XKZuyrl4kAzorwHFc8Aj6K1Bc6uhuJ8lTeUvxgeLfAa4Q7216FzvpJpo20bO2/3ZPu8tevBQMcqg0vJOYPhNzdc0E2YmEBdLeVjHjB+c0PQEIayEG1YYe2EsB0pBCl3/SNk6CZL/Msq5NiWS3/zArZecTd0yvYxKGK79c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761941259; c=relaxed/simple;
	bh=wQet1zpVA979LHOCAKnvDe4vIz5lgogB/RiA4rvDzcE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=m8FISJOWvVyUX0TB0stp3DukBwNCanqtuY6ZUkYqeJGS8rDvLfC72cxOC8rNwoPIdykX7ht7jIPNbp2aOeqXkBtpeW4bZCpk0BBmINjwn79OodpS1hKW2ntjF7591LLaFt7HHYtSV60RwnkrvNfByFrZe1d5qDibZpXXPdsruUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eEbaFUeP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC5FC4CEE7;
	Fri, 31 Oct 2025 20:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761941258;
	bh=wQet1zpVA979LHOCAKnvDe4vIz5lgogB/RiA4rvDzcE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=eEbaFUePEqsqd1xqvFj6PfHBe6jOCi2lEMdH8TycHl0Q5Auluk8S2lpJXmv9TxFx6
	 NusxPnTpJc0X0f0CeYGgWHWJPP+pm9H5h9r65gPGw/KCR077Hi6MKNwd20DNPMNN6b
	 WeahrAxPZQa10FjP/DdR4c+HK/1h5x2nUAasMuSHcOITJAiV483CzwcXL5NGIqys+P
	 mY145nVNkpzIC2zpwBWy190cfG4RZuldrQmgNpuR1kKC8i8XpoLRbm6nuQrl1TbMCc
	 xrhLxkelxND1eIrhNaB+SV+lyaoUFqxJyBOJ8iEADXR4rSsgSzl+qs3Ga+6/bKM9QS
	 dwrww+Tnxquiw==
Date: Fri, 31 Oct 2025 14:07:32 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Deepak Gupta <debug@rivosinc.com>, Andy Chiu <andybnac@gmail.com>
cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
    Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
    x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
    Vlastimil Babka <vbabka@suse.cz>, 
    Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
    Paul Walmsley <paul.walmsley@sifive.com>, 
    Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
    Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
    Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
    Christian Brauner <brauner@kernel.org>, 
    Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>, 
    Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
    Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
    Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>, 
    Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
    Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
    =?ISO-8859-15?Q?Bj=F6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
    Andreas Hindborg <a.hindborg@kernel.org>, 
    Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
    Benno Lossin <lossin@kernel.org>, linux-kernel@vger.kernel.org, 
    linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
    linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
    linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
    linux-kselftest@vger.kernel.org, alistair.francis@wdc.com, 
    richard.henderson@linaro.org, jim.shu@sifive.com, 
    Andy Chiu <andybnac@gmail.com>, kito.cheng@sifive.com, 
    charlie@rivosinc.com, atishp@rivosinc.com, evan@rivosinc.com, 
    cleger@rivosinc.com, alexghiti@rivosinc.com, samitolvanen@google.com, 
    broonie@kernel.org, rick.p.edgecombe@intel.com, 
    rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v22 17/28] riscv/signal: save and restore of shadow stack
 for signal
In-Reply-To: <20251023-v5_user_cfi_series-v22-17-1935270f7636@rivosinc.com>
Message-ID: <a8f469b8-5750-dfec-2390-09bad4515f99@kernel.org>
References: <20251023-v5_user_cfi_series-v22-0-1935270f7636@rivosinc.com> <20251023-v5_user_cfi_series-v22-17-1935270f7636@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 23 Oct 2025, Deepak Gupta via B4 Relay wrote:

> From: Deepak Gupta <debug@rivosinc.com>
> 
> Save shadow stack pointer in sigcontext structure while delivering signal.
> Restore shadow stack pointer from sigcontext on sigreturn.
> 
> As part of save operation, kernel uses `ssamoswap` to save snapshot of
> current shadow stack on shadow stack itself (can be called as a save
> token). During restore on sigreturn, kernel retrieves token from top of
> shadow stack and validates it. This allows that user mode can't arbitrary
> pivot to any shadow stack address without having a token and thus provide
> strong security assurance between signaly delivery and sigreturn window.
> 
> Use ABI compatible way of saving/restoring shadow stack pointer into
> signal stack. This follows what Vector extension, where extra registers
> are placed in a form of extension header + extension body in the stack.
> The extension header indicates the size of the extra architectural
> states plus the size of header itself, and a magic identifier of the
> extension. Then, the extensions body contains the new architectural
> states in the form defined by uapi.
> 
> Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>

This patch causes some 'checkpatch.pl --strict' messages:

CHECK: Comparison to NULL could be written "!saved_shstk_ptr"
#271: FILE: arch/riscv/kernel/usercfi.c:186:
+	if (saved_shstk_ptr == NULL)

CHECK: Lines should not end with a '('
#300: FILE: arch/riscv/kernel/usercfi.c:215:
+		pr_info_ratelimited(

I've fixed them up here in the event that v22 goes in, but please do the 
same on your side in case a new version is needed.


- Paul

