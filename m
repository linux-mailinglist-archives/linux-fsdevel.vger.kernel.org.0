Return-Path: <linux-fsdevel+bounces-3389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 508377F426F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 10:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 818F91C20987
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 09:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD1F56471;
	Wed, 22 Nov 2023 09:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUa44Bi6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F7F1DA53;
	Wed, 22 Nov 2023 09:46:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A99AC43391;
	Wed, 22 Nov 2023 09:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700646391;
	bh=I+uVw8aipGa+8Ns9k+b3dq26kNHNXYgyRv4lZpoE8Nc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fUa44Bi64x8jXoE/MvI8BIoiZzNypKXZeeiprmYPWGJR3lX5FGydI1vtuAYWadks7
	 UasgH5m/KtJQsDRJFu9SVTzRRZ09vZBslyb0Ho2ASTSMbx7DP6p+CS8+ianT5KLmas
	 tJXDc07OIjutHkKJCdOQ9rbHFcS+M1Xk9x0/2ZDaXRW8l9gWOsMXGxNr64kYyyP2wN
	 wkARHPE4CLrm5Ok5GqnIBpxAl47axEAxsh9fxCbSQqsYrNum0vfC6FHddFrleyQ0jj
	 1fispSHLot6aPOIBz5WXtqFTgm3jtICwL5ybtt6OQ3R735RlkVitJiiQ8Rd9rwhnj7
	 yf08/Sy6l7Hug==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 22 Nov 2023 09:42:38 +0000
Subject: [PATCH v7 28/39] kselftest/arm64: Verify the GCS hwcap
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-arm64-gcs-v7-28-201c483bd775@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1190; i=broonie@kernel.org;
 h=from:subject:message-id; bh=I+uVw8aipGa+8Ns9k+b3dq26kNHNXYgyRv4lZpoE8Nc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlXc0MyzVIJO4Kid9gCsCQr45ifThlTEHkARV/j
 UTsXVxwqbuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZV3NDAAKCRAk1otyXVSH
 0PTmCACERewHlO0lUDAx7VBob22qNqbBIi4nI0finRcfRAMHGdVUVIxWAqs+6UQtEQWTanwoxxh
 RHNYkE5AnkhBIVqgo9rPkkciwxmqsPMafm9s1H0t/nysi4FdiMxIMpg6pQt0D3ydQ1Psg/yCml7
 nbLsDLWDnrT2PZBbwMSZdbxpf6TLjfDdFnf2PqTp7lJXdovzdfaZM83h4amYvIT+snl3MZDg+DE
 yO8Tc24qt+aAP5Fbjm4kLsSFx2poUdmSadKGczZTZxfOnsCSNiQjkj2FshEGptZPCYDyN1vmU0z
 I1pxYkitO980tsJqitFcBPPgoo+CvzMYooor7SZAL9CXXBHj
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Add coverage of the GCS hwcap to the hwcap selftest, using a read of
GCSPR_EL0 to generate SIGILL without having to worry about enabling GCS.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/abi/hwcap.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/testing/selftests/arm64/abi/hwcap.c b/tools/testing/selftests/arm64/abi/hwcap.c
index 1189e77c8152..bc9e3250a9df 100644
--- a/tools/testing/selftests/arm64/abi/hwcap.c
+++ b/tools/testing/selftests/arm64/abi/hwcap.c
@@ -63,6 +63,17 @@ static void fp_sigill(void)
 	asm volatile("fmov s0, #1");
 }
 
+static void gcs_sigill(void)
+{
+	unsigned long *gcspr;
+
+	asm volatile(
+		"mrs	%0, S3_3_C2_C5_1"
+	: "=r" (gcspr)
+	:
+	: "cc");
+}
+
 static void ilrcpc_sigill(void)
 {
 	/* LDAPUR W0, [SP, #8] */
@@ -360,6 +371,14 @@ static const struct hwcap_data {
 		.cpuinfo = "fp",
 		.sigill_fn = fp_sigill,
 	},
+	{
+		.name = "GCS",
+		.at_hwcap = AT_HWCAP2,
+		.hwcap_bit = HWCAP2_GCS,
+		.cpuinfo = "gcs",
+		.sigill_fn = gcs_sigill,
+		.sigill_reliable = true,
+	},
 	{
 		.name = "JSCVT",
 		.at_hwcap = AT_HWCAP,

-- 
2.39.2


