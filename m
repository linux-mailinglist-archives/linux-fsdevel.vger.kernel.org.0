Return-Path: <linux-fsdevel+bounces-61637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D25FB58A88
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 03:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED6853B0EE5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 01:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9991D31B9;
	Tue, 16 Sep 2025 01:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bqZlUDRB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DA5199935;
	Tue, 16 Sep 2025 01:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984560; cv=none; b=TSwNGDJAK0XO7vEUOjnzgXS+IF9YNARZ5yI1CWftUtrw3pki1tf81oEjuvkt9xTD0eKZmaMK4O+RV58b12gsUyfKpOUlL3ebBJrkZdnDWlc9Dm19c4rt3LehLyJcMrmBfCtvQ1K7qK/aCoUFqc9NLmuCXmySh6OifGRy67eHofw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984560; c=relaxed/simple;
	bh=1jWxtc9WQzpwXJzfRfE6zAasofGbWsg95kj65lKrfgg=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KHZfdxfxrestRV0QOyX0SQR+2sV8XTGVkgemkwdD3bMkYsC5PDlBdqIXLO4bYVSh69TJaLx1+N+H1UMMVCItydPU28/RJN+Yhy14Gddj+46bqLvsWdUE0gDylYw1549v3ar7hRnG6VdwlUdpPXBg/c0u8z6UAdV/xG6DXK1GHHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bqZlUDRB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32327C4CEF1;
	Tue, 16 Sep 2025 01:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757984560;
	bh=1jWxtc9WQzpwXJzfRfE6zAasofGbWsg95kj65lKrfgg=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=bqZlUDRBgTZfHhjlQRS5RyApfe3kE3frQs+JCssYyLtGuuFSiCTUNWHBxBqcdYM6+
	 oMj3GAQXPlWdSLDbw4kdGN75FXsrQ5htT/u4r99TvXN7X2ibi4nVH7q+7q7eNK+Yc0
	 U1s2AXw9uX4flCFnt2VhwYayIJAK1DaWj8hX+VG4sj5nbnvUE+DH8tG85iJoXk+wG8
	 d2v8+U7QTSMAmmDyAhQDrMnf1qQUIUP2Ko1gX8ht3PJQ5KivVsiEg1JZnRqofSb81h
	 HyS44k8+DwKw/KWFq42jlDWNGvhWGPnkCLZzkNw2/ruidESNhrgdW7i6HRhExG+PbG
	 rb8K1D8dtFp9A==
Date: Mon, 15 Sep 2025 18:02:39 -0700
Subject: [PATCH 15/17] fuse4fs: separate invalidation
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, John@groves.net, bernd@bsbernd.com,
 joannelkoong@gmail.com
Message-ID: <175798161990.390496.15521521611049827785.stgit@frogsfrogsfrogs>
In-Reply-To: <175798161643.390496.10274066827486065265.stgit@frogsfrogsfrogs>
References: <175798161643.390496.10274066827486065265.stgit@frogsfrogsfrogs>
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
index 6f3ddceea85c27..c633bb9eca068a 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -274,6 +274,9 @@ struct fuse4fs {
 	enum fuse4fs_iomap_state iomap_state;
 	uint32_t iomap_dev;
 	uint64_t iomap_cap;
+	void (*old_alloc_stats)(ext2_filsys fs, blk64_t blk, int inuse);
+	void (*old_alloc_stats_range)(ext2_filsys fs, blk64_t blk, blk_t num,
+				      int inuse);
 #endif
 	unsigned int blockmask;
 	unsigned long offset;
@@ -6314,6 +6317,51 @@ static int fuse4fs_iomap_config_devices(struct fuse4fs *ff)
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
@@ -6358,6 +6406,19 @@ static void op_iomap_config(fuse_req_t req, uint64_t flags, uint64_t maxbytes)
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
index 9212235495dc22..1567c2e72279c2 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -268,6 +268,9 @@ struct fuse2fs {
 	enum fuse2fs_iomap_state iomap_state;
 	uint32_t iomap_dev;
 	uint64_t iomap_cap;
+	void (*old_alloc_stats)(ext2_filsys fs, blk64_t blk, int inuse);
+	void (*old_alloc_stats_range)(ext2_filsys fs, blk64_t blk, blk_t num,
+				      int inuse);
 #endif
 	unsigned int blockmask;
 	unsigned long offset;
@@ -5844,6 +5847,50 @@ static int fuse2fs_iomap_config_devices(struct fuse2fs *ff)
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
@@ -5888,6 +5935,19 @@ static int op_iomap_config(uint64_t flags, off_t maxbytes,
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


