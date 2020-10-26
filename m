Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 262E8298630
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 05:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422263AbgJZElc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 00:41:32 -0400
Received: from casper.infradead.org ([90.155.50.34]:60052 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1421493AbgJZElc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 00:41:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ETX87MTgKWaxDq/ZgR/LhP6+qskX119fCC7yru+WEmE=; b=Jsdh2v+F+pr6rgZoxRjGGsj5wV
        D1Td4x3LapVeO8HSYlNht5MphssVq8ny0Pt9tghNDTP6FeZVBDhLnjHXhFHPb2wff77Oy4a+U0S4X
        YHzrBB/798krwPh+9IGmFunPMM4ufXVbmQ7tTMkyBRuD85Sy5Bi79XCpPvxuuwAvJ9rwGo7nUx//B
        xAkXq7yO8jKcyuWfKIKENtvGDiaILEk5z9G6Kih/u34Qsq28IxnZ0zvxP6Gk9/V5gHDeCKDbCmcCz
        kec30sF+PfzSJs4NT956c7x27kGFQjQXTcMwn82f+aby7dBe61PTclt5uQ8+hFx8R7kCJ/wbgMvje
        Kbka90Pw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kWttb-0006aO-US; Mon, 26 Oct 2020 04:14:11 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH v3 08/12] mm: Remove nr_entries parameter from pagevec_lookup_entries
Date:   Mon, 26 Oct 2020 04:14:04 +0000
Message-Id: <20201026041408.25230-9-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201026041408.25230-1-willy@infradead.org>
References: <20201026041408.25230-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All callers want to fetch the full size of the pvec.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 include/linux/pagevec.h | 2 +-
 mm/swap.c               | 4 ++--
 mm/truncate.c           | 5 ++---
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/linux/pagevec.h b/include/linux/pagevec.h
index 4b245592262c..ce77724a2ab7 100644
--- a/include/linux/pagevec.h
+++ b/include/linux/pagevec.h
@@ -27,7 +27,7 @@ void __pagevec_release(struct pagevec *pvec);
 void __pagevec_lru_add(struct pagevec *pvec);
 unsigned pagevec_lookup_entries(struct pagevec *pvec,
 		struct address_space *mapping, pgoff_t start, pgoff_t end,
-		unsigned nr_entries, pgoff_t *indices);
+		pgoff_t *indices);
 void pagevec_remove_exceptionals(struct pagevec *pvec);
 unsigned pagevec_lookup_range(struct pagevec *pvec,
 			      struct address_space *mapping,
diff --git a/mm/swap.c b/mm/swap.c
index d4d0c54d6ec9..31653152f55d 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -1097,9 +1097,9 @@ void __pagevec_lru_add(struct pagevec *pvec)
  */
 unsigned pagevec_lookup_entries(struct pagevec *pvec,
 		struct address_space *mapping, pgoff_t start, pgoff_t end,
-		unsigned nr_entries, pgoff_t *indices)
+		pgoff_t *indices)
 {
-	pvec->nr = find_get_entries(mapping, start, end, nr_entries,
+	pvec->nr = find_get_entries(mapping, start, end, PAGEVEC_SIZE,
 				    pvec->pages, indices);
 	return pagevec_count(pvec);
 }
diff --git a/mm/truncate.c b/mm/truncate.c
index ec43312f4756..c4a3c9d6a0c1 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -377,7 +377,7 @@ void truncate_inode_pages_range(struct address_space *mapping,
 	for ( ; ; ) {
 		cond_resched();
 		if (!pagevec_lookup_entries(&pvec, mapping, index, end - 1,
-				PAGEVEC_SIZE, indices)) {
+				indices)) {
 			/* If all gone from start onwards, we're done */
 			if (index == start)
 				break;
@@ -632,8 +632,7 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 
 	pagevec_init(&pvec);
 	index = start;
-	while (pagevec_lookup_entries(&pvec, mapping, index, end,
-			PAGEVEC_SIZE, indices)) {
+	while (pagevec_lookup_entries(&pvec, mapping, index, end, indices)) {
 		for (i = 0; i < pagevec_count(&pvec); i++) {
 			struct page *page = pvec.pages[i];
 
-- 
2.28.0

