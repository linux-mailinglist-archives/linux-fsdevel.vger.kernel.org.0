Return-Path: <linux-fsdevel+bounces-26606-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDAB95A98D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 03:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 152721C224F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 01:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AF9168C7;
	Thu, 22 Aug 2024 01:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Unzw3jsN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF6C1CFB9;
	Thu, 22 Aug 2024 01:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724289448; cv=none; b=FCi6oDMQDeiO7sV8+cGYwR4i9S9fQVYYwffvkPPw5MrfoJu/FFWVHYNk64ClkvD4AqCv2KqfO3hPlorid9IfH8MHeDieMKxOTOy3WBF3agJ97efG279MQ+QgjejDYN1ZR3pEd6l5IN2AeohkIR33UtY94lH4J2jAiQBwrh3DwaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724289448; c=relaxed/simple;
	bh=4p/cwsbgBUzYKsL2fclAIfpUU9Y3uPXu2QlRekLj7SY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oSU8nlr3i2/HkmAxpxrEj8MkPBlXKT1ys0zUu6l4rHmQ3DeVeY6D9U470NKxYHThsH/ehUKD1yGD+nHC0D5THKh9Zd0MIvKo81Gpqzsnz4L61bAHzE8S2uR4PGS9U4mJj3WFkX7vV9sTgdF/eQ8kOcAxcuRBnpK7b/tUzb5s5Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Unzw3jsN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDE1BC4AF11;
	Thu, 22 Aug 2024 01:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724289448;
	bh=4p/cwsbgBUzYKsL2fclAIfpUU9Y3uPXu2QlRekLj7SY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Unzw3jsNxdyyDEtIGbgFULuy333hOmD17NR3Hlokt62VSxENq+2yxdZcbSM0fnaVK
	 9D49lCPGa60j2YjpT8mZVjITIhthQPvvWA4uxeGd0ZfKivgnTcqgIHUizAV5vaz9fY
	 S23Xq1r4g6nE9i85Sa53p3eO8CrJUZUmOIYRbmOvGz/FBlat9dEV8Aj268VpkG4bc2
	 IsbGQ0B/0ScJtw7j4AFaJYbMPoZx553y+cjg1nI5UmUQIyjUl+2kuhtmSRJ5uYhvii
	 cNbCtaEcTs7TGjlAl4oyd4aOpSZ7I/6ySmHepzqGG0NVEyuss6FivB8NbQ0GXx67mz
	 Cz4Eh6c3AKXFA==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 22 Aug 2024 02:15:10 +0100
Subject: [PATCH v11 07/39] arm64/sysreg: Add definitions for architected
 GCS caps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240822-arm64-gcs-v11-7-41b81947ecb5@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1474; i=broonie@kernel.org;
 h=from:subject:message-id; bh=4p/cwsbgBUzYKsL2fclAIfpUU9Y3uPXu2QlRekLj7SY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmxpEp3emzJFbijnCU17Q0K9SIOz60aIHS82sSFhQJ
 YD5SleyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZsaRKQAKCRAk1otyXVSH0BnGB/
 9yAjOiAcje9naSPYMdZSES4nE6scTZSW+Adx1kpr9GXDoxaUVDWJr5DM/MLlhrRIxspzoUi27T9kZa
 VwHLkMBdQ60+0C28WkSrAZiu0hPIurM42vvhSFQmXMALp8l6QlFf3i1TYHPgRbmp8XXI2zyIGZ/6Hq
 9Dflnmsq8ebMHLxHmhTAm/IGOTdWrCW2GRpbuT32XqSNUmzmYfvkyTP5AZN6CQB4x3j2bpMryCwoxp
 GaMuj7yW8RNmMCOxFYbAr7jwBBR1EVjf8c4mkUNMW5APa/8uluyBzGdvqOmL2F/WxvmF7q///zZP+6
 e9qpNTuA76OMXiaJ2DqWoMg/6A1iHk
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The architecture defines a format for guarded control stack caps, used
to mark the top of an unused GCS in order to limit the potential for
exploitation via stack switching. Add definitions associated with these.

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/sysreg.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 4a9ea103817e..b8d8718a7b8b 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -1077,6 +1077,26 @@
 #define POE_RXW		UL(0x7)
 #define POE_MASK	UL(0xf)
 
+/*
+ * Definitions for Guarded Control Stack
+ */
+
+#define GCS_CAP_ADDR_MASK		GENMASK(63, 12)
+#define GCS_CAP_ADDR_SHIFT		12
+#define GCS_CAP_ADDR_WIDTH		52
+#define GCS_CAP_ADDR(x)			FIELD_GET(GCS_CAP_ADDR_MASK, x)
+
+#define GCS_CAP_TOKEN_MASK		GENMASK(11, 0)
+#define GCS_CAP_TOKEN_SHIFT		0
+#define GCS_CAP_TOKEN_WIDTH		12
+#define GCS_CAP_TOKEN(x)		FIELD_GET(GCS_CAP_TOKEN_MASK, x)
+
+#define GCS_CAP_VALID_TOKEN		0x1
+#define GCS_CAP_IN_PROGRESS_TOKEN	0x5
+
+#define GCS_CAP(x)	((((unsigned long)x) & GCS_CAP_ADDR_MASK) | \
+					       GCS_CAP_VALID_TOKEN)
+
 #define ARM64_FEATURE_FIELD_BITS	4
 
 /* Defined for compatibility only, do not add new users. */

-- 
2.39.2


