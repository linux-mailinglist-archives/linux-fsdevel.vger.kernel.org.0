Return-Path: <linux-fsdevel+bounces-6791-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E8581CBC0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 16:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D3A1B2062A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 15:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD8624B41;
	Fri, 22 Dec 2023 15:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lyhf1Gv6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA382377F;
	Fri, 22 Dec 2023 15:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=0tDqvYwFSGZxiPUTzlW4HNez1MU15vMHRFJdEDf7Dd0=; b=lyhf1Gv62XTy6SIBb8FrvCwqeh
	1RaBZI0ukFpiajsVrAsJrsZE92GjbqPfI6XSdb1FjhFStqbhHLQjcmygA2wH2wRH8g3+05NMl9J+N
	42ri8YHKlGerT9Tdd/88EoNNxcMX1xuIID+mZi3Rh1dTDwGk4ls0ipAks+FX5tabN81pWf0lIHPRj
	NReb01NKF+7sAICLZpkCUU6tt3stIcOSMyEuON9OYEzR6kMjSiPZ2RCiEQU7gotUP29X6VXo8q5pY
	aZiHY97ygOa2Pd81Mq1Vmwb+9UWfc+APNvoMxS87cC91low9T6nGXFJCO4S6AiYx5ltUy6dTrm+i8
	ULWolkew==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rGh8f-006BNf-1U;
	Fri, 22 Dec 2023 15:08:37 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.com>,
	David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	Dave Chinner <dchinner@redhat.com>
Subject: [PATCH 04/17] writeback: only update ->writeback_index for range_cyclic writeback
Date: Fri, 22 Dec 2023 16:08:14 +0100
Message-Id: <20231222150827.1329938-5-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231222150827.1329938-1-hch@lst.de>
References: <20231222150827.1329938-1-hch@lst.de>
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
Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: Dave Chinner <dchinner@redhat.com>
---
 mm/page-writeback.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 7ed6c2bc8dd51c..c798c0d6d0abb4 100644
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
@@ -2514,14 +2511,21 @@ int write_cache_pages(struct address_space *mapping,
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


