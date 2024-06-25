Return-Path: <linux-fsdevel+bounces-22377-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F59916BB2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 17:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B9221C25186
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 15:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8C417C7B8;
	Tue, 25 Jun 2024 15:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LB1z0uLC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C5816C840;
	Tue, 25 Jun 2024 15:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719327692; cv=none; b=exxtaIbXqgYc0P4/8ZVtr8btQPpxPXU+oZOZyWhTh9o+Bx/XfNwUq5dV44rD30OoQEgs1A0HnXo02Jfz8adaR2ckabd/q7SovwVvwJ/pBGzm0Dj1VH78HHTkLwwvL9pG4Q8oMisDYRYtqjARE3BdDfdNyQi1a9mtsI+WQvK+9Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719327692; c=relaxed/simple;
	bh=FZl6osZQv9tUt2U/ynTpAvRjKv0nX8jhIzHo4KZI7Xc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xq6UeZajQvpe+MvfxoC0XmlwGQVKtq3YXUsu+PNdfwAI3cS6HZFVwwGSYeVmKFHgHt/37x5eC/32M6/M9hZUwpehzHMilbCyHvnryuGBcBsUnL2ULQQdea4+Va8k2/LwDye9rsQQ3002+ARBLEbPlntCjwsUYY51fvR5lHumyCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LB1z0uLC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86A8EC32782;
	Tue, 25 Jun 2024 15:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719327691;
	bh=FZl6osZQv9tUt2U/ynTpAvRjKv0nX8jhIzHo4KZI7Xc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LB1z0uLCfALEQBxZq3EKZVaHBNY3stJUGGS33HnAF+qvGORdfESqvZIYxkj7bv+HS
	 L54U6Iv2tOs7j44tOE4h84EJHGTDTjVlcLQ66TCpZjGdtamPPWx+W+Bk/1zpl79jTs
	 jEkOH3pcuJ9K8R5CN7nTj8KGgEESCqUdR3u1CW3/JZ+hI+fOukZ6IgdLE8QPpSaRSl
	 Mk3jTJZCntx0mFGHWhgYC7NFHGichd3Kt/0PHDAD4/TAgKu2FgqexAejVK5n7sGLxs
	 3Wwr+VUqSM/UeLdYhiOS9WB70a43AdK2D82QFbm3y+bMh8yXGTcW6K9Wkz8IKHsBlm
	 UnY7K7gsZV2sw==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 25 Jun 2024 15:57:35 +0100
Subject: [PATCH v9 07/39] arm64/gcs: Add manual encodings of GCS
 instructions
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240625-arm64-gcs-v9-7-0f634469b8f0@kernel.org>
References: <20240625-arm64-gcs-v9-0-0f634469b8f0@kernel.org>
In-Reply-To: <20240625-arm64-gcs-v9-0-0f634469b8f0@kernel.org>
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
 Ross Burton <ross.burton@arm.com>, linux-arm-kernel@lists.infradead.org, 
 linux-doc@vger.kernel.org, kvmarm@lists.linux.dev, 
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.14-dev-d4707
X-Developer-Signature: v=1; a=openpgp-sha256; l=2643; i=broonie@kernel.org;
 h=from:subject:message-id; bh=FZl6osZQv9tUt2U/ynTpAvRjKv0nX8jhIzHo4KZI7Xc=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhrSq2+XPXm/0bpVzD/k8YQlf0IX13+pntU0rfHD/iHhl8g2+
 bCazTkZjFgZGLgZZMUWWtc8yVqWHS2yd/2j+K5hBrEwgUxi4OAVgIh/bOBjaedu9c59WSqjki3yWWS
 WkUBj+trxszfmbhX3ln+cJShS8Cf0lqbfX6VfE3P7yG7qM5zdnnxDcNe9lvfSEMtXr+wyKs4KnPrjO
 03bX9I920aOcdusdTDx8LEfvPJc1S5Bz4Jy27qW2XSfTifyd9orsthH/duhkuLbstLrrWjLxtWfwzk
 6TSn9Fq1bVzi+rtRec4WJ5YrXh/5FvbypfOEwRnKmmf5YhbIl8RkBTI0+Vo70zt8D2Rc9+x0nrhWux
 r9w2U1Q0s4QjMOj/WnnbwBuuEyavaqiPEJ/ixn6mNC70/Lm+SL2s3r87+cOPFieUOHbynL2RzijscI
 z1zj19gUM/3++5eqSDT/FKbYIsAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Define C callable functions for GCS instructions used by the kernel. In
order to avoid ambitious toolchain requirements for GCS support these are
manually encoded, this means we have fixed register numbers which will be
a bit limiting for the compiler but none of these should be used in
sufficiently fast paths for this to be a problem.

Note that GCSSTTR is used to store to EL0.

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
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
2.39.2


