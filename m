Return-Path: <linux-fsdevel+bounces-3368-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7497F4207
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 10:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B9CD1C20A54
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 09:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB155576C;
	Wed, 22 Nov 2023 09:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qs5YB6BE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07D016407;
	Wed, 22 Nov 2023 09:43:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F1AC433C9;
	Wed, 22 Nov 2023 09:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700646225;
	bh=AdenxNKaKLfO1zzZHzslCIJebdi1YPs1wuXZd9U1dO4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qs5YB6BECnMAmghk+5k7QLjQ4iTf/O6w9uwKHheCTbxYsU4dCielXXbKpJWvVJbOO
	 eHvstQrw3PY/tc2Itmd0DGJ7a9XLXgveUYEreP0NdC2bZwRKN8Csxmok8dA98yK6jJ
	 pc/VhN++Iddv1n65+uxrwhQVBNX4wTnb4RntXV6p1LG9HjaGajgFeuYEg7d8W2vnS6
	 DsVLe11iXrOgM+nfF8hv0a4E3fBTkDuQgmYeEb5x+merErzYBI1UBOYtqum9DhkAEu
	 iz1H6w7wU93+McmzZK2pTguofmFSA0eW8JcDbFbW+BkqVIf9s/MphpA8RcRNk9/QCg
	 +DKBkAjfQe8QQ==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 22 Nov 2023 09:42:17 +0000
Subject: [PATCH v7 07/39] arm64/sysreg: Add definitions for architected GCS
 caps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-arm64-gcs-v7-7-201c483bd775@kernel.org>
References: <20231122-arm64-gcs-v7-0-201c483bd775@kernel.org>
In-Reply-To: <20231122-arm64-gcs-v7-0-201c483bd775@kernel.org>
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
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1363; i=broonie@kernel.org;
 h=from:subject:message-id; bh=AdenxNKaKLfO1zzZHzslCIJebdi1YPs1wuXZd9U1dO4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlXcz8bmHxgHWCFRqVN8uz2M3iReNk3BZizcael
 fYUhMZ5DoWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZV3M/AAKCRAk1otyXVSH
 0F7RB/4ql9JuD5+zDZkKa3IqDccJ/whQ1MzEyDazvd5D9iSOO2uFVWKf/mgBe42Co9F7iJXvawY
 fnM4HLJ+2I6Jpps5E2t0pRb5MPSbFPYrmiDpnpwyH+gCNdD/ISBWGGKi19hQLMzotC2usKxe7n/
 ZPPgZlodquDSXAvzd6yBK/QAT+KqARuuUYjttCxdlJOeU0BHNEbhz8/owbin6JfrC1GTlcGGFai
 aASFR2cqBA+/sxYNdN9NjVEQv2zxSBdFJ+zVZ1qt29sVNQq4+UVEYWYK5MXwadGBn1rZoKRfQA/
 I2UNt33vEzbJko8U/aAkwKFHIOuyMBeaY7xivvSZlmH0QBVz
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The architecture defines a format for guarded control stack caps, used
to mark the top of an unused GCS in order to limit the potential for
exploitation via stack switching. Add definitions associated with these.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/sysreg.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 5e65f51c10d2..75a49b41fa93 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -1039,6 +1039,26 @@
 
 #define PIRx_ELx_PERM(idx, perm)	((perm) << ((idx) * 4))
 
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


