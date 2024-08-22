Return-Path: <linux-fsdevel+bounces-26607-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE54995A993
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 03:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC3D6B22E37
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 01:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87E220DC4;
	Thu, 22 Aug 2024 01:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kIivKQSG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148111F959;
	Thu, 22 Aug 2024 01:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724289460; cv=none; b=NHrnOvvaWAMT23kasdSGSFwi8XehnJ0AYPZnMgLTujEPUON4rRp5pNUZBTV0zlr5TU1NYCtrGZqKhEMEsR/cjSga1DcfeHu02Zj2lK/UQ2B3cprb3NUdHiwngMZ6MDtp4lRYs5ZCkkXDfqDycid4AwIQR/wrPjVi/Lp9vqVCSjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724289460; c=relaxed/simple;
	bh=aZLVmFYMLYBJTw70Mh617DMlgsxzLSY47vsY1KvY2Vc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZWEfiucAjYWfy3/5fIP1M93t2sZFWqJNw+PTPZGG9krETlsCi0kTWmhuQuO60TDIbBq7zJ++0JoDxtGQpCni08XoehxDwsX4zGVAOP5IVhWaMtMp3m02mIKwyF14QXuivfl8BMJ0/snVqahnHrNMHkJalTdGAtRFAMU9/bZiS64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kIivKQSG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF941C32781;
	Thu, 22 Aug 2024 01:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724289459;
	bh=aZLVmFYMLYBJTw70Mh617DMlgsxzLSY47vsY1KvY2Vc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kIivKQSGpQSMGesZeZgd6EBVYcpjhPxumfuuyC1p9tLsRr2Q9SiO2JjKpk9IJ970F
	 QW0oBx5qMnjcCkmFzqUArHSdu3KzS60Ula1K+FyAl0NgkX8lA3mUiV8axyDBrpZWE2
	 d3nawa5CPUPKeaW7ikc2aMfPBzHGmaPf401yacZaPImXJk3TbQWMl1KRAFqnqSSn7D
	 s2CFE2ZUelvKaDU2iCd9auzcr0BaTS/BOYm+amy8hdPRYcpCsYD54VrRck9dGIF/S1
	 QDgwgOZWfvHkyrMGtGWUm7fKXcGkJAG/gJfe4hKiexxnNv4bwIbu5tWBOsmII+0LSe
	 cnUA7ywedOPjA==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 22 Aug 2024 02:15:11 +0100
Subject: [PATCH v11 08/39] arm64/gcs: Add manual encodings of GCS
 instructions
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240822-arm64-gcs-v11-8-41b81947ecb5@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2696; i=broonie@kernel.org;
 h=from:subject:message-id; bh=aZLVmFYMLYBJTw70Mh617DMlgsxzLSY47vsY1KvY2Vc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmxpEqSVw2r4ilkuviLbtznHIABDg2HEMzffXxUJ6D
 MEjU4wyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZsaRKgAKCRAk1otyXVSH0N4dB/
 99OzTeqSA3NOo7OYbw+6Rwxyr3PDmuu7cyAle67OiuNLbYu8Fk1BmI7TDD85cYCDnsul2JxBzQwAsl
 Mhy24rgr/81vx+t+fzDb+cot4ubucREQchZjPCfZ1u1WGag3j/PWeixz8DHeIQNeY3sjir7SMRsPwp
 oOZ6zbDXQ+kshYql+eX5ex+7xP1xYXNKD3+1/Bcq/EWmHuOMTW5HDB55AgXbRwf4pB8I46gYeRwpU4
 RnQRpTyPVmhmAGPkBF7dvARC0fVU5ylBQ2tQt3PM4aW6EWRt3fz/0WCzT0fCZBHisHFkcW7ddnwkn6
 rUXDI47uLqnmhOmCMI6p+MzJusFugy
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Define C callable functions for GCS instructions used by the kernel. In
order to avoid ambitious toolchain requirements for GCS support these are
manually encoded, this means we have fixed register numbers which will be
a bit limiting for the compiler but none of these should be used in
sufficiently fast paths for this to be a problem.

Note that GCSSTTR is used to store to EL0.

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
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
index 28f665e0975a..6aba10e38d1c 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -502,4 +502,26 @@ static inline size_t probe_subpage_writeable(const char __user *uaddr,
 
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
2.39.2


