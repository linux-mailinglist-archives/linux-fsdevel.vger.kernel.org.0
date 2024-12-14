Return-Path: <linux-fsdevel+bounces-37404-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9089F1C3E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2024 04:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3054716AA3D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2024 03:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D3643166;
	Sat, 14 Dec 2024 03:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qL6vJdTy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944C417BA0;
	Sat, 14 Dec 2024 03:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734145860; cv=none; b=HNGm8YBifu1YP+dv0xH5j/nuthycCFCvZtDJ6qAXXBWU8UINzQGw+t9vUCDWD5EII2Z1BJzQa5l7b5LjJnDTVdsTOsDfnJVtUIvGDa11stCtrvj/oYgsweLvIrs6iitAJGOvqajYDKg5+94QdSY/QwmarYqkW81qnmsOtyUINls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734145860; c=relaxed/simple;
	bh=P3uVfLlVLJfHe4TSb4QwF1TtpfSmrcrLSBF0vRF6L7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AuWxW44nlSOTV4BV1Rcc7y4PJ61/xqdOCIhMPkvwIp3123AQeSOQMBLa58M86jVv+VX2TaUcpevNzF2soltlrdKI7w6Q1Jq1/1iVL/cCuutyMy3wiKNF4qmfdHMvJgJQKHrporNUphQbi946dvB5sqzk4h2CQ92mBUWS4dlyqok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qL6vJdTy; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=nLfCbW88XZtUGGKLjWBTHyDCe42vAPNXKRBtJR7DxnY=; b=qL6vJdTyzDGrY9BTzxUAOzoxWR
	GmyxjXs/ypIzQ4OBwJwjxzVHxTYl5WowwA8PlpzdvxsYCfAWKCxVKGzklNbFg+j9lyRrusBf2H2bo
	GLkVMnOTVZV/lpZd85GFZ1MVi81ANkvcUeR+JJE+WC+Wr3Z0gWG3fCONYfibpZ6l3jyduDgskVKBw
	zGXlDz4JQevtASwNKCWNnNAOsApI5OkuvhXNNNIaNtVIY0GOanrmRiewmyM4XTWoW+VYaF9Ch6GO/
	jAb+ekAcuFvILM50r3oh8PDu2OVvOax56B8d0fV1YdR3Auj0Fd26/gnSmPf68M1AcX68Sws/msj8r
	Mx/t0qRA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tMIYO-00000005c3p-05r5;
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
Subject: [RFC v2 09/11] block/bdev: lift block size restrictions and use common definition
Date: Fri, 13 Dec 2024 19:10:47 -0800
Message-ID: <20241214031050.1337920-10-mcgrof@kernel.org>
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

We now can support blocksizes larger than PAGE_SIZE, so lift
the restriction up to the max supported page cache order and
just bake this into a common helper used by the block layer.

We bound ourselves to 64k as a sensible limit. The hard limit,
however is 1 << (PAGE_SHIFT + MAX_PAGECACHE_ORDER).

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 block/bdev.c           |  5 ++---
 include/linux/blkdev.h | 11 ++++++++++-
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 167d82b46781..b57dc4bff81b 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -157,8 +157,7 @@ int set_blocksize(struct file *file, int size)
 	struct inode *inode = file->f_mapping->host;
 	struct block_device *bdev = I_BDEV(inode);
 
-	/* Size must be a power of two, and between 512 and PAGE_SIZE */
-	if (size > PAGE_SIZE || size < 512 || !is_power_of_2(size))
+	if (blk_validate_block_size(size))
 		return -EINVAL;
 
 	/* Size cannot be smaller than the size supported by the device */
@@ -185,7 +184,7 @@ int sb_set_blocksize(struct super_block *sb, int size)
 	if (set_blocksize(sb->s_bdev_file, size))
 		return 0;
 	/* If we get here, we know size is power of two
-	 * and it's value is between 512 and PAGE_SIZE */
+	 * and its value is larger than 512 */
 	sb->s_blocksize = size;
 	sb->s_blocksize_bits = blksize_bits(size);
 	return sb->s_blocksize;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 08a727b40816..a7303a55ed2a 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -269,10 +269,19 @@ static inline dev_t disk_devt(struct gendisk *disk)
 	return MKDEV(disk->major, disk->first_minor);
 }
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+/*
+ * The hard limit is (1 << (PAGE_SHIFT + MAX_PAGECACHE_ORDER).
+ */
+#define BLK_MAX_BLOCK_SIZE      (SZ_64K)
+#else
+#define BLK_MAX_BLOCK_SIZE      (PAGE_SIZE)
+#endif
+
 /* blk_validate_limits() validates bsize, so drivers don't usually need to */
 static inline int blk_validate_block_size(unsigned long bsize)
 {
-	if (bsize < 512 || bsize > PAGE_SIZE || !is_power_of_2(bsize))
+	if (bsize < 512 || bsize > BLK_MAX_BLOCK_SIZE || !is_power_of_2(bsize))
 		return -EINVAL;
 
 	return 0;
-- 
2.43.0


