Return-Path: <linux-fsdevel+bounces-34739-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBF89C83D6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 08:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D38528728B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 07:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9E81EBA0F;
	Thu, 14 Nov 2024 07:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="CarnZG7U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF021EBFE1
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Nov 2024 07:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731568339; cv=none; b=FulLO06DmUugvp18IkgsyLXoDYrWK+lWz33Kdhy70U8yb5LrU90HlW/k0sPhsvJ9/ead38wgdQ11sTH75DktRpFIMSpbeBofh0N7Wq0UbErfH7Ao+ji4P2hF17ynf33poAdso+nVOcgQ0H6C3vhA7zAp86BbOlHq3oRxAgw0gDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731568339; c=relaxed/simple;
	bh=8SgpE9YDcrTA012K14vrax0ivdaBXLipaFt0CmFxTIo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IXYWmpRt10c6r0+O0ywcQrZbgM7WMEyM/13uGJO/Vy2BhltswLJa5ShsoanZ/j5ki1SzgedH3Stmr0ViZLOWkxiWGcd4Jw1HiJ6fsaxlsNNHGr12Bq5Aqcqku8dZhgw+lrdL2EZOfjEimAbAE1d5PtMlWbW1RzoNdnvStFSmaF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=CarnZG7U; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20c70abba48so2472065ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2024 23:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1731568336; x=1732173136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B7U/+pm4C7G3MffORaQg9XRo4wU6QnXYyTp4dM+QVVY=;
        b=CarnZG7UQ2IBBaDkyqWguP7NdB6lv1R9jzdnwSaLvO9l/Vc1mW5ImrT35ziGFQ4Rx0
         SQKaVsdSzCCmFQRsi823jhkjPU/9fmeIww+cY+OPfFoFunhkHJrVoEJO1zJn7kGiT4fP
         ZDJfaY3ABJRRQ+zuTc9dnfFUpz06XbaAAj5oC9xFiXkR/WJ2s3bdxd1l/3FrZ+ESnhBh
         j5gO6OkfGoLW9/Hb+u5SCkFv7SPK5nEy8KvI7tQPaKKVj2nOxy4pTt/kp4M/hW/378ZZ
         cngM4FP91i/Vt2ToMuIaolJbpp58+vLNWg0eIWvrLgnoPZ9MX3eTx5PTesLDaZfKAXdM
         oFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731568336; x=1732173136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B7U/+pm4C7G3MffORaQg9XRo4wU6QnXYyTp4dM+QVVY=;
        b=NuAv0OptmimUQrqjBbdbLrb7WF1CmLV2SWhvQYW7/Qn1BFIW94X1D2yCmhCvXr3cF+
         8JwuMtd2ae5gJsr8pStMJWazQnBMYre4H+DbFqhP2DNg30TuRBL3P4W9TD1j39Eq6e2S
         wOX5O3lhwPRKT/jGa1dvgf0S7EvMaGebLf2xoUYGriFtgXr4o6ohiMDJGUCPZMkCf8dp
         Wh3J7i3KY2CEtFDp8VAur68aWUUAR5kY1jeKR8oo9ZHOERB9CKy+b6tloP1ij+v16q2l
         7I4qffq1LhKTtzC8jlxeUecCqnDCt0E6bzvAm+qQxWYWzGkAdMNAxW6kF4RKrNvCVQZ5
         GdFQ==
X-Gm-Message-State: AOJu0YyN+uTLjfdJV/4ohwFisypWYn07oS/jyu+MDZy55q59UdqRHHYq
	Nu0baHslJ+Cz6nocG6DeSrbSfvutDFh7Iefd/usXTk09FZFI5pTp+os99gao2IvIWLVAiiGIWqu
	4I4s=
X-Google-Smtp-Source: AGHT+IHeIv6bdFLvavTRALfsdpDSUrwQPBGHk50OYa6tDA1Mw86vDD1G8vHgNwm5gnHH+jBxpoFn8w==
X-Received: by 2002:a17:903:41ca:b0:205:8275:768 with SMTP id d9443c01a7336-211c4fee470mr11769345ad.21.1731568336411;
        Wed, 13 Nov 2024 23:12:16 -0800 (PST)
Received: from tianci-mac.bytedance.net ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211c7d01c7dsm4345155ad.192.2024.11.13.23.12.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 Nov 2024 23:12:15 -0800 (PST)
From: Zhang Tianci <zhangtianci.1997@bytedance.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xieyongji@bytedance.com,
	Zhang Tianci <zhangtianci.1997@bytedance.com>,
	Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Subject: [PATCH] fuse: check attributes staleness on fuse_iget()
Date: Thu, 14 Nov 2024 15:09:05 +0800
Message-ID: <20241114070905.48901-1-zhangtianci.1997@bytedance.com>
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

Reported-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Suggested-by: Miklos Szeredi <miklos@szeredi.hu>
Signed-off-by: Zhang Tianci <zhangtianci.1997@bytedance.com>
---
 fs/fuse/dir.c     | 11 +++++++----
 fs/fuse/fuse_i.h  | 11 ++++++++++-
 fs/fuse/inode.c   | 14 +++++++++++---
 fs/fuse/readdir.c | 15 +++++++++------
 4 files changed, 37 insertions(+), 14 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 54104dd48af7c..7d0a0fab69207 100644
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
@@ -691,7 +692,8 @@ static int fuse_create_open(struct mnt_idmap *idmap, struct inode *dir,
 	ff->nodeid = outentry.nodeid;
 	ff->open_flags = outopenp->open_flags;
 	inode = fuse_iget(dir->i_sb, outentry.nodeid, outentry.generation,
-			  &outentry.attr, ATTR_TIMEOUT(&outentry), 0);
+			  &outentry.attr, ATTR_TIMEOUT(&outentry), 0,
+			  fuse_get_evict_ctr(fm->fc));
 	if (!inode) {
 		flags &= ~(O_CREAT | O_EXCL | O_TRUNC);
 		fuse_sync_release(NULL, ff, flags);
@@ -822,7 +824,8 @@ static int create_new_entry(struct mnt_idmap *idmap, struct fuse_mount *fm,
 		goto out_put_forget_req;
 
 	inode = fuse_iget(dir->i_sb, outarg.nodeid, outarg.generation,
-			  &outarg.attr, ATTR_TIMEOUT(&outarg), 0);
+			  &outarg.attr, ATTR_TIMEOUT(&outarg), 0,
+			  fuse_get_evict_ctr(fm->fc));
 	if (!inode) {
 		fuse_queue_forget(fm->fc, forget, outarg.nodeid, 1);
 		return -ENOMEM;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index e6cc3d552b138..f9ff0d0029aba 100644
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
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index fd3321e29a3e5..872c61dd56618 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -173,6 +173,7 @@ static void fuse_evict_inode(struct inode *inode)
 			fuse_cleanup_submount_lookup(fc, fi->submount_lookup);
 			fi->submount_lookup = NULL;
 		}
+		atomic64_inc(&fc->evict_ctr);
 	}
 	if (S_ISREG(inode->i_mode) && !fuse_is_bad(inode)) {
 		WARN_ON(fi->iocachectr != 0);
@@ -426,7 +427,8 @@ static int fuse_inode_set(struct inode *inode, void *_nodeidp)
 
 struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 			int generation, struct fuse_attr *attr,
-			u64 attr_valid, u64 attr_version)
+			u64 attr_valid, u64 attr_version,
+			u64 evict_ctr)
 {
 	struct inode *inode;
 	struct fuse_inode *fi;
@@ -488,6 +490,10 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 	spin_unlock(&fi->lock);
 done:
 	fuse_change_attributes(inode, attr, NULL, attr_valid, attr_version);
+	spin_lock(&fi->lock);
+	if (evict_ctr < fuse_get_evict_ctr(fc))
+		fuse_invalidate_attr(inode);
+	spin_unlock(&fi->lock);
 
 	return inode;
 }
@@ -940,6 +946,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 	fc->initialized = 0;
 	fc->connected = 1;
 	atomic64_set(&fc->attr_version, 1);
+	atomic64_set(&fc->evict_ctr, 1);
 	get_random_bytes(&fc->scramble_key, sizeof(fc->scramble_key));
 	fc->pid_ns = get_pid_ns(task_active_pid_ns(current));
 	fc->user_ns = get_user_ns(user_ns);
@@ -1001,7 +1008,7 @@ static struct inode *fuse_get_root_inode(struct super_block *sb, unsigned mode)
 	attr.mode = mode;
 	attr.ino = FUSE_ROOT_ID;
 	attr.nlink = 1;
-	return fuse_iget(sb, FUSE_ROOT_ID, 0, &attr, 0, 0);
+	return fuse_iget(sb, FUSE_ROOT_ID, 0, &attr, 0, 0, 0);
 }
 
 struct fuse_inode_handle {
@@ -1610,7 +1617,8 @@ static int fuse_fill_super_submount(struct super_block *sb,
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


