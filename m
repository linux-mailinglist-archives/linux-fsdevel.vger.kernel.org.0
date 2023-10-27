Return-Path: <linux-fsdevel+bounces-1398-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B38917D9F80
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 20:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E4E7282603
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 18:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49333C08D;
	Fri, 27 Oct 2023 18:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263193B794
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 18:09:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id D0FC1F3;
	Fri, 27 Oct 2023 11:09:28 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 388EB143D;
	Fri, 27 Oct 2023 11:10:10 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B4F33F64C;
	Fri, 27 Oct 2023 11:09:26 -0700 (PDT)
From: Joey Gouly <joey.gouly@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: akpm@linux-foundation.org,
	aneesh.kumar@linux.ibm.com,
	broonie@kernel.org,
	catalin.marinas@arm.com,
	dave.hansen@linux.intel.com,
	joey.gouly@arm.com,
	maz@kernel.org,
	oliver.upton@linux.dev,
	shuah@kernel.org,
	will@kernel.org,
	kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v2 10/24] arm64: mask out POIndex when modifying a PTE
Date: Fri, 27 Oct 2023 19:08:36 +0100
Message-Id: <20231027180850.1068089-11-joey.gouly@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231027180850.1068089-1-joey.gouly@arm.com>
References: <20231027180850.1068089-1-joey.gouly@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a PTE is modified, the POIndex must be masked off so that it can be modified.

Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/pgtable.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 7f7d9b1df4e5..6c57ebe8e349 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -820,7 +820,8 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 	 */
 	const pteval_t mask = PTE_USER | PTE_PXN | PTE_UXN | PTE_RDONLY |
 			      PTE_PROT_NONE | PTE_VALID | PTE_WRITE | PTE_GP |
-			      PTE_ATTRINDX_MASK;
+			      PTE_ATTRINDX_MASK | PTE_PO_IDX_MASK;
+
 	/* preserve the hardware dirty information */
 	if (pte_hw_dirty(pte))
 		pte = set_pte_bit(pte, __pgprot(PTE_DIRTY));
-- 
2.25.1


