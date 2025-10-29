Return-Path: <linux-fsdevel+bounces-66107-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2742CC17CC5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92C661A2460D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6C82D8DDD;
	Wed, 29 Oct 2025 01:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCOoq6Zj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4ED1A7264;
	Wed, 29 Oct 2025 01:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700341; cv=none; b=sehCkbplq3mdKutBGIbpdDbja5S1epEFiLo6NXP9aPrzDoY/FuSy9Il5D1c+erbVxnKyOqunRUcfv+6u/hkuxaa4fa9MTYuR0q8cq91NoanvlwEyi7yL8p/qsE4iepjtKdlJfDXQ/abCO4txBc8EGjU3B7NOk9T+oyG/Xd5GHHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700341; c=relaxed/simple;
	bh=pyUpbzkHm8YkHCP2c1wzKAlb/27inAPDu8QE9YJpDBc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SQXOtCb+L6acBsWlmlV8o1LRtP8BRBpK3IsV+tz01gu5Irjpio7tRrN+KNnZ0qmTwa1EghdtQm/ObCYeBG8ffYtPf7VcqQmM/Xj6qwWXwJLZOo/w8GUYsXTUHREL7CVNAvTqfAR0mR622Q28cQHj1DBH1iECrnTzhiD5unNIQeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCOoq6Zj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF330C4CEE7;
	Wed, 29 Oct 2025 01:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761700341;
	bh=pyUpbzkHm8YkHCP2c1wzKAlb/27inAPDu8QE9YJpDBc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=DCOoq6ZjNZY3qidbf11e3TOlUyYEnMFUbuN5UuqVF9afwA54W23n1sMBBifaWXW+k
	 0yX2zjicpZF9IKPk54BA47MVr98jmCjVi9o4RPCFndZmVmtafYDAlik0IPwj770FAV
	 b7FrUKMXLPSBH13eG4f6yPXzyiDA+m9t1967ESqxd5/d6PK4KdaiCB5N6hMeyGocyJ
	 lQhmrwD4ubCrVj+i9ELEXSjZTHhYcvAae2DbMdvrrNRrhldwvxBBG1qZ5TfdRrtfgo
	 OYRbIZ6ndMrnNXHBGESDANM4EI1uml3hwNdk9xeGBtcaLMI51/97k2bUIoOHDZDPPW
	 2MKyF+muPGpAQ==
Date: Tue, 28 Oct 2025 18:12:20 -0700
Subject: [PATCH 15/17] fuse4fs: separate invalidation
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com,
 neal@gompa.dev, miklos@szeredi.hu, linux-ext4@vger.kernel.org
Message-ID: <176169817837.1429568.4882681255799457147.stgit@frogsfrogsfrogs>
In-Reply-To: <176169817482.1429568.16747148621305977151.stgit@frogsfrogsfrogs>
References: <176169817482.1429568.16747148621305977151.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Use the new stuff

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |   61 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 misc/fuse2fs.c    |   60 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 121 insertions(+)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index 49b895dfbcc35b..5e66b7103f57f3 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -281,6 +281,9 @@ struct fuse4fs {
 	enum fuse4fs_iomap_state iomap_state;
 	uint32_t iomap_dev;
 	uint64_t iomap_cap;
+	void (*old_alloc_stats)(ext2_filsys fs, blk64_t blk, int inuse);
+	void (*old_alloc_stats_range)(ext2_filsys fs, blk64_t blk, blk_t num,
+				      int inuse);
 #endif
 	unsigned int blockmask;
 	unsigned long offset;
@@ -6720,6 +6723,51 @@ static int fuse4fs_iomap_config_devices(struct fuse4fs *ff)
 	return 0;
 }
 
+static void fuse4fs_invalidate_bdev(struct fuse4fs *ff, blk64_t blk, blk_t num)
+{
+	off_t offset = FUSE4FS_FSB_TO_B(ff, blk);
+	off_t length = FUSE4FS_FSB_TO_B(ff, num);
+	int ret;
+
+	ret = fuse_lowlevel_iomap_device_invalidate(ff->fuse, ff->iomap_dev,
+						    offset, length);
+	if (!ret)
+		return;
+
+	if (num == 1)
+		err_printf(ff, "%s %llu: %s\n",
+			   _("error invalidating block"),
+			   (unsigned long long)blk,
+			   strerror(ret));
+	else
+		err_printf(ff, "%s %llu-%llu: %s\n",
+			   _("error invalidating blocks"),
+			   (unsigned long long)blk,
+			   (unsigned long long)blk + num - 1,
+			   strerror(ret));
+}
+
+static void fuse4fs_alloc_stats(ext2_filsys fs, blk64_t blk, int inuse)
+{
+	struct fuse4fs *ff = fs->priv_data;
+
+	if (inuse < 0)
+		fuse4fs_invalidate_bdev(ff, blk, 1);
+	if (ff->old_alloc_stats)
+		ff->old_alloc_stats(fs, blk, inuse);
+}
+
+static void fuse4fs_alloc_stats_range(ext2_filsys fs, blk64_t blk, blk_t num,
+				      int inuse)
+{
+	struct fuse4fs *ff = fs->priv_data;
+
+	if (inuse < 0)
+		fuse4fs_invalidate_bdev(ff, blk, num);
+	if (ff->old_alloc_stats_range)
+		ff->old_alloc_stats_range(fs, blk, num, inuse);
+}
+
 static void op_iomap_config(fuse_req_t req, uint64_t flags, uint64_t maxbytes)
 {
 	struct fuse_iomap_config cfg = { };
@@ -6764,6 +6812,19 @@ static void op_iomap_config(fuse_req_t req, uint64_t flags, uint64_t maxbytes)
 	if (ret)
 		goto out_unlock;
 
+	/*
+	 * If we let iomap do all file block IO, then we need to watch for
+	 * freed blocks so that we can invalidate any page cache that might
+	 * get written to the block deivce.
+	 */
+	if (fuse4fs_iomap_enabled(ff)) {
+		ext2fs_set_block_alloc_stats_callback(ff->fs,
+				fuse4fs_alloc_stats, &ff->old_alloc_stats);
+		ext2fs_set_block_alloc_stats_range_callback(ff->fs,
+				fuse4fs_alloc_stats_range,
+				&ff->old_alloc_stats_range);
+	}
+
 out_unlock:
 	fuse4fs_finish(ff, ret);
 	if (ret)
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 20201265916960..255f8d4b7ae652 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -275,6 +275,9 @@ struct fuse2fs {
 	enum fuse2fs_iomap_state iomap_state;
 	uint32_t iomap_dev;
 	uint64_t iomap_cap;
+	void (*old_alloc_stats)(ext2_filsys fs, blk64_t blk, int inuse);
+	void (*old_alloc_stats_range)(ext2_filsys fs, blk64_t blk, blk_t num,
+				      int inuse);
 #endif
 	unsigned int blockmask;
 	unsigned long offset;
@@ -6253,6 +6256,50 @@ static int fuse2fs_iomap_config_devices(struct fuse2fs *ff)
 	return 0;
 }
 
+static void fuse2fs_invalidate_bdev(struct fuse2fs *ff, blk64_t blk, blk_t num)
+{
+	off_t offset = FUSE2FS_FSB_TO_B(ff, blk);
+	off_t length = FUSE2FS_FSB_TO_B(ff, num);
+	int ret;
+
+	ret = fuse_fs_iomap_device_invalidate(ff->iomap_dev, offset, length);
+	if (!ret)
+		return;
+
+	if (num == 1)
+		err_printf(ff, "%s %llu: %s\n",
+			   _("error invalidating block"),
+			   (unsigned long long)blk,
+			   strerror(ret));
+	else
+		err_printf(ff, "%s %llu-%llu: %s\n",
+			   _("error invalidating blocks"),
+			   (unsigned long long)blk,
+			   (unsigned long long)blk + num - 1,
+			   strerror(ret));
+}
+
+static void fuse2fs_alloc_stats(ext2_filsys fs, blk64_t blk, int inuse)
+{
+	struct fuse2fs *ff = fs->priv_data;
+
+	if (inuse < 0)
+		fuse2fs_invalidate_bdev(ff, blk, 1);
+	if (ff->old_alloc_stats)
+		ff->old_alloc_stats(fs, blk, inuse);
+}
+
+static void fuse2fs_alloc_stats_range(ext2_filsys fs, blk64_t blk, blk_t num,
+				      int inuse)
+{
+	struct fuse2fs *ff = fs->priv_data;
+
+	if (inuse < 0)
+		fuse2fs_invalidate_bdev(ff, blk, num);
+	if (ff->old_alloc_stats_range)
+		ff->old_alloc_stats_range(fs, blk, num, inuse);
+}
+
 static int op_iomap_config(uint64_t flags, off_t maxbytes,
 			   struct fuse_iomap_config *cfg)
 {
@@ -6297,6 +6344,19 @@ static int op_iomap_config(uint64_t flags, off_t maxbytes,
 	if (ret)
 		goto out_unlock;
 
+	/*
+	 * If we let iomap do all file block IO, then we need to watch for
+	 * freed blocks so that we can invalidate any page cache that might
+	 * get written to the block deivce.
+	 */
+	if (fuse2fs_iomap_enabled(ff)) {
+		ext2fs_set_block_alloc_stats_callback(ff->fs,
+				fuse2fs_alloc_stats, &ff->old_alloc_stats);
+		ext2fs_set_block_alloc_stats_range_callback(ff->fs,
+				fuse2fs_alloc_stats_range,
+				&ff->old_alloc_stats_range);
+	}
+
 out_unlock:
 	fuse2fs_finish(ff, ret);
 	return ret;


