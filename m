Return-Path: <linux-fsdevel+bounces-61649-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C2EB58AB5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 03:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 949352A6D56
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 01:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DAE2153D3;
	Tue, 16 Sep 2025 01:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vAsZJM6F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCDE1AF0C8;
	Tue, 16 Sep 2025 01:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984732; cv=none; b=frIWPJBkWwGL0GePid5RY0qFkBditkUGVmhVXgGi1qHy0VMcsAF58UeTAuQhQUNRFsK9uMC8/Iizv2qIuq8JLH0SmkAxZpm3J+VetfyvAAMq9sfMei2IchE+RothMvmMFUwLWABhubuu+MGGu8si+nKonw+grSHqSIEdiHPcEaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984732; c=relaxed/simple;
	bh=pLFVoiDYh4Ed47Jq44pVydQT1vfa67GR1dm/QGqyeEE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lZgY9ogCFMhm6x0tTIGT9xaxksIcJDMiFY5XPdHa8mX0vTTGlt4727G29HdErg/EOxMQMSDChkCotsbWDfwY+mDWf4gFV1qi3B75G4ZD7t/3tYAV2tyq24TfPISDHKGjUhLstNUrCgfr5Cpi7vuAOK8F0CKGpSe/Vn1tguWKrAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vAsZJM6F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17B56C4CEF1;
	Tue, 16 Sep 2025 01:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757984732;
	bh=pLFVoiDYh4Ed47Jq44pVydQT1vfa67GR1dm/QGqyeEE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=vAsZJM6FDfPFIxchLj7DJZRQmGtApE9OXIvOGqY6FvNPOwSzhqHYRQkvtpci466or
	 62l8wKyE4FRadF7zxnpvVjtaQd4n/T9Nm+y0xCc6KZvUQBUf4v9F511cfBMlJOPYMZ
	 Lco9MGG3atndnZZE0XPbdCdJYivyE1N7MY6f7ZbvVqECwQFd4Tj098lVvJ0j95Xtfe
	 WGtGa4t+XqHlPUj1uAOVWPfpTzEGoVzm7l4fTZ6ybMyXgZjbKDt4+PjTaOZlwfDgE8
	 8rFODxV+d98+/IlGcjacPLsXkG3T1tJ+S9o572jAIHW8PqZliEDImSfUokTgjAXNx/
	 MgUb3VzLGG5yg==
Date: Mon, 15 Sep 2025 18:05:31 -0700
Subject: [PATCH 08/10] fuse2fs: enable syncfs
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, John@groves.net, bernd@bsbernd.com,
 joannelkoong@gmail.com
Message-ID: <175798162485.391272.10634665300127990664.stgit@frogsfrogsfrogs>
In-Reply-To: <175798162297.391272.17812368866586383182.stgit@frogsfrogsfrogs>
References: <175798162297.391272.17812368866586383182.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Enable syncfs calls in fuse2fs.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |   39 ++++++++++++++++++++++++++++++++++++++-
 misc/fuse2fs.c    |   36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+), 1 deletion(-)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index 5673a545b06b31..25c19c0f0deca0 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -1993,7 +1993,7 @@ static int fuse4fs_statx(struct fuse4fs *ff, ext2_ino_t ino, int statx_mask,
 static void op_statx(fuse_req_t req, fuse_ino_t fino, int flags, int mask,
 		     struct fuse_file_info *fi)
 {
-	struct statx stx;
+	struct statx stx = { };
 	struct fuse4fs *ff = fuse4fs_get(req);
 	ext2_ino_t ino;
 	int ret = 0;
@@ -5775,6 +5775,40 @@ static void op_fallocate(fuse_req_t req, fuse_ino_t fino EXT2FS_ATTR((unused)),
 }
 #endif /* SUPPORT_FALLOCATE */
 
+#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 99)
+static void op_syncfs(fuse_req_t req, fuse_ino_t ino)
+{
+	struct fuse4fs *ff = fuse4fs_get(req);
+	ext2_filsys fs;
+	errcode_t err;
+	int ret = 0;
+
+	FUSE4FS_CHECK_CONTEXT(req);
+	fs = fuse4fs_start(ff);
+
+	if (ff->opstate == F4OP_WRITABLE) {
+		if (fs->super->s_error_count)
+			fs->super->s_state |= EXT2_ERROR_FS;
+		ext2fs_mark_super_dirty(fs);
+		err = ext2fs_set_gdt_csum(fs);
+		if (err) {
+			ret = translate_error(fs, 0, err);
+			goto out_unlock;
+		}
+
+		err = ext2fs_flush2(fs, 0);
+		if (err) {
+			ret = translate_error(fs, 0, err);
+			goto out_unlock;
+		}
+	}
+
+out_unlock:
+	fuse4fs_finish(ff, ret);
+	fuse_reply_err(req, -ret);
+}
+#endif
+
 #ifdef HAVE_FUSE_IOMAP
 static void fuse4fs_iomap_hole(struct fuse4fs *ff, struct fuse_file_iomap *iomap,
 			       off_t pos, uint64_t count)
@@ -7063,6 +7097,9 @@ static struct fuse_lowlevel_ops fs_ops = {
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 18)
 	.statx = op_statx,
 #endif
+#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 99)
+	.syncfs = op_syncfs,
+#endif
 #ifdef HAVE_FUSE_IOMAP
 	.iomap_begin = op_iomap_begin,
 	.iomap_end = op_iomap_end,
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 00dafec79f7766..d4f1825dd695ad 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -5331,6 +5331,41 @@ static int op_fallocate(const char *path EXT2FS_ATTR((unused)), int mode,
 }
 #endif /* SUPPORT_FALLOCATE */
 
+#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 99)
+static int op_syncfs(const char *path)
+{
+	struct fuse2fs *ff = fuse2fs_get();
+	ext2_filsys fs;
+	errcode_t err;
+	int ret = 0;
+
+	FUSE2FS_CHECK_CONTEXT(ff);
+	dbg_printf(ff, "%s: path=%s\n", __func__, path);
+	fs = fuse2fs_start(ff);
+
+	if (ff->opstate == F2OP_WRITABLE) {
+		if (fs->super->s_error_count)
+			fs->super->s_state |= EXT2_ERROR_FS;
+		ext2fs_mark_super_dirty(fs);
+		err = ext2fs_set_gdt_csum(fs);
+		if (err) {
+			ret = translate_error(fs, 0, err);
+			goto out_unlock;
+		}
+
+		err = ext2fs_flush2(fs, 0);
+		if (err) {
+			ret = translate_error(fs, 0, err);
+			goto out_unlock;
+		}
+	}
+
+out_unlock:
+	fuse2fs_finish(ff, ret);
+	return ret;
+}
+#endif
+
 #ifdef HAVE_FUSE_IOMAP
 static void fuse2fs_iomap_hole(struct fuse2fs *ff, struct fuse_file_iomap *iomap,
 			       off_t pos, uint64_t count)
@@ -6611,6 +6646,7 @@ static struct fuse_operations fs_ops = {
 #endif
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 99)
 	.getattr_iflags = op_getattr_iflags,
+	.syncfs = op_syncfs,
 #endif
 #ifdef HAVE_FUSE_IOMAP
 	.iomap_begin = op_iomap_begin,


