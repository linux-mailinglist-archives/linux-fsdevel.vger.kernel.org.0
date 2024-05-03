Return-Path: <linux-fsdevel+bounces-18549-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 598748BA451
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 02:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A0F61C214A9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 00:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D3E1FDA;
	Fri,  3 May 2024 00:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="VL3UFXMc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C13B360;
	Fri,  3 May 2024 00:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714694916; cv=none; b=YGkO2goBSah6P2rHtjJsiZNcyWKdHraym2+ut2oquEY6zk8ePEJ6EJNKyfJn0bgjIszsywJdl053P0vKDxWnLVeq6AR+OmCXb33ENmG0gwphJ1xY+SbEizHA5P4hRChFFzzy6/bFxZR/WICmebmwBwIGpIIOvcQryIm/0J2O8Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714694916; c=relaxed/simple;
	bh=Nthh7ICbE2s/qv+DPz+C5N5NUF9cThrABfTelH21nwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p3LlkfEUlUxXeGr3nGGEkv2sq22PaKk9Td7KbJELByOYUTFqChcZfBe4E548aFOvLWCDVHQ3qs411GWinCv5rjqchGaYUItyKcfjUemGV0+0A1BziwsyPVCHDVAit8VnU9JvlFCQnyVI4FwHjPvmLrvtfHQRnHwGv7m6QO5kvqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=VL3UFXMc; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MwJ+QCQAAQMykWTxtpk8i97fNwYcavR7sdQTgeYOgN8=; b=VL3UFXMc7rBbgCMqAP3CSMLC81
	p1cfhmTa5CgkrIw62G6tMW2kunIF6kKGDxRJ2Ai6wibH1mvwYBArReOE+KWGoOJKUuIh+v0g9St1Z
	H0PTsxd/I8qsLJord/reBHlg2QKCjnN+O9dPrM3FkVoi8Bxw3+9yvH+Aok6Qd0FDXRfifHWjfjosQ
	jNWU3vJm9LFhOc3VHzdAcpb1MpmXVs19hT/cFGLO0ejINM3VRN/a1TFJyPMPRJQEQSWwCJb39ZtCb
	QR+fDe9njm3yzLOyDEdLlo5SRGOUSfD79XpjSDv+LHt3vOn5EPmXjhhP6pBlZs7l/aZkoOYjKWbio
	w4ztAQ4w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s2gTY-009tJc-0M;
	Fri, 03 May 2024 00:08:32 +0000
Date: Fri, 3 May 2024 01:08:32 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-fsdevel@vger.kernel.org, Yu Kuai <yukuai1@huaweicloud.com>,
	linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2 3/8] bdev: infrastructure for flags
Message-ID: <20240503000832.GC2357260@ZenIV>
References: <20240428051232.GU2118490@ZenIV>
 <20240429052315.GB32688@lst.de>
 <20240429073107.GZ2118490@ZenIV>
 <20240429170209.GA2118490@ZenIV>
 <20240429181300.GB2118490@ZenIV>
 <20240429183041.GC2118490@ZenIV>
 <20240503000647.GQ2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503000647.GQ2118490@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

Replace bd_partno with a 32bit field (__bd_flags).  The lower 8 bits
contain the partition number, the upper 24 are for flags.

Helpers: bdev_{test,set,clear}_flag(bdev, flag), with atomic_or()
and atomic_andnot() used to set/clear.

NOTE: this commit does not actually move any flags over there - they
are still bool fields.  As the result, it shifts the fields wrt
cacheline boundaries; that's going to be restored once the first
3 flags are dealt with.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 block/bdev.c              |  2 +-
 include/linux/blk_types.h |  3 ++-
 include/linux/blkdev.h    | 17 ++++++++++++++++-
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 7a5f611c3d2e..2ec223315500 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -411,7 +411,7 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
 	mutex_init(&bdev->bd_fsfreeze_mutex);
 	spin_lock_init(&bdev->bd_size_lock);
 	mutex_init(&bdev->bd_holder_lock);
-	bdev->bd_partno = partno;
+	atomic_set(&bdev->__bd_flags, partno);
 	bdev->bd_inode = inode;
 	bdev->bd_queue = disk->queue;
 	if (partno)
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index cb1526ec44b5..04f92737ab08 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -45,8 +45,9 @@ struct block_device {
 	struct request_queue *	bd_queue;
 	struct disk_stats __percpu *bd_stats;
 	unsigned long		bd_stamp;
+	atomic_t		__bd_flags;	// partition number + flags
+#define BD_PARTNO		255	// lower 8 bits; assign-once
 	bool			bd_read_only;	/* read-only policy */
-	u8			bd_partno;
 	bool			bd_write_holder;
 	bool			bd_has_submit_bio;
 	dev_t			bd_dev;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 32549d675955..99917e5860fd 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -722,7 +722,22 @@ void disk_uevent(struct gendisk *disk, enum kobject_action action);
 
 static inline u8 bdev_partno(const struct block_device *bdev)
 {
-	return bdev->bd_partno;
+	return atomic_read(&bdev->__bd_flags) & BD_PARTNO;
+}
+
+static inline bool bdev_test_flag(const struct block_device *bdev, unsigned flag)
+{
+	return atomic_read(&bdev->__bd_flags) & flag;
+}
+
+static inline void bdev_set_flag(struct block_device *bdev, unsigned flag)
+{
+	atomic_or(flag, &bdev->__bd_flags);
+}
+
+static inline void bdev_clear_flag(struct block_device *bdev, unsigned flag)
+{
+	atomic_andnot(flag, &bdev->__bd_flags);
 }
 
 static inline int get_disk_ro(struct gendisk *disk)
-- 
2.39.2


