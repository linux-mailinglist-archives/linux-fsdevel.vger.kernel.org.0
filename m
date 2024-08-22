Return-Path: <linux-fsdevel+bounces-26777-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F46B95B9BA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 17:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE6232870CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 15:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1821CBE89;
	Thu, 22 Aug 2024 15:13:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A1E1CC8A6;
	Thu, 22 Aug 2024 15:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724339602; cv=none; b=Oqch+8B4lToffNN+eFp8Y+mXlWJeU9pVYCq54o5QKrwpbUU5eFoK6E/7oOv8qOlzwS17Lyq2fHNe/BQ1PUXefEaW7k3XQ2JadrfCihLgeIptH3Gkwh9gWhBjoc2me/PtC+ed2F6bqPd18sQTQL3cooxlChb4RAIiWZlvCKQZ+Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724339602; c=relaxed/simple;
	bh=ZNoS+hPzOtH2iuO7pv40fuHbte5CnSjSCsgz6rR2puM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rnOqTlbZ+ALd+bK8G5FdECTm43KxwkLFxCdFmrNKJMkpOdPhyKZgGUwoHw7kpjJ2MVWAb8ClnGvVAxolXgGZlUcJtJwifNZAxnFaxWfuAtMzvZcW+6lx3OpmXvKcwwcRnkHvLAtPdTuCSCAuLpUcWKFEeM8ZaczMThr5D8wp27s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2889E1688;
	Thu, 22 Aug 2024 08:13:47 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A2683F58B;
	Thu, 22 Aug 2024 08:13:16 -0700 (PDT)
From: Joey Gouly <joey.gouly@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: nd@arm.com,
	akpm@linux-foundation.org,
	aneesh.kumar@kernel.org,
	aneesh.kumar@linux.ibm.com,
	anshuman.khandual@arm.com,
	bp@alien8.de,
	broonie@kernel.org,
	catalin.marinas@arm.com,
	christophe.leroy@csgroup.eu,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	joey.gouly@arm.com,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	maz@kernel.org,
	mingo@redhat.com,
	mpe@ellerman.id.au,
	naveen.n.rao@linux.ibm.com,
	npiggin@gmail.com,
	oliver.upton@linux.dev,
	shuah@kernel.org,
	skhan@linuxfoundation.org,
	szabolcs.nagy@arm.com,
	tglx@linutronix.de,
	will@kernel.org,
	x86@kernel.org,
	kvmarm@lists.linux.dev,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v5 27/30] kselftest/arm64: add HWCAP test for FEAT_S1POE
Date: Thu, 22 Aug 2024 16:11:10 +0100
Message-Id: <20240822151113.1479789-28-joey.gouly@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240822151113.1479789-1-joey.gouly@arm.com>
References: <20240822151113.1479789-1-joey.gouly@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check that when POE is enabled, the POR_EL0 register is accessible.

Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Reviewed-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/abi/hwcap.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git tools/testing/selftests/arm64/abi/hwcap.c tools/testing/selftests/arm64/abi/hwcap.c
index d8909b2b535a..f2d6007a2b98 100644
--- tools/testing/selftests/arm64/abi/hwcap.c
+++ tools/testing/selftests/arm64/abi/hwcap.c
@@ -156,6 +156,12 @@ static void pmull_sigill(void)
 	asm volatile(".inst 0x0ee0e000" : : : );
 }
 
+static void poe_sigill(void)
+{
+	/* mrs x0, POR_EL0 */
+	asm volatile("mrs x0, S3_3_C10_C2_4" : : : "x0");
+}
+
 static void rng_sigill(void)
 {
 	asm volatile("mrs x0, S3_3_C2_C4_0" : : : "x0");
@@ -601,6 +607,14 @@ static const struct hwcap_data {
 		.cpuinfo = "pmull",
 		.sigill_fn = pmull_sigill,
 	},
+	{
+		.name = "POE",
+		.at_hwcap = AT_HWCAP2,
+		.hwcap_bit = HWCAP2_POE,
+		.cpuinfo = "poe",
+		.sigill_fn = poe_sigill,
+		.sigill_reliable = true,
+	},
 	{
 		.name = "RNG",
 		.at_hwcap = AT_HWCAP2,
-- 
2.25.1


