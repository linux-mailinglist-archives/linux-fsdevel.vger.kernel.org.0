Return-Path: <linux-fsdevel+bounces-29863-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB9D97EE25
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 17:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13684B20E62
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 15:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1577E19E96F;
	Mon, 23 Sep 2024 15:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DJxqip8v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E061F19415E;
	Mon, 23 Sep 2024 15:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727105362; cv=none; b=tLpvp99Z2yIwjiE6oJhvB+xmchJMk9C9UedFwZF0Ahd3ejVqhpZLFtpz3NRklJtRcbhebH7oJFryAWx39pMWKGyYmF25SOzKizV25eU5FDO7NFLZh3EwctNoaQI+GCd3iruIG5V6RvtBOmH0xpR/la05WuNUWmi2QjIvtDliaos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727105362; c=relaxed/simple;
	bh=tegrbrQiPqFaEjLZlVXZebSH3GZsqeefWikrE91g64I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uZjuW8bm79HTSifFulYbFfaJbRN69WbfyNt/ReBvDCvsEAdeciwWYZRZC9UYIx0IoeK4nVCasSaXkL3eh4YwprAbeZjhwgu/JTd8o9PbZrNO5V7Cw01XZlels2UTLa5GsLxuD+qTpfwwxcsy/4qoiO3JF351yEdEeP24oODv918=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DJxqip8v; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=4th+6Mb1bQULX8x5DPcZaMxeSLRHcvz/WbZTQw1J00w=; b=DJxqip8ve9WKA23sc9UpGbdM6t
	eCdV6B8Rfv6o1ICqUPxyyprNgfYKcbNFsz3Juskv7kB4KJN0v6ck8jdp7TUCj4EX7uW7fM4maANcc
	gYUVk4WXnNlA6KHsWTblkw521uuwK+U8OxXGB2oArgkT+I9iyFkFbv7RCY6zLGLqylKkJK+20yU/n
	xE4PS03ZAjAEvr0ksSMT+r/Xa9laN1q9RklvVLUwsZBSQYja1pKM7FDVmDafYUeROKBdRjBPS0YXK
	24nhMnxQ3IVRt9FlRUVYagjBI55w2clR6MOOw+euFojRC9G6Bwi7sd1LOw/UwicYHb2++2vK140N3
	9Q93MqIg==;
Received: from 2a02-8389-2341-5b80-4c13-f559-77bd-3c36.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:4c13:f559:77bd:3c36] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1ssl03-0000000HV7j-42Vd;
	Mon, 23 Sep 2024 15:29:20 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 03/10] iomap: move locking out of iomap_write_delalloc_release
Date: Mon, 23 Sep 2024 17:28:17 +0200
Message-ID: <20240923152904.1747117-4-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240923152904.1747117-1-hch@lst.de>
References: <20240923152904.1747117-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

XFS (which currently is the only user of iomap_write_delalloc_release)
already holds invalidate_lock for most zeroing operations.  To be able
to avoid a deadlock it needs to stop taking the lock, but doing so
in iomap would leak XFS locking details into iomap.

To avoid this require the caller to hold invalidate_lock when calling
iomap_write_delalloc_release instead of taking it there.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 17 ++++++++---------
 fs/xfs/xfs_iomap.c     |  2 ++
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 237aeb883166df..232aaa1e86451a 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1211,12 +1211,13 @@ void iomap_write_delalloc_release(struct inode *inode, loff_t start_byte,
 	loff_t scan_end_byte = min(i_size_read(inode), end_byte);
 
 	/*
-	 * Lock the mapping to avoid races with page faults re-instantiating
-	 * folios and dirtying them via ->page_mkwrite whilst we walk the
-	 * cache and perform delalloc extent removal. Failing to do this can
-	 * leave dirty pages with no space reservation in the cache.
+	 * The caller must hold invalidate_lock to avoid races with page faults
+	 * re-instantiating folios and dirtying them via ->page_mkwrite whilst
+	 * we walk the cache and perform delalloc extent removal.  Failing to do
+	 * this can leave dirty pages with no space reservation in the cache.
 	 */
-	filemap_invalidate_lock(inode->i_mapping);
+	lockdep_assert_held_write(&inode->i_mapping->invalidate_lock);
+
 	while (start_byte < scan_end_byte) {
 		loff_t		data_end;
 
@@ -1233,7 +1234,7 @@ void iomap_write_delalloc_release(struct inode *inode, loff_t start_byte,
 		if (start_byte == -ENXIO || start_byte == scan_end_byte)
 			break;
 		if (WARN_ON_ONCE(start_byte < 0))
-			goto out_unlock;
+			return;
 		WARN_ON_ONCE(start_byte < punch_start_byte);
 		WARN_ON_ONCE(start_byte > scan_end_byte);
 
@@ -1244,7 +1245,7 @@ void iomap_write_delalloc_release(struct inode *inode, loff_t start_byte,
 		data_end = mapping_seek_hole_data(inode->i_mapping, start_byte,
 				scan_end_byte, SEEK_HOLE);
 		if (WARN_ON_ONCE(data_end < 0))
-			goto out_unlock;
+			return;
 
 		/*
 		 * If we race with post-direct I/O invalidation of the page cache,
@@ -1266,8 +1267,6 @@ void iomap_write_delalloc_release(struct inode *inode, loff_t start_byte,
 	if (punch_start_byte < end_byte)
 		punch(inode, punch_start_byte, end_byte - punch_start_byte,
 				iomap);
-out_unlock:
-	filemap_invalidate_unlock(inode->i_mapping);
 }
 EXPORT_SYMBOL_GPL(iomap_write_delalloc_release);
 
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 30f2530b6d5461..01324da63fcfc7 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1239,8 +1239,10 @@ xfs_buffered_write_iomap_end(
 	if (start_byte >= end_byte)
 		return 0;
 
+	filemap_invalidate_lock(inode->i_mapping);
 	iomap_write_delalloc_release(inode, start_byte, end_byte, flags, iomap,
 			xfs_buffered_write_delalloc_punch);
+	filemap_invalidate_unlock(inode->i_mapping);
 	return 0;
 }
 
-- 
2.45.2


