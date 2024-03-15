Return-Path: <linux-fsdevel+bounces-14452-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE0387CE0C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 14:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A463DB22CA0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 13:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B905A37145;
	Fri, 15 Mar 2024 13:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jNou7vev"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B1436AED;
	Fri, 15 Mar 2024 13:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710509012; cv=none; b=gIgy3svS+M8MxmDzplg5P3/NYVLdYkhIVF1mDToW8lV5bbgi21OvgI6eGaMHoZbpcs+z9xEKWHsKtifSTKH77Li9u2W+OSnpzSxrLCJohLHEK3LiCHrEGSCv3szcwDNFYWwzHzCFemhQBpl/mDYrJ0Cqr4BveduIlj0y1wf4OEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710509012; c=relaxed/simple;
	bh=RT1B0F48ch/TXesn9Gk15zq5dcXu47XHInUzvwyKGtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rJU5XC9aLyouTKkSpVY0qXhIfTOLVU1g3PU7//aoOdH64fZ7ccrJ7zKuKCNySlRKbjN2jeWcEfIImBbMr24CmcJdAJEmqTcxTckiTXHcTHAyHrUsOB6RQjktddfWxRcUgjEv7JyPC7Tl7letTY90ak4mN4+eR6FWyIiaRDRpjEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jNou7vev; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D62C433F1;
	Fri, 15 Mar 2024 13:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710509011;
	bh=RT1B0F48ch/TXesn9Gk15zq5dcXu47XHInUzvwyKGtw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jNou7vevkoXB9rgjSA7FuC9LxxAW8fXYzDOrY8XfP7/GLUeNJczD+OmrJmC0Csu42
	 2h9MqMUUhBTCp5BaAazX29C64NyyTgXFjNlGCVGIX72mYym3E7UKCtezPh1up1nYTo
	 cR9l9ng3UUixifmdiVIi70oDFJSp1eH56vFbDLgHpqSaV0/Iib8BojgAVRBSLyXdcK
	 evCqEcqpvIZT66rkHiR4NmMuwwtqUThMtxhIhssTk+ACRxIgxFyUwJ7pq5oAWHAKkD
	 W96NkyYD9EkthBS4834Fj5SHehIw57MVAiHGn4GfOfRpscIp/0wRjgc4TafQt1PRcr
	 s7/Dv8Dtnuf0A==
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@infradead.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH] fs,block: get holder during claim
Date: Fri, 15 Mar 2024 14:23:07 +0100
Message-ID: <20240315-freibad-annehmbar-ca68c375af91@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240314165814.tne3leyfmb4sqk2t@quack3>
References: <20240314165814.tne3leyfmb4sqk2t@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3429; i=brauner@kernel.org; h=from:subject:message-id; bh=RT1B0F48ch/TXesn9Gk15zq5dcXu47XHInUzvwyKGtw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR+8T5R6lTzrC+ZkUs0ZU7XmofK67e6ltj+uCTcz5KZ0 fRqi/LbjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImccmJkuB357Np3HUWVNdr9 6k/dKr8G5bZeUlVaai52XZu9Q/XXQ0aGJVfe8R+7JnUp9aH8t8WLlvueNbh11Oi5/69NF6ZphvQ q8wMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Now that we open block devices as files we need to deal with the
realities that closing is a deferred operation. An operation on the
block device such as e.g., freeze, thaw, or removal that runs
concurrently with umount, tries to acquire a stable reference on the
holder. The holder might already be gone though. Make that reliable by
grabbing a passive reference to the holder during bdev_open() and
releasing it during bdev_release().

Fixes: f3a608827d1f ("bdev: open block device as files") # mainline only
Reported-by: Christoph Hellwig <hch@infradead.org>
Link: https://lore.kernel.org/r/ZfEQQ9jZZVes0WCZ@infradead.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Hey all,

I ran blktests with nbd enabled which contains a reliable repro for the
issue. Thanks to Christoph for pointing in that direction. The
underlying issue is not reproducible anymore with this patch applied.
xfstests and blktests pass.

Thanks!
Christian
---
 block/bdev.c           |  7 +++++++
 fs/super.c             | 18 ++++++++++++++++++
 include/linux/blkdev.h | 10 ++++++++++
 3 files changed, 35 insertions(+)

diff --git a/block/bdev.c b/block/bdev.c
index e7adaaf1c219..7a5f611c3d2e 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -583,6 +583,9 @@ static void bd_finish_claiming(struct block_device *bdev, void *holder,
 	mutex_unlock(&bdev->bd_holder_lock);
 	bd_clear_claiming(whole, holder);
 	mutex_unlock(&bdev_lock);
+
+	if (hops && hops->get_holder)
+		hops->get_holder(holder);
 }
 
 /**
@@ -605,6 +608,7 @@ EXPORT_SYMBOL(bd_abort_claiming);
 static void bd_end_claim(struct block_device *bdev, void *holder)
 {
 	struct block_device *whole = bdev_whole(bdev);
+	const struct blk_holder_ops *hops = bdev->bd_holder_ops;
 	bool unblock = false;
 
 	/*
@@ -627,6 +631,9 @@ static void bd_end_claim(struct block_device *bdev, void *holder)
 		whole->bd_holder = NULL;
 	mutex_unlock(&bdev_lock);
 
+	if (hops && hops->put_holder)
+		hops->put_holder(holder);
+
 	/*
 	 * If this was the last claim, remove holder link and unblock evpoll if
 	 * it was a write holder.
diff --git a/fs/super.c b/fs/super.c
index ee05ab6b37e7..71d9779c42b1 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1515,11 +1515,29 @@ static int fs_bdev_thaw(struct block_device *bdev)
 	return error;
 }
 
+static void fs_bdev_super_get(void *data)
+{
+	struct super_block *sb = data;
+
+	spin_lock(&sb_lock);
+	sb->s_count++;
+	spin_unlock(&sb_lock);
+}
+
+static void fs_bdev_super_put(void *data)
+{
+	struct super_block *sb = data;
+
+	put_super(sb);
+}
+
 const struct blk_holder_ops fs_holder_ops = {
 	.mark_dead		= fs_bdev_mark_dead,
 	.sync			= fs_bdev_sync,
 	.freeze			= fs_bdev_freeze,
 	.thaw			= fs_bdev_thaw,
+	.get_holder		= fs_bdev_super_get,
+	.put_holder		= fs_bdev_super_put,
 };
 EXPORT_SYMBOL_GPL(fs_holder_ops);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f9b87c39cab0..c3e8f7cf96be 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1505,6 +1505,16 @@ struct blk_holder_ops {
 	 * Thaw the file system mounted on the block device.
 	 */
 	int (*thaw)(struct block_device *bdev);
+
+	/*
+	 * If needed, get a reference to the holder.
+	 */
+	void (*get_holder)(void *holder);
+
+	/*
+	 * Release the holder.
+	 */
+	void (*put_holder)(void *holder);
 };
 
 /*
-- 
2.43.0


