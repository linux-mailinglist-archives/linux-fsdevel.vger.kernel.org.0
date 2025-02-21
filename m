Return-Path: <linux-fsdevel+bounces-42320-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F53A402E5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 23:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E83A97ADBEF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 22:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DCE205500;
	Fri, 21 Feb 2025 22:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KovaJ9el"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1658220966B;
	Fri, 21 Feb 2025 22:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740177512; cv=none; b=DLvxcMij9fRn/8exeNQ2ozpMoy439i9VPdW+cO7wKzrwYl/AcKZn8Kawy+1V5OLvuTyiUu8dPzVZynLJxxyIx71GK+OQaEvHASC9q+uDa5XuEHofhgdeiujYMt1/3XIQbXyzi1O2X4gnnwl7JTS5SMVr0EE8iy13M6ZovTvunZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740177512; c=relaxed/simple;
	bh=S/We1UmV8DPFMcyNwpf63ueboaDW9xHq67ntzhpX6Qg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P6/hikXKvo4mcfdQEqZRVQBdK1oNgy/Aj5mQHFeN+F8tOQIz97HWOl8yPQFxo36Jhdbeuq9zLvgWH8gOhkYIrN+fx5kyW8I7pn7hSNncyyhYRucpNRwSGGERvUNj9cff3mO5MkSsqKQ6zpNBDKJR2YQl6prmBsQirGsAVL9nFko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KovaJ9el; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=uqPIF+VvQBHBH50rSFfIRgR8/dA90Fp8sC9NPmrqGVY=; b=KovaJ9elkLijktp/Abx8dRypXr
	DRIMF2gDcno3sOYSd7AGjBhj7LPwqbloLT/XVcG9RyJjaqI0uBUiA0CHb97ewv5bYFhn04oQmPtqJ
	l9yUhtcJXseNVC7p6LDh8imdU0/Htn7uzKBiNWzZfcKCSixHqG1iZ3KmQJOEdWnvNH6jIf2Q5sPaV
	xv9i4Tb8GOLEZEeiRfuTie8IDbiq+Ce++8Kzl6AYKumyoPHbtCeAirWEII6l6/u5NLm/2BmmwCx2A
	sB8eSjBO5fTJeTXRUXGEzwTD1o1+uGCxPwQy+zwwJC1zFciCUVgZqlyDFUmwxhnQLEzs7RNExo3Cw
	kHeAkTkQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tlbf7-000000073DF-40fU;
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
Subject: [PATCH v3 7/8] block/bdev: lift block size restrictions to 64k
Date: Fri, 21 Feb 2025 14:38:22 -0800
Message-ID: <20250221223823.1680616-8-mcgrof@kernel.org>
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

We now can support blocksizes larger than PAGE_SIZE, so in theory
we should be able to lift the restriction up to the max supported page
cache order. However bound ourselves to what we can currently validate
and test. Through blktests and fstest we can validate up to 64k today.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 block/bdev.c           | 3 +--
 include/linux/blkdev.h | 8 +++++++-
 2 files changed, 8 insertions(+), 3 deletions(-)

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
index 248416ecd01c..a97428e8bbbe 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -267,10 +267,16 @@ static inline dev_t disk_devt(struct gendisk *disk)
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
2.47.2


