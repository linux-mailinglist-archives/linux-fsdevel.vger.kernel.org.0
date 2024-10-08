Return-Path: <linux-fsdevel+bounces-31290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BA899434C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 11:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 777AD1C23314
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 09:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0092518FDC9;
	Tue,  8 Oct 2024 08:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4gRhboHE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C417B18C922;
	Tue,  8 Oct 2024 08:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728377992; cv=none; b=qME+8kKanwEJ9nV2aRZgJzGwxOCq3JAia23Dh0WcvqIr8MJgRtKrN/UegVivzQZ/IPzQ6//lUtrckMYVFNGsa+b4hqfFmgaSWKp9SX8Q6c8tKZBJ72i5RFfsGmczrrsQ29iZlqwIqAkvAPnt0R/02dZGBgV9ViXDUATyvbHxhAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728377992; c=relaxed/simple;
	bh=djuMtwPMA51ml07WieONMs5DWN1/mySMKle3yqHnmhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d7dJOFgrvWPuk+zYaq4EzCkJSzGJXWCdVrdRBziwqn+2lMjdcT7kr52wymsgcpoIr2G+VzFL3Mf5QzDZG8a0kJq86c9NJgQvrcAUWimo84+E44UAh+x3dgDrb0CTEl2CYcu28PoovXSzXIVfEcPlJvWP5kFgCNQKW9+8oO0ikoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4gRhboHE; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=kDPiv7AZVrWNmGKxIXeYJtT3OdYEgQsKaa7LjBwdvvo=; b=4gRhboHEBAbNqYnXBpd5wKoPiD
	cQzLTQ3w4CkCoZArGjMxeV2pOY6FQl+jhenLYjwMfq/2a65UEx12fBq/YuP8aE72O1dUq4xpvqMAB
	6t5511slXGagYfnszVVkIwwBu0tKHJmkXxO6P28NRTwHfY3iRjiAofa4kQc/TVJ/95HwRJtlk3KvB
	6xC0AjJqztLh3MOg0TWvbZu6wQInJP7dTosjFFJITZ191GpqIYG0TViGxOjhPckkqvPkD0kQ4nNHB
	XQzm+vRUC9A7aCxV5HjGMpWhhCsSO2RqgfTQLneBebEGYR9IYoH3lEIMkfbv7DpWsh6tj8hdu7lwe
	6BRi71Tw==;
Received: from 2a02-8389-2341-5b80-a172-fba5-598b-c40c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:a172:fba5:598b:c40c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sy64M-00000005Bc4-0RR6;
	Tue, 08 Oct 2024 08:59:50 +0000
From: Christoph Hellwig <hch@lst.de>
To: Carlos Maiolino <cem@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 03/10] iomap: move locking out of iomap_write_delalloc_release
Date: Tue,  8 Oct 2024 10:59:14 +0200
Message-ID: <20241008085939.266014-4-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241008085939.266014-1-hch@lst.de>
References: <20241008085939.266014-1-hch@lst.de>
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
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 17 ++++++++---------
 fs/xfs/xfs_iomap.c     |  2 ++
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index b4f742f3104120..aa587b2142e214 100644
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


