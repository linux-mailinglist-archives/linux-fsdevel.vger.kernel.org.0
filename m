Return-Path: <linux-fsdevel+bounces-24981-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1B3947866
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 11:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A69722828D1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 09:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F3F1547EC;
	Mon,  5 Aug 2024 09:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ZKqObFiz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3A615383D;
	Mon,  5 Aug 2024 09:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722850470; cv=none; b=F5GBlaPX72CLnPfsqHl3RDNyqZUKjoM80xsIRWFMBdXjYx7WHicW2WmCotHMeephhxPnZmyCw452JtZ74cJL6FseOdXtbK6F1zweP/TYuF+PoKx5fqQ3TD/SxH072kQgVfOXyW9TvQzlQrzZo7gFK2bi7IBXy2kaNBQPt5/pdyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722850470; c=relaxed/simple;
	bh=AP2P6uLd9rXrpl3zS13MYDJFQU66oOrwe02O7eR19m0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NVnXSjTRtK+JdTX6rtcFGKJE37bJQfsBVG1MV6CJDj4x1fAN7sTXgcisnoTXoHFiOayQIIGEzAZm6wM4tIVFQ6yyo7vaWmRuiNMrJ7UIFupAl39Qfp26q/DHe+lkt1H9KU38xjMOe2dBwwMIm1C3pnDipR03ii+kSLb5p/GZVsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ZKqObFiz; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1722850470; x=1754386470;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rBGc29GJqkanga86wc+CDruFBMWuAWTKAOMI6eWst9M=;
  b=ZKqObFizk4ScXCUe1MWqPVPs85PgeWoyJP9Ubt6Qpy8nKDJz0yAdafL7
   ALMNU61tnDw6ZjI0/YVZyboyDLq4AkpZZvko83CxNlE13m1WE3KHKFq5r
   JkO8WA7tAT83lQQJVFpR/6crkV1j7x8hza6cJB6tiDPClvZjnoDfsWbR9
   Q=;
X-IronPort-AV: E=Sophos;i="6.09,264,1716249600"; 
   d="scan'208";a="440962193"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 09:34:20 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.10.100:16945]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.35.73:2525] with esmtp (Farcaster)
 id bb9ee3fa-f148-4792-ad18-0aaa1262bc00; Mon, 5 Aug 2024 09:34:18 +0000 (UTC)
X-Farcaster-Flow-ID: bb9ee3fa-f148-4792-ad18-0aaa1262bc00
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 5 Aug 2024 09:34:18 +0000
Received: from u5d18b891348c5b.ant.amazon.com (10.146.13.113) by
 EX19D014EUC004.ant.amazon.com (10.252.51.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 5 Aug 2024 09:34:09 +0000
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
Subject: [PATCH 04/10] guestmemfs: support file truncation
Date: Mon, 5 Aug 2024 11:32:39 +0200
Message-ID: <20240805093245.889357-5-jgowans@amazon.com>
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

In a previous commit a block allocator was added. Now use that block
allocator to allocate blocks for files when ftruncate is run on them.

To do that a inode_operations is added on the file inodes with a getattr
callback handling the ATTR_SIZE attribute. When this is invoked pages
are allocated, the indexes of which are put into a mappings block.
The mappings block is an array with the index being the file offset
block and the value at that index being the pkernfs block backign that
file offset.

Signed-off-by: James Gowans <jgowans@amazon.com>
---
 fs/guestmemfs/Makefile     |  2 +-
 fs/guestmemfs/file.c       | 52 ++++++++++++++++++++++++++++++++++++++
 fs/guestmemfs/guestmemfs.h |  2 ++
 fs/guestmemfs/inode.c      | 25 +++++++++++++++---
 4 files changed, 77 insertions(+), 4 deletions(-)
 create mode 100644 fs/guestmemfs/file.c

diff --git a/fs/guestmemfs/Makefile b/fs/guestmemfs/Makefile
index b357073a60f3..e93e43ba274b 100644
--- a/fs/guestmemfs/Makefile
+++ b/fs/guestmemfs/Makefile
@@ -3,4 +3,4 @@
 # Makefile for persistent kernel filesystem
 #
 
-obj-y += guestmemfs.o inode.o dir.o allocator.o
+obj-y += guestmemfs.o inode.o dir.o allocator.o file.o
diff --git a/fs/guestmemfs/file.c b/fs/guestmemfs/file.c
new file mode 100644
index 000000000000..618c93b12196
--- /dev/null
+++ b/fs/guestmemfs/file.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "guestmemfs.h"
+
+static int truncate(struct inode *inode, loff_t newsize)
+{
+	unsigned long free_block;
+	struct guestmemfs_inode *guestmemfs_inode;
+	unsigned long *mappings;
+
+	guestmemfs_inode = guestmemfs_get_persisted_inode(inode->i_sb, inode->i_ino);
+	mappings = guestmemfs_inode->mappings;
+	i_size_write(inode, newsize);
+	for (int block_idx = 0; block_idx * PMD_SIZE < newsize; ++block_idx) {
+		free_block = guestmemfs_alloc_block(inode->i_sb);
+		if (free_block < 0)
+			/* TODO: roll back allocations. */
+			return -ENOMEM;
+		*(mappings + block_idx) = free_block;
+		++guestmemfs_inode->num_mappings;
+	}
+	return 0;
+}
+
+static int inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry, struct iattr *iattr)
+{
+	struct inode *inode = dentry->d_inode;
+	int error;
+
+	error = setattr_prepare(idmap, dentry, iattr);
+	if (error)
+		return error;
+
+	if (iattr->ia_valid & ATTR_SIZE) {
+		error = truncate(inode, iattr->ia_size);
+		if (error)
+			return error;
+	}
+	setattr_copy(idmap, inode, iattr);
+	mark_inode_dirty(inode);
+	return 0;
+}
+
+const struct inode_operations guestmemfs_file_inode_operations = {
+	.setattr = inode_setattr,
+	.getattr = simple_getattr,
+};
+
+const struct file_operations guestmemfs_file_fops = {
+	.owner = THIS_MODULE,
+	.iterate_shared = NULL,
+};
diff --git a/fs/guestmemfs/guestmemfs.h b/fs/guestmemfs/guestmemfs.h
index af9832390be3..7ea03ac8ecca 100644
--- a/fs/guestmemfs/guestmemfs.h
+++ b/fs/guestmemfs/guestmemfs.h
@@ -44,3 +44,5 @@ struct inode *guestmemfs_inode_get(struct super_block *sb, unsigned long ino);
 struct guestmemfs_inode *guestmemfs_get_persisted_inode(struct super_block *sb, int ino);
 
 extern const struct file_operations guestmemfs_dir_fops;
+extern const struct file_operations guestmemfs_file_fops;
+extern const struct inode_operations guestmemfs_file_inode_operations;
diff --git a/fs/guestmemfs/inode.c b/fs/guestmemfs/inode.c
index 2360c3a4857d..61f70441d82c 100644
--- a/fs/guestmemfs/inode.c
+++ b/fs/guestmemfs/inode.c
@@ -15,14 +15,28 @@ struct guestmemfs_inode *guestmemfs_get_persisted_inode(struct super_block *sb,
 
 struct inode *guestmemfs_inode_get(struct super_block *sb, unsigned long ino)
 {
+	struct guestmemfs_inode *guestmemfs_inode;
 	struct inode *inode = iget_locked(sb, ino);
 
 	/* If this inode is cached it is already populated; just return */
 	if (!(inode->i_state & I_NEW))
 		return inode;
-	inode->i_op = &guestmemfs_dir_inode_operations;
+	guestmemfs_inode = guestmemfs_get_persisted_inode(sb, ino);
 	inode->i_sb = sb;
-	inode->i_mode = S_IFREG;
+
+	if (guestmemfs_inode->flags & GUESTMEMFS_INODE_FLAG_DIR) {
+		inode->i_op = &guestmemfs_dir_inode_operations;
+		inode->i_mode = S_IFDIR;
+	} else {
+		inode->i_op = &guestmemfs_file_inode_operations;
+		inode->i_mode = S_IFREG;
+		inode->i_fop = &guestmemfs_file_fops;
+		inode->i_size = guestmemfs_inode->num_mappings * PMD_SIZE;
+	}
+
+	set_nlink(inode, 1);
+
+	/* Switch based on file type */
 	unlock_new_inode(inode);
 	return inode;
 }
@@ -103,6 +117,7 @@ static struct dentry *guestmemfs_lookup(struct inode *dir,
 		unsigned int flags)
 {
 	struct guestmemfs_inode *guestmemfs_inode;
+	struct inode *vfs_inode;
 	unsigned long ino;
 
 	guestmemfs_inode = guestmemfs_get_persisted_inode(dir->i_sb, dir->i_ino);
@@ -112,7 +127,10 @@ static struct dentry *guestmemfs_lookup(struct inode *dir,
 		if (!strncmp(guestmemfs_inode->filename,
 			     dentry->d_name.name,
 			     GUESTMEMFS_FILENAME_LEN)) {
-			d_add(dentry, guestmemfs_inode_get(dir->i_sb, ino));
+			vfs_inode = guestmemfs_inode_get(dir->i_sb, ino);
+			mark_inode_dirty(dir);
+			inode_update_timestamps(vfs_inode, S_ATIME);
+			d_add(dentry, vfs_inode);
 			break;
 		}
 		ino = guestmemfs_inode->sibling_ino;
@@ -162,3 +180,4 @@ const struct inode_operations guestmemfs_dir_inode_operations = {
 	.lookup		= guestmemfs_lookup,
 	.unlink		= guestmemfs_unlink,
 };
+
-- 
2.34.1


