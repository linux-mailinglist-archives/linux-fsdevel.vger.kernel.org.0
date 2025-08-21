Return-Path: <linux-fsdevel+bounces-58543-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 43816B2EA6A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 02D254E366A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5D21F463B;
	Thu, 21 Aug 2025 01:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpvhZ/Zb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B771D36CE02;
	Thu, 21 Aug 2025 01:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755739146; cv=none; b=jL6JMw7LiclQBtnzp3QQC8EqGH1hl+OY8HzmE1qtfsxBqv/Il5QEHYgbW8ULDQv5p2E79cCVaQy22mE0/kDqID+LU4OlqkpelsoaSA38idaD5eWRhavyIlKam8R9QL5OqkqLQv33PoAUvbUJRMaK4Gj8Lxgznh1JSKwdMYr5d2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755739146; c=relaxed/simple;
	bh=i/QGbXZHUQ1n19/dIs2qFKU0cNt4lhICYxxB60yjeqY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E2w64zhUm68DFAcBnuz0wwUvjI9YKZSA7XDgafr72zF3YL9Jw8ck3lF5LHFM68tliY6VTBQJKUzgdw3AHFoOD71/fpFgu87HFfIRunBt2G1+9rEhOL8iKmGUqaAyWlShEKmVjuyB/mi7aiD28LPS3K04kjYsRdkRNn1LzP/f/pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpvhZ/Zb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34E8BC4CEE7;
	Thu, 21 Aug 2025 01:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755739146;
	bh=i/QGbXZHUQ1n19/dIs2qFKU0cNt4lhICYxxB60yjeqY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=kpvhZ/ZbKDKkVffPC9pWhP+LsrELwBC5A4s7+Rcuatd2FnuSP07/3Q69pH4jf+fMs
	 HubYF07wphvTECG6JyErVA0JD3DECNDEOGAeiZEPRx0qKG3Xvp+r5sh2YAjGSly4/D
	 GTOtPitPLFMXPHqT9yBqgoprtBYwAaScueU0jmMpOjMaOvLm4kqMvxq7LZEZwKIEpZ
	 7NE/PdFnIdRlyPE5Bl2cu4tdT5UeH3v8qKaaqWAXbL1z65plkUgMv0WXxCuuN7zsZC
	 A0HI8EOZQO3xDFxdIkZjxXJkgpVehpY6bUJvx9MiNXMyIUsQIZyyoAew0Lauiptkdy
	 hlPia9IFHE7xQ==
Date: Wed, 20 Aug 2025 18:19:05 -0700
Subject: [PATCH 13/19] fuse2fs: set iomap-related inode flags
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com,
 neal@gompa.dev
Message-ID: <175573713965.21970.7942804309936907088.stgit@frogsfrogsfrogs>
In-Reply-To: <175573713645.21970.9783397720493472605.stgit@frogsfrogsfrogs>
References: <175573713645.21970.9783397720493472605.stgit@frogsfrogsfrogs>
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
 misc/fuse2fs.c |   20 ++++++++++++++++++++
 misc/fuse4fs.c |   46 +++++++++++++++++++++++++++++++++++-----------
 2 files changed, 55 insertions(+), 11 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index fc83d2d21c600b..291416afb93d6c 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -1620,6 +1620,23 @@ static int op_getattr(const char *path, struct stat *statbuf
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
@@ -6339,6 +6356,9 @@ static struct fuse_operations fs_ops = {
 	.fallocate = op_fallocate,
 # endif
 #endif
+#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 99)
+	.getattr_iflags = op_getattr_iflags,
+#endif
 #ifdef HAVE_FUSE_IOMAP
 	.iomap_begin = op_iomap_begin,
 	.iomap_end = op_iomap_end,
diff --git a/misc/fuse4fs.c b/misc/fuse4fs.c
index 6de9f69d05de0b..37a7ab3a3718e4 100644
--- a/misc/fuse4fs.c
+++ b/misc/fuse4fs.c
@@ -1659,6 +1659,7 @@ static void op_init(void *userdata, struct fuse_conn_info *conn)
 
 struct fuse4fs_stat {
 	struct fuse_entry_param	entry;
+	unsigned int iflags;
 };
 
 static int fuse4fs_stat_inode(struct fuse4fs *ff, ext2_ino_t ino,
@@ -1724,9 +1725,29 @@ static int fuse4fs_stat_inode(struct fuse4fs *ff, ext2_ino_t ino,
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
@@ -1757,7 +1778,7 @@ static void op_lookup(fuse_req_t req, fuse_ino_t fino, const char *name)
 	if (ret)
 		fuse_reply_err(req, -ret);
 	else
-		fuse_reply_entry(req, &fstat.entry);
+		fuse_reply_entry_iflags(req, &fstat.entry, fstat.iflags);
 }
 
 static void op_getattr(fuse_req_t req, fuse_ino_t fino,
@@ -1777,8 +1798,8 @@ static void op_getattr(fuse_req_t req, fuse_ino_t fino,
 	if (ret)
 		fuse_reply_err(req, -ret);
 	else
-		fuse_reply_attr(req, &fstat.entry.attr,
-				fstat.entry.attr_timeout);
+		fuse_reply_attr_iflags(req, &fstat.entry.attr, fstat.iflags,
+				       fstat.entry.attr_timeout);
 }
 
 static void op_readlink(fuse_req_t req, fuse_ino_t fino)
@@ -2056,7 +2077,7 @@ static void fuse4fs_reply_entry(fuse_req_t req, ext2_ino_t ino,
 		return;
 	}
 
-	fuse_reply_entry(req, &fstat.entry);
+	fuse_reply_entry_iflags(req, &fstat.entry, fstat.iflags);
 }
 
 static void op_mknod(fuse_req_t req, fuse_ino_t fino, const char *name,
@@ -4317,10 +4338,13 @@ static int op_readdir_iter(ext2_ino_t dir EXT2FS_ATTR((unused)),
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
@@ -4545,7 +4569,7 @@ static void op_create(fuse_req_t req, fuse_ino_t fino, const char *name,
 	if (ret)
 		fuse_reply_err(req, -ret);
 	else
-		fuse_reply_create(req, &fstat.entry, fp);
+		fuse_reply_create_iflags(req, &fstat.entry, fstat.iflags, fp);
 }
 
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 17)
@@ -4744,8 +4768,8 @@ static void op_setattr(fuse_req_t req, fuse_ino_t fino, struct stat *attr,
 	if (ret)
 		fuse_reply_err(req, -ret);
 	else
-		fuse_reply_attr(req, &fstat.entry.attr,
-				fstat.entry.attr_timeout);
+		fuse_reply_attr_iflags(req, &fstat.entry.attr, fstat.iflags,
+				       fstat.entry.attr_timeout);
 }
 
 #define FUSE4FS_MODIFIABLE_IFLAGS \


