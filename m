Return-Path: <linux-fsdevel+bounces-51563-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A414AD8429
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 09:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 178E83B1553
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 07:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C342C375F;
	Fri, 13 Jun 2025 07:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="j5SoKi7A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74CF2D6615;
	Fri, 13 Jun 2025 07:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800077; cv=none; b=BIrTAMKoYunLZrmUZB0rSKABDMTZd/UDF33zXHJfdZt1MUEeYg2+48ycN3OGCNzFPEJGV7bsk9BcCO3F7As+LuH8Ln2/uHaH11aN5wTa7kxe9RLbYhK4Qe17mf0fYmzEiCMe7YDZDOeYUQtMZIROoT9zLjmAAhiG1qfTGpUQ5gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800077; c=relaxed/simple;
	bh=rPk+dBRPzBSH06+QZrz6gdoCPrbe5VHJrSuN3aivzQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WBMmP63QylcfaunRmVwXkrtAqPRw7PiNlClLgDHvXFsvOe+RBIQ9UWNhPw/YXwKedtMjoufMH77SvR3tAp1J3C2MptINdJ+95+LAKJC57NDrOevdhkWRKLBSF2U2IuxRjj78pQd4t8pU7xbDvyRVk8WMSf9d3Y2quHz8r1q2xnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=j5SoKi7A; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=amqBZJV4/wwOVIDUHIGWUJtG3eawb1pwqvHrCjPwEPw=; b=j5SoKi7ACymShjBuhkM/42Gej0
	hNgLemeVdL7FqnBSaTPETNDCn3Sjs0nm+jCUpsnouqZ7B83DqOWtUwMlko8djVBtiKZrLKc120UIY
	0c0pBxvpLqyray/ndlYiUdq0JO+3pwKNP0QOcxDfYyD1oUIBbe/CxR4reST5Kve+vCtfO9UJDGJNQ
	7QTUhj0dnswKFxiqYJ8ouIsjW42DA08Bx9rC3Mv28HdgjUVAHjOJEgMnYeGzijI/RCm5T4sZCAVoN
	3mTla9J+uXVryiceDrMUpB8X2EpYbW+GxACg6mXQP9ZNN1fZ0TtE13SRXSmKqKpVlAL+fWCmSkn+j
	M7OgFG5Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPyvp-00000007qpK-0QWA;
	Fri, 13 Jun 2025 07:34:33 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: chuck.lever@oracle.com,
	jlayton@kernel.org,
	linux-nfs@vger.kernel.org,
	neil@brown.name,
	torvalds@linux-foundation.org,
	trondmy@kernel.org
Subject: [PATCH 02/17] new helper: simple_start_creating()
Date: Fri, 13 Jun 2025 08:34:17 +0100
Message-ID: <20250613073432.1871345-2-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613073432.1871345-1-viro@zeniv.linux.org.uk>
References: <20250613073149.GI1647736@ZenIV>
 <20250613073432.1871345-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Set the things up for kernel-initiated creation of object in
a tree-in-dcache filesystem.  With respect to locking it's
an equivalent of filename_create() - we either get a negative
dentry with locked parent, or ERR_PTR() and no locks taken.

tracefs and debugfs had that open-coded as part of their
object creation machinery; switched to calling new helper.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/debugfs/inode.c | 21 ++-------------------
 fs/libfs.c         | 25 +++++++++++++++++++++++++
 fs/tracefs/inode.c | 15 ++-------------
 include/linux/fs.h |  1 +
 4 files changed, 30 insertions(+), 32 deletions(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 30c4944e1862..08638e39bd12 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -384,26 +384,9 @@ static struct dentry *start_creating(const char *name, struct dentry *parent)
 	if (!parent)
 		parent = debugfs_mount->mnt_root;
 
-	inode_lock(d_inode(parent));
-	if (unlikely(IS_DEADDIR(d_inode(parent))))
-		dentry = ERR_PTR(-ENOENT);
-	else
-		dentry = lookup_noperm(&QSTR(name), parent);
-	if (!IS_ERR(dentry) && d_really_is_positive(dentry)) {
-		if (d_is_dir(dentry))
-			pr_err("Directory '%s' with parent '%s' already present!\n",
-			       name, parent->d_name.name);
-		else
-			pr_err("File '%s' in directory '%s' already present!\n",
-			       name, parent->d_name.name);
-		dput(dentry);
-		dentry = ERR_PTR(-EEXIST);
-	}
-
-	if (IS_ERR(dentry)) {
-		inode_unlock(d_inode(parent));
+	dentry = simple_start_creating(parent, name);
+	if (IS_ERR(dentry))
 		simple_release_fs(&debugfs_mount, &debugfs_mount_count);
-	}
 
 	return dentry;
 }
diff --git a/fs/libfs.c b/fs/libfs.c
index 42e226af6095..833ad5ed10f5 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -2260,3 +2260,28 @@ void stashed_dentry_prune(struct dentry *dentry)
 	 */
 	cmpxchg(stashed, dentry, NULL);
 }
+
+/* parent must be held exclusive */
+struct dentry *simple_start_creating(struct dentry *parent, const char *name)
+{
+	struct dentry *dentry;
+	struct inode *dir = d_inode(parent);
+
+	inode_lock(dir);
+	if (unlikely(IS_DEADDIR(dir))) {
+		inode_unlock(dir);
+		return ERR_PTR(-ENOENT);
+	}
+	dentry = lookup_noperm(&QSTR(name), parent);
+	if (IS_ERR(dentry)) {
+		inode_unlock(dir);
+		return dentry;
+	}
+	if (dentry->d_inode) {
+		dput(dentry);
+		inode_unlock(dir);
+		return ERR_PTR(-EEXIST);
+	}
+	return dentry;
+}
+EXPORT_SYMBOL(simple_start_creating);
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index a3fd3cc591bd..4e5d091e9263 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -551,20 +551,9 @@ struct dentry *tracefs_start_creating(const char *name, struct dentry *parent)
 	if (!parent)
 		parent = tracefs_mount->mnt_root;
 
-	inode_lock(d_inode(parent));
-	if (unlikely(IS_DEADDIR(d_inode(parent))))
-		dentry = ERR_PTR(-ENOENT);
-	else
-		dentry = lookup_noperm(&QSTR(name), parent);
-	if (!IS_ERR(dentry) && d_inode(dentry)) {
-		dput(dentry);
-		dentry = ERR_PTR(-EEXIST);
-	}
-
-	if (IS_ERR(dentry)) {
-		inode_unlock(d_inode(parent));
+	dentry = simple_start_creating(parent, name);
+	if (IS_ERR(dentry))
 		simple_release_fs(&tracefs_mount, &tracefs_mount_count);
-	}
 
 	return dentry;
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 96c7925a6551..9f75f8836bbd 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3619,6 +3619,7 @@ extern int simple_fill_super(struct super_block *, unsigned long,
 			     const struct tree_descr *);
 extern int simple_pin_fs(struct file_system_type *, struct vfsmount **mount, int *count);
 extern void simple_release_fs(struct vfsmount **mount, int *count);
+struct dentry *simple_start_creating(struct dentry *, const char *);
 
 extern ssize_t simple_read_from_buffer(void __user *to, size_t count,
 			loff_t *ppos, const void *from, size_t available);
-- 
2.39.5


