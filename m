Return-Path: <linux-fsdevel+bounces-10283-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A34288499A6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 13:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 163C21F26880
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 12:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6781BF3F;
	Mon,  5 Feb 2024 12:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="R3AYRMnS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1FE1BDED;
	Mon,  5 Feb 2024 12:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707134718; cv=none; b=IMpi1JE6/plHPXfoTrG1lv8DK1G4m0qLP9hDABUv7auautwokDOz6hAm8RJGHAtlhXdabhGXo23sgH9p48+F3sWMHQN8P3ZjPdX/COGKX9gNQhTbTr8zXWr+Opubk1PTejf5c8GvgGB+zJ+8qKiyExYuZ2GCiZe2mB5ApVqQokc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707134718; c=relaxed/simple;
	bh=z8BoM9mBaSRQmeip//Yd1XmcxTr/klkAQB0/G6dx2tY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S7jOIy6WnHIF5sFYrhDhXFafXN+ZK731Ezovmo9A3ryHtKNjHulaAvaVMDBdQhVGiJXSpD077Sfljdbljeih4hv5ny3iMB2apApqvTLhYw/AqfdP0oFEr5wZjZXG/uBhs43LdiqC4TsHu369gyqEaFIm5kYCJY1Rde3XhM/zkL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=R3AYRMnS; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1707134717; x=1738670717;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mVhmItHN9qmSrpLWsRnSDOh51VJYGjIwmSMhmIPWHpo=;
  b=R3AYRMnSiKwRmMKtH/lqN0t0jVA1hEeWujguPv2alxxY26X3S7XzQefN
   CbMyAY1Rw40hw8Q32U8gZ8gatsvonTW4i0VA21ckDc9rQ1AWwQz/O6p+M
   FzpA83tH+NQsPmMmtOZu3T0MuoB6TXvnFWVtb+BYZJp3/CpOeYlh70u6f
   A=;
X-IronPort-AV: E=Sophos;i="6.05,245,1701129600"; 
   d="scan'208";a="271102836"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 12:05:14 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.17.79:18332]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.28.192:2525] with esmtp (Farcaster)
 id 430958cf-6b4e-40ab-be7a-e53a50074ea7; Mon, 5 Feb 2024 12:05:13 +0000 (UTC)
X-Farcaster-Flow-ID: 430958cf-6b4e-40ab-be7a-e53a50074ea7
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 5 Feb 2024 12:05:13 +0000
Received: from dev-dsk-jgowans-1a-a3faec1f.eu-west-1.amazon.com
 (172.19.112.191) by EX19D014EUC004.ant.amazon.com (10.252.51.182) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 5 Feb
 2024 12:05:06 +0000
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
Subject: [RFC 13/18] vfio: add ioctl to define persistent pgtables on container
Date: Mon, 5 Feb 2024 12:01:58 +0000
Message-ID: <20240205120203.60312-14-jgowans@amazon.com>
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
X-ClientProxiedBy: EX19D046UWA004.ant.amazon.com (10.13.139.76) To
 EX19D014EUC004.ant.amazon.com (10.252.51.182)

The previous commits added a file type in pkernfs for IOMMU persistent
page tables. Now support actually setting persistent page tables on an
IOMMU domain. This is done via a VFIO ioctl on a VFIO container.

Userspace needs to create and open a IOMMU persistent page tables file
and then supply that fd to the new VFIO_CONTAINER_SET_PERSISTENT_PGTABLES
ioctl. That ioctl sets the supplied struct file on the
struct vfio_container. Later when the IOMMU domain is allocated by VFIO,
VFIO  will check to see if the persistent pagetables have been defined
and if they have will use the iommu_domain_alloc_persistent API which
was introduced in the previous commit to pass the struct file down to
the IOMMU which will actually use it for page tables.

After kexec userspace needs to open the same IOMMU page table file and
set it again via the same ioctl so that the IOMMU continues to use the
same memory region for its page tables for that domain.
---
 drivers/vfio/container.c        | 27 +++++++++++++++++++++++++++
 drivers/vfio/vfio.h             |  2 ++
 drivers/vfio/vfio_iommu_type1.c | 27 +++++++++++++++++++++++++--
 include/uapi/linux/vfio.h       |  9 +++++++++
 4 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/container.c b/drivers/vfio/container.c
index d53d08f16973..b60fcbf7bad0 100644
--- a/drivers/vfio/container.c
+++ b/drivers/vfio/container.c
@@ -11,6 +11,7 @@
 #include <linux/iommu.h>
 #include <linux/miscdevice.h>
 #include <linux/vfio.h>
+#include <linux/pkernfs.h>
 #include <uapi/linux/vfio.h>
 
 #include "vfio.h"
@@ -21,6 +22,7 @@ struct vfio_container {
 	struct rw_semaphore		group_lock;
 	struct vfio_iommu_driver	*iommu_driver;
 	void				*iommu_data;
+	struct file			*persistent_pgtables;
 	bool				noiommu;
 };
 
@@ -306,6 +308,8 @@ static long vfio_ioctl_set_iommu(struct vfio_container *container,
 			continue;
 		}
 
+		driver->ops->set_persistent_pgtables(data, container->persistent_pgtables);
+
 		ret = __vfio_container_attach_groups(container, driver, data);
 		if (ret) {
 			driver->ops->release(data);
@@ -324,6 +328,26 @@ static long vfio_ioctl_set_iommu(struct vfio_container *container,
 	return ret;
 }
 
+static int vfio_ioctl_set_persistent_pgtables(struct vfio_container *container,
+		unsigned long arg)
+{
+	struct vfio_set_persistent_pgtables set_ppts;
+	struct file *ppts;
+
+	if (copy_from_user(&set_ppts, (void __user *)arg, sizeof(set_ppts)))
+		return -EFAULT;
+
+	ppts = fget(set_ppts.persistent_pgtables_fd);
+	if (!ppts)
+		return -EBADF;
+	if (!pkernfs_is_iommu_domain_pgtables(ppts)) {
+		fput(ppts);
+		return -EBADF;
+	}
+	container->persistent_pgtables = ppts;
+	return 0;
+}
+
 static long vfio_fops_unl_ioctl(struct file *filep,
 				unsigned int cmd, unsigned long arg)
 {
@@ -345,6 +369,9 @@ static long vfio_fops_unl_ioctl(struct file *filep,
 	case VFIO_SET_IOMMU:
 		ret = vfio_ioctl_set_iommu(container, arg);
 		break;
+	case VFIO_CONTAINER_SET_PERSISTENT_PGTABLES:
+		ret = vfio_ioctl_set_persistent_pgtables(container, arg);
+		break;
 	default:
 		driver = container->iommu_driver;
 		data = container->iommu_data;
diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
index 307e3f29b527..6fa301bf6474 100644
--- a/drivers/vfio/vfio.h
+++ b/drivers/vfio/vfio.h
@@ -226,6 +226,8 @@ struct vfio_iommu_driver_ops {
 				  void *data, size_t count, bool write);
 	struct iommu_domain *(*group_iommu_domain)(void *iommu_data,
 						   struct iommu_group *group);
+	int		(*set_persistent_pgtables)(void *iommu_data,
+						   struct file *ppts);
 };
 
 struct vfio_iommu_driver {
diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index eacd6ec04de5..b36edfc5c9ef 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -75,6 +75,7 @@ struct vfio_iommu {
 	bool			nesting;
 	bool			dirty_page_tracking;
 	struct list_head	emulated_iommu_groups;
+	struct file		*persistent_pgtables;
 };
 
 struct vfio_domain {
@@ -2143,9 +2144,14 @@ static void vfio_iommu_iova_insert_copy(struct vfio_iommu *iommu,
 
 static int vfio_iommu_domain_alloc(struct device *dev, void *data)
 {
+	/* data is an in pointer to PPTs, and an out to the new domain. */
+	struct file *ppts = *(struct file **) data;
 	struct iommu_domain **domain = data;
 
-	*domain = iommu_domain_alloc(dev->bus);
+	if (ppts)
+		*domain = iommu_domain_alloc_persistent(dev->bus, ppts);
+	else
+		*domain = iommu_domain_alloc(dev->bus);
 	return 1; /* Don't iterate */
 }
 
@@ -2156,6 +2162,8 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	struct vfio_iommu_group *group;
 	struct vfio_domain *domain, *d;
 	bool resv_msi;
+	/* In/out ptr to iommu_domain_alloc. */
+	void *domain_alloc_data;
 	phys_addr_t resv_msi_base = 0;
 	struct iommu_domain_geometry *geo;
 	LIST_HEAD(iova_copy);
@@ -2203,8 +2211,12 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	 * want to iterate beyond the first device (if any).
 	 */
 	ret = -EIO;
-	iommu_group_for_each_dev(iommu_group, &domain->domain,
+	/* Smuggle the PPTs in the data field; it will be clobbered with the new domain */
+	domain_alloc_data = iommu->persistent_pgtables;
+	iommu_group_for_each_dev(iommu_group, &domain_alloc_data,
 				 vfio_iommu_domain_alloc);
+	domain->domain = domain_alloc_data;
+
 	if (!domain->domain)
 		goto out_free_domain;
 
@@ -3165,6 +3177,16 @@ vfio_iommu_type1_group_iommu_domain(void *iommu_data,
 	return domain;
 }
 
+int vfio_iommu_type1_set_persistent_pgtables(void *iommu_data,
+				    struct file *ppts)
+{
+
+	struct vfio_iommu *iommu = iommu_data;
+
+	iommu->persistent_pgtables = ppts;
+	return 0;
+}
+
 static const struct vfio_iommu_driver_ops vfio_iommu_driver_ops_type1 = {
 	.name			= "vfio-iommu-type1",
 	.owner			= THIS_MODULE,
@@ -3179,6 +3201,7 @@ static const struct vfio_iommu_driver_ops vfio_iommu_driver_ops_type1 = {
 	.unregister_device	= vfio_iommu_type1_unregister_device,
 	.dma_rw			= vfio_iommu_type1_dma_rw,
 	.group_iommu_domain	= vfio_iommu_type1_group_iommu_domain,
+	.set_persistent_pgtables = vfio_iommu_type1_set_persistent_pgtables,
 };
 
 static int __init vfio_iommu_type1_init(void)
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index afc1369216d9..fa9676bb4b26 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1797,6 +1797,15 @@ struct vfio_iommu_spapr_tce_remove {
 };
 #define VFIO_IOMMU_SPAPR_TCE_REMOVE	_IO(VFIO_TYPE, VFIO_BASE + 20)
 
+struct vfio_set_persistent_pgtables {
+	/*
+	 * File descriptor for a pkernfs IOMMU pgtables
+	 * file to be used for persistence.
+	 */
+	__u32	persistent_pgtables_fd;
+};
+#define VFIO_CONTAINER_SET_PERSISTENT_PGTABLES	_IO(VFIO_TYPE, VFIO_BASE + 21)
+
 /* ***************************************************************** */
 
 #endif /* _UAPIVFIO_H */
-- 
2.40.1


