Return-Path: <linux-fsdevel+bounces-18551-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7528BA455
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 02:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 869B21C214FE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 00:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFD4EC0;
	Fri,  3 May 2024 00:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="RRlonU6a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A4B23BE;
	Fri,  3 May 2024 00:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714694992; cv=none; b=O4QUemcMV9MFydO7SIlEPWvVyxT3Bw20vD80qc1rlXAcA24xIvOjf+KgilRxkJ7mt2XYKBNiKOdDAeex4hBd9XHD9ULTvhhojR+1xihF9mXxQGS5xv+h6+TOnMMrj+IBQVlQqnTaP2zQMrRt0RasvOpyK60Vuz9PT2Ud27MrJz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714694992; c=relaxed/simple;
	bh=D8AkZRzETStIuPLnD7JFVBUqMyBCxWhPezAy7TndIH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qG76cSeDBGlr3h1aK2iSOOG4a5HHFaySv0xTJYk1/+ix/jxdyqDSyTYjgnKDzdV/+8oVkhnc+yKH+CrFVGKG4lununrOKnGZKxhSRjQym4qzSxNx19feW8iEaE9ksREBnO9MFPZWVUTXPYcPg3RjM78fImkRyMQsqZdY683ddxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=RRlonU6a; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+zX/QCk99sTeJ4dtEAX8EjuXv+zzqKzaQmfxxlcg1Wg=; b=RRlonU6arumTzmeRtFIaoB0c0q
	pHXGy60vz+AZhJjGnZmk3qyMfs1yI04zAghogCQFVmjQ/U0PjYGmO5inwRPciUiwPE+vxnPdlVtMX
	zLdspbaBK18uz2V+ysZ/0YfuaacrfJuTbpmpgiuhp8CZCuRLVbiOOUPF1PiquQQHGAFPNEYLwHHyZ
	yzQb2gT5md4iFTS0iwjOwLoNLM52/2j8FHEhA6jFaiLJaMGTfgfWMSayLzJ3BeF3QdXNCLyHZNJUZ
	6gGiZHxc1tGfwn6smsaBHMz6OD3GOUeoXoKHfsqJCJCaoPB5IEVrmGTmu9stqlNxWszoR/LZZUGFS
	Q0NrncQw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s2gUn-009tNd-1D;
	Fri, 03 May 2024 00:09:49 +0000
Date: Fri, 3 May 2024 01:09:49 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-fsdevel@vger.kernel.org, Yu Kuai <yukuai1@huaweicloud.com>,
	linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2 5/8] bdev: move ->bd_write_holder into ->__bd_flags
Message-ID: <20240503000949.GE2357260@ZenIV>
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
 block/bdev.c              | 9 +++++----
 include/linux/blk_types.h | 2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 2ec223315500..9df9a59f0900 100644
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
index f70dd31cbcd1..e45a490d488e 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -48,7 +48,7 @@ struct block_device {
 	atomic_t		__bd_flags;	// partition number + flags
 #define BD_PARTNO		255	// lower 8 bits; assign-once
 #define BD_READ_ONLY		(1u<<8) // read-only policy
-	bool			bd_write_holder;
+#define BD_WRITE_HOLDER		(1u<<9)
 	bool			bd_has_submit_bio;
 	dev_t			bd_dev;
 	struct inode		*bd_inode;	/* will die */
-- 
2.39.2


