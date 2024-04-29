Return-Path: <linux-fsdevel+bounces-18160-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC99C8B60EC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 20:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79EC21F21FE7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 18:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250FC128801;
	Mon, 29 Apr 2024 18:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="jiXcY+qv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7C18614C;
	Mon, 29 Apr 2024 18:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714414387; cv=none; b=OKAcxRp8NFUyf/IwxFZUqjtm7SY1p7M5wraFg7osqcFU+3O6wPWWHhk6oKCGwXyMM9e/E3E4kMx9hYN//BY0YQArteTZNTvfoebCDvUuwNk9a1ge7j1zm9Lsftsi0pn6FERCU5f1+7tRmdSdJSJALBwsoSy2Y44sXfWosHAyuEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714414387; c=relaxed/simple;
	bh=a1MUGGOsPjOinLqQL1aKrDAKEHT6VEg9k7ZpxVV/tHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W7mMsyERnR2awW7eNung0upVLIcnPulhcWwfJYLxifSgRCVTdutUN8eVmocvRxZeDyJTYRRzt15x8iEnOafwKTpmuIPNX0C98z8X+UWP039DmR0dnl3WSPN7O/Gd7L8mFWTpTstzjLfE+h7jMpul0hkKNayb2bQmTEUIf1bCiP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=jiXcY+qv; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+gQ4lAgh+c69lkImMu4Jk/3ygyXJQ5I6/BKa36fUNXs=; b=jiXcY+qvHIRbIWvc/bmmOcPEDB
	my0wuN+CucD51s/m8tNb8m6yUhyM3Ocv3buZo7gdjSz9YoFKsZjySjlR1eMoD2Vnty6Jq6RA5I6nm
	duj3eGFFiRSNUGByVUVQpO1Hm8NQ+Dw2Rftc35pT/wakY4SDQqemTvVuHwXGSzn4QM/EDYWoRWG9J
	iMfbCSn9HLrVnGcmMykwTHknlpZKGUDJSslnoBWOLSd/EM1jsM4tGHQEDngCMxhODIylBU8fNmlbI
	k6da6nAdS1GkLgDwZtGLSf4G7MpNjvbhegnhPmFewrTu4lL8g8CPpt7veCF5pqY88Q4L7h1oKK1WC
	7SAefRbQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s1VUq-007JJ2-1p;
	Mon, 29 Apr 2024 18:13:00 +0000
Date: Mon, 29 Apr 2024 19:13:00 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-fsdevel@vger.kernel.org, Yu Kuai <yukuai1@huaweicloud.com>,
	linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCHES][RFC] packing struct block_device flags
Message-ID: <20240429181300.GB2118490@ZenIV>
References: <20240428051232.GU2118490@ZenIV>
 <20240429052315.GB32688@lst.de>
 <20240429073107.GZ2118490@ZenIV>
 <20240429170209.GA2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429170209.GA2118490@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Apr 29, 2024 at 06:02:09PM +0100, Al Viro wrote:
> On Mon, Apr 29, 2024 at 08:31:07AM +0100, Al Viro wrote:
> 
> > FWIW, we could go for atomic_t there and use
> > 	atomic_read() & 0xff
> > for partno, with atomic_or()/atomic_and() for set/clear and
> > atomic_read() & constant for test.  That might slightly optimize
> > set/clear on some architectures, but setting/clearing flags is
> > nowhere near hot enough for that to make a difference.
> 
> Incremental for that (would be folded into 3/8 if we went that way)
> is below; again, I'm not at all sure it's idiomatic enough to bother
> with, but that should at least show what's going on:

Or this, for that matter:

diff --git a/block/bdev.c b/block/bdev.c
index 9aa23620fe92..fae30eae7741 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -411,7 +411,7 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
 	mutex_init(&bdev->bd_fsfreeze_mutex);
 	spin_lock_init(&bdev->bd_size_lock);
 	mutex_init(&bdev->bd_holder_lock);
-	bdev->__bd_flags = partno;
+	atomic_set(&bdev->__bd_flags, partno);
 	bdev->bd_inode = inode;
 	bdev->bd_queue = disk->queue;
 	if (partno && bdev_test_flag(disk->part0, BD_HAS_SUBMIT_BIO))
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 98e1c2d28d60..84bfc702269a 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -45,7 +45,15 @@ struct block_device {
 	struct request_queue *	bd_queue;
 	struct disk_stats __percpu *bd_stats;
 	unsigned long		bd_stamp;
-	u32			__bd_flags;	// partition number + flags
+	atomic_t		__bd_flags;
+#define BD_PARTNO		255	// lower 8 bits; assign-once
+#define BD_READ_ONLY		(1u<<8) // read-only policy
+#define BD_WRITE_HOLDER		(1u<<9)
+#define BD_HAS_SUBMIT_BIO	(1u<<10)
+#define BD_RO_WARNED		(1u<<11)
+#ifdef CONFIG_FAIL_MAKE_REQUEST
+#define BD_MAKE_IT_FAIL		(1u<<12)
+#endif
 	dev_t			bd_dev;
 	struct inode		*bd_inode;	/* will die */
 
@@ -79,16 +87,6 @@ struct block_device {
 #define bdev_kobj(_bdev) \
 	(&((_bdev)->bd_device.kobj))
 
-enum {
-	BD_READ_ONLY,		// read-only policy
-	BD_WRITE_HOLDER,
-	BD_HAS_SUBMIT_BIO,
-	BD_RO_WARNED,
-#ifdef CONFIG_FAIL_MAKE_REQUEST
-	BD_MAKE_IT_FAIL,
-#endif
-};
-
 /*
  * Block error status values.  See block/blk-core:blk_errors for the details.
  * Alpha cannot write a byte atomically, so we need to use 32-bit value.
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d556cec9224b..1fe91231f85b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -722,38 +722,22 @@ void disk_uevent(struct gendisk *disk, enum kobject_action action);
 
 static inline u8 bdev_partno(const struct block_device *bdev)
 {
-	return bdev->__bd_flags & 0xff;
+	return atomic_read(&bdev->__bd_flags) & BD_PARTNO;
 }
 
-static inline bool bdev_test_flag(const struct block_device *bdev, int flag)
+static inline bool bdev_test_flag(const struct block_device *bdev, unsigned flag)
 {
-	return bdev->__bd_flags & (1 << (flag + 8));
+	return atomic_read(&bdev->__bd_flags) & flag;
 }
 
-static inline void bdev_set_flag(struct block_device *bdev, int flag)
+static inline void bdev_set_flag(struct block_device *bdev, unsigned flag)
 {
-	u32 v = bdev->__bd_flags;
-
-	for (;;) {
-		u32 w = cmpxchg(&bdev->__bd_flags, v, v | (1 << (flag + 8)));
-
-		if (v == w)
-			return;
-		v = w;
-	}
+	atomic_or(flag, &bdev->__bd_flags);
 }
 
-static inline void bdev_clear_flag(struct block_device *bdev, int flag)
+static inline void bdev_clear_flag(struct block_device *bdev, unsigned flag)
 {
-	u32 v = bdev->__bd_flags;
-
-	for (;;) {
-		u32 w = cmpxchg(&bdev->__bd_flags, v, v & ~(1 << (flag + 8)));
-
-		if (v == w)
-			return;
-		v = w;
-	}
+	atomic_andnot(flag, &bdev->__bd_flags);
 }
 
 static inline int get_disk_ro(struct gendisk *disk)

