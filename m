Return-Path: <linux-fsdevel+bounces-24776-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E83944C6E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 15:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94B6F283385
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 13:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017491B9B2B;
	Thu,  1 Aug 2024 13:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tnrq9/ql"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5396B1A38D3;
	Thu,  1 Aug 2024 13:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722517230; cv=none; b=FVAKj/O1cePu/zKAxgtSTyoDj1Inwpy1EPOydae1ckL1p7/x1aQVxxE+/wLjJOuEBo11F88xjYqnuKAIPpFtfY5dIeBDcxqpvhRYl7tV8eLjvlPg7lQnUyT3Ahn9tbYwH9Y00aBMQTGN6H73Xe2iwrB0VoHQcrt8c2250R2K91k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722517230; c=relaxed/simple;
	bh=oHs0edHK2ZH//P9wlXUiorha791DOO+hA3lq1vKIHRU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qf5CMtwYQ/5HNZB8UWzu3pbHqfNikq3lQ8Ua7zxOrfBwewb8/kTU/VMefV8Rvo1jUDztV3u2fni+Q/eb0nff/q4mnnweN+EpfJeaZghNsnCA+BoXZyv207kF/5fhfU65gZ3fA3e59dhnIUe9FSx9MSwMoBRzCG5x1+zYATYPsY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tnrq9/ql; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2541C4AF14;
	Thu,  1 Aug 2024 13:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722517229;
	bh=oHs0edHK2ZH//P9wlXUiorha791DOO+hA3lq1vKIHRU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tnrq9/qlz5GnEEEFFRetjGPSOWedcxCUE1yGkiFYjdws0U4itg41NBfsVY86Lvk6s
	 X+IpjSv62kIwlCfYN7eFvhz2sW+UwETmWdFlmMGMFBidDKWrg0ZHqgdbRt2HYW3gQn
	 MG0H6C/C54Id6g9ZGXA/pI+OHLR78Pd+3YU2MnbvW5YX/lYP8SuwmT0Nc9rNUHMH8J
	 QQOUeJTOom0yMSM3cBtJB4pqkkaZuDFclam5qISOmDOEzSnDQHeIdlYsrj37iRvIV/
	 3S0HHqq5YrZzkG0PsWgDt1Bg9UNBEFSgAE3wRUe8TprSjqCD4zoYzazrxW12lBGKYr
	 x3cLNAUNqLeaw==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 01 Aug 2024 13:06:54 +0100
Subject: [PATCH v10 27/40] kselftest/arm64: Verify the GCS hwcap
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240801-arm64-gcs-v10-27-699e2bd2190b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1288; i=broonie@kernel.org;
 h=from:subject:message-id; bh=oHs0edHK2ZH//P9wlXUiorha791DOO+hA3lq1vKIHRU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmq4YaR7eUIgxap135hy7ONIfzK5DCkSb7UQJMKMtp
 D592qJmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZquGGgAKCRAk1otyXVSH0ElPB/
 9ZXbE8s9vC+GQ95xVWW0x7DnbqqIxaDtNFUU54+Bf2g/sdyJFD0Kv9WAVrRQ0V5fpTxUrG23xXlFEF
 J1/nVz4ngvN+k2sXHHFlopJP23BUioBPLP2iyFvBtipYkXYxoDtbDG/SdYZipAfT+j+XnW+A9umF4l
 HNyylEPIp+P/zoxBJ1R1j0+MPSQH1BAW3YC4I6It2Qij0MQL36gOOXr9/HmD/+89eFIdD45LPvQv1V
 ms1MF+qnajf1TQk3xpz5BTikAATCVwNJTZ9+Y1zsa54sW3wPp3OAnksvOzBDEsuUtusvS52+wgxyen
 dp/nWQzMiCu0D823CItebJZbVulSjq
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Add coverage of the GCS hwcap to the hwcap selftest, using a read of
GCSPR_EL0 to generate SIGILL without having to worry about enabling GCS.

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/abi/hwcap.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/testing/selftests/arm64/abi/hwcap.c b/tools/testing/selftests/arm64/abi/hwcap.c
index d8909b2b535a..dc54ae894fe5 100644
--- a/tools/testing/selftests/arm64/abi/hwcap.c
+++ b/tools/testing/selftests/arm64/abi/hwcap.c
@@ -98,6 +98,17 @@ static void fpmr_sigill(void)
 	asm volatile("mrs x0, S3_3_C4_C4_2" : : : "x0");
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
@@ -528,6 +539,14 @@ static const struct hwcap_data {
 		.sigill_fn = fpmr_sigill,
 		.sigill_reliable = true,
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


