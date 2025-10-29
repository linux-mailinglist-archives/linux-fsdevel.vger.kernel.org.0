Return-Path: <linux-fsdevel+bounces-66124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F49FC17D3E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A3693B20DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1614288C3D;
	Wed, 29 Oct 2025 01:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SgcrHySB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59578EEBB;
	Wed, 29 Oct 2025 01:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700607; cv=none; b=rGQ6a9beAlSOPXNxfZ3BGNOyno16RfOLNSA+L2NfbtD31pNLNcg40v9qhh36fLeVB/OZtlE4wyKVTl2h26eDoXwtna4uVf2byt3HB3RJSDUBM4swfLhK47EpRJdpKpqZRuJtrOogi1kD4lqj7uqhsOTr6v72GYwXSUmRtGkHb5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700607; c=relaxed/simple;
	bh=MIOZCPHpXYu63o7DnWnNozuvn/LdwUr01+UF6dgNSDM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hbAdKDieHgtkwGytQTBUFtbMt75idbGx5+VSuCgpwdrUn//AFrUAN79k00t1gVad3c9UBgh6PeLKc45vrpbwyBRqe5mjzJ0RiYYITbkykpxjlW7XWif7g/6n6wTU6rN0X0JTt881Az//884qY0v3hiL1tyHG1WcJX9hgPDPC++w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SgcrHySB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31855C4CEE7;
	Wed, 29 Oct 2025 01:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761700607;
	bh=MIOZCPHpXYu63o7DnWnNozuvn/LdwUr01+UF6dgNSDM=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=SgcrHySBe92AQUgzkFaM2c1s31zxVF33Z8Czo/chOdFS4zvIZ68F2XxZxecOYhqBv
	 JN1yuw+yW5plaBh0FBWMtVqUggjLPvab+Q66NJiTCNA2cbToQKqtCFtQpSw72+CRbv
	 u7fS3cilWjx/0paRTqJZxRt7xPGl1jvM8cqNtvydBu865z6PALZ9MCmTb+LCncevvv
	 8ag0o8iaFvlBg2Ttx+AVScZ/LTU3THv5dXhUUmcbWPblFkYNt5f1eYdDLKsrDd0oW0
	 AjC6+G+v9FeNuhb3Ptntw+gHQ2KAP5x3Y4ySpvowHO6D0+EXFqWNo7oyZXevJ8lw0c
	 8U9r1HDggBHvA==
Date: Tue, 28 Oct 2025 18:16:46 -0700
Subject: [PATCH 2/3] fuse2fs: be smarter about caching iomaps
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com,
 neal@gompa.dev, miklos@szeredi.hu, linux-ext4@vger.kernel.org
Message-ID: <176169818593.1430840.2583293528545393648.stgit@frogsfrogsfrogs>
In-Reply-To: <176169818545.1430840.7420840378591574460.stgit@frogsfrogsfrogs>
References: <176169818545.1430840.7420840378591574460.stgit@frogsfrogsfrogs>
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
index 438a9030e3da27..5e2ced05dc5071 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -6822,6 +6822,31 @@ static int fuse4fs_iomap_begin_write(struct fuse4fs *ff, ext2_ino_t ino,
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
@@ -6892,7 +6917,7 @@ static void op_iomap_begin(fuse_req_t req, fuse_ino_t fino, uint64_t dontcare,
 	 * Cache the mapping in the kernel so that we can reuse them for
 	 * subsequent IO.
 	 */
-	if (ff->iomap_cache) {
+	if (fuse4fs_should_cache_iomap(ff, opflags, &read)) {
 		ret = fuse_lowlevel_notify_iomap_upsert(ff->fuse, fino, ino,
 							&read, NULL);
 		if (ret) {
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index ff32a429179915..7410059305fe24 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -6374,6 +6374,28 @@ static int fuse2fs_iomap_begin_write(struct fuse2fs *ff, ext2_ino_t ino,
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
@@ -6446,7 +6468,7 @@ static int op_iomap_begin(const char *path, uint64_t nodeid, uint64_t attr_ino,
 	 * Cache the mapping in the kernel so that we can reuse them for
 	 * subsequent IO.
 	 */
-	if (ff->iomap_cache) {
+	if (fuse2fs_should_cache_iomap(ff, opflags, read)) {
 		ret = fuse_fs_iomap_upsert(nodeid, attr_ino, read, NULL);
 		if (ret) {
 			ret = translate_error(fs, attr_ino, -ret);


