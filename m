Return-Path: <linux-fsdevel+bounces-10281-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 267CA8499A0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 13:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81BAFB28704
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 12:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECC41CF92;
	Mon,  5 Feb 2024 12:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="jBgeXVbC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BFD1CD35;
	Mon,  5 Feb 2024 12:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707134680; cv=none; b=YIByIh6zRP3VGUbzHnVFM8Am4kH8qnxo1ooVupDGwnn1jMtx6owrFatAyu2HgdLUZ1lQ+XDwtoIK9CPGNFGcp4owGqJm4JzrWyFm1Lsnru4k4XZzVAXvamk1QZbD5KyB4uO9ybm20nnHcPMJGd90mDSrPaL47/8hYhI/l62nvPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707134680; c=relaxed/simple;
	bh=fscNGkpC5vVpP/8B8akCxtTGKONgvg1AB8vehQ7smFU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X4Y+0NAqKIGDdiT48cXfR0058rHy9OxalbUwtpk2JcyO8NDI5pD6/nlSqOiVEAUOWnJ7J9z/xQ2twUgYvThevuQMi/hFDI99yugBujF6ufJvNoOBGIiIjp57Onh+GD8n6zla891IzS9hgJWWp0yshv5df7pE3+9LaTvmxBCxZmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=jBgeXVbC; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1707134680; x=1738670680;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J/26rYh9SEOln6y0M0icroO5+g+Mdt4aS3KBehgGFN8=;
  b=jBgeXVbC7MQ7ZeIq302ImADqVc71l2YNCmbm/gxsDbKY2jZ4RtRubVSp
   BMrt66UyyL0Rk72Q8hIhiQAcndzT2dObMXoEZ8dAKfdA7IERIGzWm/p2L
   P8lNTmaiQmpbvrKZomnyha00s5pOWg0qd2QccLfBLKpD+5MDvaNB6k6aE
   c=;
X-IronPort-AV: E=Sophos;i="6.05,245,1701129600"; 
   d="scan'208";a="63724561"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 12:04:38 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.43.254:15018]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.28.192:2525] with esmtp (Farcaster)
 id 82f5a304-b865-4a4d-9902-a5be57c26a04; Mon, 5 Feb 2024 12:04:36 +0000 (UTC)
X-Farcaster-Flow-ID: 82f5a304-b865-4a4d-9902-a5be57c26a04
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 5 Feb 2024 12:04:36 +0000
Received: from dev-dsk-jgowans-1a-a3faec1f.eu-west-1.amazon.com
 (172.19.112.191) by EX19D014EUC004.ant.amazon.com (10.252.51.182) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 5 Feb
 2024 12:04:30 +0000
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
Subject: [RFC 11/18] dma-iommu: Always enable deferred attaches for liveupdate
Date: Mon, 5 Feb 2024 12:01:56 +0000
Message-ID: <20240205120203.60312-12-jgowans@amazon.com>
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

Seeing as translations are pre-enabled, all devices will be set for
deferred attach. The deferred attached actually has to be done when
doing DMA mapping for devices to work.

There may be a better way to do this be, for example, consulting the
context entry table and only deferring attach if there is a persisted
context table entry for this device.
---
 drivers/iommu/dma-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index e5d087bd6da1..76f916848f48 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1750,7 +1750,7 @@ void iommu_dma_compose_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
 
 static int iommu_dma_init(void)
 {
-	if (is_kdump_kernel())
+	if (is_kdump_kernel() || liveupdate)
 		static_branch_enable(&iommu_deferred_attach_enabled);
 
 	return iova_cache_get();
-- 
2.40.1


