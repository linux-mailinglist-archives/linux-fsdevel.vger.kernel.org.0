Return-Path: <linux-fsdevel+bounces-10271-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8073484997C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 13:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E95A81F21EEE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 12:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517961B80F;
	Mon,  5 Feb 2024 12:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="b3mmLUM8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87BF1AACF;
	Mon,  5 Feb 2024 12:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707134549; cv=none; b=tN9N11+/bs67/kIY+g53EPbcEEeflSkH1zs3kkYKw50DgqCZk+alRRPFTW+KAOGdhlMgRqs+u9xj9iM0/46tdoApKMqW2dN4/sDwtgNajAeXc7fLFkvkVKUpKOc25Rj4bSU2fpCHJrEE1Q/ORMxkQfMNFV2pzcG2ZgxKpXfn0Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707134549; c=relaxed/simple;
	bh=RV+Ytw8ThVExKlkqCCz/3DDoByyrvDLhxUnYt76lnO8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HTg/jKuyBiCsP4PFdL2Phu3DBq0wFvOGyBG5mqOSiHR07vZxr3l6B9+KWf3M8Wf2GaJrdmZCtnu38Lb2dgWoLk4zWyuWj9iEy8jdm9mWEDGjBGnmLtwsd7c7Jwp/DVcTgpNaY9rEheBFHYx2Gaj2C5M/+HVfXKmeplAtySGOWaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=b3mmLUM8; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1707134549; x=1738670549;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ulQJ3D4Me8ScxlcztMMDIgEvnR/mGPMynfspToLkF2M=;
  b=b3mmLUM8uxUdbQnSkV2tBea6B5synisslurnQMLhT1Y48dqsPRoeoRTI
   6zWc/GGxW9avbDPVCdKxH58P9Dr0k5iHKpkCzx+wqjbVJk03MVe6yB7e7
   EYdCy2Rd/TN/Ur0HgkAZqbavOeRmsOHJuvj7iR+0Yjh9S/ByJIIE4Kmac
   g=;
X-IronPort-AV: E=Sophos;i="6.05,245,1701129600"; 
   d="scan'208";a="702145833"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 12:02:22 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.43.254:59802]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.28.192:2525] with esmtp (Farcaster)
 id c85ecf83-e3a4-4c42-963b-1a5c7099c0b7; Mon, 5 Feb 2024 12:02:20 +0000 (UTC)
X-Farcaster-Flow-ID: c85ecf83-e3a4-4c42-963b-1a5c7099c0b7
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 5 Feb 2024 12:02:20 +0000
Received: from dev-dsk-jgowans-1a-a3faec1f.eu-west-1.amazon.com
 (172.19.112.191) by EX19D014EUC004.ant.amazon.com (10.252.51.182) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 5 Feb
 2024 12:02:14 +0000
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
Subject: [RFC 01/18] pkernfs: Introduce filesystem skeleton
Date: Mon, 5 Feb 2024 12:01:46 +0000
Message-ID: <20240205120203.60312-2-jgowans@amazon.com>
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
X-ClientProxiedBy: EX19D045UWA002.ant.amazon.com (10.13.139.12) To
 EX19D014EUC004.ant.amazon.com (10.252.51.182)

Add an in-memory filesystem: pkernfs. Memory is donated to pkernfs by
carving it out of the normal System RAM range with the memmap= cmdline
parameter and then giving that same physical range to pkernfs with the
pkernfs= cmdline parameter.

A new filesystem is added; so far it doesn't do much except persist a
super block at the start of the donated memory and allows itself to be
mounted.
---
 fs/Kconfig           |  1 +
 fs/Makefile          |  3 ++
 fs/pkernfs/Kconfig   |  9 ++++
 fs/pkernfs/Makefile  |  6 +++
 fs/pkernfs/pkernfs.c | 99 ++++++++++++++++++++++++++++++++++++++++++++
 fs/pkernfs/pkernfs.h |  6 +++
 6 files changed, 124 insertions(+)
 create mode 100644 fs/pkernfs/Kconfig
 create mode 100644 fs/pkernfs/Makefile
 create mode 100644 fs/pkernfs/pkernfs.c
 create mode 100644 fs/pkernfs/pkernfs.h

diff --git a/fs/Kconfig b/fs/Kconfig
index aa7e03cc1941..33a9770ae657 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -331,6 +331,7 @@ source "fs/sysv/Kconfig"
 source "fs/ufs/Kconfig"
 source "fs/erofs/Kconfig"
 source "fs/vboxsf/Kconfig"
+source "fs/pkernfs/Kconfig"
 
 endif # MISC_FILESYSTEMS
 
diff --git a/fs/Makefile b/fs/Makefile
index f9541f40be4e..1af35b494b5d 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -19,6 +19,9 @@ obj-y :=	open.o read_write.o file_table.o super.o \
 
 obj-$(CONFIG_BUFFER_HEAD)	+= buffer.o mpage.o
 obj-$(CONFIG_PROC_FS)		+= proc_namespace.o
+
+obj-y += pkernfs/
+
 obj-$(CONFIG_LEGACY_DIRECT_IO)	+= direct-io.o
 obj-y				+= notify/
 obj-$(CONFIG_EPOLL)		+= eventpoll.o
diff --git a/fs/pkernfs/Kconfig b/fs/pkernfs/Kconfig
new file mode 100644
index 000000000000..59621a1d9aef
--- /dev/null
+++ b/fs/pkernfs/Kconfig
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config PKERNFS_FS
+	bool "Persistent Kernel filesystem (pkernfs)"
+	help
+	  An in-memory filesystem on top of reserved memory specified via
+	  pkernfs= cmdline argument.  Used for storing kernel state and
+	  userspace memory which is preserved across kexec to support
+	  live update.
diff --git a/fs/pkernfs/Makefile b/fs/pkernfs/Makefile
new file mode 100644
index 000000000000..17258cb77f58
--- /dev/null
+++ b/fs/pkernfs/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for persistent kernel filesystem
+#
+
+obj-$(CONFIG_PKERNFS_FS) += pkernfs.o
diff --git a/fs/pkernfs/pkernfs.c b/fs/pkernfs/pkernfs.c
new file mode 100644
index 000000000000..4c476ddc35b6
--- /dev/null
+++ b/fs/pkernfs/pkernfs.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "pkernfs.h"
+#include <linux/dcache.h>
+#include <linux/fs.h>
+#include <linux/module.h>
+#include <linux/fs_context.h>
+#include <linux/io.h>
+
+static phys_addr_t pkernfs_base, pkernfs_size;
+static void *pkernfs_mem;
+static const struct super_operations pkernfs_super_ops = { };
+
+static int pkernfs_fill_super(struct super_block *sb, struct fs_context *fc)
+{
+	struct inode *inode;
+	struct dentry *dentry;
+	struct pkernfs_sb *psb;
+
+	pkernfs_mem = memremap(pkernfs_base, pkernfs_size, MEMREMAP_WB);
+	psb = (struct pkernfs_sb *) pkernfs_mem;
+
+	if (psb->magic_number == PKERNFS_MAGIC_NUMBER) {
+		pr_info("pkernfs: Restoring from super block\n");
+	} else {
+		pr_info("pkernfs: Clean super block; initialising\n");
+		psb->magic_number = PKERNFS_MAGIC_NUMBER;
+	}
+
+	sb->s_op = &pkernfs_super_ops;
+
+	inode = new_inode(sb);
+	if (!inode)
+		return -ENOMEM;
+
+	inode->i_ino = 1;
+	inode->i_mode = S_IFDIR;
+	inode->i_op = &simple_dir_inode_operations;
+	inode->i_fop = &simple_dir_operations;
+	inode->i_atime = inode->i_mtime = current_time(inode);
+	inode_set_ctime_current(inode);
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
+static int pkernfs_get_tree(struct fs_context *fc)
+{
+	return get_tree_nodev(fc, pkernfs_fill_super);
+}
+
+static const struct fs_context_operations pkernfs_context_ops = {
+	.get_tree	= pkernfs_get_tree,
+};
+
+static int pkernfs_init_fs_context(struct fs_context *const fc)
+{
+	fc->ops = &pkernfs_context_ops;
+	return 0;
+}
+
+static struct file_system_type pkernfs_fs_type = {
+	.owner                  = THIS_MODULE,
+	.name                   = "pkernfs",
+	.init_fs_context        = pkernfs_init_fs_context,
+	.kill_sb                = kill_litter_super,
+	.fs_flags               = FS_USERNS_MOUNT,
+};
+
+static int __init pkernfs_init(void)
+{
+	int ret;
+
+	ret = register_filesystem(&pkernfs_fs_type);
+	return ret;
+}
+
+/**
+ * Format: pkernfs=<size>:<base>
+ * Just like: memmap=nn[KMG]!ss[KMG]
+ */
+static int __init parse_pkernfs_extents(char *p)
+{
+	pkernfs_size = memparse(p, &p);
+	p++; /* Skip over ! char */
+	pkernfs_base = memparse(p, &p);
+	return 0;
+}
+
+early_param("pkernfs", parse_pkernfs_extents);
+
+MODULE_ALIAS_FS("pkernfs");
+module_init(pkernfs_init);
diff --git a/fs/pkernfs/pkernfs.h b/fs/pkernfs/pkernfs.h
new file mode 100644
index 000000000000..bd1e2a6fd336
--- /dev/null
+++ b/fs/pkernfs/pkernfs.h
@@ -0,0 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#define PKERNFS_MAGIC_NUMBER 0x706b65726e6673
+struct pkernfs_sb {
+	unsigned long magic_number;
+};
-- 
2.40.1


