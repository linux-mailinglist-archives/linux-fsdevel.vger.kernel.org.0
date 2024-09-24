Return-Path: <linux-fsdevel+bounces-29938-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB12983F73
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 09:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD673281EAF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 07:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA60914D433;
	Tue, 24 Sep 2024 07:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y9V5IPb+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B7714D29D;
	Tue, 24 Sep 2024 07:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727163690; cv=none; b=Blm5I+7h2SfnxP/vGu74yVkn1GsvJuxkyLipj0BoFR297qVX41oBobmCSXZ5ojLWKBPvbJUsAcxbq5zdZpYhc43WmbyPLhpCfZHawQJ4yu482Are0b5h4IjGy2nzNxFPxLxlZQFf1QN2iICATrMiTXNXLAuY1EEoMvbbTDf/8a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727163690; c=relaxed/simple;
	bh=8mNCBqOXyu/NpnfVlbHQ9N1+A1FBaOQuYGXqO0TUb4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sSzfruM1KQKlsIixQmKaJ9hxkgiOQZrmpPyeKaPiCzco1/tTkoPsBCv1qER/qem6TzvcORBbec5FG5R60ZWCFI19LlpgKzK+9wRH/jZA1lZPZNPAp4ej6eab8eOaogo9r1GeaVXh9jVJkV5hXNw/+yisOOW+D4SUovtXmE6EtcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Y9V5IPb+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=xiwWX40UClgWUC19o/RhENvgiyLTCF3jGCqr/sOawHw=; b=Y9V5IPb+qMXofPCostRqbyyixP
	OQgqoAQLIYb9zZ1F9wbtxe40rGArVzGc+626GCGrk8sMnfC4xcLroDfvlEiAt5X0+czj50bmw1dLm
	+LmJTEO6eTrYSifd/gHlW9wpFOCZvz6JBMQpyTu69Ft8C12PV7HUzbgBuiHCIuzeqm1N9cRCuFUm+
	51Ik5fwl0khCnCv8EJJwdkriMGjszJ1A01uY8LH7DXbQhbvLQ/Ib8g9H9q86a9G5P45MI+mRhsLPu
	1mWPtFYGQWjt/5iOdfBOR6trAiA1Gnerm3hCCVAz1kkd5BNSE44UkflnWUSY5o7rn/4jGXDDDNaHL
	T9MbrQxw==;
Received: from 2a02-8389-2341-5b80-b62d-f525-8e84-d569.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:b62d:f525:8e84:d569] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1st0Aq-00000001SJn-0OuM;
	Tue, 24 Sep 2024 07:41:28 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chandan Babu R <chandan.babu@oracle.com>,
	Carlos Maiolino <cem@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 03/10] iomap: move locking out of iomap_write_delalloc_release
Date: Tue, 24 Sep 2024 09:40:45 +0200
Message-ID: <20240924074115.1797231-4-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240924074115.1797231-1-hch@lst.de>
References: <20240924074115.1797231-1-hch@lst.de>
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
index a350dac1bf5136..b9e70e30a1b254 100644
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


