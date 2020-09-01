Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3430259897
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Sep 2020 18:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730971AbgIAQ2k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Sep 2020 12:28:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27476 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730964AbgIAQ2g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Sep 2020 12:28:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598977715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ezAmTShFf1lpnkxSzlatynP4JebRzAzt5S9sCe1UvW4=;
        b=DD9ihPBHb/8qwx1nB1dQZG2tXdZwkdxndt0ss9mlT0zqZF9Xyw2Dxe10vltL9MJCtniZPl
        edZovVhTQD3r6Oqc1iETVUgUTjiWWodopptaur1urdBayHwkOquyAAjkTRaJBo8QyaWQjx
        gAYIZxVE4aNdDe4/ByyTeqc3i0qCSNs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-TaUdUYt9NE6gk3tKY-XS6A-1; Tue, 01 Sep 2020 12:28:33 -0400
X-MC-Unique: TaUdUYt9NE6gk3tKY-XS6A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84DAB807333;
        Tue,  1 Sep 2020 16:28:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-113-231.rdu2.redhat.com [10.10.113.231])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B56587EB7D;
        Tue,  1 Sep 2020 16:28:30 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 2/7] mm: Make ondemand_readahead() take a
 readahead_control struct
From:   David Howells <dhowells@redhat.com>
To:     willy@infradead.org
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Tue, 01 Sep 2020 17:28:29 +0100
Message-ID: <159897770995.405783.3301406968621486886.stgit@warthog.procyon.org.uk>
In-Reply-To: <159897769535.405783.17587409235571100774.stgit@warthog.procyon.org.uk>
References: <159897769535.405783.17587409235571100774.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make ondemand_readahead() take a readahead_control struct in preparation
for making do_sync_mmap_readahead() pass down an RAC struct.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 mm/readahead.c |   35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 91859e6e2b7d..0e16fb4809f5 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -511,14 +511,15 @@ static bool page_cache_readahead_order(struct readahead_control *rac,
 /*
  * A minimal readahead algorithm for trivial sequential/random reads.
  */
-static void ondemand_readahead(struct address_space *mapping,
-		struct file_ra_state *ra, struct file *file,
-		struct page *page, pgoff_t index, unsigned long req_size)
+static void ondemand_readahead(struct readahead_control *rac,
+			       struct file_ra_state *ra,
+			       struct page *page)
 {
-	DEFINE_READAHEAD(rac, file, mapping, index);
-	struct backing_dev_info *bdi = inode_to_bdi(mapping->host);
+	struct backing_dev_info *bdi = inode_to_bdi(rac->mapping->host);
 	unsigned long max_pages = ra->ra_pages;
 	unsigned long add_pages;
+	unsigned long req_size = rac->_nr_pages;
+	unsigned long index = rac->_index;
 	pgoff_t prev_index;
 
 	/*
@@ -556,7 +557,7 @@ static void ondemand_readahead(struct address_space *mapping,
 		pgoff_t start;
 
 		rcu_read_lock();
-		start = page_cache_next_miss(mapping, index + 1, max_pages);
+		start = page_cache_next_miss(rac->mapping, index + 1, max_pages);
 		rcu_read_unlock();
 
 		if (!start || start - index > max_pages)
@@ -589,14 +590,14 @@ static void ondemand_readahead(struct address_space *mapping,
 	 * Query the page cache and look for the traces(cached history pages)
 	 * that a sequential stream would leave behind.
 	 */
-	if (try_context_readahead(mapping, ra, index, req_size, max_pages))
+	if (try_context_readahead(rac->mapping, ra, index, req_size, max_pages))
 		goto readit;
 
 	/*
 	 * standalone, small random read
 	 * Read as is, and do not pollute the readahead state.
 	 */
-	__do_page_cache_readahead(&rac, req_size, 0);
+	__do_page_cache_readahead(rac, req_size, 0);
 	return;
 
 initial_readahead:
@@ -622,10 +623,10 @@ static void ondemand_readahead(struct address_space *mapping,
 		}
 	}
 
-	rac._index = ra->start;
-	if (page && page_cache_readahead_order(&rac, ra, thp_order(page)))
+	rac->_index = ra->start;
+	if (page && page_cache_readahead_order(rac, ra, thp_order(page)))
 		return;
-	__do_page_cache_readahead(&rac, ra->size, ra->async_size);
+	__do_page_cache_readahead(rac, ra->size, ra->async_size);
 }
 
 /**
@@ -645,6 +646,9 @@ void page_cache_sync_readahead(struct address_space *mapping,
 			       struct file_ra_state *ra, struct file *filp,
 			       pgoff_t index, unsigned long req_count)
 {
+	DEFINE_READAHEAD(rac, filp, mapping, index);
+	rac._nr_pages = req_count;
+
 	/* no read-ahead */
 	if (!ra->ra_pages)
 		return;
@@ -659,7 +663,7 @@ void page_cache_sync_readahead(struct address_space *mapping,
 	}
 
 	/* do read-ahead */
-	ondemand_readahead(mapping, ra, filp, NULL, index, req_count);
+	ondemand_readahead(&rac, ra, NULL);
 }
 EXPORT_SYMBOL_GPL(page_cache_sync_readahead);
 
@@ -683,7 +687,10 @@ page_cache_async_readahead(struct address_space *mapping,
 			   struct page *page, pgoff_t index,
 			   unsigned long req_count)
 {
-	/* no read-ahead */
+	DEFINE_READAHEAD(rac, filp, mapping, index);
+	rac._nr_pages = req_count;
+
+	/* No Read-ahead */
 	if (!ra->ra_pages)
 		return;
 
@@ -705,7 +712,7 @@ page_cache_async_readahead(struct address_space *mapping,
 		return;
 
 	/* do read-ahead */
-	ondemand_readahead(mapping, ra, filp, page, index, req_count);
+	ondemand_readahead(&rac, ra, page);
 }
 EXPORT_SYMBOL_GPL(page_cache_async_readahead);
 


