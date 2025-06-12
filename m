Return-Path: <linux-fsdevel+bounces-51381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECCAAD65F4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 05:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05EE03AC2C7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 03:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6825B1EA7CB;
	Thu, 12 Jun 2025 03:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="v44B1gu0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78CF1DE2A0;
	Thu, 12 Jun 2025 03:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749697918; cv=none; b=PGLL+FKHXrKHR54XsullaJvZkwndzseWZNWAbJocrVEKsYNFNu93fWnUCMT+sG4VAFTR0Yzo75yjAGSil7XH/5FKs1bDHSoCPQG3TLDnQqD0T5/ixSJBgm52ax6KwSXQo+SyWRtdL7HnjKlDmQPfIiflYkLAbE0kyVzG67lTbjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749697918; c=relaxed/simple;
	bh=opUKpIaNFtqm/5dS7ENX7hvRgjppdujBjP3hXnIaQ2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o3dVC9q2zuR8S2PT0DYMex3YgVRoe3fztpiAN7wQRF0wnpSV32QD6wjPZuZgEfBGX71xXJxHixreeU/RsPlg3KrxFbIQ/X/fUBOqKCNd9ePl97Smvm1c7OusHVGAvUYgZJ7DpUF6mw8DNArU0nHily1w4tWUqaQW4YrcgUQqMxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=v44B1gu0; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=AQfCSccKNyq4yjyNQBHtHMepBBxown1xuQNMPqF2h+E=; b=v44B1gu06Om5P2Yofte5z4QFRA
	R3+M7Gyk/JL8zXNOCBZahS273ofDZWXpYhJEoxgsnCNpiGIsVN/980X++NrBn9YzmgAu0Tn+w/hDr
	bdE1mlePEDOM3pk0ZvwmL13puM6s9c62T/n0iwvAYh6ahRUgqinNyKmSxjk8KvRZJEdV/Up10hhXb
	u8zcFeA+MOLqiUxeCBGN6MYjjNKZ+4oBxJviXYCLsX9ZN0o+OvQdSbya/urcNl5xCWlsRbncLrNL2
	6sMlQ0H30rYJFvA3ocNYameb7K6NwSo+tvMW6AT4daVuA7nsl5PtU9nY5V9tBu18TxncYNa2TOU9X
	QgRh8dNA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPYM7-00000009gew-1JXa;
	Thu, 12 Jun 2025 03:11:55 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-integrity@vger.kernel.org
Subject: [PATCH 04/10] make securityfs_remove() remove the entire subtree
Date: Thu, 12 Jun 2025 04:11:48 +0100
Message-ID: <20250612031154.2308915-4-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250612031154.2308915-1-viro@zeniv.linux.org.uk>
References: <20250612030951.GC1647736@ZenIV>
 <20250612031154.2308915-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

... and fix the mount leak when anything's mounted there.
securityfs_recursive_remove becomes an alias for securityfs_remove -
we'll probably need to remove it in a cycle or two.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/linux/security.h |  3 ++-
 security/inode.c         | 47 +++++++++-------------------------------
 2 files changed, 12 insertions(+), 38 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index dba349629229..386463b5e848 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -2211,7 +2211,6 @@ struct dentry *securityfs_create_symlink(const char *name,
 					 const char *target,
 					 const struct inode_operations *iops);
 extern void securityfs_remove(struct dentry *dentry);
-extern void securityfs_recursive_remove(struct dentry *dentry);
 
 #else /* CONFIG_SECURITYFS */
 
@@ -2243,6 +2242,8 @@ static inline void securityfs_remove(struct dentry *dentry)
 
 #endif
 
+#define securityfs_recursive_remove securityfs_remove
+
 #ifdef CONFIG_BPF_SYSCALL
 union bpf_attr;
 struct bpf_map;
diff --git a/security/inode.c b/security/inode.c
index 1ecb8859c272..43382ef8896e 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -281,6 +281,12 @@ struct dentry *securityfs_create_symlink(const char *name,
 }
 EXPORT_SYMBOL_GPL(securityfs_create_symlink);
 
+static void remove_one(struct dentry *victim)
+{
+	if (victim->d_parent == victim->d_sb->s_root)
+		simple_release_fs(&mount, &mount_count);
+}
+
 /**
  * securityfs_remove - removes a file or directory from the securityfs filesystem
  *
@@ -293,44 +299,11 @@ EXPORT_SYMBOL_GPL(securityfs_create_symlink);
  * This function is required to be called in order for the file to be
  * removed. No automatic cleanup of files will happen when a module is
  * removed; you are responsible here.
- */
-void securityfs_remove(struct dentry *dentry)
-{
-	struct inode *dir;
-
-	if (IS_ERR_OR_NULL(dentry))
-		return;
-
-	dir = d_inode(dentry->d_parent);
-	inode_lock(dir);
-	if (simple_positive(dentry)) {
-		if (d_is_dir(dentry))
-			simple_rmdir(dir, dentry);
-		else
-			simple_unlink(dir, dentry);
-	}
-	inode_unlock(dir);
-	if (dir == dir->i_sb->s_root->d_inode)
-		simple_release_fs(&mount, &mount_count);
-}
-EXPORT_SYMBOL_GPL(securityfs_remove);
-
-static void remove_one(struct dentry *victim)
-{
-	if (victim->d_parent == victim->d_sb->s_root)
-		simple_release_fs(&mount, &mount_count);
-}
-
-/**
- * securityfs_recursive_remove - recursively removes a file or directory
- *
- * @dentry: a pointer to a the dentry of the file or directory to be removed.
  *
- * This function recursively removes a file or directory in securityfs that was
- * previously created with a call to another securityfs function (like
- * securityfs_create_file() or variants thereof.)
+ * AV: when applied to directory it will take all children out; no need to call
+ * it for descendents if ancestor is getting killed.
  */
-void securityfs_recursive_remove(struct dentry *dentry)
+void securityfs_remove(struct dentry *dentry)
 {
 	if (IS_ERR_OR_NULL(dentry))
 		return;
@@ -339,7 +312,7 @@ void securityfs_recursive_remove(struct dentry *dentry)
 	simple_recursive_removal(dentry, remove_one);
 	simple_release_fs(&mount, &mount_count);
 }
-EXPORT_SYMBOL_GPL(securityfs_recursive_remove);
+EXPORT_SYMBOL_GPL(securityfs_remove);
 
 #ifdef CONFIG_SECURITY
 static struct dentry *lsm_dentry;
-- 
2.39.5


