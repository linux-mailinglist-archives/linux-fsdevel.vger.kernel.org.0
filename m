Return-Path: <linux-fsdevel+bounces-3629-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3EC7F6C1A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 07:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FB051C20D69
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 06:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C1EB657;
	Fri, 24 Nov 2023 06:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="hXW91hAN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1463D44A4;
	Thu, 23 Nov 2023 22:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=B1X78vH2EK6xtt4sX5MLSg7Z1A4nnx4CSDuwtSnEsEM=; b=hXW91hANNIJU7PhgtOogFK1YDK
	tfd7OaNmw1Q0pW7EtZxAdF/DPmfxe7liGRaCPZtB8lNEeCJ7uQfaok28uzCL4d+zQ60CPtIJVaZ0l
	wJigxpkzi0NjzzmIAd8q2xoax5hgW4qO7RYfl6BFQVOzwBnzEmq23KAi3wN/In832qKsrh3tl9Kju
	nZEYbODZL4VqViUGEmEHBwRO5sD/rfyABx/KnT1COmOhj0jZnjqJg72Un5nXh4Ymifl2XaEJG+oFf
	K8EQp63AHVudgWR8/attM4tbTTtnLXXlrXwhlOn54t6pauzligOzgG5VTqIBcyQk1T5bkgIgy4tEu
	voc7ww9g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r6PKv-002Q0Z-18;
	Fri, 24 Nov 2023 06:06:45 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/20] DCACHE_... ->d_flags bits: switch to BIT()
Date: Fri, 24 Nov 2023 06:06:29 +0000
Message-Id: <20231124060644.576611-5-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231124060644.576611-1-viro@zeniv.linux.org.uk>
References: <20231124060553.GA575483@ZenIV>
 <20231124060644.576611-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

For bits 20..22 (inode type cached in ->d_flags) turn the definitions into
expressions like (5 << 20); everything else turns into straight use of
BIT()

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/linux/dcache.h | 76 +++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 1d9f7f132055..d9c314cc93b8 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -151,13 +151,13 @@ struct dentry_operations {
  */
 
 /* d_flags entries */
-#define DCACHE_OP_HASH			0x00000001
-#define DCACHE_OP_COMPARE		0x00000002
-#define DCACHE_OP_REVALIDATE		0x00000004
-#define DCACHE_OP_DELETE		0x00000008
-#define DCACHE_OP_PRUNE			0x00000010
+#define DCACHE_OP_HASH			BIT(0)
+#define DCACHE_OP_COMPARE		BIT(1)
+#define DCACHE_OP_REVALIDATE		BIT(2)
+#define DCACHE_OP_DELETE		BIT(3)
+#define DCACHE_OP_PRUNE			BIT(4)
 
-#define	DCACHE_DISCONNECTED		0x00000020
+#define	DCACHE_DISCONNECTED		BIT(5)
      /* This dentry is possibly not currently connected to the dcache tree, in
       * which case its parent will either be itself, or will have this flag as
       * well.  nfsd will not use a dentry with this bit set, but will first
@@ -168,50 +168,50 @@ struct dentry_operations {
       * dentry into place and return that dentry rather than the passed one,
       * typically using d_splice_alias. */
 
-#define DCACHE_REFERENCED		0x00000040 /* Recently used, don't discard. */
+#define DCACHE_REFERENCED		BIT(6) /* Recently used, don't discard. */
 
-#define DCACHE_DONTCACHE		0x00000080 /* Purge from memory on final dput() */
+#define DCACHE_DONTCACHE		BIT(7) /* Purge from memory on final dput() */
 
-#define DCACHE_CANT_MOUNT		0x00000100
-#define DCACHE_GENOCIDE			0x00000200
-#define DCACHE_SHRINK_LIST		0x00000400
+#define DCACHE_CANT_MOUNT		BIT(8)
+#define DCACHE_GENOCIDE			BIT(9)
+#define DCACHE_SHRINK_LIST		BIT(10)
 
-#define DCACHE_OP_WEAK_REVALIDATE	0x00000800
+#define DCACHE_OP_WEAK_REVALIDATE	BIT(11)
 
-#define DCACHE_NFSFS_RENAMED		0x00001000
+#define DCACHE_NFSFS_RENAMED		BIT(12)
      /* this dentry has been "silly renamed" and has to be deleted on the last
       * dput() */
-#define DCACHE_COOKIE			0x00002000 /* For use by dcookie subsystem */
-#define DCACHE_FSNOTIFY_PARENT_WATCHED	0x00004000
+#define DCACHE_COOKIE			BIT(13) /* For use by dcookie subsystem */
+#define DCACHE_FSNOTIFY_PARENT_WATCHED	BIT(14)
      /* Parent inode is watched by some fsnotify listener */
 
-#define DCACHE_DENTRY_KILLED		0x00008000
+#define DCACHE_DENTRY_KILLED		BIT(15)
 
-#define DCACHE_MOUNTED			0x00010000 /* is a mountpoint */
-#define DCACHE_NEED_AUTOMOUNT		0x00020000 /* handle automount on this dir */
-#define DCACHE_MANAGE_TRANSIT		0x00040000 /* manage transit from this dirent */
+#define DCACHE_MOUNTED			BIT(16) /* is a mountpoint */
+#define DCACHE_NEED_AUTOMOUNT		BIT(17) /* handle automount on this dir */
+#define DCACHE_MANAGE_TRANSIT		BIT(18) /* manage transit from this dirent */
 #define DCACHE_MANAGED_DENTRY \
 	(DCACHE_MOUNTED|DCACHE_NEED_AUTOMOUNT|DCACHE_MANAGE_TRANSIT)
 
-#define DCACHE_LRU_LIST			0x00080000
-
-#define DCACHE_ENTRY_TYPE		0x00700000
-#define DCACHE_MISS_TYPE		0x00000000 /* Negative dentry (maybe fallthru to nowhere) */
-#define DCACHE_WHITEOUT_TYPE		0x00100000 /* Whiteout dentry (stop pathwalk) */
-#define DCACHE_DIRECTORY_TYPE		0x00200000 /* Normal directory */
-#define DCACHE_AUTODIR_TYPE		0x00300000 /* Lookupless directory (presumed automount) */
-#define DCACHE_REGULAR_TYPE		0x00400000 /* Regular file type (or fallthru to such) */
-#define DCACHE_SPECIAL_TYPE		0x00500000 /* Other file type (or fallthru to such) */
-#define DCACHE_SYMLINK_TYPE		0x00600000 /* Symlink (or fallthru to such) */
-
-#define DCACHE_MAY_FREE			0x00800000
-#define DCACHE_FALLTHRU			0x01000000 /* Fall through to lower layer */
-#define DCACHE_NOKEY_NAME		0x02000000 /* Encrypted name encoded without key */
-#define DCACHE_OP_REAL			0x04000000
-
-#define DCACHE_PAR_LOOKUP		0x10000000 /* being looked up (with parent locked shared) */
-#define DCACHE_DENTRY_CURSOR		0x20000000
-#define DCACHE_NORCU			0x40000000 /* No RCU delay for freeing */
+#define DCACHE_LRU_LIST			BIT(19)
+
+#define DCACHE_ENTRY_TYPE		(7 << 20) /* bits 20..22 are for storing type: */
+#define DCACHE_MISS_TYPE		(0 << 20) /* Negative dentry (maybe fallthru to nowhere) */
+#define DCACHE_WHITEOUT_TYPE		(1 << 20) /* Whiteout dentry (stop pathwalk) */
+#define DCACHE_DIRECTORY_TYPE		(2 << 20) /* Normal directory */
+#define DCACHE_AUTODIR_TYPE		(3 << 20) /* Lookupless directory (presumed automount) */
+#define DCACHE_REGULAR_TYPE		(4 << 20) /* Regular file type (or fallthru to such) */
+#define DCACHE_SPECIAL_TYPE		(5 << 20) /* Other file type (or fallthru to such) */
+#define DCACHE_SYMLINK_TYPE		(6 << 20) /* Symlink (or fallthru to such) */
+
+#define DCACHE_MAY_FREE			BIT(23)
+#define DCACHE_FALLTHRU			BIT(24) /* Fall through to lower layer */
+#define DCACHE_NOKEY_NAME		BIT(25) /* Encrypted name encoded without key */
+#define DCACHE_OP_REAL			BIT(26)
+
+#define DCACHE_PAR_LOOKUP		BIT(28) /* being looked up (with parent locked shared) */
+#define DCACHE_DENTRY_CURSOR		BIT(29)
+#define DCACHE_NORCU			BIT(30) /* No RCU delay for freeing */
 
 extern seqlock_t rename_lock;
 
-- 
2.39.2


