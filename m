Return-Path: <linux-fsdevel+bounces-10742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C878484DBDF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 09:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F39371C21E6D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 08:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0C96BB39;
	Thu,  8 Feb 2024 08:48:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B03535DC;
	Thu,  8 Feb 2024 08:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707382096; cv=none; b=TkhG1FNAScBVz1u8Fku4phIJ4141RgWDDzfEPykNSrUAoSAdMgmMfnryh8LQN9gdBDCtI6DSTKTdLH8Xu4YlDHmwyFQI1QvPG2aQP0UVwhPxmRZ9He2a1tLXYC1GhmO7pf3+l3Bc1FgvnxusQuSlVKisO9xCwYF2ZkyaeX3rxcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707382096; c=relaxed/simple;
	bh=6KDIdGnLvGPYx6pxiwel3ZAd2B57/3ZoEDOIO6r0yZk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aQl3cv4PuJvKvMmF+snGP3kYMzNN8QEeM2A7NBSRgl0tgR8D+vEFyw8e1F+9dzX/IkWi0IDKagsf/BSUOKmpR+e/FfODK/WDfoVvbag64B6755l9O0bLeAdl1fCDZU8X63RsXZYiP1bX0LCTRvUchcas1OWfMDqf52xSAzUI8c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 624F51FB;
	Thu,  8 Feb 2024 00:48:54 -0800 (PST)
Received: from a077893.arm.com (unknown [10.163.44.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id ECCCB3F762;
	Thu,  8 Feb 2024 00:48:09 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs/proc/task_mmu: Add display flag for VM_MAYOVERLAY
Date: Thu,  8 Feb 2024 14:18:05 +0530
Message-Id: <20240208084805.1252337-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VM_UFFD_MISSING flag is mutually exclussive with VM_MAYOVERLAY flag as they
both use the same bit position i.e 0x00000200 in the vm_flags. Let's update
show_smap_vma_flags() to display the correct flags depending on CONFIG_MMU.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v6.8-rc3

 fs/proc/task_mmu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 3f78ebbb795f..1c4eb25cfc17 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -681,7 +681,11 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 		[ilog2(VM_HUGEPAGE)]	= "hg",
 		[ilog2(VM_NOHUGEPAGE)]	= "nh",
 		[ilog2(VM_MERGEABLE)]	= "mg",
+#ifdef CONFIG_MMU
 		[ilog2(VM_UFFD_MISSING)]= "um",
+#else
+		[ilog2(VM_MAYOVERLAY)]	= "ov",
+#endif /* CONFIG_MMU */
 		[ilog2(VM_UFFD_WP)]	= "uw",
 #ifdef CONFIG_ARM64_MTE
 		[ilog2(VM_MTE)]		= "mt",
-- 
2.25.1


