Return-Path: <linux-fsdevel+bounces-55353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B6CB09827
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49F893A2615
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C1823FC4C;
	Thu, 17 Jul 2025 23:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jphjrluM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF8F1FCFF8
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 23:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795390; cv=none; b=Bhc3jUisOnFOike+EXBliqKPddCw3qQxjzF+SoC/qcnJRNrlin+J4sqGO2n5/lMRfT0TmweYsd43Jvq3PV+FfAkUIek9Nu34CCjkh/29Y9NBw/ZvQ3qFgVH/OkWN1T99IzY+HOaNYb3Nuil0BQW7zf7INJmt0KZ/FvF95u5N+eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795390; c=relaxed/simple;
	bh=iR1XxPZUMWaeQn/3YtH0FrRkz6fTDeROg834SE8mBnc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KumCRdcS/FI9nAG5FfY4iGHINHMUKa/O2ibTUO/O/Glfd3WNqI1gX5+N6RGIdf7SP6Abc4PERc48pdKgE5P3iNB8kjZIJfJeMn7zsp8BSrl6tufOvgE94CjcoG/rQ/g0aXkr7jCYms6LniM88IZzs24m96eE4YmOHxl4pDmSCn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jphjrluM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73713C4CEE3;
	Thu, 17 Jul 2025 23:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795390;
	bh=iR1XxPZUMWaeQn/3YtH0FrRkz6fTDeROg834SE8mBnc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=jphjrluMH7uvmysxNmLETrIl/MXoB7D/zJ1NRimC/24MQ5qLP0K99QIaBF55W6bRk
	 1pK69v8lItVZEwCr2f6oWIXWdaT2+/iCthDqtlxfilFiOWe2A2pKXM4YlcORFmjxso
	 jbxugNalW/+zGj/dRe/DF1Bmmi/LbGpi60mdI5A49s64bIBvNA5qtiE+s7VGrpOV4B
	 4DhURHjk0HFwlvf7paz33D26/fQhWG/Np94FEDGLVL6O1c9UaO7N4j07jrb87T0OS9
	 4nBD7HE4XKvF0l7EVNgYY1TmmVGIQKlPbL0LDsJsknz3cp6O5eFyojNMDB9YLhCyCD
	 P0KApw4nTLD/Q==
Date: Thu, 17 Jul 2025 16:36:29 -0700
Subject: [PATCH 08/14] libfuse: connect high level fuse library to
 fuse_reply_attr_iflags
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: John@groves.net, joannelkoong@gmail.com, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, neal@gompa.dev, miklos@szeredi.hu
Message-ID: <175279459875.714161.9108157061004962886.stgit@frogsfrogsfrogs>
In-Reply-To: <175279459673.714161.10658209239262310420.stgit@frogsfrogsfrogs>
References: <175279459673.714161.10658209239262310420.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Create a new ->getattr_iflags function so that iomap filesystems can set
the appropriate in-kernel inode flags on instantiation.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse.h |    7 ++
 lib/fuse.c     |  219 ++++++++++++++++++++++++++++++++++++++++++++------------
 2 files changed, 180 insertions(+), 46 deletions(-)


diff --git a/include/fuse.h b/include/fuse.h
index e2e7c950bf144d..f894dd5da0d106 100644
--- a/include/fuse.h
+++ b/include/fuse.h
@@ -876,6 +876,13 @@ struct fuse_operations {
 			    uint64_t attr_ino, off_t pos_in, size_t written_in,
 			    uint32_t ioendflags_in, int error_in,
 			    uint64_t new_addr_in);
+
+	/**
+	 * Get file attributes and FUSE_IFLAG_* flags.  Otherwise the same as
+	 * getattr.
+	 */
+	int (*getattr_iflags) (const char *path, struct stat *buf,
+			       unsigned int *iflags, struct fuse_file_info *fi);
 #endif /* FUSE_USE_VERSION >= 318 */
 };
 
diff --git a/lib/fuse.c b/lib/fuse.c
index 8dbf88877dd37c..685d0181e569d0 100644
--- a/lib/fuse.c
+++ b/lib/fuse.c
@@ -123,6 +123,7 @@ struct fuse {
 	struct list_head partial_slabs;
 	struct list_head full_slabs;
 	pthread_t prune_thread;
+	bool want_iflags;
 };
 
 struct lock {
@@ -144,6 +145,7 @@ struct node {
 	char *name;
 	uint64_t nlookup;
 	int open_count;
+	unsigned int iflags;
 	struct timespec stat_updated;
 	struct timespec mtime;
 	off_t size;
@@ -1605,6 +1607,24 @@ int fuse_fs_getattr(struct fuse_fs *fs, const char *path, struct stat *buf,
 	return fs->op.getattr(path, buf, fi);
 }
 
+static int fuse_fs_getattr_iflags(struct fuse_fs *fs, const char *path,
+				  struct stat *buf, unsigned int *iflags,
+				  struct fuse_file_info *fi)
+{
+	fuse_get_context()->private_data = fs->user_data;
+	if (!fs->op.getattr_iflags)
+		return -ENOSYS;
+
+	if (fs->debug) {
+		char buf[10];
+
+		fuse_log(FUSE_LOG_DEBUG, "getattr_iflags[%s] %s\n",
+			file_info_string(fi, buf, sizeof(buf)),
+			path);
+	}
+	return fs->op.getattr_iflags(path, buf, iflags, fi);
+}
+
 int fuse_fs_rename(struct fuse_fs *fs, const char *oldpath,
 		   const char *newpath, unsigned int flags)
 {
@@ -2417,7 +2437,7 @@ static void update_stat(struct node *node, const struct stat *stbuf)
 }
 
 static int do_lookup(struct fuse *f, fuse_ino_t nodeid, const char *name,
-		     struct fuse_entry_param *e)
+		     struct fuse_entry_param *e, unsigned int *iflags)
 {
 	struct node *node;
 
@@ -2435,25 +2455,59 @@ static int do_lookup(struct fuse *f, fuse_ino_t nodeid, const char *name,
 		pthread_mutex_unlock(&f->lock);
 	}
 	set_stat(f, e->ino, &e->attr);
+	*iflags = node->iflags;
+	return 0;
+}
+
+static int lookup_and_update(struct fuse *f, fuse_ino_t nodeid,
+			     const char *name, struct fuse_entry_param *e,
+			     unsigned int iflags)
+{
+	struct node *node;
+
+	node = find_node(f, nodeid, name);
+	if (node == NULL)
+		return -ENOMEM;
+
+	e->ino = node->nodeid;
+	e->generation = node->generation;
+	e->entry_timeout = f->conf.entry_timeout;
+	e->attr_timeout = f->conf.attr_timeout;
+	if (f->conf.auto_cache) {
+		pthread_mutex_lock(&f->lock);
+		update_stat(node, &e->attr);
+		pthread_mutex_unlock(&f->lock);
+	}
+	set_stat(f, e->ino, &e->attr);
+	node->iflags = iflags;
 	return 0;
 }
 
 static int lookup_path(struct fuse *f, fuse_ino_t nodeid,
 		       const char *name, const char *path,
-		       struct fuse_entry_param *e, struct fuse_file_info *fi)
+		       struct fuse_entry_param *e, unsigned int *iflags,
+		       struct fuse_file_info *fi)
 {
 	int res;
 
 	memset(e, 0, sizeof(struct fuse_entry_param));
-	res = fuse_fs_getattr(f->fs, path, &e->attr, fi);
-	if (res == 0) {
-		res = do_lookup(f, nodeid, name, e);
-		if (res == 0 && f->conf.debug) {
-			fuse_log(FUSE_LOG_DEBUG, "   NODEID: %llu\n",
-				(unsigned long long) e->ino);
-		}
-	}
-	return res;
+	*iflags = 0;
+	if (f->want_iflags)
+		res = fuse_fs_getattr_iflags(f->fs, path, &e->attr, iflags, fi);
+	else
+		res = fuse_fs_getattr(f->fs, path, &e->attr, fi);
+	if (res)
+		return res;
+
+	res = lookup_and_update(f, nodeid, name, e, *iflags);
+	if (res)
+		return res;
+
+	if (f->conf.debug)
+		fuse_log(FUSE_LOG_DEBUG, "   NODEID: %llu iflags 0x%x\n",
+			(unsigned long long) e->ino, *iflags);
+
+	return 0;
 }
 
 static struct fuse_context_i *fuse_get_context_internal(void)
@@ -2537,11 +2591,17 @@ static inline void reply_err(fuse_req_t req, int err)
 }
 
 static void reply_entry(fuse_req_t req, const struct fuse_entry_param *e,
-			int err)
+			unsigned int iflags, int err)
 {
 	if (!err) {
 		struct fuse *f = req_fuse(req);
-		if (fuse_reply_entry(req, e) == -ENOENT) {
+		int entry_res;
+
+		if (f->want_iflags)
+			entry_res = fuse_reply_entry_iflags(req, e, iflags);
+		else
+			entry_res = fuse_reply_entry(req, e);
+		if (entry_res == -ENOENT) {
 			/* Skip forget for negative result */
 			if  (e->ino != 0)
 				forget_node(f, e->ino, 1);
@@ -2582,6 +2642,9 @@ static void fuse_lib_init(void *data, struct fuse_conn_info *conn)
 		/* Disable the receiving and processing of FUSE_INTERRUPT requests */
 		conn->no_interrupt = 1;
 	}
+
+	if (fuse_get_feature_flag(conn, FUSE_CAP_IOMAP))
+		f->want_iflags = true;
 }
 
 void fuse_fs_destroy(struct fuse_fs *fs)
@@ -2605,6 +2668,7 @@ static void fuse_lib_lookup(fuse_req_t req, fuse_ino_t parent,
 	struct fuse *f = req_fuse_prepare(req);
 	struct fuse_entry_param e;
 	char *path;
+	unsigned int iflags = 0;
 	int err;
 	struct node *dot = NULL;
 
@@ -2619,7 +2683,7 @@ static void fuse_lib_lookup(fuse_req_t req, fuse_ino_t parent,
 				dot = get_node_nocheck(f, parent);
 				if (dot == NULL) {
 					pthread_mutex_unlock(&f->lock);
-					reply_entry(req, &e, -ESTALE);
+					reply_entry(req, &e, -ESTALE, 0);
 					return;
 				}
 				dot->refctr++;
@@ -2639,7 +2703,7 @@ static void fuse_lib_lookup(fuse_req_t req, fuse_ino_t parent,
 		if (f->conf.debug)
 			fuse_log(FUSE_LOG_DEBUG, "LOOKUP %s\n", path);
 		fuse_prepare_interrupt(f, req, &d);
-		err = lookup_path(f, parent, name, path, &e, NULL);
+		err = lookup_path(f, parent, name, path, &e, &iflags, NULL);
 		if (err == -ENOENT && f->conf.negative_timeout != 0.0) {
 			e.ino = 0;
 			e.entry_timeout = f->conf.negative_timeout;
@@ -2653,7 +2717,7 @@ static void fuse_lib_lookup(fuse_req_t req, fuse_ino_t parent,
 		unref_node(f, dot);
 		pthread_mutex_unlock(&f->lock);
 	}
-	reply_entry(req, &e, err);
+	reply_entry(req, &e, iflags, err);
 }
 
 static void do_forget(struct fuse *f, fuse_ino_t ino, uint64_t nlookup)
@@ -2689,6 +2753,7 @@ static void fuse_lib_getattr(fuse_req_t req, fuse_ino_t ino,
 	struct fuse *f = req_fuse_prepare(req);
 	struct stat buf;
 	char *path;
+	unsigned int iflags = 0;
 	int err;
 
 	memset(&buf, 0, sizeof(buf));
@@ -2700,7 +2765,11 @@ static void fuse_lib_getattr(fuse_req_t req, fuse_ino_t ino,
 	if (!err) {
 		struct fuse_intr_data d;
 		fuse_prepare_interrupt(f, req, &d);
-		err = fuse_fs_getattr(f->fs, path, &buf, fi);
+		if (f->want_iflags)
+			err = fuse_fs_getattr_iflags(f->fs, path, &buf,
+						     &iflags, fi);
+		else
+			err = fuse_fs_getattr(f->fs, path, &buf, fi);
 		fuse_finish_interrupt(f, req, &d);
 		free_path(f, ino, path);
 	}
@@ -2713,9 +2782,14 @@ static void fuse_lib_getattr(fuse_req_t req, fuse_ino_t ino,
 			buf.st_nlink--;
 		if (f->conf.auto_cache)
 			update_stat(node, &buf);
+		node->iflags = iflags;
 		pthread_mutex_unlock(&f->lock);
 		set_stat(f, ino, &buf);
-		fuse_reply_attr(req, &buf, f->conf.attr_timeout);
+		if (f->want_iflags)
+			fuse_reply_attr_iflags(req, &buf, iflags,
+					       f->conf.attr_timeout);
+		else
+			fuse_reply_attr(req, &buf, f->conf.attr_timeout);
 	} else
 		reply_err(req, err);
 }
@@ -2802,6 +2876,7 @@ static void fuse_lib_setattr(fuse_req_t req, fuse_ino_t ino, struct stat *attr,
 	struct fuse *f = req_fuse_prepare(req);
 	struct stat buf;
 	char *path;
+	unsigned int iflags = 0;
 	int err;
 
 	memset(&buf, 0, sizeof(buf));
@@ -2860,19 +2935,30 @@ static void fuse_lib_setattr(fuse_req_t req, fuse_ino_t ino, struct stat *attr,
 			err = fuse_fs_utimens(f->fs, path, tv, fi);
 		}
 		if (!err) {
-			err = fuse_fs_getattr(f->fs, path, &buf, fi);
+			if (f->want_iflags)
+				err = fuse_fs_getattr_iflags(f->fs, path, &buf,
+							     &iflags, fi);
+			else
+				err = fuse_fs_getattr(f->fs, path, &buf, fi);
 		}
 		fuse_finish_interrupt(f, req, &d);
 		free_path(f, ino, path);
 	}
 	if (!err) {
-		if (f->conf.auto_cache) {
-			pthread_mutex_lock(&f->lock);
-			update_stat(get_node(f, ino), &buf);
-			pthread_mutex_unlock(&f->lock);
-		}
+		struct node *node;
+
+		pthread_mutex_lock(&f->lock);
+		node = get_node(f, ino);
+		if (f->conf.auto_cache)
+			update_stat(node, &buf);
+		node->iflags = iflags;
+		pthread_mutex_unlock(&f->lock);
 		set_stat(f, ino, &buf);
-		fuse_reply_attr(req, &buf, f->conf.attr_timeout);
+		if (f->want_iflags)
+			fuse_reply_attr_iflags(req, &buf, iflags,
+					       f->conf.attr_timeout);
+		else
+			fuse_reply_attr(req, &buf, f->conf.attr_timeout);
 	} else
 		reply_err(req, err);
 }
@@ -2923,6 +3009,7 @@ static void fuse_lib_mknod(fuse_req_t req, fuse_ino_t parent, const char *name,
 	struct fuse *f = req_fuse_prepare(req);
 	struct fuse_entry_param e;
 	char *path;
+	unsigned int iflags = 0;
 	int err;
 
 	err = get_path_name(f, parent, name, &path);
@@ -2939,7 +3026,7 @@ static void fuse_lib_mknod(fuse_req_t req, fuse_ino_t parent, const char *name,
 			err = fuse_fs_create(f->fs, path, mode, &fi);
 			if (!err) {
 				err = lookup_path(f, parent, name, path, &e,
-						  &fi);
+						  &iflags, &fi);
 				fuse_fs_release(f->fs, path, &fi);
 			}
 		}
@@ -2947,12 +3034,12 @@ static void fuse_lib_mknod(fuse_req_t req, fuse_ino_t parent, const char *name,
 			err = fuse_fs_mknod(f->fs, path, mode, rdev);
 			if (!err)
 				err = lookup_path(f, parent, name, path, &e,
-						  NULL);
+						  &iflags, NULL);
 		}
 		fuse_finish_interrupt(f, req, &d);
 		free_path(f, parent, path);
 	}
-	reply_entry(req, &e, err);
+	reply_entry(req, &e, iflags, err);
 }
 
 static void fuse_lib_mkdir(fuse_req_t req, fuse_ino_t parent, const char *name,
@@ -2961,6 +3048,7 @@ static void fuse_lib_mkdir(fuse_req_t req, fuse_ino_t parent, const char *name,
 	struct fuse *f = req_fuse_prepare(req);
 	struct fuse_entry_param e;
 	char *path;
+	unsigned int iflags = 0;
 	int err;
 
 	err = get_path_name(f, parent, name, &path);
@@ -2970,11 +3058,12 @@ static void fuse_lib_mkdir(fuse_req_t req, fuse_ino_t parent, const char *name,
 		fuse_prepare_interrupt(f, req, &d);
 		err = fuse_fs_mkdir(f->fs, path, mode);
 		if (!err)
-			err = lookup_path(f, parent, name, path, &e, NULL);
+			err = lookup_path(f, parent, name, path, &e, &iflags,
+					  NULL);
 		fuse_finish_interrupt(f, req, &d);
 		free_path(f, parent, path);
 	}
-	reply_entry(req, &e, err);
+	reply_entry(req, &e, iflags, err);
 }
 
 static void fuse_lib_unlink(fuse_req_t req, fuse_ino_t parent,
@@ -3044,6 +3133,7 @@ static void fuse_lib_symlink(fuse_req_t req, const char *linkname,
 	struct fuse *f = req_fuse_prepare(req);
 	struct fuse_entry_param e;
 	char *path;
+	unsigned int iflags = 0;
 	int err;
 
 	err = get_path_name(f, parent, name, &path);
@@ -3053,11 +3143,12 @@ static void fuse_lib_symlink(fuse_req_t req, const char *linkname,
 		fuse_prepare_interrupt(f, req, &d);
 		err = fuse_fs_symlink(f->fs, linkname, path);
 		if (!err)
-			err = lookup_path(f, parent, name, path, &e, NULL);
+			err = lookup_path(f, parent, name, path, &e, &iflags,
+					  NULL);
 		fuse_finish_interrupt(f, req, &d);
 		free_path(f, parent, path);
 	}
-	reply_entry(req, &e, err);
+	reply_entry(req, &e, iflags, err);
 }
 
 static void fuse_lib_rename(fuse_req_t req, fuse_ino_t olddir,
@@ -3105,6 +3196,7 @@ static void fuse_lib_link(fuse_req_t req, fuse_ino_t ino, fuse_ino_t newparent,
 	struct fuse_entry_param e;
 	char *oldpath;
 	char *newpath;
+	unsigned int iflags = 0;
 	int err;
 
 	err = get_path2(f, ino, NULL, newparent, newname,
@@ -3116,11 +3208,11 @@ static void fuse_lib_link(fuse_req_t req, fuse_ino_t ino, fuse_ino_t newparent,
 		err = fuse_fs_link(f->fs, oldpath, newpath);
 		if (!err)
 			err = lookup_path(f, newparent, newname, newpath,
-					  &e, NULL);
+					  &e, &iflags, NULL);
 		fuse_finish_interrupt(f, req, &d);
 		free_path2(f, ino, newparent, NULL, NULL, oldpath, newpath);
 	}
-	reply_entry(req, &e, err);
+	reply_entry(req, &e, iflags, err);
 }
 
 static void fuse_do_release(struct fuse *f, fuse_ino_t ino, const char *path,
@@ -3163,6 +3255,7 @@ static void fuse_lib_create(fuse_req_t req, fuse_ino_t parent,
 	struct fuse_intr_data d;
 	struct fuse_entry_param e;
 	char *path;
+	unsigned int iflags;
 	int err;
 
 	err = get_path_name(f, parent, name, &path);
@@ -3170,7 +3263,8 @@ static void fuse_lib_create(fuse_req_t req, fuse_ino_t parent,
 		fuse_prepare_interrupt(f, req, &d);
 		err = fuse_fs_create(f->fs, path, mode, fi);
 		if (!err) {
-			err = lookup_path(f, parent, name, path, &e, fi);
+			err = lookup_path(f, parent, name, path, &e,
+					  &iflags, fi);
 			if (err)
 				fuse_fs_release(f->fs, path, fi);
 			else if (!S_ISREG(e.attr.st_mode)) {
@@ -3190,10 +3284,18 @@ static void fuse_lib_create(fuse_req_t req, fuse_ino_t parent,
 		fuse_finish_interrupt(f, req, &d);
 	}
 	if (!err) {
+		int create_res;
+
 		pthread_mutex_lock(&f->lock);
 		get_node(f, e.ino)->open_count++;
 		pthread_mutex_unlock(&f->lock);
-		if (fuse_reply_create(req, &e, fi) == -ENOENT) {
+
+		if (f->want_iflags)
+			create_res = fuse_reply_create_iflags(req, &e, iflags,
+							      fi);
+		else
+			create_res = fuse_reply_create(req, &e, fi);
+		if (create_res == -ENOENT) {
 			/* The open syscall was interrupted, so it
 			   must be cancelled */
 			fuse_do_release(f, e.ino, path, fi);
@@ -3227,13 +3329,21 @@ static void open_auto_cache(struct fuse *f, fuse_ino_t ino, const char *path,
 		if (diff_timespec(&now, &node->stat_updated) >
 		    f->conf.ac_attr_timeout) {
 			struct stat stbuf;
+			unsigned int iflags = 0;
 			int err;
+
 			pthread_mutex_unlock(&f->lock);
-			err = fuse_fs_getattr(f->fs, path, &stbuf, fi);
+			if (f->want_iflags)
+				err = fuse_fs_getattr_iflags(f->fs, path,
+							     &stbuf, &iflags,
+							     fi);
+			else
+				err = fuse_fs_getattr(f->fs, path, &stbuf, fi);
 			pthread_mutex_lock(&f->lock);
-			if (!err)
+			if (!err) {
 				update_stat(node, &stbuf);
-			else
+				node->iflags = iflags;
+			} else
 				node->cache_valid = 0;
 		}
 	}
@@ -3562,6 +3672,7 @@ static int fill_dir_plus(void *dh_, const char *name, const struct stat *statp,
 		.ino = 0,
 	};
 	struct fuse *f = dh->fuse;
+	unsigned int iflags = 0;
 	int res;
 
 	if ((flags & ~FUSE_FILL_DIR_PLUS) != 0) {
@@ -3586,6 +3697,7 @@ static int fill_dir_plus(void *dh_, const char *name, const struct stat *statp,
 
 	if (off) {
 		size_t newlen;
+		size_t thislen;
 
 		if (dh->filled) {
 			dh->error = -EIO;
@@ -3601,7 +3713,8 @@ static int fill_dir_plus(void *dh_, const char *name, const struct stat *statp,
 
 		if (statp && (flags & FUSE_FILL_DIR_PLUS)) {
 			if (!is_dot_or_dotdot(name)) {
-				res = do_lookup(f, dh->nodeid, name, &e);
+				res = do_lookup(f, dh->nodeid, name, &e,
+						&iflags);
 				if (res) {
 					dh->error = res;
 					return 1;
@@ -3609,10 +3722,17 @@ static int fill_dir_plus(void *dh_, const char *name, const struct stat *statp,
 			}
 		}
 
-		newlen = dh->len +
-			fuse_add_direntry_plus(dh->req, dh->contents + dh->len,
-					       dh->needlen - dh->len, name,
-					       &e, off);
+		if (f->want_iflags)
+			thislen = fuse_add_direntry_plus_iflags(dh->req,
+					dh->contents + dh->len,
+					dh->needlen - dh->len, name, iflags,
+					&e, off);
+		else
+			thislen = fuse_add_direntry_plus(dh->req,
+					dh->contents + dh->len,
+					dh->needlen - dh->len, name, &e, off);
+		newlen = dh->len + thislen;
+
 		if (newlen > dh->needlen)
 			return 1;
 		dh->len = newlen;
@@ -3679,6 +3799,7 @@ static int readdir_fill(struct fuse *f, fuse_req_t req, fuse_ino_t ino,
 static int readdir_fill_from_list(fuse_req_t req, struct fuse_dh *dh,
 				  off_t off, enum fuse_readdir_flags flags)
 {
+	struct fuse *f = req_fuse_prepare(req);
 	off_t pos;
 	struct fuse_direntry *de = dh->first;
 	int res;
@@ -3699,6 +3820,7 @@ static int readdir_fill_from_list(fuse_req_t req, struct fuse_dh *dh,
 		unsigned rem = dh->needlen - dh->len;
 		unsigned thislen;
 		unsigned newlen;
+		unsigned int iflags = 0;
 		pos++;
 
 		if (flags & FUSE_READDIR_PLUS) {
@@ -3710,14 +3832,19 @@ static int readdir_fill_from_list(fuse_req_t req, struct fuse_dh *dh,
 			if (de->flags & FUSE_FILL_DIR_PLUS &&
 			    !is_dot_or_dotdot(de->name)) {
 				res = do_lookup(dh->fuse, dh->nodeid,
-						de->name, &e);
+						de->name, &e, &iflags);
 				if (res) {
 					dh->error = res;
 					return 1;
 				}
 			}
 
-			thislen = fuse_add_direntry_plus(req, p, rem,
+			if (f->want_iflags)
+				thislen = fuse_add_direntry_plus_iflags(req, p,
+							 rem, de->name, iflags,
+							 &e, pos);
+			else
+				thislen = fuse_add_direntry_plus(req, p, rem,
 							 de->name, &e, pos);
 		} else {
 			thislen = fuse_add_direntry(req, p, rem,


