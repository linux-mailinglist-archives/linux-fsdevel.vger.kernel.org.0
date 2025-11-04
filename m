Return-Path: <linux-fsdevel+bounces-66890-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D3AC2FB93
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 08:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 84B0B34CE9B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 07:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33123101D0;
	Tue,  4 Nov 2025 07:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4yROKUV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E061430AAB8;
	Tue,  4 Nov 2025 07:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762242784; cv=none; b=HpIv9uEBH4A1S3RR+xU4gP5mtJxKU1kAOLEvKMknty6u2NBuywqp6uWAUleGeKUa7KEGMAq3T6TvbqhOGNqqTnto1rNaAZ6lYPO8+ijNCb9h6lgRfe3dGK2tXZnDMGTGtBmEfBq8/f9/EQfGgSo95cacu01WeWQ1ZcjhAlO1MAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762242784; c=relaxed/simple;
	bh=lGIbceyVZgdKoxAlgrENOyuI7iqdDhBBFcc98C3lKn0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rqDe8JC8vWeexLCQcKgdzxPhgMKA1epB0ndkEktCccV8f0JCpZXq7EZiJd0BSWJpjvKZr2939WZQN65bETTpkn/rHe8lIh8C8J5GuIOOGy5SJr6rHHnnxDnWk5Jv1LQdSmeI/1gjeuV97huhReh/X5BS1bPQZqASI69VO1ZWzz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j4yROKUV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E8A2C4CEF7;
	Tue,  4 Nov 2025 07:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762242780;
	bh=lGIbceyVZgdKoxAlgrENOyuI7iqdDhBBFcc98C3lKn0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=j4yROKUVgRxS9OZJC90/SHA8XCPDVvwVHDTgceh+mCs64FFENtqjNn3VC2cS3YHRS
	 Vh89i49TvVRT0q9eqdMJYy6UnQ4flTEkFee+vNQ+LDBtPs6JzXOg9rqYQ1l4R+DhcE
	 OKQGVXbTY9tU25yQyQP/GPDQop+9ZGgyxC6t3ereLkJQbDn6Ob5K1plMoN0NTftZxP
	 H0zc0vdg/o5PK4tKAehZQ7H8UtwncmtwY6oH+6QVwjaU8ikukGQIRaxvlWW+ISd3QU
	 to0NJLl+MiSLIdyT3IYNIGJSnGwpG80zYDO7P7ohAcYwUyIFI+7D4Iv2WyVwNsWwgM
	 89d6ggsAvvugA==
Date: Tue, 4 Nov 2025 00:52:53 -0700 (MST)
From: Paul Walmsley <pjw@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
cc: Paul Walmsley <pjw@kernel.org>, Deepak Gupta <debug@rivosinc.com>, 
    Andy Chiu <andybnac@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
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
    =?ISO-8859-15?Q?Bj=F6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
    Andreas Hindborg <a.hindborg@kernel.org>, 
    Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
    Benno Lossin <lossin@kernel.org>, linux-kernel@vger.kernel.org, 
    linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
    linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
    linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
    linux-kselftest@vger.kernel.org, alistair.francis@wdc.com, 
    richard.henderson@linaro.org, jim.shu@sifive.com, kito.cheng@sifive.com, 
    charlie@rivosinc.com, atishp@rivosinc.com, evan@rivosinc.com, 
    cleger@rivosinc.com, alexghiti@rivosinc.com, samitolvanen@google.com, 
    broonie@kernel.org, rick.p.edgecombe@intel.com, 
    rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v22 17/28] riscv/signal: save and restore of shadow stack
 for signal
In-Reply-To: <d442965b-8716-4f89-be88-bc62459af712@infradead.org>
Message-ID: <febe1a8a-a68b-1af8-a9d5-1b5f510ecab3@kernel.org>
References: <20251023-v5_user_cfi_series-v22-0-1935270f7636@rivosinc.com> <20251023-v5_user_cfi_series-v22-17-1935270f7636@rivosinc.com> <a8f469b8-5750-dfec-2390-09bad4515f99@kernel.org> <d442965b-8716-4f89-be88-bc62459af712@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hi Randy,

On Fri, 31 Oct 2025, Randy Dunlap wrote:

> 
> On 10/31/25 1:07 PM, Paul Walmsley wrote:
> > On Thu, 23 Oct 2025, Deepak Gupta via B4 Relay wrote:
> > 
> >> Save shadow stack pointer in sigcontext structure while delivering signal.
> >> Restore shadow stack pointer from sigcontext on sigreturn.
> 
> > This patch causes some 'checkpatch.pl --strict' messages:
> > 
> > CHECK: Comparison to NULL could be written "!saved_shstk_ptr"
> > #271: FILE: arch/riscv/kernel/usercfi.c:186:
> > +	if (saved_shstk_ptr == NULL)
> > 
> > CHECK: Lines should not end with a '('
> > #300: FILE: arch/riscv/kernel/usercfi.c:215:
> > +		pr_info_ratelimited(
> > 
> > I've fixed them up here in the event that v22 goes in, but please do the 
> > same on your side in case a new version is needed.
> 
> Is checkpatch.pl --strict the norm for arch/riscv/ ?

I run it on every patch I review.  I usually implement the formatting 
recommendations, in the interest of keeping the codebase formatted in a 
standard way across submitters.

> If there are enough arch/riscv/-specific patch expectations,
> maybe they could be documented in Documentation/process/maintainer-riscv.rst
> (a new file).

It never occurred to me as being arch/riscv specific, in the sense that, 
if --strict wasn't more broadly useful across the entire kernel tree, then 
we should just remove it from checkpatch.pl entirely.  In other words, 
probably everyone should use it.  There are false positive warnings, of 
course, including at least one with this patch set; but then again, there 
are regular false positive warnings with non-strict checkpatch (also with 
this patch set).

In any case, thanks for the suggestion, and will consider.


- Paul


