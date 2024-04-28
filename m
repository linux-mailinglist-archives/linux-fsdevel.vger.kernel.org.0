Return-Path: <linux-fsdevel+bounces-18002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2188B49CB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 07:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1716F1F2174C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 05:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D1D5664;
	Sun, 28 Apr 2024 05:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="HPwhaHMK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15706320C;
	Sun, 28 Apr 2024 05:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714281496; cv=none; b=rYMNIg9849osUpEsWOR21svgykbrRoU6rQgUWsAjXkZ3hdF5cEeSPZ4i3heJjW9m/Ru+XN4GczWJQJkklVlqQW8JNGUoP1S/Kv/I0EO6vNxtmYT7F2MgfafakbcHZr9tV1G3OqfaI9sbUjg1qQZX/H3A2pzPvUC7aRq4PU1je0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714281496; c=relaxed/simple;
	bh=7azFLDepGw3EjAQD9Jh6qJavhTc0jsWETc+eaETwr2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rj/VNHSaStkBcb8xJnOpm/LUxHzN74nr9U3Fk252JFhhExZKAirKf2huR72C0R/sPOQa7p2h5x7JynXNoEOAdrrd1VOhhdydTEepPzWhJu+MGjGZFsf8zrOza94RYkhKXm6/e5P1uuQG0umakepvpAYH5vuCecmRJsyK2dp4n3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=HPwhaHMK; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uqvEx6sEC2MY3wKLQdNGpDvZ1tI9w1QriUWIELjqFzk=; b=HPwhaHMK2VIivTTbFP/1WgMOXL
	ijwZhUDe6bVj60efteSRpUbB1ruaU6S6ZxKTMQYHnn06rVHH2ltRosnGcNhVuo33ntkoZ1iYWq6JR
	u9WEbrw9ZBVXzzDrd5wfOdvKKMnMA/cPwm75hnIeWm34YoMOxy3mCDzVqpKe5PU1ypSNagOXU7Qwx
	7+iUlgZkAgjLx3T2EMlvzKE6RUNO0dvQl5FwUTpC0tN9Mw5L+OHecVtP4wmzl6OmslRgctfwLf7Hv
	Ppg3EHFHgSecgbHhAx8cPvFqcR3VwTPZndlL3GkUiewkapqrPQiZrTk/BFshznWcWvZLkc94Y8iSX
	ehpALhow==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s0wvV-006VML-0F;
	Sun, 28 Apr 2024 05:18:13 +0000
Date: Sun, 28 Apr 2024 06:18:13 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Yu Kuai <yukuai1@huaweicloud.com>, linux-block@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5/8] bdev: move ->bd_write_holder into ->__bd_flags
Message-ID: <20240428051813.GE1549798@ZenIV>
References: <20240428051232.GU2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240428051232.GU2118490@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 block/bdev.c              | 9 +++++----
 include/linux/blk_types.h | 2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 0c55f7abaac3..24c1dd6de8a9 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -624,7 +624,7 @@ static void bd_end_claim(struct block_device *bdev, void *holder)
 		bdev->bd_holder = NULL;
 		bdev->bd_holder_ops = NULL;
 		mutex_unlock(&bdev->bd_holder_lock);
-		if (bdev->bd_write_holder)
+		if (bdev_test_flag(bdev, BD_WRITE_HOLDER))
 			unblock = true;
 	}
 	if (!whole->bd_holders)
@@ -640,7 +640,7 @@ static void bd_end_claim(struct block_device *bdev, void *holder)
 	 */
 	if (unblock) {
 		disk_unblock_events(bdev->bd_disk);
-		bdev->bd_write_holder = false;
+		bdev_clear_flag(bdev, BD_WRITE_HOLDER);
 	}
 }
 
@@ -892,9 +892,10 @@ int bdev_open(struct block_device *bdev, blk_mode_t mode, void *holder,
 		 * writeable reference is too fragile given the way @mode is
 		 * used in blkdev_get/put().
 		 */
-		if ((mode & BLK_OPEN_WRITE) && !bdev->bd_write_holder &&
+		if ((mode & BLK_OPEN_WRITE) &&
+		    !bdev_test_flag(bdev, BD_WRITE_HOLDER) &&
 		    (disk->event_flags & DISK_EVENT_FLAG_BLOCK_ON_EXCL_WRITE)) {
-			bdev->bd_write_holder = true;
+			bdev_set_flag(bdev, BD_WRITE_HOLDER);
 			unblock_events = false;
 		}
 	}
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 1aa41b651614..8a336053b5fa 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -46,7 +46,6 @@ struct block_device {
 	struct disk_stats __percpu *bd_stats;
 	unsigned long		bd_stamp;
 	u32			__bd_flags;	// partition number + flags
-	bool			bd_write_holder;
 	bool			bd_has_submit_bio;
 	dev_t			bd_dev;
 	struct inode		*bd_inode;	/* will die */
@@ -87,6 +86,7 @@ struct block_device {
 
 enum {
 	BD_READ_ONLY,		// read-only policy
+	BD_WRITE_HOLDER,
 };
 
 /*
-- 
2.39.2


