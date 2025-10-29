Return-Path: <linux-fsdevel+bounces-66105-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23745C17CB0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79AE3188CB91
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7722D979F;
	Wed, 29 Oct 2025 01:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8FITk7+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95CD3A1CD;
	Wed, 29 Oct 2025 01:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700310; cv=none; b=HqvzFqApsyZYBH7DTOqIdL7rnxEh7rLKYKuAKfglzEG5zaEj2eBBkyfd2T0ASn0iu543DXSfYks+T1QuG1dYwWiN9nvzf9FwDdIHgKEbPI7z3XLdzSlZcEl2okmVJSctg7nh4BjrKacfxllZI1/eBmk20trJ6g8o8ce2kbM5XN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700310; c=relaxed/simple;
	bh=WPDZhzJGYyn1M6hk7KK8du3EDU6aXxaOoofpsgkKXFA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B1ndtt2khDxc1SviwHl6VtlKZGv9LzHo5V43bZ/hGgsPtaZBzue2nXk3OOFhcuDV2xCVKOpVw2ttefLuSIKGyZprU5Tlt9vrTV67339CiJTfDdTqQ9jW6lzydP0ump0ZvCaWYsVfsxPyohRcTt6fydsrAgjRGF9BmzzUiydZNgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r8FITk7+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B61B8C4CEE7;
	Wed, 29 Oct 2025 01:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761700309;
	bh=WPDZhzJGYyn1M6hk7KK8du3EDU6aXxaOoofpsgkKXFA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=r8FITk7+GA7n+5dSiuomyaqpXeY9wzbRe6WpjFYLNa7jicT3biD8AZhQgxczU5cTj
	 iT1RBj/7B9bwXU4nQgqzyPAkURBFrjnrjguGm0D9fC4LAXqmMsu66Btr2Ug2lM8ePU
	 12FCWlVuTCqW0RzXaNVDvcMN58f30mwaTpJe5sHneBTfvFKK0pjWTGrMZtocz4Ywd8
	 0TcAfqA2k3+vlYmreQhabHHocL2FKSdlknsbUdq/nPdbnZ+1PffqxXuY/L/LVtiyop
	 qIPx/aXcINthlDM/C53gr5/WxCEOod9L0Ka4leI8ZwSkyqS2EUDx62ZcIFrus3MB0r
	 9jRp80c3Ev6dw==
Date: Tue, 28 Oct 2025 18:11:49 -0700
Subject: [PATCH 13/17] fuse2fs: set iomap-related inode flags
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com,
 neal@gompa.dev, miklos@szeredi.hu, linux-ext4@vger.kernel.org
Message-ID: <176169817800.1429568.9480060100758957681.stgit@frogsfrogsfrogs>
In-Reply-To: <176169817482.1429568.16747148621305977151.stgit@frogsfrogsfrogs>
References: <176169817482.1429568.16747148621305977151.stgit@frogsfrogsfrogs>
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
index c12cc982291b1c..e83fbf8c8fe8fc 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -2037,6 +2037,7 @@ static void op_init(void *userdata, struct fuse_conn_info *conn)
 
 struct fuse4fs_stat {
 	struct fuse_entry_param	entry;
+	unsigned int iflags;
 };
 
 static int fuse4fs_stat_inode(struct fuse4fs *ff, ext2_ino_t ino,
@@ -2102,9 +2103,29 @@ static int fuse4fs_stat_inode(struct fuse4fs *ff, ext2_ino_t ino,
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
@@ -2135,7 +2156,7 @@ static void op_lookup(fuse_req_t req, fuse_ino_t fino, const char *name)
 	if (ret)
 		fuse_reply_err(req, -ret);
 	else
-		fuse_reply_entry(req, &fstat.entry);
+		fuse_reply_entry_iflags(req, &fstat.entry, fstat.iflags);
 }
 
 static void op_getattr(fuse_req_t req, fuse_ino_t fino,
@@ -2155,8 +2176,8 @@ static void op_getattr(fuse_req_t req, fuse_ino_t fino,
 	if (ret)
 		fuse_reply_err(req, -ret);
 	else
-		fuse_reply_attr(req, &fstat.entry.attr,
-				fstat.entry.attr_timeout);
+		fuse_reply_attr_iflags(req, &fstat.entry.attr, fstat.iflags,
+				       fstat.entry.attr_timeout);
 }
 
 static void op_readlink(fuse_req_t req, fuse_ino_t fino)
@@ -2434,7 +2455,7 @@ static void fuse4fs_reply_entry(fuse_req_t req, ext2_ino_t ino,
 		return;
 	}
 
-	fuse_reply_entry(req, &fstat.entry);
+	fuse_reply_entry_iflags(req, &fstat.entry, fstat.iflags);
 }
 
 static void op_mknod(fuse_req_t req, fuse_ino_t fino, const char *name,
@@ -4755,10 +4776,13 @@ static int op_readdir_iter(ext2_ino_t dir EXT2FS_ATTR((unused)),
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
@@ -4983,7 +5007,7 @@ static void op_create(fuse_req_t req, fuse_ino_t fino, const char *name,
 	if (ret)
 		fuse_reply_err(req, -ret);
 	else
-		fuse_reply_create(req, &fstat.entry, fp);
+		fuse_reply_create_iflags(req, &fstat.entry, fstat.iflags, fp);
 }
 
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 17)
@@ -5182,8 +5206,8 @@ static void op_setattr(fuse_req_t req, fuse_ino_t fino, struct stat *attr,
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
index 1a4efca8beb623..6abf1e53656e5a 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -1972,6 +1972,23 @@ static int op_getattr(const char *path, struct stat *statbuf,
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
@@ -6647,6 +6664,9 @@ static struct fuse_operations fs_ops = {
 #ifdef SUPPORT_FALLOCATE
 	.fallocate = op_fallocate,
 #endif
+#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 99)
+	.getattr_iflags = op_getattr_iflags,
+#endif
 #ifdef HAVE_FUSE_IOMAP
 	.iomap_begin = op_iomap_begin,
 	.iomap_end = op_iomap_end,


