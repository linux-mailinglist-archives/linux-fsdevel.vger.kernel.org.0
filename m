Return-Path: <linux-fsdevel+bounces-26773-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0042E95B9B0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 17:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A84E11F24AE6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 15:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9321CCEC2;
	Thu, 22 Aug 2024 15:13:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217401CC89B;
	Thu, 22 Aug 2024 15:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724339585; cv=none; b=FpdTT//kJhxKHJA4wTZ+Yoj8F9vqBME8e7ufJUVT6vBdSAEcpUTxkxfz3dDzXNCRmfqtAviUH1QgEp7BDQLO0GRCPjJd1uShn1o4YtgEc7Dq3UOOYlTxJN6TjQSyIf1ROpZQMYlUn2Dl02icXhS+OftoH8bv3UlRBPHF0XeFPSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724339585; c=relaxed/simple;
	bh=01R1Iyq6ziUFGEz2FQMkgk+bYCtZVZAHa8k1QgHsKVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VlkS04Ypa+dmqlWgSQpzgQH8OfwA+t2/Ua7U+a9LW4kEJWKRxs4vBh46yWZZtqmz3mSZU5JpvjFOswr/T65d4U7yWzDjVvu2rDRgd3012IB0gYiDj2P7xL0YCFBYhd3EcuZ4gzURGq4XwBH3HPlBrPUhkZa/jQRmO1G7xCUOMBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6BB01650;
	Thu, 22 Aug 2024 08:13:29 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B8D833F58B;
	Thu, 22 Aug 2024 08:12:59 -0700 (PDT)
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
Subject: [PATCH v5 23/30] arm64: add Permission Overlay Extension Kconfig
Date: Thu, 22 Aug 2024 16:11:06 +0100
Message-Id: <20240822151113.1479789-24-joey.gouly@arm.com>
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

Now that support for POE and Protection Keys has been implemented, add a
config to allow users to actually enable it.

Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/Kconfig | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git arch/arm64/Kconfig arch/arm64/Kconfig
index a2f8ff354ca6..35dfc6275328 100644
--- arch/arm64/Kconfig
+++ arch/arm64/Kconfig
@@ -2137,6 +2137,29 @@ config ARM64_EPAN
 	  if the cpu does not implement the feature.
 endmenu # "ARMv8.7 architectural features"
 
+menu "ARMv8.9 architectural features"
+
+config ARM64_POE
+	prompt "Permission Overlay Extension"
+	def_bool y
+	select ARCH_USES_HIGH_VMA_FLAGS
+	select ARCH_HAS_PKEYS
+	help
+	  The Permission Overlay Extension is used to implement Memory
+	  Protection Keys. Memory Protection Keys provides a mechanism for
+	  enforcing page-based protections, but without requiring modification
+	  of the page tables when an application changes protection domains.
+
+	  For details, see Documentation/core-api/protection-keys.rst
+
+	  If unsure, say y.
+
+config ARCH_PKEY_BITS
+	int
+	default 3
+
+endmenu # "ARMv8.9 architectural features"
+
 config ARM64_SVE
 	bool "ARM Scalable Vector Extension support"
 	default y
-- 
2.25.1


