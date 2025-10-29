Return-Path: <linux-fsdevel+bounces-66110-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D24C17CD7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DC521AA0610
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7212D9ECE;
	Wed, 29 Oct 2025 01:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tEPGK4Rg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AE01EF0B0;
	Wed, 29 Oct 2025 01:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700388; cv=none; b=XcClI7U2jfYso77GU1fCWp4ej2i4hWMBMCl18/+8JKgzMiHBLx7sMiPptLEokX1dbRtUSM2VyO+A2WIS1QY3luMvInD0EKPffVDT+xcN9YVyjPFT+sli3uyjXMVMo/NlX1AYcIlIjzsD5ZYS8SpLv8zNEtHh/SnquUzjnDKtfeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700388; c=relaxed/simple;
	bh=AzmVo2m0Ehi9DGkm5B5ZFPlYFOTDtgfI9qCENyifMW0=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h9LdbfVYnGLMC5mPH/s0F9f1fOtnEVmAuwB7j+sDCH5DGzs9w5dhv45El5pyqeDjJRf0EN45CD0mr4ngrOZKXTr8xLQ1l+3V3DW2Zd+T2GB5xbEdNdC8+UDE3Fh/LRnOpaeSSt4Xwa2oUp+BTD+54+1zdu7BeZEOafe8A4h4QpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tEPGK4Rg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9EF3C4CEE7;
	Wed, 29 Oct 2025 01:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761700387;
	bh=AzmVo2m0Ehi9DGkm5B5ZFPlYFOTDtgfI9qCENyifMW0=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=tEPGK4Rg/PueQmuCn+ilgAW2+jZ05VBFubQQOv4Dx7y7i9c/Lxc+a9KI7H5dZVq1H
	 IUmFcmU6TOlQXgParMcTVPs548Ncy+8oqWCrILBFeBXpvFUITLHHD7M7BiDQYuxJW5
	 4u0qOLcTmEcSA+6VuHAPsEMWsMrsh5UTIM6pCc+pjIZEtZDUFWv4ng8idCjyX2N7f5
	 sBkhyN8h/kXA2oQdCiZ3fv0dwymxNAxpqimuM3mDtBeSERy3/Bdv2J5ji15CEt7ujz
	 DVh4H0q36qXSrXB6vxwpz8weEFXnngTGs+fFnYYPQfsJZ1F2/F5lUZM7Jn+LYCyPrj
	 71T+e/Gv0uLug==
Date: Tue, 28 Oct 2025 18:13:07 -0700
Subject: [PATCH 1/2] fuse2fs: implement freeze and shutdown requests
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com,
 neal@gompa.dev, miklos@szeredi.hu, linux-ext4@vger.kernel.org
Message-ID: <176169818017.1430244.15867634241723830969.stgit@frogsfrogsfrogs>
In-Reply-To: <176169817993.1430244.1454665580135941500.stgit@frogsfrogsfrogs>
References: <176169817993.1430244.1454665580135941500.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Handle freezing and shutting down the filesystem if requested.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |   91 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 misc/fuse2fs.c    |   84 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 175 insertions(+)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index 544ad9ecb06d45..26b9c6340b73a1 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -228,6 +228,7 @@ struct fuse4fs_file_handle {
 
 enum fuse4fs_opstate {
 	F4OP_READONLY,
+	F4OP_WRITABLE_FROZEN,
 	F4OP_WRITABLE,
 	F4OP_SHUTDOWN,
 };
@@ -6153,6 +6154,91 @@ static void op_fallocate(fuse_req_t req, fuse_ino_t fino EXT2FS_ATTR((unused)),
 }
 #endif /* SUPPORT_FALLOCATE */
 
+#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 99)
+static void op_freezefs(fuse_req_t req, fuse_ino_t ino, uint64_t unlinked)
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
+		else if (!unlinked)
+			fs->super->s_state |= EXT2_VALID_FS;
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
+
+		ff->opstate = F4OP_WRITABLE_FROZEN;
+	}
+
+out_unlock:
+	fs->super->s_state &= ~EXT2_VALID_FS;
+	fuse4fs_finish(ff, ret);
+	fuse_reply_err(req, -ret);
+}
+
+static void op_unfreezefs(fuse_req_t req, fuse_ino_t ino)
+{
+	struct fuse4fs *ff = fuse4fs_get(req);
+	ext2_filsys fs;
+	errcode_t err;
+	int ret = 0;
+
+	FUSE4FS_CHECK_CONTEXT(req);
+	fs = fuse4fs_start(ff);
+
+	if (ff->opstate == F4OP_WRITABLE_FROZEN) {
+		if (fs->super->s_error_count)
+			fs->super->s_state |= EXT2_ERROR_FS;
+		fs->super->s_state &= ~EXT2_VALID_FS;
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
+
+		ff->opstate = F4OP_WRITABLE;
+	}
+
+out_unlock:
+	fuse4fs_finish(ff, ret);
+	fuse_reply_err(req, -ret);
+}
+
+static void op_shutdownfs(fuse_req_t req, fuse_ino_t ino, uint64_t flags)
+{
+	const struct fuse_ctx *ctxt = fuse_req_ctx(req);
+	struct fuse4fs *ff = fuse4fs_get(req);
+	int ret;
+
+	ret = ioctl_shutdown(ff, ctxt, NULL, NULL, 0);
+
+	fuse_reply_err(req, -ret);
+}
+#endif
+
 #ifdef HAVE_FUSE_IOMAP
 static void fuse4fs_iomap_hole(struct fuse4fs *ff, struct fuse_file_iomap *iomap,
 			       off_t pos, uint64_t count)
@@ -7441,6 +7527,11 @@ static struct fuse_lowlevel_ops fs_ops = {
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 18)
 	.statx = op_statx,
 #endif
+#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 99)
+	.freezefs = op_freezefs,
+	.unfreezefs = op_unfreezefs,
+	.shutdownfs = op_shutdownfs,
+#endif
 #ifdef HAVE_FUSE_IOMAP
 	.iomap_begin = op_iomap_begin,
 	.iomap_end = op_iomap_end,
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index e6853a9be7dd03..763e1386bb54c8 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -222,6 +222,7 @@ struct fuse2fs_file_handle {
 
 enum fuse2fs_opstate {
 	F2OP_READONLY,
+	F2OP_WRITABLE_FROZEN,
 	F2OP_WRITABLE,
 	F2OP_SHUTDOWN,
 };
@@ -5687,6 +5688,86 @@ static int op_fallocate(const char *path EXT2FS_ATTR((unused)), int mode,
 }
 #endif /* SUPPORT_FALLOCATE */
 
+#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 99)
+static int op_freezefs(const char *path, uint64_t unlinked)
+{
+	struct fuse2fs *ff = fuse2fs_get();
+	ext2_filsys fs;
+	errcode_t err;
+	int ret = 0;
+
+	FUSE2FS_CHECK_CONTEXT(ff);
+	fs = fuse2fs_start(ff);
+
+	if (ff->opstate == F2OP_WRITABLE) {
+		if (fs->super->s_error_count)
+			fs->super->s_state |= EXT2_ERROR_FS;
+		else if (!unlinked)
+			fs->super->s_state |= EXT2_VALID_FS;
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
+
+		ff->opstate = F2OP_WRITABLE_FROZEN;
+	}
+
+out_unlock:
+	fs->super->s_state &= ~EXT2_VALID_FS;
+	fuse2fs_finish(ff, ret);
+	return ret;
+}
+
+static int op_unfreezefs(const char *path)
+{
+	struct fuse2fs *ff = fuse2fs_get();
+	ext2_filsys fs;
+	errcode_t err;
+	int ret = 0;
+
+	FUSE2FS_CHECK_CONTEXT(ff);
+	fs = fuse2fs_start(ff);
+
+	if (ff->opstate == F2OP_WRITABLE_FROZEN) {
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
+
+		ff->opstate = F2OP_WRITABLE;
+	}
+
+out_unlock:
+	fuse2fs_finish(ff, ret);
+	return ret;
+}
+
+static int op_shutdownfs(const char *path, uint64_t flags)
+{
+	struct fuse2fs *ff = fuse2fs_get();
+
+	return ioctl_shutdown(ff, NULL, NULL);
+}
+#endif
+
 #ifdef HAVE_FUSE_IOMAP
 static void fuse2fs_iomap_hole(struct fuse2fs *ff, struct fuse_file_iomap *iomap,
 			       off_t pos, uint64_t count)
@@ -6967,6 +7048,9 @@ static struct fuse_operations fs_ops = {
 #endif
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 99)
 	.getattr_iflags = op_getattr_iflags,
+	.freezefs = op_freezefs,
+	.unfreezefs = op_unfreezefs,
+	.shutdownfs = op_shutdownfs,
 #endif
 #ifdef HAVE_FUSE_IOMAP
 	.iomap_begin = op_iomap_begin,


