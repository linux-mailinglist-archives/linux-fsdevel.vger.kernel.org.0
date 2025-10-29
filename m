Return-Path: <linux-fsdevel+bounces-66119-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AEDC17D32
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACE851897B56
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA812D7DDF;
	Wed, 29 Oct 2025 01:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILTFJ4qi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F701F419A;
	Wed, 29 Oct 2025 01:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700529; cv=none; b=cv0WeemiRxjVTK94M4w4ZnSaliPWD81y8JX32Ba8XZ25ac30VTyj7kcRAUhJdR0+/aVViOgEd5ZhJhh+sLmTsTrjWy59tF0/vw1c8iZStMHeKwIbmWjKDm/3UADeLTg0C5J5amAsyXnIyTrMgY0zHy3Uy/73sdFtCIWPlcQc/hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700529; c=relaxed/simple;
	bh=3Vly51GnP5EPf0OzaZg9DEpiNAN9emU+1wcT00fPm+c=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q8Xvw5U+/7OktDLLVilO5wp4sKsjCAvzMzCSGR1YP3N6nK+jPwizzQHJvlleUmzLkQjA63v07ci1MUVgo/3IC+NeHnPreN2snyyGoA5/+Fum10ObBmMFzjsg5jRHnqczduvmApo0E8bodEm0Dx13rpMN41cAnZYv373zjOlEww8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILTFJ4qi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED0CFC4CEE7;
	Wed, 29 Oct 2025 01:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761700529;
	bh=3Vly51GnP5EPf0OzaZg9DEpiNAN9emU+1wcT00fPm+c=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ILTFJ4qi2TDGu9NYrv2W5yx922kzkzojOCyl62YCt40tqRBLmiHru7evxnT2Iq2+E
	 oChZp7iY/VYf761NsH7BjBepiVr4B3bdKsr+1e1OiXYDDW8qjjpkwrYIpeuFZgX+ll
	 eM5EftxpZ4BNN2WmDsau1FNF4rUL7wVcWnVrGneoWad4wz+nwJE7L2FSmLzcNcma3S
	 2ek+wMdMErv+/leS5ySpFR3nEvqmWYPIWD0LR1w/neVMMr9fRgTxUtvIO6pbuSfNV5
	 e4RShA6nVnK53nDYVmDi+P55BfHFgDWnt+k4tbidc8c6ebLYk3zcy1cprZ1PnELjDC
	 kdOw22yHPJJaA==
Date: Tue, 28 Oct 2025 18:15:28 -0700
Subject: [PATCH 08/11] fuse2fs: enable syncfs
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com,
 neal@gompa.dev, miklos@szeredi.hu, linux-ext4@vger.kernel.org
Message-ID: <176169818368.1430380.11990499926700329921.stgit@frogsfrogsfrogs>
In-Reply-To: <176169818170.1430380.13590456647130347042.stgit@frogsfrogsfrogs>
References: <176169818170.1430380.13590456647130347042.stgit@frogsfrogsfrogs>
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
 fuse4fs/fuse4fs.c |   32 ++++++++++++++++++++++++++++++++
 misc/fuse2fs.c    |   34 ++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index cafee29991bff6..ac8696aab65af4 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -6271,7 +6271,38 @@ static void op_shutdownfs(fuse_req_t req, fuse_ino_t ino, uint64_t flags)
 	int ret;
 
 	ret = ioctl_shutdown(ff, ctxt, NULL, NULL, 0);
+	fuse_reply_err(req, -ret);
+}
 
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
 	fuse_reply_err(req, -ret);
 }
 #endif
@@ -7568,6 +7599,7 @@ static struct fuse_lowlevel_ops fs_ops = {
 	.freezefs = op_freezefs,
 	.unfreezefs = op_unfreezefs,
 	.shutdownfs = op_shutdownfs,
+	.syncfs = op_syncfs,
 #endif
 #ifdef HAVE_FUSE_IOMAP
 	.iomap_begin = op_iomap_begin,
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 10673aaed60dea..b6ede4bcb32c27 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -5829,6 +5829,39 @@ static int op_shutdownfs(const char *path, uint64_t flags)
 
 	return ioctl_shutdown(ff, NULL, NULL);
 }
+
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
 #endif
 
 #ifdef HAVE_FUSE_IOMAP
@@ -7114,6 +7147,7 @@ static struct fuse_operations fs_ops = {
 	.freezefs = op_freezefs,
 	.unfreezefs = op_unfreezefs,
 	.shutdownfs = op_shutdownfs,
+	.syncfs = op_syncfs,
 #endif
 #ifdef HAVE_FUSE_IOMAP
 	.iomap_begin = op_iomap_begin,


