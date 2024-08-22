Return-Path: <linux-fsdevel+bounces-26751-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F9795B967
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 17:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D29431C211D6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 15:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCB81CC896;
	Thu, 22 Aug 2024 15:11:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EE41CBEA2;
	Thu, 22 Aug 2024 15:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724339490; cv=none; b=raJkmI78f3y+CekkMOedxajwTvG40oQ+GP40ESeTzECxxDk349YpYqvyUDXtVE/iXs9aRJT+i7MDV6X5CJ77Rc1guCOpJDsmqTn/mWQSEbkxc3R3ohnjD03IgFOD18TnEaFjATs5ds9ic/nT6jzXzwQgN0u6QYkzesr14PVkRWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724339490; c=relaxed/simple;
	bh=mMR77yN/5/U0+rjMRKVDIMUPno5GgLTM0SPRDjSdOhU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a3Ig5OEFSe1IW4CL1opU2DbIJq0ElVe1KzmDJvtm5q8kezvNntnQpcXBFZQmnq3o5un4Iev6Xe3p7AwfXKvcdObt4W82LPcEH+jVNcb0dTVlSdonuID1TQpAS6IbikG+oe9Lz0/oDuChP1vjCbmWRuo7dK0LZ9btBdWu93KFw3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8DFFFEC;
	Thu, 22 Aug 2024 08:11:54 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A4E13F58B;
	Thu, 22 Aug 2024 08:11:24 -0700 (PDT)
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
Subject: [PATCH v5 01/30] powerpc/mm: add ARCH_PKEY_BITS to Kconfig
Date: Thu, 22 Aug 2024 16:10:44 +0100
Message-Id: <20240822151113.1479789-2-joey.gouly@arm.com>
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

The new config option specifies how many bits are in each PKEY.

Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git arch/powerpc/Kconfig arch/powerpc/Kconfig
index d7b09b064a8a..8a4ee57cd4ef 100644
--- arch/powerpc/Kconfig
+++ arch/powerpc/Kconfig
@@ -1026,6 +1026,10 @@ config PPC_MEM_KEYS
 
 	  If unsure, say y.
 
+config ARCH_PKEY_BITS
+	int
+	default 5
+
 config PPC_SECURE_BOOT
 	prompt "Enable secure boot support"
 	bool
-- 
2.25.1


