Return-Path: <linux-fsdevel+bounces-61653-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A687B58ABE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 03:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F0183B146E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 01:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FB21CEAD6;
	Tue, 16 Sep 2025 01:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t3UXXPsf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200CD20322;
	Tue, 16 Sep 2025 01:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984795; cv=none; b=ui3O7b7U9L3KUtMc4acaeITGLTR5EmdDqqDeFG7O7QP40gPh485Ll7rlJvpQYCs2NF81LTRDjg11j56sN3hZcWBPecfyN/o2cKGRmMMmqeNUW/uKVF9plnV3nKcl9P7uKHPI1UHcCKOruNlBd6VPa8v32YIk3484FeOpsYRG8K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984795; c=relaxed/simple;
	bh=x8bYxd4a3Uhu1HQObjNi1tYV/O3s+lYScOVJkSdBtr0=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DFqmzhfPOmqnp4Bq7IRC74gFw9EZJE9AJXgYeoOee6T2bF5JxPxc7h4TTB+pTfWmtd1lbXUXPHW5m7yOqSthN+ta8oWXSxdpRRQQUHyQLeCK8aZd25KdVB13Mnrt3ex/JW181LbIMsW/w7IU4vT9hksce5FXg7tu7opNmbBqyJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t3UXXPsf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 971C2C4CEF1;
	Tue, 16 Sep 2025 01:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757984794;
	bh=x8bYxd4a3Uhu1HQObjNi1tYV/O3s+lYScOVJkSdBtr0=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=t3UXXPsfSjb3Nn0CYCrpZhNTdrH09wPy12NGXzawd42rdEagDDG766196PGtm4tjT
	 9xnjHDL+Vci4KhUOMmJZxT71tKpubWSQJUrvSMH+4zSOy4aLSX8K5NSnYHOzf9xjbO
	 LtxGol4kTq+CpZClix3Stv3xxlnjHUCzHqjpaUW/oXgY+v+xEKADdEEdYMI3cMnbzf
	 ZlxILHRtrcepEk2xYJHt8nvnSdefcp0zJjMANZ2Urng6Z/ljGDI3pPpfsGbPvV8BPG
	 coNtVURZWjt2MOE/NuHNUq8r77BdiXIYlaj2EjWMVCaphx4O5S8Sr3AbJ4E6VsKiOI
	 vxka9ZP3x2y2A==
Date: Mon, 15 Sep 2025 18:06:34 -0700
Subject: [PATCH 2/3] fuse2fs: be smarter about caching iomaps
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, John@groves.net, bernd@bsbernd.com,
 joannelkoong@gmail.com
Message-ID: <175798162687.391696.2613145968784038322.stgit@frogsfrogsfrogs>
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

There's no point in caching iomaps when we're initiating a disk write to
an unwritten region -- we'll just replace the mapping in the ioend.
Save ourselves a bit of overhead by screening for that.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |   27 ++++++++++++++++++++++++++-
 misc/fuse2fs.c    |   24 +++++++++++++++++++++++-
 2 files changed, 49 insertions(+), 2 deletions(-)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index 6ab660b36d0472..5c563eff1c38c1 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -6309,6 +6309,31 @@ static int fuse4fs_iomap_begin_write(struct fuse4fs *ff, ext2_ino_t ino,
 	return 0;
 }
 
+static inline int fuse4fs_should_cache_iomap(struct fuse4fs *ff,
+					     uint32_t opflags,
+					     const struct fuse_file_iomap *map)
+{
+	if (!ff->iomap_cache)
+		return 0;
+
+	/* XXX I think this is stupid */
+	return 1;
+
+	/*
+	 * Don't cache small unwritten extents that are being written to the
+	 * device because the overhead of keeping the cache updated will tank
+	 * performance.
+	 */
+	if ((opflags & (FUSE_IOMAP_OP_WRITE | FUSE_IOMAP_OP_DIRECT)) == 0)
+		return 1;
+	if (map->type != FUSE_IOMAP_TYPE_UNWRITTEN)
+		return 1;
+	if (map->length >= FUSE4FS_FSB_TO_B(ff, 16))
+		return 1;
+
+	return 0;
+}
+
 static void op_iomap_begin(fuse_req_t req, fuse_ino_t fino, uint64_t dontcare,
 			   off_t pos, uint64_t count, uint32_t opflags)
 {
@@ -6379,7 +6404,7 @@ static void op_iomap_begin(fuse_req_t req, fuse_ino_t fino, uint64_t dontcare,
 	 * Cache the mapping in the kernel so that we can reuse them for
 	 * subsequent IO.
 	 */
-	if (ff->iomap_cache) {
+	if (fuse4fs_should_cache_iomap(ff, opflags, &read)) {
 		ret = fuse_lowlevel_notify_iomap_upsert(ff->fuse, fino, ino,
 							&read, NULL);
 		if (ret) {
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 14a1ceeea46a0b..7a10b6cab87f7c 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -5876,6 +5876,28 @@ static int fuse2fs_iomap_begin_write(struct fuse2fs *ff, ext2_ino_t ino,
 	return 0;
 }
 
+static inline int fuse2fs_should_cache_iomap(struct fuse2fs *ff,
+					     uint32_t opflags,
+					     const struct fuse_file_iomap *map)
+{
+	if (!ff->iomap_cache)
+		return 0;
+
+	/*
+	 * Don't cache small unwritten extents that are being written to the
+	 * device because the overhead of keeping the cache updated will tank
+	 * performance.
+	 */
+	if ((opflags & (FUSE_IOMAP_OP_WRITE | FUSE_IOMAP_OP_DIRECT)) == 0)
+		return 1;
+	if (map->type != FUSE_IOMAP_TYPE_UNWRITTEN)
+		return 1;
+	if (map->length >= FUSE2FS_FSB_TO_B(ff, 16))
+		return 1;
+
+	return 0;
+}
+
 static int op_iomap_begin(const char *path, uint64_t nodeid, uint64_t attr_ino,
 			  off_t pos, uint64_t count, uint32_t opflags,
 			  struct fuse_file_iomap *read,
@@ -5948,7 +5970,7 @@ static int op_iomap_begin(const char *path, uint64_t nodeid, uint64_t attr_ino,
 	 * Cache the mapping in the kernel so that we can reuse them for
 	 * subsequent IO.
 	 */
-	if (ff->iomap_cache) {
+	if (fuse2fs_should_cache_iomap(ff, opflags, read)) {
 		ret = fuse_fs_iomap_upsert(nodeid, attr_ino, read, NULL);
 		if (ret) {
 			ret = translate_error(fs, attr_ino, -ret);


