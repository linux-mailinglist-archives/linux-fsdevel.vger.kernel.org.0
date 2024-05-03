Return-Path: <linux-fsdevel+bounces-18633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 517E58BAD0C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 15:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 724FBB22AE5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 13:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B30A153BEE;
	Fri,  3 May 2024 13:03:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D0F153BE6
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 May 2024 13:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714741390; cv=none; b=BMWABdVfEtpmv2t+MfU0S6aar3oDmhD/RHoXU2KJmsPg4MGMDYSdGuCuTAarnlBmPrIU4BF5+W95ZwLeT25MlPW3Hpjh0f+sMo6DuZ7n5TPvBB9aOh6wACbnhgm9d3F619Ci82QPoChuaen5AUa8isIMkm4yGpojiXkU2Oi3uyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714741390; c=relaxed/simple;
	bh=QL7Z2oX9KcDRABPheq8Sil8DiHxZ/oUCj/OkPUP/MPw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AR9Sq5mYqWTCgskdNFCmBpFfhPzOHqroukeIbzkqqnfmU777KtOO7FtqRvtjQON3gntYNgjvHFa3blTR8X41Dk7Gdo2zhd6Nxb58zlEUqOPD3pVgSr7i1FD2AWzhavI2LUxrZHHL5QOwyibu2r5OYF1mE8iWtf4FFi/mF5Bov1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC8511713;
	Fri,  3 May 2024 06:03:33 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B5063F73F;
	Fri,  3 May 2024 06:03:05 -0700 (PDT)
From: Joey Gouly <joey.gouly@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: akpm@linux-foundation.org,
	aneesh.kumar@kernel.org,
	aneesh.kumar@linux.ibm.com,
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
	szabolcs.nagy@arm.com,
	tglx@linutronix.de,
	will@kernel.org,
	x86@kernel.org,
	kvmarm@lists.linux.dev
Subject: [PATCH v4 22/29] arm64: add Permission Overlay Extension Kconfig
Date: Fri,  3 May 2024 14:01:40 +0100
Message-Id: <20240503130147.1154804-23-joey.gouly@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240503130147.1154804-1-joey.gouly@arm.com>
References: <20240503130147.1154804-1-joey.gouly@arm.com>
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
---
 arch/arm64/Kconfig | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7b11c98b3e84..676ebe4bf9eb 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2095,6 +2095,28 @@ config ARM64_EPAN
 	  if the cpu does not implement the feature.
 endmenu # "ARMv8.7 architectural features"
 
+menu "ARMv8.9 architectural features"
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


