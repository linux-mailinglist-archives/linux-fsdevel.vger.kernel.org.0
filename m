Return-Path: <linux-fsdevel+bounces-26603-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 376F695A97D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 03:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5B8D284B02
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 01:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DF414277;
	Thu, 22 Aug 2024 01:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LGNDWsFl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6692ABA42;
	Thu, 22 Aug 2024 01:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724289413; cv=none; b=EjqU71UTty+qlt8eu0P7DZV/MPmHsFPA79TW8hCkV8nkbsh47ix2PIJSK55Nt7bG+pOrcX5PIDM/ycuFe/cawDSan0thEyhJo1NlqszfyOs5UE9OMATOemgBg4F0mC3J8WROSPX5qkshq3eVwNse3GtS4lhbeMEYKai5wuDdNLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724289413; c=relaxed/simple;
	bh=/QxGsZ7kGu5gcX/2Pir/IdpixOHnIz8YHhHUjvvkxmA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mQmiofmE7Xpftl6sXnlvDSzOJM/XXzEzhuFwnxSAnJRI9QuJAzrfLapZzdadEjocPLv91XHZZMm3DTx4suNDnukJdQaBDcvaec6vddgXr+YYVyKWk6YVDltBGtQ3bIvzY7rU4utTDT7G/yVLzp21eKxjD/uXDle06lC3i+7+jWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LGNDWsFl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6297C32781;
	Thu, 22 Aug 2024 01:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724289413;
	bh=/QxGsZ7kGu5gcX/2Pir/IdpixOHnIz8YHhHUjvvkxmA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LGNDWsFlzxJpsLAVIpOQEC5kb6i5ctYSjTkS7zqKfYjDO4HeXm79/cVdBPJvmur9S
	 od8xZNlqIyVK5T1bqkMmjcHzbj6a0klUysAlpQi2Yhgih8mzhbij+KdMseAm/FdQaF
	 qZTBLHdveQuXmpCBhljTF9L8u25KyBQ3UkEXKwWG7h9HTFhHMq/8EFjSAASEO69fhU
	 Rha2NJPqhAg6/O6D/yn51jj4yM7pVQ00gtqctq6vmIsGxMeZC4BVUrbCVpCVEvt/v1
	 72uY1RjlmTcQPUSdvy9x3LJE8vZby6RTH8pn89jlq3aBz6DUaszeHlYh35wZz71MjV
	 TIllZc2KTvXAg==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 22 Aug 2024 02:15:07 +0100
Subject: [PATCH v11 04/39] mman: Add map_shadow_stack() flags
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240822-arm64-gcs-v11-4-41b81947ecb5@kernel.org>
References: <20240822-arm64-gcs-v11-0-41b81947ecb5@kernel.org>
In-Reply-To: <20240822-arm64-gcs-v11-0-41b81947ecb5@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Andrew Morton <akpm@linux-foundation.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Oleg Nesterov <oleg@redhat.com>, Eric Biederman <ebiederm@xmission.com>, 
 Shuah Khan <shuah@kernel.org>, 
 "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>, 
 Deepak Gupta <debug@rivosinc.com>, Ard Biesheuvel <ardb@kernel.org>, 
 Szabolcs Nagy <Szabolcs.Nagy@arm.com>, Kees Cook <kees@kernel.org>
Cc: "H.J. Lu" <hjl.tools@gmail.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Florian Weimer <fweimer@redhat.com>, Christian Brauner <brauner@kernel.org>, 
 Thiago Jung Bauermann <thiago.bauermann@linaro.org>, 
 Ross Burton <ross.burton@arm.com>, 
 Yury Khrustalev <yury.khrustalev@arm.com>, 
 Wilco Dijkstra <wilco.dijkstra@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=1882; i=broonie@kernel.org;
 h=from:subject:message-id; bh=/QxGsZ7kGu5gcX/2Pir/IdpixOHnIz8YHhHUjvvkxmA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmxpEm5kN/wk9/KZfcaloebeKbxKmUlgdTlw1GvdtV
 QGljy32JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZsaRJgAKCRAk1otyXVSH0G6bB/
 4oIpOZVu8Yo9IDRGCq6U5tCs4LXytwZCRgOuYex97b7Nkcj7jMWi4RhwitRZSfcpV0DbYlyYd+iWWW
 PXiCwTyXg40ZxbW3FSHAb0/7l1IC7zergq6B7kZ8GwyGAdYoI2VWcL668YXJJoQLkv2B67vBzFAWxA
 0aJoPCixyep42bVyjfHhbxUWuUVTm6Azfs8smOLro0yiE3SO1sDbg9IHXUv8KRtBB+liDWGGcGlCR9
 8cZ/Ui5XrZeRA2H2ClhqE8XtfVPG0YL24APKug6j9UtK+9QI38fi43WAWS9vEmgkxaxk8WN+QMdAyj
 N6cNfGTWdiZ/qqkbem1568AQ3f+9wl
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

In preparation for adding arm64 GCS support make the map_shadow_stack()
SHADOW_STACK_SET_TOKEN flag generic and add _SET_MARKER. The existing
flag indicates that a token usable for stack switch should be added to
the top of the newly mapped GCS region while the new flag indicates that
a top of stack marker suitable for use by unwinders should be added
above that.

For arm64 the top of stack marker is all bits 0.

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
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
index 57e8195d0b53..5e3d61ddbd8c 100644
--- a/include/uapi/asm-generic/mman.h
+++ b/include/uapi/asm-generic/mman.h
@@ -19,4 +19,8 @@
 #define MCL_FUTURE	2		/* lock all future mappings */
 #define MCL_ONFAULT	4		/* lock all pages that are faulted in */
 
+#define SHADOW_STACK_SET_TOKEN (1ULL << 0)     /* Set up a restore token in the shadow stack */
+#define SHADOW_STACK_SET_MARKER (1ULL << 1)     /* Set up a top of stack marker in the shadow stack */
+
+
 #endif /* __ASM_GENERIC_MMAN_H */

-- 
2.39.2


