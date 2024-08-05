Return-Path: <linux-fsdevel+bounces-24978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B07E6947857
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 11:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE5191C2110D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 09:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3331547C0;
	Mon,  5 Aug 2024 09:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="hQOus4z7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127D5149000;
	Mon,  5 Aug 2024 09:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722850405; cv=none; b=m2M85Encghc2rW9Av8FSlG5fxlEX1lirKS741Y4rIGA6/e6gR1ocHYcjF5jvvCxWxYn6tOl4u7iwgyeMjy/9i1oxCXkBjNxb+GtqUD/uTGmpGYk+/2PcJfiVy+Is4geIdtZBW0aTC9cW1OaCjk3i5tTLT/SoAHhjM2Dot0Dskho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722850405; c=relaxed/simple;
	bh=0bFYaHSa+Vz9oSFvO03FVk4NUWF0Y2/7z97wmzfwMmE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q0x6ZFE9Icu1eBBNhBh3dCQOhpzFL2V9bKiwmB6ANXPWNdPfV7owSe05rW/5mxpgZarLfS0d5dem5PerKIUfCNlfZUfEpUwrQhmis4iDcZg8ATWfQ+/hRpPBTa0BHB27cvO1bQSxUj5P+e9u8DQnGFct2lcBTqVW/QWlWxGI/bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=hQOus4z7; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1722850403; x=1754386403;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CIMC4dBHyqkF/IJtbOCSyvit7T6FcLaiifrH1Oqev8I=;
  b=hQOus4z7PWl70BuQy228FpjLbq2l+y3TMJEdoZWRKOcQpMCXWq/sCM0r
   DdjTFak8h0tyrIASJBFf17/QibRnHZo6pjmQ9qZ2Nlo6+pTucIQufHybN
   3/bDFS0w1hFmWrqp3cbRpabpinAXTkj6j6GcaAPY6X98pZEqfQfmKeqQZ
   M=;
X-IronPort-AV: E=Sophos;i="6.09,264,1716249600"; 
   d="scan'208";a="16963930"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 09:33:20 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.43.254:34036]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.35.73:2525] with esmtp (Farcaster)
 id 9a93516f-30d6-4fa2-8ce9-a895a0a56cc5; Mon, 5 Aug 2024 09:33:18 +0000 (UTC)
X-Farcaster-Flow-ID: 9a93516f-30d6-4fa2-8ce9-a895a0a56cc5
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 5 Aug 2024 09:33:18 +0000
Received: from u5d18b891348c5b.ant.amazon.com (10.146.13.113) by
 EX19D014EUC004.ant.amazon.com (10.252.51.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 5 Aug 2024 09:33:09 +0000
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
Subject: [PATCH 01/10] guestmemfs: Introduce filesystem skeleton
Date: Mon, 5 Aug 2024 11:32:36 +0200
Message-ID: <20240805093245.889357-2-jgowans@amazon.com>
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
X-ClientProxiedBy: EX19D033UWC004.ant.amazon.com (10.13.139.225) To
 EX19D014EUC004.ant.amazon.com (10.252.51.182)

Add an in-memory filesystem: guestmemfs. Memory is donated to guestmemfs
by carving it out of the normal System RAM range with the memmap= cmdline
parameter and then giving that same physical range to guestmemfs with the
guestmemfs= cmdline parameter.

A new filesystem is added; so far it doesn't do much except persist a
super block at the start of the donated memory and allows itself to be
mounted.

A hook to x86 mm init is added to reserve the memory really early on via
memblock allocator. There is probably a better arch-independent place to
do this...

Signed-off-by: James Gowans <jgowans@amazon.com>
---
 arch/x86/mm/init_64.c      |   2 +
 fs/Kconfig                 |   1 +
 fs/Makefile                |   1 +
 fs/guestmemfs/Kconfig      |  11 ++++
 fs/guestmemfs/Makefile     |   6 ++
 fs/guestmemfs/guestmemfs.c | 116 +++++++++++++++++++++++++++++++++++++
 fs/guestmemfs/guestmemfs.h |   9 +++
 include/linux/guestmemfs.h |  16 +++++
 8 files changed, 162 insertions(+)
 create mode 100644 fs/guestmemfs/Kconfig
 create mode 100644 fs/guestmemfs/Makefile
 create mode 100644 fs/guestmemfs/guestmemfs.c
 create mode 100644 fs/guestmemfs/guestmemfs.h
 create mode 100644 include/linux/guestmemfs.h

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 8932ba8f5cdd..39fcf017c90c 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -18,6 +18,7 @@
 #include <linux/mm.h>
 #include <linux/swap.h>
 #include <linux/smp.h>
+#include <linux/guestmemfs.h>
 #include <linux/init.h>
 #include <linux/initrd.h>
 #include <linux/kexec.h>
@@ -1331,6 +1332,7 @@ static void __init preallocate_vmalloc_pages(void)
 
 void __init mem_init(void)
 {
+	guestmemfs_reserve_mem();
 	pci_iommu_alloc();
 
 	/* clear_bss() already clear the empty_zero_page */
diff --git a/fs/Kconfig b/fs/Kconfig
index a46b0cbc4d8f..727359901da8 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -321,6 +321,7 @@ source "fs/befs/Kconfig"
 source "fs/bfs/Kconfig"
 source "fs/efs/Kconfig"
 source "fs/jffs2/Kconfig"
+source "fs/guestmemfs/Kconfig"
 # UBIFS File system configuration
 source "fs/ubifs/Kconfig"
 source "fs/cramfs/Kconfig"
diff --git a/fs/Makefile b/fs/Makefile
index 6ecc9b0a53f2..044524b17d63 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -129,3 +129,4 @@ obj-$(CONFIG_EFIVAR_FS)		+= efivarfs/
 obj-$(CONFIG_EROFS_FS)		+= erofs/
 obj-$(CONFIG_VBOXSF_FS)		+= vboxsf/
 obj-$(CONFIG_ZONEFS_FS)		+= zonefs/
+obj-$(CONFIG_GUESTMEMFS_FS)	+= guestmemfs/
diff --git a/fs/guestmemfs/Kconfig b/fs/guestmemfs/Kconfig
new file mode 100644
index 000000000000..d87fca4822cb
--- /dev/null
+++ b/fs/guestmemfs/Kconfig
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config GUESTMEMFS_FS
+	bool "Persistent Guest memory filesystem (guestmemfs)"
+	help
+	  An in-memory filesystem on top of reserved memory specified via
+	  guestmemfs= cmdline argument.  Used for storing kernel state and
+	  userspace memory which is preserved across kexec to support
+	  live update of a hypervisor when running guest virtual machines.
+	  Select this if you need the ability to persist memory for guest VMs
+	  across kexec to do live update.
diff --git a/fs/guestmemfs/Makefile b/fs/guestmemfs/Makefile
new file mode 100644
index 000000000000..6dc820a9d4fe
--- /dev/null
+++ b/fs/guestmemfs/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for persistent kernel filesystem
+#
+
+obj-y += guestmemfs.o
diff --git a/fs/guestmemfs/guestmemfs.c b/fs/guestmemfs/guestmemfs.c
new file mode 100644
index 000000000000..3aaada1b8df6
--- /dev/null
+++ b/fs/guestmemfs/guestmemfs.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "guestmemfs.h"
+#include <linux/dcache.h>
+#include <linux/fs.h>
+#include <linux/module.h>
+#include <linux/fs_context.h>
+#include <linux/io.h>
+#include <linux/memblock.h>
+#include <linux/statfs.h>
+
+static phys_addr_t guestmemfs_base, guestmemfs_size;
+struct guestmemfs_sb *psb;
+
+static int statfs(struct dentry *root, struct kstatfs *buf)
+{
+	simple_statfs(root, buf);
+	buf->f_bsize = PMD_SIZE;
+	buf->f_blocks = guestmemfs_size / PMD_SIZE;
+	buf->f_bfree = buf->f_bavail = buf->f_blocks;
+	return 0;
+}
+
+static const struct super_operations guestmemfs_super_ops = {
+	.statfs = statfs,
+};
+
+static int guestmemfs_fill_super(struct super_block *sb, struct fs_context *fc)
+{
+	struct inode *inode;
+	struct dentry *dentry;
+
+	psb = kzalloc(sizeof(*psb), GFP_KERNEL);
+	/*
+	 * Keep a reference to the persistent super block in the
+	 * ephemeral super block.
+	 */
+	sb->s_fs_info = psb;
+	sb->s_op = &guestmemfs_super_ops;
+
+	inode = new_inode(sb);
+	if (!inode)
+		return -ENOMEM;
+
+	inode->i_ino = 1;
+	inode->i_mode = S_IFDIR;
+	inode->i_op = &simple_dir_inode_operations;
+	inode->i_fop = &simple_dir_operations;
+	simple_inode_init_ts(inode);
+	/* directory inodes start off with i_nlink == 2 (for "." entry) */
+	inc_nlink(inode);
+
+	dentry = d_make_root(inode);
+	if (!dentry)
+		return -ENOMEM;
+	sb->s_root = dentry;
+
+	return 0;
+}
+
+static int guestmemfs_get_tree(struct fs_context *fc)
+{
+	return get_tree_nodev(fc, guestmemfs_fill_super);
+}
+
+static const struct fs_context_operations guestmemfs_context_ops = {
+	.get_tree	= guestmemfs_get_tree,
+};
+
+static int guestmemfs_init_fs_context(struct fs_context *const fc)
+{
+	fc->ops = &guestmemfs_context_ops;
+	return 0;
+}
+
+static struct file_system_type guestmemfs_fs_type = {
+	.owner                  = THIS_MODULE,
+	.name                   = "guestmemfs",
+	.init_fs_context        = guestmemfs_init_fs_context,
+	.kill_sb                = kill_litter_super,
+	.fs_flags               = FS_USERNS_MOUNT,
+};
+
+static int __init guestmemfs_init(void)
+{
+	int ret;
+
+	ret = register_filesystem(&guestmemfs_fs_type);
+	return ret;
+}
+
+/**
+ * Format: guestmemfs=<size>:<base>
+ * Just like: memmap=nn[KMG]!ss[KMG]
+ */
+static int __init parse_guestmemfs_extents(char *p)
+{
+	guestmemfs_size = memparse(p, &p);
+	return 0;
+}
+
+early_param("guestmemfs", parse_guestmemfs_extents);
+
+void __init guestmemfs_reserve_mem(void)
+{
+	guestmemfs_base = memblock_phys_alloc(guestmemfs_size, 4 << 10);
+	if (guestmemfs_base) {
+		memblock_reserved_mark_noinit(guestmemfs_base, guestmemfs_size);
+		memblock_mark_nomap(guestmemfs_base, guestmemfs_size);
+	} else {
+		pr_warn("Failed to alloc %llu bytes for guestmemfs\n", guestmemfs_size);
+	}
+}
+
+MODULE_ALIAS_FS("guestmemfs");
+module_init(guestmemfs_init);
diff --git a/fs/guestmemfs/guestmemfs.h b/fs/guestmemfs/guestmemfs.h
new file mode 100644
index 000000000000..37d8cf630e0a
--- /dev/null
+++ b/fs/guestmemfs/guestmemfs.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#define pr_fmt(fmt) "guestmemfs: " KBUILD_MODNAME ": " fmt
+
+#include <linux/guestmemfs.h>
+
+struct guestmemfs_sb {
+    /* Will be populated soon... */
+};
diff --git a/include/linux/guestmemfs.h b/include/linux/guestmemfs.h
new file mode 100644
index 000000000000..60e769c8e533
--- /dev/null
+++ b/include/linux/guestmemfs.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: MIT */
+
+#ifndef _LINUX_GUESTMEMFS_H
+#define _LINUX_GUESTMEMFS_H
+
+/*
+ * Carves out chunks of memory from memblocks for guestmemfs.
+ * Must be called in early boot before memblocks are freed.
+ */
+# ifdef CONFIG_GUESTMEMFS_FS
+void guestmemfs_reserve_mem(void);
+#else
+void guestmemfs_reserve_mem(void) { }
+#endif
+
+#endif
-- 
2.34.1


