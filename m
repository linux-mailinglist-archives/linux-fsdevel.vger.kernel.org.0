Return-Path: <linux-fsdevel+bounces-71137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CC4CB6ACC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 18:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8A8F7301EFFC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 17:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028213191D1;
	Thu, 11 Dec 2025 17:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQyS+uV0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11043315D4C;
	Thu, 11 Dec 2025 17:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765473667; cv=none; b=o9Cf9XEEgsVJTAAbwEy+XvPyuku5uN0JmHRBgmRQKJlkseJWZeTU+1/xYgMsHXz1ZqRJxxhwQL4oXFcPjmEQ6A2RMeG4FLw0M+kJO2yK+YkfTKfSK0Q7L97tnZ2zH627cjWe6iL6vGntbV8zHTfLuhbo5G+OBtg9bOXy5/6uOF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765473667; c=relaxed/simple;
	bh=s9Nd8OrIdmTzTe15BEE4fAoU+yUwpq+wRGim3URhRCA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T02lCeUjhEM0Dy29M2F5Ea5UV+/DBy63RtZ8uH6dR/Qcov+IiDnESyhIYPeNl3i2wTWc2njpVMyb6nVfqem8tr5rDZ4MxMoCx7PsJKrPRMdAgZ0JdWHl6nrW/goZT1bGHBdGefZ37ALAVjq39/CP7t6YdtM1e6G0n89vL9vPMTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQyS+uV0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E041C19422;
	Thu, 11 Dec 2025 17:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765473666;
	bh=s9Nd8OrIdmTzTe15BEE4fAoU+yUwpq+wRGim3URhRCA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=EQyS+uV0U+SCI3XKmW5ij21lzLSY5/r6FFdHK6UdNPWASDaVW7X6vqQy8UFzq7obp
	 xNquXMSvaGbYh+O1Y1QHlYjFVXEVzi/KAT5FtYIO2rbGMIPMDkmOrXouZDFnL2XDQ1
	 /Pc5oqCur4NqxRbepSYsRcW+7uGBQt6UuIqJQC/H8/7DWCYrdXzeRGz1D2A0ssrDjB
	 Mwr/6tG4ESESK1COpL7kDvI0bKB0+/9jQxFkmlmnbZS2WGk5p5epcH4ik/LdphIQkY
	 e4BIlP9Vd9pTuhZDTsVevQIemhh/kABtvpqK/OKY4M1vzcxnvOtcxh4IG7rYjssZ+U
	 N+TLwFIChvTMw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522F8D41D6B;
	Thu, 11 Dec 2025 17:21:06 +0000 (UTC)
From: Deepak Gupta via B4 Relay <devnull+debug.rivosinc.com@kernel.org>
Date: Thu, 11 Dec 2025 09:20:34 -0800
Subject: [PATCH v26 01/28] mm: VM_SHADOW_STACK definition for riscv
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251211-v5_user_cfi_series-v26-1-f0f419e81ac0@rivosinc.com>
References: <20251211-v5_user_cfi_series-v26-0-f0f419e81ac0@rivosinc.com>
In-Reply-To: <20251211-v5_user_cfi_series-v26-0-f0f419e81ac0@rivosinc.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
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
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Benno Lossin <lossin@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com, rust-for-linux@vger.kernel.org, 
 Zong Li <zong.li@sifive.com>, David Hildenbrand <david@redhat.com>, 
 Andreas Korb <andreas.korb@aisec.fraunhofer.de>, 
 Valentin Haudiquet <valentin.haudiquet@canonical.com>, 
 Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765473664; l=941;
 i=debug@rivosinc.com; s=20251023; h=from:subject:message-id;
 bh=DXRwVlzwdoQZD1P4AgHLEInq/8iOZjrgGgTHzLAJMYU=;
 b=0Dv74hXBGeBWjfcrTvnDOWwPkPd9Di2kldY2KrnrI7XBDo3LnCyqAM/EE3wTg03KyqefMIxt7
 jB5QQy+W8tED+wmP1c2WDSx9gEcyu7GDFvkzXMucAUjsZp+DrZPXcOM
X-Developer-Key: i=debug@rivosinc.com; a=ed25519;
 pk=O37GQv1thBhZToXyQKdecPDhtWVbEDRQ0RIndijvpjk=
X-Endpoint-Received: by B4 Relay for debug@rivosinc.com/20251023 with
 auth_id=553
X-Original-From: Deepak Gupta <debug@rivosinc.com>
Reply-To: debug@rivosinc.com

From: Deepak Gupta <debug@rivosinc.com>

VM_HIGH_ARCH_5 is used for riscv

Reviewed-by: Zong Li <zong.li@sifive.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Acked-by: David Hildenbrand <david@redhat.com>
Tested-by: Andreas Korb <andreas.korb@aisec.fraunhofer.de>
Tested-by: Valentin Haudiquet <valentin.haudiquet@canonical.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 include/linux/mm.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index d16b33bacc32..2032d3f195f1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -380,6 +380,13 @@ extern unsigned int kobjsize(const void *objp);
 # define VM_SHADOW_STACK	VM_HIGH_ARCH_6
 #endif
 
+#if defined(CONFIG_RISCV_USER_CFI)
+/*
+ * Following x86 and picking up the same bitpos.
+ */
+# define VM_SHADOW_STACK	VM_HIGH_ARCH_5
+#endif
+
 #ifndef VM_SHADOW_STACK
 # define VM_SHADOW_STACK	VM_NONE
 #endif

-- 
2.43.0



