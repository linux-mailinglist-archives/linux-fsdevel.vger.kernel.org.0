Return-Path: <linux-fsdevel+bounces-68140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C6ACDC5518C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 01:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 69BB3350139
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 00:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A78286402;
	Thu, 13 Nov 2025 00:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJlJjgOW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151D619258E;
	Thu, 13 Nov 2025 00:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762994622; cv=none; b=UlcyCEqOXJwagXwvlwIBWZdFLVasy3W3xFJLQUU/4K1WYefPfp/vweXbxn4e4DUGLUSeCN8V4GJ6SohyoxK1ElqTe/LRPdwQMrAS0YzTXLgjoERSuzq2qKWZPhCRyTMz8n6APez0+sBcQZ9uY6Cp/B7Bcf0L0oP4zXfUhbGtpig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762994622; c=relaxed/simple;
	bh=a58bONVF1hEXJcHKI9R0Y6L9RqhnS7srP5e66tDrhlU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r6pJV/3eNeZ1q3cS6+bSKTBVPq1/f82FLMRxbjo1ZYgbZp+fBYJ9yPjgq51rG0s8GvW7e4MP5pryfvGWTMjxaP3GB2pFJ0fjRaEySybBRIrshwzh6j+TD6wpRzOi0iTBpWPA91x135h06Y2gkquXK7+fXHZORU/23MzHrgwTnUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJlJjgOW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9249C2BC86;
	Thu, 13 Nov 2025 00:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762994621;
	bh=a58bONVF1hEXJcHKI9R0Y6L9RqhnS7srP5e66tDrhlU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=WJlJjgOWs49vJXxKO13IQ5+ZJkHPeUNUmt9Qa5lHD/QPpdKCS1l0j+D2E4LsItkqh
	 nR1lgYlaqLKJtjxBDkcXOd2FfpVfmuvuXooPAufwoZxRs0FmjahauvplMbV7JY2fnd
	 jYp6vO0f0stJd91blxsMgCLCLtJHKt/K9k0wWYvbaJZqgN07uIf9brhZ8eExmvk7hZ
	 iFOW3GQtVJ6MkTSPnLfbRzEOzLDpLDrrBqZaXRnYPm5oINizX/i1s2flnCuR8BRZjI
	 faITBYlPc1liDUyQHPQe1xaIFN3jAqGVNO3K96NgQ4eAhCMT4Ao6uCSDYPMaezg5H8
	 iAMw+cO189Wlg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D6E8CD4F2A;
	Thu, 13 Nov 2025 00:43:41 +0000 (UTC)
From: Deepak Gupta via B4 Relay <devnull+debug.rivosinc.com@kernel.org>
Date: Wed, 12 Nov 2025 16:42:59 -0800
Subject: [PATCH v23 01/28] mm: VM_SHADOW_STACK definition for riscv
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-v5_user_cfi_series-v23-1-b55691eacf4f@rivosinc.com>
References: <20251112-v5_user_cfi_series-v23-0-b55691eacf4f@rivosinc.com>
In-Reply-To: <20251112-v5_user_cfi_series-v23-0-b55691eacf4f@rivosinc.com>
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
 Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762994618; l=815;
 i=debug@rivosinc.com; s=20251023; h=from:subject:message-id;
 bh=pkBAvc0IieGGas1vvYQtOkKUWHcQF724uRmRqVMGgPs=;
 b=WN4zwZFejV79pbUOQoeRssm2N7dfg2ZW9rR31scsgggIJR9B+lZ9rPCZ52x0Nn8Xgk8o87/g5
 8gRdhV0/INjDZLdEyI3y197h4MQLHhbblyWw2Jxls08mui5lccpHYqZ
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



