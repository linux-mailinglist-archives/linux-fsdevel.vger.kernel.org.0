Return-Path: <linux-fsdevel+bounces-46151-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9C3A83600
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 03:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DB7419E8312
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 01:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2161DFDA1;
	Thu, 10 Apr 2025 01:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b/XLETIB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933E0198E8C;
	Thu, 10 Apr 2025 01:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744249793; cv=none; b=TG2hWxFIvyZbROjHXNTG6OUchurksOghjo9P1eLsU71P2VBmjR0akRLyPLz4eD3sA15FdZC7lxVQ0ONRX5oOYfIe6hB/aAGrPdcTmP8sIxqF38272eKm+oZ2kyuWzlz4mHqE7bv9O1Yo7IVqFcybDQbmIioLL5gEYgiEu+7+KD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744249793; c=relaxed/simple;
	bh=mu/+znPJJj83Q4VgB1jn93BxAWKUp778KoeI0b0ewhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uD4XV+Lmu8d33PX89WU+e61SKioK0zLU5yFrEsvEYy0CAQSNO1WtACh/jxLyDzLzlB4dDP0E7Mhrbb3ZglJ4uNTCmLHI/Euwsv0tVjU5ljPo/eN2AZUb1sp9i7mP7JFgHyTPBPmnO4d+gr8Novqh4XUFJ92NX3xZK+j5zRDMmnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=b/XLETIB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=1ZkQCLEfvSJJMcZUEvIWp91J3xZQH1qlm2s7wYby9N4=; b=b/XLETIB5KCHfGv4ObhFsAtZeg
	9PIOhDozbrjIiwkz8FCrVudBNh2xFJuJPCMRAZeWfEuT0B65+YA0mPvNkelPKXGYW70ztF80jFtrk
	+zk3ijWBp87lt6bqq3DJhsxWX9gTuF74Jnd9NmvK1ryYmCOivexotCIUtVE5uDZGyi3XDwy0R42J6
	hmwni0rd8Rx/vXlbvB/t2/Lj/REqtA8EpzSkQsol1GK/rc9TKvQvQBSVIAHKqYN5G9bju7WsHJS9q
	Qc3PJM/BXxCWo0oGP+Feqe48qlCXA0oi9dt8kdTsUCrc9P/4T1Apl74rogmqpTvs/ISX1C7WGRDtl
	KWtwGWeQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2h35-00000008yvH-3Pl7;
	Thu, 10 Apr 2025 01:49:47 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: brauner@kernel.org,
	jack@suse.cz,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	riel@surriel.com
Cc: dave@stgolabs.net,
	willy@infradead.org,
	hannes@cmpxchg.org,
	oliver.sang@intel.com,
	david@redhat.com,
	axboe@kernel.dk,
	hare@suse.de,
	david@fromorbit.com,
	djwong@kernel.org,
	ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	gost.dev@samsung.com,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	mcgrof@kernel.org
Subject: [PATCH v2 2/8] fs/buffer: try to use folio lock for pagecache lookups
Date: Wed,  9 Apr 2025 18:49:39 -0700
Message-ID: <20250410014945.2140781-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410014945.2140781-1-mcgrof@kernel.org>
References: <20250410014945.2140781-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

From: Davidlohr Bueso <dave@stgolabs.net>

Callers of __find_get_block() may or may not allow for blocking
semantics, and is currently assumed that it will not. Layout
two paths based on this. Ultimately the i_private_lock scheme will
be used as a fallback in non-blocking contexts. Otherwise
always take the folio lock instead. The suggested trylock idea
is implemented, thereby potentially reducing i_private_lock
contention in addition to later enabling future migration support
around with large folios and noref migration.

No change in semantics. All lookup users are non-blocking.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/buffer.c | 45 +++++++++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index c7abb4a029dc..5a1a37a6840a 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -176,18 +176,8 @@ void end_buffer_write_sync(struct buffer_head *bh, int uptodate)
 }
 EXPORT_SYMBOL(end_buffer_write_sync);
 
-/*
- * Various filesystems appear to want __find_get_block to be non-blocking.
- * But it's the page lock which protects the buffers.  To get around this,
- * we get exclusion from try_to_free_buffers with the blockdev mapping's
- * i_private_lock.
- *
- * Hack idea: for the blockdev mapping, i_private_lock contention
- * may be quite high.  This code could TryLock the page, and if that
- * succeeds, there is no need to take i_private_lock.
- */
 static struct buffer_head *
-__find_get_block_slow(struct block_device *bdev, sector_t block)
+__find_get_block_slow(struct block_device *bdev, sector_t block, bool atomic)
 {
 	struct address_space *bd_mapping = bdev->bd_mapping;
 	const int blkbits = bd_mapping->host->i_blkbits;
@@ -197,6 +187,7 @@ __find_get_block_slow(struct block_device *bdev, sector_t block)
 	struct buffer_head *head;
 	struct folio *folio;
 	int all_mapped = 1;
+	bool folio_locked = true;
 	static DEFINE_RATELIMIT_STATE(last_warned, HZ, 1);
 
 	index = ((loff_t)block << blkbits) / PAGE_SIZE;
@@ -204,7 +195,19 @@ __find_get_block_slow(struct block_device *bdev, sector_t block)
 	if (IS_ERR(folio))
 		goto out;
 
-	spin_lock(&bd_mapping->i_private_lock);
+	/*
+	 * Folio lock protects the buffers. Callers that cannot block
+	 * will fallback to serializing vs try_to_free_buffers() via
+	 * the i_private_lock.
+	 */
+	if (!folio_trylock(folio)) {
+		if (atomic) {
+			spin_lock(&bd_mapping->i_private_lock);
+			folio_locked = false;
+		} else
+			folio_lock(folio);
+	}
+
 	head = folio_buffers(folio);
 	if (!head)
 		goto out_unlock;
@@ -236,7 +239,10 @@ __find_get_block_slow(struct block_device *bdev, sector_t block)
 		       1 << blkbits);
 	}
 out_unlock:
-	spin_unlock(&bd_mapping->i_private_lock);
+	if (folio_locked)
+		folio_unlock(folio);
+	else
+		spin_unlock(&bd_mapping->i_private_lock);
 	folio_put(folio);
 out:
 	return ret;
@@ -1388,14 +1394,15 @@ lookup_bh_lru(struct block_device *bdev, sector_t block, unsigned size)
  * it in the LRU and mark it as accessed.  If it is not present then return
  * NULL
  */
-struct buffer_head *
-__find_get_block(struct block_device *bdev, sector_t block, unsigned size)
+static struct buffer_head *
+find_get_block_common(struct block_device *bdev, sector_t block,
+			unsigned size, bool atomic)
 {
 	struct buffer_head *bh = lookup_bh_lru(bdev, block, size);
 
 	if (bh == NULL) {
 		/* __find_get_block_slow will mark the page accessed */
-		bh = __find_get_block_slow(bdev, block);
+		bh = __find_get_block_slow(bdev, block, atomic);
 		if (bh)
 			bh_lru_install(bh);
 	} else
@@ -1403,6 +1410,12 @@ __find_get_block(struct block_device *bdev, sector_t block, unsigned size)
 
 	return bh;
 }
+
+struct buffer_head *
+__find_get_block(struct block_device *bdev, sector_t block, unsigned size)
+{
+	return find_get_block_common(bdev, block, size, true);
+}
 EXPORT_SYMBOL(__find_get_block);
 
 /**
-- 
2.47.2


