Return-Path: <linux-fsdevel+bounces-51253-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB35AD4D99
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 09:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 128643A3891
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 07:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DB5246781;
	Wed, 11 Jun 2025 07:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="qPXKqU4z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8AC23A9BB
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 07:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749628483; cv=none; b=AHOR9Q0gxQt+gdRqiCcKZzjdyf6ekl/JBCpXb/OZXV4LCzM4tnyTmmCyJitInmmCzghIdmKmeNXAgHFhEQrKBVrdXI71shYScGuk1iXQdyja0BkY14RtQxhkr5Sy3G95YZsln5I0Vc24MDLzQiLw99tEKpuvs1Yrji8YAX5vjZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749628483; c=relaxed/simple;
	bh=DXEmwGZxD5UOWR/aTl0ZzDHFyT521qfOKXXD/2fSzTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JA/HM+Fy+Wng/EGio5PlgoEZ2u/EY4jY1rYAPytBhxj5eabwG0BMI1sBekvjoMbAF1h0edKauYtWO8Zl4/SZYYuKPdwPPefoZ48HwE4yQUR6rl5nQDs67/Dj680jHXcyJ50vLn144k8PH+u/2qHzMSE5GUHDHvEae4OYFZpboBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=qPXKqU4z; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=YQD4zswUKu7HeNvMVguFKxDx5AH4ovTMc1kUCwA2zgw=; b=qPXKqU4zz9RYWM87uKJzKhRUd8
	awLfwsyNBjBe8KOPwZ3OrDBStu2FTRDjRi2eNr+uB98MuYSeSd9PlxLoi9oZApR4fJNFctmwWCcdH
	Y4bPKHFpfwGCLmqoG5nIzllX9YbAAGgeZG3Wz8Cqz+HeRHTW+FAQWj63jKAMdURRus5AFT7fyxH3u
	G2VR1/mJZ0O1NIW8VvJVyJ2ULx6h/eP/ecAlGJVmofoJR4HAv5V540YbPC/KQNborXgOOuRE/tS78
	6/5VsiX6ZAywIfXMXTYz03dbjfop3ppPta8sS0P0fdP6DmPKVYgsUrMAL0/sGSTgADMAm3VTdm9US
	my87EK1g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPGIA-0000000HTw6-0enH;
	Wed, 11 Jun 2025 07:54:38 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	miklos@szeredi.hu,
	neilb@suse.de,
	torvalds@linux-foundation.org
Subject: [PATCH v2 03/21] new helper: d_splice_alias_ops()
Date: Wed, 11 Jun 2025 08:54:19 +0100
Message-ID: <20250611075437.4166635-3-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611075437.4166635-1-viro@zeniv.linux.org.uk>
References: <20250611075023.GJ299672@ZenIV>
 <20250611075437.4166635-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Uses of d_set_d_op() on live dentry can be very dangerous; it is going
to be withdrawn and replaced with saner things.

The best way for a filesystem is to have the default dentry_operations
set at mount time and be done with that - __d_alloc() will use that.

Currently there are two cases when d_set_d_op() is used on a live dentry -
one is procfs, which has several genuinely different dentry_operations
instances (different ->d_revalidate(), etc.) and another is
simple_lookup(), where we would be better off without overriding ->d_op.

For procfs we have d_set_d_op() calls followed by d_splice_alias();
provide a new helper (d_splice_alias_ops(inode, dentry, d_ops)) that would
combine those two, and do the d_set_d_op() part while under ->d_lock.
That eliminates one of the places where ->d_flags had been modified
without holding ->d_lock; current behaviour is not racy, but the reasons
for that are far too brittle.  Better move to uniform locking rules and
simpler proof of correctness...

The next commit will convert procfs to use of that helper; it is not
exported and won't be until somebody comes up with convincing modular
user for it.

Again, the best approach is to have default ->d_op and let __d_alloc()
do the right thing; filesystem _may_ need non-uniform ->d_op (procfs
does), but there'd better be good reasons for that.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c            | 63 ++++++++++++++++++++++++------------------
 include/linux/dcache.h |  3 ++
 2 files changed, 39 insertions(+), 27 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 3c3cfb345233..bf550d438e40 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2667,7 +2667,8 @@ EXPORT_SYMBOL(__d_lookup_unhash_wake);
 
 /* inode->i_lock held if inode is non-NULL */
 
-static inline void __d_add(struct dentry *dentry, struct inode *inode)
+static inline void __d_add(struct dentry *dentry, struct inode *inode,
+			   const struct dentry_operations *ops)
 {
 	wait_queue_head_t *d_wait;
 	struct inode *dir = NULL;
@@ -2678,6 +2679,8 @@ static inline void __d_add(struct dentry *dentry, struct inode *inode)
 		n = start_dir_add(dir);
 		d_wait = __d_lookup_unhash(dentry);
 	}
+	if (unlikely(ops))
+		d_set_d_op(dentry, ops);
 	if (inode) {
 		unsigned add_flags = d_flags_for_inode(inode);
 		hlist_add_head(&dentry->d_u.d_alias, &inode->i_dentry);
@@ -2709,7 +2712,7 @@ void d_add(struct dentry *entry, struct inode *inode)
 		security_d_instantiate(entry, inode);
 		spin_lock(&inode->i_lock);
 	}
-	__d_add(entry, inode);
+	__d_add(entry, inode, NULL);
 }
 EXPORT_SYMBOL(d_add);
 
@@ -2961,30 +2964,8 @@ static int __d_unalias(struct dentry *dentry, struct dentry *alias)
 	return ret;
 }
 
-/**
- * d_splice_alias - splice a disconnected dentry into the tree if one exists
- * @inode:  the inode which may have a disconnected dentry
- * @dentry: a negative dentry which we want to point to the inode.
- *
- * If inode is a directory and has an IS_ROOT alias, then d_move that in
- * place of the given dentry and return it, else simply d_add the inode
- * to the dentry and return NULL.
- *
- * If a non-IS_ROOT directory is found, the filesystem is corrupt, and
- * we should error out: directories can't have multiple aliases.
- *
- * This is needed in the lookup routine of any filesystem that is exportable
- * (via knfsd) so that we can build dcache paths to directories effectively.
- *
- * If a dentry was found and moved, then it is returned.  Otherwise NULL
- * is returned.  This matches the expected return value of ->lookup.
- *
- * Cluster filesystems may call this function with a negative, hashed dentry.
- * In that case, we know that the inode will be a regular file, and also this
- * will only occur during atomic_open. So we need to check for the dentry
- * being already hashed only in the final case.
- */
-struct dentry *d_splice_alias(struct inode *inode, struct dentry *dentry)
+struct dentry *d_splice_alias_ops(struct inode *inode, struct dentry *dentry,
+				  const struct dentry_operations *ops)
 {
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
@@ -3030,9 +3011,37 @@ struct dentry *d_splice_alias(struct inode *inode, struct dentry *dentry)
 		}
 	}
 out:
-	__d_add(dentry, inode);
+	__d_add(dentry, inode, ops);
 	return NULL;
 }
+
+/**
+ * d_splice_alias - splice a disconnected dentry into the tree if one exists
+ * @inode:  the inode which may have a disconnected dentry
+ * @dentry: a negative dentry which we want to point to the inode.
+ *
+ * If inode is a directory and has an IS_ROOT alias, then d_move that in
+ * place of the given dentry and return it, else simply d_add the inode
+ * to the dentry and return NULL.
+ *
+ * If a non-IS_ROOT directory is found, the filesystem is corrupt, and
+ * we should error out: directories can't have multiple aliases.
+ *
+ * This is needed in the lookup routine of any filesystem that is exportable
+ * (via knfsd) so that we can build dcache paths to directories effectively.
+ *
+ * If a dentry was found and moved, then it is returned.  Otherwise NULL
+ * is returned.  This matches the expected return value of ->lookup.
+ *
+ * Cluster filesystems may call this function with a negative, hashed dentry.
+ * In that case, we know that the inode will be a regular file, and also this
+ * will only occur during atomic_open. So we need to check for the dentry
+ * being already hashed only in the final case.
+ */
+struct dentry *d_splice_alias(struct inode *inode, struct dentry *dentry)
+{
+	return d_splice_alias_ops(inode, dentry, NULL);
+}
 EXPORT_SYMBOL(d_splice_alias);
 
 /*
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index e29823c701ac..1993e6704552 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -245,6 +245,9 @@ extern struct dentry * d_alloc_anon(struct super_block *);
 extern struct dentry * d_alloc_parallel(struct dentry *, const struct qstr *,
 					wait_queue_head_t *);
 extern struct dentry * d_splice_alias(struct inode *, struct dentry *);
+/* weird procfs mess; *NOT* exported */
+extern struct dentry * d_splice_alias_ops(struct inode *, struct dentry *,
+					  const struct dentry_operations *);
 extern struct dentry * d_add_ci(struct dentry *, struct inode *, struct qstr *);
 extern bool d_same_name(const struct dentry *dentry, const struct dentry *parent,
 			const struct qstr *name);
-- 
2.39.5


