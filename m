Return-Path: <linux-fsdevel+bounces-11082-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F195850DC7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 08:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F09AEB23DCE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 07:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333B413FF1;
	Mon, 12 Feb 2024 07:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QMXkj9OR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5651012B9F;
	Mon, 12 Feb 2024 07:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707722056; cv=none; b=J+yvjj1z0PXrtjp6CoNnPR6PoY8jczy/D/DZWqKsU8S7h3GtCxsOfS7KEviWTEHIKXBumfw6dm1ti9ZU/y/exCufYMH4nbFpOrqBi8E+4RQPcWBaaEIxpLWlqSrPyuZFtgVTsI5bBzskZJOdvmIPqRKIFUG4LYF9zn+DujgZ9Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707722056; c=relaxed/simple;
	bh=ukY0COvN+NL1nMv2vyEwUNEfkq+t2wK4jlewlvvA9Aw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ei9GZKiuGgUkUEmpE1DjqoaWixf+LhhMECtvgu17v6qqrIFtEdpeO7dDCTeX/dO0WcFjN73FA0yDoe5rME37oEkEJn0x1Zqma11oPU3vejIp/F96hr1BK1pRoUvTtiruNHC2+i1aVG2GysoJydZioYzGuWV1S1ikVLX16+ytKkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QMXkj9OR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=KUIj5droJWBY9JuTDNlu6m/OZ7SC5gyUm02IKuKQE8M=; b=QMXkj9OR68fUtzLzKk+BxuxP5V
	lLcsfARWxz3J73jW+4CgAYNChX8vH6k0bYjyje3Ka3UUp3oc6GxLgHxFAdgUXy8I3Q3cRXMjVbNo2
	UTdZOTlyUdiKdDXVA+30f9Hz4sGb1b9PlTE9EOQ+6g0S36udj5BbdA6CafPZ9Po96XiHG8eDOgtKG
	FKwNEztpeIb/BiXUv4XWkKCconDCsJXg0G+1M929zR6uRK51QBCmXgoU2HM5G4xb+Jbb2b9r/568X
	TIwGtt07kVctUBqVnmuuBQ/x2I5CUpuUf0jYc9Ig1T/eFiRNpVsz+Ge0Z6jbgho4bypbjl34cJZtc
	ux8+JkwA==;
Received: from [2001:4bb8:190:6eab:75e9:7295:a6e3:c35d] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZQW4-00000004SsL-0LR5;
	Mon, 12 Feb 2024 07:14:12 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-mm@kvack.org
Cc: Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.com>,
	David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	Dave Chinner <dchinner@redhat.com>
Subject: [PATCH 05/14] writeback: only update ->writeback_index for range_cyclic writeback
Date: Mon, 12 Feb 2024 08:13:39 +0100
Message-Id: <20240212071348.1369918-6-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240212071348.1369918-1-hch@lst.de>
References: <20240212071348.1369918-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

mapping->writeback_index is only [1] used as the starting point for
range_cyclic writeback, so there is no point in updating it for other
types of writeback.

[1] except for btrfs_defrag_file which does really odd things with
mapping->writeback_index.  But btrfs doesn't use write_cache_pages at
all, so this isn't relevant here.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: Dave Chinner <dchinner@redhat.com>
---
 mm/page-writeback.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 06afba8f078515..4d862f196d1f05 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2403,7 +2403,6 @@ int write_cache_pages(struct address_space *mapping,
 	pgoff_t index;
 	pgoff_t end;		/* Inclusive */
 	pgoff_t done_index;
-	int range_whole = 0;
 	xa_mark_t tag;
 
 	folio_batch_init(&fbatch);
@@ -2413,8 +2412,6 @@ int write_cache_pages(struct address_space *mapping,
 	} else {
 		index = wbc->range_start >> PAGE_SHIFT;
 		end = wbc->range_end >> PAGE_SHIFT;
-		if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX)
-			range_whole = 1;
 	}
 	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages) {
 		tag_pages_for_writeback(mapping, index, end);
@@ -2518,14 +2515,21 @@ int write_cache_pages(struct address_space *mapping,
 	}
 
 	/*
-	 * If we hit the last page and there is more work to be done: wrap
-	 * back the index back to the start of the file for the next
-	 * time we are called.
+	 * For range cyclic writeback we need to remember where we stopped so
+	 * that we can continue there next time we are called.  If  we hit the
+	 * last page and there is more work to be done, wrap back to the start
+	 * of the file.
+	 *
+	 * For non-cyclic writeback we always start looking up at the beginning
+	 * of the file if we are called again, which can only happen due to
+	 * -ENOMEM from the file system.
 	 */
-	if (wbc->range_cyclic && !done)
-		done_index = 0;
-	if (wbc->range_cyclic || (range_whole && wbc->nr_to_write > 0))
-		mapping->writeback_index = done_index;
+	if (wbc->range_cyclic) {
+		if (done)
+			mapping->writeback_index = done_index;
+		else
+			mapping->writeback_index = 0;
+	}
 
 	return ret;
 }
-- 
2.39.2


