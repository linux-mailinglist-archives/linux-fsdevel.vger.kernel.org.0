Return-Path: <linux-fsdevel+bounces-73869-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C91EDD2234F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 03:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2FDD4304348D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 02:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C45A285071;
	Thu, 15 Jan 2026 02:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pM66J1BT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED70318024;
	Thu, 15 Jan 2026 02:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768445844; cv=none; b=t7Arr9Ir1Q5C5nm91d6ZWIIcsZ58rqDhY/2eOVxMJiIEgUxcIbi7mo4QNh+o4KMYLPNnmjeTwYMC3bViNE8+DZDzyE7II8BnbWCi+JFfbULr8PCTOc5DxvCghnFxRp9YQKLKi7M246H/mVOKKx6Vf7oION2GfT6DX0cgS+9bQJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768445844; c=relaxed/simple;
	bh=vZY5zsWBaO65aRDg0tkCt053druTmj76dpqw1tJ3uPM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nyNWm83CdgdlYGt6nQZ/7u2wPudwFzvTkTln2SXhEtbcY+IXGkCT19doHb1V1rNCo0qbv8GqK+ywijRN2k789cY2QF9uvBDY6Q4jamWl9dC/dHy5Oy4k0H+w2F+DLSxY1/m8x3GjatAHDovHRW1gpMg/Jc+Nvr/3eMBNtheh+gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pM66J1BT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B73CC4CEF7;
	Thu, 15 Jan 2026 02:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768445843;
	bh=vZY5zsWBaO65aRDg0tkCt053druTmj76dpqw1tJ3uPM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=pM66J1BT0I09Nyr/Aavbh2/YXOpVUtzg4+16ZMMkcG/CGlwUiklJ+lVzqZBscIBdU
	 8ONmNeBh29X6tFzTRjYZ67byWpAtquhTNeJf40Gj1cF/3mO+w7aNCDUqUof73dejXu
	 Z0vTCdrQNinKd7int+v6pgxUlZe2ABvJQ2ug74fxQEaBUaVo8+rJV+VuDbIzv9QmH0
	 jqn5ZDnghY8isJPSQrfcHJrleudDgapDvp0PqE5rEKfcPyjARADnPcZ3eAierGTh55
	 wiDpqcriAzAtQ4Ibc9OHIb6pgPIoIKJt9Zg3inBL7ArklI0ilNQB+tIPdwGpWRKbde
	 pny0nDjTkCWUw==
Date: Wed, 14 Jan 2026 19:57:19 -0700 (MST)
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
    rust-for-linux@vger.kernel.org, Zong Li <zong.li@sifive.com>, 
    David Hildenbrand <david@redhat.com>, 
    Andreas Korb <andreas.korb@aisec.fraunhofer.de>, 
    Valentin Haudiquet <valentin.haudiquet@canonical.com>
Subject: Re: [PATCH v26 01/28] mm: VM_SHADOW_STACK definition for riscv
In-Reply-To: <20251211-v5_user_cfi_series-v26-1-f0f419e81ac0@rivosinc.com>
Message-ID: <68e1702e-f803-2db2-0e16-53ecef4d9eb6@kernel.org>
References: <20251211-v5_user_cfi_series-v26-0-f0f419e81ac0@rivosinc.com> <20251211-v5_user_cfi_series-v26-1-f0f419e81ac0@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 11 Dec 2025, Deepak Gupta via B4 Relay wrote:

> From: Deepak Gupta <debug@rivosinc.com>
> 
> VM_HIGH_ARCH_5 is used for riscv
> 
> Reviewed-by: Zong Li <zong.li@sifive.com>
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Tested-by: Andreas Korb <andreas.korb@aisec.fraunhofer.de>
> Tested-by: Valentin Haudiquet <valentin.haudiquet@canonical.com>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>

Here's what I'm planning to queue, after updating it after Lorenzo's mm 
changes.  Please let me know if you want to change anything.


- Paul

From: Deepak Gupta <debug@rivosinc.com>
Date: Wed, 19 Nov 2025 09:55:05 -0700

mm: add VM_SHADOW_STACK definition for riscv

VM_HIGH_ARCH_5 is used for riscv.

Reviewed-by: Zong Li <zong.li@sifive.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Tested-by: Andreas Korb <andreas.korb@aisec.fraunhofer.de> # QEMU, custom CVA6
Tested-by: Valentin Haudiquet <valentin.haudiquet@canonical.com>
Link: https://patch.msgid.link/20251112-v5_user_cfi_series-v23-1-b55691eacf4f@rivosinc.com
[pjw@kernel.org: clarify subject; update to apply]
Signed-off-by: Paul Walmsley <pjw@kernel.org>
---
 include/linux/mm.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 15076261d0c2..de912272c5f9 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -359,7 +359,7 @@ enum {
 	DECLARE_VMA_BIT_ALIAS(PKEY_BIT2, HIGH_ARCH_2),
 	DECLARE_VMA_BIT_ALIAS(PKEY_BIT3, HIGH_ARCH_3),
 	DECLARE_VMA_BIT_ALIAS(PKEY_BIT4, HIGH_ARCH_4),
-#if defined(CONFIG_X86_USER_SHADOW_STACK)
+#if defined(CONFIG_X86_USER_SHADOW_STACK) || defined(CONFIG_RISCV_USER_CFI)
 	/*
 	 * VM_SHADOW_STACK should not be set with VM_SHARED because of lack of
 	 * support core mm.
@@ -460,7 +460,8 @@ enum {
 #define VM_PKEY_BIT4  VM_NONE
 #endif /* CONFIG_ARCH_PKEY_BITS > 4 */
 #endif /* CONFIG_ARCH_HAS_PKEYS */
-#if defined(CONFIG_X86_USER_SHADOW_STACK) || defined(CONFIG_ARM64_GCS)
+#if defined(CONFIG_X86_USER_SHADOW_STACK) || defined(CONFIG_ARM64_GCS) || \
+	defined(CONFIG_RISCV_USER_CFI)
 #define VM_SHADOW_STACK	INIT_VM_FLAG(SHADOW_STACK)
 #else
 #define VM_SHADOW_STACK	VM_NONE
-- 
2.51.0





