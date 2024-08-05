Return-Path: <linux-fsdevel+bounces-24984-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10777947875
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 11:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 330081C211D0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 09:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43541547ED;
	Mon,  5 Aug 2024 09:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="l0N4dnJ9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2403815442A;
	Mon,  5 Aug 2024 09:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722850526; cv=none; b=R22y+dIdNG/ZVxpWnuLP6RzOyWOYUkjhrxSs0wQrr2A7y6NUz3m0rzoKuYMSz5QjFOyF/mnDINTcqgqiZkamr75MN7zzjcDSaormKPbhS2iABLhHofkceeJHdO+d4k9e9IPz1t9I/pDaT7arGpvR9VKUHdoJJ+TcZ+41SBn1BZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722850526; c=relaxed/simple;
	bh=NWcdHOT6meDsgvRcXp1Ku0orGgpxznWQs9iKhksWhQM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MEbj1KoJ7gIy7EuXzgfkgcIMdGsBORTU9EiyXnhwgQz+UzNLT+9tC2hX4jkJ7SVvlw2hSwMs0XWD/DG7jjEPnT4Kn/tHPMNEvDiXEvMhDtH1DE8NjxDMrQbXqT81dCmNurbFMj1y9OUfaenj2zrvviI8v+HaEv7ziocWDYUTKMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=l0N4dnJ9; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1722850524; x=1754386524;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GwcyuHUonPineq63SNtpYz+107twfbb1IfXA3IZYCMA=;
  b=l0N4dnJ9A+R7uRnHMR5icwiwQLh0cAexhbGXt4mlcADbD2ueg0LDFuSY
   FZyUv3jjNy6obk/7pwD44imNYq0gQnELfHqNbOL92oJmeMxUXIkRAZnRb
   qLdahAPa0AFjkm54bQMPbb7wvAhOam8CQS5BN2Z+E5R1bOMbsYtAC7c4A
   Y=;
X-IronPort-AV: E=Sophos;i="6.09,264,1716249600"; 
   d="scan'208";a="419323041"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 09:35:20 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.17.79:14005]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.35.73:2525] with esmtp (Farcaster)
 id e982917a-a97c-45f2-b4e4-5a00217a4f1e; Mon, 5 Aug 2024 09:35:18 +0000 (UTC)
X-Farcaster-Flow-ID: e982917a-a97c-45f2-b4e4-5a00217a4f1e
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 5 Aug 2024 09:35:18 +0000
Received: from u5d18b891348c5b.ant.amazon.com (10.146.13.113) by
 EX19D014EUC004.ant.amazon.com (10.252.51.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 5 Aug 2024 09:35:08 +0000
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
Subject: [PATCH 07/10] guestmemfs: Persist filesystem metadata via KHO
Date: Mon, 5 Aug 2024 11:32:42 +0200
Message-ID: <20240805093245.889357-8-jgowans@amazon.com>
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
X-ClientProxiedBy: EX19D046UWB002.ant.amazon.com (10.13.139.181) To
 EX19D014EUC004.ant.amazon.com (10.252.51.182)

Filesystem metadata consists of: physical memory extents, superblock,
inodes block and allocation bitmap. Here serialisation and
deserialisation of all of these is done via the KHO framework.

A serialisation callback is added which is run when KHO activate is
triggered. This creates the device tree blob for the metadata and marks
the memory as persistent via struct kho_mem(s).

When the filesystem is mounted it attempts to re-hydrate metadata from
KHO. Only if this fails (first boot, for example) then it allocates
fresh metadata pages.

The privatet data struct is switched from holding a reference to the
persistent superblock to now referencing the regular struct super_block.
This is necessary for the serialisation code. Better would be to be able
to define callback private data, if that were possible.

Signed-off-by: James Gowans <jgowans@amazon.com>
---
 fs/guestmemfs/Makefile     |   2 +
 fs/guestmemfs/guestmemfs.c |  72 ++++++---
 fs/guestmemfs/guestmemfs.h |   8 +
 fs/guestmemfs/serialise.c  | 296 +++++++++++++++++++++++++++++++++++++
 4 files changed, 355 insertions(+), 23 deletions(-)
 create mode 100644 fs/guestmemfs/serialise.c

diff --git a/fs/guestmemfs/Makefile b/fs/guestmemfs/Makefile
index e93e43ba274b..8b95cac34564 100644
--- a/fs/guestmemfs/Makefile
+++ b/fs/guestmemfs/Makefile
@@ -4,3 +4,5 @@
 #
 
 obj-y += guestmemfs.o inode.o dir.o allocator.o file.o
+
+obj-$(CONFIG_KEXEC_KHO) += serialise.o
diff --git a/fs/guestmemfs/guestmemfs.c b/fs/guestmemfs/guestmemfs.c
index 38f20ad25286..cf47e5100504 100644
--- a/fs/guestmemfs/guestmemfs.c
+++ b/fs/guestmemfs/guestmemfs.c
@@ -3,6 +3,7 @@
 #include "guestmemfs.h"
 #include <linux/dcache.h>
 #include <linux/fs.h>
+#include <linux/kexec.h>
 #include <linux/module.h>
 #include <linux/fs_context.h>
 #include <linux/io.h>
@@ -10,7 +11,7 @@
 #include <linux/statfs.h>
 
 phys_addr_t guestmemfs_base, guestmemfs_size;
-struct guestmemfs_sb *psb;
+struct super_block *guestmemfs_sb;
 
 static int statfs(struct dentry *root, struct kstatfs *buf)
 {
@@ -33,26 +34,39 @@ static int guestmemfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	struct inode *inode;
 	struct dentry *dentry;
 
-	psb = kzalloc(sizeof(*psb), GFP_KERNEL);
-	psb->inodes = kzalloc(2 << 20, GFP_KERNEL);
-	if (!psb->inodes)
-		return -ENOMEM;
-	psb->allocator_bitmap = kzalloc(1 << 20, GFP_KERNEL);
-	if (!psb->allocator_bitmap)
-		return -ENOMEM;
-
 	/*
 	 * Keep a reference to the persistent super block in the
 	 * ephemeral super block.
 	 */
-	sb->s_fs_info = psb;
-	spin_lock_init(&psb->allocation_lock);
-	guestmemfs_initialise_inode_store(sb);
-	guestmemfs_zero_allocations(sb);
-	guestmemfs_get_persisted_inode(sb, 1)->flags = GUESTMEMFS_INODE_FLAG_DIR;
-	strscpy(guestmemfs_get_persisted_inode(sb, 1)->filename, ".",
-			GUESTMEMFS_FILENAME_LEN);
-	psb->next_free_ino = 2;
+	sb->s_fs_info = guestmemfs_restore_from_kho();
+
+	if (GUESTMEMFS_PSB(sb)) {
+		pr_info("Restored super block from KHO\n");
+	} else {
+		struct guestmemfs_sb *psb;
+
+		pr_info("Did not restore from KHO - allocating free\n");
+		psb = kzalloc(sizeof(*psb), GFP_KERNEL);
+		psb->inodes = kzalloc(2 << 20, GFP_KERNEL);
+		if (!psb->inodes)
+			return -ENOMEM;
+		psb->allocator_bitmap = kzalloc(1 << 20, GFP_KERNEL);
+		if (!psb->allocator_bitmap)
+			return -ENOMEM;
+		sb->s_fs_info = psb;
+		spin_lock_init(&psb->allocation_lock);
+		guestmemfs_initialise_inode_store(sb);
+		guestmemfs_zero_allocations(sb);
+		guestmemfs_get_persisted_inode(sb, 1)->flags = GUESTMEMFS_INODE_FLAG_DIR;
+		strscpy(guestmemfs_get_persisted_inode(sb, 1)->filename, ".",
+				GUESTMEMFS_FILENAME_LEN);
+		GUESTMEMFS_PSB(sb)->next_free_ino = 2;
+	}
+	/*
+	 * Keep a reference to this sb; the serialise callback needs it
+	 * and has no oher way to get it.
+	 */
+	guestmemfs_sb = sb;
 
 	sb->s_op = &guestmemfs_super_ops;
 
@@ -98,11 +112,18 @@ static struct file_system_type guestmemfs_fs_type = {
 	.fs_flags               = FS_USERNS_MOUNT,
 };
 
+
+static struct notifier_block trace_kho_nb = {
+	.notifier_call = guestmemfs_serialise_to_kho,
+};
+
 static int __init guestmemfs_init(void)
 {
 	int ret;
 
 	ret = register_filesystem(&guestmemfs_fs_type);
+	if (IS_ENABLED(CONFIG_FTRACE_KHO))
+		register_kho_notifier(&trace_kho_nb);
 	return ret;
 }
 
@@ -120,13 +141,18 @@ early_param("guestmemfs", parse_guestmemfs_extents);
 
 void __init guestmemfs_reserve_mem(void)
 {
-	guestmemfs_base = memblock_phys_alloc(guestmemfs_size, 4 << 10);
-	if (guestmemfs_base) {
-		memblock_reserved_mark_noinit(guestmemfs_base, guestmemfs_size);
-		memblock_mark_nomap(guestmemfs_base, guestmemfs_size);
-	} else {
-		pr_warn("Failed to alloc %llu bytes for guestmemfs\n", guestmemfs_size);
+	if (guestmemfs_size) {
+		guestmemfs_base = memblock_phys_alloc(guestmemfs_size, 4 << 10);
+
+		if (guestmemfs_base) {
+			memblock_reserved_mark_noinit(guestmemfs_base, guestmemfs_size);
+			memblock_mark_nomap(guestmemfs_base, guestmemfs_size);
+			pr_debug("guestmemfs reserved base=%llu from memblocks\n", guestmemfs_base);
+		} else {
+			pr_warn("Failed to alloc %llu bytes for guestmemfs\n", guestmemfs_size);
+		}
 	}
+
 }
 
 MODULE_ALIAS_FS("guestmemfs");
diff --git a/fs/guestmemfs/guestmemfs.h b/fs/guestmemfs/guestmemfs.h
index 0f2788ce740e..263d995b75ed 100644
--- a/fs/guestmemfs/guestmemfs.h
+++ b/fs/guestmemfs/guestmemfs.h
@@ -10,11 +10,14 @@
 
 /* Units of bytes */
 extern phys_addr_t guestmemfs_base, guestmemfs_size;
+extern struct super_block *guestmemfs_sb;
 
 struct guestmemfs_sb {
 	/* Inode number */
 	unsigned long next_free_ino;
 	unsigned long allocated_inodes;
+
+	/* Ephemeral fields - must be updated on deserialise */
 	struct guestmemfs_inode *inodes;
 	void *allocator_bitmap;
 	spinlock_t allocation_lock;
@@ -46,6 +49,11 @@ long guestmemfs_alloc_block(struct super_block *sb);
 struct inode *guestmemfs_inode_get(struct super_block *sb, unsigned long ino);
 struct guestmemfs_inode *guestmemfs_get_persisted_inode(struct super_block *sb, int ino);
 
+int guestmemfs_serialise_to_kho(struct notifier_block *self,
+			      unsigned long cmd,
+			      void *v);
+struct guestmemfs_sb *guestmemfs_restore_from_kho(void);
+
 extern const struct file_operations guestmemfs_dir_fops;
 extern const struct file_operations guestmemfs_file_fops;
 extern const struct inode_operations guestmemfs_file_inode_operations;
diff --git a/fs/guestmemfs/serialise.c b/fs/guestmemfs/serialise.c
new file mode 100644
index 000000000000..eb70d496a3eb
--- /dev/null
+++ b/fs/guestmemfs/serialise.c
@@ -0,0 +1,296 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "guestmemfs.h"
+#include <linux/kexec.h>
+#include <linux/memblock.h>
+
+/*
+ * Responsible for serialisation and deserialisation of filesystem metadata
+ * to and from KHO to survive kexec. The deserialisation logic needs to mirror
+ * serialisation, so putting them in the same file.
+ *
+ * The format of the device tree structure is:
+ *
+ * /guestmemfs
+ *   compatible = "guestmemfs-v1"
+ *   fs_mem {
+ *     mem = [ ... ]
+ *   };
+ *   superblock {
+ *     mem = [
+ *       persistent super block,
+ *       inodes,
+ *       allocator_bitmap,
+ *   };
+ *   mappings_block {
+ *     mem = [ ... ]
+ *   };
+ *   // For every mappings_block mem, which inode it belongs to.
+ *   mappings_to_inode {
+ *     num_inodes,
+ *     mem = [ ... ],
+ *   }
+ */
+
+static int serialise_superblock(struct super_block *sb, void *fdt)
+{
+	struct kho_mem mem[3];
+	int err = 0;
+	struct guestmemfs_sb *psb = sb->s_fs_info;
+
+	err |= fdt_begin_node(fdt, "superblock");
+
+	mem[0].addr = virt_to_phys(psb);
+	mem[0].len = sizeof(*psb);
+
+	mem[1].addr = virt_to_phys(psb->inodes);
+	mem[1].len = 2 << 20;
+
+	mem[2].addr = virt_to_phys(psb->allocator_bitmap);
+	mem[2].len = 1 << 20;
+
+	err |= fdt_property(fdt, "mem", &mem, sizeof(mem));
+	err |= fdt_end_node(fdt);
+
+	return err;
+}
+
+static int serialise_mappings_blocks(struct super_block *sb, void *fdt)
+{
+	struct kho_mem *mappings_mems;
+	struct kho_mem mappings_to_inode_mem;
+	struct guestmemfs_sb *psb = sb->s_fs_info;
+	int inode_idx;
+	size_t num_inodes = PMD_SIZE / sizeof(struct guestmemfs_inode);
+	struct guestmemfs_inode *inode;
+	int err = 0;
+	int *mappings_to_inode;
+	int mappings_to_inode_idx = 0;
+
+	mappings_to_inode = kzalloc(PAGE_SIZE, GFP_KERNEL);
+
+	mappings_mems = kcalloc(psb->allocated_inodes, sizeof(struct kho_mem), GFP_KERNEL);
+
+	for (inode_idx = 1; inode_idx < num_inodes; ++inode_idx) {
+		inode = guestmemfs_get_persisted_inode(sb, inode_idx);
+		if (inode->flags & GUESTMEMFS_INODE_FLAG_FILE) {
+			mappings_mems[mappings_to_inode_idx].addr = virt_to_phys(inode->mappings);
+			mappings_mems[mappings_to_inode_idx].len = PAGE_SIZE;
+			mappings_to_inode[mappings_to_inode_idx] = inode_idx;
+			mappings_to_inode_idx++;
+		}
+	}
+
+	err |= fdt_begin_node(fdt, "mappings_blocks");
+	err |= fdt_property(fdt, "mem", mappings_mems,
+		sizeof(struct kho_mem) * mappings_to_inode_idx);
+	err |= fdt_end_node(fdt);
+
+
+	err |= fdt_begin_node(fdt, "mappings_to_inode");
+	mappings_to_inode_mem.addr = virt_to_phys(mappings_to_inode);
+	mappings_to_inode_mem.len = PAGE_SIZE;
+	err |= fdt_property(fdt, "mem", &mappings_to_inode_mem,
+			sizeof(mappings_to_inode_mem));
+	err |= fdt_property(fdt, "num_inodes", &psb->allocated_inodes,
+			sizeof(psb->allocated_inodes));
+
+	err |= fdt_end_node(fdt);
+
+	return err;
+}
+
+int guestmemfs_serialise_to_kho(struct notifier_block *self,
+			      unsigned long cmd,
+			      void *v)
+{
+	static const char compatible[] = "guestmemfs-v1";
+	struct kho_mem mem;
+	void *fdt = v;
+	int err = 0;
+
+	switch (cmd) {
+	case KEXEC_KHO_ABORT:
+		/* No rollback action needed. */
+		return NOTIFY_DONE;
+	case KEXEC_KHO_DUMP:
+		/* Handled below */
+		break;
+	default:
+		return NOTIFY_BAD;
+	}
+
+	err |= fdt_begin_node(fdt, "guestmemfs");
+	err |= fdt_property(fdt, "compatible", compatible, sizeof(compatible));
+
+	err |= fdt_begin_node(fdt, "fs_mem");
+	mem.addr = guestmemfs_base | KHO_MEM_ADDR_FLAG_NOINIT;
+	mem.len = guestmemfs_size;
+	err |= fdt_property(fdt, "mem", &mem, sizeof(mem));
+	err |= fdt_end_node(fdt);
+
+	err |= serialise_superblock(guestmemfs_sb, fdt);
+	err |= serialise_mappings_blocks(guestmemfs_sb, fdt);
+
+	err |= fdt_end_node(fdt);
+
+	pr_info("Serialised extends [0x%llx + 0x%llx] via KHO: %i\n",
+			guestmemfs_base, guestmemfs_size, err);
+
+	return err;
+}
+
+static struct guestmemfs_sb *deserialise_superblock(const void *fdt, int root_off)
+{
+	const struct kho_mem *mem;
+	int mem_len;
+	struct guestmemfs_sb *old_sb;
+	int off;
+
+	off = fdt_subnode_offset(fdt, root_off, "superblock");
+	mem = fdt_getprop(fdt, off, "mem", &mem_len);
+
+	if (mem_len != 3 * sizeof(struct kho_mem)) {
+		pr_err("Incorrect mem_len; got %i\n", mem_len);
+		return NULL;
+	}
+
+	old_sb = kho_claim_mem(mem);
+	old_sb->inodes = kho_claim_mem(mem + 1);
+	old_sb->allocator_bitmap = kho_claim_mem(mem + 2);
+
+	return old_sb;
+}
+
+static int deserialise_mappings_blocks(const void *fdt, int root_off,
+		struct guestmemfs_sb *sb)
+{
+	int off;
+	int len = 0;
+	const unsigned long *num_inodes;
+	const struct kho_mem *mappings_to_inode_mem;
+	int *mappings_to_inode;
+	int mappings_block;
+	const struct kho_mem *mappings_blocks_mems;
+
+	/*
+	 * Array of struct kho_mem - one for each persisted mappings
+	 * blocks.
+	 */
+	off = fdt_subnode_offset(fdt, root_off, "mappings_blocks");
+	mappings_blocks_mems = fdt_getprop(fdt, off, "mem", &len);
+
+	/*
+	 * Array specifying which inode a specific index into the
+	 * mappings_blocks kho_mem array corresponds to. num_inodes
+	 * indicates the size of the array which is the number of mappings
+	 * blocks which need to be restored.
+	 */
+	off = fdt_subnode_offset(fdt, root_off, "mappings_to_inode");
+	if (off < 0) {
+		pr_warn("No fs_mem available in KHO\n");
+		return -EINVAL;
+	}
+	num_inodes = fdt_getprop(fdt, off, "num_inodes", &len);
+	if (len != sizeof(num_inodes)) {
+		pr_warn("Invalid num_inodes len: %i\n", len);
+		return -EINVAL;
+	}
+	mappings_to_inode_mem = fdt_getprop(fdt, off, "mem", &len);
+	if (len != sizeof(*mappings_to_inode_mem)) {
+		pr_warn("Invalid mappings_to_inode_mem len: %i\n", len);
+		return -EINVAL;
+	}
+	mappings_to_inode = kho_claim_mem(mappings_to_inode_mem);
+
+	/*
+	 * Re-assigned the mappings block to the inodes. Indexes into
+	 * mappings_to_inode specifies which inode to assign each mappings
+	 * block to.
+	 */
+	for (mappings_block = 0; mappings_block < *num_inodes; ++mappings_block) {
+		int inode = mappings_to_inode[mappings_block];
+
+		sb->inodes[inode].mappings = kho_claim_mem(&mappings_blocks_mems[mappings_block]);
+	}
+
+	return 0;
+}
+
+static int deserialise_fs_mem(const void *fdt, int root_off)
+{
+	int err;
+	/* Offset into the KHO DT */
+	int off;
+	int len = 0;
+	const struct kho_mem *mem;
+
+	off = fdt_subnode_offset(fdt, root_off, "fs_mem");
+	if (off < 0) {
+		pr_info("No fs_mem available in KHO\n");
+		return -EINVAL;
+	}
+
+	mem = fdt_getprop(fdt, off, "mem", &len);
+	if (mem && len == sizeof(*mem)) {
+		guestmemfs_base = mem->addr & ~KHO_MEM_ADDR_FLAG_MASK;
+		guestmemfs_size = mem->len;
+	} else {
+		pr_err("KHO did not contain a guestmemfs base address and size\n");
+		return -EINVAL;
+	}
+
+	pr_info("Reclaimed [%llx + %llx] via KHO\n", guestmemfs_base, guestmemfs_size);
+	if (err) {
+		pr_err("Unable to reserve [0x%llx + 0x%llx] from memblock: %i\n",
+				guestmemfs_base, guestmemfs_size, err);
+		return err;
+	}
+	return 0;
+}
+struct guestmemfs_sb *guestmemfs_restore_from_kho(void)
+{
+	const void *fdt = kho_get_fdt();
+	struct guestmemfs_sb *old_sb;
+	int err;
+	/* Offset into the KHO DT */
+	int off;
+
+	if (!fdt) {
+		pr_err("Unable to get KHO DT after KHO boot?\n");
+		return NULL;
+	}
+
+	off = fdt_path_offset(fdt, "/guestmemfs");
+	pr_info("guestmemfs offset: %i\n", off);
+
+	if (!off) {
+		pr_info("No guestmemfs data available in KHO\n");
+		return NULL;
+	}
+	err = fdt_node_check_compatible(fdt, off, "guestmemfs-v1");
+	if (err) {
+		pr_err("Existing KHO superblock format is not compatible with this kernel\n");
+		return NULL;
+	}
+
+	old_sb = deserialise_superblock(fdt, off);
+	if (!old_sb) {
+		pr_warn("Failed to restore superblock\n");
+		return NULL;
+	}
+
+	err = deserialise_mappings_blocks(fdt, off, old_sb);
+	if (err) {
+		pr_warn("Failed to restore mappings blocks\n");
+		return NULL;
+	}
+
+	err = deserialise_fs_mem(fdt, off);
+	if (err) {
+		pr_warn("Failed to restore filesystem memory extents\n");
+		return NULL;
+	}
+
+	return old_sb;
+}
-- 
2.34.1


