Return-Path: <linux-fsdevel+bounces-42316-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6543CA402DF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 23:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5047A18995ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 22:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E3C255E34;
	Fri, 21 Feb 2025 22:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qfI+6CVA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DDE2054EC;
	Fri, 21 Feb 2025 22:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740177512; cv=none; b=vGBKeR9Aa4HIeu9Zd8eMPNXtXKGlYxESaKhoWbaEpZG1OONCjiSh0Y82m1tUg9qx8hdx9VNbgst/O2jzucHVI96/MBiqpGbovVF8UxtQwjvWr0eIea3urhEh65oRpSb3tycV0Hp4El/LST2Q+J7+qtMamHE9L3VfLkro1xkQ3lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740177512; c=relaxed/simple;
	bh=cpFeSl7V1siK2jIrJWc8/1O6vqPGiI+x+UOItHwJfNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q7JeKQAjLg3SAFJ9iZUz5PLDT6Bins2GYXh5LyA1EZFmKoT4wGv/cUB34CFb+0lu9JVM7uYykghzBqzydcLBqCV9PPCrdd+m26yUoce3cAHFVyr+UWivd06RT35Yaackk7U4smIwiIeLUS0CnV6SeCaZmoVVnLTR7JkYLYMcURc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qfI+6CVA; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=dPYsaEMRasFiFhMNTtOpkluc57HIzwvU4rUiMYmi9nk=; b=qfI+6CVA3tipgW2HoFB+Sph6kC
	ojVbYPteH2HN9YNIRQNgabxVOxbyu3vzNyWvcv3QbydCSqjtYEdETy6GhjYsXGmXOCgLRADt5Riul
	gId1AxDN9dF2oJR5t3/LL0ik7MU+eLrERaAhdwNDmE+OwEgiGDfgIepYOT7kwkzzJ7oOkWQt5vtyx
	f9kws4SbOJoxp26AbIBPJq6lE0zge4Mc3mCg891tFx45dI0gbb4dw2do/e3cbtflZ1JWK7hmP3Fxk
	oeIUsxXFbB/ahkHzLQcFsLTsiMgkf978tsMNCly6+41cEHR4AljXIfdUIbUuP0CE6LZ+QsyN1B5cn
	gBsm3zOQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tlbf7-000000073DH-49mH;
	Fri, 21 Feb 2025 22:38:25 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: brauner@kernel.org,
	akpm@linux-foundation.org,
	hare@suse.de,
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
Subject: [PATCH v3 8/8] bdev: use bdev_io_min() for statx block size
Date: Fri, 21 Feb 2025 14:38:23 -0800
Message-ID: <20250221223823.1680616-9-mcgrof@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221223823.1680616-1-mcgrof@kernel.org>
References: <20250221223823.1680616-1-mcgrof@kernel.org>
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

Reviewed-by: Hannes Reinecke <hare@suse.de>
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
2.47.2


