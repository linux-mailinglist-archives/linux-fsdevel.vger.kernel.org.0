Return-Path: <linux-fsdevel+bounces-55352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEEF3B09826
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CD2D3ABDCC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF99D23FC4C;
	Thu, 17 Jul 2025 23:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9eSzv/z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8BF1FCFF8
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 23:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795375; cv=none; b=DZ62SYt7YDlIa7MQEsVfxxZ6ZWFvi27zRbowgR+2C+8L8IHjTjc215WNFEwv6xxnuQL8QhbM+seAjTXGTalCD6ujhjJbmQvx2y0OjGNgTAvlIyiG9jVV6QVyFuFz2+kogsmBnoZckDivBFf23qfrHdawaLRkjPzedHFUwBn7zdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795375; c=relaxed/simple;
	bh=4TgzNHp6JDqqK06JadT/Keykoz9+pCKxfmPSKkaDrzY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tfYM5d6diwJPzzbSDZQAoSTZDEype/cbA1CR+tvnTwHOp34fM9jLAXFGy191B5Cj9jY8RbySahLymDJYwvAK5vitpOpA/VMgD9ynvaiTY5ump+ZLcR9cjZpg8A7VXt6anf6L/iJnpYUGFqxWTG+wDKi25ljDKjUxo8IdTqM2fHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9eSzv/z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9835C4CEE3;
	Thu, 17 Jul 2025 23:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795374;
	bh=4TgzNHp6JDqqK06JadT/Keykoz9+pCKxfmPSKkaDrzY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=C9eSzv/zLAvkbAhxLNSuIykFgP3+7+6VRPNCI04DGUogzapXeYZzyjpkglhE/peRD
	 etw/ZqUGqHBsqglaw5ngzM0qqBpo+vLQlkiqOufCkR04efJvB+D6loDH61LWU4LASr
	 T/h5yKcbVNaMFlSiOdw+9oVTA51IJZD+HoK1cgQepkqKHxFwPydJAs6ig9Ufkz8u1t
	 hhd/9QwVDKRKpWhaiod63djvupPM4Yf3CxUpqRzI404b9Evdt8u/bBqOo9vdVzz/7a
	 1dhEVWrwyIm7Wa+cDJKnHlKcg8B7frgbPqNW3wZmA/kpYM0ms/4aQoMCZrmxYeZUc+
	 +ipW6Ok7fcVnA==
Date: Thu, 17 Jul 2025 16:36:14 -0700
Subject: [PATCH 07/14] libfuse: add a reply function to send FUSE_ATTR_* to
 the kernel
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: John@groves.net, joannelkoong@gmail.com, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, neal@gompa.dev, miklos@szeredi.hu
Message-ID: <175279459857.714161.8213814053864249949.stgit@frogsfrogsfrogs>
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

Create new fuse_reply_{attr,create,entry}_iflags functions so that we
can send FUSE_ATTR_* flags to the kernel when instantiating an inode.
Servers are expected to send FUSE_IFLAG_* values, which will be
translated into what the kernel can understand.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_common.h   |    3 ++
 include/fuse_lowlevel.h |   87 +++++++++++++++++++++++++++++++++++++++++++++--
 lib/fuse_lowlevel.c     |   69 ++++++++++++++++++++++++++++++-------
 lib/fuse_versionscript  |    4 ++
 4 files changed, 146 insertions(+), 17 deletions(-)


diff --git a/include/fuse_common.h b/include/fuse_common.h
index 66c25afe15ec76..11eb22d011896c 100644
--- a/include/fuse_common.h
+++ b/include/fuse_common.h
@@ -1210,6 +1210,9 @@ struct fuse_iomap {
 /* is append ioend */
 #define FUSE_IOMAP_IOEND_APPEND		(1U << 15)
 
+/* enable fsdax */
+#define FUSE_IFLAG_DAX			(1U << 0)
+
 #endif /* FUSE_USE_VERSION >= 318 */
 
 /* ----------------------------------------------------------- *
diff --git a/include/fuse_lowlevel.h b/include/fuse_lowlevel.h
index 1b856431de0a60..07748abcf079cf 100644
--- a/include/fuse_lowlevel.h
+++ b/include/fuse_lowlevel.h
@@ -240,6 +240,7 @@ struct fuse_lowlevel_ops {
 	 *
 	 * Valid replies:
 	 *   fuse_reply_entry
+	 *   fuse_reply_entry_iflags
 	 *   fuse_reply_err
 	 *
 	 * @param req request handle
@@ -299,6 +300,7 @@ struct fuse_lowlevel_ops {
 	 *
 	 * Valid replies:
 	 *   fuse_reply_attr
+	 *   fuse_reply_attr_iflags
 	 *   fuse_reply_err
 	 *
 	 * @param req request handle
@@ -334,6 +336,7 @@ struct fuse_lowlevel_ops {
 	 *
 	 * Valid replies:
 	 *   fuse_reply_attr
+	 *   fuse_reply_attr_iflags
 	 *   fuse_reply_err
 	 *
 	 * @param req request handle
@@ -364,7 +367,7 @@ struct fuse_lowlevel_ops {
 	 * socket node.
 	 *
 	 * Valid replies:
-	 *   fuse_reply_entry
+	 *   fuse_reply_entry_iflags
 	 *   fuse_reply_err
 	 *
 	 * @param req request handle
@@ -380,7 +383,7 @@ struct fuse_lowlevel_ops {
 	 * Create a directory
 	 *
 	 * Valid replies:
-	 *   fuse_reply_entry
+	 *   fuse_reply_entry_iflags
 	 *   fuse_reply_err
 	 *
 	 * @param req request handle
@@ -429,7 +432,7 @@ struct fuse_lowlevel_ops {
 	 * Create a symbolic link
 	 *
 	 * Valid replies:
-	 *   fuse_reply_entry
+	 *   fuse_reply_entry_iflags
 	 *   fuse_reply_err
 	 *
 	 * @param req request handle
@@ -477,7 +480,7 @@ struct fuse_lowlevel_ops {
 	 * Create a hard link
 	 *
 	 * Valid replies:
-	 *   fuse_reply_entry
+	 *   fuse_reply_entry_iflags
 	 *   fuse_reply_err
 	 *
 	 * @param req request handle
@@ -969,6 +972,7 @@ struct fuse_lowlevel_ops {
 	 *
 	 * Valid replies:
 	 *   fuse_reply_create
+	 *   fuse_reply_create_iflags
 	 *   fuse_reply_err
 	 *
 	 * @param req request handle
@@ -1315,6 +1319,7 @@ struct fuse_lowlevel_ops {
 	 *
 	 * Valid replies:
 	 *   fuse_reply_create
+	 *   fuse_reply_create_iflags
 	 *   fuse_reply_err
 	 *
 	 * @param req request handle
@@ -1435,6 +1440,23 @@ void fuse_reply_none(fuse_req_t req);
  */
 int fuse_reply_entry(fuse_req_t req, const struct fuse_entry_param *e);
 
+/**
+ * Reply with a directory entry and FUSE_IFLAG_*
+ *
+ * Possible requests:
+ *   lookup, mknod, mkdir, symlink, link
+ *
+ * Side effects:
+ *   increments the lookup count on success
+ *
+ * @param req request handle
+ * @param e the entry parameters
+ * @param iflags	FUSE_IFLAG_*
+ * @return zero for success, -errno for failure to send reply
+ */
+int fuse_reply_entry_iflags(fuse_req_t req, const struct fuse_entry_param *e,
+			    unsigned int iflags);
+
 /**
  * Reply with a directory entry and open parameters
  *
@@ -1456,6 +1478,29 @@ int fuse_reply_entry(fuse_req_t req, const struct fuse_entry_param *e);
 int fuse_reply_create(fuse_req_t req, const struct fuse_entry_param *e,
 		      const struct fuse_file_info *fi);
 
+/**
+ * Reply with a directory entry, open parameters and FUSE_IFLAG_*
+ *
+ * currently the following members of 'fi' are used:
+ *   fh, direct_io, keep_cache, cache_readdir, nonseekable, noflush,
+ *   parallel_direct_writes
+ *
+ * Possible requests:
+ *   create
+ *
+ * Side effects:
+ *   increments the lookup count on success
+ *
+ * @param req request handle
+ * @param e the entry parameters
+ * @param iflags	FUSE_IFLAG_*
+ * @param fi file information
+ * @return zero for success, -errno for failure to send reply
+ */
+int fuse_reply_create_iflags(fuse_req_t req, const struct fuse_entry_param *e,
+			     unsigned int iflags,
+			     const struct fuse_file_info *fi);
+
 /**
  * Reply with attributes
  *
@@ -1470,6 +1515,21 @@ int fuse_reply_create(fuse_req_t req, const struct fuse_entry_param *e,
 int fuse_reply_attr(fuse_req_t req, const struct stat *attr,
 		    double attr_timeout);
 
+/**
+ * Reply with attributes and FUSE_IFLAG_* flags
+ *
+ * Possible requests:
+ *   getattr, setattr
+ *
+ * @param req request handle
+ * @param attr the attributes
+ * @param attr_timeout	validity timeout (in seconds) for the attributes
+ * @param iflags	set of FUSE_IFLAG_* flags
+ * @return zero for success, -errno for failure to send reply
+ */
+int fuse_reply_attr_iflags(fuse_req_t req, const struct stat *attr,
+			   unsigned int iflags, double attr_timeout);
+
 /**
  * Reply with the contents of a symbolic link
  *
@@ -1697,6 +1757,25 @@ size_t fuse_add_direntry_plus(fuse_req_t req, char *buf, size_t bufsize,
 			      const char *name,
 			      const struct fuse_entry_param *e, off_t off);
 
+/**
+ * Add a directory entry and FUSE_IFLAG_* to the buffer with the attributes
+ *
+ * See documentation of `fuse_add_direntry_plus()` for more details.
+ *
+ * @param req request handle
+ * @param buf the point where the new entry will be added to the buffer
+ * @param bufsize remaining size of the buffer
+ * @param name the name of the entry
+ * @param iflags	FUSE_IFLAG_*
+ * @param e the directory entry
+ * @param off the offset of the next entry
+ * @return the space needed for the entry
+ */
+size_t fuse_add_direntry_plus_iflags(fuse_req_t req, char *buf, size_t bufsize,
+				     const char *name, unsigned int iflags,
+				     const struct fuse_entry_param *e,
+				     off_t off);
+
 /**
  * Reply to ask for data fetch and output buffer preparation.  ioctl
  * will be retried with the specified input data fetched and output
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index d26043fa54c036..568db13502a7d7 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -102,7 +102,8 @@ static void trace_request_reply(uint64_t unique, unsigned int len,
 }
 #endif
 
-static void convert_stat(const struct stat *stbuf, struct fuse_attr *attr)
+static void convert_stat(const struct stat *stbuf, struct fuse_attr *attr,
+			 unsigned int iflags)
 {
 	attr->ino	= stbuf->st_ino;
 	attr->mode	= stbuf->st_mode;
@@ -119,6 +120,10 @@ static void convert_stat(const struct stat *stbuf, struct fuse_attr *attr)
 	attr->atimensec = ST_ATIM_NSEC(stbuf);
 	attr->mtimensec = ST_MTIM_NSEC(stbuf);
 	attr->ctimensec = ST_CTIM_NSEC(stbuf);
+
+	attr->flags	= 0;
+	if (iflags & FUSE_IFLAG_DAX)
+		attr->flags |= FUSE_ATTR_DAX;
 }
 
 static void convert_attr(const struct fuse_setattr_in *attr, struct stat *stbuf)
@@ -438,7 +443,8 @@ static unsigned int calc_timeout_nsec(double t)
 }
 
 static void fill_entry(struct fuse_entry_out *arg,
-		       const struct fuse_entry_param *e)
+		       const struct fuse_entry_param *e,
+		       unsigned int iflags)
 {
 	arg->nodeid = e->ino;
 	arg->generation = e->generation;
@@ -446,14 +452,15 @@ static void fill_entry(struct fuse_entry_out *arg,
 	arg->entry_valid_nsec = calc_timeout_nsec(e->entry_timeout);
 	arg->attr_valid = calc_timeout_sec(e->attr_timeout);
 	arg->attr_valid_nsec = calc_timeout_nsec(e->attr_timeout);
-	convert_stat(&e->attr, &arg->attr);
+	convert_stat(&e->attr, &arg->attr, iflags);
 }
 
 /* `buf` is allowed to be empty so that the proper size may be
    allocated by the caller */
-size_t fuse_add_direntry_plus(fuse_req_t req, char *buf, size_t bufsize,
-			      const char *name,
-			      const struct fuse_entry_param *e, off_t off)
+size_t fuse_add_direntry_plus_iflags(fuse_req_t req, char *buf, size_t bufsize,
+				     const char *name, unsigned int iflags,
+				     const struct fuse_entry_param *e,
+				     off_t off)
 {
 	(void)req;
 	size_t namelen;
@@ -468,7 +475,7 @@ size_t fuse_add_direntry_plus(fuse_req_t req, char *buf, size_t bufsize,
 
 	struct fuse_direntplus *dp = (struct fuse_direntplus *) buf;
 	memset(&dp->entry_out, 0, sizeof(dp->entry_out));
-	fill_entry(&dp->entry_out, e);
+	fill_entry(&dp->entry_out, e, iflags);
 
 	struct fuse_dirent *dirent = &dp->dirent;
 	dirent->ino = e->attr.st_ino;
@@ -481,6 +488,14 @@ size_t fuse_add_direntry_plus(fuse_req_t req, char *buf, size_t bufsize,
 	return entlen_padded;
 }
 
+size_t fuse_add_direntry_plus(fuse_req_t req, char *buf, size_t bufsize,
+			      const char *name,
+			      const struct fuse_entry_param *e, off_t off)
+{
+	return fuse_add_direntry_plus_iflags(req, buf, bufsize, name, 0, e,
+					     off);
+}
+
 static void fill_open(struct fuse_open_out *arg,
 		      const struct fuse_file_info *f)
 {
@@ -503,7 +518,8 @@ static void fill_open(struct fuse_open_out *arg,
 		arg->open_flags |= FOPEN_PARALLEL_DIRECT_WRITES;
 }
 
-int fuse_reply_entry(fuse_req_t req, const struct fuse_entry_param *e)
+int fuse_reply_entry_iflags(fuse_req_t req, const struct fuse_entry_param *e,
+			    unsigned int iflags)
 {
 	struct fuse_entry_out arg;
 	size_t size = req->se->conn.proto_minor < 9 ?
@@ -515,12 +531,18 @@ int fuse_reply_entry(fuse_req_t req, const struct fuse_entry_param *e)
 		return fuse_reply_err(req, ENOENT);
 
 	memset(&arg, 0, sizeof(arg));
-	fill_entry(&arg, e);
+	fill_entry(&arg, e, iflags);
 	return send_reply_ok(req, &arg, size);
 }
 
-int fuse_reply_create(fuse_req_t req, const struct fuse_entry_param *e,
-		      const struct fuse_file_info *f)
+int fuse_reply_entry(fuse_req_t req, const struct fuse_entry_param *e)
+{
+	return fuse_reply_entry_iflags(req, e, 0);
+}
+
+int fuse_reply_create_iflags(fuse_req_t req, const struct fuse_entry_param *e,
+			     unsigned int iflags,
+			     const struct fuse_file_info *f)
 {
 	alignas(uint64_t) char buf[sizeof(struct fuse_entry_out) + sizeof(struct fuse_open_out)];
 	size_t entrysize = req->se->conn.proto_minor < 9 ?
@@ -529,12 +551,18 @@ int fuse_reply_create(fuse_req_t req, const struct fuse_entry_param *e,
 	struct fuse_open_out *oarg = (struct fuse_open_out *) (buf + entrysize);
 
 	memset(buf, 0, sizeof(buf));
-	fill_entry(earg, e);
+	fill_entry(earg, e, iflags);
 	fill_open(oarg, f);
 	return send_reply_ok(req, buf,
 			     entrysize + sizeof(struct fuse_open_out));
 }
 
+int fuse_reply_create(fuse_req_t req, const struct fuse_entry_param *e,
+		      const struct fuse_file_info *f)
+{
+	return fuse_reply_create_iflags(req, e, 0, f);
+}
+
 int fuse_reply_attr(fuse_req_t req, const struct stat *attr,
 		    double attr_timeout)
 {
@@ -545,7 +573,22 @@ int fuse_reply_attr(fuse_req_t req, const struct stat *attr,
 	memset(&arg, 0, sizeof(arg));
 	arg.attr_valid = calc_timeout_sec(attr_timeout);
 	arg.attr_valid_nsec = calc_timeout_nsec(attr_timeout);
-	convert_stat(attr, &arg.attr);
+	convert_stat(attr, &arg.attr, 0);
+
+	return send_reply_ok(req, &arg, size);
+}
+
+int fuse_reply_attr_iflags(fuse_req_t req, const struct stat *attr,
+			   unsigned int iflags, double attr_timeout)
+{
+	struct fuse_attr_out arg;
+	size_t size = req->se->conn.proto_minor < 9 ?
+		FUSE_COMPAT_ATTR_OUT_SIZE : sizeof(arg);
+
+	memset(&arg, 0, sizeof(arg));
+	arg.attr_valid = calc_timeout_sec(attr_timeout);
+	arg.attr_valid_nsec = calc_timeout_nsec(attr_timeout);
+	convert_stat(attr, &arg.attr, iflags);
 
 	return send_reply_ok(req, &arg, size);
 }
diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
index 4cdae6a6a42051..9207145624ba83 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -215,6 +215,10 @@ FUSE_3.18 {
 
 		fuse_reply_iomap_begin;
 		fuse_iomap_add_device;
+		fuse_reply_attr_iflags;
+		fuse_reply_create_iflags;
+		fuse_reply_entry_iflags;
+		fuse_add_direntry_plus_iflags;
 } FUSE_3.17;
 
 # Local Variables:


