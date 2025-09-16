Return-Path: <linux-fsdevel+bounces-61652-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0541EB58ABA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 03:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26B2F524518
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 01:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22B41C8621;
	Tue, 16 Sep 2025 01:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XhRKSbeb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3AE20322;
	Tue, 16 Sep 2025 01:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984779; cv=none; b=h5MJIgWXYy6xO0ZZa42QFJ2b50LnvHKRe6A1smp/EYQiTUbx96sQvaa+zCuwTj0hHnSzuLAnsaLBS7BE4if7nMEk1Gb+Enix91XjFCuusGqSc9PH+Qbwo17/MT+ft/D94LNRc8UOYKKtjJ/mNg+dL2DmnSEeORnQnKdsp/sW7zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984779; c=relaxed/simple;
	bh=SfisLtPJTikbiTB4bPEd7BX7Pmk38DH8RDPMGRz3gwE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m6REQiUl1Xg5yEHD1+9HZc+h4V99ymNHVKch2P2g2sIeXQ7dSdZz5FwB4sdXU/N0TfwjgYSKitD6Fmb1el1pzDfi10Aw024/tnYVekiuthmOVJrrm+wFVCTZW6cWfduocOCGhqH/Y6/nF7oUNTdgJX172WupwVBYtqGkgipmF4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XhRKSbeb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0381CC4CEF1;
	Tue, 16 Sep 2025 01:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757984779;
	bh=SfisLtPJTikbiTB4bPEd7BX7Pmk38DH8RDPMGRz3gwE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=XhRKSbeb43b8SknKqj++e4XuOI2WMHU09jrrxUcFnNuIPno32Vpfz6gP7rbkuRavh
	 oHsM2lTUGX+n5Z5+MC+I1XiwE5xakUH8QEJQK8Ss9K0/0ZnjlsgVYCkbyI+S+5TLxC
	 9JwddlL3Q89WAj2cB0GiGwjO3/RLcsl603cnhoYaUgekLX9rksoWLh/MVBFbl2EuzY
	 GHzs7Iy7PzRBSwkk9HQtLk+BucW8n3/3w44a7zG3KTXgKFnVDVtM26w4F/4mjpwb+H
	 2EtAyWfnJa2F69vXUKKa6zKdgUKQj27xgJWZUSxPFxZGg9ifFMVpE7fXE/vZiknMNw
	 lTUiVEdiBgjBw==
Date: Mon, 15 Sep 2025 18:06:18 -0700
Subject: [PATCH 1/3] fuse2fs: enable caching of iomaps
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, John@groves.net, bernd@bsbernd.com,
 joannelkoong@gmail.com
Message-ID: <175798162669.391696.2292027654285998318.stgit@frogsfrogsfrogs>
In-Reply-To: <175798162643.391696.6878173028466397793.stgit@frogsfrogsfrogs>
References: <175798162643.391696.6878173028466397793.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Cache the iomaps we generate in the kernel for better performance.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |   25 +++++++++++++++++++++++++
 misc/fuse2fs.c    |   24 ++++++++++++++++++++++++
 2 files changed, 49 insertions(+)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index a7709a7e6fb699..6ab660b36d0472 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -284,6 +284,8 @@ struct fuse4fs {
 #ifdef STATX_WRITE_ATOMIC
 	unsigned int awu_min, awu_max;
 #endif
+	/* options set by fuse_opt_parse must be of type int */
+	int iomap_cache;
 #endif
 	unsigned int blockmask;
 	unsigned long offset;
@@ -6373,6 +6375,24 @@ static void op_iomap_begin(fuse_req_t req, fuse_ino_t fino, uint64_t dontcare,
 	if (opflags & FUSE_IOMAP_OP_ATOMIC)
 		read.flags |= FUSE_IOMAP_F_ATOMIC_BIO;
 
+	/*
+	 * Cache the mapping in the kernel so that we can reuse them for
+	 * subsequent IO.
+	 */
+	if (ff->iomap_cache) {
+		ret = fuse_lowlevel_notify_iomap_upsert(ff->fuse, fino, ino,
+							&read, NULL);
+		if (ret) {
+			ret = translate_error(fs, ino, -ret);
+			goto out_unlock;
+		} else {
+			/* Tell the kernel to retry from cache */
+			read.type = FUSE_IOMAP_TYPE_RETRY_CACHE;
+			read.dev = FUSE_IOMAP_DEV_NULL;
+			read.addr = FUSE_IOMAP_NULL_ADDR;
+		}
+	}
+
 out_unlock:
 	fuse4fs_finish(ff, ret);
 	if (ret)
@@ -7183,6 +7203,10 @@ static struct fuse_opt fuse4fs_opts[] = {
 	FUSE4FS_OPT("timing",		timing,			1),
 #endif
 	FUSE4FS_OPT("noblkdev",		noblkdev,		1),
+#ifdef HAVE_FUSE_IOMAP
+	FUSE4FS_OPT("iomap_cache",	iomap_cache,		1),
+	FUSE4FS_OPT("noiomap_cache",	iomap_cache,		0),
+#endif
 
 #ifdef HAVE_FUSE_IOMAP
 #ifdef MS_LAZYTIME
@@ -7517,6 +7541,7 @@ int main(int argc, char *argv[])
 		.iomap_want = FT_DEFAULT,
 		.iomap_state = IOMAP_UNKNOWN,
 		.iomap_dev = FUSE_IOMAP_DEV_NULL,
+		.iomap_cache = 1,
 #endif
 		.translate_inums = 1,
 		.write_gdt_on_destroy = 1,
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 260d1b77e3f24b..14a1ceeea46a0b 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -277,6 +277,8 @@ struct fuse2fs {
 #ifdef STATX_WRITE_ATOMIC
 	unsigned int awu_min, awu_max;
 #endif
+	/* options set by fuse_opt_parse must be of type int */
+	int iomap_cache;
 #endif
 	unsigned int blockmask;
 	unsigned long offset;
@@ -5942,6 +5944,23 @@ static int op_iomap_begin(const char *path, uint64_t nodeid, uint64_t attr_ino,
 	if (opflags & FUSE_IOMAP_OP_ATOMIC)
 		read->flags |= FUSE_IOMAP_F_ATOMIC_BIO;
 
+	/*
+	 * Cache the mapping in the kernel so that we can reuse them for
+	 * subsequent IO.
+	 */
+	if (ff->iomap_cache) {
+		ret = fuse_fs_iomap_upsert(nodeid, attr_ino, read, NULL);
+		if (ret) {
+			ret = translate_error(fs, attr_ino, -ret);
+			goto out_unlock;
+		} else {
+			/* Tell the kernel to retry from cache */
+			read->type = FUSE_IOMAP_TYPE_RETRY_CACHE;
+			read->dev = FUSE_IOMAP_DEV_NULL;
+			read->addr = FUSE_IOMAP_NULL_ADDR;
+		}
+	}
+
 out_unlock:
 	fuse2fs_finish(ff, ret);
 	return ret;
@@ -6744,6 +6763,10 @@ static struct fuse_opt fuse2fs_opts[] = {
 	FUSE2FS_OPT("timing",		timing,			1),
 #endif
 	FUSE2FS_OPT("noblkdev",		noblkdev,		1),
+#ifdef HAVE_FUSE_IOMAP
+	FUSE2FS_OPT("iomap_cache",	iomap_cache,		1),
+	FUSE2FS_OPT("noiomap_cache",	iomap_cache,		0),
+#endif
 
 #ifdef HAVE_FUSE_IOMAP
 #ifdef MS_LAZYTIME
@@ -6978,6 +7001,7 @@ int main(int argc, char *argv[])
 		.iomap_want = FT_DEFAULT,
 		.iomap_state = IOMAP_UNKNOWN,
 		.iomap_dev = FUSE_IOMAP_DEV_NULL,
+		.iomap_cache = 1,
 #endif
 		.write_gdt_on_destroy = 1,
 	};


