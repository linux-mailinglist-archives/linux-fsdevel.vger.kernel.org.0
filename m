Return-Path: <linux-fsdevel+bounces-40851-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0672A27F56
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 00:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4859F16302B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 23:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020A721CA19;
	Tue,  4 Feb 2025 23:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="btPrmYVU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E969C1FF7A5;
	Tue,  4 Feb 2025 23:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738710736; cv=none; b=qhC+4957EYgIidROCOmyZJ2IQkdrAlbBWEh5iIdm38v6+59TMBVALS5H6pykkMcMbejqEKdxjU2VgbfdxCm1XatrnBzBuQF88NwdFAQGyOrIJufpCwthwMeUOFtsmgH8i6S3iJber2yrKrjCLfA1grOZdKwghKELSBNEcjO4CXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738710736; c=relaxed/simple;
	bh=SmE0ANenCwNCRIh861iB/cVXFzTWu0vhYRGAtIA6Re4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eD5dE93zYvJ4G6CELBgYoOxbiVPOgZvOgAMxdpsQxy+CS4wFrr9p5Y1BGvQFYfmAh5Agg5vwXidvphObbwjRFztoT+GWQEliw4lB/xm/zNvH6CThYWUPW2nfcENyfoDIPozXRH7sw5OBNjpllpEILavkMfcd2FK5RHwwQsJGEVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=btPrmYVU; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=uOeLYsw9Sv9eePIry8YkgaAM0u7ucnWKFkLyfp328sM=; b=btPrmYVUIxv/PUPNXWIIMwBM6P
	xdr5bCfUDfEXVLeDiWlkcc9wcAAlPLtZcKGPl/KPku29F6Heroqfk02KMNylpMuKL7Plx2J0Is6pN
	r29mKYQRjTW2qgleR4u8VtGuYVSGPqq9kZpsczBByM/09yCXiLysvwsVPSRQAsqDj+akDHjW4yyY6
	lQx6hToYIMU3ptGlugC+owrMVO0Vzv/+2A5D0t9Y0gB4ZVnyMiVlPkCKl27D9rZR1EGoeRcC8nHKO
	hGbQrFB6d9WIpejPUoWvCwLG9N3tbA/1BoMoDt4Mt/VctQGHM6yhkDu+8qidTpDefS6Em56DHpcCr
	bHlfs/cQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tfS5T-00000001nhY-1xER;
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
Subject: [PATCH v2 7/8] block/bdev: lift block size restrictions to 64k
Date: Tue,  4 Feb 2025 15:12:08 -0800
Message-ID: <20250204231209.429356-8-mcgrof@kernel.org>
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

We now can support blocksizes larger than PAGE_SIZE, so in theory
we should be able to lift the restriction up to the max supported page
cache order. However bound ourselves to what we can currently validate
and test. Through blktests and fstest we can validate up to 64k today.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 block/bdev.c           | 3 +--
 include/linux/blkdev.h | 9 ++++++++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 8aadf1f23cb4..22806ce11e1d 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -183,8 +183,7 @@ int sb_set_blocksize(struct super_block *sb, int size)
 {
 	if (set_blocksize(sb->s_bdev_file, size))
 		return 0;
-	/* If we get here, we know size is power of two
-	 * and it's value is between 512 and PAGE_SIZE */
+	/* If we get here, we know size is validated */
 	sb->s_blocksize = size;
 	sb->s_blocksize_bits = blksize_bits(size);
 	return sb->s_blocksize;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 248416ecd01c..a89513302977 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -26,6 +26,7 @@
 #include <linux/xarray.h>
 #include <linux/file.h>
 #include <linux/lockdep.h>
+#include <linux/pagemap.h>
 
 struct module;
 struct request_queue;
@@ -267,10 +268,16 @@ static inline dev_t disk_devt(struct gendisk *disk)
 	return MKDEV(disk->major, disk->first_minor);
 }
 
+/*
+ * We should strive for 1 << (PAGE_SHIFT + MAX_PAGECACHE_ORDER)
+ * however we constrain this to what we can validate and test.
+ */
+#define BLK_MAX_BLOCK_SIZE      SZ_64K
+
 /* blk_validate_limits() validates bsize, so drivers don't usually need to */
 static inline int blk_validate_block_size(unsigned long bsize)
 {
-	if (bsize < 512 || bsize > PAGE_SIZE || !is_power_of_2(bsize))
+	if (bsize < 512 || bsize > BLK_MAX_BLOCK_SIZE || !is_power_of_2(bsize))
 		return -EINVAL;
 
 	return 0;
-- 
2.45.2


