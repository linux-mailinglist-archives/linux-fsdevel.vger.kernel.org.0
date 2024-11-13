Return-Path: <linux-fsdevel+bounces-34602-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A43959C6BCA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 10:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 699C5285B5A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 09:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F751F8921;
	Wed, 13 Nov 2024 09:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nnsxL9il"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447D81F77A9;
	Wed, 13 Nov 2024 09:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731491254; cv=none; b=jtOWGaJrGH9d59Oo5/qI37iMICxC3jeH8lREKfNSqF79bw4shhoxp6Wol66VsQqSkikmvoPnC1VSatH/yXZBwOz8UJSZvRnNp+ubmZu/ukqSqmFTOE2HO1hJ80hwjNvKi4sHJSDibhvDGE4LKHaoU2XpXpw7VqNN/GgJ3lncLME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731491254; c=relaxed/simple;
	bh=2FJKd9ZjX/FTjzZy+nKExvSSpawhvR4mGm3YEVReZfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NTM8BIHBDk+c6WurdT9X2i6VceHzfeYbwCyiStxuGGTXDZY+aqRU1w89AY4zh0Cwq+lwmlYBQRu8h2IphSKN+vw36NsyIELhquuUaqJaxLSAYxIATQpbRNwjyQTN+MaAKKVg+ZakqJCuHQl8z9K9Y05QVW0U6h8HVmmgCMAzMow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nnsxL9il; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=SXlfkrrZjaYgmSwcVorAtVLJKuW9IZECB9TbzjdaaSk=; b=nnsxL9ilFCNXXb8XhHktNx4MtI
	eueIODYT+h0QJCHVLB/jX6H7i8oYtPkebZmAJMrKGkCXeLfajcxwviwkIyd9FN/O6mcx+ei3jsMGL
	lLYSwGU07XuWI+g3iLP7d3UgjI/GLqQO5FhGaTKXyBny+WsdZmcUANr/lu9+td6m7vbxgo+er/c71
	m1qm8UVQjWYDifOi1BPw8cxpnWRkEGhaQ/6hn7WDAMT7LXbczwkuLlVFnKOGtIEPK/HkTXT1SJtR4
	Ln6zqu8vEI41CkdlDsnYzuTIs5RCI+Dvxy9LXbDxbN7izHu9D2k5p6f4GjegeLd5QXtVzuf05p6JJ
	4GE6mnkw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tB9yD-00000006HdK-1w0j;
	Wed, 13 Nov 2024 09:47:29 +0000
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
Subject: [RFC 6/8] block/bdev: lift block size restrictions and use common definition
Date: Wed, 13 Nov 2024 01:47:25 -0800
Message-ID: <20241113094727.1497722-7-mcgrof@kernel.org>
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

We now can support blocksizes larger than PAGE_SIZE, so lift
the restriction up to the max supported page cache order and
just bake this into a common helper used by the block layer.

We bound ourselves to 64k, because beyond that we need more testing.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 block/bdev.c           | 5 ++---
 include/linux/blkdev.h | 6 +++++-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 167d82b46781..3a5fd65f6c8e 100644
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
+	 * and it's value is larger than 512 */
 	sb->s_blocksize = size;
 	sb->s_blocksize_bits = blksize_bits(size);
 	return sb->s_blocksize;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 50c3b959da28..cc9fca1fceaa 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -25,6 +25,7 @@
 #include <linux/uuid.h>
 #include <linux/xarray.h>
 #include <linux/file.h>
+#include <linux/pagemap.h>
 
 struct module;
 struct request_queue;
@@ -268,10 +269,13 @@ static inline dev_t disk_devt(struct gendisk *disk)
 	return MKDEV(disk->major, disk->first_minor);
 }
 
+/* We should strive for 1 << (PAGE_SHIFT + MAX_PAGECACHE_ORDER) */
+#define BLK_MAX_BLOCK_SIZE      (SZ_64K)
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


