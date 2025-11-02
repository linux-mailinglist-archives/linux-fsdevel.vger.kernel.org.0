Return-Path: <linux-fsdevel+bounces-66706-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2640C29A8D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 00:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 183A6188CB4C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Nov 2025 23:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D9B23C8A1;
	Sun,  2 Nov 2025 23:51:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A774B1C8605;
	Sun,  2 Nov 2025 23:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762127491; cv=none; b=Ua9RBvMLQmVzQnhD7oN/FN0DHKaYdBQfb7OFxrGkteafYKSaE+TIhXtvDnbS5NXAkv6JlnXyjyboX/ZWuKatpQdcxsbnVSoEGhJ0PzvLB+jRJJf30zQ41tXmBsN0eZEAg2fBSOlOjjW9bGgzq9TON0kzXKO7xD40bX6TeXdStoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762127491; c=relaxed/simple;
	bh=3QBJqNiePwTQmv6unGmlEenM/JEk9C6UuRzdmtI8mBE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ji5znvkKOt8+RXiL8zs6cSqm1CsMQKygWMxgkHRaxQcbxNMDB/cgx8+63EacjYuhPP9ogecz07paRz8jiBV3Hhz2K+9M2zQWlPt61wnderVEGMyLJs2SqQVcSxRsPhJ1nLDnNySPi13MMHU2NNKZhCFQydAtWT00VNcedIWvAgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id DDB6592009D; Mon,  3 Nov 2025 00:51:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id CF26F92009B;
	Sun,  2 Nov 2025 23:51:12 +0000 (GMT)
Date: Sun, 2 Nov 2025 23:51:12 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Paul Walmsley <pjw@kernel.org>
cc: Deepak Gupta <debug@rivosinc.com>, Thomas Gleixner <tglx@linutronix.de>, 
    Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
    Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
    "H. Peter Anvin" <hpa@zytor.com>, 
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
    =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
    Andreas Hindborg <a.hindborg@kernel.org>, 
    Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
    Benno Lossin <lossin@kernel.org>, linux-kernel@vger.kernel.org, 
    linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
    linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
    linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
    linux-kselftest@vger.kernel.org, alistair.francis@wdc.com, 
    richard.henderson@linaro.org, jim.shu@sifive.com, andybnac@gmail.com, 
    kito.cheng@sifive.com, charlie@rivosinc.com, atishp@rivosinc.com, 
    evan@rivosinc.com, cleger@rivosinc.com, alexghiti@rivosinc.com, 
    samitolvanen@google.com, broonie@kernel.org, rick.p.edgecombe@intel.com, 
    rust-for-linux@vger.kernel.org, Zong Li <zong.li@sifive.com>
Subject: Re: [PATCH v22 10/28] riscv/mm: Implement map_shadow_stack()
 syscall
In-Reply-To: <020e2f6e-9c1b-648e-3017-31eb8a89c493@kernel.org>
Message-ID: <alpine.DEB.2.21.2511022341110.1185@angie.orcam.me.uk>
References: <20251023-v5_user_cfi_series-v22-0-1935270f7636@rivosinc.com> <20251023-v5_user_cfi_series-v22-10-1935270f7636@rivosinc.com> <020e2f6e-9c1b-648e-3017-31eb8a89c493@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 31 Oct 2025, Paul Walmsley wrote:

> This patch introduces a 'checkpatch.pl --strict' message:
> 
> CHECK: Lines should not end with a '('
> #78: FILE: arch/riscv/kernel/usercfi.c:36:
> +	asm goto(
> 
> I'll fix it up here in the event that v22 goes in, but please do the same 
> on your side in case a new version is needed.

 I think this warning is silly for `asm' statements.  It's been common for 
decades to do this to format multi-line `asm' statements, just because it 
makes them so much more readable.  We have roughly two thousand instances 
in our tree already and I would use this style for new code in the parts I 
maintain as well.

 Now having trailing `);' on a separate line is another matter.

  Maciej

