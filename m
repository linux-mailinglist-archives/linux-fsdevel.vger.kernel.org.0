Return-Path: <linux-fsdevel+bounces-66067-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E060CC17B93
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EA9734FF652
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7702D7DEB;
	Wed, 29 Oct 2025 01:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCH1rOLM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E3D1FAC42;
	Wed, 29 Oct 2025 01:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699715; cv=none; b=lmYbQDezRWvL9q5j0yApRcnqerWRC4kaI5RutJ5e2rj9lqXo8xzsO1j+wNGDcBQq4nH9gyx/2hKA+8wkh+j5JJO3JCRCUyzjvnzU0w557B8AOisTkwhacezMD+yhcHiB/Gdh7wce/6FASJLBFJHJZZnD2iHLtg7jJgA1l1oc90Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699715; c=relaxed/simple;
	bh=7Btbfm1gBYTTg2dgR+i4ec8kYqmn89MS/96ELu8SFsM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=onpHNuY+twEAtPtwAbviFTf9C//3UYcSg6ta3FPlxr1qwbO7kKh0aBDl4zmxiwlC3eQR6w3bC76tX9nM2JlUgczfFlRIbYpwUV0dVrvMqojtmCRaI6nOYqOmw93qK22gS8n9DxWQhXidDmMeNEwkvrXolgDTqfwXqGyYKS4d73o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCH1rOLM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F31BC4CEE7;
	Wed, 29 Oct 2025 01:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761699715;
	bh=7Btbfm1gBYTTg2dgR+i4ec8kYqmn89MS/96ELu8SFsM=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=GCH1rOLMRUmgYfHjveuqP/7fhbU8PNI5TwzulCLk4ghzQWuxc1IdYR6iFLY471f48
	 fp4CThORw4Ifq7QQ1xh4pu5mogi7CYh/J5J2wNUAFwv/2ywyfDvV9L8Lak2FD+lvvf
	 2JXodceZpF99gHGo+6JXvgU9jEvPB0C/CZwNmnVeVIWsMEyf67INHGbr+eiTV4dfgB
	 Lmz8wWHnxxrjwAB6O5T8wWbMNXTuBBS/19FPhT8yfMkDfP2L2AfHUO+QnRKsTEzL5i
	 9xouOYVSf42Cok5rhpKA7WMwzc9RbIiQewhUahEDFfp2bflT1Izh7VGmNj/5MwhB+r
	 5SE9q+hNNBCng==
Date: Tue, 28 Oct 2025 18:01:54 -0700
Subject: [PATCH 10/22] libfuse: connect high level fuse library to
 fuse_reply_attr_iflags
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, miklos@szeredi.hu, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <176169813714.1427432.12190518035075942171.stgit@frogsfrogsfrogs>
In-Reply-To: <176169813437.1427432.15345189583850708968.stgit@frogsfrogsfrogs>
References: <176169813437.1427432.15345189583850708968.stgit@frogsfrogsfrogs>
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
index 1d2f99074911c3..0870b56d6c10eb 100644
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
@@ -2879,6 +2948,7 @@ static void fuse_lib_setattr(fuse_req_t req, fuse_ino_t ino, struct stat *attr,
 	struct fuse *f = req_fuse_prepare(req);
 	struct stat buf;
 	char *path;
+	unsigned int iflags = 0;
 	int err;
 
 	memset(&buf, 0, sizeof(buf));
@@ -2937,19 +3007,23 @@ static void fuse_lib_setattr(fuse_req_t req, fuse_ino_t ino, struct stat *attr,
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
@@ -3000,6 +3074,7 @@ static void fuse_lib_mknod(fuse_req_t req, fuse_ino_t parent, const char *name,
 	struct fuse *f = req_fuse_prepare(req);
 	struct fuse_entry_param e;
 	char *path;
+	unsigned int iflags = 0;
 	int err;
 
 	err = get_path_name(f, parent, name, &path);
@@ -3016,7 +3091,7 @@ static void fuse_lib_mknod(fuse_req_t req, fuse_ino_t parent, const char *name,
 			err = fuse_fs_create(f->fs, path, mode, &fi);
 			if (!err) {
 				err = lookup_path(f, parent, name, path, &e,
-						  &fi);
+						  &iflags, &fi);
 				fuse_fs_release(f->fs, path, &fi);
 			}
 		}
@@ -3024,12 +3099,12 @@ static void fuse_lib_mknod(fuse_req_t req, fuse_ino_t parent, const char *name,
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
@@ -3038,6 +3113,7 @@ static void fuse_lib_mkdir(fuse_req_t req, fuse_ino_t parent, const char *name,
 	struct fuse *f = req_fuse_prepare(req);
 	struct fuse_entry_param e;
 	char *path;
+	unsigned int iflags = 0;
 	int err;
 
 	err = get_path_name(f, parent, name, &path);
@@ -3047,11 +3123,12 @@ static void fuse_lib_mkdir(fuse_req_t req, fuse_ino_t parent, const char *name,
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
@@ -3121,6 +3198,7 @@ static void fuse_lib_symlink(fuse_req_t req, const char *linkname,
 	struct fuse *f = req_fuse_prepare(req);
 	struct fuse_entry_param e;
 	char *path;
+	unsigned int iflags = 0;
 	int err;
 
 	err = get_path_name(f, parent, name, &path);
@@ -3130,11 +3208,12 @@ static void fuse_lib_symlink(fuse_req_t req, const char *linkname,
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
@@ -3182,6 +3261,7 @@ static void fuse_lib_link(fuse_req_t req, fuse_ino_t ino, fuse_ino_t newparent,
 	struct fuse_entry_param e;
 	char *oldpath;
 	char *newpath;
+	unsigned int iflags = 0;
 	int err;
 
 	err = get_path2(f, ino, NULL, newparent, newname,
@@ -3193,11 +3273,11 @@ static void fuse_lib_link(fuse_req_t req, fuse_ino_t ino, fuse_ino_t newparent,
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
@@ -3240,6 +3320,7 @@ static void fuse_lib_create(fuse_req_t req, fuse_ino_t parent,
 	struct fuse_intr_data d;
 	struct fuse_entry_param e;
 	char *path;
+	unsigned int iflags;
 	int err;
 
 	err = get_path_name(f, parent, name, &path);
@@ -3247,7 +3328,8 @@ static void fuse_lib_create(fuse_req_t req, fuse_ino_t parent,
 		fuse_prepare_interrupt(f, req, &d);
 		err = fuse_fs_create(f->fs, path, mode, fi);
 		if (!err) {
-			err = lookup_path(f, parent, name, path, &e, fi);
+			err = lookup_path(f, parent, name, path, &e,
+					  &iflags, fi);
 			if (err)
 				fuse_fs_release(f->fs, path, fi);
 			else if (!S_ISREG(e.attr.st_mode)) {
@@ -3267,10 +3349,14 @@ static void fuse_lib_create(fuse_req_t req, fuse_ino_t parent,
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
@@ -3304,13 +3390,16 @@ static void open_auto_cache(struct fuse *f, fuse_ino_t ino, const char *path,
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
@@ -3639,6 +3728,7 @@ static int fill_dir_plus(void *dh_, const char *name, const struct stat *statp,
 		.ino = 0,
 	};
 	struct fuse *f = dh->fuse;
+	unsigned int iflags = 0;
 	int res;
 
 	if ((flags & ~FUSE_FILL_DIR_PLUS) != 0) {
@@ -3663,6 +3753,7 @@ static int fill_dir_plus(void *dh_, const char *name, const struct stat *statp,
 
 	if (off) {
 		size_t newlen;
+		size_t thislen;
 
 		if (dh->filled) {
 			dh->error = -EIO;
@@ -3678,7 +3769,8 @@ static int fill_dir_plus(void *dh_, const char *name, const struct stat *statp,
 
 		if (statp && (flags & FUSE_FILL_DIR_PLUS)) {
 			if (!is_dot_or_dotdot(name)) {
-				res = do_lookup(f, dh->nodeid, name, &e);
+				res = do_lookup(f, dh->nodeid, name, &e,
+						&iflags);
 				if (res) {
 					dh->error = res;
 					return 1;
@@ -3686,10 +3778,12 @@ static int fill_dir_plus(void *dh_, const char *name, const struct stat *statp,
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
@@ -3776,6 +3870,7 @@ static int readdir_fill_from_list(fuse_req_t req, struct fuse_dh *dh,
 		unsigned rem = dh->needlen - dh->len;
 		unsigned thislen;
 		unsigned newlen;
+		unsigned int iflags = 0;
 		pos++;
 
 		if (flags & FUSE_READDIR_PLUS) {
@@ -3787,15 +3882,17 @@ static int readdir_fill_from_list(fuse_req_t req, struct fuse_dh *dh,
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


