Return-Path: <linux-fsdevel+bounces-24985-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C33947878
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 11:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 229941C21044
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 09:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112A5155346;
	Mon,  5 Aug 2024 09:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="TuR4j0nd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1580715442A;
	Mon,  5 Aug 2024 09:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722850534; cv=none; b=SfWajB2BNttR8XO9lI0CzgDnF91O8ze9iibSDuHY000ZoXBFc8jgCoHcpZ3oGyyXUYdM7ZLbwn4o9xJAn9r4854agECJ2L/rfWAcQYfXQOftX0BrzxrwSXmqEprC5WkHZLCGZ/Tgtsw617j9zyAMOZOF8H7ATVQOPL9bYVN9AVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722850534; c=relaxed/simple;
	bh=HaZglgonvr41X6YnrF6DoFX0ivd5TdLlUhGuSbscGfM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jArQT1MYdv7FJRh1tuViGjIOJcjeTVuLfBjMPWr+OCF6vfoPicd9lipQGX0l6ybH+PR8j1bThsXQTvvoov4USauWQBe6E8SCcj1iQWNKJYRn6iyAzFi/SxdaZj/VOsCCKYYZvdoFFPWA5WSOYvVL5FRt5CZInSHCYOlx2WEbsNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=TuR4j0nd; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1722850533; x=1754386533;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b/ZDrMWB4VIy9ADRZF2m3pCqPq++QQhsZ6WqVk7Aipc=;
  b=TuR4j0ndKzOgL0hg3WqnXT0RQqvEPwzHWPYPHcv3ntsuouNSIPkNlsLo
   2hwNXAURpd9aCJIpcTnoMizJNZ4LIwD069tg5FBSoqVbFGrt/E/Koz84o
   gCNZmSnTfqDaftX5u8dH5BkrEVyg4Tns2jVHXN0XYYOUX3xIfijDYmSwC
   8=;
X-IronPort-AV: E=Sophos;i="6.09,264,1716249600"; 
   d="scan'208";a="112169575"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 09:35:29 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.43.254:35726]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.45.111:2525] with esmtp (Farcaster)
 id ba2c37fa-2737-488d-9a39-9aa5f2392569; Mon, 5 Aug 2024 09:35:28 +0000 (UTC)
X-Farcaster-Flow-ID: ba2c37fa-2737-488d-9a39-9aa5f2392569
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 5 Aug 2024 09:35:27 +0000
Received: from u5d18b891348c5b.ant.amazon.com (10.146.13.113) by
 EX19D014EUC004.ant.amazon.com (10.252.51.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 5 Aug 2024 09:35:18 +0000
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
Subject: [PATCH 08/10] guestmemfs: Block modifications when serialised
Date: Mon, 5 Aug 2024 11:32:43 +0200
Message-ID: <20240805093245.889357-9-jgowans@amazon.com>
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

Once the memory regions for inodes, mappings and allocations have been
serialised, further modifications would break the serialised data; it
would no longer be valid.

Return an error code if attempting to create new files or allocate data
for files once serialised.

Signed-off-by: James Gowans <jgowans@amazon.com>
---
 fs/guestmemfs/file.c       | 19 ++++++++++++++++---
 fs/guestmemfs/guestmemfs.c |  1 +
 fs/guestmemfs/guestmemfs.h |  1 +
 fs/guestmemfs/inode.c      |  6 ++++++
 fs/guestmemfs/serialise.c  |  8 +++++++-
 5 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/fs/guestmemfs/file.c b/fs/guestmemfs/file.c
index b1a52abcde65..8707a9d3ad90 100644
--- a/fs/guestmemfs/file.c
+++ b/fs/guestmemfs/file.c
@@ -8,19 +8,32 @@ static int truncate(struct inode *inode, loff_t newsize)
 	unsigned long free_block;
 	struct guestmemfs_inode *guestmemfs_inode;
 	unsigned long *mappings;
+	int rc = 0;
+	struct guestmemfs_sb *psb = GUESTMEMFS_PSB(inode->i_sb);
+
+	spin_lock(&psb->allocation_lock);
+
+	if (psb->serialised) {
+		rc = -EBUSY;
+		goto out;
+	}
 
 	guestmemfs_inode = guestmemfs_get_persisted_inode(inode->i_sb, inode->i_ino);
 	mappings = guestmemfs_inode->mappings;
 	i_size_write(inode, newsize);
 	for (int block_idx = 0; block_idx * PMD_SIZE < newsize; ++block_idx) {
 		free_block = guestmemfs_alloc_block(inode->i_sb);
-		if (free_block < 0)
+		if (free_block < 0) {
 			/* TODO: roll back allocations. */
-			return -ENOMEM;
+			rc = -ENOMEM;
+			goto out;
+		}
 		*(mappings + block_idx) = free_block;
 		++guestmemfs_inode->num_mappings;
 	}
-	return 0;
+out:
+	spin_unlock(&psb->allocation_lock);
+	return rc;
 }
 
 static int inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry, struct iattr *iattr)
diff --git a/fs/guestmemfs/guestmemfs.c b/fs/guestmemfs/guestmemfs.c
index cf47e5100504..d854033bfb7e 100644
--- a/fs/guestmemfs/guestmemfs.c
+++ b/fs/guestmemfs/guestmemfs.c
@@ -42,6 +42,7 @@ static int guestmemfs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	if (GUESTMEMFS_PSB(sb)) {
 		pr_info("Restored super block from KHO\n");
+		GUESTMEMFS_PSB(sb)->serialised = 0;
 	} else {
 		struct guestmemfs_sb *psb;
 
diff --git a/fs/guestmemfs/guestmemfs.h b/fs/guestmemfs/guestmemfs.h
index 263d995b75ed..91cc06ae45a5 100644
--- a/fs/guestmemfs/guestmemfs.h
+++ b/fs/guestmemfs/guestmemfs.h
@@ -21,6 +21,7 @@ struct guestmemfs_sb {
 	struct guestmemfs_inode *inodes;
 	void *allocator_bitmap;
 	spinlock_t allocation_lock;
+	bool serialised;
 };
 
 // If neither of these are set the inode is not in use.
diff --git a/fs/guestmemfs/inode.c b/fs/guestmemfs/inode.c
index 61f70441d82c..d521b35d4992 100644
--- a/fs/guestmemfs/inode.c
+++ b/fs/guestmemfs/inode.c
@@ -48,6 +48,12 @@ static unsigned long guestmemfs_allocate_inode(struct super_block *sb)
 	struct guestmemfs_sb *psb = GUESTMEMFS_PSB(sb);
 
 	spin_lock(&psb->allocation_lock);
+
+	if (psb->serialised) {
+	    spin_unlock(&psb->allocation_lock);
+	    return -EBUSY;
+	}
+
 	next_free_ino = psb->next_free_ino;
 	psb->allocated_inodes += 1;
 	if (!next_free_ino)
diff --git a/fs/guestmemfs/serialise.c b/fs/guestmemfs/serialise.c
index eb70d496a3eb..347eb8049a71 100644
--- a/fs/guestmemfs/serialise.c
+++ b/fs/guestmemfs/serialise.c
@@ -111,7 +111,7 @@ int guestmemfs_serialise_to_kho(struct notifier_block *self,
 
 	switch (cmd) {
 	case KEXEC_KHO_ABORT:
-		/* No rollback action needed. */
+		GUESTMEMFS_PSB(guestmemfs_sb)->serialised = 0;
 		return NOTIFY_DONE;
 	case KEXEC_KHO_DUMP:
 		/* Handled below */
@@ -120,6 +120,7 @@ int guestmemfs_serialise_to_kho(struct notifier_block *self,
 		return NOTIFY_BAD;
 	}
 
+	spin_lock(&GUESTMEMFS_PSB(guestmemfs_sb)->allocation_lock);
 	err |= fdt_begin_node(fdt, "guestmemfs");
 	err |= fdt_property(fdt, "compatible", compatible, sizeof(compatible));
 
@@ -134,6 +135,11 @@ int guestmemfs_serialise_to_kho(struct notifier_block *self,
 
 	err |= fdt_end_node(fdt);
 
+	if (!err)
+		GUESTMEMFS_PSB(guestmemfs_sb)->serialised = 1;
+
+	spin_unlock(&GUESTMEMFS_PSB(guestmemfs_sb)->allocation_lock);
+
 	pr_info("Serialised extends [0x%llx + 0x%llx] via KHO: %i\n",
 			guestmemfs_base, guestmemfs_size, err);
 
-- 
2.34.1


