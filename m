Return-Path: <linux-fsdevel+bounces-24980-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFE594785F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 11:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 929551C21148
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 09:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F1315380B;
	Mon,  5 Aug 2024 09:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="K9w/CAIM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFA014D2B3;
	Mon,  5 Aug 2024 09:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722850454; cv=none; b=S1GM8kJ/lYx735IHFBGo3nwRSahDP+s0S/xD49qE2lZx63CdQM2PnjQLCZbUDwtNUo3AiNPmsLUDBQ71Nj3hyzSJ+bn2ZRWwjO6zk97/QV7MJ3YAubrDOvOB38cd19q2lqvs7bMDWcDOsQdyMvd/t8MzEIVS76cNMcNAByDPr/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722850454; c=relaxed/simple;
	bh=C+2QCWuajYQ/XOlrovRJz5UKrRoJyZS+Th/wsV04b04=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FF+XR5lF29PnrqZDx6LkgarEmP8L0Jo7YElpH5UoSWMvUrC7R76RVgC6DRCp791Fxn9rDi91qxmQ/ptIsmjSYHtVr9VagYexfBs7MlVjWdIzkSxNCA4optqtG307b4OAhDd76Z4MotQG1aLmxQw9CKH8vHcaIpEoDWssI2Jbqro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=K9w/CAIM; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1722850453; x=1754386453;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mf4bGqkjJGcuD7WLWM/6xATCnP8HxmWYZb3Uae5eqbU=;
  b=K9w/CAIMa2st6perqqv1IUClGAN06TjVdr6KQZWOFQ1m1ToMAQ+TPayo
   jZosfRt3EEA/WnXH8B56n1cETBYJQrpj6D+OVsxtKAFfKE13s3op8lRZp
   UHWtTzRv1U9tRFiT3QtdAKT0SBQXlZWy46tqI0huQ/bFRjPO28f/eHCj5
   Q=;
X-IronPort-AV: E=Sophos;i="6.09,264,1716249600"; 
   d="scan'208";a="112401062"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 09:34:11 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.43.254:30354]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.25.233:2525] with esmtp (Farcaster)
 id bfd7aaac-eb93-420b-99d8-e287bbc4fa9e; Mon, 5 Aug 2024 09:34:10 +0000 (UTC)
X-Farcaster-Flow-ID: bfd7aaac-eb93-420b-99d8-e287bbc4fa9e
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 5 Aug 2024 09:34:08 +0000
Received: from u5d18b891348c5b.ant.amazon.com (10.146.13.113) by
 EX19D014EUC004.ant.amazon.com (10.252.51.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 5 Aug 2024 09:33:59 +0000
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
Subject: [PATCH 03/10] guestmemfs: add persistent data block allocator
Date: Mon, 5 Aug 2024 11:32:38 +0200
Message-ID: <20240805093245.889357-4-jgowans@amazon.com>
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

In order to assign backing data memory to files there needs to be the
ability to allocate blocks of data from the large contiguous reserved
memory block of filesystem memory. Here an allocated is added to serve
that purpose. For now it's a simple bitmap allocator: each bit
corresponds to a 2 MiB chunk in the filesystem data block.

On initialisation the bitmap is allocated for a fixed size (TODO: make
this dynamic based on filesystem memory size). Allocating a block
involves finding and setting the next free bit.

Allocations will be done in the next commit which adds support for
truncating files.

It's quite limiting having a fixed size bitmap, and we perhaps want to
look at making this a dynamic and potentially large allocation early in
boot using the memblock allocator. It may also turn out that a simple
bitmap is too limiting and something with more metadata is needed.

Signed-off-by: James Gowans <jgowans@amazon.com>
---
 fs/guestmemfs/Makefile     |  2 +-
 fs/guestmemfs/allocator.c  | 40 ++++++++++++++++++++++++++++++++++++++
 fs/guestmemfs/guestmemfs.c |  4 ++++
 fs/guestmemfs/guestmemfs.h |  3 +++
 4 files changed, 48 insertions(+), 1 deletion(-)
 create mode 100644 fs/guestmemfs/allocator.c

diff --git a/fs/guestmemfs/Makefile b/fs/guestmemfs/Makefile
index 804997799ce8..b357073a60f3 100644
--- a/fs/guestmemfs/Makefile
+++ b/fs/guestmemfs/Makefile
@@ -3,4 +3,4 @@
 # Makefile for persistent kernel filesystem
 #
 
-obj-y += guestmemfs.o inode.o dir.o
+obj-y += guestmemfs.o inode.o dir.o allocator.o
diff --git a/fs/guestmemfs/allocator.c b/fs/guestmemfs/allocator.c
new file mode 100644
index 000000000000..3da14d11b60f
--- /dev/null
+++ b/fs/guestmemfs/allocator.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "guestmemfs.h"
+
+/**
+ * For allocating blocks from the guestmemfs filesystem.
+ */
+
+static void *guestmemfs_allocations_bitmap(struct super_block *sb)
+{
+	return GUESTMEMFS_PSB(sb)->allocator_bitmap;
+}
+
+void guestmemfs_zero_allocations(struct super_block *sb)
+{
+	memset(guestmemfs_allocations_bitmap(sb), 0, (1 << 20));
+}
+
+/*
+ * Allocs one 2 MiB block, and returns the block index.
+ * Index is 2 MiB chunk index.
+ * Negative error code if unable to alloc.
+ */
+long guestmemfs_alloc_block(struct super_block *sb)
+{
+	unsigned long free_bit;
+	void *allocations_mem = guestmemfs_allocations_bitmap(sb);
+
+	free_bit = bitmap_find_next_zero_area(allocations_mem,
+			(1 << 20), /* Size */
+			0, /* Start */
+			1, /* Number of zeroed bits to look for */
+			0); /* Alignment mask - none required. */
+
+	if (free_bit >= PMD_SIZE / 2)
+		return -ENOMEM;
+
+	bitmap_set(allocations_mem, free_bit, 1);
+	return free_bit;
+}
diff --git a/fs/guestmemfs/guestmemfs.c b/fs/guestmemfs/guestmemfs.c
index 21cb3490a2bd..c45c796c497a 100644
--- a/fs/guestmemfs/guestmemfs.c
+++ b/fs/guestmemfs/guestmemfs.c
@@ -37,6 +37,9 @@ static int guestmemfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	psb->inodes = kzalloc(2 << 20, GFP_KERNEL);
 	if (!psb->inodes)
 		return -ENOMEM;
+	psb->allocator_bitmap = kzalloc(1 << 20, GFP_KERNEL);
+	if (!psb->allocator_bitmap)
+		return -ENOMEM;
 
 	/*
 	 * Keep a reference to the persistent super block in the
@@ -45,6 +48,7 @@ static int guestmemfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_fs_info = psb;
 	spin_lock_init(&psb->allocation_lock);
 	guestmemfs_initialise_inode_store(sb);
+	guestmemfs_zero_allocations(sb);
 	guestmemfs_get_persisted_inode(sb, 1)->flags = GUESTMEMFS_INODE_FLAG_DIR;
 	strscpy(guestmemfs_get_persisted_inode(sb, 1)->filename, ".",
 			GUESTMEMFS_FILENAME_LEN);
diff --git a/fs/guestmemfs/guestmemfs.h b/fs/guestmemfs/guestmemfs.h
index 3a2954d1beec..af9832390be3 100644
--- a/fs/guestmemfs/guestmemfs.h
+++ b/fs/guestmemfs/guestmemfs.h
@@ -13,6 +13,7 @@ struct guestmemfs_sb {
 	unsigned long next_free_ino;
 	unsigned long allocated_inodes;
 	struct guestmemfs_inode *inodes;
+	void *allocator_bitmap;
 	spinlock_t allocation_lock;
 };
 
@@ -37,6 +38,8 @@ struct guestmemfs_inode {
 };
 
 void guestmemfs_initialise_inode_store(struct super_block *sb);
+void guestmemfs_zero_allocations(struct super_block *sb);
+long guestmemfs_alloc_block(struct super_block *sb);
 struct inode *guestmemfs_inode_get(struct super_block *sb, unsigned long ino);
 struct guestmemfs_inode *guestmemfs_get_persisted_inode(struct super_block *sb, int ino);
 
-- 
2.34.1


