Return-Path: <linux-fsdevel+bounces-40855-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4759A27F5F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 00:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EB9716362E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 23:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E83021E094;
	Tue,  4 Feb 2025 23:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0nzOxxML"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6BA21C187;
	Tue,  4 Feb 2025 23:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738710736; cv=none; b=h3OsAiwoDMoS3V5bpRFThoNfOzNNrD6yO9oqP31tu0y3xJ/IaP8AhORLrqpc/xT+Li6Mzx0hBJRjdFTH79FtMyaHIP7e8msMQipxr9rcvIF3JI//HITwtb9pwuj25YxazenX6HksNMb9JSdSQ4C92/3Nz3nXl413EYvsk3dWFFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738710736; c=relaxed/simple;
	bh=0il+T3BQ5n+k4lrS7bxTfATTMygd4Dtzc6zHZySEXRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wj3uuhWeYzca/28zBRdLxA71zx/Fzd8TNuKwttBymg1ciDu+MmXGnR+ShTel+UMrZ4FbLWa5GNFPXvIYuM0HFnCYL7cy9/bR/eon4hGOT8HyxPcRCNifE4FDd23+YZ7imazsY8pKotvumsZH7kMGOD8v5AXYm6MFhX71DqxpcRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0nzOxxML; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=vsI3NrYDCkaTTiln7YWklNd5/+H3Tzw74X2k8TbvG94=; b=0nzOxxMLwU+TflgBQMEtdhAsm8
	+xmsBu/qY0JwCI1dXIoV5MXYXGahDwQF1Ibbnvkoarthv7xByRdwPYPpQ/searzACLLZUcBGbwb/f
	hsWuhQ1VpcW+/la2tFAWJkaS4gmr4MAUuS+SdmOEHQkdAErpyyqnSP6+j1uLcQhyu+w7AJGOwPZH/
	5zwlFRBnUrjElWvfumBsjkqRVi3pBEMglKpJgQcR6fRgwwIzyz+3bubKGK8cPLv01+aHwHmYpzTSK
	yr+uAl+OC6m/bYnoo6CNNI0vb3mMHP96V+hxotakRfuquvEe2QcVD+tT4Xnj8F+kvdZGCm75aRJOF
	YAgjVBWw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tfS5T-00000001nha-261m;
	Tue, 04 Feb 2025 23:12:11 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: hare@suse.de,
	willy@infradead.org,
	dave@stgolabs.net,
	david@fromorbit.com,
	djwong@kernel.org,
	kbusch@kernel.org
Cc: john.g.garry@oracle.com,
	hch@lst.de,
	ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	gost.dev@samsung.com,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	kernel@pankajraghav.com,
	mcgrof@kernel.org
Subject: [PATCH v2 8/8] bdev: use bdev_io_min() for statx block size
Date: Tue,  4 Feb 2025 15:12:09 -0800
Message-ID: <20250204231209.429356-9-mcgrof@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250204231209.429356-1-mcgrof@kernel.org>
References: <20250204231209.429356-1-mcgrof@kernel.org>
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
index 22806ce11e1d..3bd948e6438d 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1276,9 +1276,6 @@ void bdev_statx(struct path *path, struct kstat *stat,
 	struct inode *backing_inode;
 	struct block_device *bdev;
 
-	if (!(request_mask & (STATX_DIOALIGN | STATX_WRITE_ATOMIC)))
-		return;
-
 	backing_inode = d_backing_inode(path->dentry);
 
 	/*
@@ -1305,6 +1302,8 @@ void bdev_statx(struct path *path, struct kstat *stat,
 			queue_atomic_write_unit_max_bytes(bd_queue));
 	}
 
+	stat->blksize = bdev_io_min(bdev);
+
 	blkdev_put_no_open(bdev);
 }
 
-- 
2.45.2


