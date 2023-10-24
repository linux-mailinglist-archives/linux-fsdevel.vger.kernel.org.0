Return-Path: <linux-fsdevel+bounces-1090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 408D17D5475
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 16:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70DC21C20CAD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 14:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABB930F9D;
	Tue, 24 Oct 2023 14:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5VO/5/L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA65C30CEC
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 14:54:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3A41C433CB;
	Tue, 24 Oct 2023 14:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698159249;
	bh=v3RKBYvuRr8zxHvkXri88BSnOOcy017B2yC5x12I4VM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=h5VO/5/L6i43E567LCVRlfdhpi4zjOvDMqWWviwL4Ij8LQM1RhCVp8aGSKebS1BEW
	 vL5QFuw2i3T+EY3tbEv2mxaNrPgs6pL8u3awBWwGUh2noHGymbL6mdNUsgC3xK72Dj
	 /LrYZa33kY2OquVU10tJHXQQ98ueV0G4o+CsfVS4rm9yd+P9uYUbO9BEhCPsGNryNc
	 JotosxWpML47XlMAhWRJLfDeecoXi7UVBNJSEbYOHiYsAPkioXYknse6h707b9zbKN
	 mx3Z7fhoh+TrcYS/XWNlMWGOK93GV3tXOrV6y7iM5LCuROklcI0ORxII4i8+GT2PU1
	 4h2d6Dwng9ARg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 24 Oct 2023 16:53:42 +0200
Subject: [PATCH RFC 4/6] bdev: simplify waiting for concurrent claimers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231024-vfs-super-rework-v1-4-37a8aa697148@kernel.org>
References: <20231024-vfs-super-rework-v1-0-37a8aa697148@kernel.org>
In-Reply-To: <20231024-vfs-super-rework-v1-0-37a8aa697148@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-26615
X-Developer-Signature: v=1; a=openpgp-sha256; l=3947; i=brauner@kernel.org;
 h=from:subject:message-id; bh=v3RKBYvuRr8zxHvkXri88BSnOOcy017B2yC5x12I4VM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSa3+oS9BPimbep1UXFzoVj/0E2VcdLu74wFNTzGog88Zrb
 nXqmo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCLsZgz/o8PS5GdvVbozjZOrUJul+v
 tm/6uP3ki9Lp1W4Wtx2HjFGkaGV8nzGye58SZopXF+ZS3T9mPzuOUb9PXXzhsv3RxbTS9yAgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Simplify the mechanism to wait for concurrent block devices claimers
and make it possible to introduce an additional state in the following
patches.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 block/bdev.c              | 34 ++++++++++++++++++----------------
 include/linux/blk_types.h |  7 ++++++-
 2 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 9deacd346192..7d19e04a8df8 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -482,6 +482,14 @@ static bool bd_may_claim(struct block_device *bdev, void *holder,
 	return true;
 }
 
+static bool wait_claimable(const struct block_device *bdev)
+{
+	enum bd_claim bd_claim;
+
+	bd_claim = smp_load_acquire(&bdev->bd_claim);
+	return bd_claim == BD_CLAIM_DEFAULT;
+}
+
 /**
  * bd_prepare_to_claim - claim a block device
  * @bdev: block device of interest
@@ -490,7 +498,7 @@ static bool bd_may_claim(struct block_device *bdev, void *holder,
  *
  * Claim @bdev.  This function fails if @bdev is already claimed by another
  * holder and waits if another claiming is in progress. return, the caller
- * has ownership of bd_claiming and bd_holder[s].
+ * has ownership of bd_claim and bd_holder[s].
  *
  * RETURNS:
  * 0 if @bdev can be claimed, -EBUSY otherwise.
@@ -511,31 +519,25 @@ int bd_prepare_to_claim(struct block_device *bdev, void *holder,
 	}
 
 	/* if claiming is already in progress, wait for it to finish */
-	if (whole->bd_claiming) {
-		wait_queue_head_t *wq = bit_waitqueue(&whole->bd_claiming, 0);
-		DEFINE_WAIT(wait);
-
-		prepare_to_wait(wq, &wait, TASK_UNINTERRUPTIBLE);
+	if (whole->bd_claim) {
 		mutex_unlock(&bdev_lock);
-		schedule();
-		finish_wait(wq, &wait);
+		wait_var_event(&whole->bd_claim, wait_claimable(whole));
 		goto retry;
 	}
 
 	/* yay, all mine */
-	whole->bd_claiming = holder;
+	whole->bd_claim = BD_CLAIM_ACQUIRE;
 	mutex_unlock(&bdev_lock);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(bd_prepare_to_claim); /* only for the loop driver */
 
-static void bd_clear_claiming(struct block_device *whole, void *holder)
+static void bd_clear_claiming(struct block_device *whole)
 {
 	lockdep_assert_held(&bdev_lock);
-	/* tell others that we're done */
-	BUG_ON(whole->bd_claiming != holder);
-	whole->bd_claiming = NULL;
-	wake_up_bit(&whole->bd_claiming, 0);
+	smp_store_release(&whole->bd_claim, BD_CLAIM_DEFAULT);
+	smp_mb();
+	wake_up_var(&whole->bd_claim);
 }
 
 /**
@@ -565,7 +567,7 @@ static void bd_finish_claiming(struct block_device *bdev, void *holder,
 	bdev->bd_holder = holder;
 	bdev->bd_holder_ops = hops;
 	mutex_unlock(&bdev->bd_holder_lock);
-	bd_clear_claiming(whole, holder);
+	bd_clear_claiming(whole);
 	mutex_unlock(&bdev_lock);
 }
 
@@ -581,7 +583,7 @@ static void bd_finish_claiming(struct block_device *bdev, void *holder,
 void bd_abort_claiming(struct block_device *bdev, void *holder)
 {
 	mutex_lock(&bdev_lock);
-	bd_clear_claiming(bdev_whole(bdev), holder);
+	bd_clear_claiming(bdev_whole(bdev));
 	mutex_unlock(&bdev_lock);
 }
 EXPORT_SYMBOL(bd_abort_claiming);
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 749203277fee..cbef041fd868 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -37,6 +37,11 @@ struct bio_crypt_ctx;
 #define PAGE_SECTORS		(1 << PAGE_SECTORS_SHIFT)
 #define SECTOR_MASK		(PAGE_SECTORS - 1)
 
+enum bd_claim {
+	BD_CLAIM_DEFAULT = 0,
+	BD_CLAIM_ACQUIRE = 1,
+};
+
 struct block_device {
 	sector_t		bd_start_sect;
 	sector_t		bd_nr_sectors;
@@ -52,7 +57,7 @@ struct block_device {
 	atomic_t		bd_openers;
 	spinlock_t		bd_size_lock; /* for bd_inode->i_size updates */
 	struct inode *		bd_inode;	/* will die */
-	void *			bd_claiming;
+	enum bd_claim		bd_claim;
 	void *			bd_holder;
 	const struct blk_holder_ops *bd_holder_ops;
 	struct mutex		bd_holder_lock;

-- 
2.34.1


