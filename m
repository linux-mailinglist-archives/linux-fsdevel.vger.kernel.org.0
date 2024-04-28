Return-Path: <linux-fsdevel+bounces-18000-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 347858B49C6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 07:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6662E1C20D4E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 05:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF7E5664;
	Sun, 28 Apr 2024 05:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="hMrBQnLU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC4A321D;
	Sun, 28 Apr 2024 05:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714281384; cv=none; b=klBXkzAeAEdEdwLTVqq6VXnnfRrbMias+sD0BzdS07Ejo4V+g1BNN/GY9uNwEyOl/TOQCBGRhbwoTcvTdZ8EUXY6+bj3bzukG430Pj7zYKfTCgS+SMPkaji8enN/Ax9m01OL/7S3ySESap6EektLFAyDAYTsvBdLR8TrD2x9hOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714281384; c=relaxed/simple;
	bh=q0RAssYWsvGYCQEhxffMOxjxrhMhIBZbvWOAYDWsB+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YVafpBfNnOr7Cs/BRkm7/oMdKXC3mCkV49sTSVxoCD6j5aT2vQIKfHPVpZIANCxtpgfX19/ywpbi5e/3iFWs374GLd2tO2qT3InQuycqSFOKvSAfYrURv2LVz/D7q3TkSuEzORfuiFmkrQhwEDypgt47y2LrgrWWoPsvbn3WwLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=hMrBQnLU; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pa27QOZhgTYyjdTX6K9oFf7IjSK8d/+qozIJWisXWV0=; b=hMrBQnLU5MFUWkpUtzCSjw9U+F
	vze8lDtnckLgJuXdAWEj+ZJrABZ6L5a07rBHGDeVPE+ANvU6p5dVZ0ocO2iHShvVtI6ThIXtKUbgp
	ZzajvdfPtOxvuBC6wtIZ+Oe+LuswR3kgFB8ByIlZSSK2nR0FHauDA3jdqmNm1HEH1ol0GNnumRTWy
	zTVUFSj6ANLsvEKYiLGBxTM9GJqcL5S4GCnivwLjYFneSbf1Kh66TpQE8pCwk5dXVqKpIwVZVvIIY
	3InOlQA8XdXX/eVPZwyuPXygPtGMHXnWQlqeG0coQO7oAnaU62ZouVCITs5PS0qQdOdHx9CCRZRAS
	NfkmFxCA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s0wtg-006VIB-3B;
	Sun, 28 Apr 2024 05:16:21 +0000
Date: Sun, 28 Apr 2024 06:16:20 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Yu Kuai <yukuai1@huaweicloud.com>, linux-block@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/8] bdev: infrastructure for flags
Message-ID: <20240428051620.GC1549798@ZenIV>
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

Replace bd_partno with a 32bit field (__bd_flags).  The lower 8 bits
contain the partition number, the upper 24 are for flags.

Helpers: bdev_{test,set,clear}_flag(bdev, flag), where flag numbers
are zero-based.  Use cmpxchg() to set/clear - all architectures support
it for u32.

NOTE: this commit does not actuall move any flags over there - they
are still bool fields.  As the result, it shifts the fields wrt
cacheline boundaries; that's going to be restored once the first
3 flags are dealt with.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 block/bdev.c              |  2 +-
 include/linux/blk_types.h |  2 +-
 include/linux/blkdev.h    | 33 ++++++++++++++++++++++++++++++++-
 3 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 7a5f611c3d2e..0c55f7abaac3 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -411,7 +411,7 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
 	mutex_init(&bdev->bd_fsfreeze_mutex);
 	spin_lock_init(&bdev->bd_size_lock);
 	mutex_init(&bdev->bd_holder_lock);
-	bdev->bd_partno = partno;
+	bdev->__bd_flags = partno;
 	bdev->bd_inode = inode;
 	bdev->bd_queue = disk->queue;
 	if (partno)
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index cb1526ec44b5..274f7eb4138f 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -45,8 +45,8 @@ struct block_device {
 	struct request_queue *	bd_queue;
 	struct disk_stats __percpu *bd_stats;
 	unsigned long		bd_stamp;
+	u32			__bd_flags;	// partition number + flags
 	bool			bd_read_only;	/* read-only policy */
-	u8			bd_partno;
 	bool			bd_write_holder;
 	bool			bd_has_submit_bio;
 	dev_t			bd_dev;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 32549d675955..b9dbfb811533 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -722,7 +722,38 @@ void disk_uevent(struct gendisk *disk, enum kobject_action action);
 
 static inline u8 bdev_partno(const struct block_device *bdev)
 {
-	return bdev->bd_partno;
+	return bdev->__bd_flags & 0xff;
+}
+
+static inline bool bdev_test_flag(const struct block_device *bdev, int flag)
+{
+	return bdev->__bd_flags & (1 << (flag + 8));
+}
+
+static inline void bdev_set_flag(struct block_device *bdev, int flag)
+{
+	u32 v = bdev->__bd_flags;
+
+	for (;;) {
+		u32 w = cmpxchg(&bdev->__bd_flags, v, v | (1 << (flag + 8)));
+
+		if (v == w)
+			return;
+		v = w;
+	}
+}
+
+static inline void bdev_clear_flag(struct block_device *bdev, int flag)
+{
+	u32 v = bdev->__bd_flags;
+
+	for (;;) {
+		u32 w = cmpxchg(&bdev->__bd_flags, v, v & ~(1 << (flag + 8)));
+
+		if (v == w)
+			return;
+		v = w;
+	}
 }
 
 static inline int get_disk_ro(struct gendisk *disk)
-- 
2.39.2


