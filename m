Return-Path: <linux-fsdevel+bounces-10152-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 477B68485A0
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 13:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AAD91C21895
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 12:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7AE5D911;
	Sat,  3 Feb 2024 12:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dTXtO9zo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EEC1643A;
	Sat,  3 Feb 2024 12:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706963388; cv=none; b=CoTdgAq/MTawj2Y3Nazr12VZndqOG2tbdFjiJf8x3U9QXkSVAhSsaEI2IKJhrDVlBlhP2LMyG738cs+vU2DgWhys2bCH9qndvqssA15YyoYomTWXOU4kwbE87M5lRfMjBeiy09i8T4vxFGix8t1Om3NH4zP/PXpnCVPbkBg+trQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706963388; c=relaxed/simple;
	bh=sadX6jRs7DdBAThhpdGK2D3phr2V3dLQCMXle4b8GlY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ab9SLds8OMhTrkK4ZsKLFOqcDUByqzQrCDAgxrLUkMT3QCffcl9/Kd6i7byP+Ax5I2Sf6mdvRMV+OW5FjcJMLNFgTuQXHKhXLgQpBUGfamMXq78AW0DkDgyGlH6IHxIn1fGqK/IwJosAaBLn2VyJHp/bXdDueVOeF7A2jTgIgx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dTXtO9zo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA6CC43390;
	Sat,  3 Feb 2024 12:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706963387;
	bh=sadX6jRs7DdBAThhpdGK2D3phr2V3dLQCMXle4b8GlY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dTXtO9zoQm9JKCKVlTQvs8wgeMjkGOAr950r85KgQGAT34nQSSQ2ln64WxHAiJSSm
	 6PEarPvcoqFTmKT5cj+HNeUFr7pQcIfGbe/klZhA+Gkoa1v65gL5yD+Mqw28o9xbW0
	 XEQWk+Cl9jbYrlf5kijxq1s1ROA0BB6StTf0KMmMKXIXwpAXOM4xDKVclfS0df/Po7
	 Rg/marbuHTjU5J+T7iEW5sdtvASHVxoDEH5nKmz85XW+1Sl01maEm6BdV2XzdcuK/R
	 tONiZcB3QLD8rufqmcRFLGHZ2neKaX5nb/wRhPu8oq4ux9CAUl85rntpWtq1LMJ8Ql
	 D7+aWaDk0Ov9g==
From: Mark Brown <broonie@kernel.org>
Date: Sat, 03 Feb 2024 12:25:33 +0000
Subject: [PATCH v8 07/38] arm64/gcs: Add manual encodings of GCS
 instructions
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-arm64-gcs-v8-7-c9fec77673ef@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2577; i=broonie@kernel.org;
 h=from:subject:message-id; bh=sadX6jRs7DdBAThhpdGK2D3phr2V3dLQCMXle4b8GlY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlvjDWl0RFbpcffLYcZJBiVq99jNr+C4cCBZd5T7RM
 G4XEv1eJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZb4w1gAKCRAk1otyXVSH0NwrB/
 9qoPgQtako2eNJFYJjaadGibJhrC+O0rrQ1WjE8Q9ksJCD+xyk2iXaeED1LmGEM3ZQMaNLezHZnqCE
 YzpJZxzTffvJ8MbMj0ZW+j7kI8MOe0jm4w+PMPvPf+YCHQA6kzklMsd8HOMnmCxKe01+hbtiiPcqoc
 JTMZW6BCL8+fjQ4aICJpz1CafRa5IhasNRga1FPU8SCgl0E+ojogy3ewXC9Q7Wit+8L8ZW94hHa7U7
 iVy9XiEFddFnqgZdhk3E6a5F07EjPMBMRMbI2jRxrz1G2a9/PDQ8C8bc23U49FNAxKrBjW3jJR6IZ7
 NU+2krwITMBnkNo5cyh4uleB8jnJMb
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Define C callable functions for GCS instructions used by the kernel. In
order to avoid ambitious toolchain requirements for GCS support these are
manually encoded, this means we have fixed register numbers which will be
a bit limiting for the compiler but none of these should be used in
sufficiently fast paths for this to be a problem.

Note that GCSSTTR is used to store to EL0.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/gcs.h     | 51 ++++++++++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/uaccess.h | 22 +++++++++++++++++
 2 files changed, 73 insertions(+)

diff --git a/arch/arm64/include/asm/gcs.h b/arch/arm64/include/asm/gcs.h
new file mode 100644
index 000000000000..7c5e95218db6
--- /dev/null
+++ b/arch/arm64/include/asm/gcs.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2023 ARM Ltd.
+ */
+#ifndef __ASM_GCS_H
+#define __ASM_GCS_H
+
+#include <asm/types.h>
+#include <asm/uaccess.h>
+
+static inline void gcsb_dsync(void)
+{
+	asm volatile(".inst 0xd503227f" : : : "memory");
+}
+
+static inline void gcsstr(u64 *addr, u64 val)
+{
+	register u64 *_addr __asm__ ("x0") = addr;
+	register long _val __asm__ ("x1") = val;
+
+	/* GCSSTTR x1, x0 */
+	asm volatile(
+		".inst 0xd91f1c01\n"
+		:
+		: "rZ" (_val), "r" (_addr)
+		: "memory");
+}
+
+static inline void gcsss1(u64 Xt)
+{
+	asm volatile (
+		"sys #3, C7, C7, #2, %0\n"
+		:
+		: "rZ" (Xt)
+		: "memory");
+}
+
+static inline u64 gcsss2(void)
+{
+	u64 Xt;
+
+	asm volatile(
+		"SYSL %0, #3, C7, C7, #3\n"
+		: "=r" (Xt)
+		:
+		: "memory");
+
+	return Xt;
+}
+
+#endif
diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 14be5000c5a0..22e10e79f56a 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -425,4 +425,26 @@ static inline size_t probe_subpage_writeable(const char __user *uaddr,
 
 #endif /* CONFIG_ARCH_HAS_SUBPAGE_FAULTS */
 
+#ifdef CONFIG_ARM64_GCS
+
+static inline int gcssttr(unsigned long __user *addr, unsigned long val)
+{
+	register unsigned long __user *_addr __asm__ ("x0") = addr;
+	register unsigned long _val __asm__ ("x1") = val;
+	int err = 0;
+
+	/* GCSSTTR x1, x0 */
+	asm volatile(
+		"1: .inst 0xd91f1c01\n"
+		"2: \n"
+		_ASM_EXTABLE_UACCESS_ERR(1b, 2b, %w0)
+		: "+r" (err)
+		: "rZ" (_val), "r" (_addr)
+		: "memory");
+
+	return err;
+}
+
+#endif /* CONFIG_ARM64_GCS */
+
 #endif /* __ASM_UACCESS_H */

-- 
2.30.2


