Return-Path: <linux-fsdevel+bounces-46152-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA600A83612
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 03:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D1928A2BE7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 01:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E001E0DEB;
	Thu, 10 Apr 2025 01:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ipBwvmyv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB1019ADB0;
	Thu, 10 Apr 2025 01:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744249793; cv=none; b=QYThojf1XU42SotNa/PZAZLJ+E+QZEyRtCXMFgEzM9GRr58IJ4tvRgKdJBi9U9G/ANWqks8PLOha5xBkc4UcRgj+Wcrd3wgXZ6tjMWE/GOReRMmHOQnJzxjYEAZqPVSJlW/DwJ99gz3KtBfIxgevEdDxRqJj9w6g1mYdPb75Uvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744249793; c=relaxed/simple;
	bh=6AcGXxfbBxjNN+NNnC8VOmrsKGHXtnZn9WapwkH55B0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m+Xub3Wn+U8xs2zvfAHA0hp9OJTbTLGOKcZaKIRv848MLMHHmfqHTn4ZK2IPxIFbNzQwZQFML8rOaWJJNkZMi73mWcgYOZ5nLf6+v1NUst4qh+ZXAbn4OxlBTkCM1VMAuY5PeF+qiindL64+MOlrHDYMWe/PKLKVnLZzS2W5uKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ipBwvmyv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=IJXPCgsWY2AYZ+ERHJ5qQZaJVfrH0dcPo+w1wteI5Ag=; b=ipBwvmyv4g4pzBPiSz5QUDcBzq
	AOtFV3f6RHrv9qNMsPiWLlXHk0KRNOGrx4o0iqcNXtL+XXYJYoXwJGwkUKVjnxVFLEuXVjPSVotHj
	SGg2Q4NS6KTe8Zzo/MoOyLZKMbbIKuQ9KiDWJd56PjYD/DqdQmhbq7k3Cy/XazUH0PeMwkOCMJKmn
	J7vCSCXbe8pjh2LRYUGn3TUSWwGQH/GENSZPo1vx6r18czqaysbyjQa8LN8tn0udRXK6VV4Rt7SSJ
	+kvcKp+BHk0YcENBoAuFFeIKkaWGMU9Bg5YoEqG8ALCnuEWNez6FH2LXV8JPxBzxruzLFCfrxwFuE
	2ZgTSy8w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2h35-00000008yvJ-3gUy;
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
Subject: [PATCH v2 3/8] fs/buffer: introduce __find_get_block_nonatomic()
Date: Wed,  9 Apr 2025 18:49:40 -0700
Message-ID: <20250410014945.2140781-4-mcgrof@kernel.org>
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

Callers that do not require atomic context for pagecache
lookups can use this flavor to avoid the unnencesary
contention on the blockdev mapping i_private_lock as well
as waiting on noref migration.

Convert local caller write_boundary_block() which already
takes the buffer lock as well as bdev_getblk() depending
on the respective gpf flags. Either way there are no
currently changes in semantics.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/buffer.c                 | 19 +++++++++++++++++--
 include/linux/buffer_head.h |  2 ++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 5a1a37a6840a..07ec57ec100e 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -662,7 +662,8 @@ EXPORT_SYMBOL(generic_buffers_fsync);
 void write_boundary_block(struct block_device *bdev,
 			sector_t bblock, unsigned blocksize)
 {
-	struct buffer_head *bh = __find_get_block(bdev, bblock + 1, blocksize);
+	struct buffer_head *bh = __find_get_block_nonatomic(bdev, bblock + 1,
+							    blocksize);
 	if (bh) {
 		if (buffer_dirty(bh))
 			write_dirty_buffer(bh, 0);
@@ -1418,6 +1419,15 @@ __find_get_block(struct block_device *bdev, sector_t block, unsigned size)
 }
 EXPORT_SYMBOL(__find_get_block);
 
+/* same as __find_get_block() but allows sleeping contexts */
+struct buffer_head *
+__find_get_block_nonatomic(struct block_device *bdev, sector_t block,
+			   unsigned size)
+{
+	return find_get_block_common(bdev, block, size, false);
+}
+EXPORT_SYMBOL(__find_get_block_nonatomic);
+
 /**
  * bdev_getblk - Get a buffer_head in a block device's buffer cache.
  * @bdev: The block device.
@@ -1435,7 +1445,12 @@ EXPORT_SYMBOL(__find_get_block);
 struct buffer_head *bdev_getblk(struct block_device *bdev, sector_t block,
 		unsigned size, gfp_t gfp)
 {
-	struct buffer_head *bh = __find_get_block(bdev, block, size);
+	struct buffer_head *bh;
+
+	if (gfpflags_allow_blocking(gfp))
+		bh = __find_get_block_nonatomic(bdev, block, size);
+	else
+		bh = __find_get_block(bdev, block, size);
 
 	might_alloc(gfp);
 	if (bh)
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index f0a4ad7839b6..2b5458517def 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -222,6 +222,8 @@ void __wait_on_buffer(struct buffer_head *);
 wait_queue_head_t *bh_waitq_head(struct buffer_head *bh);
 struct buffer_head *__find_get_block(struct block_device *bdev, sector_t block,
 			unsigned size);
+struct buffer_head *__find_get_block_nonatomic(struct block_device *bdev,
+		       sector_t block, unsigned size);
 struct buffer_head *bdev_getblk(struct block_device *bdev, sector_t block,
 		unsigned size, gfp_t gfp);
 void __brelse(struct buffer_head *);
-- 
2.47.2


