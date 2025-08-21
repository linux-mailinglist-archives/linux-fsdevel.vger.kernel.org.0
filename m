Return-Path: <linux-fsdevel+bounces-58484-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AFAB2E9EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D583D1CC48AC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B271D5170;
	Thu, 21 Aug 2025 01:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rlBmMdtO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3132C3B29E
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 01:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755738223; cv=none; b=mGFuO64IkmNh8WmyKZ6G0XIbjXrnF4tHhsU6eZptn0BBrNSPNbUNH8ZXiFWAzFyB+WiOt4YhLCnhdPAR815HUvRsj7caXqXi9QpocSpa1OoYX5qOyE/ZhQZgq6hi/B2cDJ10hl/PH8vmoIaIkYAWvqALQdj5QgrV9GgAJvLX8tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755738223; c=relaxed/simple;
	bh=qUKi8ISykKWrzWTT/aljV0nOjQs25Ii8DYdG470hEbg=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JLflh6qO8qBhXd/AO4FzNSru1sNQBBYp1gD2eg+JrVO97U/eiWpVeC7vNlJfwrqrp+alFlcHUM+BBWub60XlO30zhOHrzm6GQokjpDPonwtguu3Jnmo+/SCJIyWCoihNO7jKo3Z7bSsAgNWwZC8ErxpRBzc0KZojaXv7LZ5ZBLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rlBmMdtO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CA30C4CEE7;
	Thu, 21 Aug 2025 01:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755738223;
	bh=qUKi8ISykKWrzWTT/aljV0nOjQs25Ii8DYdG470hEbg=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=rlBmMdtO5QsybCWEdEce/361rInidvwueW7hBIjbanIuO9RUr8XQb7NOlPeyIHteF
	 MVxj3bmUIVr7rAHXCcU1YLlt6cxREH4rYdilMH/UKTGp9DiQIKBo/bFZTGXfnDERGf
	 GzBS8TAK4BOGeatY6EffJAzGQShWP4bU/CsxBAJMHhYk5w1tmWdDSwQPuQTdK4s144
	 frx43sc7sbNaOYJ9qdxsYIIgjoJ5Hy0ktAUSDXiuFg5yoZppVphf5ptSQdL0FppTu5
	 /EEUybQ38na/pyzCdV/ddfYwDBUOgfy7EvtUnb/jy4Jdp+HBWdISAbfcMgGcZguR2c
	 qOHc77UzGduVw==
Date: Wed, 20 Aug 2025 18:03:42 -0700
Subject: [PATCH 09/21] libfuse: add a reply function to send FUSE_ATTR_* to
 the kernel
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: John@groves.net, joannelkoong@gmail.com, bernd@bsbernd.com,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, neal@gompa.dev
Message-ID: <175573711452.19163.441700978192485798.stgit@frogsfrogsfrogs>
In-Reply-To: <175573711192.19163.9486664721161324503.stgit@frogsfrogsfrogs>
References: <175573711192.19163.9486664721161324503.stgit@frogsfrogsfrogs>
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
 include/fuse_lowlevel.h |   83 +++++++++++++++++++++++++++++++++++++++++++++++
 lib/fuse_lowlevel.c     |   64 ++++++++++++++++++++++++++++--------
 lib/fuse_versionscript  |    4 ++
 4 files changed, 139 insertions(+), 15 deletions(-)


diff --git a/include/fuse_common.h b/include/fuse_common.h
index 77e971c3fed17d..9181ec6cb5e5e9 100644
--- a/include/fuse_common.h
+++ b/include/fuse_common.h
@@ -1226,6 +1226,9 @@ static inline bool fuse_iomap_need_write_allocate(unsigned int opflags,
 /* is append ioend */
 #define FUSE_IOMAP_IOEND_APPEND		(1U << 4)
 
+/* enable fsdax */
+#define FUSE_IFLAG_DAX			(1U << 0)
+
 /* ----------------------------------------------------------- *
  * Compatibility stuff					       *
  * ----------------------------------------------------------- */
diff --git a/include/fuse_lowlevel.h b/include/fuse_lowlevel.h
index 7f7f418b281601..e0642032127686 100644
--- a/include/fuse_lowlevel.h
+++ b/include/fuse_lowlevel.h
@@ -243,6 +243,7 @@ struct fuse_lowlevel_ops {
 	 *
 	 * Valid replies:
 	 *   fuse_reply_entry
+	 *   fuse_reply_entry_iflags
 	 *   fuse_reply_err
 	 *
 	 * @param req request handle
@@ -302,6 +303,7 @@ struct fuse_lowlevel_ops {
 	 *
 	 * Valid replies:
 	 *   fuse_reply_attr
+	 *   fuse_reply_attr_iflags
 	 *   fuse_reply_err
 	 *
 	 * @param req request handle
@@ -337,6 +339,7 @@ struct fuse_lowlevel_ops {
 	 *
 	 * Valid replies:
 	 *   fuse_reply_attr
+	 *   fuse_reply_attr_iflags
 	 *   fuse_reply_err
 	 *
 	 * @param req request handle
@@ -368,6 +371,7 @@ struct fuse_lowlevel_ops {
 	 *
 	 * Valid replies:
 	 *   fuse_reply_entry
+	 *   fuse_reply_entry_iflags
 	 *   fuse_reply_err
 	 *
 	 * @param req request handle
@@ -384,6 +388,7 @@ struct fuse_lowlevel_ops {
 	 *
 	 * Valid replies:
 	 *   fuse_reply_entry
+	 *   fuse_reply_entry_iflags
 	 *   fuse_reply_err
 	 *
 	 * @param req request handle
@@ -433,6 +438,7 @@ struct fuse_lowlevel_ops {
 	 *
 	 * Valid replies:
 	 *   fuse_reply_entry
+	 *   fuse_reply_entry_iflags
 	 *   fuse_reply_err
 	 *
 	 * @param req request handle
@@ -481,6 +487,7 @@ struct fuse_lowlevel_ops {
 	 *
 	 * Valid replies:
 	 *   fuse_reply_entry
+	 *   fuse_reply_entry_iflags
 	 *   fuse_reply_err
 	 *
 	 * @param req request handle
@@ -972,6 +979,7 @@ struct fuse_lowlevel_ops {
 	 *
 	 * Valid replies:
 	 *   fuse_reply_create
+	 *   fuse_reply_create_iflags
 	 *   fuse_reply_err
 	 *
 	 * @param req request handle
@@ -1317,6 +1325,7 @@ struct fuse_lowlevel_ops {
 	 *
 	 * Valid replies:
 	 *   fuse_reply_create
+	 *   fuse_reply_create_iflags
 	 *   fuse_reply_err
 	 *
 	 * @param req request handle
@@ -1451,6 +1460,23 @@ void fuse_reply_none(fuse_req_t req);
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
@@ -1472,6 +1498,29 @@ int fuse_reply_entry(fuse_req_t req, const struct fuse_entry_param *e);
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
@@ -1486,6 +1535,21 @@ int fuse_reply_create(fuse_req_t req, const struct fuse_entry_param *e,
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
@@ -1713,6 +1777,25 @@ size_t fuse_add_direntry_plus(fuse_req_t req, char *buf, size_t bufsize,
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
index ce7971a23be94b..04bc858f54d01f 100644
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
@@ -529,14 +551,20 @@ int fuse_reply_create(fuse_req_t req, const struct fuse_entry_param *e,
 	struct fuse_open_out *oarg = (struct fuse_open_out *) (buf + entrysize);
 
 	memset(buf, 0, sizeof(buf));
-	fill_entry(earg, e);
+	fill_entry(earg, e, iflags);
 	fill_open(oarg, f);
 	return send_reply_ok(req, buf,
 			     entrysize + sizeof(struct fuse_open_out));
 }
 
-int fuse_reply_attr(fuse_req_t req, const struct stat *attr,
-		    double attr_timeout)
+int fuse_reply_create(fuse_req_t req, const struct fuse_entry_param *e,
+		      const struct fuse_file_info *f)
+{
+	return fuse_reply_create_iflags(req, e, 0, f);
+}
+
+int fuse_reply_attr_iflags(fuse_req_t req, const struct stat *attr,
+			   unsigned int iflags, double attr_timeout)
 {
 	struct fuse_attr_out arg;
 	size_t size = req->se->conn.proto_minor < 9 ?
@@ -545,11 +573,17 @@ int fuse_reply_attr(fuse_req_t req, const struct stat *attr,
 	memset(&arg, 0, sizeof(arg));
 	arg.attr_valid = calc_timeout_sec(attr_timeout);
 	arg.attr_valid_nsec = calc_timeout_nsec(attr_timeout);
-	convert_stat(attr, &arg.attr);
+	convert_stat(attr, &arg.attr, iflags);
 
 	return send_reply_ok(req, &arg, size);
 }
 
+int fuse_reply_attr(fuse_req_t req, const struct stat *attr,
+		    double attr_timeout)
+{
+	return fuse_reply_attr_iflags(req, attr, 0, attr_timeout);
+}
+
 int fuse_reply_readlink(fuse_req_t req, const char *linkname)
 {
 	return send_reply_ok(req, linkname, strlen(linkname));
diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
index 03cce1f0f184c3..df78723e0f2518 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -225,6 +225,10 @@ FUSE_3.99 {
 		fuse_lowlevel_iomap_device_remove;
 		fuse_fs_iomap_device_add;
 		fuse_fs_iomap_device_remove;
+		fuse_reply_attr_iflags;
+		fuse_reply_create_iflags;
+		fuse_reply_entry_iflags;
+		fuse_add_direntry_plus_iflags;
 } FUSE_3.18;
 
 # Local Variables:


