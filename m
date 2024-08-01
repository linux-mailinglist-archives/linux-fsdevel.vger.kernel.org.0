Return-Path: <linux-fsdevel+bounces-24755-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD9F944BF5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 14:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 518B71C23759
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 12:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97481A4871;
	Thu,  1 Aug 2024 12:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nmdd/qNO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A711A0703;
	Thu,  1 Aug 2024 12:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722517081; cv=none; b=aHsGy8+4DLJ2ofu1xRGkjMD/ipNWGs0BoWFNR1nBpWFdUmBuzYwIAqBcisKJEsIEHGrNYFZRdvtMynZAGCg3pohVXC6IDiC5PuRv+3WAoYS2/1SrTx31WjrP6NSh6d+CPjwZw3U2GxJqe8xkV0SDSLbgwMyPOIwbF5TiV/9uokY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722517081; c=relaxed/simple;
	bh=mym7o+ur4BbRj2ASFXSNRXGOKmfB+ZB4m72hLojRIa4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tn3rTN01e5RKwNglqtuaAiBptpvF8k68J9UqIy2rsqVnnGdFUL4JxFh+8SvpGTqEl0QVCQVCYWXG9Vkx27qGvjpdTKLWDx70szpzdbHpFJmN31bZQWtLAz4DBgwyZBjXA6yOs7Ghs3kIVpqN59Ae56KSqQXO7yCveS/L8hJjVyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nmdd/qNO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805F3C4AF09;
	Thu,  1 Aug 2024 12:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722517080;
	bh=mym7o+ur4BbRj2ASFXSNRXGOKmfB+ZB4m72hLojRIa4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Nmdd/qNOML0/WPSvFlhfPlPFhdWGDTeOehxKcqEpf3pUgk0DTgPcT6ho75GI2cH9s
	 V9oFZAomCWM0OIH2upCKRhoVP+5d6N4VQz42KdMbbc4TAEQVeCDdkKwlswhdSkRwAr
	 FUwVvQ9Z5lz/jE9sI8/DeuUqEy3W8GI6QftvN7ZtKtjB9jUws7JBoCyphjvomGDTE+
	 gFO4dEugK/8+qecErZI0sCkcKJEoS5uc/mfcjfIPkHNL3rO4K7sTrnouyFxgVR5CDL
	 zLqVRlTkVNLsVVadLPewREgLENPUiZlzlh8MN1E1K1yocY/aH4Wimxuz2auCxdp3l1
	 Bpq4xZ+Uo4Upg==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 01 Aug 2024 13:06:33 +0100
Subject: [PATCH v10 06/40] arm64/sysreg: Add definitions for architected
 GCS caps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240801-arm64-gcs-v10-6-699e2bd2190b@kernel.org>
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
In-Reply-To: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
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
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=1421; i=broonie@kernel.org;
 h=from:subject:message-id; bh=mym7o+ur4BbRj2ASFXSNRXGOKmfB+ZB4m72hLojRIa4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmq4YKMuPchzO3os0nL3U57pumieXoSD2PfbwOG1FY
 wWpxjVmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZquGCgAKCRAk1otyXVSH0JfMB/
 9S5qc+5UJ2Hq5Hh2gJZcqt5fs4hfsdHKXcwoKtpDSOxKNd+hIU23vQ23YrI62hlWogX++fZin4QYDT
 GOcCwT/cOUR3m/dL5FF4voHeOJTl2W7yFsUbSOey0f99FxqtjXHVe7w7DQvQrId6oU8t/lAsclZoHZ
 tQD9TJJJqolDvO5HE+DQ0fTh6WL5GECumUAW3lISgxymu//DrManuyXVjRouei1rgDvaJfd9mEbn8K
 hxDJrekIwc19/h44xJDi+e8sukKdHBCB2IAe8SSn7rqTq8apK5NDjamIvd72m5sbmWMbwAdHsJAqjc
 1iMoQNDdS3yVBU5/TM8YlURU/7VMsc
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The architecture defines a format for guarded control stack caps, used
to mark the top of an unused GCS in order to limit the potential for
exploitation via stack switching. Add definitions associated with these.

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
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


