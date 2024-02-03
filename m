Return-Path: <linux-fsdevel+bounces-10151-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9B984859B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 13:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3AACB25FB9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 12:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1CA5FDB6;
	Sat,  3 Feb 2024 12:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="osiScCWg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6075FB87;
	Sat,  3 Feb 2024 12:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706963369; cv=none; b=U5dajNLiR0OBbQgN8k/s0G9fm7T6el8DSyGOSp/ileLh1K/Ke4Kr1BGZk+r/6TOv2BBtwI5r/r4pZV4/DlPGkd0/Ati9NI54yvgVMsRl0m7V+bW7AspfrerbhubsAdCSolotwUP7sdg9h6fpyDH1DMMTvb5ptXaaxLwWcSOlz/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706963369; c=relaxed/simple;
	bh=nfp6EMTmsacTE8jIWijq0csUQnWyRS9dbPzwDPbc9Oo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HV3AlT4YECIm8I1SlWDZrxo21QHSghNaHq28yfYVtHc1/gHOCzpmgCAK+Gz2XHJn7l72G7U03e4fqVBYyBYQ1luiQI+/wTRvEwXAo0YmWGM4t7Hu5p63cdkBDt5RnIvBjsI8aq7Z/q4HfraPeO2n1cMK5+7O/7HOvKcQINala0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=osiScCWg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C2D4C433C7;
	Sat,  3 Feb 2024 12:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706963368;
	bh=nfp6EMTmsacTE8jIWijq0csUQnWyRS9dbPzwDPbc9Oo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=osiScCWg4d3KIQZcrJeOEESWG83yHbzhiGcQeX7MowDI3BpjPG0b59J5w0TMyUGhx
	 AiZFxIDmeGUFCmE3Gx5qt5Ekc13a+DGzvGFihiMuVXGFOpCy0HP16OhiVdFRNmINdk
	 B+++NJvgEKQkXUHftLefN+RkWlfmRMCdidNYbJscH4DWcTBUpNux0R9eWYq6BgUyJf
	 ZIpFreOOPDY1dmytZEu+vqVlYuYTsEYckA3a3Ae8EXP8Uz0zdzKlWfbpI0+Y+oqN/+
	 8BARDvmTtKiPJDePxkqMCbgacVKxEXJM9wA9NjmKcvMUJHFKUtFzBD3+BpE2U3mXGq
	 6FWOb2QFd08tw==
From: Mark Brown <broonie@kernel.org>
Date: Sat, 03 Feb 2024 12:25:32 +0000
Subject: [PATCH v8 06/38] arm64/sysreg: Add definitions for architected GCS
 caps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-arm64-gcs-v8-6-c9fec77673ef@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1355; i=broonie@kernel.org;
 h=from:subject:message-id; bh=nfp6EMTmsacTE8jIWijq0csUQnWyRS9dbPzwDPbc9Oo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlvjDV9XvzQG5mbwdmnxaEA2beaNmzTLR4QnZfsb5k
 dABRgtOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZb4w1QAKCRAk1otyXVSH0DSDB/
 4ndgRTySkwuTALaejt2vvGqwqgfiRnfYkefv1ma8rX3ZFKkMhDmmWTaqgOWLCRoex5Fe5UhcFwYrHT
 a2aI58d9V1IAUodeTLqo1GD5DaDA4u1/tDmYlgYmy9u9PJrnPonUUaYzkKVfkOHjIVRvFL75b9VcNH
 ax5DpBY3FxYokPpg6PWwG8R0LApWNrwrEMY/jxDYInXcBnW8nnqGaG5PQ7XlpwM04YBo00koRuPJ/3
 Sc3T/ew/2wbt3217BNKGVIUpFtzCn83x7VLwr/Ht3vfMrHO0IkX0V/RAxhBMYq9JvGYMm5rL/cCkbA
 OLa29/wK/D7MMMDE1wda7wLwRtVOwc
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
index c3b19b376c86..6ed813e856c1 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -1064,6 +1064,26 @@
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
2.30.2


