Return-Path: <linux-fsdevel+bounces-29866-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD7797EE2A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 17:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70A2D1F223D3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 15:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138C119E96B;
	Mon, 23 Sep 2024 15:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="x4Z/fO0i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E09019CD12;
	Mon, 23 Sep 2024 15:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727105373; cv=none; b=T996PFksLbr+KLS2GdTfjmaGGKOL0MRrKLNmlaa7b67WnxdYNTBv0DVfLbJwop9RKQke6JfY5Z0qQsCoN3sCUeovSoaoeSANfd0ypUkRGWp6q1lcOJTftQlQN/cK0mGCUM98/5+ZojrxA1FotcCIY+CcEdiJiYgSW7O8kXAcjWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727105373; c=relaxed/simple;
	bh=XF5m3LJn6QFImskENJqD3junbHbiv+D+B8UugmwY2cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fEPiqoZl1QJZu15udBiWhfIuqLtZclVNX7q8B5hezdmNZ7YcetACG3W9vlelgiYG4PbfsfotcptVHCgs7v97S1mvX9CW7BJLRPOWWOZMmVtG8WHgWtaBmMyme6iC5xuEAJJMBDCjndfBZgRFde+FRxSV7CQj55S6e7w/gZkYPMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=x4Z/fO0i; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=J//fTUGztMygvwJgGwt+1V76oFzuvFO4GEJZRSxThS8=; b=x4Z/fO0ivqsexPpEKRwvGiORuM
	q46wPqmVbfkwd+9tbD1047vK7JlVUJ/MiccbANYvaWZ/4SVxyo2BWg+tBf2swu+ROvn2Dl57ki+DS
	JKShHk9bHVx45xceArNDBpLRaAo4mNH+8W0FVrE8qhrk9IZ4GKKBxJx6RMO8quDhVUkywripsKxoR
	ML7vwLUk+AvOc5CHdDIEklJd1iPp/mYsv6FME7j0c7tNv+fHh0zkKDMYSDGtaMK9V3b+PBGO1iaZx
	z+TCeyW5hakcovKn/dx4NuaIcLb4Ttpma37IVMVQ6h9zLap1sidJrm1cj3PL0f803ovzYVx7FmRli
	myYqYdVQ==;
Received: from 2a02-8389-2341-5b80-4c13-f559-77bd-3c36.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:4c13:f559:77bd:3c36] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1ssl0F-0000000HVBb-1Fag;
	Mon, 23 Sep 2024 15:29:31 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 06/10] xfs: zeroing already holds invalidate_lock
Date: Mon, 23 Sep 2024 17:28:20 +0200
Message-ID: <20240923152904.1747117-7-hch@lst.de>
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

All XFS callers of iomap_zero_range already hold invalidate_lock, so we can't
take it again in iomap_file_buffered_write_punch_delalloc.

Use the passed in flags argument to detect if we're called from a zeroing
operation and don't take the lock again in this case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_iomap.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 4fa4d66dc37761..0f5fa3de6d3ecc 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1239,10 +1239,17 @@ xfs_buffered_write_iomap_end(
 	if (start_byte >= end_byte)
 		return 0;
 
-	filemap_invalidate_lock(inode->i_mapping);
+	/* For zeroing operations the callers already hold invalidate_lock. */
+	if (flags & IOMAP_ZERO)
+		rwsem_assert_held_write(&inode->i_mapping->invalidate_lock);
+	else
+		filemap_invalidate_lock(inode->i_mapping);
+
 	iomap_write_delalloc_release(inode, start_byte, end_byte, flags, iomap,
 			xfs_buffered_write_delalloc_punch);
-	filemap_invalidate_unlock(inode->i_mapping);
+
+	if (!(flags & IOMAP_ZERO))
+		filemap_invalidate_unlock(inode->i_mapping);
 	return 0;
 }
 
-- 
2.45.2


