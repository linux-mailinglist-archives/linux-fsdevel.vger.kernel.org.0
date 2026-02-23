Return-Path: <linux-fsdevel+bounces-78160-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aO/mArvlnGlNMAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78160-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:41:47 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5784617FC40
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2D3F4304938C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20A037FF42;
	Mon, 23 Feb 2026 23:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/BM649s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA4534CFBA;
	Mon, 23 Feb 2026 23:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771889890; cv=none; b=O+v1nRZSVFLpLYgsUlYOQQZL2BiW0cHf7BCd665VSpMrBMeAESIOTSltvTnpVfyHu/YBtkgSjmt1/iNB7v3wMji3dxcOZnAYwq5NsldtOoFLiranSoomrfsCrDI/eoJlEn055gOEx+JQIbnkOQOwlrHCrUlomc/zhrb6lR9LJKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771889890; c=relaxed/simple;
	bh=r/8/hmWCfICII6PXRLNvDboa8JSybXCaHYap56MvkvA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HzcP0rog492NNaXSJR8A5khzLMbcGo8AdMXyBtIkHfNXmgqYCLnEV/n/JzQPpDksUoNuLili5hgxDy2NgwELizIwMKbthHr8zuxVtGtWB0GIJO97nQJG9n9fvnELmjEpWFTw5JC3ADUw319yPL8ZQ+pu8YdCxtqtiwvWx26jE3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/BM649s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDBBEC116C6;
	Mon, 23 Feb 2026 23:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771889889;
	bh=r/8/hmWCfICII6PXRLNvDboa8JSybXCaHYap56MvkvA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=D/BM649sTAN5WAVdwgOgoYm60k6BMTL/wiiXQtmGgcWruuh5n8pl3BAORtsGaLc+Y
	 Ym9kHRBJhKDRDNJX9M7R033IYcYt0k7MBJGEtseaZHcGFdll7kmh4AN9xK0M+svG1a
	 bxykOgtLi8RGivxINtLZosD5vVSnC24DThagZVYcETkmMExyUMDw0glhV0btYPFqsi
	 siaBITa4BpjHM6CPvDXO5xEd8jfalfE01rqhawf6JKHGWSw7waMqua29CpDKpCMgcr
	 EtEFjV8m15v5URIMqWtXL+TDUFxOnD+YmJYGB4iqGcSew3Xugz2TPNVFxhoHbOaLgs
	 JA7KYqi6g0kqA==
Date: Mon, 23 Feb 2026 15:38:09 -0800
Subject: [PATCH 08/19] fuse2fs: turn on iomap for pagecache IO
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, bernd@bsbernd.com,
 joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177188744624.3943178.6359732464892057979.stgit@frogsfrogsfrogs>
In-Reply-To: <177188744403.3943178.7675407203918355137.stgit@frogsfrogsfrogs>
References: <177188744403.3943178.7675407203918355137.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,szeredi.hu,bsbernd.com,gmail.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78160-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5784617FC40
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Turn on iomap for pagecache IO to regular files.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |   61 +++++++++++++++++++++++++++++++++++++++++++++++------
 misc/fuse2fs.c    |   61 +++++++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 108 insertions(+), 14 deletions(-)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index 2f95a1ecbfa330..39737c72e6133f 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -6219,9 +6219,6 @@ static int fuse4fs_iomap_begin_read(struct fuse4fs *ff, ext2_ino_t ino,
 				    uint64_t count, uint32_t opflags,
 				    struct fuse_file_iomap *read)
 {
-	if (!(opflags & FUSE_IOMAP_OP_DIRECT))
-		return -ENOSYS;
-
 	/* fall back to slow path for inline data reads */
 	if (inode->i_flags & EXT4_INLINE_DATA_FL)
 		return -ENOSYS;
@@ -6312,9 +6309,6 @@ static int fuse4fs_iomap_begin_write(struct fuse4fs *ff, ext2_ino_t ino,
 	off_t max_size = fuse4fs_max_file_size(ff, inode);
 	int ret;
 
-	if (!(opflags & FUSE_IOMAP_OP_DIRECT))
-		return -ENOSYS;
-
 	if (pos >= max_size)
 		return -EFBIG;
 
@@ -6410,12 +6404,51 @@ static void op_iomap_begin(fuse_req_t req, fuse_ino_t fino, uint64_t dontcare,
 		fuse_reply_iomap_begin(req, &read, NULL);
 }
 
+static int fuse4fs_iomap_append_setsize(struct fuse4fs *ff, ext2_ino_t ino,
+					loff_t newsize)
+{
+	ext2_filsys fs = ff->fs;
+	struct ext2_inode_large inode;
+	ext2_off64_t isize;
+	errcode_t err;
+
+	dbg_printf(ff, "%s: ino=%u newsize=%llu\n", __func__, ino,
+		   (unsigned long long)newsize);
+
+	err = fuse4fs_read_inode(fs, ino, &inode);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	isize = EXT2_I_SIZE(&inode);
+	if (newsize <= isize)
+		return 0;
+
+	dbg_printf(ff, "%s: ino=%u oldsize=%llu newsize=%llu\n", __func__, ino,
+		   (unsigned long long)isize,
+		   (unsigned long long)newsize);
+
+	/*
+	 * XXX cheesily update the ondisk size even though we only want to do
+	 * the incore size until writeback happens
+	 */
+	err = ext2fs_inode_size_set(fs, EXT2_INODE(&inode), newsize);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	err = fuse4fs_write_inode(fs, ino, &inode);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	return 0;
+}
+
 static void op_iomap_end(fuse_req_t req, fuse_ino_t fino, uint64_t dontcare,
 			 off_t pos, uint64_t count, uint32_t opflags,
 			 ssize_t written, const struct fuse_file_iomap *iomap)
 {
 	struct fuse4fs *ff = fuse4fs_get(req);
 	ext2_ino_t ino;
+	int ret = 0;
 
 	FUSE4FS_CHECK_CONTEXT(req);
 	FUSE4FS_CONVERT_FINO(req, &ino, fino);
@@ -6429,7 +6462,21 @@ static void op_iomap_end(fuse_req_t req, fuse_ino_t fino, uint64_t dontcare,
 		   written,
 		   iomap->flags);
 
-	fuse_reply_err(req, 0);
+	fuse4fs_start(ff);
+
+	/* XXX is this really necessary? */
+	if ((opflags & FUSE_IOMAP_OP_WRITE) &&
+	    !(opflags & FUSE_IOMAP_OP_DIRECT) &&
+	    (iomap->flags & FUSE_IOMAP_F_SIZE_CHANGED) &&
+	    written > 0) {
+		ret = fuse4fs_iomap_append_setsize(ff, ino, pos + written);
+		if (ret)
+			goto out_unlock;
+	}
+
+out_unlock:
+	fuse4fs_finish(ff, ret);
+	fuse_reply_err(req, -ret);
 }
 
 /*
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 4b64a37aa0e029..afb50a7e498694 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -5665,9 +5665,6 @@ static int fuse2fs_iomap_begin_read(struct fuse2fs *ff, ext2_ino_t ino,
 				    uint64_t count, uint32_t opflags,
 				    struct fuse_file_iomap *read)
 {
-	if (!(opflags & FUSE_IOMAP_OP_DIRECT))
-		return -ENOSYS;
-
 	/* fall back to slow path for inline data reads */
 	if (inode->i_flags & EXT4_INLINE_DATA_FL)
 		return -ENOSYS;
@@ -5755,9 +5752,6 @@ static int fuse2fs_iomap_begin_write(struct fuse2fs *ff, ext2_ino_t ino,
 	off_t max_size = fuse2fs_max_file_size(ff, inode);
 	int ret;
 
-	if (!(opflags & FUSE_IOMAP_OP_DIRECT))
-		return -ENOSYS;
-
 	if (pos >= max_size)
 		return -EFBIG;
 
@@ -5852,11 +5846,50 @@ static int op_iomap_begin(const char *path, uint64_t nodeid, uint64_t attr_ino,
 	return ret;
 }
 
+static int fuse2fs_iomap_append_setsize(struct fuse2fs *ff, ext2_ino_t ino,
+					loff_t newsize)
+{
+	ext2_filsys fs = ff->fs;
+	struct ext2_inode_large inode;
+	ext2_off64_t isize;
+	errcode_t err;
+
+	dbg_printf(ff, "%s: ino=%u newsize=%llu\n", __func__, ino,
+		   (unsigned long long)newsize);
+
+	err = fuse2fs_read_inode(fs, ino, &inode);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	isize = EXT2_I_SIZE(&inode);
+	if (newsize <= isize)
+		return 0;
+
+	dbg_printf(ff, "%s: ino=%u oldsize=%llu newsize=%llu\n", __func__, ino,
+		   (unsigned long long)isize,
+		   (unsigned long long)newsize);
+
+	/*
+	 * XXX cheesily update the ondisk size even though we only want to do
+	 * the incore size until writeback happens
+	 */
+	err = ext2fs_inode_size_set(fs, EXT2_INODE(&inode), newsize);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	err = fuse2fs_write_inode(fs, ino, &inode);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	return 0;
+}
+
 static int op_iomap_end(const char *path, uint64_t nodeid, uint64_t attr_ino,
 			off_t pos, uint64_t count, uint32_t opflags,
 			ssize_t written, const struct fuse_file_iomap *iomap)
 {
 	struct fuse2fs *ff = fuse2fs_get();
+	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
 
@@ -5871,7 +5904,21 @@ static int op_iomap_end(const char *path, uint64_t nodeid, uint64_t attr_ino,
 		   written,
 		   iomap->flags);
 
-	return 0;
+	fuse2fs_start(ff);
+
+	/* XXX is this really necessary? */
+	if ((opflags & FUSE_IOMAP_OP_WRITE) &&
+	    !(opflags & FUSE_IOMAP_OP_DIRECT) &&
+	    (iomap->flags & FUSE_IOMAP_F_SIZE_CHANGED) &&
+	    written > 0) {
+		ret = fuse2fs_iomap_append_setsize(ff, attr_ino, pos + written);
+		if (ret)
+			goto out_unlock;
+	}
+
+out_unlock:
+	fuse2fs_finish(ff, ret);
+	return ret;
 }
 
 /*


