Return-Path: <linux-fsdevel+bounces-78164-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJDUFCnlnGlNMAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78164-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:39:21 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E95817FB30
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9EE093015B57
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343FF37FF57;
	Mon, 23 Feb 2026 23:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AfKEBztb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20C91A256E;
	Mon, 23 Feb 2026 23:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771889952; cv=none; b=BIWjFPRAgf0atMBwwuiAPlHS+LQAX+RggxEs/fLEK4ULNfy2nIDgjEaY/VA8RUHYVBqq4HvWDrDPcNoKJ3oL9hYrPCm8PvuufsX1feBcFKhBapt+xghTCzcM0Jos2mNGSIikR1JaecMUwR+E6lqX5QT8l2YgNY16OjjVI/fZS0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771889952; c=relaxed/simple;
	bh=0VeGmW1sfuspXC1u3yO5UEhgpz4Bh54SrQHHFfgfmxM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RUF08e64wsZbyuu4mQS7/ZPSAEIrZJ1oxuz1hrna7lIPx2JUvanAAAEwlu6Wcr4wnvRtHKIM5CUUHBn59MzNzejsWzRfmkBe/eYeNp9pS/j8wFRQgBhAcZyKcfC4hzJ2GfMSW7t3JjvrO8Uz7qVRZxMH07S9lMMEfZ6uqmxspM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AfKEBztb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6136DC116C6;
	Mon, 23 Feb 2026 23:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771889952;
	bh=0VeGmW1sfuspXC1u3yO5UEhgpz4Bh54SrQHHFfgfmxM=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=AfKEBztbDdwp3ymb3ZFB/CrTuyOw+pOrS+ICq4n1cL5rr4kPCgWGLaud5q4qMSJ7g
	 gCS2aYJyQNlKSlqMDI/i1i301y4PKYU2KaAFDLs8CxFCC40ek9kNIEMUMU9eebfMNS
	 AZGN5GiTwvAY4pFHTvUi+mNmHg1ia3cV0uDQ3pkYdjmRYFJWi5URCT+GkoLJvazDa/
	 /yQHyCr+UnWXWCtcDJfWrIUmK/1yAWFUtUSqJjeneepe4v1ffDaPGxPCYZqCj+T/EP
	 DJ5elUvemlP4DTykZPI2WdIt406mj5fL8lD6LnmYSTweHUQBKjvBtzcT3B8wQHgj03
	 hkJFKKxRdG/eA==
Date: Mon, 23 Feb 2026 15:39:11 -0800
Subject: [PATCH 12/19] fuse2fs: enable file IO to inline data files
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, bernd@bsbernd.com,
 joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177188744697.3943178.4106268360256891363.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,szeredi.hu,bsbernd.com,gmail.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78164-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3E95817FB30
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Enable file reads and writes from inline data files.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |    3 ++-
 misc/fuse2fs.c    |   42 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 42 insertions(+), 3 deletions(-)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index 58a67252b7b613..59c8d7de7e4533 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -6344,7 +6344,8 @@ static int fuse4fs_iomap_begin_read(struct fuse4fs *ff, ext2_ino_t ino,
 {
 	/* fall back to slow path for inline data reads */
 	if (inode->i_flags & EXT4_INLINE_DATA_FL)
-		return -ENOSYS;
+		return fuse4fs_iomap_begin_inline(ff, ino, inode, pos, count,
+						  read);
 
 	if (inode->i_flags & EXT4_EXTENTS_FL)
 		return fuse4fs_iomap_begin_extent(ff, ino, inode, pos, count,
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 8079ace3d30e3f..5651b9633c5bb6 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -1837,7 +1837,16 @@ static void *op_init(struct fuse_conn_info *conn,
 	cfg->use_ino = 1;
 	if (ff->debug)
 		cfg->debug = 1;
-	cfg->nullpath_ok = 1;
+
+	/*
+	 * Inline data file io depends on op_read/write being fed a path, so we
+	 * have to slow everyone down to look up the path from the nodeid.
+	 */
+	if (fuse2fs_iomap_enabled(ff) &&
+	    ext2fs_has_feature_inline_data(ff->fs->super))
+		cfg->nullpath_ok = 0;
+	else
+		cfg->nullpath_ok = 1;
 
 	fuse2fs_detach_losetup(ff);
 
@@ -3831,6 +3840,9 @@ static int op_read(const char *path EXT2FS_ATTR((unused)), char *buf,
 		   size_t len, off_t offset,
 		   struct fuse_file_info *fp)
 {
+	struct fuse2fs_file_handle fhurk = {
+		.magic = FUSE2FS_FILE_MAGIC,
+	};
 	struct fuse2fs *ff = fuse2fs_get();
 	struct fuse2fs_file_handle *fh = fuse2fs_get_handle(fp);
 	ext2_filsys fs;
@@ -3840,10 +3852,21 @@ static int op_read(const char *path EXT2FS_ATTR((unused)), char *buf,
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
+
+	if (!fh)
+		fh = &fhurk;
+
 	FUSE2FS_CHECK_HANDLE(ff, fh);
 	dbg_printf(ff, "%s: ino=%d off=0x%llx len=0x%zx\n", __func__, fh->ino,
 		   (unsigned long long)offset, len);
 	fs = fuse2fs_start(ff);
+
+	if (fh == &fhurk) {
+		ret = fuse2fs_file_ino(ff, path, NULL, &fhurk.ino);
+		if (ret)
+			goto out;
+	}
+
 	err = ext2fs_file_open(fs, fh->ino, fh->open_flags, &efp);
 	if (err) {
 		ret = translate_error(fs, fh->ino, err);
@@ -3885,6 +3908,10 @@ static int op_write(const char *path EXT2FS_ATTR((unused)),
 		    const char *buf, size_t len, off_t offset,
 		    struct fuse_file_info *fp)
 {
+	struct fuse2fs_file_handle fhurk = {
+		.magic = FUSE2FS_FILE_MAGIC,
+		.open_flags = EXT2_FILE_WRITE,
+	};
 	struct fuse2fs *ff = fuse2fs_get();
 	struct fuse2fs_file_handle *fh = fuse2fs_get_handle(fp);
 	ext2_filsys fs;
@@ -3894,6 +3921,10 @@ static int op_write(const char *path EXT2FS_ATTR((unused)),
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
+
+	if (!fh)
+		fh = &fhurk;
+
 	FUSE2FS_CHECK_HANDLE(ff, fh);
 	dbg_printf(ff, "%s: ino=%d off=0x%llx len=0x%zx\n", __func__, fh->ino,
 		   (unsigned long long) offset, len);
@@ -3908,6 +3939,12 @@ static int op_write(const char *path EXT2FS_ATTR((unused)),
 		goto out;
 	}
 
+	if (fh == &fhurk) {
+		ret = fuse2fs_file_ino(ff, path, NULL, &fhurk.ino);
+		if (ret)
+			goto out;
+	}
+
 	err = ext2fs_file_open(fs, fh->ino, fh->open_flags, &efp);
 	if (err) {
 		ret = translate_error(fs, fh->ino, err);
@@ -5851,7 +5888,8 @@ static int fuse2fs_iomap_begin_read(struct fuse2fs *ff, ext2_ino_t ino,
 {
 	/* fall back to slow path for inline data reads */
 	if (inode->i_flags & EXT4_INLINE_DATA_FL)
-		return -ENOSYS;
+		return fuse2fs_iomap_begin_inline(ff, ino, inode, pos, count,
+						  read);
 
 	if (inode->i_flags & EXT4_EXTENTS_FL)
 		return fuse2fs_iomap_begin_extent(ff, ino, inode, pos, count,


