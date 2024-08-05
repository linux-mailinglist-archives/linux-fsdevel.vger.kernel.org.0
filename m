Return-Path: <linux-fsdevel+bounces-24979-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B93AF94785A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 11:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB54D1C21001
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 09:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2448C15381A;
	Mon,  5 Aug 2024 09:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="AeKvkmuC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808B114F9D7;
	Mon,  5 Aug 2024 09:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722850415; cv=none; b=dOS0NND58M0OGoJZDUhnP2ZIxW6z7otatCv4jm71rDLCNkOm4FmrHtzIBIcLu/qcHjnh0fu4iQxd/5H+0pHlKIDB2TPjPIsgBvJJCo5MJDaLUSMHEcf6xQ1mL21VXY06fL4N518ZCTCpog/Ah5bB5zkKMQbza8fZGKM+MMa62bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722850415; c=relaxed/simple;
	bh=nQ1WLF14Y/vRRp7JSxyU66cbzjWNAiG3Po4/qQvOwtM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q1pINjF2JqkmUaLMEgk2XfOqlgN6px4ss9EUhNsqQ6o2Z9P114IeBeOE2Mf59hB29i2J/RpjpL5o40IgJ18tH5EVztaCclSddzcDi+cqlyUSGi55Y+fJkwp801SHcWJUzRbA2PrsH6NpDkXPlnRBWoGT2IwVfSOKf/IQQSsw+uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=AeKvkmuC; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1722850414; x=1754386414;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HjMwVBXj1g+VXvnThIAFzLofQdSvF983VdApn1VgvTs=;
  b=AeKvkmuCoABgBHBi6DsQsnzFeX4RcWNcdbUnSIAHz/lDMN5Ded8t8wqV
   RywxuNRXkrlOw+iDJOIB0DJQH9qkMO/K0WZag/gl06OlRiHN013NanEcp
   S0KaRwb08n/2k0u6hF2hZZ+V/vR9OceAXZDV/kVSSQ0tfnHNkWbCxol5w
   k=;
X-IronPort-AV: E=Sophos;i="6.09,264,1716249600"; 
   d="scan'208";a="672010836"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 09:33:29 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.10.100:16269]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.35.73:2525] with esmtp (Farcaster)
 id 2fb10915-ae34-4c72-8260-ae60945f471a; Mon, 5 Aug 2024 09:33:28 +0000 (UTC)
X-Farcaster-Flow-ID: 2fb10915-ae34-4c72-8260-ae60945f471a
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 5 Aug 2024 09:33:28 +0000
Received: from u5d18b891348c5b.ant.amazon.com (10.146.13.113) by
 EX19D014EUC004.ant.amazon.com (10.252.51.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 5 Aug 2024 09:33:19 +0000
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
Subject: [PATCH 02/10] guestmemfs: add inode store, files and dirs
Date: Mon, 5 Aug 2024 11:32:37 +0200
Message-ID: <20240805093245.889357-3-jgowans@amazon.com>
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

Here inodes are added to the filesystem: inodes for both regular files
and directories. This involes supporting the callbacks to create inodes
in a directory, as well as being able to list the contents of a
directory and lookup and inode by name.

The inode store is implemented as a 2 MiB page which is an array of
struct guestmemfs_inode. The reason to have a large allocation and put
them all in a big flat array is to make persistence easy: when it's time
to introduce persistence to the filesystem it will need to persist this
one big chunk of inodes across kexec using KHO.

Free inodes in the page form a slab type structure, the first free inode
pointing to the next free inode, etc. The super block points to the
first free, so allocating involves popping the head, and freeing an
inode involves pushing a new head.

Directories point to the first inode in the directory via a child_inode
reference. Subsequent inodes within the same directory are pointed to
via a sibling_inode member. Essentially forming a linked list of inodes
within the directory.

Looking up an inode in a directory involves traversing the sibling_inode
linked list until one with a matching name is found.

Filesystem stats are updated to account for total and allocated inodes.

Signed-off-by: James Gowans <jgowans@amazon.com>
---
 fs/guestmemfs/Makefile     |   2 +-
 fs/guestmemfs/dir.c        |  43 ++++++++++
 fs/guestmemfs/guestmemfs.c |  21 ++++-
 fs/guestmemfs/guestmemfs.h |  36 +++++++-
 fs/guestmemfs/inode.c      | 164 +++++++++++++++++++++++++++++++++++++
 5 files changed, 260 insertions(+), 6 deletions(-)
 create mode 100644 fs/guestmemfs/dir.c
 create mode 100644 fs/guestmemfs/inode.c

diff --git a/fs/guestmemfs/Makefile b/fs/guestmemfs/Makefile
index 6dc820a9d4fe..804997799ce8 100644
--- a/fs/guestmemfs/Makefile
+++ b/fs/guestmemfs/Makefile
@@ -3,4 +3,4 @@
 # Makefile for persistent kernel filesystem
 #
 
-obj-y += guestmemfs.o
+obj-y += guestmemfs.o inode.o dir.o
diff --git a/fs/guestmemfs/dir.c b/fs/guestmemfs/dir.c
new file mode 100644
index 000000000000..4acd81421c85
--- /dev/null
+++ b/fs/guestmemfs/dir.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "guestmemfs.h"
+
+static int guestmemfs_dir_iterate(struct file *dir, struct dir_context *ctx)
+{
+	struct guestmemfs_inode *guestmemfs_inode;
+	struct super_block *sb = dir->f_inode->i_sb;
+
+	/* Indication from previous invoke that there's no more to iterate. */
+	if (ctx->pos == -1)
+		return 0;
+
+	if (!dir_emit_dots(dir, ctx))
+		return 0;
+
+	/*
+	 * Just emitted this dir; go to dir contents. Use pos to smuggle
+	 * the next inode number to emit across iterations.
+	 * -1 indicates no valid inode. Can't use 0 because first loop has pos=0
+	 */
+	if (ctx->pos == 2) {
+		ctx->pos = guestmemfs_get_persisted_inode(sb, dir->f_inode->i_ino)->child_ino;
+		/* Empty dir case. */
+		if (ctx->pos == 0)
+			ctx->pos = -1;
+	}
+
+	while (ctx->pos > 1) {
+		guestmemfs_inode = guestmemfs_get_persisted_inode(sb, ctx->pos);
+		dir_emit(ctx, guestmemfs_inode->filename, GUESTMEMFS_FILENAME_LEN,
+				ctx->pos, DT_UNKNOWN);
+		ctx->pos = guestmemfs_inode->sibling_ino;
+		if (!ctx->pos)
+			ctx->pos = -1;
+	}
+	return 0;
+}
+
+const struct file_operations guestmemfs_dir_fops = {
+	.owner = THIS_MODULE,
+	.iterate_shared = guestmemfs_dir_iterate,
+};
diff --git a/fs/guestmemfs/guestmemfs.c b/fs/guestmemfs/guestmemfs.c
index 3aaada1b8df6..21cb3490a2bd 100644
--- a/fs/guestmemfs/guestmemfs.c
+++ b/fs/guestmemfs/guestmemfs.c
@@ -18,6 +18,9 @@ static int statfs(struct dentry *root, struct kstatfs *buf)
 	buf->f_bsize = PMD_SIZE;
 	buf->f_blocks = guestmemfs_size / PMD_SIZE;
 	buf->f_bfree = buf->f_bavail = buf->f_blocks;
+	buf->f_files = PMD_SIZE / sizeof(struct guestmemfs_inode);
+	buf->f_ffree = buf->f_files -
+		GUESTMEMFS_PSB(root->d_sb)->allocated_inodes;
 	return 0;
 }
 
@@ -31,24 +34,34 @@ static int guestmemfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	struct dentry *dentry;
 
 	psb = kzalloc(sizeof(*psb), GFP_KERNEL);
+	psb->inodes = kzalloc(2 << 20, GFP_KERNEL);
+	if (!psb->inodes)
+		return -ENOMEM;
+
 	/*
 	 * Keep a reference to the persistent super block in the
 	 * ephemeral super block.
 	 */
 	sb->s_fs_info = psb;
+	spin_lock_init(&psb->allocation_lock);
+	guestmemfs_initialise_inode_store(sb);
+	guestmemfs_get_persisted_inode(sb, 1)->flags = GUESTMEMFS_INODE_FLAG_DIR;
+	strscpy(guestmemfs_get_persisted_inode(sb, 1)->filename, ".",
+			GUESTMEMFS_FILENAME_LEN);
+	psb->next_free_ino = 2;
+
 	sb->s_op = &guestmemfs_super_ops;
 
-	inode = new_inode(sb);
+	inode = guestmemfs_inode_get(sb, 1);
 	if (!inode)
 		return -ENOMEM;
 
-	inode->i_ino = 1;
 	inode->i_mode = S_IFDIR;
-	inode->i_op = &simple_dir_inode_operations;
-	inode->i_fop = &simple_dir_operations;
+	inode->i_fop = &guestmemfs_dir_fops;
 	simple_inode_init_ts(inode);
 	/* directory inodes start off with i_nlink == 2 (for "." entry) */
 	inc_nlink(inode);
+	inode_init_owner(&nop_mnt_idmap, inode, NULL, inode->i_mode);
 
 	dentry = d_make_root(inode);
 	if (!dentry)
diff --git a/fs/guestmemfs/guestmemfs.h b/fs/guestmemfs/guestmemfs.h
index 37d8cf630e0a..3a2954d1beec 100644
--- a/fs/guestmemfs/guestmemfs.h
+++ b/fs/guestmemfs/guestmemfs.h
@@ -3,7 +3,41 @@
 #define pr_fmt(fmt) "guestmemfs: " KBUILD_MODNAME ": " fmt
 
 #include <linux/guestmemfs.h>
+#include <linux/fs.h>
+
+#define GUESTMEMFS_FILENAME_LEN 255
+#define GUESTMEMFS_PSB(sb) ((struct guestmemfs_sb *)sb->s_fs_info)
 
 struct guestmemfs_sb {
-    /* Will be populated soon... */
+	/* Inode number */
+	unsigned long next_free_ino;
+	unsigned long allocated_inodes;
+	struct guestmemfs_inode *inodes;
+	spinlock_t allocation_lock;
+};
+
+// If neither of these are set the inode is not in use.
+#define GUESTMEMFS_INODE_FLAG_FILE (1 << 0)
+#define GUESTMEMFS_INODE_FLAG_DIR (1 << 1)
+struct guestmemfs_inode {
+	int flags;
+	/*
+	 * Points to next inode in the same directory, or
+	 * 0 if last file in directory.
+	 */
+	unsigned long sibling_ino;
+	/*
+	 * If this inode is a directory, this points to the
+	 * first inode *in* that directory.
+	 */
+	unsigned long child_ino;
+	char filename[GUESTMEMFS_FILENAME_LEN];
+	void *mappings;
+	int num_mappings;
 };
+
+void guestmemfs_initialise_inode_store(struct super_block *sb);
+struct inode *guestmemfs_inode_get(struct super_block *sb, unsigned long ino);
+struct guestmemfs_inode *guestmemfs_get_persisted_inode(struct super_block *sb, int ino);
+
+extern const struct file_operations guestmemfs_dir_fops;
diff --git a/fs/guestmemfs/inode.c b/fs/guestmemfs/inode.c
new file mode 100644
index 000000000000..2360c3a4857d
--- /dev/null
+++ b/fs/guestmemfs/inode.c
@@ -0,0 +1,164 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "guestmemfs.h"
+#include <linux/fs.h>
+
+const struct inode_operations guestmemfs_dir_inode_operations;
+
+struct guestmemfs_inode *guestmemfs_get_persisted_inode(struct super_block *sb, int ino)
+{
+	/*
+	 * Inode index starts at 1, so -1 to get memory index.
+	 */
+	return GUESTMEMFS_PSB(sb)->inodes + ino - 1;
+}
+
+struct inode *guestmemfs_inode_get(struct super_block *sb, unsigned long ino)
+{
+	struct inode *inode = iget_locked(sb, ino);
+
+	/* If this inode is cached it is already populated; just return */
+	if (!(inode->i_state & I_NEW))
+		return inode;
+	inode->i_op = &guestmemfs_dir_inode_operations;
+	inode->i_sb = sb;
+	inode->i_mode = S_IFREG;
+	unlock_new_inode(inode);
+	return inode;
+}
+
+static unsigned long guestmemfs_allocate_inode(struct super_block *sb)
+{
+
+	unsigned long next_free_ino = -ENOMEM;
+	struct guestmemfs_sb *psb = GUESTMEMFS_PSB(sb);
+
+	spin_lock(&psb->allocation_lock);
+	next_free_ino = psb->next_free_ino;
+	psb->allocated_inodes += 1;
+	if (!next_free_ino)
+		goto out;
+	psb->next_free_ino =
+		guestmemfs_get_persisted_inode(sb, next_free_ino)->sibling_ino;
+out:
+	spin_unlock(&psb->allocation_lock);
+	return next_free_ino;
+}
+
+/*
+ * Zeroes the inode and makes it the head of the free list.
+ */
+static void guestmemfs_free_inode(struct super_block *sb, unsigned long ino)
+{
+	struct guestmemfs_sb *psb = GUESTMEMFS_PSB(sb);
+	struct guestmemfs_inode *inode = guestmemfs_get_persisted_inode(sb, ino);
+
+	spin_lock(&psb->allocation_lock);
+	memset(inode, 0, sizeof(struct guestmemfs_inode));
+	inode->sibling_ino = psb->next_free_ino;
+	psb->next_free_ino = ino;
+	psb->allocated_inodes -= 1;
+	spin_unlock(&psb->allocation_lock);
+}
+
+/*
+ * Sets all inodes as free and points each free inode to the next one.
+ */
+void guestmemfs_initialise_inode_store(struct super_block *sb)
+{
+	/* Inode store is a PMD sized (ie: 2 MiB) page */
+	memset(guestmemfs_get_persisted_inode(sb, 1), 0, PMD_SIZE);
+	/* Point each inode for the next one; linked-list initialisation. */
+	for (unsigned long ino = 2; ino * sizeof(struct guestmemfs_inode) < PMD_SIZE; ino++)
+		guestmemfs_get_persisted_inode(sb, ino - 1)->sibling_ino = ino;
+}
+
+static int guestmemfs_create(struct mnt_idmap *id, struct inode *dir,
+			  struct dentry *dentry, umode_t mode, bool excl)
+{
+	unsigned long free_inode;
+	struct guestmemfs_inode *guestmemfs_inode;
+	struct inode *vfs_inode;
+
+	free_inode = guestmemfs_allocate_inode(dir->i_sb);
+	if (free_inode <= 0)
+		return -ENOMEM;
+
+	guestmemfs_inode = guestmemfs_get_persisted_inode(dir->i_sb, free_inode);
+	guestmemfs_inode->sibling_ino =
+		guestmemfs_get_persisted_inode(dir->i_sb, dir->i_ino)->child_ino;
+	guestmemfs_get_persisted_inode(dir->i_sb, dir->i_ino)->child_ino = free_inode;
+	strscpy(guestmemfs_inode->filename, dentry->d_name.name, GUESTMEMFS_FILENAME_LEN);
+	guestmemfs_inode->flags = GUESTMEMFS_INODE_FLAG_FILE;
+	/* TODO: make dynamic */
+	guestmemfs_inode->mappings = kzalloc(PAGE_SIZE, GFP_KERNEL);
+
+	vfs_inode = guestmemfs_inode_get(dir->i_sb, free_inode);
+	d_instantiate(dentry, vfs_inode);
+	return 0;
+}
+
+static struct dentry *guestmemfs_lookup(struct inode *dir,
+		struct dentry *dentry,
+		unsigned int flags)
+{
+	struct guestmemfs_inode *guestmemfs_inode;
+	unsigned long ino;
+
+	guestmemfs_inode = guestmemfs_get_persisted_inode(dir->i_sb, dir->i_ino);
+	ino = guestmemfs_inode->child_ino;
+	while (ino) {
+		guestmemfs_inode = guestmemfs_get_persisted_inode(dir->i_sb, ino);
+		if (!strncmp(guestmemfs_inode->filename,
+			     dentry->d_name.name,
+			     GUESTMEMFS_FILENAME_LEN)) {
+			d_add(dentry, guestmemfs_inode_get(dir->i_sb, ino));
+			break;
+		}
+		ino = guestmemfs_inode->sibling_ino;
+	}
+	return NULL;
+}
+
+static int guestmemfs_unlink(struct inode *dir, struct dentry *dentry)
+{
+	unsigned long ino;
+	struct guestmemfs_inode *inode;
+
+	ino = guestmemfs_get_persisted_inode(dir->i_sb, dir->i_ino)->child_ino;
+
+	/* Special case for first file in dir */
+	if (ino == dentry->d_inode->i_ino) {
+		guestmemfs_get_persisted_inode(dir->i_sb, dir->i_ino)->child_ino =
+			guestmemfs_get_persisted_inode(dir->i_sb,
+					dentry->d_inode->i_ino)->sibling_ino;
+		guestmemfs_free_inode(dir->i_sb, ino);
+		return 0;
+	}
+
+	/*
+	 * Although we know exactly the inode to free, because we maintain only
+	 * a singly linked list we need to scan for it to find the previous
+	 * element so it's "next" pointer can be updated.
+	 */
+	while (ino) {
+		inode = guestmemfs_get_persisted_inode(dir->i_sb, ino);
+		/* We've found the one pointing to the one we want to delete */
+		if (inode->sibling_ino == dentry->d_inode->i_ino) {
+			inode->sibling_ino =
+				guestmemfs_get_persisted_inode(dir->i_sb,
+						dentry->d_inode->i_ino)->sibling_ino;
+			guestmemfs_free_inode(dir->i_sb, dentry->d_inode->i_ino);
+			break;
+		}
+		ino = guestmemfs_get_persisted_inode(dir->i_sb, ino)->sibling_ino;
+	}
+
+	return 0;
+}
+
+const struct inode_operations guestmemfs_dir_inode_operations = {
+	.create		= guestmemfs_create,
+	.lookup		= guestmemfs_lookup,
+	.unlink		= guestmemfs_unlink,
+};
-- 
2.34.1


