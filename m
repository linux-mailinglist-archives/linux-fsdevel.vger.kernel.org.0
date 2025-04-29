Return-Path: <linux-fsdevel+bounces-47650-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12608AA3D53
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 01:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6AB77B1F65
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 23:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12376272797;
	Tue, 29 Apr 2025 23:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCtVGyk7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590C7272787;
	Tue, 29 Apr 2025 23:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970656; cv=none; b=GkIhs6Zjv9xKmWH24myN+s56tNarz7SWtBw4lz4ZJrCuU5XAd78o6VHKbHHgP3nnTh39aPFRet3xpV1dKEdwQBxVPqCxQtcwCu5260Ixod5LiJ4zyHot5UG3pL/sfgZpx6LKVuZou1iph72JKxh0fDAKfPNkq4I64VhiHTLEkOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970656; c=relaxed/simple;
	bh=pQwYTn+gO9HN3mptPSSIlFvV7Dk2li5j6cwEGQaugFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m0gf/xaZuDRgM3vst/6pzwRXGmPz805WhSM4o1MWU8rRWPezwkPN9vo0FRIPJMMnZKRGNf05e3ENu/jE6IqgrbKeu83WbS2ie5Te3hbECkJKu6QAEZE0b84UOW2G04s8jZkB3KKL1PgyBM2kNGoe/xihbqSPM1dc/zfc8CGuR54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oCtVGyk7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9A87C4CEEB;
	Tue, 29 Apr 2025 23:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745970655;
	bh=pQwYTn+gO9HN3mptPSSIlFvV7Dk2li5j6cwEGQaugFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oCtVGyk7Jxvy31A1RoiUpIY5rVoi0JoOcMTv5MAhP0gUrPaxG+InW1mu/PTqXkvEZ
	 q+ZQR+DVgB93/lbld4S/99ipnqlmqVp2xww1uzl0WSH7CC8QaM1FkgAhIlZd0vFVJg
	 oRTqHC4o8Ozyxgx4tn+JnOM+acxMo7uCt2vQpOPvi48Si/31cxzPnN9C9O/L+JPFzr
	 19BxWsHqun42hdSX0sEu5ZYZlES5HHyRKWcYgBmLfzeaW3RVJj9pII9eseNOsuqoJt
	 jjhalPv3GdrYSoeqZo+mATUxMyJVM2IqI9olhYsa9Fvk4rkpHORPQ0Rtf3DZ+N4QDQ
	 gtnF6bdPt9X2A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jan Kara <jack@suse.cz>,
	kdevops@lists.linux.dev,
	Luis Chamberlain <mcgrof@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 26/39] fs/buffer: split locking for pagecache lookups
Date: Tue, 29 Apr 2025 19:49:53 -0400
Message-Id: <20250429235006.536648-26-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250429235006.536648-1-sashal@kernel.org>
References: <20250429235006.536648-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.4
Content-Transfer-Encoding: 8bit

From: Davidlohr Bueso <dave@stgolabs.net>

[ Upstream commit 7ffe3de53a885dbb5836541c2178bd07d1bad7df ]

Callers of __find_get_block() may or may not allow for blocking
semantics, and is currently assumed that it will not. Layout
two paths based on this. The the private_lock scheme will
continued to be used for atomic contexts. Otherwise take the
folio lock instead, which protects the buffers, such as
vs migration and try_to_free_buffers().

Per the "hack idea", the latter can alleviate contention on
the private_lock for bdev mappings. For reasons of determinism
and avoid making bugs hard to reproduce, the trylocking is not
attempted.

No change in semantics. All lookup users still take the spinlock.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Link: https://kdevops.org/ext4/v6.15-rc2.html # [0]
Link: https://lore.kernel.org/all/aAAEvcrmREWa1SKF@bombadil.infradead.org/ # [1]
Link: https://lore.kernel.org/20250418015921.132400-2-dave@stgolabs.net
Tested-by: kdevops@lists.linux.dev
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/buffer.c | 41 +++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index cc8452f602516..a03c245022dcf 100644
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
@@ -204,7 +194,16 @@ __find_get_block_slow(struct block_device *bdev, sector_t block)
 	if (IS_ERR(folio))
 		goto out;
 
-	spin_lock(&bd_mapping->i_private_lock);
+	/*
+	 * Folio lock protects the buffers. Callers that cannot block
+	 * will fallback to serializing vs try_to_free_buffers() via
+	 * the i_private_lock.
+	 */
+	if (atomic)
+		spin_lock(&bd_mapping->i_private_lock);
+	else
+		folio_lock(folio);
+
 	head = folio_buffers(folio);
 	if (!head)
 		goto out_unlock;
@@ -236,7 +235,10 @@ __find_get_block_slow(struct block_device *bdev, sector_t block)
 		       1 << blkbits);
 	}
 out_unlock:
-	spin_unlock(&bd_mapping->i_private_lock);
+	if (atomic)
+		spin_unlock(&bd_mapping->i_private_lock);
+	else
+		folio_unlock(folio);
 	folio_put(folio);
 out:
 	return ret;
@@ -1388,14 +1390,15 @@ lookup_bh_lru(struct block_device *bdev, sector_t block, unsigned size)
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
@@ -1403,6 +1406,12 @@ __find_get_block(struct block_device *bdev, sector_t block, unsigned size)
 
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
2.39.5


