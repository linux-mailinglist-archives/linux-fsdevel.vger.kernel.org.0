Return-Path: <linux-fsdevel+bounces-62584-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB870B9A470
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 16:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86F067AAFA4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 14:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF801308F34;
	Wed, 24 Sep 2025 14:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sU4qbKHf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1611A9FA7;
	Wed, 24 Sep 2025 14:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758724585; cv=none; b=mP1N2OvJpCaBKc70UX3oNtuDa93h9IISP3W2rPYrCK+rWvQg9RXQfPWzp2u7HIy+HGuC1QCZ1UyOPHmgS5YE15RxiCIDFGASHm8boJJYibC+n2LRPjDt7Y8bU1nkyjkbPD2JRrEdI9j9fz8+1ZUHrNTmaMOh6oDJhvJhe/88Vxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758724585; c=relaxed/simple;
	bh=dtMyGOLRj3HY14tPCzeUn90iQCDhGJqxqhE3t2ov7aU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=H7oe+o0hGlCZor2JhJ44f/qqNbSJ+8me/8dG/ciBpOR8tXzzHn8Hj+FOJQCaNmLl6u02xVOhxyUTDcsq3Lq5LTwVqYqLUaXorJ4rXZljz1JRQADtNymT7O/PBPC2/EEw2flU3FEqcc+DBnx1HNEC3VsC423ZNLIRAwkf3K/1mBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sU4qbKHf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F373C4CEE7;
	Wed, 24 Sep 2025 14:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758724584;
	bh=dtMyGOLRj3HY14tPCzeUn90iQCDhGJqxqhE3t2ov7aU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=sU4qbKHfWJn/GVEqOSKG90PR7kq8un4mmh2XnGkYWYj96nm0vP3t0kpMc9qgQDF/r
	 Njj8+x9+98clpezx9Qbexhjiiqb9LgGf2zO7zaasjP6Aw3ZwagcAIEE8M1xw+MaWmu
	 YUaMY0p/KqRd8zFg6n7QJyC9wlkAy1COyRWfXsjDCyXLlLAmMW+OOVMT0stiJlFThR
	 pSjukkkFK4og3+n0QfVwwodCBFQYwRR1q0tdqFB+L5GUbegS/N6BCgBwxdv/nKP85r
	 1KUsbDv30oxCq+omuKsOLciS1wr91DsaxnZLhDWTt7/0uf59+4ZuwoESQ7BQmcDgr0
	 wKP3Ex22F2I6w==
Date: Wed, 24 Sep 2025 08:36:11 -0600 (MDT)
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
    David Hildenbrand <david@redhat.com>, Andy Chiu <andybnac@gmail.com>
Subject: Re: [PATCH v19 00/27] riscv control-flow integrity for usermode
In-Reply-To: <20250731-v5_user_cfi_series-v19-0-09b468d7beab@rivosinc.com>
Message-ID: <f953ee7b-91b3-f6f5-6955-b4a138f16dbc@kernel.org>
References: <20250731-v5_user_cfi_series-v19-0-09b468d7beab@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hi,

On Thu, 31 Jul 2025, Deepak Gupta wrote:

[ ... ]

> vDSO related Opens (in the flux)
> =================================
> 
> I am listing these opens for laying out plan and what to expect in future
> patch sets. And of course for the sake of discussion.
> 

[ ... ]

> How many vDSOs
> ---------------
> Shadow stack instructions are carved out of zimop (may be operations) and if CPU
> doesn't implement zimop, they're illegal instructions. Kernel could be running on
> a CPU which may or may not implement zimop. And thus kernel will have to carry 2
> different vDSOs and expose the appropriate one depending on whether CPU implements
> zimop or not.

If we merge this series without this, then when CFI is enabled in the 
Kconfig, we'll wind up with a non-portable kernel that won't run on older 
hardware.  We go to great lengths to enable kernel binary portability 
across the presence or absence of other RISC-V extensions, and I think 
these CFI extensions should be no different.

So before considering this for merging, I'd like to see at least an 
attempt to implement the dual-vDSO approach (or something equivalent) 
where the same kernel binary with CFI enabled can run on both pre-Zimop 
and post-Zimop hardware, with the existing userspaces that are common 
today.

thanks Deepak,

- Paul

