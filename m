Return-Path: <linux-fsdevel+bounces-10273-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EB1849983
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 13:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B7AE1C22889
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 12:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575FE1AAD2;
	Mon,  5 Feb 2024 12:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="i6+E2Y7u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC771BC46;
	Mon,  5 Feb 2024 12:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707134581; cv=none; b=UGS50KRa6ZX0QVyhpyucufZJVSejsRLWvm8M7pHNl5y239WnfFWvQgAvp5GdyPMDunVHvgxQnake9gCob0RjpBhxOfWKPDZa8D41bdTpUzuMJIk4rKHgYNFksZc2ZIYdL+Qqh+46wvG5JTwyXZgTm2Hh6IhY6BnD9yCmwcnTUjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707134581; c=relaxed/simple;
	bh=lErGtpA70KiDfjFQXCKs90lxVYs+wLNGHzuwt7P6XCM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mv7crg3dWGqyJZfR4Sn2oSCFMUU71kVlC/lzIqgVUzHr3wV8emNUFCJV9fliN5Avw3XU/LZvYuqTLB3l1/HET9NYAFqohLgduhYRrukDDHQE2VMJnXcKm0PDqQFEh5ozIflOKHNHYjz/7r1TN/ZFSPq1/oVzrnpoKFGc3y8tI2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=i6+E2Y7u; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1707134580; x=1738670580;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=09HM9kCtJQ5fhByhNyO/r0il26Ag7KNxaSp1FSa3SKw=;
  b=i6+E2Y7uQY4J6eLqwZJnGtNvDDFRxqGbbuND7EMksfEJDoiaiB+GMEwn
   qwAXylnrSmo0XnSYzJKFCKClN1aqm1eeraOqBC7AK1Ua0gALOCa7vduN5
   dj8oZu+tawgjUa8qDCjZiL4w4O6jEyOVJOqKo3Eq/WZbVYkqElKtr7YjC
   w=;
X-IronPort-AV: E=Sophos;i="6.05,245,1701129600"; 
   d="scan'208";a="63755246"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 12:02:58 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.10.100:37383]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.33.186:2525] with esmtp (Farcaster)
 id 0e22be1f-cb32-4c25-b8b9-6a540783cffe; Mon, 5 Feb 2024 12:02:57 +0000 (UTC)
X-Farcaster-Flow-ID: 0e22be1f-cb32-4c25-b8b9-6a540783cffe
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 5 Feb 2024 12:02:57 +0000
Received: from dev-dsk-jgowans-1a-a3faec1f.eu-west-1.amazon.com
 (172.19.112.191) by EX19D014EUC004.ant.amazon.com (10.252.51.182) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 5 Feb
 2024 12:02:50 +0000
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
Subject: [RFC 03/18] pkernfs: Define an allocator for persistent pages
Date: Mon, 5 Feb 2024 12:01:48 +0000
Message-ID: <20240205120203.60312-4-jgowans@amazon.com>
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

This introduces the concept of a bitmap allocator for pages from the
pkernfs filesystem. The allocation bitmap is stored in the second half
of the first page. This imposes an artificial limit of the maximum size
of the filesystem; this needs to be made extensible.

The allocations can be zeroed, that's it so far. The next commit will
add the ability to allocate and use it.
---
 fs/pkernfs/Makefile    |  2 +-
 fs/pkernfs/allocator.c | 27 +++++++++++++++++++++++++++
 fs/pkernfs/pkernfs.c   |  1 +
 fs/pkernfs/pkernfs.h   |  1 +
 4 files changed, 30 insertions(+), 1 deletion(-)
 create mode 100644 fs/pkernfs/allocator.c

diff --git a/fs/pkernfs/Makefile b/fs/pkernfs/Makefile
index 0a66e98bda07..d8b92a74fbc6 100644
--- a/fs/pkernfs/Makefile
+++ b/fs/pkernfs/Makefile
@@ -3,4 +3,4 @@
 # Makefile for persistent kernel filesystem
 #
 
-obj-$(CONFIG_PKERNFS_FS) += pkernfs.o inode.o dir.o
+obj-$(CONFIG_PKERNFS_FS) += pkernfs.o inode.o allocator.o dir.o
diff --git a/fs/pkernfs/allocator.c b/fs/pkernfs/allocator.c
new file mode 100644
index 000000000000..1d4aac9c4545
--- /dev/null
+++ b/fs/pkernfs/allocator.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "pkernfs.h"
+
+/**
+ * For allocating blocks from the pkernfs filesystem.
+ * The first two blocks are special:
+ * - the first block is persitent filesystme metadata and
+ *   a bitmap of allocated blocks
+ * - the second block is an array of persisted inodes; the
+ *   inode store.
+ */
+
+void *pkernfs_allocations_bitmap(struct super_block *sb)
+{
+	/* Allocations is 2nd half of first block */
+	return pkernfs_mem + (1 << 20);
+}
+
+void pkernfs_zero_allocations(struct super_block *sb)
+{
+	memset(pkernfs_allocations_bitmap(sb), 0, (1 << 20));
+	/* First page is persisted super block and allocator bitmap */
+	set_bit(0, pkernfs_allocations_bitmap(sb));
+	/* Second page is inode store */
+	set_bit(1, pkernfs_allocations_bitmap(sb));
+}
diff --git a/fs/pkernfs/pkernfs.c b/fs/pkernfs/pkernfs.c
index 518c610e3877..199c2c648bca 100644
--- a/fs/pkernfs/pkernfs.c
+++ b/fs/pkernfs/pkernfs.c
@@ -25,6 +25,7 @@ static int pkernfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	} else {
 		pr_info("pkernfs: Clean super block; initialising\n");
 		pkernfs_initialise_inode_store(sb);
+		pkernfs_zero_allocations(sb);
 		psb->magic_number = PKERNFS_MAGIC_NUMBER;
 		pkernfs_get_persisted_inode(sb, 1)->flags = PKERNFS_INODE_FLAG_DIR;
 		strscpy(pkernfs_get_persisted_inode(sb, 1)->filename, ".", PKERNFS_FILENAME_LEN);
diff --git a/fs/pkernfs/pkernfs.h b/fs/pkernfs/pkernfs.h
index 192e089b3151..4655780f31f2 100644
--- a/fs/pkernfs/pkernfs.h
+++ b/fs/pkernfs/pkernfs.h
@@ -34,6 +34,7 @@ struct pkernfs_inode {
 };
 
 void pkernfs_initialise_inode_store(struct super_block *sb);
+void pkernfs_zero_allocations(struct super_block *sb);
 struct inode *pkernfs_inode_get(struct super_block *sb, unsigned long ino);
 struct pkernfs_inode *pkernfs_get_persisted_inode(struct super_block *sb, int ino);
 
-- 
2.40.1


