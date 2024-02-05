Return-Path: <linux-fsdevel+bounces-10280-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 669FE84999D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 13:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14DE6281E51
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 12:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86BA1CD08;
	Mon,  5 Feb 2024 12:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ZpHiYYS7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0841B5AA;
	Mon,  5 Feb 2024 12:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707134677; cv=none; b=YSzcTq8d/8Om7LYg9kQFFgPXbkweq5YueINlGL8+g6A/ig5+YUz+cvBBrSNq/eDlnEqaszCL5s/0E3yUs/q/Ut83H0cz3iIAA5QN0PwjkBUpacOcB2ru+KRliuugsXu68Oo4IXzmqENYMCeNzO8jDLOGKsLPF9FmlEgvr0+RAxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707134677; c=relaxed/simple;
	bh=pZgiiTAlLapO69RdGzjL9bPIQ+8hoYW8Z/jLkX/PZWw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uv7FPGFSDLgtlsiqMTPG2ubsYin/qTuXBX69pYpwqgy17tEY9TbklgH60CzFtyM3gXjfHBp2ftSoadRIfgL6rW2o8mnkg/q9sHQ8s/jbePy9w6uF2vN7gHeXjtHu8xW7PRn2gjVLhthXWne04rSb6Q6epp4udKbC5Yz7/M9Z95I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ZpHiYYS7; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1707134676; x=1738670676;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R61AUSOacFWGGPMbVgCPWnIrJ1KmkLbm3r8EEWKzIHg=;
  b=ZpHiYYS7bX7Ee49iWVwgn6tXTcpzrQg/OJnRaSUU+v0EuUDGFcIda7LO
   mY2xzJKofyFUzM1DcCoHChqTwj4RQkUcyhJHjPRSfxKtVcqRRmNS7Y+ay
   ACpFwNad/ZcuF1gsLqjjysVMrpa1wm5F71PkDijz43Vm0nZt15Jgnizj+
   g=;
X-IronPort-AV: E=Sophos;i="6.05,245,1701129600"; 
   d="scan'208";a="182633292"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 12:04:31 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.43.254:29990]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.14.129:2525] with esmtp (Farcaster)
 id 479437ca-efef-4c96-b04c-24208e90e4af; Mon, 5 Feb 2024 12:04:30 +0000 (UTC)
X-Farcaster-Flow-ID: 479437ca-efef-4c96-b04c-24208e90e4af
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 5 Feb 2024 12:04:29 +0000
Received: from dev-dsk-jgowans-1a-a3faec1f.eu-west-1.amazon.com
 (172.19.112.191) by EX19D014EUC004.ant.amazon.com (10.252.51.182) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 5 Feb
 2024 12:04:23 +0000
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
Subject: [RFC 10/18] iommu/intel: zap context table entries on kexec
Date: Mon, 5 Feb 2024 12:01:55 +0000
Message-ID: <20240205120203.60312-11-jgowans@amazon.com>
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
X-ClientProxiedBy: EX19D041UWA001.ant.amazon.com (10.13.139.124) To
 EX19D014EUC004.ant.amazon.com (10.252.51.182)

In the next commit the IOMMU shutdown function will be modified to not
actually shut down the IOMMU when doing a kexec. To prevent leaving DMA
mappings for non-persistent devices around during kexec we add a
function to the kexec flow which iterates though all IOMMU domains and
zaps the context entries for the devices belonging to those domain.

A list of domains for the IOMMU is added and maintained.
---
 drivers/iommu/intel/dmar.c  |  1 +
 drivers/iommu/intel/iommu.c | 34 ++++++++++++++++++++++++++++++----
 drivers/iommu/intel/iommu.h |  2 ++
 3 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 23cb80d62a9a..00f69f40a4ac 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1097,6 +1097,7 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
 	iommu->segment = drhd->segment;
 
 	iommu->node = NUMA_NO_NODE;
+	INIT_LIST_HEAD(&iommu->domains);
 
 	ver = readl(iommu->reg + DMAR_VER_REG);
 	pr_info("%s: reg_base_addr %llx ver %d:%d cap %llx ecap %llx\n",
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 2dd3f055dbce..315c6b7f901c 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1831,6 +1831,7 @@ static int domain_attach_iommu(struct dmar_domain *domain,
 		goto err_clear;
 	}
 	domain_update_iommu_cap(domain);
+	list_add(&domain->domains, &iommu->domains);
 
 	spin_unlock(&iommu->lock);
 	return 0;
@@ -3608,6 +3609,33 @@ static void intel_disable_iommus(void)
 		iommu_disable_translation(iommu);
 }
 
+void zap_context_table_entries(struct intel_iommu *iommu)
+{
+	struct context_entry *context;
+	struct dmar_domain *domain;
+	struct device_domain_info *device;
+	int bus, devfn;
+	u16 did_old;
+
+	list_for_each_entry(domain, &iommu->domains, domains) {
+		list_for_each_entry(device, &domain->devices, link) {
+			context = iommu_context_addr(iommu, device->bus, device->devfn, 0);
+			if (!context || !context_present(context))
+				continue;
+			context_domain_id(context);
+			context_clear_entry(context);
+			__iommu_flush_cache(iommu, context, sizeof(*context));
+			iommu->flush.flush_context(iommu,
+						   did_old,
+						   (((u16)bus) << 8) | devfn,
+						   DMA_CCMD_MASK_NOBIT,
+						   DMA_CCMD_DEVICE_INVL);
+			iommu->flush.flush_iotlb(iommu,	did_old, 0, 0,
+						 DMA_TLB_DSI_FLUSH);
+		}
+	}
+}
+
 void intel_iommu_shutdown(void)
 {
 	struct dmar_drhd_unit *drhd;
@@ -3620,10 +3648,8 @@ void intel_iommu_shutdown(void)
 
 	/* Disable PMRs explicitly here. */
 	for_each_iommu(iommu, drhd)
-		iommu_disable_protect_mem_regions(iommu);
-
-	/* Make sure the IOMMUs are switched off */
-	intel_disable_iommus();
+		zap_context_table_entries(iommu);
+	return
 
 	up_write(&dmar_global_lock);
 }
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index a2338e398ba3..4a2f163a86f3 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -600,6 +600,7 @@ struct dmar_domain {
 	spinlock_t lock;		/* Protect device tracking lists */
 	struct list_head devices;	/* all devices' list */
 	struct list_head dev_pasids;	/* all attached pasids */
+	struct list_head domains;	/* all struct dmar_domains on this IOMMU */
 
 	struct dma_pte	*pgd;		/* virtual address */
 	int		gaw;		/* max guest address width */
@@ -700,6 +701,7 @@ struct intel_iommu {
 	void *perf_statistic;
 
 	struct iommu_pmu *pmu;
+	struct list_head domains;	/* all struct dmar_domains on this IOMMU */
 };
 
 /* PCI domain-device relationship */
-- 
2.40.1


