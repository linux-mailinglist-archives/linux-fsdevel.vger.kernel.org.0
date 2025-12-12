Return-Path: <linux-fsdevel+bounces-71189-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D78E7CB84A7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 09:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6CE1E30688F9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 08:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD3A3112C4;
	Fri, 12 Dec 2025 08:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dcBuqNIl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569083101DC;
	Fri, 12 Dec 2025 08:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765528246; cv=none; b=lIwJVHXdL2gQfkg2Yz9Myns+o8ac/yoOp1vO8G5UIynGXnOBcF/VTy+rKAld2wUWdUmiPfI59llDD+cY8KveLVPJPNEzuV5AaD+M8h6G3GbekqO9nzC75KJkyD4kvfZFx/r5HPT4122NYqLGtvL4Wro6JL2Hh4+F/fyaD+rRdMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765528246; c=relaxed/simple;
	bh=DRPzZm8wRyj4mY54tq0jM/zwgD0vFMbcEQzT/w8zFyM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dqTsHnQ8isNxzGpI+bZxC0VPxJoihKyUZZqPqZ7QQSOUcNVL5q2OJWUDmo2LhQt5THR1TaJ+bBKWOZfBnktcVaeXgp7DB5YPqMNYUedoBaPcRO7ZLuTfguYvmlQ72BbMSShmloUqDrn2vNXmlaSzgOjQNSspfWrMrkIuYwEPeYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dcBuqNIl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36FF1C4CEF1;
	Fri, 12 Dec 2025 08:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765528245;
	bh=DRPzZm8wRyj4mY54tq0jM/zwgD0vFMbcEQzT/w8zFyM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=dcBuqNIldXTL6nxc9vHRFmJK1q+pCEpPXDnMynSxTcTE0f5CMeYb1YC/QYimK7HvL
	 yW9ZIAMunbbNR/XddaD+W2WBzK9ITEOc9Jpd/WF/oFxZGqgMxWJaYnhPdWS/2ZndYV
	 QvTcZ2zk/8XusiG2mEKWiyswaxnlL8kucMpgGRGKUFvBmh6HToRFzmjdMzC8iFklZ7
	 C/w/rAiweFwaGnDV+0vs7+eq/kMNQh7nLuDIAH4TZjY2J30aoCpasEx9IT9zYH+9Ck
	 kNK9eY7wcDmJuvc2ytWrBRu1KTkw/s4QBwSvxfmd6ToD+GB5v6srhdPSZeTpE9iyRE
	 95/u2RrgtAxkA==
Date: Fri, 12 Dec 2025 01:30:29 -0700 (MST)
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
    richard.henderson@linaro.org, jim.shu@sifive.com, 
    Andy Chiu <andybnac@gmail.com>, kito.cheng@sifive.com, 
    charlie@rivosinc.com, atishp@rivosinc.com, evan@rivosinc.com, 
    cleger@rivosinc.com, alexghiti@rivosinc.com, samitolvanen@google.com, 
    broonie@kernel.org, rick.p.edgecombe@intel.com, 
    rust-for-linux@vger.kernel.org, Zong Li <zong.li@sifive.com>, 
    David Hildenbrand <david@redhat.com>, 
    Andreas Korb <andreas.korb@aisec.fraunhofer.de>, 
    Valentin Haudiquet <valentin.haudiquet@canonical.com>, 
    Charles Mirabile <cmirabil@redhat.com>, Andy Chiu <andybnac@gmail.com>
Subject: Re: [PATCH v26 00/28] riscv control-flow integrity for usermode
In-Reply-To: <20251211-v5_user_cfi_series-v26-0-f0f419e81ac0@rivosinc.com>
Message-ID: <e052745b-6bf0-c2a3-21b2-5ecd8b04ec70@kernel.org>
References: <20251211-v5_user_cfi_series-v26-0-f0f419e81ac0@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 11 Dec 2025, Deepak Gupta via B4 Relay wrote:

> v26: CONFIG_RISCV_USER_CFI depends on CONFIG_MMU (dependency of shadow stack
> on MMU). Used b4 to pick tags, apparantly it messed up some tag picks. Fixing it

Deepak: I'm now (at least) the third person to tell you to stop resending 
this entire series over and over again.

First, a modified version of the CFI v23 series was ALREADY SITTING IN 
LINUX-NEXT.  So there's no reason you should be resending the entire 
series, UNLESS your intention for me is to drop the entire existing series 
and wait for another merge window.

Second: when someone asks you questions about an individual patch, and you 
want to answer those questions, it's NOT GOOD for you to resend the entire 
28 series as the response!  You are DDOSing a bunch of lists and E-mail 
inboxes.  Just answer the question in a single E-mail.  If you want to 
update a single patch, just send that one patch.

If you don't start paying attention to these rules then people are going 
to start ignoring you -- at best! -- and it's going to give the entire 
community a bad reputation.

Please acknowledge that you understand this,


- Paul

