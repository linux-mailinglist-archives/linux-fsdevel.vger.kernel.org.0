Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6A0A2B1043
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Nov 2020 22:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbgKLV0z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Nov 2020 16:26:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbgKLV0y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Nov 2020 16:26:54 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBB0C0613D1;
        Thu, 12 Nov 2020 13:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=uffLheexwH4YKkYyuwl3ZDoqTJgvhShB/zTgAuL0STg=; b=tsQHj/H6HLq+ZEls4rGNrVmklp
        TcVPWiwbp3CBY2EcqYYz+OaWLQolgctxTpR6L4F5n+rEVPpQ5SxLUTkZXqXKmsugOUzc41pN22eFC
        8esxXmlovmPa1tH8o7ug6dgZy8aeC6uSVPB5XtpMYKOb4LMvlX0CnMPSh/jxpjt+GM2MFgzv4VR2u
        xYdiSj04gRz4mmwTWdjGkHdvqNYxZC0ATEOVoVUzmmJklxxJ32z0VOjpJvu1JfHSJuOm6OV9LCNre
        W1UI5pzGjnEdCO2ao0JgH/DDlaVSY+f5MrIJPPLTZcF79PUHi7F282/ax+RV1TACWQeIgMRO67Y4i
        8FDI10vA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kdK7F-0007HR-65; Thu, 12 Nov 2020 21:26:49 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        akpm@linux-foundation.org, hughd@google.com, hch@lst.de,
        hannes@cmpxchg.org, yang.shi@linux.alibaba.com,
        dchinner@redhat.com, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH v4 12/16] mm: Remove nr_entries parameter from pagevec_lookup_entries
Date:   Thu, 12 Nov 2020 21:26:37 +0000
Message-Id: <20201112212641.27837-13-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201112212641.27837-1-willy@infradead.org>
References: <20201112212641.27837-1-willy@infradead.org>
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
index 5c2c12e3581e..9a562f7fd200 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -1100,9 +1100,9 @@ void __pagevec_lru_add(struct pagevec *pvec)
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
index dcaee659fe1a..50d160700b7d 100644
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

