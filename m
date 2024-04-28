Return-Path: <linux-fsdevel+bounces-18001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4158B49C9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 07:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7F471C20D4E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 05:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B560453BE;
	Sun, 28 Apr 2024 05:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="dZX9cYZo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C7C320C;
	Sun, 28 Apr 2024 05:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714281449; cv=none; b=kc9rcLLgOWMdZvQH51/DAEYASA49fCcc2SFs0iBdzIhfpR0L1JtBuMbDswZ7MQYhhYrV5uNg23UQuH49AdPS3VgpbrWTu1JGI9OMPrjhJuI6tzX7OnGl/ZuSOI15WCpyWBEFberd4w8zaf6XNtFUGofEjmk4z4fmkO8JGiXBxRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714281449; c=relaxed/simple;
	bh=+BLcWJoCEy6Lcy7oq8TS69eqNomO12mqU0xRquEsrYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qpAp4BL0DOpvn1Da/Gt0olBkYkZHgWQ73QyYFYp+9M4lfOaCinOXcU7AvsYc1ZS00gdd0vQliyOtw8FGzsxOhVyrgMiH68F/YsYzKyPHmblvm95FrvUJk35sldzl1UOKhc3kl9Xc4vBAXRt3F7RSNFT2+yKVyGKZb9r+uHl7Zi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=dZX9cYZo; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=S4nF/w/dYVCfQoFNcFEm8mUpsqd4FCdsG1qHmSeVg+s=; b=dZX9cYZo5ltwl6wfk1EwmZ+KHK
	chQ9A7R9oBQdhzaqhn9N7As5xwxdSD2CAa9oFbhCiWqxWH716NKsdYuKl64dWVlEVvRcrqK3gP+iw
	Nm6e4VSIU+tLcVu0iRkKPAhpkMKtMaS8T7ZMVHhouaxiY0CYmdcQfPNhiZL5qYPRcTAuB0jHQpZ8E
	8Y5i5SVxwSa5SpF0sfAMM26jnS0pjLPNf+gbmEdxhO4nxxFlLqh7vYvSCoBAWy1fVv8KeiZqOodS/
	pILSld896lWMAaFI1iON6MlVOfgNglZgrHqvnQuCTEtGMi3A97I/OOwd4gfySJV1pgZeyshNJavp1
	hBKoijvQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s0wui-006VKS-1l;
	Sun, 28 Apr 2024 05:17:24 +0000
Date: Sun, 28 Apr 2024 06:17:24 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Yu Kuai <yukuai1@huaweicloud.com>, linux-block@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/8] bdev: move ->bd_read_only to ->__bd_flags
Message-ID: <20240428051724.GD1549798@ZenIV>
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
 block/ioctl.c             | 5 ++++-
 include/linux/blk_types.h | 5 ++++-
 include/linux/blkdev.h    | 4 ++--
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index 0c76137adcaa..be173e4ff43d 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -402,7 +402,10 @@ static int blkdev_roset(struct block_device *bdev, unsigned cmd,
 		if (ret)
 			return ret;
 	}
-	bdev->bd_read_only = n;
+	if (n)
+		bdev_set_flag(bdev, BD_READ_ONLY);
+	else
+		bdev_clear_flag(bdev, BD_READ_ONLY);
 	return 0;
 }
 
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 274f7eb4138f..1aa41b651614 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -46,7 +46,6 @@ struct block_device {
 	struct disk_stats __percpu *bd_stats;
 	unsigned long		bd_stamp;
 	u32			__bd_flags;	// partition number + flags
-	bool			bd_read_only;	/* read-only policy */
 	bool			bd_write_holder;
 	bool			bd_has_submit_bio;
 	dev_t			bd_dev;
@@ -86,6 +85,10 @@ struct block_device {
 #define bdev_kobj(_bdev) \
 	(&((_bdev)->bd_device.kobj))
 
+enum {
+	BD_READ_ONLY,		// read-only policy
+};
+
 /*
  * Block error status values.  See block/blk-core:blk_errors for the details.
  * Alpha cannot write a byte atomically, so we need to use 32-bit value.
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index b9dbfb811533..d556cec9224b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -758,13 +758,13 @@ static inline void bdev_clear_flag(struct block_device *bdev, int flag)
 
 static inline int get_disk_ro(struct gendisk *disk)
 {
-	return disk->part0->bd_read_only ||
+	return bdev_test_flag(disk->part0, BD_READ_ONLY) ||
 		test_bit(GD_READ_ONLY, &disk->state);
 }
 
 static inline int bdev_read_only(struct block_device *bdev)
 {
-	return bdev->bd_read_only || get_disk_ro(bdev->bd_disk);
+	return bdev_test_flag(bdev, BD_READ_ONLY) || get_disk_ro(bdev->bd_disk);
 }
 
 bool set_capacity_and_notify(struct gendisk *disk, sector_t size);
-- 
2.39.2


