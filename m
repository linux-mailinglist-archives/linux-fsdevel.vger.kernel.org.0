Return-Path: <linux-fsdevel+bounces-61635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE55B58A82
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 03:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0D987B07F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 01:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30D61C5F23;
	Tue, 16 Sep 2025 01:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C56cy6Wf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5ED18C933;
	Tue, 16 Sep 2025 01:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984529; cv=none; b=OpntDzfLKfO3xPAxAdnp6Q16RzzLN8x0MKMuxjhu7IRDi9CPQXmCRlf4OM5QxhXDJgshqI4gK6J4AQoGSlZBGKShyo3CoDKdHwGEn/iz6PoAcAr+S3FtuVj8rNtT5v/mxAQlKxx8nituyJySyX/jHB/fS0yi/PIzLPsFedqdYDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984529; c=relaxed/simple;
	bh=KG4Bz8fJDA09rbd17+nCwnRs0wBk70goxx22kLE6pcM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TpNj0ZLHZOWCDbxohdvW8cSBUsIHxXHEumMvozdof4fjcmCDGNx7V4B6a0rT6F4QESmJ0wqBWT5CwFtW4IxZcAdxeNKmjFEq8E06NKUHoCXcBUxkdtLfhEvLVrOmem2RQC/f+UG8xyge2OxNHM9Y4z5K8+qW0/ig88f6y0OAT98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C56cy6Wf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B54CDC4CEF1;
	Tue, 16 Sep 2025 01:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757984528;
	bh=KG4Bz8fJDA09rbd17+nCwnRs0wBk70goxx22kLE6pcM=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=C56cy6Wfr5zEF4oLPPFaHpWsT/Vfoigj1i7FmXMviLLk9+5YiWUrEQLexgMLGka0Y
	 JOJv4HCvnTLGNJWcofeVWP6buiIsNrUmHPqMQWDMC989QFss71XMUJWvpNAw6xBV1r
	 xajMmdRGmu+/B5kYo78L5UyHJuwvymA+V2aUMdTacHiYCiuer0G7zukwr0//X8WDBC
	 gY4DQ3DbooKN+28k+KupQjHmqyAHES+ZwFk9CSSbn4aeNF0aJ1yrhv976JYAqTQoJK
	 uV1uttbTTkuHhm7i894MMfiZJWbfPcBdQoMyfB1Vyf3fH9cvedK4qwbWpRQusKougn
	 QT/YkM4YA4v8w==
Date: Mon, 15 Sep 2025 18:02:08 -0700
Subject: [PATCH 13/17] fuse2fs: set iomap-related inode flags
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, John@groves.net, bernd@bsbernd.com,
 joannelkoong@gmail.com
Message-ID: <175798161954.390496.13517440154976780084.stgit@frogsfrogsfrogs>
In-Reply-To: <175798161643.390496.10274066827486065265.stgit@frogsfrogsfrogs>
References: <175798161643.390496.10274066827486065265.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Set FUSE_IFLAG_* when we do a getattr, so that all files will have iomap
enabled.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |   46 +++++++++++++++++++++++++++++++++++-----------
 misc/fuse2fs.c    |   20 ++++++++++++++++++++
 2 files changed, 55 insertions(+), 11 deletions(-)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index 47ad8215c3e1d1..37999d864a05e5 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -1685,6 +1685,7 @@ static void op_init(void *userdata, struct fuse_conn_info *conn)
 
 struct fuse4fs_stat {
 	struct fuse_entry_param	entry;
+	unsigned int iflags;
 };
 
 static int fuse4fs_stat_inode(struct fuse4fs *ff, ext2_ino_t ino,
@@ -1750,9 +1751,29 @@ static int fuse4fs_stat_inode(struct fuse4fs *ff, ext2_ino_t ino,
 	entry->attr_timeout = FUSE4FS_ATTR_TIMEOUT;
 	entry->entry_timeout = FUSE4FS_ATTR_TIMEOUT;
 
+	fstat->iflags = 0;
+#ifdef HAVE_FUSE_IOMAP
+	if (fuse4fs_iomap_enabled(ff))
+		fstat->iflags |= FUSE_IFLAG_IOMAP;
+#endif
+
 	return 0;
 }
 
+#if FUSE_VERSION < FUSE_MAKE_VERSION(3, 99)
+#define fuse_reply_entry_iflags(req, entry, iflags) \
+	fuse_reply_entry((req), (entry))
+
+#define fuse_reply_attr_iflags(req, entry, iflags, timeout) \
+	fuse_reply_attr((req), (entry), (timeout))
+
+#define fuse_add_direntry_plus_iflags(req, buf, sz, name, iflags, entry, dirpos) \
+	fuse_add_direntry_plus((req), (buf), (sz), (name), (entry), (dirpos))
+
+#define fuse_reply_create_iflags(req, entry, iflags, fp) \
+	fuse_reply_create((req), (entry), (fp))
+#endif
+
 static void op_lookup(fuse_req_t req, fuse_ino_t fino, const char *name)
 {
 	struct fuse4fs_stat fstat;
@@ -1783,7 +1804,7 @@ static void op_lookup(fuse_req_t req, fuse_ino_t fino, const char *name)
 	if (ret)
 		fuse_reply_err(req, -ret);
 	else
-		fuse_reply_entry(req, &fstat.entry);
+		fuse_reply_entry_iflags(req, &fstat.entry, fstat.iflags);
 }
 
 static void op_getattr(fuse_req_t req, fuse_ino_t fino,
@@ -1803,8 +1824,8 @@ static void op_getattr(fuse_req_t req, fuse_ino_t fino,
 	if (ret)
 		fuse_reply_err(req, -ret);
 	else
-		fuse_reply_attr(req, &fstat.entry.attr,
-				fstat.entry.attr_timeout);
+		fuse_reply_attr_iflags(req, &fstat.entry.attr, fstat.iflags,
+				       fstat.entry.attr_timeout);
 }
 
 static void op_readlink(fuse_req_t req, fuse_ino_t fino)
@@ -2082,7 +2103,7 @@ static void fuse4fs_reply_entry(fuse_req_t req, ext2_ino_t ino,
 		return;
 	}
 
-	fuse_reply_entry(req, &fstat.entry);
+	fuse_reply_entry_iflags(req, &fstat.entry, fstat.iflags);
 }
 
 static void op_mknod(fuse_req_t req, fuse_ino_t fino, const char *name,
@@ -4352,10 +4373,13 @@ static int op_readdir_iter(ext2_ino_t dir EXT2FS_ATTR((unused)),
 	namebuf[dirent->name_len & 0xFF] = 0;
 
 	if (i->readdirplus) {
-		entrysize = fuse_add_direntry_plus(i->req, i->buf + i->bufused,
-						   i->bufsz - i->bufused,
-						   namebuf, &fstat.entry,
-						   i->dirpos);
+		entrysize = fuse_add_direntry_plus_iflags(i->req,
+							  i->buf + i->bufused,
+							  i->bufsz - i->bufused,
+							  namebuf,
+							  fstat.iflags,
+							  &fstat.entry,
+							  i->dirpos);
 	} else {
 		entrysize = fuse_add_direntry(i->req, i->buf + i->bufused,
 					      i->bufsz - i->bufused, namebuf,
@@ -4580,7 +4604,7 @@ static void op_create(fuse_req_t req, fuse_ino_t fino, const char *name,
 	if (ret)
 		fuse_reply_err(req, -ret);
 	else
-		fuse_reply_create(req, &fstat.entry, fp);
+		fuse_reply_create_iflags(req, &fstat.entry, fstat.iflags, fp);
 }
 
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 17)
@@ -4779,8 +4803,8 @@ static void op_setattr(fuse_req_t req, fuse_ino_t fino, struct stat *attr,
 	if (ret)
 		fuse_reply_err(req, -ret);
 	else
-		fuse_reply_attr(req, &fstat.entry.attr,
-				fstat.entry.attr_timeout);
+		fuse_reply_attr_iflags(req, &fstat.entry.attr, fstat.iflags,
+				       fstat.entry.attr_timeout);
 }
 
 #define FUSE4FS_MODIFIABLE_IFLAGS \
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 5dc0b0606112af..32fcada0426752 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -1619,6 +1619,23 @@ static int op_getattr(const char *path, struct stat *statbuf,
 	return ret;
 }
 
+#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 99)
+static int op_getattr_iflags(const char *path, struct stat *statbuf,
+			     unsigned int *iflags, struct fuse_file_info *fi)
+{
+	int ret = op_getattr(path, statbuf, fi);
+
+	if (ret)
+		return ret;
+
+	if (fuse_fs_can_enable_iomap(statbuf))
+		*iflags |= FUSE_IFLAG_IOMAP;
+
+	return 0;
+}
+#endif
+
+
 static int op_readlink(const char *path, char *buf, size_t len)
 {
 	struct fuse2fs *ff = fuse2fs_get();
@@ -6238,6 +6255,9 @@ static struct fuse_operations fs_ops = {
 #ifdef SUPPORT_FALLOCATE
 	.fallocate = op_fallocate,
 #endif
+#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 99)
+	.getattr_iflags = op_getattr_iflags,
+#endif
 #ifdef HAVE_FUSE_IOMAP
 	.iomap_begin = op_iomap_begin,
 	.iomap_end = op_iomap_end,


