Return-Path: <linux-fsdevel+bounces-70912-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B64CA93FD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 21:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA55D3112451
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 20:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2372C29BDA5;
	Fri,  5 Dec 2025 20:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="bxqGkefi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDFEDDAB;
	Fri,  5 Dec 2025 20:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764965957; cv=none; b=CWOyrqezopashJQJx5gAkbD0rHSa6sWF995MeWJtxBMHU9yHy8EmMGh/ty8ffX1WRcG4OJg+g+O2syStP8ctENxkWtFHzvpvDBO+31bzklBomF+/SwVhWgGLDRJi3IS0irf5IENfOpzjl3M1lNUD/HKNjEOVcTP8YKlR4pcqiNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764965957; c=relaxed/simple;
	bh=EkPLPYCr/PB32DrsOWZdyhfi1YrR/svWL/n/QcZZ1TU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8woaSsn//jDrv1dLL12R2XZTSHbhR5v3d+i49xHLF4K6IoI31K28jhlBv2I/9WOAxjIWUXJejMBQWUXIqCEHf8kP6mJo1QPF9F8/w89llQO/ksK9GgNaF3AQaPYjCUpVxa0j+a7/I2xmiYr5h7epygV7pI9CD820aq3KoKLgSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=bxqGkefi; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 67E3C40E015B;
	Fri,  5 Dec 2025 20:19:06 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 1E4TMqj0voQt; Fri,  5 Dec 2025 20:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1764965939; bh=+k+j5zpiOXPUaOMclkmVjKztohgymIQPYnO7V/a+C/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bxqGkefiEe2JFBIhARr9tXH5BeezbVW/58uxKq/Tfdv1Y3tcJ64dJ1cdY5nzgOcDx
	 Me/EwWk+UXXs5J5ilfhEsv4wRvMy6BoVgrjCQn7zbTZT2qYHO7fKRxALp2n6Qt5htI
	 gTAQ7c8xibH7fPZ24PWS1/mprjgWrwEhVK5CwZ82QcZ5336mD6SqPK/onz+yTMAXLP
	 Uo4I7c8WqByXwRacksIdRkqnh8YO6p8CMsqM/PCHezHIYa9d4lP93ibGWI3ZNiVxAM
	 mPb8gsmuEss401Wbz/xAbQNSUOuwu1r41oOvGUaV5kZBIn4MHLDAY7CJYqZBL9W3ap
	 laFZ7I+Zcr/T9Q/3ukCSfpG9cZXEK5vOti5wbd4vPFVuUFGTZ5MyID5VShadi3zIRl
	 xGQjT6zxjvwEqh0co2EFJhK3Wd2fCAbzZ0qQWgj1uBN8lkhIN9EAp7ruVUbMpryNy7
	 Jki+8RlqBEddLzRCQhp0Rdzku+HsxukwOUwD/gyU69z3FlEw5ppsXfaJyz+G7RLJzh
	 93hDC8gTmjSc4rYF7NhWhumcNWaQKLgqxtOxNJQCwIdPBsVUgVBY9zZpFZ/dqOCZNB
	 Er3+sydfYNzFkSoqjM9orlD665WhWzJ3uGh+eWKn7Ik+dRECEpFAfI3O1YBJgdo385
	 7MzW5WnEhsH8ZS8oz2Pgz8H4=
Received: from zn.tnic (pd953023b.dip0.t-ipconnect.de [217.83.2.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id D6DE840E0173;
	Fri,  5 Dec 2025 20:17:54 +0000 (UTC)
Date: Fri, 5 Dec 2025 21:17:47 +0100
From: Borislav Petkov <bp@alien8.de>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: debug@rivosinc.com, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Benno Lossin <lossin@kernel.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, alistair.francis@wdc.com,
	richard.henderson@linaro.org, jim.shu@sifive.com,
	andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com,
	atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com,
	alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org,
	rick.p.edgecombe@intel.com, rust-for-linux@vger.kernel.org,
	Zong Li <zong.li@sifive.com>, David Hildenbrand <david@redhat.com>,
	Andreas Korb <andreas.korb@aisec.fraunhofer.de>,
	Valentin Haudiquet <valentin.haudiquet@canonical.com>,
	Paul Walmsley <pjw@kernel.org>,
	Charles Mirabile <cmirabil@redhat.com>
Subject: Re: [PATCH v25 00/28] riscv control-flow integrity for usermode
Message-ID: <20251205201747.GAaTM963Zy4gr820KV@fat_crate.local>
References: <20251205-v5_user_cfi_series-v25-0-1a07c0127361@rivosinc.com>
 <d45808b5-44c3-42c6-a54c-3a13606ee39d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d45808b5-44c3-42c6-a54c-3a13606ee39d@kernel.org>

On Fri, Dec 05, 2025 at 08:32:32PM +0100, Krzysztof Kozlowski wrote:
> On 05/12/2025 19:41, Deepak Gupta via B4 Relay wrote:
> > v25: Removal of `riscv_nousercfi` from `cpufeature.c` and instead placing
> > it as extern in `usercfi.h` was leading to build error whene cfi config
> > is not selected. Placed `riscv_nousercfi` outside cfi config ifdef block
> > in `usercfi.h`
> 
> 
> Please stop. You sent this 28-patch-bomb TWICE to 50 or 60 addresses.
> It's actually merge window so it should wait in the first place, but for
> sure sending it multiple times does not help. Please observe the Linux
> development process.

You can just delete them. I don't know about you but riscv shadow stack is not
something I even pretend to know so it all goes to /dev/null

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

