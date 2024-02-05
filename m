Return-Path: <linux-fsdevel+bounces-10285-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8547C8499AD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 13:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DA901F274F2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 12:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28141B94F;
	Mon,  5 Feb 2024 12:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="i/klmtUX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1691B943;
	Mon,  5 Feb 2024 12:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707134759; cv=none; b=s81H1sAf3ew6o8YKADNQuYTm96YJ0bVI1brNyCqgigp/GtwmnYhTCAIMywGgWVW9ziSdxQhr6jVh56zuYEqyJOm6/5XT+wR70eo+JQ1JLuYTQAGsy1UrtMeNoZ+9Idy/zf0ZAGAqg40ckFLCWnVCmUSPXihlWEVYEKvK3TWF4/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707134759; c=relaxed/simple;
	bh=GKb17qTpfFtGwafuxlfpZaDYOiFuRf0lqbATSZhVa5M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VrKKmf3sgMGcE9hox37DOgifvWdwgb8fS5p5Ix71RaXvdu923oa5WXAu+CGE7OBa8LdCyX7UkTESOFLqmllOLVty2yTY0oxDIIrt60VDLiv/ZjDnIBozpSYDUamnnpcerbRZqlzT3W71ywGX5O70Eydx7KZ5nPiFQ6Y0xmA6mLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=i/klmtUX; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1707134757; x=1738670757;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2AUEdbvoftHMg2AkT8RS6u9G56Zx/z0Bmygk8dweA74=;
  b=i/klmtUXhQUrqDvb4qCuzopKWT/ra9S74iPzNL3XvyoyCKcwmf1zgN4T
   miLXyPqCx6UXRj23ocW5tiM35DErXD+aCBEoRp0jMNNqmiSaBol5bQGif
   ZC2YCfK6Dd3qeJdvGBv3PJgo97QbI+tWtNJLMnAJnqpGex+192NyLyvIn
   c=;
X-IronPort-AV: E=Sophos;i="6.05,245,1701129600"; 
   d="scan'208";a="63755948"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 12:05:57 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.17.79:13316]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.45.85:2525] with esmtp (Farcaster)
 id 596cc4dd-1066-4e32-b40f-00d6ab21896d; Mon, 5 Feb 2024 12:05:56 +0000 (UTC)
X-Farcaster-Flow-ID: 596cc4dd-1066-4e32-b40f-00d6ab21896d
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 5 Feb 2024 12:05:56 +0000
Received: from dev-dsk-jgowans-1a-a3faec1f.eu-west-1.amazon.com
 (172.19.112.191) by EX19D014EUC004.ant.amazon.com (10.252.51.182) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 5 Feb
 2024 12:05:49 +0000
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
Subject: [RFC 16/18] vfio: support not mapping IOMMU pgtables on live-update
Date: Mon, 5 Feb 2024 12:02:01 +0000
Message-ID: <20240205120203.60312-17-jgowans@amazon.com>
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

When restoring VMs after live update kexec, the IOVAs for the guest VM
are already present in the persisted page tables. It is unnecessary to
clobber the existing pgtable entries and it may introduce races if
pgtable modifications happen concurrently with DMA.

Provide a new VFIO MAP_DMA flag which userspace can supply to inform
VFIO that the IOVAs are already mapped. In this case VFIO will skip over
the call to the IOMMU driver to do the mapping. VFIO still needs the
MAP_DMA ioctl to set up its internal data structures about the mapping.

It would probably be better to move the persistence one layer up and
persist the VFIO container in pkernfs. That way the whole container
could be picked up and re-used without needing to do any MAP_DMA ioctls
after kexec.
---
 drivers/vfio/vfio_iommu_type1.c | 24 +++++++++++++-----------
 include/uapi/linux/vfio.h       |  1 +
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index b36edfc5c9ef..dc2682fbda2e 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -1456,7 +1456,7 @@ static int vfio_iommu_map(struct vfio_iommu *iommu, dma_addr_t iova,
 }
 
 static int vfio_pin_map_dma(struct vfio_iommu *iommu, struct vfio_dma *dma,
-			    size_t map_size)
+			    size_t map_size, unsigned int flags)
 {
 	dma_addr_t iova = dma->iova;
 	unsigned long vaddr = dma->vaddr;
@@ -1479,14 +1479,16 @@ static int vfio_pin_map_dma(struct vfio_iommu *iommu, struct vfio_dma *dma,
 			break;
 		}
 
-		/* Map it! */
-		ret = vfio_iommu_map(iommu, iova + dma->size, pfn, npage,
-				     dma->prot);
-		if (ret) {
-			vfio_unpin_pages_remote(dma, iova + dma->size, pfn,
-						npage, true);
-			vfio_batch_unpin(&batch, dma);
-			break;
+		if (!(flags & VFIO_DMA_MAP_FLAG_LIVE_UPDATE)) {
+			/* Map it! */
+			ret = vfio_iommu_map(iommu, iova + dma->size, pfn, npage,
+					     dma->prot);
+			if (ret) {
+				vfio_unpin_pages_remote(dma, iova + dma->size, pfn,
+							npage, true);
+				vfio_batch_unpin(&batch, dma);
+				break;
+			}
 		}
 
 		size -= npage << PAGE_SHIFT;
@@ -1662,7 +1664,7 @@ static int vfio_dma_do_map(struct vfio_iommu *iommu,
 	if (list_empty(&iommu->domain_list))
 		dma->size = size;
 	else
-		ret = vfio_pin_map_dma(iommu, dma, size);
+		ret = vfio_pin_map_dma(iommu, dma, size, map->flags);
 
 	if (!ret && iommu->dirty_page_tracking) {
 		ret = vfio_dma_bitmap_alloc(dma, pgsize);
@@ -2836,7 +2838,7 @@ static int vfio_iommu_type1_map_dma(struct vfio_iommu *iommu,
 	struct vfio_iommu_type1_dma_map map;
 	unsigned long minsz;
 	uint32_t mask = VFIO_DMA_MAP_FLAG_READ | VFIO_DMA_MAP_FLAG_WRITE |
-			VFIO_DMA_MAP_FLAG_VADDR;
+			VFIO_DMA_MAP_FLAG_VADDR | VFIO_DMA_MAP_FLAG_LIVE_UPDATE;
 
 	minsz = offsetofend(struct vfio_iommu_type1_dma_map, size);
 
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index fa9676bb4b26..d04d28e52110 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1536,6 +1536,7 @@ struct vfio_iommu_type1_dma_map {
 #define VFIO_DMA_MAP_FLAG_READ (1 << 0)		/* readable from device */
 #define VFIO_DMA_MAP_FLAG_WRITE (1 << 1)	/* writable from device */
 #define VFIO_DMA_MAP_FLAG_VADDR (1 << 2)
+#define VFIO_DMA_MAP_FLAG_LIVE_UPDATE  (1 << 3) /* IOVAs already mapped in IOMMU before LU */
 	__u64	vaddr;				/* Process virtual address */
 	__u64	iova;				/* IO virtual address */
 	__u64	size;				/* Size of mapping (bytes) */
-- 
2.40.1


