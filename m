Return-Path: <linux-fsdevel+bounces-58551-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D32A2B2EA84
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D22E03B2FD9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A3420C037;
	Thu, 21 Aug 2025 01:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xhgw0bar"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA21E204F99;
	Thu, 21 Aug 2025 01:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755739271; cv=none; b=VEwUc4LuS8xeiEAJGNaRRip+86BKAflX9eXsh+bYk4hlsi6CwTXZJOSHsIN1EUV5zyYhfhwTEAGDUe2nmgSMJKjJxickTXxkhpg50qMqtdGwtGiVDWdg0qS5w7kxPf3lLCFVD9QuO1ivWGnZ3vkYARrhbMu0EXkp2AjYDWCAshE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755739271; c=relaxed/simple;
	bh=xJ2P6gXO0EMec3VBZuF+ByDw07AynylRZMuKl/AjHp4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HSpc/fLoCzZloziNpqwExGQTNdTqUoEQyu6ID/jAZVDicjCVFxzlAt/3mIhjMc4z7kV4sBVa6zAVu4zUR5Or9mmsHMx2nL5CagVH9fPv8OgBXZHstdUpHLjUNYeFpxtu883Qg20kD/o9L7zLzV7tJs+DjXgadglWtI9p1irqHOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xhgw0bar; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44E05C4CEE7;
	Thu, 21 Aug 2025 01:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755739271;
	bh=xJ2P6gXO0EMec3VBZuF+ByDw07AynylRZMuKl/AjHp4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Xhgw0bark+YTTKEQr/TATFgMMM0ichutlyO/S7eKBj5Rs6mtYJHGZv+xxu3LKFYTy
	 Awf6m2kml1i+MLAmJrl+rixS70e6gam+/tGtBeCMsOcxM/RkPWst08DnDbGL2mjTDy
	 NkScZzn6V3t8EWVpZ334f4xa5DNVChA11BX8RAV9v0Hf774mxGir8AjKOk2f+X/wPc
	 1/3BzCJ4ib5ZVas17x55nyrfapwNZyymSByHsKcQMjGh5UVG+jVa6XssS/JC8PvbfF
	 LPeMqDOcrWmzZJyiWBzOoBdSjQAuLatLyLt9KrkneEz2rf3sxJD4h6OEOetqlxWIqb
	 kba7zak6h0zqQ==
Date: Wed, 20 Aug 2025 18:21:10 -0700
Subject: [PATCH 2/2] fuse2fs: be smarter about caching iomaps
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com,
 neal@gompa.dev
Message-ID: <175573714236.22718.14421501448019855274.stgit@frogsfrogsfrogs>
In-Reply-To: <175573714195.22718.16229398392414971041.stgit@frogsfrogsfrogs>
References: <175573714195.22718.16229398392414971041.stgit@frogsfrogsfrogs>
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
 misc/fuse2fs.c |   24 +++++++++++++++++++++++-
 misc/fuse4fs.c |   24 +++++++++++++++++++++++-
 2 files changed, 46 insertions(+), 2 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index da384b10bc6bc5..1b44b836484b14 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -5833,6 +5833,28 @@ static int fuse2fs_iomap_begin_write(struct fuse2fs *ff, ext2_ino_t ino,
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
@@ -5905,7 +5927,7 @@ static int op_iomap_begin(const char *path, uint64_t nodeid, uint64_t attr_ino,
 	 * Cache the mapping in the kernel so that we can reuse them for
 	 * subsequent IO.
 	 */
-	if (ff->iomap_cache) {
+	if (fuse2fs_should_cache_iomap(ff, opflags, read)) {
 		ret = fuse_fs_iomap_upsert(nodeid, attr_ino, read, NULL);
 		if (ret) {
 			ret = translate_error(fs, attr_ino, -ret);
diff --git a/misc/fuse4fs.c b/misc/fuse4fs.c
index a2601b5ca94970..df8da745fcd7c7 100644
--- a/misc/fuse4fs.c
+++ b/misc/fuse4fs.c
@@ -6159,6 +6159,28 @@ static int fuse4fs_iomap_begin_write(struct fuse4fs *ff, ext2_ino_t ino,
 	return 0;
 }
 
+static inline int fuse4fs_should_cache_iomap(struct fuse4fs *ff,
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
+	if (map->length >= FUSE4FS_FSB_TO_B(ff, 16))
+		return 1;
+
+	return 0;
+}
+
 static void op_iomap_begin(fuse_req_t req, fuse_ino_t fino, uint64_t dontcare,
 			   off_t pos, uint64_t count, uint32_t opflags)
 {
@@ -6229,7 +6251,7 @@ static void op_iomap_begin(fuse_req_t req, fuse_ino_t fino, uint64_t dontcare,
 	 * Cache the mapping in the kernel so that we can reuse them for
 	 * subsequent IO.
 	 */
-	if (ff->iomap_cache) {
+	if (fuse4fs_should_cache_iomap(ff, opflags, &read)) {
 		ret = fuse_lowlevel_notify_iomap_upsert(ff->fuse, fino, ino,
 							&read, NULL);
 		if (ret) {


