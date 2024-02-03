Return-Path: <linux-fsdevel+bounces-10172-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1667E848605
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 13:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEC8FB241D2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 12:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FBA77F16;
	Sat,  3 Feb 2024 12:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rq54rGZn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952F777F0E;
	Sat,  3 Feb 2024 12:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706963563; cv=none; b=O0fv9IUaeUY/9aRbbyslkxf7RKh5fk3wc0TzLPY8/Wyjo12BBq1TQrKPIWhXZZg2RQ8KPZGOE2E+hmGdRr3ZcByBLWyyB7t8mW1REsnMM5sWQf0vG5Cd8WKS9x1fOF/cC01xbj19FAz6MNcCNhvex2wesC3T0EwJ3KrIHU8oeBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706963563; c=relaxed/simple;
	bh=12GEB0Pk7RCg7IDCHng3d3qOxpvs8kdDfOLg/QCQKjw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gdXmT9jQZAc9NC/V+35wPS/dkrsrLCrvcqcyhGnwcmP1ZuV71jWqtf0FR0W6+rGqAvSnxuq8JPxLwkVBWxP5yDisH8B2AcYufgFExUBrbo7upEa+++gTy2V89ODrrmYIC8u4OPshbTzOLipDprJVRX0rPy4Ks8mQg68MGr6vwGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rq54rGZn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32B8AC43394;
	Sat,  3 Feb 2024 12:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706963563;
	bh=12GEB0Pk7RCg7IDCHng3d3qOxpvs8kdDfOLg/QCQKjw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rq54rGZnx24MR+LUh3nV3e8oP26hH94Ibu9LOex/80fqVy+e02EBu6dqOsyofq/dn
	 9S3U4uPifeLeILbteJBG/QpWUnZBy2WOLOp+KlMEeRcHL0qaYHcKVtv9q0S3QhIcwI
	 9E7PODu5zTqrPfUy5t4C+wZy0qNXoit/OCYzm0NAdwWQydU1XQwNFUeDX0MRP167T0
	 Y7Iu3LtDUIXNO0qtNGG0Y7WCih15IbGNQYHJdK+QTL7cGBX7U9Fzf95CLwlV6+DWis
	 KDpX4Lz0jfsNLClK5EnD1j4F6fJ0rXsFQXAp3XGWDvODVXmAyfNf+vI79g1HZOXsYV
	 THWaW5vGRn1IA==
From: Mark Brown <broonie@kernel.org>
Date: Sat, 03 Feb 2024 12:25:53 +0000
Subject: [PATCH v8 27/38] kselftest/arm64: Verify the GCS hwcap
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-arm64-gcs-v8-27-c9fec77673ef@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1190; i=broonie@kernel.org;
 h=from:subject:message-id; bh=12GEB0Pk7RCg7IDCHng3d3qOxpvs8kdDfOLg/QCQKjw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlvjDmTw5/9VutAafQEgaHl/AQF1z3bFN2KzUpHqGY
 L4zrDKaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZb4w5gAKCRAk1otyXVSH0H76B/
 0ZxrYYCMIsi8MRn7I+3H6jNZKAVNmw8SJNvqoTY/zYbJNmq4MKh3rt6x1O2gevx9hobz/cn88DE1f9
 pdIhoGTFgFsgL5+npQ6sINjikcDLWkpQZ9IKvFtQ8i0A7p1Ts6+F8ouQ/YWF5fiwDCcaglMB5SDDS0
 UKDKMWST/vMh8R/NHIjFIZ/yqpAFZrbPxntxjgSGwoIONgk0N959zfmcfkPghY9+a5troDlRxfBQyg
 M1y/zi2IbuTvIkrM9tWMmAh0rM4cC3npQ8FUa7WcMl9u2iNHczDLo6UvLO8idOYZStNtaGst5U6Izi
 tbHk2hUyigCouolu0//aNQ/XwlU1i1
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
2.30.2


