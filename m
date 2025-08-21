Return-Path: <linux-fsdevel+bounces-58558-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF2BB2EA9B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 588275C45C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5B3214204;
	Thu, 21 Aug 2025 01:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lROqfo6C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02244204F99;
	Thu, 21 Aug 2025 01:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755739381; cv=none; b=i+eCNPrCjef/BuZhAsI+dI7+Rx9h2wb1nXhvOfi/KZot/jvXOhAz5kqNoci36MeKXHLbZ5A1I+mF5zUtVgAk4j75rOSm7WOoQf6TXr5N+cpcMCJJ/oJ3CzH+0GY+iV1PMylia4aXCDovnyO0QufymCe1emJQO59RsMS1Z06fUpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755739381; c=relaxed/simple;
	bh=mHKVsGN5hmbYz/eW/Bzw6EpRbajWjVotaUpNCnMiEeQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WweBcKBfUaBqaMl9FDgQhZ9Ix1Plh5bB3gF/ncbgAouSK4v2NxWJdiZw0Yb0fE6NJXeWB5KMGXvf9ClCb06GGivVlPrHJGVMs8zYqj4pogC6K5e7Xoh+2C+yY/UpVX+sIsEwGYKZVs4e2Eob/WmyiezcCzeoajtkYEak3K4BJmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lROqfo6C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D5D8C4CEEB;
	Thu, 21 Aug 2025 01:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755739380;
	bh=mHKVsGN5hmbYz/eW/Bzw6EpRbajWjVotaUpNCnMiEeQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=lROqfo6C584bxCPgTJMFY1TCO9IlWJAU7OSZ8WA0C9TsZEzm8oKEFXNEKFgIgMsAg
	 JqhKSU74SqZuXdZYKGWiXhIQBhGW8Gdl5geAyX2NeaW56sQnEEMvWQ6NjovKJsIYtg
	 ocqVWIUxzbTnZ8QHK3KRKHJ/WEMr458nW7KFC2KegTgm9/m2SXt6T7GUMoAm41bTC8
	 br8w82loXF+L6YGRHT8RWGTz+VHdG0l/oN9XO2RIiMLiMtrAphieR51+x5JLMfl9y9
	 BDMOpfkNnbt0IaYOg0ZtMb9taIZpg4sLWe7aBfs+BKD+4QxhWmi1s516IDLtmnXnpI
	 IV9WExQwrFv+A==
Date: Wed, 20 Aug 2025 18:23:00 -0700
Subject: [PATCH 7/8] fuse2fs: enable syncfs
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com,
 neal@gompa.dev
Message-ID: <175573714519.22854.15570663994051594737.stgit@frogsfrogsfrogs>
In-Reply-To: <175573714359.22854.5198450217393478706.stgit@frogsfrogsfrogs>
References: <175573714359.22854.5198450217393478706.stgit@frogsfrogsfrogs>
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
 misc/fuse2fs.c |   36 ++++++++++++++++++++++++++++++++++++
 misc/fuse4fs.c |   39 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 74 insertions(+), 1 deletion(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 80bd47549925bf..62aca0ab56ec07 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -5414,6 +5414,41 @@ static int op_fallocate(const char *path EXT2FS_ATTR((unused)), int mode,
 # endif /* SUPPORT_FALLOCATE */
 #endif /* FUSE 29 */
 
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
@@ -6750,6 +6785,7 @@ static struct fuse_operations fs_ops = {
 #endif
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 99)
 	.getattr_iflags = op_getattr_iflags,
+	.syncfs = op_syncfs,
 #endif
 #ifdef HAVE_FUSE_IOMAP
 	.iomap_begin = op_iomap_begin,
diff --git a/misc/fuse4fs.c b/misc/fuse4fs.c
index a06e963eab6afd..e01b83e271415c 100644
--- a/misc/fuse4fs.c
+++ b/misc/fuse4fs.c
@@ -1968,7 +1968,7 @@ static int fuse4fs_statx(struct fuse4fs *ff, ext2_ino_t ino, int statx_mask,
 static void op_statx(fuse_req_t req, fuse_ino_t fino, int flags, int mask,
 		     struct fuse_file_info *fi)
 {
-	struct statx stx;
+	struct statx stx = { };
 	struct fuse4fs *ff = fuse4fs_get(req);
 	ext2_ino_t ino;
 	int ret = 0;
@@ -5708,6 +5708,40 @@ static void op_fallocate(fuse_req_t req, fuse_ino_t fino EXT2FS_ATTR((unused)),
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
@@ -7034,6 +7068,9 @@ static struct fuse_lowlevel_ops fs_ops = {
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 18)
 	.statx = op_statx,
 #endif
+#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 99)
+	.syncfs = op_syncfs,
+#endif
 #ifdef HAVE_FUSE_IOMAP
 	.iomap_begin = op_iomap_begin,
 	.iomap_end = op_iomap_end,


