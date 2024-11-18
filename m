Return-Path: <linux-fsdevel+bounces-35075-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC799D0E51
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 11:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C72B1F217A5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 10:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4980619ADBF;
	Mon, 18 Nov 2024 10:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="BIKbbPtx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923031925B3
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Nov 2024 10:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731925004; cv=none; b=FMjR45zSsY52qM39TkvmTeZ16uOp3rhg8tukC+KfODMSM8ylJF+RSQhbTFZ1Hevt13dhUBWkrgnab6pFSl8lVK/QqcvehNuoBqJUGx0Ae0SpMl/P6wDtZ5RG1YZDJ2Nr5KanlF+kzFLq005JDFybHBZbGOKx68ALbsIlpvjqDvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731925004; c=relaxed/simple;
	bh=VfjBuO2EVgO3uYHnyTCW8puoidomQ+oBPm3Fp9ubau8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZzZuMQttwKog45h85pCpszeI9md6NW42W2BntFtFsZEeUdSc0SGNYcAXNK4TfQERCFWDE9PC2WHnTUdjfxIzUnrncsD4q3lnVxdTii3Chi+9XZrqbhX5wUYixPSGbFuVQMbrh2Z4muNfplyCHf2D1Ck7f2GvwO5dmJdw+PjEoRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=BIKbbPtx; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20cf6eea3c0so36026685ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Nov 2024 02:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1731925002; x=1732529802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7Y2TA9eGVB7H88xAHF+/6WLIDqt1ULw8AsQKOOSLgoU=;
        b=BIKbbPtxK4m6Reu48xWdkPHobpxL36WAq+/F/Cz9n+KZ7WRr4gVvs3TYmoPBRrQF5G
         a+tBENSbOhulbvM15JFW1JqzpGBQMHzGPigASAWPLQ1utto8S9ut3RRze5suaeMq25oR
         mvQ28fu66zdeJzAwQvnDacpkoPhAZjExIQqn23e7mJHw6a6hOMRWCV7NFb2K1IXbgyCc
         5am4PP0UJIZxKk89nDQRU19Gx/t1GsFYxpiUZuhtq7fxhjhzWfQIlDUNFVPm6jo45epD
         /er5CuBjCW3spKObJaJ+/vFRswormEq3hzWWPEAL6Q/M6Nqnx+wzmNOAw253+ZoriwEn
         9/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731925002; x=1732529802;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Y2TA9eGVB7H88xAHF+/6WLIDqt1ULw8AsQKOOSLgoU=;
        b=KX/gXgGoPRvON4yhduQDl8HAdmS5k10RV2JW/FksSzJdtoSW/QJSq8ZWrEiDYAJfv5
         R+6u1DvlficZyzKSkSQbnPVUFFAoWUSZkDB3g+izpboAaQuijRVOIzZeJ5/WKs/gRYiA
         cZuoadX8UD2hUpNpKHLqB0VIxni82P35o5LVU0Q+b2F9vK8KmZBw9+etxRKzHRtm6Zb7
         Sh1IQ+xn6gQ4MyDU/wdZpENaXSD4PR2zesgMw1a51B1TuREt2fojg+YFJmobA1F1ArlI
         01LgkoMD/HIigl+ChStUt7qDBdRzzUHgL4k42fsWo/kmj681bjgD9WVGohj6qKJUnrXV
         ASgA==
X-Gm-Message-State: AOJu0YzC9EN5xWQqjctXgyzW9XULcDDKNToJdVbTzw4ALIplwH9bGF3T
	5CZ4+9zXd+qEs1/MGkJoUnFwz/keWX1OSQmjEtgFhMdC6Z+7ayUemvcyGhDOfSk=
X-Google-Smtp-Source: AGHT+IHcDDMXQ+RIcoRMeDxDq+QAN0o5h5dEoM1KsPEjD5+nTAvM3j/SJMUxbOyx+Yp3fqbRRh61Rg==
X-Received: by 2002:a17:902:d4ce:b0:20d:cb6:11e with SMTP id d9443c01a7336-211d0d83bdcmr146953755ad.26.1731925001841;
        Mon, 18 Nov 2024 02:16:41 -0800 (PST)
Received: from tianci-mac.bytedance.net ([61.213.176.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f35143sm52934985ad.148.2024.11.18.02.16.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 18 Nov 2024 02:16:41 -0800 (PST)
From: Zhang Tianci <zhangtianci.1997@bytedance.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xieyongji@bytedance.com,
	Zhang Tianci <zhangtianci.1997@bytedance.com>,
	Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Subject: [PATCH v2] fuse: check attributes staleness on fuse_iget()
Date: Mon, 18 Nov 2024 18:16:00 +0800
Message-ID: <20241118101600.21710-1-zhangtianci.1997@bytedance.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Function fuse_direntplus_link() might call fuse_iget() to initialize a new
fuse_inode and change its attributes. If fi->attr_version is always
initialized with 0, even if the attributes returned by the FUSE_READDIR
request is staled, as the new fi->attr_version is 0, fuse_change_attributes
will still set the staled attributes to inode. This wrong behaviour may
cause file size inconsistency even when there is no changes from
server-side.

To reproduce the issue, consider the following 2 programs (A and B) are
running concurrently,

        A                                               B
----------------------------------      --------------------------------
{ /fusemnt/dir/f is a file path in a fuse mount, the size of f is 0. }

readdir(/fusemnt/dir) start
//Daemon set size 0 to f direntry
                                        fallocate(f, 1024)
                                        stat(f) // B see size 1024
                                        echo 2 > /proc/sys/vm/drop_caches
readdir(/fusemnt/dir) reply to kernel
Kernel set 0 to the I_NEW inode

                                        stat(f) // B see size 0

In the above case, only program B is modifying the file size, however, B
observes file size changing between the 2 'readonly' stat() calls. To fix
this issue, we should make sure readdirplus still follows the rule of
attr_version staleness checking even if the fi->attr_version is lost due to
inode eviction.

To identify this situation, the new fc->evict_ctr is used to record whether
the eviction of inodes occurs during the readdirplus request processing.
If it does, the result of readdirplus may be inaccurate; otherwise, the
result of readdirplus can be trusted. Although this may still lead to
incorrect invalidation, considering the relatively low frequency of
evict occurrences, it should be acceptable.

Link: https://lore.kernel.org/lkml/20230711043405.66256-2-zhangjiachen.jaycee@bytedance.com/
Link: https://lore.kernel.org/lkml/20241114070905.48901-1-zhangtianci.1997@bytedance.com/

Reported-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Suggested-by: Miklos Szeredi <miklos@szeredi.hu>
Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
Signed-off-by: Zhang Tianci <zhangtianci.1997@bytedance.com>
---
 fs/fuse/dir.c     | 11 +++++-----
 fs/fuse/fuse_i.h  | 14 ++++++++++--
 fs/fuse/inode.c   | 56 +++++++++++++++++++++++++++++++++++++----------
 fs/fuse/readdir.c | 15 ++++++++-----
 4 files changed, 71 insertions(+), 25 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 54104dd48af7c..59be2877786f2 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -366,7 +366,7 @@ int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name
 	struct fuse_mount *fm = get_fuse_mount_super(sb);
 	FUSE_ARGS(args);
 	struct fuse_forget_link *forget;
-	u64 attr_version;
+	u64 attr_version, evict_ctr;
 	int err;
 
 	*inode = NULL;
@@ -381,6 +381,7 @@ int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name
 		goto out;
 
 	attr_version = fuse_get_attr_version(fm->fc);
+	evict_ctr = fuse_get_evict_ctr(fm->fc);
 
 	fuse_lookup_init(fm->fc, &args, nodeid, name, outarg);
 	err = fuse_simple_request(fm, &args);
@@ -398,7 +399,7 @@ int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name
 
 	*inode = fuse_iget(sb, outarg->nodeid, outarg->generation,
 			   &outarg->attr, ATTR_TIMEOUT(outarg),
-			   attr_version);
+			   attr_version, evict_ctr);
 	err = -ENOMEM;
 	if (!*inode) {
 		fuse_queue_forget(fm->fc, forget, outarg->nodeid, 1);
@@ -691,7 +692,7 @@ static int fuse_create_open(struct mnt_idmap *idmap, struct inode *dir,
 	ff->nodeid = outentry.nodeid;
 	ff->open_flags = outopenp->open_flags;
 	inode = fuse_iget(dir->i_sb, outentry.nodeid, outentry.generation,
-			  &outentry.attr, ATTR_TIMEOUT(&outentry), 0);
+			  &outentry.attr, ATTR_TIMEOUT(&outentry), 0, 0);
 	if (!inode) {
 		flags &= ~(O_CREAT | O_EXCL | O_TRUNC);
 		fuse_sync_release(NULL, ff, flags);
@@ -822,7 +823,7 @@ static int create_new_entry(struct mnt_idmap *idmap, struct fuse_mount *fm,
 		goto out_put_forget_req;
 
 	inode = fuse_iget(dir->i_sb, outarg.nodeid, outarg.generation,
-			  &outarg.attr, ATTR_TIMEOUT(&outarg), 0);
+			  &outarg.attr, ATTR_TIMEOUT(&outarg), 0, 0);
 	if (!inode) {
 		fuse_queue_forget(fm->fc, forget, outarg.nodeid, 1);
 		return -ENOMEM;
@@ -2028,7 +2029,7 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 
 	fuse_change_attributes_common(inode, &outarg.attr, NULL,
 				      ATTR_TIMEOUT(&outarg),
-				      fuse_get_cache_mask(inode));
+				      fuse_get_cache_mask(inode), 0);
 	oldsize = inode->i_size;
 	/* see the comment in fuse_change_attributes() */
 	if (!is_wb || is_truncate)
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index e6cc3d552b138..a98fb243b9130 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -884,6 +884,9 @@ struct fuse_conn {
 	/** Version counter for attribute changes */
 	atomic64_t attr_version;
 
+	/** Version counter for evict inode */
+	atomic64_t evict_ctr;
+
 	/** Called on final put */
 	void (*release)(struct fuse_conn *);
 
@@ -978,6 +981,11 @@ static inline u64 fuse_get_attr_version(struct fuse_conn *fc)
 	return atomic64_read(&fc->attr_version);
 }
 
+static inline u64 fuse_get_evict_ctr(struct fuse_conn *fc)
+{
+	return atomic64_read(&fc->evict_ctr);
+}
+
 static inline bool fuse_stale_inode(const struct inode *inode, int generation,
 				    struct fuse_attr *attr)
 {
@@ -1037,7 +1045,8 @@ extern const struct dentry_operations fuse_root_dentry_operations;
  */
 struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 			int generation, struct fuse_attr *attr,
-			u64 attr_valid, u64 attr_version);
+			u64 attr_valid, u64 attr_version,
+			u64 evict_ctr);
 
 int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name,
 		     struct fuse_entry_out *outarg, struct inode **inode);
@@ -1127,7 +1136,8 @@ void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
 
 void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
 				   struct fuse_statx *sx,
-				   u64 attr_valid, u32 cache_mask);
+				   u64 attr_valid, u32 cache_mask,
+				   u64 evict_ctr);
 
 u32 fuse_get_cache_mask(struct inode *inode);
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index fd3321e29a3e5..f9b292c1cc7e5 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -173,6 +173,14 @@ static void fuse_evict_inode(struct inode *inode)
 			fuse_cleanup_submount_lookup(fc, fi->submount_lookup);
 			fi->submount_lookup = NULL;
 		}
+		/*
+		 * Evict of non-deleted inode may race with outstanding
+		 * LOOKUP/READDIRPLUS requests and result in inconsistency when
+		 * the request finishes.  Deal with that here by bumping a
+		 * counter that can be compared to the starting value.
+		 */
+		if (inode->i_nlink > 0)
+			atomic64_inc(&fc->evict_ctr);
 	}
 	if (S_ISREG(inode->i_mode) && !fuse_is_bad(inode)) {
 		WARN_ON(fi->iocachectr != 0);
@@ -206,17 +214,30 @@ static ino_t fuse_squash_ino(u64 ino64)
 
 void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
 				   struct fuse_statx *sx,
-				   u64 attr_valid, u32 cache_mask)
+				   u64 attr_valid, u32 cache_mask,
+				   u64 evict_ctr)
 {
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	struct fuse_inode *fi = get_fuse_inode(inode);
 
 	lockdep_assert_held(&fi->lock);
 
+	/*
+	 * Clear basic stats from invalid mask.
+	 *
+	 * Don't do this if this is coming from a fuse_iget() call and there
+	 * might have been a racing evict which would've invalidated the result
+	 * if the attr_version would've been preserved.
+	 *
+	 * !evict_ctr -> this is create
+	 * fi->attr_version != 0 -> this is not a new inode
+	 * evict_ctr == fuse_get_evict_ctr() -> no evicts while during request
+	 */
+	if (!evict_ctr || fi->attr_version || evict_ctr == fuse_get_evict_ctr(fc))
+		set_mask_bits(&fi->inval_mask, STATX_BASIC_STATS, 0);
+
 	fi->attr_version = atomic64_inc_return(&fc->attr_version);
 	fi->i_time = attr_valid;
-	/* Clear basic stats from invalid mask */
-	set_mask_bits(&fi->inval_mask, STATX_BASIC_STATS, 0);
 
 	inode->i_ino     = fuse_squash_ino(attr->ino);
 	inode->i_mode    = (inode->i_mode & S_IFMT) | (attr->mode & 07777);
@@ -295,9 +316,9 @@ u32 fuse_get_cache_mask(struct inode *inode)
 	return STATX_MTIME | STATX_CTIME | STATX_SIZE;
 }
 
-void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
-			    struct fuse_statx *sx,
-			    u64 attr_valid, u64 attr_version)
+static void fuse_change_attributes_i(struct inode *inode, struct fuse_attr *attr,
+				     struct fuse_statx *sx, u64 attr_valid,
+				     u64 attr_version, u64 evict_ctr)
 {
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	struct fuse_inode *fi = get_fuse_inode(inode);
@@ -331,7 +352,8 @@ void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
 	}
 
 	old_mtime = inode_get_mtime(inode);
-	fuse_change_attributes_common(inode, attr, sx, attr_valid, cache_mask);
+	fuse_change_attributes_common(inode, attr, sx, attr_valid, cache_mask,
+				      evict_ctr);
 
 	oldsize = inode->i_size;
 	/*
@@ -372,6 +394,13 @@ void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
 		fuse_dax_dontcache(inode, attr->flags);
 }
 
+void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
+			    struct fuse_statx *sx, u64 attr_valid,
+			    u64 attr_version)
+{
+	fuse_change_attributes_i(inode, attr, sx, attr_valid, attr_version, 0);
+}
+
 static void fuse_init_submount_lookup(struct fuse_submount_lookup *sl,
 				      u64 nodeid)
 {
@@ -426,7 +455,8 @@ static int fuse_inode_set(struct inode *inode, void *_nodeidp)
 
 struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 			int generation, struct fuse_attr *attr,
-			u64 attr_valid, u64 attr_version)
+			u64 attr_valid, u64 attr_version,
+			u64 evict_ctr)
 {
 	struct inode *inode;
 	struct fuse_inode *fi;
@@ -487,8 +517,8 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 	fi->nlookup++;
 	spin_unlock(&fi->lock);
 done:
-	fuse_change_attributes(inode, attr, NULL, attr_valid, attr_version);
-
+	fuse_change_attributes_i(inode, attr, NULL, attr_valid, attr_version,
+				 evict_ctr);
 	return inode;
 }
 
@@ -940,6 +970,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 	fc->initialized = 0;
 	fc->connected = 1;
 	atomic64_set(&fc->attr_version, 1);
+	atomic64_set(&fc->evict_ctr, 1);
 	get_random_bytes(&fc->scramble_key, sizeof(fc->scramble_key));
 	fc->pid_ns = get_pid_ns(task_active_pid_ns(current));
 	fc->user_ns = get_user_ns(user_ns);
@@ -1001,7 +1032,7 @@ static struct inode *fuse_get_root_inode(struct super_block *sb, unsigned mode)
 	attr.mode = mode;
 	attr.ino = FUSE_ROOT_ID;
 	attr.nlink = 1;
-	return fuse_iget(sb, FUSE_ROOT_ID, 0, &attr, 0, 0);
+	return fuse_iget(sb, FUSE_ROOT_ID, 0, &attr, 0, 0, 0);
 }
 
 struct fuse_inode_handle {
@@ -1610,7 +1641,8 @@ static int fuse_fill_super_submount(struct super_block *sb,
 		return -ENOMEM;
 
 	fuse_fill_attr_from_inode(&root_attr, parent_fi);
-	root = fuse_iget(sb, parent_fi->nodeid, 0, &root_attr, 0, 0);
+	root = fuse_iget(sb, parent_fi->nodeid, 0, &root_attr, 0, 0,
+			 fuse_get_evict_ctr(fm->fc));
 	/*
 	 * This inode is just a duplicate, so it is not looked up and
 	 * its nlookup should not be incremented.  fuse_iget() does
diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index 0377b6dc24c80..ceb5aefd6012f 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -149,7 +149,7 @@ static int parse_dirfile(char *buf, size_t nbytes, struct file *file,
 
 static int fuse_direntplus_link(struct file *file,
 				struct fuse_direntplus *direntplus,
-				u64 attr_version)
+				u64 attr_version, u64 evict_ctr)
 {
 	struct fuse_entry_out *o = &direntplus->entry_out;
 	struct fuse_dirent *dirent = &direntplus->dirent;
@@ -233,7 +233,7 @@ static int fuse_direntplus_link(struct file *file,
 	} else {
 		inode = fuse_iget(dir->i_sb, o->nodeid, o->generation,
 				  &o->attr, ATTR_TIMEOUT(o),
-				  attr_version);
+				  attr_version, evict_ctr);
 		if (!inode)
 			inode = ERR_PTR(-ENOMEM);
 
@@ -284,7 +284,8 @@ static void fuse_force_forget(struct file *file, u64 nodeid)
 }
 
 static int parse_dirplusfile(char *buf, size_t nbytes, struct file *file,
-			     struct dir_context *ctx, u64 attr_version)
+			     struct dir_context *ctx, u64 attr_version,
+			     u64 evict_ctr)
 {
 	struct fuse_direntplus *direntplus;
 	struct fuse_dirent *dirent;
@@ -319,7 +320,7 @@ static int parse_dirplusfile(char *buf, size_t nbytes, struct file *file,
 		buf += reclen;
 		nbytes -= reclen;
 
-		ret = fuse_direntplus_link(file, direntplus, attr_version);
+		ret = fuse_direntplus_link(file, direntplus, attr_version, evict_ctr);
 		if (ret)
 			fuse_force_forget(file, direntplus->entry_out.nodeid);
 	}
@@ -337,7 +338,7 @@ static int fuse_readdir_uncached(struct file *file, struct dir_context *ctx)
 	struct fuse_io_args ia = {};
 	struct fuse_args_pages *ap = &ia.ap;
 	struct fuse_page_desc desc = { .length = PAGE_SIZE };
-	u64 attr_version = 0;
+	u64 attr_version = 0, evict_ctr = 0;
 	bool locked;
 
 	page = alloc_page(GFP_KERNEL);
@@ -351,6 +352,7 @@ static int fuse_readdir_uncached(struct file *file, struct dir_context *ctx)
 	ap->descs = &desc;
 	if (plus) {
 		attr_version = fuse_get_attr_version(fm->fc);
+		evict_ctr = fuse_get_evict_ctr(fm->fc);
 		fuse_read_args_fill(&ia, file, ctx->pos, PAGE_SIZE,
 				    FUSE_READDIRPLUS);
 	} else {
@@ -368,7 +370,8 @@ static int fuse_readdir_uncached(struct file *file, struct dir_context *ctx)
 				fuse_readdir_cache_end(file, ctx->pos);
 		} else if (plus) {
 			res = parse_dirplusfile(page_address(page), res,
-						file, ctx, attr_version);
+						file, ctx, attr_version,
+						evict_ctr);
 		} else {
 			res = parse_dirfile(page_address(page), res, file,
 					    ctx);
-- 
2.46.0.rc2


