Return-Path: <linux-fsdevel+bounces-66622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1CFC26B9E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 20:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 739A540646F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 19:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B147D2E336E;
	Fri, 31 Oct 2025 19:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5HDCi2R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04B42D97B7;
	Fri, 31 Oct 2025 19:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761938552; cv=none; b=DD74Y5aMdn5jzFUxKEJqLEoshx1hJxxDMc/4qnP3Y7gSy+2cPHES79dpXZ70ll4GN+n26YKPqvnF5XqzDF2keVmn8Q0jY/gUtkKIGCgnasDf+1lNgerC7rEo484jpOoczB7Wl02aTmtfznssVMJAhIF8glrtUZuBqnEzu4MzOpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761938552; c=relaxed/simple;
	bh=aRO45gf5CfHW1/jbUbbLGsRCxWY7tHk3cFfnDvNsB6Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=IZEsEfGciCGn7YCUlhF+9OWVyY9PAO4purbzxVHeg6yD/GTVNfKoSLXV+aCWqpyTb7NXboRdqW3ytBWthejEdnrHMocqL8L4rlslaIBlByMP83BosNQXBPehuSzO3CaMi0Rd5igKsZ7BKJatoEA6WJiPTqq8QGT86zz5ECSSLL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5HDCi2R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB1DEC4CEE7;
	Fri, 31 Oct 2025 19:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761938551;
	bh=aRO45gf5CfHW1/jbUbbLGsRCxWY7tHk3cFfnDvNsB6Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=M5HDCi2R/696KAq+LQQDeEnnFTStWNLkXYwKUiU9FxJS0+SMep8pWFlpbWtMhCEDE
	 3IqSttDBCsW639HgoIfXNDa5Rl5R2Eg3DPtIMGmbvxRmY4i0JiGYkRMvEIB/UsEAF/
	 CpSxsd8YDaLo7qB+j1Vd4dXbW9wlxIEkOBpLnql/SBO5QE8BsCAMM0NgYXNNpBc0uG
	 74Srbaun1zMez0S5J737hSGvZAiklmcFqDN9evPXeLKPQOTt4EkImzO1RV9Ab3ErMe
	 U7GPDkqCNG4vnEozILb4d3SSdHavGo7+IHCu1Lfn9KlyQUdgHAk2dJZMnL8zRIQzci
	 moNGNmIxIROuQ==
Date: Fri, 31 Oct 2025 13:22:23 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Deepak Gupta <debug@rivosinc.com>
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
    richard.henderson@linaro.org, jim.shu@sifive.com, andybnac@gmail.com, 
    kito.cheng@sifive.com, charlie@rivosinc.com, atishp@rivosinc.com, 
    evan@rivosinc.com, cleger@rivosinc.com, alexghiti@rivosinc.com, 
    samitolvanen@google.com, broonie@kernel.org, rick.p.edgecombe@intel.com, 
    rust-for-linux@vger.kernel.org, Zong Li <zong.li@sifive.com>
Subject: Re: [PATCH v22 03/28] riscv: zicfiss / zicfilp enumeration
In-Reply-To: <20251023-v5_user_cfi_series-v22-3-1d53ce35d8fd@rivosinc.com>
Message-ID: <9230fa65-6b8e-ebf6-f215-b3a3bb7357d9@kernel.org>
References: <20251023-v5_user_cfi_series-v22-0-1d53ce35d8fd@rivosinc.com> <20251023-v5_user_cfi_series-v22-3-1d53ce35d8fd@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 23 Oct 2025, Deepak Gupta wrote:

> This patch adds support for detecting zicfiss and zicfilp. zicfiss and
> zicfilp stands for unprivleged integer spec extension for shadow stack
> and branch tracking on indirect branches, respectively.
> 
> This patch looks for zicfiss and zicfilp in device tree and accordinlgy
> lights up bit in cpu feature bitmap. Furthermore this patch adds detection
> utility functions to return whether shadow stack or landing pads are
> supported by cpu.
> 
> Reviewed-by: Zong Li <zong.li@sifive.com>
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>

This patch introduces some 'checkpatch.pl --strict' messages:

CHECK: Alignment should match open parenthesis
#68: FILE: arch/riscv/kernel/cpufeature.c:278:
+static int riscv_cfilp_validate(const struct riscv_isa_ext_data *data,
+			      const unsigned long *isa_bitmap)

CHECK: Alignment should match open parenthesis
#77: FILE: arch/riscv/kernel/cpufeature.c:287:
+static int riscv_cfiss_validate(const struct riscv_isa_ext_data *data,
+			      const unsigned long *isa_bitmap)


I'll fix them up here in the event that v22 goes in, but please do the 
same on your side in case a new version is needed.  


thanks,

- Paul 

