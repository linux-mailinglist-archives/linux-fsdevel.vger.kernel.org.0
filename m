Return-Path: <linux-fsdevel+bounces-18003-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1573A8B49CD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 07:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C64BD282029
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 05:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF405664;
	Sun, 28 Apr 2024 05:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="jshJ5KR1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81973C28;
	Sun, 28 Apr 2024 05:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714281544; cv=none; b=JKqklUHTmekFhIh01tuY6SmEimUihMrxITlxfIcTdyAi8OTPW0c0vL2/a0ZFiCVsYf+QHZE+bmERw3y0IhkPTuo9Sfxbzw1qJNTHgXN+7oQwVsfG8ErTZZR510EAgefIVoHyFCSSyTg/oPQSCYmy0AIKxI8hWaN2FR9/1HmWAcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714281544; c=relaxed/simple;
	bh=wM+0OgGZu8hO2Fn+GCnfnseFlCFqVn7dQHD0jDuyZaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oXHJJ7ZJKLQsa469QDHM9I8G0InBBZR4lfi+UDNR0k2sVyDOqHONrZW7HzCHtbM+c13P5OApuUSPxoopZXZyinJWYki3STP8Kg+bl5ZfsaqWUDP+ypYZ0bTX+zApGA/qlRbASZfryUQ3vWfbFN7SJicuVaOh9K4x7MUXzVJ3nWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=jshJ5KR1; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MXOTJZGYGgFux0gWx+fGk+GxPTBkFmwMjosjPL6WUqE=; b=jshJ5KR18qEcPTGWXNFdPniy6t
	MQd5toYF32OwJEY3VvCyZtjhHl9n/ChAVXO5hrGzhZPABEXTPOjimbJlFUZQqk3be//Sney7bfUVY
	8nK190XkeTCLIBYp+K6doYvq8uSooesSmD6fueFHVLJLwSipM7OiAq6uyoj+R3iHvMnrw+4Qig4uk
	UcDgUNmy/z36FI5u+N5YQPwWNXBXpY4kNW2bmei/rpjsB+36eM5idzdBUqAHwoEdoWXxqC+tXAGKx
	s05jhHkIxtrg2MaWF5SnHj9W7szjc9mvoSeekqKRP+dWNReVaiaGUMTv8P8tNI0MwPuVxCntwNYJF
	WwExfzQg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s0wwG-006VOF-30;
	Sun, 28 Apr 2024 05:19:01 +0000
Date: Sun, 28 Apr 2024 06:19:00 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Yu Kuai <yukuai1@huaweicloud.com>, linux-block@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6/8] bdev: move ->bd_has_subit_bio to ->__bd_flags
Message-ID: <20240428051900.GF1549798@ZenIV>
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
 block/bdev.c              | 6 ++----
 block/blk-core.c          | 4 ++--
 block/genhd.c             | 3 ++-
 include/linux/blk_types.h | 2 +-
 4 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 24c1dd6de8a9..9aa23620fe92 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -414,10 +414,8 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
 	bdev->__bd_flags = partno;
 	bdev->bd_inode = inode;
 	bdev->bd_queue = disk->queue;
-	if (partno)
-		bdev->bd_has_submit_bio = disk->part0->bd_has_submit_bio;
-	else
-		bdev->bd_has_submit_bio = false;
+	if (partno && bdev_test_flag(disk->part0, BD_HAS_SUBMIT_BIO))
+		bdev_set_flag(bdev, BD_HAS_SUBMIT_BIO);
 	bdev->bd_stats = alloc_percpu(struct disk_stats);
 	if (!bdev->bd_stats) {
 		iput(inode);
diff --git a/block/blk-core.c b/block/blk-core.c
index 20322abc6082..f61460b65408 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -615,7 +615,7 @@ static void __submit_bio(struct bio *bio)
 	if (unlikely(!blk_crypto_bio_prep(&bio)))
 		return;
 
-	if (!bio->bi_bdev->bd_has_submit_bio) {
+	if (!bdev_test_flag(bio->bi_bdev, BD_HAS_SUBMIT_BIO)) {
 		blk_mq_submit_bio(bio);
 	} else if (likely(bio_queue_enter(bio) == 0)) {
 		struct gendisk *disk = bio->bi_bdev->bd_disk;
@@ -723,7 +723,7 @@ void submit_bio_noacct_nocheck(struct bio *bio)
 	 */
 	if (current->bio_list)
 		bio_list_add(&current->bio_list[0], bio);
-	else if (!bio->bi_bdev->bd_has_submit_bio)
+	else if (!bdev_test_flag(bio->bi_bdev, BD_HAS_SUBMIT_BIO))
 		__submit_bio_noacct_mq(bio);
 	else
 		__submit_bio_noacct(bio);
diff --git a/block/genhd.c b/block/genhd.c
index bb29a68e1d67..19cd1a31fa80 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -413,7 +413,8 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 	elevator_init_mq(disk->queue);
 
 	/* Mark bdev as having a submit_bio, if needed */
-	disk->part0->bd_has_submit_bio = disk->fops->submit_bio != NULL;
+	if (disk->fops->submit_bio)
+		bdev_set_flag(disk->part0, BD_HAS_SUBMIT_BIO);
 
 	/*
 	 * If the driver provides an explicit major number it also must provide
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 8a336053b5fa..c8f5364b24f1 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -46,7 +46,6 @@ struct block_device {
 	struct disk_stats __percpu *bd_stats;
 	unsigned long		bd_stamp;
 	u32			__bd_flags;	// partition number + flags
-	bool			bd_has_submit_bio;
 	dev_t			bd_dev;
 	struct inode		*bd_inode;	/* will die */
 
@@ -87,6 +86,7 @@ struct block_device {
 enum {
 	BD_READ_ONLY,		// read-only policy
 	BD_WRITE_HOLDER,
+	BD_HAS_SUBMIT_BIO,
 };
 
 /*
-- 
2.39.2


