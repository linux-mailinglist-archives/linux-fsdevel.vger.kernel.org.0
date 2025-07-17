Return-Path: <linux-fsdevel+bounces-55348-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B29A8B0981F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 242D118866EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A63523FC4C;
	Thu, 17 Jul 2025 23:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ogms7VC/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB6B1FCFF8
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 23:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795312; cv=none; b=ASn9exeKZjNA5jQz8zXUuz1sOEjpzbNfMpqHrl8DUmX1cuk4fpM/a6//49bZp4Nru/zNRYetAXDffI8OXL7Jtl6tyqakPt1CxLt9NqsH8BVzSV6kutEDMYR90Oju78AJfDRJJg4dCUILBJNbWBAHSsFtCKDx07qHzVUxvh288qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795312; c=relaxed/simple;
	bh=zbjq8r5zb1TuvWywWaDREyjMaJxGyQl2O1ZhPvS6RfM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eePvv9P/H3wjxwWZhwvXeUfn4NZjoXpVsySItzNpCw4T8J0O6NYCvIswLeE3UnToGQSHI/8o0D1tV80OfUNjBMMZMErxQwFEMt3A+gLEeyUUcbV7Sw/2GM4Mm9H/AU5vRFR4CFe8K0Bo8jdPpbsbOGgy28rM5RaIMMeYtdSn4iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ogms7VC/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5014AC4CEE3;
	Thu, 17 Jul 2025 23:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795312;
	bh=zbjq8r5zb1TuvWywWaDREyjMaJxGyQl2O1ZhPvS6RfM=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ogms7VC/E8+iN8k8dweSKV+LEmksyU+DY5zWfrDJ9qtiPRNfjqllGAMcgmj2sMYe9
	 WSUDsYH2WByW2JdmuF6L/G9CrpboUK2xZSIWth64OYi5cQK0J9ZJ552yhDDkLe+K+8
	 dmag7WXPBXMg8jBQd/1lv+zLG8uyDJN9VAdDZ4Um65fHJlBA+rxUMyXqtYt9XuBh8u
	 Hp7qN7UY99lI3SgMhN10WHU9fg6yqdIT26hulT2vrDiHYYBtYNv0UtBWTF456PKNoD
	 yipEI7RBJP/0eMQhA733TU0b36c33N6oiFR+AoRg9pm2L4COnrVQYm9lADGaTpWlBm
	 735f9CzpqzAsA==
Date: Thu, 17 Jul 2025 16:35:11 -0700
Subject: [PATCH 03/14] libfuse: add upper level iomap commands
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: John@groves.net, joannelkoong@gmail.com, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, neal@gompa.dev, miklos@szeredi.hu
Message-ID: <175279459785.714161.3415420497027705389.stgit@frogsfrogsfrogs>
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

Teach the upper level fuse library about the iomap begin and end
operations, and connect it to the lower level.  This is needed for
fuse2fs to start using iomap.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse.h |   19 ++++++++++
 lib/fuse.c     |  107 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 126 insertions(+)


diff --git a/include/fuse.h b/include/fuse.h
index b99004334c99f3..6b25586e768285 100644
--- a/include/fuse.h
+++ b/include/fuse.h
@@ -850,6 +850,25 @@ struct fuse_operations {
 	 * Find next data or hole after the specified offset
 	 */
 	off_t (*lseek) (const char *, off_t off, int whence, struct fuse_file_info *);
+
+#if FUSE_USE_VERSION >= FUSE_MAKE_VERSION(3, 18)
+	/**
+	 * Send a mapping to the kernel so that a file IO operation can run.
+	 */
+	int (*iomap_begin) (const char *path, uint64_t nodeid,
+			    uint64_t attr_ino, off_t pos_in,
+			    uint64_t length_in, uint32_t opflags_in,
+			    struct fuse_iomap *read_iomap_out,
+			    struct fuse_iomap *write_iomap_out);
+
+	/**
+	 * Respond to the outcome of a previous file mapping operation.
+	 */
+	int (*iomap_end) (const char *path, uint64_t nodeid, uint64_t attr_ino,
+			  off_t pos_in, uint64_t length_in,
+			  uint32_t opflags_in, ssize_t written_in,
+			  const struct fuse_iomap *iomap_in);
+#endif /* FUSE_USE_VERSION >= 318 */
 };
 
 /** Extra context that may be needed by some filesystems
diff --git a/lib/fuse.c b/lib/fuse.c
index 68b61ce6953d6f..aa4287e0896761 100644
--- a/lib/fuse.c
+++ b/lib/fuse.c
@@ -2737,6 +2737,45 @@ int fuse_fs_chmod(struct fuse_fs *fs, const char *path, mode_t mode,
 	return fs->op.chmod(path, mode, fi);
 }
 
+static int fuse_fs_iomap_begin(struct fuse_fs *fs, const char *path,
+			       fuse_ino_t nodeid, uint64_t attr_ino, off_t pos,
+			       uint64_t count, uint32_t opflags,
+			       struct fuse_iomap *read_iomap,
+			       struct fuse_iomap *write_iomap)
+{
+	fuse_get_context()->private_data = fs->user_data;
+	if (!fs->op.iomap_begin)
+		return -ENOSYS;
+
+	if (fs->debug) {
+		fuse_log(FUSE_LOG_DEBUG,
+			 "iomap_begin[%s] nodeid %llu attr_ino %llu pos %llu count %llu opflags 0x%x\n",
+			 path, nodeid, attr_ino, pos, count, opflags);
+	}
+
+	return fs->op.iomap_begin(path, nodeid, attr_ino, pos, count, opflags,
+				  read_iomap, write_iomap);
+}
+
+static int fuse_fs_iomap_end(struct fuse_fs *fs, const char *path,
+			     fuse_ino_t nodeid, uint64_t attr_ino, off_t pos,
+			     uint64_t count, uint32_t opflags, ssize_t written,
+			     const struct fuse_iomap *iomap)
+{
+	fuse_get_context()->private_data = fs->user_data;
+	if (!fs->op.iomap_end)
+		return 0;
+
+	if (fs->debug) {
+		fuse_log(FUSE_LOG_DEBUG,
+			 "iomap_end[%s] nodeid %llu attr_ino %llu pos %llu count %llu opflags 0x%x written %zd\n",
+			 path, nodeid, attr_ino, pos, count, opflags, written);
+	}
+
+	return fs->op.iomap_end(path, nodeid, attr_ino, pos, count, opflags,
+				written, iomap);
+}
+
 static void fuse_lib_setattr(fuse_req_t req, fuse_ino_t ino, struct stat *attr,
 			     int valid, struct fuse_file_info *fi)
 {
@@ -4361,6 +4400,72 @@ static void fuse_lib_lseek(fuse_req_t req, fuse_ino_t ino, off_t off, int whence
 		reply_err(req, res);
 }
 
+static void fuse_lib_iomap_begin(fuse_req_t req, fuse_ino_t nodeid,
+				 uint64_t attr_ino, off_t pos, uint64_t count,
+				 uint32_t opflags)
+{
+	struct fuse *f = req_fuse_prepare(req);
+	struct fuse_iomap read_iomap = {
+		.offset = pos,
+		.length = count,
+		.type = FUSE_IOMAP_TYPE_HOLE,
+		.dev  = FUSE_IOMAP_DEV_NULL,
+		.addr = FUSE_IOMAP_NULL_ADDR,
+	};
+	struct fuse_iomap write_iomap = {
+		.offset = pos,
+		.length = count,
+		.type = FUSE_IOMAP_TYPE_PURE_OVERWRITE,
+		.dev  = FUSE_IOMAP_DEV_NULL,
+		.addr = FUSE_IOMAP_NULL_ADDR,
+	};
+	struct fuse_intr_data d;
+	char *path;
+	int err;
+
+	err = get_path_nullok(f, nodeid, &path);
+	if (err) {
+		reply_err(req, err);
+		return;
+	}
+
+	fuse_prepare_interrupt(f, req, &d);
+	err = fuse_fs_iomap_begin(f->fs, path, nodeid, attr_ino, pos, count,
+				  opflags, &read_iomap, &write_iomap);
+	fuse_finish_interrupt(f, req, &d);
+	free_path(f, nodeid, path);
+	if (err) {
+		reply_err(req, err);
+		return;
+	}
+
+	fuse_reply_iomap_begin(req, &read_iomap, &write_iomap);
+}
+
+static void fuse_lib_iomap_end(fuse_req_t req, fuse_ino_t nodeid,
+			       uint64_t attr_ino, off_t pos, uint64_t count,
+			       uint32_t opflags, ssize_t written,
+			       const struct fuse_iomap *iomap)
+{
+	struct fuse *f = req_fuse_prepare(req);
+	struct fuse_intr_data d;
+	char *path;
+	int err;
+
+	err = get_path_nullok(f, nodeid, &path);
+	if (err) {
+		reply_err(req, err);
+		return;
+	}
+
+	fuse_prepare_interrupt(f, req, &d);
+	err = fuse_fs_iomap_end(f->fs, path, nodeid, attr_ino, pos, count,
+				opflags, written, iomap);
+	fuse_finish_interrupt(f, req, &d);
+	free_path(f, nodeid, path);
+	reply_err(req, err);
+}
+
 static int clean_delay(struct fuse *f)
 {
 	/*
@@ -4459,6 +4564,8 @@ static struct fuse_lowlevel_ops fuse_path_ops = {
 	.fallocate = fuse_lib_fallocate,
 	.copy_file_range = fuse_lib_copy_file_range,
 	.lseek = fuse_lib_lseek,
+	.iomap_begin = fuse_lib_iomap_begin,
+	.iomap_end = fuse_lib_iomap_end,
 };
 
 int fuse_notify_poll(struct fuse_pollhandle *ph)


