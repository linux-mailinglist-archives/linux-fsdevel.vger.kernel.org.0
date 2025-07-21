Return-Path: <linux-fsdevel+bounces-55573-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B74B0BF5B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 10:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D88F189B024
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 08:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB533289811;
	Mon, 21 Jul 2025 08:45:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FA8288C0D;
	Mon, 21 Jul 2025 08:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753087541; cv=none; b=T+S5huWXdkjulJKhSbfIT7tnh0bsthK9elpUT4QBoPUQqjv9axikRj9X/5pEfXh/JxIt7sGbLP4bB4Rnh6Cc6FNBsiJ/rb2/Yh0LaYwGDTYrNXkFSJk7oqQGvuQQ3VRWP/Sg4TnoeGjw5In+B68y/zLJtZJ4JGgfdhyjTNdaihA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753087541; c=relaxed/simple;
	bh=5G8ua6KcjgR3pcmj+D6mNI13dMJbQyQEVfel7UfMrRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cw9Nkz5Rs7Rwkm3YElJxxS12UriTQ/Xk8ViLiu048+Yt5n4vQX+rRSA+Uy3zkqPtwwXWJYh8ChLRjq3hXhDzEAJMeIWAK7UezWOGu4qauXeTiMxm6CZ++WoDzxgIqM2Hgh7/t4oklGYnXxjOfvhLkXmCGr1DJ3zBUH4h77+IPWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1udm9I-002pgF-TG;
	Mon, 21 Jul 2025 08:45:30 +0000
From: NeilBrown <neil@brown.name>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] VFS: introduce dentry_lock_in()
Date: Mon, 21 Jul 2025 18:00:03 +1000
Message-ID: <20250721084412.370258-8-neil@brown.name>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250721084412.370258-1-neil@brown.name>
References: <20250721084412.370258-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A few callers operate on a dentry which they already have - unlike the
normal case where a lookup proceeds an operation.

For these callers dentry_lock_in() is provided where other callers would
use dentry_lookup().  The call will fail if, after the lock was
gained, the child is no longer a child of the given parent.

When the operation completes done_dentry_lookup() must be called.  An
extra reference is taken when the dentry_lock_in() call succeeds
and will be dropped by done_dentry_lookup().

This will be used in smb/server, ecryptfs, and overlayfs, each of which
have their own lock_parent() or parent_lock() or similar; and a few
other places which lock the parent but don't check if the parent is
still correct (often because rename isn't supported so parent cannot be
incorrect).

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/namei.c            | 26 ++++++++++++++++++++++++++
 include/linux/namei.h |  1 +
 2 files changed, 27 insertions(+)

diff --git a/fs/namei.c b/fs/namei.c
index ae8079916ac6..ed656a1e458c 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1836,6 +1836,32 @@ struct dentry *dentry_lookup_killable(struct mnt_idmap *idmap,
 }
 EXPORT_SYMBOL(dentry_lookup_killable);
 
+/**
+ * dentry_lock_in: lock a dentry in given parent prior to dir ops
+ * @child: the dentry to lock
+ * @parent: the dentry of the assumed parent
+ *
+ * The child is locked - currently by taking i_rwsem on the parent - to
+ * prepare for create/remove operations.  If the given parent is no longer
+ * the parent of the dentry after the lock is gained, the lock is released
+ * and the call fails (returns %false).
+ *
+ * A reference is taken to the child on success.  The lock and reference
+ * must both be dropped by done_dentry_lookup() after the operation completes.
+ */
+bool dentry_lock_in(struct dentry *child, struct dentry *parent)
+{
+	inode_lock_nested(d_inode(parent), I_MUTEX_PARENT);
+	if (child->d_parent == parent) {
+		/* get the child to balance with done_dentry_lookup() which puts it. */
+		dget(child);
+		return true;
+	}
+	inode_unlock(d_inode(parent));
+	return false;
+}
+EXPORT_SYMBOL(dentry_lock_in);
+
 /**
  * done_dentry_lookup - finish a lookup used for create/delete
  * @dentry:  the target dentry
diff --git a/include/linux/namei.h b/include/linux/namei.h
index c86d9683563c..61ab251237e4 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -104,6 +104,7 @@ int rename_lookup(struct renamedata *rd, int lookup_flags);
 int rename_lookup_noperm(struct renamedata *rd, int lookup_flags);
 int rename_lookup_hashed(struct renamedata *rd, int lookup_flags);
 void done_rename_lookup(struct renamedata *rd);
+bool dentry_lock_in(struct dentry *child, struct dentry *parent);
 
 /**
  * mode_strip_umask - handle vfs umask stripping
-- 
2.49.0


