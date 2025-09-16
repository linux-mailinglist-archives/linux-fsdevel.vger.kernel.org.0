Return-Path: <linux-fsdevel+bounces-61570-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B78B589F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E08ED16EADA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9F314F112;
	Tue, 16 Sep 2025 00:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IiYpS4Cv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6621A5B92
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 00:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757983464; cv=none; b=QPXFFCIr6pVTBaa3NZkcHDd/KzgkGqOsh93VZTZGyE8t1u6a7WVQiFdAGy+PayLO6PH/vghOb6o4FT2MNKgQn0AUQRF42fpM8mBOQwyX1MzjFynAt0addk0tTShXq2rTOwtL145hu9+FmVJLNzIHbXkFxsGwpVtjTfhL+B3gs8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757983464; c=relaxed/simple;
	bh=H/I0ZHSmv53XAljq+dsb+4lul5558+uK9LEQd/1Ys+I=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dqh0ffPy8ao4v46HZ0fox+rL0quA9V25uroN53osGBTueIhGx1DfTNHGOtjWerHbg65gJmcFGtB5rAF4FEL9HxBa0iEZMNN08OFmEM8ujqmkHwvG/eyc4PGFaBWpdaK5x9KCBtaVcBD1zZpGkyVIItQq62fPXsMxv9flWoVlmiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IiYpS4Cv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E15C4CEF1;
	Tue, 16 Sep 2025 00:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757983464;
	bh=H/I0ZHSmv53XAljq+dsb+4lul5558+uK9LEQd/1Ys+I=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=IiYpS4CvcMv7hpwCjcS3Ql8E1lB07h6Uqs0IkqANJ7gcIzg7VEeZCXH7jz3DgSltK
	 K+FifxokjUWBIGLiqQpLewIWmdA0LIc2jZr3TKtJ9QPPLaEUnNCKFsHJoMReOE9p3M
	 tAmNPDUoOaMqpj3Ihl2FtqbS+/x/4D85B3zbgGTwQQHvVpq9RHtwx4dpkv7mfQk8/h
	 bkqWxHj+gpYMd0GzCXK91nBFDT4o8/GDlSgjOxB7g8z8cf5vMujlNYfMOFYOvhO9MJ
	 5GZTG80jykdhXlR0X1MB0MUaiENB2uuRW3AB2qceNyyITdDJGAdmzYlH1o6nm3jzuI
	 mXJlAkfJIlbOQ==
Date: Mon, 15 Sep 2025 17:44:23 -0700
Subject: [PATCH 10/18] libfuse: connect high level fuse library to
 fuse_reply_attr_iflags
From: "Darrick J. Wong" <djwong@kernel.org>
To: bschubert@ddn.com, djwong@kernel.org
Cc: John@groves.net, neal@gompa.dev, bernd@bsbernd.com,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com
Message-ID: <175798154690.386924.3963879587707129321.stgit@frogsfrogsfrogs>
In-Reply-To: <175798154438.386924.8786074960979860206.stgit@frogsfrogsfrogs>
References: <175798154438.386924.8786074960979860206.stgit@frogsfrogsfrogs>
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
 lib/fuse.c     |  191 ++++++++++++++++++++++++++++++++++++++++++--------------
 2 files changed, 151 insertions(+), 47 deletions(-)


diff --git a/include/fuse.h b/include/fuse.h
index 1357f4319bcc21..7256f43fd5c39a 100644
--- a/include/fuse.h
+++ b/include/fuse.h
@@ -889,6 +889,13 @@ struct fuse_operations {
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
 };
 
 /** Extra context that may be needed by some filesystems
diff --git a/lib/fuse.c b/lib/fuse.c
index 725ab615d456e3..6b211084e2175a 100644
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
@@ -1628,6 +1630,24 @@ int fuse_fs_getattr(struct fuse_fs *fs, const char *path, struct stat *buf,
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
@@ -2473,7 +2493,7 @@ static void update_stat(struct node *node, const struct stat *stbuf)
 }
 
 static int do_lookup(struct fuse *f, fuse_ino_t nodeid, const char *name,
-		     struct fuse_entry_param *e)
+		     struct fuse_entry_param *e, unsigned int *iflags)
 {
 	struct node *node;
 
@@ -2491,25 +2511,64 @@ static int do_lookup(struct fuse *f, fuse_ino_t nodeid, const char *name,
 		pthread_mutex_unlock(&f->lock);
 	}
 	set_stat(f, e->ino, &e->attr);
+	*iflags = node->iflags;
 	return 0;
 }
 
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
+	return 0;
+}
+
+static int getattr(struct fuse *f, const char *path, struct stat *buf,
+		   unsigned int *iflags, struct fuse_file_info *fi)
+{
+	if (f->want_iflags)
+		return fuse_fs_getattr_iflags(f->fs, path, buf, iflags, fi);
+	return fuse_fs_getattr(f->fs, path, buf, fi);
+}
+
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
+	res = getattr(f, path, &e->attr, iflags, fi);
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
@@ -2593,11 +2652,14 @@ static inline void reply_err(fuse_req_t req, int err)
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
+		entry_res = fuse_reply_entry_iflags(req, e, iflags);
+		if (entry_res == -ENOENT) {
 			/* Skip forget for negative result */
 			if  (e->ino != 0)
 				forget_node(f, e->ino, 1);
@@ -2638,6 +2700,9 @@ static void fuse_lib_init(void *data, struct fuse_conn_info *conn)
 		/* Disable the receiving and processing of FUSE_INTERRUPT requests */
 		conn->no_interrupt = 1;
 	}
+
+	if (conn->want_ext & FUSE_CAP_IOMAP)
+		f->want_iflags = true;
 }
 
 void fuse_fs_destroy(struct fuse_fs *fs)
@@ -2661,6 +2726,7 @@ static void fuse_lib_lookup(fuse_req_t req, fuse_ino_t parent,
 	struct fuse *f = req_fuse_prepare(req);
 	struct fuse_entry_param e;
 	char *path;
+	unsigned int iflags = 0;
 	int err;
 	struct node *dot = NULL;
 
@@ -2675,7 +2741,7 @@ static void fuse_lib_lookup(fuse_req_t req, fuse_ino_t parent,
 				dot = get_node_nocheck(f, parent);
 				if (dot == NULL) {
 					pthread_mutex_unlock(&f->lock);
-					reply_entry(req, &e, -ESTALE);
+					reply_entry(req, &e, -ESTALE, 0);
 					return;
 				}
 				dot->refctr++;
@@ -2695,7 +2761,7 @@ static void fuse_lib_lookup(fuse_req_t req, fuse_ino_t parent,
 		if (f->conf.debug)
 			fuse_log(FUSE_LOG_DEBUG, "LOOKUP %s\n", path);
 		fuse_prepare_interrupt(f, req, &d);
-		err = lookup_path(f, parent, name, path, &e, NULL);
+		err = lookup_path(f, parent, name, path, &e, &iflags, NULL);
 		if (err == -ENOENT && f->conf.negative_timeout != 0.0) {
 			e.ino = 0;
 			e.entry_timeout = f->conf.negative_timeout;
@@ -2709,7 +2775,7 @@ static void fuse_lib_lookup(fuse_req_t req, fuse_ino_t parent,
 		unref_node(f, dot);
 		pthread_mutex_unlock(&f->lock);
 	}
-	reply_entry(req, &e, err);
+	reply_entry(req, &e, iflags, err);
 }
 
 static void do_forget(struct fuse *f, fuse_ino_t ino, uint64_t nlookup)
@@ -2745,6 +2811,7 @@ static void fuse_lib_getattr(fuse_req_t req, fuse_ino_t ino,
 	struct fuse *f = req_fuse_prepare(req);
 	struct stat buf;
 	char *path;
+	unsigned int iflags = 0;
 	int err;
 
 	memset(&buf, 0, sizeof(buf));
@@ -2756,7 +2823,7 @@ static void fuse_lib_getattr(fuse_req_t req, fuse_ino_t ino,
 	if (!err) {
 		struct fuse_intr_data d;
 		fuse_prepare_interrupt(f, req, &d);
-		err = fuse_fs_getattr(f->fs, path, &buf, fi);
+		err = getattr(f, path, &buf, &iflags, fi);
 		fuse_finish_interrupt(f, req, &d);
 		free_path(f, ino, path);
 	}
@@ -2769,9 +2836,11 @@ static void fuse_lib_getattr(fuse_req_t req, fuse_ino_t ino,
 			buf.st_nlink--;
 		if (f->conf.auto_cache)
 			update_stat(node, &buf);
+		node->iflags = iflags;
 		pthread_mutex_unlock(&f->lock);
 		set_stat(f, ino, &buf);
-		fuse_reply_attr(req, &buf, f->conf.attr_timeout);
+		fuse_reply_attr_iflags(req, &buf, iflags,
+				       f->conf.attr_timeout);
 	} else
 		reply_err(req, err);
 }
@@ -2874,6 +2943,7 @@ static void fuse_lib_setattr(fuse_req_t req, fuse_ino_t ino, struct stat *attr,
 	struct fuse *f = req_fuse_prepare(req);
 	struct stat buf;
 	char *path;
+	unsigned int iflags = 0;
 	int err;
 
 	memset(&buf, 0, sizeof(buf));
@@ -2932,19 +3002,23 @@ static void fuse_lib_setattr(fuse_req_t req, fuse_ino_t ino, struct stat *attr,
 			err = fuse_fs_utimens(f->fs, path, tv, fi);
 		}
 		if (!err) {
-			err = fuse_fs_getattr(f->fs, path, &buf, fi);
+			err = getattr(f, path, &buf, &iflags, fi);
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
+		fuse_reply_attr_iflags(req, &buf, iflags,
+				       f->conf.attr_timeout);
 	} else
 		reply_err(req, err);
 }
@@ -2995,6 +3069,7 @@ static void fuse_lib_mknod(fuse_req_t req, fuse_ino_t parent, const char *name,
 	struct fuse *f = req_fuse_prepare(req);
 	struct fuse_entry_param e;
 	char *path;
+	unsigned int iflags = 0;
 	int err;
 
 	err = get_path_name(f, parent, name, &path);
@@ -3011,7 +3086,7 @@ static void fuse_lib_mknod(fuse_req_t req, fuse_ino_t parent, const char *name,
 			err = fuse_fs_create(f->fs, path, mode, &fi);
 			if (!err) {
 				err = lookup_path(f, parent, name, path, &e,
-						  &fi);
+						  &iflags, &fi);
 				fuse_fs_release(f->fs, path, &fi);
 			}
 		}
@@ -3019,12 +3094,12 @@ static void fuse_lib_mknod(fuse_req_t req, fuse_ino_t parent, const char *name,
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
@@ -3033,6 +3108,7 @@ static void fuse_lib_mkdir(fuse_req_t req, fuse_ino_t parent, const char *name,
 	struct fuse *f = req_fuse_prepare(req);
 	struct fuse_entry_param e;
 	char *path;
+	unsigned int iflags = 0;
 	int err;
 
 	err = get_path_name(f, parent, name, &path);
@@ -3042,11 +3118,12 @@ static void fuse_lib_mkdir(fuse_req_t req, fuse_ino_t parent, const char *name,
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
@@ -3116,6 +3193,7 @@ static void fuse_lib_symlink(fuse_req_t req, const char *linkname,
 	struct fuse *f = req_fuse_prepare(req);
 	struct fuse_entry_param e;
 	char *path;
+	unsigned int iflags = 0;
 	int err;
 
 	err = get_path_name(f, parent, name, &path);
@@ -3125,11 +3203,12 @@ static void fuse_lib_symlink(fuse_req_t req, const char *linkname,
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
@@ -3177,6 +3256,7 @@ static void fuse_lib_link(fuse_req_t req, fuse_ino_t ino, fuse_ino_t newparent,
 	struct fuse_entry_param e;
 	char *oldpath;
 	char *newpath;
+	unsigned int iflags = 0;
 	int err;
 
 	err = get_path2(f, ino, NULL, newparent, newname,
@@ -3188,11 +3268,11 @@ static void fuse_lib_link(fuse_req_t req, fuse_ino_t ino, fuse_ino_t newparent,
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
@@ -3235,6 +3315,7 @@ static void fuse_lib_create(fuse_req_t req, fuse_ino_t parent,
 	struct fuse_intr_data d;
 	struct fuse_entry_param e;
 	char *path;
+	unsigned int iflags;
 	int err;
 
 	err = get_path_name(f, parent, name, &path);
@@ -3242,7 +3323,8 @@ static void fuse_lib_create(fuse_req_t req, fuse_ino_t parent,
 		fuse_prepare_interrupt(f, req, &d);
 		err = fuse_fs_create(f->fs, path, mode, fi);
 		if (!err) {
-			err = lookup_path(f, parent, name, path, &e, fi);
+			err = lookup_path(f, parent, name, path, &e,
+					  &iflags, fi);
 			if (err)
 				fuse_fs_release(f->fs, path, fi);
 			else if (!S_ISREG(e.attr.st_mode)) {
@@ -3262,10 +3344,14 @@ static void fuse_lib_create(fuse_req_t req, fuse_ino_t parent,
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
+		create_res = fuse_reply_create_iflags(req, &e, iflags, fi);
+		if (create_res == -ENOENT) {
 			/* The open syscall was interrupted, so it
 			   must be cancelled */
 			fuse_do_release(f, e.ino, path, fi);
@@ -3299,13 +3385,16 @@ static void open_auto_cache(struct fuse *f, fuse_ino_t ino, const char *path,
 		if (diff_timespec(&now, &node->stat_updated) >
 		    f->conf.ac_attr_timeout) {
 			struct stat stbuf;
+			unsigned int iflags = 0;
 			int err;
+
 			pthread_mutex_unlock(&f->lock);
-			err = fuse_fs_getattr(f->fs, path, &stbuf, fi);
+			err = getattr(f, path, &stbuf, &iflags, fi);
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
@@ -3634,6 +3723,7 @@ static int fill_dir_plus(void *dh_, const char *name, const struct stat *statp,
 		.ino = 0,
 	};
 	struct fuse *f = dh->fuse;
+	unsigned int iflags = 0;
 	int res;
 
 	if ((flags & ~FUSE_FILL_DIR_PLUS) != 0) {
@@ -3658,6 +3748,7 @@ static int fill_dir_plus(void *dh_, const char *name, const struct stat *statp,
 
 	if (off) {
 		size_t newlen;
+		size_t thislen;
 
 		if (dh->filled) {
 			dh->error = -EIO;
@@ -3673,7 +3764,8 @@ static int fill_dir_plus(void *dh_, const char *name, const struct stat *statp,
 
 		if (statp && (flags & FUSE_FILL_DIR_PLUS)) {
 			if (!is_dot_or_dotdot(name)) {
-				res = do_lookup(f, dh->nodeid, name, &e);
+				res = do_lookup(f, dh->nodeid, name, &e,
+						&iflags);
 				if (res) {
 					dh->error = res;
 					return 1;
@@ -3681,10 +3773,12 @@ static int fill_dir_plus(void *dh_, const char *name, const struct stat *statp,
 			}
 		}
 
-		newlen = dh->len +
-			fuse_add_direntry_plus(dh->req, dh->contents + dh->len,
-					       dh->needlen - dh->len, name,
-					       &e, off);
+		thislen = fuse_add_direntry_plus_iflags(dh->req,
+							dh->contents + dh->len,
+							dh->needlen - dh->len,
+							name, iflags, &e, off);
+		newlen = dh->len + thislen;
+
 		if (newlen > dh->needlen)
 			return 1;
 		dh->len = newlen;
@@ -3771,6 +3865,7 @@ static int readdir_fill_from_list(fuse_req_t req, struct fuse_dh *dh,
 		unsigned rem = dh->needlen - dh->len;
 		unsigned thislen;
 		unsigned newlen;
+		unsigned int iflags = 0;
 		pos++;
 
 		if (flags & FUSE_READDIR_PLUS) {
@@ -3782,15 +3877,17 @@ static int readdir_fill_from_list(fuse_req_t req, struct fuse_dh *dh,
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
-							 de->name, &e, pos);
+			thislen = fuse_add_direntry_plus_iflags(req, p, rem,
+								de->name,
+								iflags, &e,
+								pos);
 		} else {
 			thislen = fuse_add_direntry(req, p, rem,
 						    de->name, &de->stat, pos);


