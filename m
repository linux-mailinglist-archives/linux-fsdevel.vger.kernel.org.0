Return-Path: <linux-fsdevel+bounces-39365-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D62EA13270
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 06:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B92A7A344F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 05:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5680F195FEF;
	Thu, 16 Jan 2025 05:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Ez1TY3C5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A6C137C2A;
	Thu, 16 Jan 2025 05:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737005003; cv=none; b=o+su748JrIGCcMECV/NWYepVxjioTvN2eoIlZe10nzROQCQXX/TURALzf9DCgdXzbV7aRkoaaojut/8Tyc4hdn9Bp8dj6sLkCph9IyKxbJYEMKOWxYZyAwqeoTHFYPOZ7faKEI+X2aWFE339IeeRUNJnZ6koqNpoBzG+S4Xnk1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737005003; c=relaxed/simple;
	bh=bnM7IlZjJeMkojm2bRtLjbztWyJmoGEHG7yxO/rV778=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QDpvsHVd7PgUQcjJfZ/R+jHfWrSAL3/haXMRIZwru/SV+Y0g5oiyjkf4y8NmTJ6sj4sOm+0n7K0wD7dCpN04zwAcGSUPXRxHQOKmSF+up/vGhYA6Pnp1NyGSOOKpv2LH0tjyJ6geQKK1GIlHqarmy2Qocv3jSLVvHgW3WEVdrmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Ez1TY3C5; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=9P4AXE/NxXpdPJKGKESuA2bxek8e3972Qb/ybaUUTpg=; b=Ez1TY3C5y3ylfj1kK+JmA6nZ8d
	1gN81LuY95nARmNJ7L91RzUBacXjPqMmpy0EchaiW9CO+ZtU13VJ09zQf1WpJZi4ym66pPDH8Yb1U
	9RHBwX4q/9nLP8ciEg2pZQi57p7VXpnIkbSX3L468Bpi/c941MjGqjWCfz7TicwR6bTMMjz+OtyvA
	IiSNzVs2HJBJaGcVJrNsYFiCicoHhSVvFMbpaGeajXJyG5Xa4TQdS+fAvhV7guV+h7Ui7oq9fuYvL
	jXhJxCXlL/N5rbWKK4bfB6p3hbPWlwgfnzHEC+hsr+39/kzvMW5iXdek5S4VQ0WzpAcygs8W09+Os
	2ZAjBPvQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tYILe-000000022GU-0Zvk;
	Thu, 16 Jan 2025 05:23:18 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: agruenba@redhat.com,
	amir73il@gmail.com,
	brauner@kernel.org,
	ceph-devel@vger.kernel.org,
	dhowells@redhat.com,
	hubcap@omnibond.com,
	jack@suse.cz,
	krisman@kernel.org,
	linux-nfs@vger.kernel.org,
	miklos@szeredi.hu,
	torvalds@linux-foundation.org
Subject: [PATCH v2 02/20] dcache: back inline names with a struct-wrapped array of unsigned long
Date: Thu, 16 Jan 2025 05:22:59 +0000
Message-ID: <20250116052317.485356-2-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250116052317.485356-1-viro@zeniv.linux.org.uk>
References: <20250116052103.GF1977892@ZenIV>
 <20250116052317.485356-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

... so that they can be copied with struct assignment (which generates
better code) and accessed word-by-word.

The type is union shortname_storage; it's a union of arrays of
unsigned char and unsigned long.

struct name_snapshot.inline_name turned into union shortname_storage;
users (all in fs/dcache.c) adjusted.

struct dentry.d_iname has some users outside of fs/dcache.c; to
reduce the amount of noise in commit, it is replaced with
union shortname_storage d_shortname and d_iname is turned into a macro
that expands to d_shortname.string (similar to d_lock handling).
That compat macro is temporary - most of the remaining instances will
be taken out by debugfs series, and once that is merged and few others
are taken care of this will go away.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c                                  | 43 +++++++++-----------
 include/linux/dcache.h                       | 10 ++++-
 tools/testing/selftests/bpf/progs/find_vma.c |  2 +-
 3 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index ea0f0bea511b..52662a5d08e4 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -324,7 +324,7 @@ static void __d_free_external(struct rcu_head *head)
 
 static inline int dname_external(const struct dentry *dentry)
 {
-	return dentry->d_name.name != dentry->d_iname;
+	return dentry->d_name.name != dentry->d_shortname.string;
 }
 
 void take_dentry_name_snapshot(struct name_snapshot *name, struct dentry *dentry)
@@ -334,9 +334,8 @@ void take_dentry_name_snapshot(struct name_snapshot *name, struct dentry *dentry
 	if (unlikely(dname_external(dentry))) {
 		atomic_inc(&external_name(dentry)->u.count);
 	} else {
-		memcpy(name->inline_name, dentry->d_iname,
-		       dentry->d_name.len + 1);
-		name->name.name = name->inline_name;
+		name->inline_name = dentry->d_shortname;
+		name->name.name = name->inline_name.string;
 	}
 	spin_unlock(&dentry->d_lock);
 }
@@ -344,7 +343,7 @@ EXPORT_SYMBOL(take_dentry_name_snapshot);
 
 void release_dentry_name_snapshot(struct name_snapshot *name)
 {
-	if (unlikely(name->name.name != name->inline_name)) {
+	if (unlikely(name->name.name != name->inline_name.string)) {
 		struct external_name *p;
 		p = container_of(name->name.name, struct external_name, name[0]);
 		if (unlikely(atomic_dec_and_test(&p->u.count)))
@@ -1654,10 +1653,10 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 	 * will still always have a NUL at the end, even if we might
 	 * be overwriting an internal NUL character
 	 */
-	dentry->d_iname[DNAME_INLINE_LEN-1] = 0;
+	dentry->d_shortname.string[DNAME_INLINE_LEN-1] = 0;
 	if (unlikely(!name)) {
 		name = &slash_name;
-		dname = dentry->d_iname;
+		dname = dentry->d_shortname.string;
 	} else if (name->len > DNAME_INLINE_LEN-1) {
 		size_t size = offsetof(struct external_name, name[1]);
 		struct external_name *p = kmalloc(size + name->len,
@@ -1670,7 +1669,7 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 		atomic_set(&p->u.count, 1);
 		dname = p->name;
 	} else  {
-		dname = dentry->d_iname;
+		dname = dentry->d_shortname.string;
 	}	
 
 	dentry->d_name.len = name->len;
@@ -2729,10 +2728,9 @@ static void swap_names(struct dentry *dentry, struct dentry *target)
 			 * dentry:internal, target:external.  Steal target's
 			 * storage and make target internal.
 			 */
-			memcpy(target->d_iname, dentry->d_name.name,
-					dentry->d_name.len + 1);
 			dentry->d_name.name = target->d_name.name;
-			target->d_name.name = target->d_iname;
+			target->d_shortname = dentry->d_shortname;
+			target->d_name.name = target->d_shortname.string;
 		}
 	} else {
 		if (unlikely(dname_external(dentry))) {
@@ -2740,18 +2738,16 @@ static void swap_names(struct dentry *dentry, struct dentry *target)
 			 * dentry:external, target:internal.  Give dentry's
 			 * storage to target and make dentry internal
 			 */
-			memcpy(dentry->d_iname, target->d_name.name,
-					target->d_name.len + 1);
 			target->d_name.name = dentry->d_name.name;
-			dentry->d_name.name = dentry->d_iname;
+			dentry->d_shortname = target->d_shortname;
+			dentry->d_name.name = dentry->d_shortname.string;
 		} else {
 			/*
 			 * Both are internal.
 			 */
-			for (int i = 0; i < DNAME_INLINE_WORDS; i++) {
-				swap(((long *) &dentry->d_iname)[i],
-				     ((long *) &target->d_iname)[i]);
-			}
+			for (int i = 0; i < DNAME_INLINE_WORDS; i++)
+				swap(dentry->d_shortname.words[i],
+				     target->d_shortname.words[i]);
 		}
 	}
 	swap(dentry->d_name.hash_len, target->d_name.hash_len);
@@ -2766,9 +2762,8 @@ static void copy_name(struct dentry *dentry, struct dentry *target)
 		atomic_inc(&external_name(target)->u.count);
 		dentry->d_name = target->d_name;
 	} else {
-		memcpy(dentry->d_iname, target->d_name.name,
-				target->d_name.len + 1);
-		dentry->d_name.name = dentry->d_iname;
+		dentry->d_shortname = target->d_shortname;
+		dentry->d_name.name = dentry->d_shortname.string;
 		dentry->d_name.hash_len = target->d_name.hash_len;
 	}
 	if (old_name && likely(atomic_dec_and_test(&old_name->u.count)))
@@ -3101,12 +3096,12 @@ void d_mark_tmpfile(struct file *file, struct inode *inode)
 {
 	struct dentry *dentry = file->f_path.dentry;
 
-	BUG_ON(dentry->d_name.name != dentry->d_iname ||
+	BUG_ON(dname_external(dentry) ||
 		!hlist_unhashed(&dentry->d_u.d_alias) ||
 		!d_unlinked(dentry));
 	spin_lock(&dentry->d_parent->d_lock);
 	spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
-	dentry->d_name.len = sprintf(dentry->d_iname, "#%llu",
+	dentry->d_name.len = sprintf(dentry->d_shortname.string, "#%llu",
 				(unsigned long long)inode->i_ino);
 	spin_unlock(&dentry->d_lock);
 	spin_unlock(&dentry->d_parent->d_lock);
@@ -3194,7 +3189,7 @@ static void __init dcache_init(void)
 	 */
 	dentry_cache = KMEM_CACHE_USERCOPY(dentry,
 		SLAB_RECLAIM_ACCOUNT|SLAB_PANIC|SLAB_ACCOUNT,
-		d_iname);
+		d_shortname.string);
 
 	/* Hash may have been set up in dcache_init_early */
 	if (!hashdist)
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 42dd89beaf4e..8bc567a35718 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -79,7 +79,13 @@ extern const struct qstr dotdot_name;
 
 #define DNAME_INLINE_LEN (DNAME_INLINE_WORDS*sizeof(unsigned long))
 
+union shortname_store {
+	unsigned char string[DNAME_INLINE_LEN];
+	unsigned long words[DNAME_INLINE_WORDS];
+};
+
 #define d_lock	d_lockref.lock
+#define d_iname d_shortname.string
 
 struct dentry {
 	/* RCU lookup touched fields */
@@ -90,7 +96,7 @@ struct dentry {
 	struct qstr d_name;
 	struct inode *d_inode;		/* Where the name belongs to - NULL is
 					 * negative */
-	unsigned char d_iname[DNAME_INLINE_LEN];	/* small names */
+	union shortname_store d_shortname;
 	/* --- cacheline 1 boundary (64 bytes) was 32 bytes ago --- */
 
 	/* Ref lookup also touches following */
@@ -591,7 +597,7 @@ static inline struct inode *d_real_inode(const struct dentry *dentry)
 
 struct name_snapshot {
 	struct qstr name;
-	unsigned char inline_name[DNAME_INLINE_LEN];
+	union shortname_store inline_name;
 };
 void take_dentry_name_snapshot(struct name_snapshot *, struct dentry *);
 void release_dentry_name_snapshot(struct name_snapshot *);
diff --git a/tools/testing/selftests/bpf/progs/find_vma.c b/tools/testing/selftests/bpf/progs/find_vma.c
index 38034fb82530..02b82774469c 100644
--- a/tools/testing/selftests/bpf/progs/find_vma.c
+++ b/tools/testing/selftests/bpf/progs/find_vma.c
@@ -25,7 +25,7 @@ static long check_vma(struct task_struct *task, struct vm_area_struct *vma,
 {
 	if (vma->vm_file)
 		bpf_probe_read_kernel_str(d_iname, DNAME_INLINE_LEN - 1,
-					  vma->vm_file->f_path.dentry->d_iname);
+					  vma->vm_file->f_path.dentry->d_shortname.string);
 
 	/* check for VM_EXEC */
 	if (vma->vm_flags & VM_EXEC)
-- 
2.39.5


