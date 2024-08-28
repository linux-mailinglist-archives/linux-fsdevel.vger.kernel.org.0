Return-Path: <linux-fsdevel+bounces-27691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AE99635FB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 01:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D26A1F2590A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 23:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904D71AED32;
	Wed, 28 Aug 2024 23:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjwu1NOI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C0F1AED28;
	Wed, 28 Aug 2024 23:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724887919; cv=none; b=oZnvawHxzEytPnfhZFvW5+yaVxVY8r8fjj0oqA7iVGXxVRDtY3c3FiScu4GDl8QkkUh/uQBA75kL2tge+hKnIc9bMsYt4XoEmKhWVSAWiKYKGHD5aYYdFnk0Gau8SBQ689K5ZYQqmx1bUVjmq5jmRQeBTQ2Tyk80353W9cChJ8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724887919; c=relaxed/simple;
	bh=aFW2qvTAUk71Nq29FR7iqobh+ecvMgae9gmrzv39Zig=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q0dHLLCZMf/6VN96b0CNsaDjCQhINV3bzi55yq13xCGxJJvQ1+/QeXHOgaZpPEfUwKLjNqSCJyN2O4YagPOntQR9u6LSXpICnHLsvApiLA/fmABMqDP5IeM1xcZVZWJJIFFNGFrv7DfUXcKHYFUcg+tiFQBMDVA2oX7abpxGqUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjwu1NOI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B375C4CEC7;
	Wed, 28 Aug 2024 23:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724887918;
	bh=aFW2qvTAUk71Nq29FR7iqobh+ecvMgae9gmrzv39Zig=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hjwu1NOIEmtm8Z7u72gZ6JHpkwB5gkUJwalodRKF8NUXnKJGIEb0zJUYn0XqEtVsK
	 6eir07YTJAN930R0rS8oXPsf6PMfQ9EfkaAWQ1dRKOa5wXBUnNDnZaVRhFcZay/PDH
	 o/emvel+ObwFHeJv5S51ipjvW8LPa1xdsI+eywNUXvOC5+9MncYTnDzs8Uteg4EfVc
	 yuQM05fKSpjDRx9hshHQz8ztRMRG76+LOxIH3PymqWyy4gwdHZESoB/tcfmV/26lB+
	 qTA10jQeMNmWKfhwrB7LyxLXvrqayRjUqWp7rT//nr67E8BdqSESxF6eyGyVLa88li
	 voHyn7VgIlVTQ==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 29 Aug 2024 00:27:44 +0100
Subject: [PATCH v12 28/39] kselftest/arm64: Verify the GCS hwcap
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-arm64-gcs-v12-28-42fec947436a@kernel.org>
References: <20240829-arm64-gcs-v12-0-42fec947436a@kernel.org>
In-Reply-To: <20240829-arm64-gcs-v12-0-42fec947436a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1352; i=broonie@kernel.org;
 h=from:subject:message-id; bh=aFW2qvTAUk71Nq29FR7iqobh+ecvMgae9gmrzv39Zig=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmz7KOSj/YT5ssZcKeVNxIRh75CfX+1/LJGwnNPsEb
 KfxmaQmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZs+yjgAKCRAk1otyXVSH0AjAB/
 9IIDCOoIAD9cFmgd31fBocKw1sDdzChCEINlCN4R0b5mrluwuKvPLbgBxP96AyAIXdOfycNgOfzLkX
 sEBtTYbGIRb/4+k5PT5XV+8RvrJUQOYR/upipwFuP5naV3G16qy+an11n090xuLfuaBy8W/ImD5z82
 ZIIS8iof/mQ8HEOGmIyMAz+DDNpZbIl40V+PgO8ZXNOHJjj6kCUomP4kQhbcfb/AvtUtOuo5tBYbxs
 4Wr4Lb7KhW/WNKTnUD3EBFmzIQj/TGOJTSMEw0BUVChYxdHRy+U0lpcFUxuRK30pAxHy3X06v1Pnm/
 Gmna9QTiGgP9kprUoXL7dL1XvDBs1s
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Add coverage of the GCS hwcap to the hwcap selftest, using a read of
GCSPR_EL0 to generate SIGILL without having to worry about enabling GCS.

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Tested-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
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


