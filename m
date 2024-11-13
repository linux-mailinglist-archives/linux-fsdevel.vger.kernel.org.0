Return-Path: <linux-fsdevel+bounces-34609-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2659C6BDB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 10:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38D3FB27CAC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 09:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0371F9405;
	Wed, 13 Nov 2024 09:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1H770m6u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D021F80CC;
	Wed, 13 Nov 2024 09:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731491256; cv=none; b=T9PhiPSduxMHM5x8hoeUxNP4xLABr5069Si6kbWfhZF4GyXpBJryMneXMRJ3DaVgbP6xTIQK5ZuGOSn9cpM4F31J/qMlnAFTwe0t9H2Hw5aTjvQT+JjEJA7JV2EbszffhWFUY5a0ggIVleKzL4S0apGncHDw/fZsjOWvt10qSIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731491256; c=relaxed/simple;
	bh=qSg4jt+PdvsngxRtEBRGA/FD6TRSDQUzeRkB8v2LbIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uUANPRsr4GE4H8dvxRom/6e3Oo9R2EEwwzFMbLJkagKIJTzqhgpYZKwumlR2SNQ4odoRtoO7p2mj5saJnLLRoOryiW50qFPFSeODc17JEzIP3oqPbx7i9Erja0tuL4/g8RoKOQJSgAC1Sct5gBKns7kpe/9JYCcXl2k0hkpHCjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1H770m6u; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Rvjs84UgO5xSGvxl4iuvzBP8tFGehN7pbV06CfLjg3U=; b=1H770m6uZYJRsNLnGwzs/TYE7f
	gf32SzSFjC1OTx+9oTWzt/eb3OBbFZPEnS9eIjfXxWb2HTKI5997hOMEui1NLkZv1f7ZdY6YplmdP
	Mn9yTxEs2W9zqrnuQ8d4vAi1CPHtUnxkWedaQYIDf6+IKguB19CZMmWo1EcTap6ncmUpff2BHGbls
	OLQBDRaZJ95iTWnESxDGpKVS5HBnmtTigRawlaWu+fwrooEVxq4Xo3C74IjethFWPkCoB6Shaj5wN
	f6u7NAfglv4r8Ldg9UVQvGW7LJMsZ4vtDoE7mP2PiT4MycJMnp0V90SMINbjT9496Ta+2gaUqvIUc
	c5nUp2MQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tB9yF-00000006He1-03jf;
	Wed, 13 Nov 2024 09:47:31 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: willy@infradead.org,
	hch@lst.de,
	hare@suse.de,
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
Subject: [RFC 8/8] bdev: use bdev_io_min() for statx block size
Date: Wed, 13 Nov 2024 01:47:27 -0800
Message-ID: <20241113094727.1497722-9-mcgrof@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241113094727.1497722-1-mcgrof@kernel.org>
References: <20241113094727.1497722-1-mcgrof@kernel.org>
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
 block/bdev.c | 1 +
 fs/stat.c    | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/bdev.c b/block/bdev.c
index 3a5fd65f6c8e..4dcc501ed953 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1306,6 +1306,7 @@ void bdev_statx(struct path *path, struct kstat *stat,
 			queue_atomic_write_unit_max_bytes(bd_queue));
 	}
 
+	stat->blksize = (unsigned int) bdev_io_min(bdev);
 	blkdev_put_no_open(bdev);
 }
 
diff --git a/fs/stat.c b/fs/stat.c
index 41e598376d7e..9b579c0b5153 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -268,7 +268,7 @@ static int vfs_statx_path(struct path *path, int flags, struct kstat *stat,
 	 * obtained from the bdev backing inode.
 	 */
 	if (S_ISBLK(stat->mode))
-		bdev_statx(path, stat, request_mask);
+		bdev_statx(path, stat, request_mask | STATX_DIOALIGN);
 
 	return error;
 }
-- 
2.43.0


