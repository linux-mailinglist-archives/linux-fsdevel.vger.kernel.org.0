Return-Path: <linux-fsdevel+bounces-49475-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15385ABCE79
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 07:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A527A16D4EE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 05:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2EF25B1DC;
	Tue, 20 May 2025 05:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K2WqbMBj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7A51E9B19;
	Tue, 20 May 2025 05:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747718173; cv=none; b=GUvFrKTQ9yopjDWXW4kQXHdDwGdxGKT6nMtsUhcZAvkEghMZydT9XE63PJk3etzaRfngX1i+w1EFObqoz0sutCN/kkS4SpuQswJXJSL1gFRGbRF9W2PeKYpydKJWH793gZrryIc9y11CCyv0NtAWYOSH9ClwJ1EMJar0FJFSP+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747718173; c=relaxed/simple;
	bh=rWn0KtQV6w7v4hIccCW5M7Zg5TVS1WdH2jUhat5RwJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f092yFMFqoKFtN2THY15OHULQ/4rS8hbKlo76MvmPIq5L2Usm3ex93jIxyKpoIWriY0B6IxZpNW2AJkdE1vYeqatEVTgAqw2m7UNXuG1WanMO10m4sAOZzZXyH/iBfTlHpIsPXE37M8ppMDFXNAxOxs95r8PwMR0DjUJ40tNHK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K2WqbMBj; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747718169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LhOkd2WseNGnwpcnI2NXO/0YjYpHYyCLAFMWWwe1gw0=;
	b=K2WqbMBj/eC1Xn6H2EKWBNEEjitdHcjPoHCtgqYVSLZVRE0rA+kAf6YS5pjnFAEwOKvdK7
	irfgPB30SbkHAXHuyxQPyZ1rqb0dnQUYzI581DNGoBeBAH8wDdCBC2k3lXLJRsNd7PvvdR
	ajRHK9cClRwZdGzBnx0gwrzTXcv7YkM=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-fsdevel@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 1/6] bcachefs: BCH_INODE_has_case_insensitive
Date: Tue, 20 May 2025 01:15:53 -0400
Message-ID: <20250520051600.1903319-2-kent.overstreet@linux.dev>
In-Reply-To: <20250520051600.1903319-1-kent.overstreet@linux.dev>
References: <20250520051600.1903319-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add a flag for tracking whether a directory has case-insensitive
descendents - so that overlayfs can disallow mounting, even though the
filesystem supports case insensitivity.

This is a new on disk format version, with a (cheap) upgrade to ensure
the flag is correctly set on existing inodes.

Create, rename and fssetxattr are all plumbed to ensure the new flag is
set, and we've got new fsck code that hooks into check_inode(0.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/bcachefs/bcachefs_format.h  |   3 +-
 fs/bcachefs/fs.c               |   4 +
 fs/bcachefs/fsck.c             |  10 +-
 fs/bcachefs/inode.c            |   8 +-
 fs/bcachefs/inode.h            |   2 +-
 fs/bcachefs/inode_format.h     |   7 +-
 fs/bcachefs/namei.c            | 166 ++++++++++++++++++++++++++++++++-
 fs/bcachefs/namei.h            |   5 +
 fs/bcachefs/sb-downgrade.c     |   6 +-
 fs/bcachefs/sb-errors_format.h |   4 +-
 10 files changed, 202 insertions(+), 13 deletions(-)

diff --git a/fs/bcachefs/bcachefs_format.h b/fs/bcachefs/bcachefs_format.h
index 5900ff3715c6..b4a04df5ea95 100644
--- a/fs/bcachefs/bcachefs_format.h
+++ b/fs/bcachefs/bcachefs_format.h
@@ -699,7 +699,8 @@ struct bch_sb_field_ext {
 	x(casefolding,			BCH_VERSION(1, 24))		\
 	x(extent_flags,			BCH_VERSION(1, 25))		\
 	x(snapshot_deletion_v2,		BCH_VERSION(1, 26))		\
-	x(fast_device_removal,		BCH_VERSION(1, 27))
+	x(fast_device_removal,		BCH_VERSION(1, 27))		\
+	x(inode_has_case_insensitive,	BCH_VERSION(1, 28))
 
 enum bcachefs_metadata_version {
 	bcachefs_metadata_version_min = 9,
diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
index c863dcae5062..0b5d52895e05 100644
--- a/fs/bcachefs/fs.c
+++ b/fs/bcachefs/fs.c
@@ -1681,6 +1681,10 @@ static int fssetxattr_inode_update_fn(struct btree_trans *trans,
 		bi->bi_casefold = s->casefold + 1;
 		bi->bi_fields_set |= BIT(Inode_opt_casefold);
 
+		ret = bch2_maybe_propagate_has_case_insensitive(trans, inode_inum(inode), bi);
+		if (ret)
+			return ret;
+
 #else
 		printk(KERN_ERR "Cannot use casefolding on a kernel without CONFIG_UNICODE\n");
 		return -EOPNOTSUPP;
diff --git a/fs/bcachefs/fsck.c b/fs/bcachefs/fsck.c
index a0afb4c2a6f5..338309d0a570 100644
--- a/fs/bcachefs/fsck.c
+++ b/fs/bcachefs/fsck.c
@@ -264,7 +264,7 @@ static int lookup_lostfound(struct btree_trans *trans, u32 snapshot,
 	u64 cpu = raw_smp_processor_id();
 
 	bch2_inode_init_early(c, lostfound);
-	bch2_inode_init_late(lostfound, now, 0, 0, S_IFDIR|0700, 0, &root_inode);
+	bch2_inode_init_late(c, lostfound, now, 0, 0, S_IFDIR|0700, 0, &root_inode);
 	lostfound->bi_dir = root_inode.bi_inum;
 	lostfound->bi_snapshot = le32_to_cpu(st.root_snapshot);
 
@@ -543,7 +543,7 @@ static int reconstruct_subvol(struct btree_trans *trans, u32 snapshotid, u32 sub
 		u64 cpu = raw_smp_processor_id();
 
 		bch2_inode_init_early(c, &new_inode);
-		bch2_inode_init_late(&new_inode, bch2_current_time(c), 0, 0, S_IFDIR|0755, 0, NULL);
+		bch2_inode_init_late(c, &new_inode, bch2_current_time(c), 0, 0, S_IFDIR|0755, 0, NULL);
 
 		new_inode.bi_subvol = subvolid;
 
@@ -633,7 +633,7 @@ static int reconstruct_inode(struct btree_trans *trans, enum btree_id btree, u32
 
 	struct bch_inode_unpacked new_inode;
 	bch2_inode_init_early(c, &new_inode);
-	bch2_inode_init_late(&new_inode, bch2_current_time(c), 0, 0, i_mode|0600, 0, NULL);
+	bch2_inode_init_late(c, &new_inode, bch2_current_time(c), 0, 0, i_mode|0600, 0, NULL);
 	new_inode.bi_size = i_size;
 	new_inode.bi_inum = inum;
 	new_inode.bi_snapshot = snapshot;
@@ -1135,6 +1135,10 @@ static int check_inode(struct btree_trans *trans,
 			goto err;
 	}
 
+	ret = bch2_check_inode_has_case_insensitive(trans, &u, &s->ids, &do_update);
+	if (ret)
+		goto err;
+
 	if (u.bi_dir || u.bi_dir_offset) {
 		ret = check_inode_dirent_inode(trans, &u, &do_update);
 		if (ret)
diff --git a/fs/bcachefs/inode.c b/fs/bcachefs/inode.c
index 1d7c3e6b9089..dbcb95ad1e33 100644
--- a/fs/bcachefs/inode.c
+++ b/fs/bcachefs/inode.c
@@ -907,7 +907,8 @@ void bch2_inode_init_early(struct bch_fs *c,
 	get_random_bytes(&inode_u->bi_hash_seed, sizeof(inode_u->bi_hash_seed));
 }
 
-void bch2_inode_init_late(struct bch_inode_unpacked *inode_u, u64 now,
+void bch2_inode_init_late(struct bch_fs *c,
+			  struct bch_inode_unpacked *inode_u, u64 now,
 			  uid_t uid, gid_t gid, umode_t mode, dev_t rdev,
 			  struct bch_inode_unpacked *parent)
 {
@@ -934,6 +935,9 @@ void bch2_inode_init_late(struct bch_inode_unpacked *inode_u, u64 now,
 
 	if (!S_ISDIR(mode))
 		inode_u->bi_casefold = 0;
+
+	if (bch2_inode_casefold(c, inode_u))
+		inode_u->bi_flags |= BCH_INODE_has_case_insensitive;
 }
 
 void bch2_inode_init(struct bch_fs *c, struct bch_inode_unpacked *inode_u,
@@ -941,7 +945,7 @@ void bch2_inode_init(struct bch_fs *c, struct bch_inode_unpacked *inode_u,
 		     struct bch_inode_unpacked *parent)
 {
 	bch2_inode_init_early(c, inode_u);
-	bch2_inode_init_late(inode_u, bch2_current_time(c),
+	bch2_inode_init_late(c, inode_u, bch2_current_time(c),
 			     uid, gid, mode, rdev, parent);
 }
 
diff --git a/fs/bcachefs/inode.h b/fs/bcachefs/inode.h
index 851721d88295..f562ba516191 100644
--- a/fs/bcachefs/inode.h
+++ b/fs/bcachefs/inode.h
@@ -164,7 +164,7 @@ int bch2_fsck_write_inode(struct btree_trans *, struct bch_inode_unpacked *);
 
 void bch2_inode_init_early(struct bch_fs *,
 			   struct bch_inode_unpacked *);
-void bch2_inode_init_late(struct bch_inode_unpacked *, u64,
+void bch2_inode_init_late(struct bch_fs *, struct bch_inode_unpacked *, u64,
 			  uid_t, gid_t, umode_t, dev_t,
 			  struct bch_inode_unpacked *);
 void bch2_inode_init(struct bch_fs *, struct bch_inode_unpacked *,
diff --git a/fs/bcachefs/inode_format.h b/fs/bcachefs/inode_format.h
index 87e193e8ed25..1f00938b1bdc 100644
--- a/fs/bcachefs/inode_format.h
+++ b/fs/bcachefs/inode_format.h
@@ -129,6 +129,10 @@ enum inode_opt_id {
 	Inode_opt_nr,
 };
 
+/*
+ * BCH_INODE_has_case_insensitive is set if any descendent is case insensitive -
+ * for overlayfs
+ */
 #define BCH_INODE_FLAGS()			\
 	x(sync,				0)	\
 	x(immutable,			1)	\
@@ -139,7 +143,8 @@ enum inode_opt_id {
 	x(i_sectors_dirty,		6)	\
 	x(unlinked,			7)	\
 	x(backptr_untrusted,		8)	\
-	x(has_child_snapshot,		9)
+	x(has_child_snapshot,		9)	\
+	x(has_case_insensitive,		10)
 
 /* bits 20+ reserved for packed fields below: */
 
diff --git a/fs/bcachefs/namei.c b/fs/bcachefs/namei.c
index 561dc034df21..148615f6952a 100644
--- a/fs/bcachefs/namei.c
+++ b/fs/bcachefs/namei.c
@@ -11,6 +11,14 @@
 
 #include <linux/posix_acl.h>
 
+static inline subvol_inum parent_inum(subvol_inum inum, struct bch_inode_unpacked *inode)
+{
+	return (subvol_inum) {
+		.subvol	= inode->bi_parent_subvol ?: inum.subvol,
+		.inum	= inode->bi_dir,
+	};
+}
+
 static inline int is_subdir_for_nlink(struct bch_inode_unpacked *inode)
 {
 	return S_ISDIR(inode->bi_mode) && !inode->bi_subvol;
@@ -49,7 +57,7 @@ int bch2_create_trans(struct btree_trans *trans,
 
 	if (!(flags & BCH_CREATE_SNAPSHOT)) {
 		/* Normal create path - allocate a new inode: */
-		bch2_inode_init_late(new_inode, now, uid, gid, mode, rdev, dir_u);
+		bch2_inode_init_late(c, new_inode, now, uid, gid, mode, rdev, dir_u);
 
 		if (flags & BCH_CREATE_TMPFILE)
 			new_inode->bi_flags |= BCH_INODE_unlinked;
@@ -512,6 +520,13 @@ int bch2_rename_trans(struct btree_trans *trans,
 			goto err;
 		}
 
+		ret =   bch2_maybe_propagate_has_case_insensitive(trans, src_inum, src_inode_u) ?:
+			(mode == BCH_RENAME_EXCHANGE
+			 ? bch2_maybe_propagate_has_case_insensitive(trans, dst_inum, dst_inode_u)
+			 : 0);
+		if (ret)
+			goto err;
+
 		if (is_subdir_for_nlink(src_inode_u)) {
 			src_dir_u->bi_nlink--;
 			dst_dir_u->bi_nlink++;
@@ -613,8 +628,7 @@ int bch2_inum_to_path(struct btree_trans *trans, subvol_inum inum, struct printb
 			goto disconnected;
 		}
 
-		inum.subvol	= inode.bi_parent_subvol ?: inum.subvol;
-		inum.inum	= inode.bi_dir;
+		inum = parent_inum(inum, &inode);
 
 		u32 snapshot;
 		ret = bch2_subvolume_get_snapshot(trans, inum.subvol, &snapshot);
@@ -849,3 +863,149 @@ int __bch2_check_dirent_target(struct btree_trans *trans,
 	bch_err_fn(c, ret);
 	return ret;
 }
+
+/*
+ * BCH_INODE_has_case_insensitive:
+ * We have to track whether directories have any descendent directory that is
+ * casefolded - for overlayfs:
+ */
+
+static int bch2_propagate_has_case_insensitive(struct btree_trans *trans, subvol_inum inum)
+{
+	struct btree_iter iter = {};
+	int ret = 0;
+
+	while (true) {
+		struct bch_inode_unpacked inode;
+		ret = bch2_inode_peek(trans, &iter, &inode, inum,
+				      BTREE_ITER_intent|BTREE_ITER_with_updates);
+		if (ret)
+			break;
+
+		if (inode.bi_flags & BCH_INODE_has_case_insensitive)
+			break;
+
+		inode.bi_flags |= BCH_INODE_has_case_insensitive;
+		ret = bch2_inode_write(trans, &iter, &inode);
+		if (ret)
+			break;
+
+		bch2_trans_iter_exit(trans, &iter);
+		if (subvol_inum_eq(inum, BCACHEFS_ROOT_SUBVOL_INUM))
+			break;
+
+		inum = parent_inum(inum, &inode);
+	}
+
+	bch2_trans_iter_exit(trans, &iter);
+	return ret;
+}
+
+int bch2_maybe_propagate_has_case_insensitive(struct btree_trans *trans, subvol_inum inum,
+					      struct bch_inode_unpacked *inode)
+{
+	if (!bch2_inode_casefold(trans->c, inode))
+		return 0;
+
+	inode->bi_flags |= BCH_INODE_has_case_insensitive;
+
+	return bch2_propagate_has_case_insensitive(trans, parent_inum(inum, inode));
+}
+
+int bch2_check_inode_has_case_insensitive(struct btree_trans *trans,
+					  struct bch_inode_unpacked *inode,
+					  snapshot_id_list *snapshot_overwrites,
+					  bool *do_update)
+{
+	struct printbuf buf = PRINTBUF;
+	bool repairing_parents = false;
+	int ret = 0;
+
+	if (!S_ISDIR(inode->bi_mode)) {
+		/*
+		 * Old versions set bi_casefold for non dirs, but that's
+		 * unnecessary and wasteful
+		 */
+		if (inode->bi_casefold) {
+			inode->bi_casefold = 0;
+			*do_update = true;
+		}
+		return 0;
+	}
+
+	if (trans->c->sb.version < bcachefs_metadata_version_inode_has_case_insensitive)
+		return 0;
+
+	if (bch2_inode_casefold(trans->c, inode) &&
+	    !(inode->bi_flags & BCH_INODE_has_case_insensitive)) {
+		prt_printf(&buf, "casefolded dir with has_case_insensitive not set\ninum %llu:%u ",
+			   inode->bi_inum, inode->bi_snapshot);
+
+		ret = bch2_inum_snapshot_to_path(trans, inode->bi_inum, inode->bi_snapshot,
+						 snapshot_overwrites, &buf);
+		if (ret)
+			goto err;
+
+		if (fsck_err(trans, inode_has_case_insensitive_not_set, "%s", buf.buf)) {
+			inode->bi_flags |= BCH_INODE_has_case_insensitive;
+			*do_update = true;
+		}
+	}
+
+	if (!(inode->bi_flags & BCH_INODE_has_case_insensitive))
+		goto out;
+
+	struct bch_inode_unpacked dir = *inode;
+	u32 snapshot = dir.bi_snapshot;
+
+	while (!(dir.bi_inum	== BCACHEFS_ROOT_INO &&
+		 dir.bi_subvol	== BCACHEFS_ROOT_SUBVOL)) {
+		if (dir.bi_parent_subvol) {
+			ret = bch2_subvolume_get_snapshot(trans, dir.bi_parent_subvol, &snapshot);
+			if (ret)
+				goto err;
+
+			snapshot_overwrites = NULL;
+		}
+
+		ret = bch2_inode_find_by_inum_snapshot(trans, dir.bi_dir, snapshot, &dir, 0);
+		if (ret)
+			goto err;
+
+		if (!(dir.bi_flags & BCH_INODE_has_case_insensitive)) {
+			prt_printf(&buf, "parent of casefolded dir with has_case_insensitive not set\n");
+
+			ret = bch2_inum_snapshot_to_path(trans, dir.bi_inum, dir.bi_snapshot,
+							 snapshot_overwrites, &buf);
+			if (ret)
+				goto err;
+
+			if (fsck_err(trans, inode_parent_has_case_insensitive_not_set, "%s", buf.buf)) {
+				dir.bi_flags |= BCH_INODE_has_case_insensitive;
+				ret = __bch2_fsck_write_inode(trans, &dir);
+				if (ret)
+					goto err;
+			}
+		}
+
+		/*
+		 * We only need to check the first parent, unless we find an
+		 * inconsistency
+		 */
+		if (!repairing_parents)
+			break;
+	}
+out:
+err:
+fsck_err:
+	printbuf_exit(&buf);
+	if (ret)
+		return ret;
+
+	if (repairing_parents) {
+		return bch2_trans_commit(trans, NULL, NULL, BCH_TRANS_COMMIT_no_enospc) ?:
+			-BCH_ERR_transaction_restart_nested;
+	}
+
+	return 0;
+}
diff --git a/fs/bcachefs/namei.h b/fs/bcachefs/namei.h
index d4d2d2d69517..ae6ebc2d0785 100644
--- a/fs/bcachefs/namei.h
+++ b/fs/bcachefs/namei.h
@@ -71,4 +71,9 @@ static inline int bch2_check_dirent_target(struct btree_trans *trans,
 	return __bch2_check_dirent_target(trans, dirent_iter, d, target, in_fsck);
 }
 
+int bch2_maybe_propagate_has_case_insensitive(struct btree_trans *, subvol_inum,
+					      struct bch_inode_unpacked *);
+int bch2_check_inode_has_case_insensitive(struct btree_trans *, struct bch_inode_unpacked *,
+					  snapshot_id_list *, bool *);
+
 #endif /* _BCACHEFS_NAMEI_H */
diff --git a/fs/bcachefs/sb-downgrade.c b/fs/bcachefs/sb-downgrade.c
index 296c6c925386..861fce1630f0 100644
--- a/fs/bcachefs/sb-downgrade.c
+++ b/fs/bcachefs/sb-downgrade.c
@@ -100,7 +100,11 @@
 	  BCH_FSCK_ERR_ptr_to_missing_backpointer)		\
 	x(stripe_backpointers,					\
 	  BIT_ULL(BCH_RECOVERY_PASS_check_extents_to_backpointers),\
-	  BCH_FSCK_ERR_ptr_to_missing_backpointer)
+	  BCH_FSCK_ERR_ptr_to_missing_backpointer)		\
+	x(inode_has_case_insensitive,				\
+	  BIT_ULL(BCH_RECOVERY_PASS_check_inodes),		\
+	  BCH_FSCK_ERR_inode_has_case_insensitive_not_set,	\
+	  BCH_FSCK_ERR_inode_parent_has_case_insensitive_not_set)
 
 #define DOWNGRADE_TABLE()					\
 	x(bucket_stripe_sectors,				\
diff --git a/fs/bcachefs/sb-errors_format.h b/fs/bcachefs/sb-errors_format.h
index 68d99ca70634..8f6b02571df0 100644
--- a/fs/bcachefs/sb-errors_format.h
+++ b/fs/bcachefs/sb-errors_format.h
@@ -239,6 +239,8 @@ enum bch_fsck_flags {
 	x(inode_unreachable,					210,	FSCK_AUTOFIX)	\
 	x(inode_journal_seq_in_future,				299,	FSCK_AUTOFIX)	\
 	x(inode_i_sectors_underflow,				312,	FSCK_AUTOFIX)	\
+	x(inode_has_case_insensitive_not_set,			316,	FSCK_AUTOFIX)	\
+	x(inode_parent_has_case_insensitive_not_set,		317,	FSCK_AUTOFIX)	\
 	x(vfs_inode_i_blocks_underflow,				311,	FSCK_AUTOFIX)	\
 	x(vfs_inode_i_blocks_not_zero_at_truncate,		313,	FSCK_AUTOFIX)	\
 	x(deleted_inode_but_clean,				211,	FSCK_AUTOFIX)	\
@@ -325,7 +327,7 @@ enum bch_fsck_flags {
 	x(dirent_stray_data_after_cf_name,			305,	0)		\
 	x(rebalance_work_incorrectly_set,			309,	FSCK_AUTOFIX)	\
 	x(rebalance_work_incorrectly_unset,			310,	FSCK_AUTOFIX)	\
-	x(MAX,							316,	0)
+	x(MAX,							318,	0)
 
 enum bch_sb_error_id {
 #define x(t, n, ...) BCH_FSCK_ERR_##t = n,
-- 
2.49.0


