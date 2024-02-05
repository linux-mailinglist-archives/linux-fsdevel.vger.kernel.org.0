Return-Path: <linux-fsdevel+bounces-10275-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D00849989
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 13:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB2821C22BCC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 12:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7111BDD8;
	Mon,  5 Feb 2024 12:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Bo62Hq4w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4225F1BF47;
	Mon,  5 Feb 2024 12:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707134595; cv=none; b=ayQzVLTr9ZfuqcEx6ngTRe1vg8OYjIKDD+qM4xCtWVEPB5GGS4qlqvAuablf/8/keoNDCLoYcZtPit6GLvQttKAE7NU560vnhB6npThdG7YjORgPU1uTloiQZto2YsDBsgWdfu3+2zVTYjU5D6yLRzkKaQytItuLkSovjAyfm4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707134595; c=relaxed/simple;
	bh=X0DVeAhkLd+qmZjH5rmDRSG3fWO+VNwd2pVbOIDFh9k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gvdoX61FDn4IdJ5Xkw3OKznvZiI6C34TzEMV9nvxsdv8p2dvnlGSih61vm9pZ4NAOFd33N+zuo/Z10QTIwfWhT6VUc7wg89H2XpcuhTnVil3xtTLsMg4GK4+o+AU37+wUXfwdpHr5cc4owyIZY0SHpNG7apMF5ayeNV+bDohor4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Bo62Hq4w; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1707134594; x=1738670594;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0/oASfY5H1JyciZlNLWYHif+Zbb5czst+5Ds70M97DI=;
  b=Bo62Hq4wZkiJjgZ4E8Art4Q5jS9hXwFz/gPSBAwIZ/MeOo9pcaoKWuCH
   OxyO1VwyVw+B4tTI0M7vt3288m2mDKFdDtq56Wc3Eh3GaorD92eDgQ2vV
   BU8RTrl0enJ4PYciaw55awgS/kEHlLTXXPMfWqugIF6gTWf+ytZap3iuJ
   g=;
X-IronPort-AV: E=Sophos;i="6.05,245,1701129600"; 
   d="scan'208";a="632119672"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 12:03:11 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.17.79:5859]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.31.207:2525] with esmtp (Farcaster)
 id 80b5446f-c47d-4e7f-ae7e-e8668aadf81b; Mon, 5 Feb 2024 12:03:10 +0000 (UTC)
X-Farcaster-Flow-ID: 80b5446f-c47d-4e7f-ae7e-e8668aadf81b
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 5 Feb 2024 12:03:10 +0000
Received: from dev-dsk-jgowans-1a-a3faec1f.eu-west-1.amazon.com
 (172.19.112.191) by EX19D014EUC004.ant.amazon.com (10.252.51.182) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 5 Feb
 2024 12:03:03 +0000
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
Subject: [RFC 05/18] pkernfs: add file mmap callback
Date: Mon, 5 Feb 2024 12:01:50 +0000
Message-ID: <20240205120203.60312-6-jgowans@amazon.com>
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

Make the file data useable to userspace by adding mmap. That's all that
QEMU needs for guest RAM, so that's all be bother implementing for now.

When mmaping the file the VMA is marked as PFNMAP to indicate that there
are no struct pages for the memory in this VMA. Remap_pfn_range() is
used to actually populate the page tables. All PTEs are pre-faulted into
the pgtables at mmap time so that the pgtables are useable when this
virtual address range is given to VFIO's MAP_DMA.
---
 fs/pkernfs/file.c    | 42 +++++++++++++++++++++++++++++++++++++++++-
 fs/pkernfs/pkernfs.c |  2 +-
 fs/pkernfs/pkernfs.h |  2 ++
 3 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/fs/pkernfs/file.c b/fs/pkernfs/file.c
index 27a637423178..844b6cc63840 100644
--- a/fs/pkernfs/file.c
+++ b/fs/pkernfs/file.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
 #include "pkernfs.h"
+#include <linux/mm.h>
 
 static int truncate(struct inode *inode, loff_t newsize)
 {
@@ -42,6 +43,45 @@ static int inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry, struct
 	return 0;
 }
 
+/*
+ * To be able to use PFNMAP VMAs for VFIO DMA mapping we need the page tables
+ * populated with mappings. Pre-fault everything.
+ */
+static int mmap(struct file *filp, struct vm_area_struct *vma)
+{
+	int rc;
+	unsigned long *mappings_block;
+	struct pkernfs_inode *pkernfs_inode;
+
+	pkernfs_inode = pkernfs_get_persisted_inode(filp->f_inode->i_sb, filp->f_inode->i_ino);
+
+	mappings_block = (unsigned long *)pkernfs_addr_for_block(filp->f_inode->i_sb,
+			pkernfs_inode->mappings_block);
+
+	/* Remap-pfn-range will mark the range VM_IO */
+	for (unsigned long vma_addr_offset = vma->vm_start;
+			vma_addr_offset < vma->vm_end;
+			vma_addr_offset += PMD_SIZE) {
+		int block, mapped_block;
+
+		block = (vma_addr_offset - vma->vm_start) / PMD_SIZE;
+		mapped_block = *(mappings_block + block);
+		/*
+		 * It's wrong to use rempa_pfn_range; this will install PTE-level entries.
+		 * The whole point of 2 MiB allocs is to improve TLB perf!
+		 * We should use something like mm/huge_memory.c#insert_pfn_pmd
+		 * but that is currently static.
+		 * TODO: figure out the best way to install PMDs.
+		 */
+		rc = remap_pfn_range(vma,
+				vma_addr_offset,
+				(pkernfs_base >> PAGE_SHIFT) + (mapped_block * 512),
+				PMD_SIZE,
+				vma->vm_page_prot);
+	}
+	return 0;
+}
+
 const struct inode_operations pkernfs_file_inode_operations = {
 	.setattr = inode_setattr,
 	.getattr = simple_getattr,
@@ -49,5 +89,5 @@ const struct inode_operations pkernfs_file_inode_operations = {
 
 const struct file_operations pkernfs_file_fops = {
 	.owner = THIS_MODULE,
-	.iterate_shared = NULL,
+	.mmap = mmap,
 };
diff --git a/fs/pkernfs/pkernfs.c b/fs/pkernfs/pkernfs.c
index 199c2c648bca..f010c2d76c76 100644
--- a/fs/pkernfs/pkernfs.c
+++ b/fs/pkernfs/pkernfs.c
@@ -7,7 +7,7 @@
 #include <linux/fs_context.h>
 #include <linux/io.h>
 
-static phys_addr_t pkernfs_base, pkernfs_size;
+phys_addr_t pkernfs_base, pkernfs_size;
 void *pkernfs_mem;
 static const struct super_operations pkernfs_super_ops = { };
 
diff --git a/fs/pkernfs/pkernfs.h b/fs/pkernfs/pkernfs.h
index 8b4fee8c5b2e..1a7aa783a9be 100644
--- a/fs/pkernfs/pkernfs.h
+++ b/fs/pkernfs/pkernfs.h
@@ -6,6 +6,8 @@
 #define PKERNFS_FILENAME_LEN 255
 
 extern void *pkernfs_mem;
+/* Units of bytes */
+extern phys_addr_t pkernfs_base, pkernfs_size;
 
 struct pkernfs_sb {
 	unsigned long magic_number;
-- 
2.40.1


