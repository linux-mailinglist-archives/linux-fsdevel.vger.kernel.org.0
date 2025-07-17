Return-Path: <linux-fsdevel+bounces-55395-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC127B09898
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19EDF17D5FA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81ABE242927;
	Thu, 17 Jul 2025 23:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FghGZkSL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB21225A39;
	Thu, 17 Jul 2025 23:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752796048; cv=none; b=Fk79Ib+BRrKLLjo5kHIWENNSqJIqHvS4mm+CDjRpOyUWIz5jEHRPB0KJX9Am0TPFIhhc7JmHupK+4mM/Iq6VH9tCP3VfqWH4Vv4ha8Gkql4asLilQ407EZ8WfSY34/sGdgMviBEBhxQ43+JzoPJHph4kY2zMS8DkFZ1tDv8yr+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752796048; c=relaxed/simple;
	bh=q/MANVK5hzY8fvaA8rjFI8Uf+5tio3vjJsUxmp9oTP0=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QPKACQiMx9thGLZxJTqilXgGqcA0qKtm2BDTYx/mWRYSOPpohispozAui7e7xhso2PgXfoQFwiJKmYT0Xa0is8/OXORyktwQikm9DC7WmUJTu+sNBVENGepEfm95Shpfs5z3bqoVgmuG0Fe2UeMOvhSn76FSpx8SVu5FYPEZRtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FghGZkSL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1CB8C4CEE3;
	Thu, 17 Jul 2025 23:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752796048;
	bh=q/MANVK5hzY8fvaA8rjFI8Uf+5tio3vjJsUxmp9oTP0=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=FghGZkSLCBelKe0wqwIxBUZBVI6/uD59Ep+CbqJyNxTsLVBOfU2VRBgZsvxRJj6Qb
	 pt9N6+/NswxkzqlAdKvSR9iRMBhedmO3Q1mjUezG4TwJKC1tuRfK48yRvgdaKWMme4
	 RxFiwaFLXTm3OPBIzl9mFMS7XX6nMOgCfpjXsy+0lCwtkHQM2MEeU1/yvAlQL/AvSD
	 Jw3v5dwXNWcDGjh9wZMMAPk2ZRUGMxwxAuBBH5Vecye5ikpcGHPHeZ3QVYlv7mcvKU
	 c4wk+Ot+Kr5UdYnxBdkB3ZrP7z0CiRvv3S9Tu6yNBFO8aAb8+aHOSXay+DT5jUBEPZ
	 OXWjDD1u1P+8Q==
Date: Thu, 17 Jul 2025 16:47:28 -0700
Subject: [PATCH 08/10] fuse2fs: enable syncfs
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: joannelkoong@gmail.com, miklos@szeredi.hu, John@groves.net,
 linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, linux-ext4@vger.kernel.org,
 neal@gompa.dev
Message-ID: <175279461864.716436.8625571064879927613.stgit@frogsfrogsfrogs>
In-Reply-To: <175279461680.716436.11923939115339176158.stgit@frogsfrogsfrogs>
References: <175279461680.716436.11923939115339176158.stgit@frogsfrogsfrogs>
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
 misc/fuse2fs.c |   39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 15595fdf0b19ba..66baca72ad49d1 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -5099,6 +5099,42 @@ static int op_fallocate(const char *path EXT2FS_ATTR((unused)), int mode,
 # endif /* SUPPORT_FALLOCATE */
 #endif /* FUSE 29 */
 
+#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 18)
+static int op_syncfs(const char *path)
+{
+	struct fuse_context *ctxt = fuse_get_context();
+	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
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
 static void fuse2fs_iomap_hole(struct fuse2fs *ff, struct fuse_iomap *iomap,
 			       off_t pos, uint64_t count)
@@ -6301,6 +6337,9 @@ static struct fuse_operations fs_ops = {
 	.fallocate = op_fallocate,
 # endif
 #endif
+#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 18)
+	.syncfs = op_syncfs,
+#endif
 #ifdef HAVE_FUSE_IOMAP
 	.iomap_begin = op_iomap_begin,
 	.iomap_end = op_iomap_end,


