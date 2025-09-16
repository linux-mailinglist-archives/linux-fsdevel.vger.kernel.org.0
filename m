Return-Path: <linux-fsdevel+bounces-61569-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC66B589F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5BF516E0C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A9A1A3172;
	Tue, 16 Sep 2025 00:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0PlQhEk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95131179A3
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 00:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757983448; cv=none; b=f6n0EHlbF7pi/lnhxNj+87sqNmwDPTJ50Wdi0QzliU/eSXaO+e9l0x9iXwdmbPnS/EflD8PlWEN+D3Nkc+VYI6jygF08tnkgPzbKzmXwwWe6MKcEuXofBOTdMdLQrFU+IX8Lh2gwvvrcUnCegBwYecIO095NDXUCJwgPneB93/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757983448; c=relaxed/simple;
	bh=+ISRXXk2rkdwWng1c3e4IR6c/K6vQ155HBtGFXBOGtE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZWOAm29cpepHzGvIAeor2hNuQQ9UTil1uFF1axkQdn8/p8keEwGc2yHkyScHfn3b24zAO5d1+EyjjNqNwZt8ueFsTPIRhW5cPJTKI6m7MPq33HeyQmXvh1IHmvXbHwDUkpb2kcCTD+q63dWU9n9kNRnTAgjMBxjZ/haXIQQ2EVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0PlQhEk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69A26C4CEF1;
	Tue, 16 Sep 2025 00:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757983448;
	bh=+ISRXXk2rkdwWng1c3e4IR6c/K6vQ155HBtGFXBOGtE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=S0PlQhEkl3k67t3TZXg9UQdiO9Slazu+vTUJ/5/Zo4b5guxUh6gzydhA78vtvg4wA
	 Egj7zCFcBF2cw2XTmjfDb3/2av9XKQ830BsS34tUh4M//ib/A/agJN0Pp9WcO5AFT6
	 ge34l8PyA5biVhSQp0KUIX/UqBC1a1fe1+WGjvzzUoHAJMdvSKCoJauIIG990oTRtH
	 cKUM9vIS0NHZUcRRiuN9JdX3dkZP5WzRgPF5AtHWCvWpYvevOYcQourZcqjfKDvj+2
	 FNqtemIjtTV8BFrNwSnZWe1vxXLYo0OtKiPMloDtCslC+qlxzxrAkXz92iUe/inaWQ
	 9uha+h2/Q1AJQ==
Date: Mon, 15 Sep 2025 17:44:08 -0700
Subject: [PATCH 09/18] libfuse: add a reply function to send FUSE_ATTR_* to
 the kernel
From: "Darrick J. Wong" <djwong@kernel.org>
To: bschubert@ddn.com, djwong@kernel.org
Cc: John@groves.net, neal@gompa.dev, bernd@bsbernd.com,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com
Message-ID: <175798154672.386924.5666782231835946678.stgit@frogsfrogsfrogs>
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
index c75428dae64e2f..faf0bc57bcdbe6 100644
--- a/include/fuse_common.h
+++ b/include/fuse_common.h
@@ -1221,6 +1221,9 @@ static inline bool fuse_iomap_need_write_allocate(unsigned int opflags,
 /* is pagecache writeback */
 #define FUSE_IOMAP_IOEND_WRITEBACK	(1U << 5)
 
+/* enable fsdax */
+#define FUSE_IFLAG_DAX			(1U << 0)
+
 /* ----------------------------------------------------------- *
  * Compatibility stuff					       *
  * ----------------------------------------------------------- */
diff --git a/include/fuse_lowlevel.h b/include/fuse_lowlevel.h
index ab274091f2248f..dfe28d33d8d0b8 100644
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
index e8b78622b8f850..bddc161412f33e 100644
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
index c42fae5d4a3c50..29a000fff16104 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -226,6 +226,10 @@ FUSE_3.99 {
 		fuse_lowlevel_iomap_device_remove;
 		fuse_fs_iomap_device_add;
 		fuse_fs_iomap_device_remove;
+		fuse_reply_attr_iflags;
+		fuse_reply_create_iflags;
+		fuse_reply_entry_iflags;
+		fuse_add_direntry_plus_iflags;
 } FUSE_3.18;
 
 # Local Variables:


