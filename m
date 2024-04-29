Return-Path: <linux-fsdevel+bounces-18120-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCB48B5F7E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 19:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ACB9283FA8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 17:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DF786640;
	Mon, 29 Apr 2024 17:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="a4NDn8EA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA22F8595F;
	Mon, 29 Apr 2024 17:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714410137; cv=none; b=I+JpNg0AnHoHiKMNRpODicAl0ocZ1OUAmMAollOR6TEg7VLlvi9gZdeqqb9AOfvR0QOsBdxGtaWV4ew/6WNUIJzkQ6PHpjAI1ChFgBBqx3Uo0rORJFfq8zIGiEAkprB+tKT17etUG0gXWRcr7YETg7Ifiksi7ZskuBmy0RFEH+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714410137; c=relaxed/simple;
	bh=bSBKbk0dakvui62/1/gpj5Gf+LvIq6ltNpq6o8uujCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ibg0QbpUUHnyFh34Dzfe6/6W1P1wjmEh8zsbi+NlBesiPGXNUbL05Vo4LMvA89RMOdHmOI/Hi4NaMm0v8+K/OguCo+EnuVYwRrYDDc+lPkDgLxnxW+2/AO3uMk8WD1XeNGmeJgLO3nO5434DWMATPPpdtHQQYTQ7pmrT3PfR+wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=a4NDn8EA; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yTC+bWVgM4SBE+HjKOSSMptE8ndZVGdRXrI5RUQIhsY=; b=a4NDn8EAViKGB748ph/GzB4yNx
	EkE+vTWSQuoylM13u+ONh7KVF/Pgil71T79f5ICgoA89/ysBKdIi80oROhm/m0i5bBrLq1YWxmL26
	i6REVIhwhHnUCr24FrrCSIXAO+OcBDq+/NHZnbktqvrEoMA1VvapdGLUVYkEoODyygxnKe9jJjfZ0
	8BUWCMVqMiGYFbFVrho7QavIjwkUrtH4fv+TZRI91Q3boVuvA4QctoC3yeT51WfqbKbV9aSSU2HBd
	BBNpPTXzdcOuoGifoqa2Z5Ff9dWFDs7Jpbu4eo9ZvdEWwh/ftQIHkM4ZOE7493EVMf13X0QBxMkGV
	Z+XJk1Cw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s1UOH-007Hz0-1Z;
	Mon, 29 Apr 2024 17:02:09 +0000
Date: Mon, 29 Apr 2024 18:02:09 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-fsdevel@vger.kernel.org, Yu Kuai <yukuai1@huaweicloud.com>,
	linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCHES][RFC] packing struct block_device flags
Message-ID: <20240429170209.GA2118490@ZenIV>
References: <20240428051232.GU2118490@ZenIV>
 <20240429052315.GB32688@lst.de>
 <20240429073107.GZ2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429073107.GZ2118490@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Apr 29, 2024 at 08:31:07AM +0100, Al Viro wrote:

> FWIW, we could go for atomic_t there and use
> 	atomic_read() & 0xff
> for partno, with atomic_or()/atomic_and() for set/clear and
> atomic_read() & constant for test.  That might slightly optimize
> set/clear on some architectures, but setting/clearing flags is
> nowhere near hot enough for that to make a difference.

Incremental for that (would be folded into 3/8 if we went that way)
is below; again, I'm not at all sure it's idiomatic enough to bother
with, but that should at least show what's going on:

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
index 98e1c2d28d60..a822911e28e5 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -45,7 +45,7 @@ struct block_device {
 	struct request_queue *	bd_queue;
 	struct disk_stats __percpu *bd_stats;
 	unsigned long		bd_stamp;
-	u32			__bd_flags;	// partition number + flags
+	atomic_t		__bd_flags;	// partition number + flags
 	dev_t			bd_dev;
 	struct inode		*bd_inode;	/* will die */
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d556cec9224b..a8271497ac62 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -722,38 +722,22 @@ void disk_uevent(struct gendisk *disk, enum kobject_action action);
 
 static inline u8 bdev_partno(const struct block_device *bdev)
 {
-	return bdev->__bd_flags & 0xff;
+	return atomic_read(&bdev->__bd_flags) & 0xff;
 }
 
 static inline bool bdev_test_flag(const struct block_device *bdev, int flag)
 {
-	return bdev->__bd_flags & (1 << (flag + 8));
+	return atomic_read(&bdev->__bd_flags) & (1 << (flag + 8));
 }
 
 static inline void bdev_set_flag(struct block_device *bdev, int flag)
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
+	atomic_or(1 << (flag + 8), &bdev->__bd_flags);
 }
 
 static inline void bdev_clear_flag(struct block_device *bdev, int flag)
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
+	atomic_and(~(1 << (flag + 8)), &bdev->__bd_flags);
 }
 
 static inline int get_disk_ro(struct gendisk *disk)

