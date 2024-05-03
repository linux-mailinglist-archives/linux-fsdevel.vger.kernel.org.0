Return-Path: <linux-fsdevel+bounces-18550-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C218BA453
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 02:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F04A82814F8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 00:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95AB61370;
	Fri,  3 May 2024 00:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="hIn4o+Kx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885F3363;
	Fri,  3 May 2024 00:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714694956; cv=none; b=mU/Zolp2KNg3L9nH6J9J7lJbbDC7lgDoh73t63a5NB9clFTpIUyN96nHivlOHhYC1V50B1SDM4qXdpea4ba5GSaukxEdOqBVwKiL5+7GJk2PhjbgHTRnnSIeD9MmDoJPF5z1+12jQS1lxZeLjYSU7OpplfQQtTCCmj7mrLJ0aPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714694956; c=relaxed/simple;
	bh=cojsWIeyfGiLhxm2tPqb2vAQ5hT5Z34uEOctYj0O3Pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G4T/Env5mTZ3zR4yhUB5j9K2AA+h+/nlJFVGo5kNCTlptIS26ocywZLCrgjTgutvw3VOPFBEgNAnPenZj69LYyjK/vIyFOSzMlMT8o8raS98lCdDrbr2e+kY0leBWvNmrp+w13vhba/4kWOemWEdA6f7C7Am1tit36CrQdoc44k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=hIn4o+Kx; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=n4Ft2/FYJcfjKPznnQzW16Cvd+WdR+TnW1ctICzNXeo=; b=hIn4o+KxMIZn2p0bbE3P3ZyKlk
	2LueSK00h43Ip/TxrOesHyPlJhNDsfwNcjjxe1vMbwQmim3qjpYCQ80Q9AZbYNd64cl49HG2pXqR6
	Zcb/EZc4Lmcsxy/EOB5psfgELw4hhwsYIOl+iHV5p8AsMws0AmevVozytJ9OyHH9IxvKVLtuy0z93
	UsluT5mKCKTbhgFCxCKHohGn2Kg9EXNkVAc9qKY4N6XWvvJz06MSfS8627uuD0ngnA3l7f8/0QTVC
	v1NWKc2TeugSR0YLitn/IJRoBrKrFufMJBEpA97BbNfD/LJ5/FGfJWtlbD0LnVAvZiBkRBuB4Dn8b
	xuTzSOFA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s2gUD-009tLf-0M;
	Fri, 03 May 2024 00:09:13 +0000
Date: Fri, 3 May 2024 01:09:13 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-fsdevel@vger.kernel.org, Yu Kuai <yukuai1@huaweicloud.com>,
	linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2 4/8] bdev: move ->bd_read_only to ->__bd_flags
Message-ID: <20240503000913.GD2357260@ZenIV>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 block/ioctl.c             | 5 ++++-
 include/linux/blk_types.h | 2 +-
 include/linux/blkdev.h    | 4 ++--
 3 files changed, 7 insertions(+), 4 deletions(-)

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
index 04f92737ab08..f70dd31cbcd1 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -47,7 +47,7 @@ struct block_device {
 	unsigned long		bd_stamp;
 	atomic_t		__bd_flags;	// partition number + flags
 #define BD_PARTNO		255	// lower 8 bits; assign-once
-	bool			bd_read_only;	/* read-only policy */
+#define BD_READ_ONLY		(1u<<8) // read-only policy
 	bool			bd_write_holder;
 	bool			bd_has_submit_bio;
 	dev_t			bd_dev;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 99917e5860fd..1fe91231f85b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -742,13 +742,13 @@ static inline void bdev_clear_flag(struct block_device *bdev, unsigned flag)
 
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


