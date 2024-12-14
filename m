Return-Path: <linux-fsdevel+bounces-37412-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EAE9F1C54
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2024 04:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC3CB188CFF9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2024 03:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE00C15DBB3;
	Sat, 14 Dec 2024 03:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rqjr9k1z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B73F25765;
	Sat, 14 Dec 2024 03:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734145861; cv=none; b=GKS5G+3FEEw0IwFPyVwu3FeUQXIElOxuQf3LgCsXPEmYIJx2NETaG5zrzIl8sxhrXZ3cNvnZfgDYS6ZzhO72RdsAFYvKCzUl114GKt2uyA40GX4ZKLQHd6UIiUme9q4qJTrw4Q16CqwKjO2Gfz9ffp+Bcg0QnMPgWJ+GEUXwsKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734145861; c=relaxed/simple;
	bh=xXw6E+HkHMk+5jlnDPXJyxIJ7c9aWW7APmbJz64rOq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hk8Dmb7juHtfU+DQ6BQYe8ddrZLL4s+c2LgcHXjJ/gJJu7S7GQvNcF6DNSHlIVAcNYSQvvfT9z2VRP0OQ+11eqQbIxdVLg1cOECS1djdLI8Z9i0vynyNbvuYmzQB1RUhrHFmyHJsf7PEjzrvK2lsszfx4N5fiGqWTKWFyhcCM2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rqjr9k1z; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=QwW6+QbJTlSFLC3FzzKGoyGuJ59VODNiRzXn4st2nlY=; b=rqjr9k1z6khTpfp/RfwgO2EvnD
	k52jL8QOpAlYrZREH8RLqgl823+evliu61hP3EYJT2SyxbKDjFF6QIbCTLEXl6zNtz7rtY9ibW1XX
	9G53kXlos5RYGUGI0eTPtAixrTTPmMTWq9gMwJOIXzq27iu+8EcpEKpwuV4Y5e5HX8Iu0HoNtW9Hh
	3suyN6IBf1BSA7JSl8RBtjp2PWaw+GXqawh3KLsERTN1DmlWP7edWp622G5Pif3PYfCeqLljzTire
	7wzDzx+BFmYz7jXqjtZF0ZogUuuKCv57HOKzkkML/yQwXYfR4DRqneo5wBLssOM58W7xyPgGpl+eg
	8Qvtpm0A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tMIYO-00000005c3t-0MSX;
	Sat, 14 Dec 2024 03:10:52 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: willy@infradead.org,
	hch@lst.de,
	hare@suse.de,
	dave@stgolabs.net,
	david@fromorbit.com,
	djwong@kernel.org
Cc: john.g.garry@oracle.com,
	ritesh.list@gmail.com,
	kbusch@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	gost.dev@samsung.com,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	kernel@pankajraghav.com,
	mcgrof@kernel.org
Subject: [RFC v2 11/11] bdev: use bdev_io_min() for statx block size
Date: Fri, 13 Dec 2024 19:10:49 -0800
Message-ID: <20241214031050.1337920-12-mcgrof@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241214031050.1337920-1-mcgrof@kernel.org>
References: <20241214031050.1337920-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

You can use lsblk to query for a block device block device block size:

lsblk -o MIN-IO /dev/nvme0n1
MIN-IO
 4096

The min-io is the minimum IO the block device prefers for optimal
performance. In turn we map this to the block device block size.
The current block size exposed even for block devices with an
LBA format of 16k is 4k. Likewise devices which support 4k LBA format
but have a larger Indirection Unit of 16k have an exposed block size
of 4k.

This incurs read-modify-writes on direct IO against devices with a
min-io larger than the page size. To fix this, use the block device
min io, which is the minimal optimal IO the device prefers.

With this we now get:

lsblk -o MIN-IO /dev/nvme0n1
MIN-IO
 16384

And so userspace gets the appropriate information it needs for optimal
performance. This is verified with blkalgn against mkfs against a
device with LBA format of 4k but an NPWG of 16k (min io size)

mkfs.xfs -f -b size=16k  /dev/nvme3n1
blkalgn -d nvme3n1 --ops Write

     Block size          : count     distribution
         0 -> 1          : 0        |                                        |
         2 -> 3          : 0        |                                        |
         4 -> 7          : 0        |                                        |
         8 -> 15         : 0        |                                        |
        16 -> 31         : 0        |                                        |
        32 -> 63         : 0        |                                        |
        64 -> 127        : 0        |                                        |
       128 -> 255        : 0        |                                        |
       256 -> 511        : 0        |                                        |
       512 -> 1023       : 0        |                                        |
      1024 -> 2047       : 0        |                                        |
      2048 -> 4095       : 0        |                                        |
      4096 -> 8191       : 0        |                                        |
      8192 -> 16383      : 0        |                                        |
     16384 -> 32767      : 66       |****************************************|
     32768 -> 65535      : 0        |                                        |
     65536 -> 131071     : 0        |                                        |
    131072 -> 262143     : 2        |*                                       |
Block size: 14 - 66
Block size: 17 - 2

     Algn size           : count     distribution
         0 -> 1          : 0        |                                        |
         2 -> 3          : 0        |                                        |
         4 -> 7          : 0        |                                        |
         8 -> 15         : 0        |                                        |
        16 -> 31         : 0        |                                        |
        32 -> 63         : 0        |                                        |
        64 -> 127        : 0        |                                        |
       128 -> 255        : 0        |                                        |
       256 -> 511        : 0        |                                        |
       512 -> 1023       : 0        |                                        |
      1024 -> 2047       : 0        |                                        |
      2048 -> 4095       : 0        |                                        |
      4096 -> 8191       : 0        |                                        |
      8192 -> 16383      : 0        |                                        |
     16384 -> 32767      : 66       |****************************************|
     32768 -> 65535      : 0        |                                        |
     65536 -> 131071     : 0        |                                        |
    131072 -> 262143     : 2        |*                                       |
Algn size: 14 - 66
Algn size: 17 - 2

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 block/bdev.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index b57dc4bff81b..b1be720bd485 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1277,9 +1277,6 @@ void bdev_statx(struct path *path, struct kstat *stat,
 	struct inode *backing_inode;
 	struct block_device *bdev;
 
-	if (!(request_mask & (STATX_DIOALIGN | STATX_WRITE_ATOMIC)))
-		return;
-
 	backing_inode = d_backing_inode(path->dentry);
 
 	/*
@@ -1306,6 +1303,8 @@ void bdev_statx(struct path *path, struct kstat *stat,
 			queue_atomic_write_unit_max_bytes(bd_queue));
 	}
 
+	stat->blksize = bdev_io_min(bdev);
+
 	blkdev_put_no_open(bdev);
 }
 
-- 
2.43.0


