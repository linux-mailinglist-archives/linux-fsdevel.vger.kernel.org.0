Return-Path: <linux-fsdevel+bounces-10289-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D237F8499BD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 13:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70F621F27A93
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 12:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FED1C6BB;
	Mon,  5 Feb 2024 12:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="KS4I5EHo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B873A21112;
	Mon,  5 Feb 2024 12:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707134800; cv=none; b=YxJ6wdOQS0TZPvzRInTa1S5d99lTgL89aVwjyXgEE8L+sbQbVWR8cdMY2BdLvhUVOg6G6XZYkehkkd4vHlDHBpqXzir5wcaFGfmOzjd71JSOnLZ1YxjUC6qUCkVkWWbEmPM9Mgd3r5xcn/RgTW7MwLVRoVXFM125TYYXkp7Skw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707134800; c=relaxed/simple;
	bh=yhYdhvkUj66URI+HxR9xU2mALUiQmweSZAQjAWuVHXw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LzgPUhIbuNVAexs0wKTrO0nqm1P+HU2wRm8r/0YBT9wphTVZRnWkGGDrDn49NgI3RmH+IjFj/Cy5iG/uOy9fyEWEYR1pfNR5hB61TcirbB86pRe/1qI50OGpObfLNteAx0wtke33E8dTPYFx6OlzzTFjG6bBjourBaKUL5ZRyiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=KS4I5EHo; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1707134799; x=1738670799;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FiBUV1fiPqoy2U4uMejLoWWd/EiydMvzfGCqIJIuYJY=;
  b=KS4I5EHoPb/GLevhTJXhrqZGA19Gu0J1gr1dLxgNL42X9GGMElWCxcV6
   TMkSKYaGibsuGrDtJ/BVIk12A5B2F6AeD63lMV41v1myZ+ZGI6khCfgDA
   KtYbjAX5a0RIQlGh00w6P5OeRBJ1H9xpdzO4LHNt/rm5sA/HwFOxllbTC
   U=;
X-IronPort-AV: E=Sophos;i="6.05,245,1701129600"; 
   d="scan'208";a="378967633"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 12:06:35 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.17.79:8094]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.45.85:2525] with esmtp (Farcaster)
 id 26f74936-a3bc-4ca0-9d65-59fbb5471a6c; Mon, 5 Feb 2024 12:06:32 +0000 (UTC)
X-Farcaster-Flow-ID: 26f74936-a3bc-4ca0-9d65-59fbb5471a6c
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 5 Feb 2024 12:06:32 +0000
Received: from dev-dsk-jgowans-1a-a3faec1f.eu-west-1.amazon.com
 (172.19.112.191) by EX19D014EUC004.ant.amazon.com (10.252.51.182) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 5 Feb
 2024 12:06:26 +0000
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
Subject: [RFC 18/18] vfio-pci: Assume device working after liveupdate
Date: Mon, 5 Feb 2024 12:02:03 +0000
Message-ID: <20240205120203.60312-19-jgowans@amazon.com>
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
X-ClientProxiedBy: EX19D044UWB004.ant.amazon.com (10.13.139.134) To
 EX19D014EUC004.ant.amazon.com (10.252.51.182)

When re-creating a VFIO device after liveupdate no desctructive actions
should be taken on it to avoid interrupting any ongoing DMA.
Specifically bus mastering should not be cleared and the device should
not be reset. Assume that reset works properly and skip over bus
mastering reset.

Ideally this would only be done for persistent devices but in this rough
RFC there currently is no mechanism at this point to easily tell if a
device is persisted or not.
---
 drivers/vfio/pci/vfio_pci_core.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 1929103ee59a..a7f56d43e0a4 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -480,19 +480,25 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 			return ret;
 	}
 
-	/* Don't allow our initial saved state to include busmaster */
-	pci_clear_master(pdev);
+	if (!liveupdate) {
+		/* Don't allow our initial saved state to include busmaster */
+		pci_clear_master(pdev);
+	}
 
 	ret = pci_enable_device(pdev);
 	if (ret)
 		goto out_power;
 
-	/* If reset fails because of the device lock, fail this path entirely */
-	ret = pci_try_reset_function(pdev);
-	if (ret == -EAGAIN)
-		goto out_disable_device;
+	if (!liveupdate) {
+		/* If reset fails because of the device lock, fail this path entirely */
+		ret = pci_try_reset_function(pdev);
+		if (ret == -EAGAIN)
+			goto out_disable_device;
 
-	vdev->reset_works = !ret;
+		vdev->reset_works = !ret;
+	} else {
+		vdev->reset_works = 1;
+	}
 	pci_save_state(pdev);
 	vdev->pci_saved_state = pci_store_saved_state(pdev);
 	if (!vdev->pci_saved_state)
-- 
2.40.1


