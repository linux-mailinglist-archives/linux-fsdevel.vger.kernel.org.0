Return-Path: <linux-fsdevel+bounces-58547-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34733B2EA8A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 250F31BC764D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B1A20ADD6;
	Thu, 21 Aug 2025 01:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OT0iSPrI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33211F9A89;
	Thu, 21 Aug 2025 01:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755739209; cv=none; b=ELrTCQhI0caVlr0OXYYH4ElDQpDBXh5mKi29yDbFRkH/vmKqrwjV5SyK7jG5EEiR87rzSZ2NfRCxYIHJx/qss/gC5FT/mjI5+/dNwX2oEtuh6nmbLjag9cKAtYijEkn70F9a3zQzth5W2uvtq9Qa4JbhUllgTGTnO0JtHMqD6o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755739209; c=relaxed/simple;
	bh=LfL5gxloCJFcSjK5SnikGbrbWvUfmPTAU6sXjFQwFAQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XNsArYPMcZ36qe7owF6C2PSdGkXKSvvTIxGEGnA6AUzF3cGKcpfolc9RJesQOXpuvllsHZGAhdAiFvAFU59EMH7qqDxvj2Fteu2gjV9b11p569giqPfssS79Kki5vDdWETDAQAwA1mqUTlbd7XXKK2tAbHaVWr67svJw5OQW4yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OT0iSPrI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0824C113D0;
	Thu, 21 Aug 2025 01:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755739208;
	bh=LfL5gxloCJFcSjK5SnikGbrbWvUfmPTAU6sXjFQwFAQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=OT0iSPrICaaV60FOcXN8YKxP4xkcg8BYl7z3FsZooMcSH33frOAUlDZ7hOxa2MfEC
	 iE+B2KbXi0tdSHknglBff1V0uWzbOzhaUX/ePWm74RZQ2Ay8x7w17d7PK2A9Wc8DBU
	 WKqMmhuCB89mxnvUERRhj1ha40wOoW77W8rz7+lCXt2wnQHdBjQwgwtIOUBs9LlbHE
	 csNKRFgvaNubAF/2dG4BJioFl1E57P44zFb7T6uAyBsw43tZFm6e1MiUItNZ6M7MRE
	 IwpdGVpYs4bu5GAs3euuzy8ZNsY3tDGKJ1NJ1cD/lTFjVyFbx9gDtVeqg4jTIhJN1D
	 dx0UIIXudZRqw==
Date: Wed, 20 Aug 2025 18:20:08 -0700
Subject: [PATCH 17/19] fuse4fs: separate invalidation
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com,
 neal@gompa.dev
Message-ID: <175573714037.21970.5650928421627307752.stgit@frogsfrogsfrogs>
In-Reply-To: <175573713645.21970.9783397720493472605.stgit@frogsfrogsfrogs>
References: <175573713645.21970.9783397720493472605.stgit@frogsfrogsfrogs>
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
 misc/fuse2fs.c |   60 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 misc/fuse4fs.c |   61 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 121 insertions(+)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 874fe3bbcc3b9f..cc835f894122a4 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -277,6 +277,9 @@ struct fuse2fs {
 	enum fuse2fs_iomap_state iomap_state;
 	uint32_t iomap_dev;
 	uint64_t iomap_cap;
+	void (*old_alloc_stats)(ext2_filsys fs, blk64_t blk, int inuse);
+	void (*old_alloc_stats_range)(ext2_filsys fs, blk64_t blk, blk_t num,
+				      int inuse);
 #endif
 	unsigned int blockmask;
 	unsigned long offset;
@@ -5927,6 +5930,50 @@ static int fuse2fs_iomap_config_devices(struct fuse2fs *ff)
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
@@ -5971,6 +6018,19 @@ static int op_iomap_config(uint64_t flags, off_t maxbytes,
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
diff --git a/misc/fuse4fs.c b/misc/fuse4fs.c
index 5127712e19e6f9..2371b9b37cc16a 100644
--- a/misc/fuse4fs.c
+++ b/misc/fuse4fs.c
@@ -273,6 +273,9 @@ struct fuse4fs {
 	enum fuse4fs_iomap_state iomap_state;
 	uint32_t iomap_dev;
 	uint64_t iomap_cap;
+	void (*old_alloc_stats)(ext2_filsys fs, blk64_t blk, int inuse);
+	void (*old_alloc_stats_range)(ext2_filsys fs, blk64_t blk, blk_t num,
+				      int inuse);
 #endif
 	unsigned int blockmask;
 	unsigned long offset;
@@ -6250,6 +6253,51 @@ static int fuse4fs_iomap_config_devices(struct fuse4fs *ff)
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
@@ -6294,6 +6342,19 @@ static void op_iomap_config(fuse_req_t req, uint64_t flags, uint64_t maxbytes)
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


