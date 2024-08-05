Return-Path: <linux-fsdevel+bounces-24982-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 198B794786A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 11:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CF46B23B52
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 09:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1913615383D;
	Mon,  5 Aug 2024 09:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="IkUqHxWA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FB4154BE7;
	Mon,  5 Aug 2024 09:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722850474; cv=none; b=oQkam1Pn/h+Kbfottc5Pms2yiy28tiSo6NoSmtR7fU4YfMGWyK7az1zdEPX5KkfXV+oS2TbKTRABl86CD1gLdLLr4t1RhBeeaNwB7dW3Bo9MK4BCfgIKP0RhhguEQO2/WI4dQY7OODzzKkLylLNvcKozuL+90mELAiFcwwCcCa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722850474; c=relaxed/simple;
	bh=JDBxRZkF7qtTIiobsrij9ABz3RpEDD5fpxOB1egzB0g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oSXG86KvGVsgzmFxRgROgCX0hXIaWddbEYDMg/CLUS/+07SYBSOU63Ob6ZCHkN61f0C2Ypjz3UgDbQsvgPMvUY1hhtT0ty3Z2eIiMu6NHYx7pfK+rkFYBfjU5i7XwW91wFv5d26tAm+EJ0CKr622i85zIC2Xv428NYWc8fIpDhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=IkUqHxWA; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1722850473; x=1754386473;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QLzX8kQ4Me7VkWkGGUOEVumIPTgCaBccV0Vp9jQZvU0=;
  b=IkUqHxWAI7TYM9W2XdphdZ415TRyDYS6hLpAGvEqxH5+10J1lkCjK83C
   C6Kj9OgDLio64suRcfCtH2pPJfN5MDfxsNTFskg/+66TvkOlQHBk6wy5g
   NRj3lRYATmW8rZPkGp/d3lnCGxnYxIgxxhhv64r2KJARiOLSaTjUNjWWF
   w=;
X-IronPort-AV: E=Sophos;i="6.09,264,1716249600"; 
   d="scan'208";a="650673665"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 09:34:29 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.17.79:60629]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.35.73:2525] with esmtp (Farcaster)
 id d3e48c8d-1f8d-494a-8e05-dd641a46ffbf; Mon, 5 Aug 2024 09:34:28 +0000 (UTC)
X-Farcaster-Flow-ID: d3e48c8d-1f8d-494a-8e05-dd641a46ffbf
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 5 Aug 2024 09:34:27 +0000
Received: from u5d18b891348c5b.ant.amazon.com (10.146.13.113) by
 EX19D014EUC004.ant.amazon.com (10.252.51.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 5 Aug 2024 09:34:18 +0000
From: James Gowans <jgowans@amazon.com>
To: <linux-kernel@vger.kernel.org>
CC: James Gowans <jgowans@amazon.com>, Sean Christopherson
	<seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Steve Sistare <steven.sistare@oracle.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, "Anthony
 Yznaga" <anthony.yznaga@oracle.com>, Mike Rapoport <rppt@kernel.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, <linux-mm@kvack.org>, Jason Gunthorpe
	<jgg@ziepe.ca>, <linux-fsdevel@vger.kernel.org>, Usama Arif
	<usama.arif@bytedance.com>, <kvm@vger.kernel.org>, Alexander Graf
	<graf@amazon.com>, David Woodhouse <dwmw@amazon.co.uk>, Paul Durrant
	<pdurrant@amazon.co.uk>, Nicolas Saenz Julienne <nsaenz@amazon.es>
Subject: [PATCH 05/10] guestmemfs: add file mmap callback
Date: Mon, 5 Aug 2024 11:32:40 +0200
Message-ID: <20240805093245.889357-6-jgowans@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240805093245.889357-1-jgowans@amazon.com>
References: <20240805093245.889357-1-jgowans@amazon.com>
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

Make the file data usable to userspace by adding mmap. That's all that
QEMU needs for guest RAM, so that's all be bother implementing for now.

When mmaping the file the VMA is marked as PFNMAP to indicate that there
are no struct pages for the memory in this VMA. Remap_pfn_range() is
used to actually populate the page tables. All PTEs are pre-faulted into
the pgtables at mmap time so that the pgtables are usable when this
virtual address range is given to VFIO's MAP_DMA.

Signed-off-by: James Gowans <jgowans@amazon.com>
---
 fs/guestmemfs/file.c       | 43 +++++++++++++++++++++++++++++++++++++-
 fs/guestmemfs/guestmemfs.c |  2 +-
 fs/guestmemfs/guestmemfs.h |  3 +++
 3 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/fs/guestmemfs/file.c b/fs/guestmemfs/file.c
index 618c93b12196..b1a52abcde65 100644
--- a/fs/guestmemfs/file.c
+++ b/fs/guestmemfs/file.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
 #include "guestmemfs.h"
+#include <linux/mm.h>
 
 static int truncate(struct inode *inode, loff_t newsize)
 {
@@ -41,6 +42,46 @@ static int inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry, struct
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
+	struct guestmemfs_inode *guestmemfs_inode;
+
+	guestmemfs_inode = guestmemfs_get_persisted_inode(filp->f_inode->i_sb,
+			filp->f_inode->i_ino);
+
+	mappings_block = guestmemfs_inode->mappings;
+
+	/* Remap-pfn-range will mark the range VM_IO */
+	for (unsigned long vma_addr_offset = vma->vm_start;
+			vma_addr_offset < vma->vm_end;
+			vma_addr_offset += PMD_SIZE) {
+		int block, mapped_block;
+		unsigned long map_size = min(PMD_SIZE, vma->vm_end - vma_addr_offset);
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
+				(guestmemfs_base >> PAGE_SHIFT) + (mapped_block * 512),
+				map_size,
+				vma->vm_page_prot);
+	}
+	return 0;
+}
+
 const struct inode_operations guestmemfs_file_inode_operations = {
 	.setattr = inode_setattr,
 	.getattr = simple_getattr,
@@ -48,5 +89,5 @@ const struct inode_operations guestmemfs_file_inode_operations = {
 
 const struct file_operations guestmemfs_file_fops = {
 	.owner = THIS_MODULE,
-	.iterate_shared = NULL,
+	.mmap = mmap,
 };
diff --git a/fs/guestmemfs/guestmemfs.c b/fs/guestmemfs/guestmemfs.c
index c45c796c497a..38f20ad25286 100644
--- a/fs/guestmemfs/guestmemfs.c
+++ b/fs/guestmemfs/guestmemfs.c
@@ -9,7 +9,7 @@
 #include <linux/memblock.h>
 #include <linux/statfs.h>
 
-static phys_addr_t guestmemfs_base, guestmemfs_size;
+phys_addr_t guestmemfs_base, guestmemfs_size;
 struct guestmemfs_sb *psb;
 
 static int statfs(struct dentry *root, struct kstatfs *buf)
diff --git a/fs/guestmemfs/guestmemfs.h b/fs/guestmemfs/guestmemfs.h
index 7ea03ac8ecca..0f2788ce740e 100644
--- a/fs/guestmemfs/guestmemfs.h
+++ b/fs/guestmemfs/guestmemfs.h
@@ -8,6 +8,9 @@
 #define GUESTMEMFS_FILENAME_LEN 255
 #define GUESTMEMFS_PSB(sb) ((struct guestmemfs_sb *)sb->s_fs_info)
 
+/* Units of bytes */
+extern phys_addr_t guestmemfs_base, guestmemfs_size;
+
 struct guestmemfs_sb {
 	/* Inode number */
 	unsigned long next_free_ino;
-- 
2.34.1


