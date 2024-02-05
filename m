Return-Path: <linux-fsdevel+bounces-10272-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA3984997F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 13:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FD121C2262A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 12:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4931B951;
	Mon,  5 Feb 2024 12:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="TA0K/s1I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5331B7FC;
	Mon,  5 Feb 2024 12:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707134551; cv=none; b=YtqlS9XWObXzGjvXO4VGj97Cfts5pzf17z4It4SHLmTQhFhcpb6E05grmxwGbtJq41X5gF6mOpr4918jN9QwGm++H1n/pKUvw2sxkrXf3Z+B2yjB9XsFta703QnLpq15zizBMqzsyYdowRFVYwDNSGe3oDB6Purbes2H2WnTld4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707134551; c=relaxed/simple;
	bh=SnpnjsIe5mX0+E5JVEhCwr63Ah3ckizateAvEwVUJoo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QH326F/wTJacONs6mn3+FHQ4TbeWa+g3aaQRHrQMyg3MfpiMp6ryYETf/oQJ9ZZVO7HOJYnevAsYPOACpqpsB77wTWSFOnc0N0nnqGLIcaDU+gzNwvUSyNSoTLt+XjDAc5wo9La1rWKBu2ddDv3DZYjAoh7uIBE0KVdowWGQIpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=TA0K/s1I; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1707134550; x=1738670550;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DNmTqGFg0B4wwqijKuh2wndJnn1CFCRShUGGQJLOmFw=;
  b=TA0K/s1IJHf/prFJ+13DsO3hRi6rIgNVOyxZkj9Mc4tZPsOBC4X0GPps
   4beNfJUsnGEfWYwxzHtz+IGhFINgJh5da5qq9tB4yyUzCYKcIS3rOnkyO
   FTdoHF0fuS35Wad33aVxPAF3orkzA+n9bitGEca8aj8giW0lsHjNSMJSJ
   o=;
X-IronPort-AV: E=Sophos;i="6.05,245,1701129600"; 
   d="scan'208";a="271936637"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 12:02:28 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.43.254:3818]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.33.186:2525] with esmtp (Farcaster)
 id e767a7b8-4373-41b8-af32-a81e33b618aa; Mon, 5 Feb 2024 12:02:27 +0000 (UTC)
X-Farcaster-Flow-ID: e767a7b8-4373-41b8-af32-a81e33b618aa
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 5 Feb 2024 12:02:26 +0000
Received: from dev-dsk-jgowans-1a-a3faec1f.eu-west-1.amazon.com
 (172.19.112.191) by EX19D014EUC004.ant.amazon.com (10.252.51.182) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 5 Feb
 2024 12:02:20 +0000
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
Subject: [RFC 02/18] pkernfs: Add persistent inodes hooked into directies
Date: Mon, 5 Feb 2024 12:01:47 +0000
Message-ID: <20240205120203.60312-3-jgowans@amazon.com>
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

Add the ability to create inodes for files and directories inside
directories. Inodes are persistent in the in-memory filesystem; the
second 2 MiB is used as an "inode store." The inode store is one big array
of struct pkernfs_inodes and they use a linked list to point to the next
sibling inode or in the case of a directory the child inode which is the
first inode in that directory.

Free inodese are similarly maintained in a linked list with the first
free inode being pointed to by the super block.

Directory file_operations are added to support iterating through the
content of a directory.

Simiarly inode operations are added to support creating a file inside a
directory. This allocate the next free inode and makes it the head of
tthe "child inode" linked list for the directory. Unlink is implemented
to remove an inode from the linked list. This is a bit finicky as it is
done differently depending on whether the inode is the first child of a
directory or somewhere later in the linked list.
---
 fs/pkernfs/Makefile  |   2 +-
 fs/pkernfs/dir.c     |  43 +++++++++++++
 fs/pkernfs/inode.c   | 148 +++++++++++++++++++++++++++++++++++++++++++
 fs/pkernfs/pkernfs.c |  13 ++--
 fs/pkernfs/pkernfs.h |  34 ++++++++++
 5 files changed, 234 insertions(+), 6 deletions(-)
 create mode 100644 fs/pkernfs/dir.c
 create mode 100644 fs/pkernfs/inode.c

diff --git a/fs/pkernfs/Makefile b/fs/pkernfs/Makefile
index 17258cb77f58..0a66e98bda07 100644
--- a/fs/pkernfs/Makefile
+++ b/fs/pkernfs/Makefile
@@ -3,4 +3,4 @@
 # Makefile for persistent kernel filesystem
 #
 
-obj-$(CONFIG_PKERNFS_FS) += pkernfs.o
+obj-$(CONFIG_PKERNFS_FS) += pkernfs.o inode.o dir.o
diff --git a/fs/pkernfs/dir.c b/fs/pkernfs/dir.c
new file mode 100644
index 000000000000..b10ce745f19d
--- /dev/null
+++ b/fs/pkernfs/dir.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "pkernfs.h"
+
+static int pkernfs_dir_iterate(struct file *dir, struct dir_context *ctx)
+{
+	struct pkernfs_inode *pkernfs_inode;
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
+		ctx->pos = pkernfs_get_persisted_inode(sb, dir->f_inode->i_ino)->child_ino;
+		/* Empty dir case. */
+		if (ctx->pos == 0)
+			ctx->pos = -1;
+	}
+
+	while (ctx->pos > 1) {
+		pkernfs_inode = pkernfs_get_persisted_inode(sb, ctx->pos);
+		dir_emit(ctx, pkernfs_inode->filename, PKERNFS_FILENAME_LEN,
+				ctx->pos, DT_UNKNOWN);
+		ctx->pos = pkernfs_inode->sibling_ino;
+		if (!ctx->pos)
+			ctx->pos = -1;
+	}
+	return 0;
+}
+
+const struct file_operations pkernfs_dir_fops = {
+	.owner = THIS_MODULE,
+	.iterate_shared = pkernfs_dir_iterate,
+};
diff --git a/fs/pkernfs/inode.c b/fs/pkernfs/inode.c
new file mode 100644
index 000000000000..f6584c8b8804
--- /dev/null
+++ b/fs/pkernfs/inode.c
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "pkernfs.h"
+#include <linux/fs.h>
+
+const struct inode_operations pkernfs_dir_inode_operations;
+
+struct pkernfs_inode *pkernfs_get_persisted_inode(struct super_block *sb, int ino)
+{
+	/*
+	 * Inode index starts at 1, so -1 to get memory index.
+	 */
+	return ((struct pkernfs_inode *) (pkernfs_mem + PMD_SIZE)) + ino - 1;
+}
+
+struct inode *pkernfs_inode_get(struct super_block *sb, unsigned long ino)
+{
+	struct inode *inode = iget_locked(sb, ino);
+
+	/* If this inode is cached it is already populated; just return */
+	if (!(inode->i_state & I_NEW))
+		return inode;
+	inode->i_op = &pkernfs_dir_inode_operations;
+	inode->i_sb = sb;
+	inode->i_mode = S_IFREG;
+	unlock_new_inode(inode);
+	return inode;
+}
+
+static unsigned long pkernfs_allocate_inode(struct super_block *sb)
+{
+
+	unsigned long next_free_ino;
+	struct pkernfs_sb *psb = (struct pkernfs_sb *) pkernfs_mem;
+
+	next_free_ino = psb->next_free_ino;
+	if (!next_free_ino)
+		return -ENOMEM;
+	psb->next_free_ino =
+		pkernfs_get_persisted_inode(sb, next_free_ino)->sibling_ino;
+	return next_free_ino;
+}
+
+/*
+ * Zeroes the inode and makes it the head of the free list.
+ */
+static void pkernfs_free_inode(struct super_block *sb, unsigned long ino)
+{
+	struct pkernfs_sb *psb = (struct pkernfs_sb *) pkernfs_mem;
+	struct pkernfs_inode *inode = pkernfs_get_persisted_inode(sb, ino);
+
+	memset(inode, 0, sizeof(struct pkernfs_inode));
+	inode->sibling_ino = psb->next_free_ino;
+	psb->next_free_ino = ino;
+}
+
+void pkernfs_initialise_inode_store(struct super_block *sb)
+{
+	/* Inode store is a PMD sized (ie: 2 MiB) page */
+	memset(pkernfs_get_persisted_inode(sb, 1), 0, PMD_SIZE);
+	/* Point each inode for the next one; linked-list initialisation. */
+	for (unsigned long ino = 2; ino * sizeof(struct pkernfs_inode) < PMD_SIZE; ino++)
+		pkernfs_get_persisted_inode(sb, ino - 1)->sibling_ino = ino;
+}
+
+static int pkernfs_create(struct mnt_idmap *id, struct inode *dir,
+			  struct dentry *dentry, umode_t mode, bool excl)
+{
+	unsigned long free_inode;
+	struct pkernfs_inode *pkernfs_inode;
+	struct inode *vfs_inode;
+
+	free_inode = pkernfs_allocate_inode(dir->i_sb);
+	if (free_inode <= 0)
+		return -ENOMEM;
+
+	pkernfs_inode = pkernfs_get_persisted_inode(dir->i_sb, free_inode);
+	pkernfs_inode->sibling_ino = pkernfs_get_persisted_inode(dir->i_sb, dir->i_ino)->child_ino;
+	pkernfs_get_persisted_inode(dir->i_sb, dir->i_ino)->child_ino = free_inode;
+	strscpy(pkernfs_inode->filename, dentry->d_name.name, PKERNFS_FILENAME_LEN);
+	pkernfs_inode->flags = PKERNFS_INODE_FLAG_FILE;
+
+	vfs_inode = pkernfs_inode_get(dir->i_sb, free_inode);
+	d_instantiate(dentry, vfs_inode);
+	return 0;
+}
+
+static struct dentry *pkernfs_lookup(struct inode *dir,
+		struct dentry *dentry,
+		unsigned int flags)
+{
+	struct pkernfs_inode *pkernfs_inode;
+	unsigned long ino;
+
+	pkernfs_inode = pkernfs_get_persisted_inode(dir->i_sb, dir->i_ino);
+	ino = pkernfs_inode->child_ino;
+	while (ino) {
+		pkernfs_inode = pkernfs_get_persisted_inode(dir->i_sb, ino);
+		if (!strncmp(pkernfs_inode->filename, dentry->d_name.name, PKERNFS_FILENAME_LEN)) {
+			d_add(dentry, pkernfs_inode_get(dir->i_sb, ino));
+			break;
+		}
+		ino = pkernfs_inode->sibling_ino;
+	}
+	return NULL;
+}
+
+static int pkernfs_unlink(struct inode *dir, struct dentry *dentry)
+{
+	unsigned long ino;
+	struct pkernfs_inode *inode;
+
+	ino = pkernfs_get_persisted_inode(dir->i_sb, dir->i_ino)->child_ino;
+
+	/* Special case for first file in dir */
+	if (ino == dentry->d_inode->i_ino) {
+		pkernfs_get_persisted_inode(dir->i_sb, dir->i_ino)->child_ino =
+			pkernfs_get_persisted_inode(dir->i_sb, dentry->d_inode->i_ino)->sibling_ino;
+		pkernfs_free_inode(dir->i_sb, ino);
+		return 0;
+	}
+
+	/*
+	 * Although we know exactly the inode to free, because we maintain only
+	 * a singly linked list we need to scan for it to find the previous
+	 * element so it's "next" pointer can be updated.
+	 */
+	while (ino) {
+		inode = pkernfs_get_persisted_inode(dir->i_sb, ino);
+		/* We've found the one pointing to the one we want to delete */
+		if (inode->sibling_ino == dentry->d_inode->i_ino) {
+			inode->sibling_ino =
+				pkernfs_get_persisted_inode(dir->i_sb,
+						dentry->d_inode->i_ino)->sibling_ino;
+			pkernfs_free_inode(dir->i_sb, dentry->d_inode->i_ino);
+			break;
+		}
+		ino = pkernfs_get_persisted_inode(dir->i_sb, ino)->sibling_ino;
+	}
+
+	return 0;
+}
+
+const struct inode_operations pkernfs_dir_inode_operations = {
+	.create		= pkernfs_create,
+	.lookup		= pkernfs_lookup,
+	.unlink		= pkernfs_unlink,
+};
diff --git a/fs/pkernfs/pkernfs.c b/fs/pkernfs/pkernfs.c
index 4c476ddc35b6..518c610e3877 100644
--- a/fs/pkernfs/pkernfs.c
+++ b/fs/pkernfs/pkernfs.c
@@ -8,7 +8,7 @@
 #include <linux/io.h>
 
 static phys_addr_t pkernfs_base, pkernfs_size;
-static void *pkernfs_mem;
+void *pkernfs_mem;
 static const struct super_operations pkernfs_super_ops = { };
 
 static int pkernfs_fill_super(struct super_block *sb, struct fs_context *fc)
@@ -24,23 +24,26 @@ static int pkernfs_fill_super(struct super_block *sb, struct fs_context *fc)
 		pr_info("pkernfs: Restoring from super block\n");
 	} else {
 		pr_info("pkernfs: Clean super block; initialising\n");
+		pkernfs_initialise_inode_store(sb);
 		psb->magic_number = PKERNFS_MAGIC_NUMBER;
+		pkernfs_get_persisted_inode(sb, 1)->flags = PKERNFS_INODE_FLAG_DIR;
+		strscpy(pkernfs_get_persisted_inode(sb, 1)->filename, ".", PKERNFS_FILENAME_LEN);
+		psb->next_free_ino = 2;
 	}
 
 	sb->s_op = &pkernfs_super_ops;
 
-	inode = new_inode(sb);
+	inode = pkernfs_inode_get(sb, 1);
 	if (!inode)
 		return -ENOMEM;
 
-	inode->i_ino = 1;
 	inode->i_mode = S_IFDIR;
-	inode->i_op = &simple_dir_inode_operations;
-	inode->i_fop = &simple_dir_operations;
+	inode->i_fop = &pkernfs_dir_fops;
 	inode->i_atime = inode->i_mtime = current_time(inode);
 	inode_set_ctime_current(inode);
 	/* directory inodes start off with i_nlink == 2 (for "." entry) */
 	inc_nlink(inode);
+	inode_init_owner(&nop_mnt_idmap, inode, NULL, inode->i_mode);
 
 	dentry = d_make_root(inode);
 	if (!dentry)
diff --git a/fs/pkernfs/pkernfs.h b/fs/pkernfs/pkernfs.h
index bd1e2a6fd336..192e089b3151 100644
--- a/fs/pkernfs/pkernfs.h
+++ b/fs/pkernfs/pkernfs.h
@@ -1,6 +1,40 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 
+#include <linux/fs.h>
+
 #define PKERNFS_MAGIC_NUMBER 0x706b65726e6673
+#define PKERNFS_FILENAME_LEN 255
+
+extern void *pkernfs_mem;
+
 struct pkernfs_sb {
 	unsigned long magic_number;
+	/* Inode number */
+	unsigned long next_free_ino;
 };
+
+// If neither of these are set the inode is not in use.
+#define PKERNFS_INODE_FLAG_FILE (1 << 0)
+#define PKERNFS_INODE_FLAG_DIR (1 << 1)
+struct pkernfs_inode {
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
+	char filename[PKERNFS_FILENAME_LEN];
+	int mappings_block;
+	int num_mappings;
+};
+
+void pkernfs_initialise_inode_store(struct super_block *sb);
+struct inode *pkernfs_inode_get(struct super_block *sb, unsigned long ino);
+struct pkernfs_inode *pkernfs_get_persisted_inode(struct super_block *sb, int ino);
+
+extern const struct file_operations pkernfs_dir_fops;
-- 
2.40.1


