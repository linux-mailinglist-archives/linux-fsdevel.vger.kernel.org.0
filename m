Return-Path: <linux-fsdevel+bounces-72881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B38D047C0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 17:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C42E30570BF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 16:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C74D2C1590;
	Thu,  8 Jan 2026 16:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XrjTyWmG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF79923C8A0;
	Thu,  8 Jan 2026 16:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767889560; cv=none; b=EOzkhaFWAtt5CDH3boXsSFpgFIofuKHu3GycfitPqwDnoI8T9PNw0wMR+WfPwZFA+3j48VmAFzClN3g0GSHBbt65V2iByCYGrKoBgPNWRa03e2VxjxaS0DxYihl+ivsrCXxGw528WgMkupLFWoY/sh9btHh4rhrOOH4JX/S2hY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767889560; c=relaxed/simple;
	bh=OQxDuNgfE6e5tF4qpwq4v6IWP64NBvnqK3wmGYcyRBU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nHRUeJRWbqFIj2phBtiWj9KjQydmQRiP3khS2H9TBvGPY+kTB+iHIJiVknEiKwROSK1YEWTiRNiKyS5jCa5VxK0IeRL7Jl9NN4862BD+mt9HS1+soF02CY2GTGUmL096cj24KCttyiOmXA4tHKgaxSxc9/uDAIBxFu1HbAhHud4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XrjTyWmG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A1C6C116C6;
	Thu,  8 Jan 2026 16:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767889560;
	bh=OQxDuNgfE6e5tF4qpwq4v6IWP64NBvnqK3wmGYcyRBU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=XrjTyWmGlM9ynS+kE26WK4jWibbKKPLMLH4CBpcdhpleY8DPE45SA/UTzeXmERy24
	 mJ+bBrcHNSnuJqBMo+ZxKOtxxbkobRs0QELFpHk2Z7U3owKAcH3fcdtz0syeOcU61U
	 z6dikvGvgVC7qTCzSXkLBy2Gjmac25yXoX7s7Y79wP8niEBFgC87wv5ceryJMxvtbQ
	 PbUU9O8SUola85nvSNQju0ZcS+8OELA8AVILAo1bGJJHXBHP7pwHVwU5R7IuZVsKeG
	 5NT85m/20ljCZqQrzL3XnjHB59ocPhq3OMPbh0ThCl2b812NDixOgLf0NFWIUrBAwy
	 ijChpFvHraCQQ==
Date: Thu, 8 Jan 2026 09:25:53 -0700 (MST)
From: Paul Walmsley <pjw@kernel.org>
To: Deepak Gupta <debug@rivosinc.com>
cc: Paul Walmsley <pjw@kernel.org>, x86@kernel.org, 
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
    rust-for-linux@vger.kernel.org, Zong Li <zong.li@sifive.com>, 
    Andreas Korb <andreas.korb@aisec.fraunhofer.de>, 
    Valentin Haudiquet <valentin.haudiquet@canonical.com>, 
    Charles Mirabile <cmirabil@redhat.com>, 
    Jesse Huang <jesse.huang@sifive.com>
Subject: Re: [PATCH v26 00/28] riscv control-flow integrity for usermode
In-Reply-To: <CAKC1njQ-hS+kUJ0C_v0oqZW1EZw2zAXMp-SnnA-ZXh_H-SoVdQ@mail.gmail.com>
Message-ID: <30f969d2-794f-937f-53b7-3af3f2b88ef7@kernel.org>
References: <20251211-v5_user_cfi_series-v26-0-f0f419e81ac0@rivosinc.com> <e052745b-6bf0-c2a3-21b2-5ecd8b04ec70@kernel.org> <aTxf7IGlkGLgHgI2@debug.ba.rivosinc.com> <CAKC1njQ-hS+kUJ0C_v0oqZW1EZw2zAXMp-SnnA-ZXh_H-SoVdQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hi Deepak,
On Thu, 8 Jan 2026, Deepak Gupta wrote:

> I have a bugfix for a bug reported by Jesse Huang (thanks Jesse) in riscv
> implementation of `map_shadow_stack`.
> 
> Should I send a new series or only the bugfix-patch for implementation
> of `map_shadow_stack`

If you just send the bugfix patch, I'll roll it in to the patches that I'm 
applying.

Thanks for asking and happy new year,


- Paul

