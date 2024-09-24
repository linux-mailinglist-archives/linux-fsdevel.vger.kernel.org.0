Return-Path: <linux-fsdevel+bounces-29944-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F55983F80
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 09:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 735A1280CF5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 07:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC9A14AD1A;
	Tue, 24 Sep 2024 07:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wmW8lFUe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F61148316;
	Tue, 24 Sep 2024 07:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727163707; cv=none; b=Xo4pqzQY2yMU9tddOlPQEnu/39GPJAgAkxH6EQpL4vYQxkZ3FRkEax3zQmS/ynIxIXSdd0cIOSYPXpM7dkTW+q5b6HbnP+lUAnqN4RdOWgXV9SDrxti1rclzjJjINqrYK+oD0CamQ3agyKdeLNQRhU40moT/6JI3Bn38L1mbiX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727163707; c=relaxed/simple;
	bh=XBDS9+zFPYaTYRZiKoC57H9q+/jBQoCHNLX6kyjgK9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nGngKndJwoMu+8nrjoSXz8yatM89w6lQS0PLPGHziy9c3NrMv5qONi3WZykFCWGg+PQx6Zh0lLKx395BhKWa4CgtUZpAtJk6OyJGeMjH3hbVILONVTv722It3hXBpKvUe3uSg8wc9VxmYru/EqhFN0muMgDqH3N6MOEC4urwRR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wmW8lFUe; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=0fTTsQj3ZdvTBprqSSqQ54OSPZpIeMu3ngGG0FwbbT8=; b=wmW8lFUesNcc3v1tu9HETju3h3
	DEtbLjx4Q0hplObyuG7YKseXG2aSrk3bpLs5LSgY1JhyPHK4V9ZS4llLPM9DpH8qrGcNxK0tr4Y7D
	z+28TSRKENQeLe5K7cU/pNs+w3NkqyOuGNyzIW6+XiKz5e7hQ2QJG/g/Wf9bBjQlIpOyTqqLccV0z
	nfUkr1klfyRC8gSaesRsUGZC0+SZdlaB+wD5pNo4+58VJ9q5m/zAmEOYOa38MtRd3zlw0MrQOLW1d
	BWOhouIoJx0IufKAVAFH3EvEUy5IX/WWHMVmdZNd811d9qjI1DqLzd2JTA/j6C/wturoqgqtc7wq+
	iUvM9+ZA==;
Received: from 2a02-8389-2341-5b80-b62d-f525-8e84-d569.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:b62d:f525:8e84:d569] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1st0B7-00000001SO9-3B7U;
	Tue, 24 Sep 2024 07:41:46 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chandan Babu R <chandan.babu@oracle.com>,
	Carlos Maiolino <cem@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 09/10] xfs: set IOMAP_F_SHARED for all COW fork allocations
Date: Tue, 24 Sep 2024 09:40:51 +0200
Message-ID: <20240924074115.1797231-10-hch@lst.de>
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

Change to always set xfs_buffered_write_iomap_begin for COW fork
allocations even if they don't overlap existing data fork extents,
which will allow the iomap_end callback to detect if it has to punch
stale delalloc blocks from the COW fork instead of the data fork.  It
also means we sample the sequence counter for both the data and the COW
fork when writing to the COW fork, which ensures we properly revalidate
when only COW fork changes happens.

This is essentially a revert of commit 72a048c1056a ("xfs: only set
IOMAP_F_SHARED when providing a srcmap to a write"). This is fine because
the problem that the commit fixed has now been dealt with in iomap by
only looking at the actual srcmap and not the fallback to the write
iomap.

Note that the direct I/O path was never changed and has always set
IOMAP_F_SHARED for all COW fork allocations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_iomap.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index aff9e8305399ee..cc768f0139d365 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1186,20 +1186,19 @@ xfs_buffered_write_iomap_begin(
 	return 0;
 
 found_cow:
-	seq = xfs_iomap_inode_sequence(ip, 0);
 	if (imap.br_startoff <= offset_fsb) {
-		error = xfs_bmbt_to_iomap(ip, srcmap, &imap, flags, 0, seq);
+		error = xfs_bmbt_to_iomap(ip, srcmap, &imap, flags, 0,
+				xfs_iomap_inode_sequence(ip, 0));
 		if (error)
 			goto out_unlock;
-		seq = xfs_iomap_inode_sequence(ip, IOMAP_F_SHARED);
-		xfs_iunlock(ip, lockmode);
-		return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags,
-					 IOMAP_F_SHARED, seq);
+	} else {
+		xfs_trim_extent(&cmap, offset_fsb, imap.br_startoff - offset_fsb);
 	}
 
-	xfs_trim_extent(&cmap, offset_fsb, imap.br_startoff - offset_fsb);
+	iomap_flags = IOMAP_F_SHARED;
+	seq = xfs_iomap_inode_sequence(ip, iomap_flags);
 	xfs_iunlock(ip, lockmode);
-	return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags, 0, seq);
+	return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags, iomap_flags, seq);
 
 out_unlock:
 	xfs_iunlock(ip, lockmode);
-- 
2.45.2


