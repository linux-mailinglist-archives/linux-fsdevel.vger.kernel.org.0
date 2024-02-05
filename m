Return-Path: <linux-fsdevel+bounces-10278-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5939C849993
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 13:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DC4A1C22DD5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 12:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CDB1BC3D;
	Mon,  5 Feb 2024 12:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="oVzsA6nA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE291C68D;
	Mon,  5 Feb 2024 12:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707134639; cv=none; b=NVgyJDGkp3qdvbci56kmhgp3kQQTNmE1SlYeUhPQ6An0nw1OiJUfajyI+LuuWRs4seyHPOT1hPaK4cku+FoYyfjvfx0g1ekI9xpty28UsZvrdo/npkDUnaHE1h7jSTIhUYKOFdJKpO0N9ue9BLeLIy7RwjpsQKhS2IIH8HwhEZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707134639; c=relaxed/simple;
	bh=KJj1B5pipHCNG5+0xARVhv9lBaZP4+Uag/y5HQlG81E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ku3DHDTq6tsE9Me3BLFiCXMiicfTsn/bbbVh372Zv7aeiPgMa9T2ukqZSUk0HSIPaWF1wyzEchBWZn4+m1V7HRs8kqQjSxAlp9CX2ZCpRLpLyOGqbCBUn982+rTVmsAOrSQP4/rk9DgUYecEcoO+dqaVMQR9YQgSzYR0YLMtm9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=oVzsA6nA; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1707134638; x=1738670638;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TzDhoCjRqYjwB6Ud3BxBgq+3tlmLodP3ZHF9TRx+87E=;
  b=oVzsA6nAcfsX2N9xvk+a6q/VX6J3iUMxPcWj8ZReekVCI1QcTwQpPgY1
   7pufPRraCq/vpoLSpm9GWvVjHX/gwtpQk3b260sTs+RCcqKuFfnY5SWJX
   KPF0eYZXHHULCJq1p4kiXiEsmaqrWgvxagCOCHboX6GAzuQ7jC2dxTgOG
   Q=;
X-IronPort-AV: E=Sophos;i="6.05,245,1701129600"; 
   d="scan'208";a="394883262"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 12:03:52 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.17.79:26775]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.8.155:2525] with esmtp (Farcaster)
 id 37d56f4d-adef-4cf1-bb52-948bac8bacd3; Mon, 5 Feb 2024 12:03:50 +0000 (UTC)
X-Farcaster-Flow-ID: 37d56f4d-adef-4cf1-bb52-948bac8bacd3
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 5 Feb 2024 12:03:46 +0000
Received: from dev-dsk-jgowans-1a-a3faec1f.eu-west-1.amazon.com
 (172.19.112.191) by EX19D014EUC004.ant.amazon.com (10.252.51.182) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 5 Feb
 2024 12:03:40 +0000
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
Subject: [RFC 07/18] pkernfs: Add file type for IOMMU root pgtables
Date: Mon, 5 Feb 2024 12:01:52 +0000
Message-ID: <20240205120203.60312-8-jgowans@amazon.com>
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

So far pkernfs is able to hold regular files for userspace to mmap and
in which store persisted data. Now begin the IOMMU integration for
persistent IOMMU pgtables.

A new type of inode is created for an IOMMU data directory. A new type
of inode is also created for a file which holds the IOMMU root pgtables.
The inode types are specified by flags on the inodes. Different inode
ops are also registed on the IOMMU pgtables file to ensure that
userspace can't access it. These IOMMU directory and data inodes are
created lazily: pkernfs_alloc_iommu_root_pgtables() scans for these and
returns them if they already exist (ie: after kexec) or creates them if
they don't exist (ie: cold boot).

The data in the IOMMU root pgtables file needs to be accessible early in
system boot: before filesystems are initialised and before anything is
mounted. To support this the pkernfs initialisation code is split out
into an pkernfs_init() function which is responsible for making the
pkernfs memory available. Here the filesystem abstraction starts to
creak: the pkernfs functions responsible for the IOMMU pgtables files
manipulated persisted inodes directly. It may be preferable to somehow
get pkernfs mounted early in system boot before it's needed by the IOMMU
so that filesystem paths can be used, but it is unclear if that's
possible.

The need for super blocks in the pkernfs functions has been limited so
far, super blocks are barely used because the pkernfs extents are stored
as global variables in pkernfs.c. Now NULLs are actually supplied to
functions which take a super block. This is also not pretty and this
code should probably rather be plumbing some sort of wrapper around the
persisted super block which would allow supporting multiple mount
moints.

Additionally, the memory backing the IOMMU root pgtable file is mapped
into the direct map by registering it as a device. This is needed
because the IOMMU does phys_to_virt in a few places when traversing the
pgtables so the direct map virtual address should be populated. The
alternative would be to replace all of the phy_to_virt calls in the
IOMMU driver with wrappers which understand if the phys_addr is part of
a pkernfs file.

The next commit will use this pkernfs file for root pgtables.
---
 fs/pkernfs/Makefile     |  2 +-
 fs/pkernfs/inode.c      | 17 +++++--
 fs/pkernfs/iommu.c      | 98 +++++++++++++++++++++++++++++++++++++++++
 fs/pkernfs/pkernfs.c    | 38 ++++++++++------
 fs/pkernfs/pkernfs.h    |  7 +++
 include/linux/pkernfs.h | 36 +++++++++++++++
 6 files changed, 181 insertions(+), 17 deletions(-)
 create mode 100644 fs/pkernfs/iommu.c
 create mode 100644 include/linux/pkernfs.h

diff --git a/fs/pkernfs/Makefile b/fs/pkernfs/Makefile
index e41f06cc490f..7f0f7a4cd3a1 100644
--- a/fs/pkernfs/Makefile
+++ b/fs/pkernfs/Makefile
@@ -3,4 +3,4 @@
 # Makefile for persistent kernel filesystem
 #
 
-obj-$(CONFIG_PKERNFS_FS) += pkernfs.o inode.o allocator.o dir.o file.o
+obj-$(CONFIG_PKERNFS_FS) += pkernfs.o inode.o allocator.o dir.o file.o iommu.o
diff --git a/fs/pkernfs/inode.c b/fs/pkernfs/inode.c
index 7fe4e7b220cc..1d712e0a82a1 100644
--- a/fs/pkernfs/inode.c
+++ b/fs/pkernfs/inode.c
@@ -25,11 +25,18 @@ struct inode *pkernfs_inode_get(struct super_block *sb, unsigned long ino)
 	inode->i_sb = sb;
 	if (pkernfs_inode->flags & PKERNFS_INODE_FLAG_DIR) {
 		inode->i_op = &pkernfs_dir_inode_operations;
+		inode->i_fop = &pkernfs_dir_fops;
 		inode->i_mode = S_IFDIR;
-	} else {
+	} else if (pkernfs_inode->flags & PKERNFS_INODE_FLAG_FILE)  {
 		inode->i_op = &pkernfs_file_inode_operations;
-		inode->i_mode = S_IFREG;
 		inode->i_fop = &pkernfs_file_fops;
+		inode->i_mode = S_IFREG;
+	} else if (pkernfs_inode->flags & PKERNFS_INODE_FLAG_IOMMU_DIR) {
+		inode->i_op = &pkernfs_iommu_dir_inode_operations;
+		inode->i_fop = &pkernfs_dir_fops;
+		inode->i_mode = S_IFDIR;
+	} else if (pkernfs_inode->flags | PKERNFS_INODE_FLAG_IOMMU_ROOT_PGTABLES) {
+		inode->i_mode = S_IFREG;
 	}
 
 	inode->i_atime = inode->i_mtime = current_time(inode);
@@ -41,7 +48,7 @@ struct inode *pkernfs_inode_get(struct super_block *sb, unsigned long ino)
 	return inode;
 }
 
-static unsigned long pkernfs_allocate_inode(struct super_block *sb)
+unsigned long pkernfs_allocate_inode(struct super_block *sb)
 {
 
 	unsigned long next_free_ino;
@@ -167,3 +174,7 @@ const struct inode_operations pkernfs_dir_inode_operations = {
 	.unlink		= pkernfs_unlink,
 };
 
+const struct inode_operations pkernfs_iommu_dir_inode_operations = {
+	.lookup		= pkernfs_lookup,
+};
+
diff --git a/fs/pkernfs/iommu.c b/fs/pkernfs/iommu.c
new file mode 100644
index 000000000000..5bce8146d7bb
--- /dev/null
+++ b/fs/pkernfs/iommu.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "pkernfs.h"
+#include <linux/io.h>
+
+
+void pkernfs_alloc_iommu_root_pgtables(struct pkernfs_region *pkernfs_region)
+{
+	unsigned long *mappings_block_vaddr;
+	unsigned long inode_idx;
+	struct pkernfs_inode *iommu_pgtables, *iommu_dir = NULL;
+	int rc;
+
+	pkernfs_init();
+
+	/* Try find a 'iommu' directory */
+	inode_idx = pkernfs_get_persisted_inode(NULL, 1)->child_ino;
+	while (inode_idx) {
+		if (!strncmp(pkernfs_get_persisted_inode(NULL, inode_idx)->filename,
+					"iommu", PKERNFS_FILENAME_LEN)) {
+			iommu_dir = pkernfs_get_persisted_inode(NULL, inode_idx);
+			break;
+		}
+		inode_idx = pkernfs_get_persisted_inode(NULL, inode_idx)->sibling_ino;
+	}
+
+	if (!iommu_dir) {
+		unsigned long root_pgtables_ino = 0;
+		unsigned long iommu_dir_ino = pkernfs_allocate_inode(NULL);
+
+		iommu_dir = pkernfs_get_persisted_inode(NULL, iommu_dir_ino);
+		strscpy(iommu_dir->filename, "iommu", PKERNFS_FILENAME_LEN);
+		iommu_dir->flags = PKERNFS_INODE_FLAG_IOMMU_DIR;
+
+		/* Make this the head of the list. */
+		iommu_dir->sibling_ino = pkernfs_get_persisted_inode(NULL, 1)->child_ino;
+		pkernfs_get_persisted_inode(NULL, 1)->child_ino = iommu_dir_ino;
+
+		/* Add a child file for pgtables. */
+		root_pgtables_ino = pkernfs_allocate_inode(NULL);
+		iommu_pgtables = pkernfs_get_persisted_inode(NULL, root_pgtables_ino);
+		strscpy(iommu_pgtables->filename, "root-pgtables", PKERNFS_FILENAME_LEN);
+		iommu_pgtables->sibling_ino = iommu_dir->child_ino;
+		iommu_dir->child_ino = root_pgtables_ino;
+		iommu_pgtables->flags = PKERNFS_INODE_FLAG_IOMMU_ROOT_PGTABLES;
+		iommu_pgtables->mappings_block = pkernfs_alloc_block(NULL);
+		/* TODO: make alloc zero. */
+		memset(pkernfs_addr_for_block(NULL, iommu_pgtables->mappings_block), 0, (2 << 20));
+	} else {
+		inode_idx = iommu_dir->child_ino;
+		while (inode_idx) {
+			if (!strncmp(pkernfs_get_persisted_inode(NULL, inode_idx)->filename,
+						"root-pgtables", PKERNFS_FILENAME_LEN)) {
+				iommu_pgtables = pkernfs_get_persisted_inode(NULL, inode_idx);
+				break;
+			}
+			inode_idx = pkernfs_get_persisted_inode(NULL, inode_idx)->sibling_ino;
+		}
+	}
+
+	/*
+	 * For a pkernfs region block, the "mappings_block" field is still
+	 * just a block index, but that block doesn't actually contain mappings
+	 * it contains the pkernfs_region data
+	 */
+
+	mappings_block_vaddr = (unsigned long *)pkernfs_addr_for_block(NULL,
+		iommu_pgtables->mappings_block);
+	set_bit(0, mappings_block_vaddr);
+	pkernfs_region->vaddr = mappings_block_vaddr;
+	pkernfs_region->paddr = pkernfs_base + (iommu_pgtables->mappings_block * PMD_SIZE);
+	pkernfs_region->bytes = PMD_SIZE;
+
+	dev_set_name(&pkernfs_region->dev, "iommu_root_pgtables");
+	rc = device_register(&pkernfs_region->dev);
+	if (rc)
+		pr_err("device_register failed: %i\n", rc);
+
+	pkernfs_region->pgmap.range.start = pkernfs_base +
+		(iommu_pgtables->mappings_block * PMD_SIZE);
+	pkernfs_region->pgmap.range.end =
+		pkernfs_region->pgmap.range.start + PMD_SIZE - 1;
+	pkernfs_region->pgmap.nr_range = 1;
+	pkernfs_region->pgmap.type = MEMORY_DEVICE_GENERIC;
+	pkernfs_region->vaddr =
+		devm_memremap_pages(&pkernfs_region->dev, &pkernfs_region->pgmap);
+	pkernfs_region->paddr = pkernfs_base +
+		(iommu_pgtables->mappings_block * PMD_SIZE);
+}
+
+void *pkernfs_region_paddr_to_vaddr(struct pkernfs_region *region, unsigned long paddr)
+{
+	if (WARN_ON(paddr >= region->paddr + region->bytes))
+		return NULL;
+	if (WARN_ON(paddr < region->paddr))
+		return NULL;
+	return region->vaddr + (paddr - region->paddr);
+}
diff --git a/fs/pkernfs/pkernfs.c b/fs/pkernfs/pkernfs.c
index f010c2d76c76..2e8c4b0a5807 100644
--- a/fs/pkernfs/pkernfs.c
+++ b/fs/pkernfs/pkernfs.c
@@ -11,12 +11,14 @@ phys_addr_t pkernfs_base, pkernfs_size;
 void *pkernfs_mem;
 static const struct super_operations pkernfs_super_ops = { };
 
-static int pkernfs_fill_super(struct super_block *sb, struct fs_context *fc)
+void pkernfs_init(void)
 {
-	struct inode *inode;
-	struct dentry *dentry;
+	static int inited;
 	struct pkernfs_sb *psb;
 
+	if (inited++)
+		return;
+
 	pkernfs_mem = memremap(pkernfs_base, pkernfs_size, MEMREMAP_WB);
 	psb = (struct pkernfs_sb *) pkernfs_mem;
 
@@ -24,13 +26,21 @@ static int pkernfs_fill_super(struct super_block *sb, struct fs_context *fc)
 		pr_info("pkernfs: Restoring from super block\n");
 	} else {
 		pr_info("pkernfs: Clean super block; initialising\n");
-		pkernfs_initialise_inode_store(sb);
-		pkernfs_zero_allocations(sb);
+		pkernfs_initialise_inode_store(NULL);
+		pkernfs_zero_allocations(NULL);
 		psb->magic_number = PKERNFS_MAGIC_NUMBER;
-		pkernfs_get_persisted_inode(sb, 1)->flags = PKERNFS_INODE_FLAG_DIR;
-		strscpy(pkernfs_get_persisted_inode(sb, 1)->filename, ".", PKERNFS_FILENAME_LEN);
+		pkernfs_get_persisted_inode(NULL, 1)->flags = PKERNFS_INODE_FLAG_DIR;
+		strscpy(pkernfs_get_persisted_inode(NULL, 1)->filename, ".", PKERNFS_FILENAME_LEN);
 		psb->next_free_ino = 2;
 	}
+}
+
+static int pkernfs_fill_super(struct super_block *sb, struct fs_context *fc)
+{
+	struct inode *inode;
+	struct dentry *dentry;
+
+	pkernfs_init();
 
 	sb->s_op = &pkernfs_super_ops;
 
@@ -77,12 +87,9 @@ static struct file_system_type pkernfs_fs_type = {
 	.fs_flags               = FS_USERNS_MOUNT,
 };
 
-static int __init pkernfs_init(void)
+static int __init pkernfs_fs_init(void)
 {
-	int ret;
-
-	ret = register_filesystem(&pkernfs_fs_type);
-	return ret;
+	return register_filesystem(&pkernfs_fs_type);
 }
 
 /**
@@ -97,7 +104,12 @@ static int __init parse_pkernfs_extents(char *p)
 	return 0;
 }
 
+bool pkernfs_enabled(void)
+{
+	return !!pkernfs_base;
+}
+
 early_param("pkernfs", parse_pkernfs_extents);
 
 MODULE_ALIAS_FS("pkernfs");
-module_init(pkernfs_init);
+module_init(pkernfs_fs_init);
diff --git a/fs/pkernfs/pkernfs.h b/fs/pkernfs/pkernfs.h
index 1a7aa783a9be..e1b7ae3fe7f1 100644
--- a/fs/pkernfs/pkernfs.h
+++ b/fs/pkernfs/pkernfs.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 
 #include <linux/fs.h>
+#include <linux/pkernfs.h>
 
 #define PKERNFS_MAGIC_NUMBER 0x706b65726e6673
 #define PKERNFS_FILENAME_LEN 255
@@ -18,6 +19,8 @@ struct pkernfs_sb {
 // If neither of these are set the inode is not in use.
 #define PKERNFS_INODE_FLAG_FILE (1 << 0)
 #define PKERNFS_INODE_FLAG_DIR (1 << 1)
+#define PKERNFS_INODE_FLAG_IOMMU_DIR (1 << 2)
+#define PKERNFS_INODE_FLAG_IOMMU_ROOT_PGTABLES (1 << 3)
 struct pkernfs_inode {
 	int flags;
 	/*
@@ -31,20 +34,24 @@ struct pkernfs_inode {
 	 */
 	unsigned long child_ino;
 	char filename[PKERNFS_FILENAME_LEN];
+	/* Block index for where the mappings live. */
 	int mappings_block;
 	int num_mappings;
 };
 
 void pkernfs_initialise_inode_store(struct super_block *sb);
+void pkernfs_init(void);
 
 void pkernfs_zero_allocations(struct super_block *sb);
 unsigned long pkernfs_alloc_block(struct super_block *sb);
 struct inode *pkernfs_inode_get(struct super_block *sb, unsigned long ino);
 void *pkernfs_addr_for_block(struct super_block *sb, int block_idx);
 
+unsigned long pkernfs_allocate_inode(struct super_block *sb);
 struct pkernfs_inode *pkernfs_get_persisted_inode(struct super_block *sb, int ino);
 
 
 extern const struct file_operations pkernfs_dir_fops;
 extern const struct file_operations pkernfs_file_fops;
 extern const struct inode_operations pkernfs_file_inode_operations;
+extern const struct inode_operations pkernfs_iommu_dir_inode_operations;
diff --git a/include/linux/pkernfs.h b/include/linux/pkernfs.h
new file mode 100644
index 000000000000..0110e4784109
--- /dev/null
+++ b/include/linux/pkernfs.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: MIT */
+
+#ifndef _LINUX_PKERNFS_H
+#define _LINUX_PKERNFS_H
+
+#include <linux/memremap.h>
+#include <linux/device.h>
+
+#ifdef CONFIG_PKERNFS_FS
+extern bool pkernfs_enabled(void);
+#else
+static inline bool pkernfs_enabled(void)
+{
+	return false;
+}
+#endif
+
+/*
+ * This is a light wrapper around the data behind a pkernfs
+ * file. Really it should be a file but the filesystem comes
+ * up too late: IOMMU needs root pgtables before fs is up.
+ */
+struct pkernfs_region {
+	void *vaddr;
+	unsigned long paddr;
+	unsigned long bytes;
+	struct dev_pagemap pgmap;
+	struct device dev;
+};
+
+void pkernfs_alloc_iommu_root_pgtables(struct pkernfs_region *pkernfs_region);
+void pkernfs_alloc_page_from_region(struct pkernfs_region *pkernfs_region,
+				    void **vaddr, unsigned long *paddr);
+void *pkernfs_region_paddr_to_vaddr(struct pkernfs_region *region, unsigned long paddr);
+
+#endif /* _LINUX_PKERNFS_H */
-- 
2.40.1


