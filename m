Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E31D725C23B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Sep 2020 16:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbgICOJt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Sep 2020 10:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729142AbgICOJQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Sep 2020 10:09:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790F0C06123F
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Sep 2020 07:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ftiQ0rcYjso3GTllhJYCyUIUiwObfxzKShUEAZXZCoo=; b=ieU9MwuLeDT6kI+gVCSDU9856N
        mgI4UZbxpkI6coKEc6a5cobosI/GkySKoiTTyYYU5fhG6PCageWFZ/yInwoGnuUXYQpd4Q1MdKvlZ
        XGFIIMEGOedMs1k+b0Z6rNHDNBc87ZoXMi7ATbv/ufSJec3Z0n+gBH7HZHkeBrFA+PKZueVkphkyG
        DFRKuu9Arfop4cy7yFCP6R92XKYXaZapf/jV+juowfMMX+8PDagK1CGorOmuxGPDM0qn8oDBzsBOQ
        i+iMbh4TlOl3WCnals4h4ZbwRABHJdfv27Kguf8JbvLd+2RxBWvXf+Hx3ID8t0aLlgVGZQJvn63/9
        ntWewkJQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDpv2-0003iK-CY; Thu, 03 Sep 2020 14:08:52 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 5/9] mm/readahead: Make ondemand_readahead take a readahead_control
Date:   Thu,  3 Sep 2020 15:08:40 +0100
Message-Id: <20200903140844.14194-6-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200903140844.14194-1-willy@infradead.org>
References: <20200903140844.14194-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Make ondemand_readahead() take a readahead_control struct in preparation
for making do_sync_mmap_readahead() pass down an RAC struct.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/readahead.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 577f180d9252..73110c4148f8 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -431,15 +431,14 @@ static int try_context_readahead(struct address_space *mapping,
 /*
  * A minimal readahead algorithm for trivial sequential/random reads.
  */
-static void ondemand_readahead(struct address_space *mapping,
-		struct file_ra_state *ra, struct file *file,
-		bool hit_readahead_marker, pgoff_t index,
+static void ondemand_readahead(struct readahead_control *ractl,
+		struct file_ra_state *ra, bool hit_readahead_marker,
 		unsigned long req_size)
 {
-	DEFINE_READAHEAD(ractl, file, mapping, index);
-	struct backing_dev_info *bdi = inode_to_bdi(mapping->host);
+	struct backing_dev_info *bdi = inode_to_bdi(ractl->mapping->host);
 	unsigned long max_pages = ra->ra_pages;
 	unsigned long add_pages;
+	unsigned long index = readahead_index(ractl);
 	pgoff_t prev_index;
 
 	/*
@@ -477,7 +476,8 @@ static void ondemand_readahead(struct address_space *mapping,
 		pgoff_t start;
 
 		rcu_read_lock();
-		start = page_cache_next_miss(mapping, index + 1, max_pages);
+		start = page_cache_next_miss(ractl->mapping, index + 1,
+				max_pages);
 		rcu_read_unlock();
 
 		if (!start || start - index > max_pages)
@@ -510,14 +510,15 @@ static void ondemand_readahead(struct address_space *mapping,
 	 * Query the page cache and look for the traces(cached history pages)
 	 * that a sequential stream would leave behind.
 	 */
-	if (try_context_readahead(mapping, ra, index, req_size, max_pages))
+	if (try_context_readahead(ractl->mapping, ra, index, req_size,
+			max_pages))
 		goto readit;
 
 	/*
 	 * standalone, small random read
 	 * Read as is, and do not pollute the readahead state.
 	 */
-	do_page_cache_ra(&ractl, req_size, 0);
+	do_page_cache_ra(ractl, req_size, 0);
 	return;
 
 initial_readahead:
@@ -543,8 +544,8 @@ static void ondemand_readahead(struct address_space *mapping,
 		}
 	}
 
-	ractl._index = ra->start;
-	do_page_cache_ra(&ractl, ra->size, ra->async_size);
+	ractl->_index = ra->start;
+	do_page_cache_ra(ractl, ra->size, ra->async_size);
 }
 
 /**
@@ -564,6 +565,8 @@ void page_cache_sync_readahead(struct address_space *mapping,
 			       struct file_ra_state *ra, struct file *filp,
 			       pgoff_t index, unsigned long req_count)
 {
+	DEFINE_READAHEAD(ractl, filp, mapping, index);
+
 	/* no read-ahead */
 	if (!ra->ra_pages)
 		return;
@@ -578,7 +581,7 @@ void page_cache_sync_readahead(struct address_space *mapping,
 	}
 
 	/* do read-ahead */
-	ondemand_readahead(mapping, ra, filp, false, index, req_count);
+	ondemand_readahead(&ractl, ra, false, req_count);
 }
 EXPORT_SYMBOL_GPL(page_cache_sync_readahead);
 
@@ -602,6 +605,8 @@ page_cache_async_readahead(struct address_space *mapping,
 			   struct page *page, pgoff_t index,
 			   unsigned long req_count)
 {
+	DEFINE_READAHEAD(ractl, filp, mapping, index);
+
 	/* no read-ahead */
 	if (!ra->ra_pages)
 		return;
@@ -624,7 +629,7 @@ page_cache_async_readahead(struct address_space *mapping,
 		return;
 
 	/* do read-ahead */
-	ondemand_readahead(mapping, ra, filp, true, index, req_count);
+	ondemand_readahead(&ractl, ra, true, req_count);
 }
 EXPORT_SYMBOL_GPL(page_cache_async_readahead);
 
-- 
2.28.0

