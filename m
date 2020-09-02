Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0572025AFB9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 17:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbgIBPok (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 11:44:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33480 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728353AbgIBPoj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:44:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599061475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V4CHpzZV3WxhXnFWX3WjxwezsCZ0gw1JjzH53agFM0E=;
        b=Qe9sRCf3idTnVBSht/2gsOWWZnJF4yIcpP7dG3laP39/al2EpK81mTSM+pFyRVR8jZhhNH
        PtrhLoWI7RXenjyeGuMXkTgNHye9aQRS62a0HxAN3U5oq/5IlwHBgTvJZJ3cBX/W6hDic2
        hSkbotGLEnU7WxF/vvpznDQtUyU3IMY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-oroO2E7PN_GR3NltQaaFEw-1; Wed, 02 Sep 2020 11:44:34 -0400
X-MC-Unique: oroO2E7PN_GR3NltQaaFEw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0F11107B102;
        Wed,  2 Sep 2020 15:44:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-113-6.rdu2.redhat.com [10.10.113.6])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C9F1D19C59;
        Wed,  2 Sep 2020 15:44:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 2/6] mm: Make ondemand_readahead() take a
 readahead_control struct [ver #2]
From:   David Howells <dhowells@redhat.com>
To:     willy@infradead.org
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Wed, 02 Sep 2020 16:44:31 +0100
Message-ID: <159906147106.663183.11426662588034129469.stgit@warthog.procyon.org.uk>
In-Reply-To: <159906145700.663183.3678164182141075453.stgit@warthog.procyon.org.uk>
References: <159906145700.663183.3678164182141075453.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make ondemand_readahead() take a readahead_control struct in preparation
for making do_sync_mmap_readahead() pass down an RAC struct.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 mm/readahead.c |   32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 91859e6e2b7d..e3e3419dfe3d 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -511,14 +511,14 @@ static bool page_cache_readahead_order(struct readahead_control *rac,
 /*
  * A minimal readahead algorithm for trivial sequential/random reads.
  */
-static void ondemand_readahead(struct address_space *mapping,
-		struct file_ra_state *ra, struct file *file,
-		struct page *page, pgoff_t index, unsigned long req_size)
+static void ondemand_readahead(struct readahead_control *rac,
+		struct file_ra_state *ra,
+		struct page *page, unsigned long req_size)
 {
-	DEFINE_READAHEAD(rac, file, mapping, index);
-	struct backing_dev_info *bdi = inode_to_bdi(mapping->host);
+	struct backing_dev_info *bdi = inode_to_bdi(rac->mapping->host);
 	unsigned long max_pages = ra->ra_pages;
 	unsigned long add_pages;
+	unsigned long index = rac->_index;
 	pgoff_t prev_index;
 
 	/*
@@ -556,7 +556,7 @@ static void ondemand_readahead(struct address_space *mapping,
 		pgoff_t start;
 
 		rcu_read_lock();
-		start = page_cache_next_miss(mapping, index + 1, max_pages);
+		start = page_cache_next_miss(rac->mapping, index + 1, max_pages);
 		rcu_read_unlock();
 
 		if (!start || start - index > max_pages)
@@ -589,14 +589,14 @@ static void ondemand_readahead(struct address_space *mapping,
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
@@ -622,10 +622,10 @@ static void ondemand_readahead(struct address_space *mapping,
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
@@ -645,6 +645,8 @@ void page_cache_sync_readahead(struct address_space *mapping,
 			       struct file_ra_state *ra, struct file *filp,
 			       pgoff_t index, unsigned long req_count)
 {
+	DEFINE_READAHEAD(rac, filp, mapping, index);
+
 	/* no read-ahead */
 	if (!ra->ra_pages)
 		return;
@@ -659,7 +661,7 @@ void page_cache_sync_readahead(struct address_space *mapping,
 	}
 
 	/* do read-ahead */
-	ondemand_readahead(mapping, ra, filp, NULL, index, req_count);
+	ondemand_readahead(&rac, ra, NULL, req_count);
 }
 EXPORT_SYMBOL_GPL(page_cache_sync_readahead);
 
@@ -683,7 +685,9 @@ page_cache_async_readahead(struct address_space *mapping,
 			   struct page *page, pgoff_t index,
 			   unsigned long req_count)
 {
-	/* no read-ahead */
+	DEFINE_READAHEAD(rac, filp, mapping, index);
+
+	/* No Read-ahead */
 	if (!ra->ra_pages)
 		return;
 
@@ -705,7 +709,7 @@ page_cache_async_readahead(struct address_space *mapping,
 		return;
 
 	/* do read-ahead */
-	ondemand_readahead(mapping, ra, filp, page, index, req_count);
+	ondemand_readahead(&rac, ra, page, req_count);
 }
 EXPORT_SYMBOL_GPL(page_cache_async_readahead);
 


