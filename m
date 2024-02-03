Return-Path: <linux-fsdevel+bounces-10148-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BF284858C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 13:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F92F1C218D4
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 12:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837965F572;
	Sat,  3 Feb 2024 12:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s313Wgbk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17015F55C;
	Sat,  3 Feb 2024 12:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706963270; cv=none; b=hIQAblYz+jbPKm4cvcxo6MZCEVR0gXK+vx8/vPTTb3RblKNEEgQ486rUe3QXz9y6eTCR/kR6EPAIn0ObZGcDY8bQhs2iwJotPmSKW0xzNbjVDPWc1ltxzOdgsjzkydrMlcmSNVyJhH7x5X4Ua9rRsJdR/X37SYtV0ABAwLjp7Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706963270; c=relaxed/simple;
	bh=uElqfQr2KtEKDlB4Anquq4cFfJfq+1aLsyIKGyzwTJE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tLJCc9UN1AStbCRlLcN3df8m/LsnqOC6HcsJlbfKe/6/GvWQbOn0uy9MBSp/+qeV7jSq7U7rr5CgHDDgA2Vl7LCX0rp1OSeQXXqghMHHFRTCNI0HFVkoSCAINUoJ2i3YBK619Htl8R0tNb/YrQ3u2LjFPIT3PyE4vOZxgy083/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s313Wgbk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76937C433F1;
	Sat,  3 Feb 2024 12:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706963269;
	bh=uElqfQr2KtEKDlB4Anquq4cFfJfq+1aLsyIKGyzwTJE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=s313WgbkOz6vbnCBve0R1yHwDF1pK5mK+UYPA+OD99GziD3jcKqQKnySBTBGi4duj
	 vqr/SmLkHLF4Lk3ruhNzm4cJmmH3yq67ODVpGPJa204lWf5JGzspt5wcs+jVeTqQ3S
	 xhGc67JCzmdfCFdtsQj0eD1MNq802vjS85i8oJ77UsbyUsgJU3LC/razYzQhP82fOZ
	 yUEt8OsHLWgjE5yCQS9U678Dqz4m0U/3+3XD3cpVQmlStDup2yznD4F1i3uy552aa2
	 ph8TrgcsHHnR/DdeZgxHiKuE4/CWD9hXMRVY4GM5fwosCA8s0HuS3SOZeZGavv+/d9
	 AJIcyVewnHvvA==
From: Mark Brown <broonie@kernel.org>
Date: Sat, 03 Feb 2024 12:25:29 +0000
Subject: [PATCH v8 03/38] mman: Add map_shadow_stack() flags
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-arm64-gcs-v8-3-c9fec77673ef@kernel.org>
References: <20240203-arm64-gcs-v8-0-c9fec77673ef@kernel.org>
In-Reply-To: <20240203-arm64-gcs-v8-0-c9fec77673ef@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Andrew Morton <akpm@linux-foundation.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Oleg Nesterov <oleg@redhat.com>, Eric Biederman <ebiederm@xmission.com>, 
 Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>, 
 "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>, 
 Deepak Gupta <debug@rivosinc.com>, Ard Biesheuvel <ardb@kernel.org>, 
 Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Cc: "H.J. Lu" <hjl.tools@gmail.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Florian Weimer <fweimer@redhat.com>, Christian Brauner <brauner@kernel.org>, 
 Thiago Jung Bauermann <thiago.bauermann@linaro.org>, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-a684c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1759; i=broonie@kernel.org;
 h=from:subject:message-id; bh=uElqfQr2KtEKDlB4Anquq4cFfJfq+1aLsyIKGyzwTJE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlvjDTUIBdLAQcWP64eMtOa1tBhyxd3vT1/dabcKsI
 J03ruPGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZb4w0wAKCRAk1otyXVSH0H1sB/
 48Yjm/fTfaRFnrNWPL9rLUxz1LhV7ouhYI4uPWpceW/ximquDLxZHEc/zFA3kWQprsk3kgF3Ek+H4h
 sJ6pKh0M9pJjZAaoKYLHUs725T3HFZXBH+EY+nMbrwxH0LDhcfEZLPfhdYFuRJJf43IjfuPzYjQF44
 RFh4W9ZcVujZWePceJLCoClhHmUjxLuT2mjx+h0DBhjLu7LU6hT0wiXmkntjXRiS99AUMr2o7qNyms
 aaPTUAlLc0njj8DVRSzXsIP/EhochXn1l2v8kaUwkKB6RZSxGLBAWOqK9emNUOuONlL5xtKPyqXGqA
 OIJpJdP//0DLv8SNxwE5R86ch2Uq66
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

In preparation for adding arm64 GCS support make the map_shadow_stack()
SHADOW_STACK_SET_TOKEN flag generic and add _SET_MARKER. The existing
flag indicats that a token usable for stack switch should be added to
the top of the newly mapped GCS region while the new flag indicates that
a top of stack marker suitable for use by unwinders should be added
above that.

For arm64 the top of stack marker is all bits 0.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/x86/include/uapi/asm/mman.h | 3 ---
 include/uapi/asm-generic/mman.h  | 4 ++++
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/uapi/asm/mman.h b/arch/x86/include/uapi/asm/mman.h
index 46cdc941f958..ac1e6277212b 100644
--- a/arch/x86/include/uapi/asm/mman.h
+++ b/arch/x86/include/uapi/asm/mman.h
@@ -5,9 +5,6 @@
 #define MAP_32BIT	0x40		/* only give out 32bit addresses */
 #define MAP_ABOVE4G	0x80		/* only map above 4GB */
 
-/* Flags for map_shadow_stack(2) */
-#define SHADOW_STACK_SET_TOKEN	(1ULL << 0)	/* Set up a restore token in the shadow stack */
-
 #include <asm-generic/mman.h>
 
 #endif /* _ASM_X86_MMAN_H */
diff --git a/include/uapi/asm-generic/mman.h b/include/uapi/asm-generic/mman.h
index 57e8195d0b53..d6a282687af5 100644
--- a/include/uapi/asm-generic/mman.h
+++ b/include/uapi/asm-generic/mman.h
@@ -19,4 +19,8 @@
 #define MCL_FUTURE	2		/* lock all future mappings */
 #define MCL_ONFAULT	4		/* lock all pages that are faulted in */
 
+#define SHADOW_STACK_SET_TOKEN (1ULL << 0)     /* Set up a restore token in the shadow stack */
+#define SHADOW_STACK_SET_MARKER (1ULL << 1)     /* Set up a top of stack merker in the shadow stack */
+
+
 #endif /* __ASM_GENERIC_MMAN_H */

-- 
2.30.2


