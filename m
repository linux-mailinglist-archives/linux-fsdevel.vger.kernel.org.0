Return-Path: <linux-fsdevel+bounces-10288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCAB8499B8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 13:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8A672822C8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 12:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F61208CF;
	Mon,  5 Feb 2024 12:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="tPu64pUv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E369200C3;
	Mon,  5 Feb 2024 12:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707134767; cv=none; b=jr+433HzYYAtjj+BxAl+SVaMSqVuXS9x6saff/uj1A8eGyY6Fw8DvRuYxJjigUInFdoDQ+gl/TDMnaelpwYCwBgtxpOEn2+1euExWWX+SFTe28mnq+9scTGnErgETxTNyczCMin4BBySZRqpaBK3ISD7bVKGO2c94u7XIk3fGa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707134767; c=relaxed/simple;
	bh=wiv5U2uS8hUNGvTNLpJMav4y5mpoMA0A7e/DcQgUB54=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cItoH1kD6BBUG1ze24SXY7eIs18Ol8VIwjTLBPQD6tCuyUwNL4uJlvsCupedWL7J/93A0kEMU042wJbnGC4qb/D9yU4ehwM4z/RxCrlefUT7f0PT487XQRsHYMjLDQIjI3qhvCv8/7YPNbtXaHLn+jwdZZ3BWzaFi4NZsIRlElc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=tPu64pUv; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1707134766; x=1738670766;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nHBURAsv2kVj18uGoBS/ynF5eAKuZbHIuIE7fti0DT8=;
  b=tPu64pUvAr6GnsEJ2eZJyq16WF88nHXybjAkbNmSFVN6DizbghynKDZN
   VMYgd63kckia0/Kh+s2KMXDnCkauoyNrhzbwajn+MWNP0ZFgLFFKsJ3fv
   tODXa+LUMh4p3y8a2ACA2lLkRz1SBH6fWIl1iSwR08WAmOWQ2Qkpzd9a9
   4=;
X-IronPort-AV: E=Sophos;i="6.05,245,1701129600"; 
   d="scan'208";a="635764854"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 12:06:02 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.43.254:50504]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.28.192:2525] with esmtp (Farcaster)
 id a892883c-e384-427e-8387-b1c5e5820895; Mon, 5 Feb 2024 12:05:50 +0000 (UTC)
X-Farcaster-Flow-ID: a892883c-e384-427e-8387-b1c5e5820895
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 5 Feb 2024 12:05:49 +0000
Received: from dev-dsk-jgowans-1a-a3faec1f.eu-west-1.amazon.com
 (172.19.112.191) by EX19D014EUC004.ant.amazon.com (10.252.51.182) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 5 Feb
 2024 12:05:43 +0000
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
Subject: [RFC 15/18] pkernfs: register device memory for IOMMU domain pgtables
Date: Mon, 5 Feb 2024 12:02:00 +0000
Message-ID: <20240205120203.60312-16-jgowans@amazon.com>
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
X-ClientProxiedBy: EX19D042UWB002.ant.amazon.com (10.13.139.175) To
 EX19D014EUC004.ant.amazon.com (10.252.51.182)

Similarly to the root/context pgtables, the IOMMU driver also does
phys_to_virt when walking the domain pgtables. To make this work
properly the physical memory needs to be mapped in at the correct place
in the direct map. Register a memory device to support this.

The alternative would be to wrap all of the phys_to_virt functions in
something which is pkernfs aware.
---
 fs/pkernfs/iommu.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/pkernfs/iommu.c b/fs/pkernfs/iommu.c
index 5d0b256e7dd8..073b9dd48237 100644
--- a/fs/pkernfs/iommu.c
+++ b/fs/pkernfs/iommu.c
@@ -9,6 +9,7 @@ void pkernfs_get_region_for_ppts(struct file *ppts, struct pkernfs_region *pkern
 	struct pkernfs_inode *pkernfs_inode;
 	unsigned long *mappings_block_vaddr;
 	unsigned long inode_idx;
+	int rc;
 
 	/*
 	 * For a pkernfs region block, the "mappings_block" field is still
@@ -22,7 +23,20 @@ void pkernfs_get_region_for_ppts(struct file *ppts, struct pkernfs_region *pkern
 	mappings_block_vaddr = (unsigned long *)pkernfs_addr_for_block(NULL,
 			pkernfs_inode->mappings_block);
 	set_bit(0, mappings_block_vaddr);
-	pkernfs_region->vaddr = mappings_block_vaddr;
+
+	dev_set_name(&pkernfs_region->dev, "vfio-ppt-%s", pkernfs_inode->filename);
+	rc = device_register(&pkernfs_region->dev);
+	if (rc)
+		pr_err("device_register failed: %i\n", rc);
+
+	pkernfs_region->pgmap.range.start = pkernfs_base +
+		(pkernfs_inode->mappings_block * PMD_SIZE);
+	pkernfs_region->pgmap.range.end =
+		pkernfs_region->pgmap.range.start + PMD_SIZE - 1;
+	pkernfs_region->pgmap.nr_range = 1;
+	pkernfs_region->pgmap.type = MEMORY_DEVICE_GENERIC;
+	pkernfs_region->vaddr =
+		devm_memremap_pages(&pkernfs_region->dev, &pkernfs_region->pgmap);
 	pkernfs_region->paddr = pkernfs_base + (pkernfs_inode->mappings_block * (2 << 20));
 }
 void pkernfs_alloc_iommu_root_pgtables(struct pkernfs_region *pkernfs_region)
-- 
2.40.1


