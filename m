Return-Path: <linux-fsdevel+bounces-10277-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C017F849990
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 13:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D25328189A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 12:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D1B1C69F;
	Mon,  5 Feb 2024 12:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="JSkDIGyr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC28D1C686;
	Mon,  5 Feb 2024 12:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707134638; cv=none; b=qYAVKrOnyIG7xicsCDxV3ckmQfZ1w/Uor2B2GKDMINbzXDCNgZIhk1KdmJI1SecoWgF3p0gHg3Q8yCLID+RSmD9DkwbEruq75np1yEcmA0anutU0DU1jgQXaQk0aQ0wCJ+450tiREjp3jMwgoEme77PH3EnDAD4DE69PlIfBFX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707134638; c=relaxed/simple;
	bh=HphmXgXmCKa5mqdnPL9wBxqcBYTxkbzFB0ny6/qkCB4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HZdlIRaBysRkb9SkBJxIXoeqsdwmtPqTHHEREieG2RT6z/jlGM+AknRvsEXMkUDW/hOPGsk2pU64TbJExN4wfmSSpI33qnLtfvZlqNuCe4Xm0On/FIR6SmC14l3FQ6roh1RIp5W8E419GPYkaaUgb9CUOLPS5Y5ngpFsyO4pR4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=JSkDIGyr; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1707134637; x=1738670637;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iY0J0IZ5qTqLG1CI5oIteOfffrC6hlfw7IE0MCx8M3k=;
  b=JSkDIGyrOfNkdmuDUcA1wlHoiTEd4BH8dtO97qK0NJ2Pte20i/a0OOCm
   C0j4dmJ+xT+dqfxYjkzyAaHx0JvaB1O29vk4fcn3dFp+/HSh1BHdFnrJJ
   7nrvM4D8CHbVq1DsiDeLNIbnc82oZ+jmY+bgefcK6RMaqaeUsJlwrjaNP
   Y=;
X-IronPort-AV: E=Sophos;i="6.05,245,1701129600"; 
   d="scan'208";a="63724432"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 12:03:55 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.10.100:51867]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.28.192:2525] with esmtp (Farcaster)
 id 0b48539d-2334-4d72-bccb-1f938dcbdb04; Mon, 5 Feb 2024 12:03:53 +0000 (UTC)
X-Farcaster-Flow-ID: 0b48539d-2334-4d72-bccb-1f938dcbdb04
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 5 Feb 2024 12:03:53 +0000
Received: from dev-dsk-jgowans-1a-a3faec1f.eu-west-1.amazon.com
 (172.19.112.191) by EX19D014EUC004.ant.amazon.com (10.252.51.182) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 5 Feb
 2024 12:03:46 +0000
From: James Gowans <jgowans@amazon.com>
To: <linux-kernel@vger.kernel.org>
CC: Eric Biederman <ebiederm@xmission.com>, <kexec@lists.infradead.org>,
	"Joerg Roedel" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	<iommu@lists.linux.dev>, Alexander Viro <viro@zeniv.linux.org.uk>, "Christian
 Brauner" <brauner@kernel.org>, <linux-fsdevel@vger.kernel.org>, Paolo Bonzini
	<pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>,
	<kvm@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	<linux-mm@kvack.org>, Alexander Graf <graf@amazon.com>, David Woodhouse
	<dwmw@amazon.co.uk>, "Jan H . Schoenherr" <jschoenh@amazon.de>, Usama Arif
	<usama.arif@bytedance.com>, Anthony Yznaga <anthony.yznaga@oracle.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	<madvenka@linux.microsoft.com>, <steven.sistare@oracle.com>,
	<yuleixzhang@tencent.com>
Subject: [RFC 08/18] iommu: Add allocator for pgtables from persistent region
Date: Mon, 5 Feb 2024 12:01:53 +0000
Message-ID: <20240205120203.60312-9-jgowans@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240205120203.60312-1-jgowans@amazon.com>
References: <20240205120203.60312-1-jgowans@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC001.ant.amazon.com (10.13.139.218) To
 EX19D014EUC004.ant.amazon.com (10.252.51.182)

The specific IOMMU drivers will need to ability to allocate pages from a
pkernfs IOMMU pgtable file for their pgtables. Also, the IOMMU drivers
will need to ability to consistent get the same page for the root PGD
page - add a specific function to get this PGD "root" page. This is
different to allocating regular pgtable pages because the exact same
page needs to be *restored* after kexec into the pgd pointer on the
IOMMU domain struct.

To support this sort of allocation the pkernfs region is treated as an
array of 512 4 KiB pages, the first of which is an allocation bitmap.
---
 drivers/iommu/Makefile        |  1 +
 drivers/iommu/pgtable_alloc.c | 36 +++++++++++++++++++++++++++++++++++
 drivers/iommu/pgtable_alloc.h |  9 +++++++++
 3 files changed, 46 insertions(+)
 create mode 100644 drivers/iommu/pgtable_alloc.c
 create mode 100644 drivers/iommu/pgtable_alloc.h

diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 769e43d780ce..cadebabe9581 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-y += amd/ intel/ arm/ iommufd/
+obj-y += pgtable_alloc.o
 obj-$(CONFIG_IOMMU_API) += iommu.o
 obj-$(CONFIG_IOMMU_API) += iommu-traces.o
 obj-$(CONFIG_IOMMU_API) += iommu-sysfs.o
diff --git a/drivers/iommu/pgtable_alloc.c b/drivers/iommu/pgtable_alloc.c
new file mode 100644
index 000000000000..f0c2e12f8a8b
--- /dev/null
+++ b/drivers/iommu/pgtable_alloc.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "pgtable_alloc.h"
+#include <linux/mm.h>
+
+/*
+ * The first 4 KiB is the bitmap - set the first bit in the bitmap.
+ * Scan bitmap to find next free bits - it's next free page.
+ */
+
+void iommu_alloc_page_from_region(struct pkernfs_region *region, void **vaddr, unsigned long *paddr)
+{
+	int page_idx;
+
+	page_idx = bitmap_find_free_region(region->vaddr, 512, 0);
+	*vaddr = region->vaddr + (page_idx << PAGE_SHIFT);
+	if (paddr)
+		*paddr = region->paddr + (page_idx << PAGE_SHIFT);
+}
+
+
+void *pgtable_get_root_page(struct pkernfs_region *region, bool liveupdate)
+{
+	/*
+	 * The page immediately after the bitmap is the root page.
+	 * It would be wrong for the page to be allocated if we're
+	 * NOT doing a liveupdate, or for a liveupdate to happen
+	 * with no allocated page. Detect this mismatch.
+	 */
+	if (test_bit(1, region->vaddr) ^ liveupdate) {
+		pr_err("%sdoing a liveupdate but root pg bit incorrect",
+				liveupdate ? "" : "NOT ");
+	}
+	set_bit(1, region->vaddr);
+	return region->vaddr + PAGE_SIZE;
+}
diff --git a/drivers/iommu/pgtable_alloc.h b/drivers/iommu/pgtable_alloc.h
new file mode 100644
index 000000000000..c1666a7be3d3
--- /dev/null
+++ b/drivers/iommu/pgtable_alloc.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#include <linux/types.h>
+#include <linux/pkernfs.h>
+
+void iommu_alloc_page_from_region(struct pkernfs_region *region,
+				  void **vaddr, unsigned long *paddr);
+
+void *pgtable_get_root_page(struct pkernfs_region *region, bool liveupdate);
-- 
2.40.1


