Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8782598A0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Sep 2020 18:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732048AbgIAQ3H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Sep 2020 12:29:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41194 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732109AbgIAQ3C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Sep 2020 12:29:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598977740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sChPbft+Yjw8rk61mHgyqBrpWiSpcftbFDciQ4tpAS4=;
        b=ddqACsE/Yi3rMvbbDkoLIdDEJZ2AYPzSfcEfl94RDSYA8X3HazFbaabyYHlB7Ic7NMpnM3
        9mnEkFsUqnO/A8iB3iNOXTmSRgSxzppSKa3HUF1qphJsdCfHhoCXD0kI/EwzzuynG53fQq
        inCvsm0HwmXyFlbki288bSSPKtXmrEY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-_kh1rbyIPdafDI3y-0tX2A-1; Tue, 01 Sep 2020 12:28:55 -0400
X-MC-Unique: _kh1rbyIPdafDI3y-0tX2A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8753110ABDA1;
        Tue,  1 Sep 2020 16:28:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-113-231.rdu2.redhat.com [10.10.113.231])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 632785D9D3;
        Tue,  1 Sep 2020 16:28:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 5/7] mm: Make __do_page_cache_readahead() use
 rac->_nr_pages
From:   David Howells <dhowells@redhat.com>
To:     willy@infradead.org
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Tue, 01 Sep 2020 17:28:52 +0100
Message-ID: <159897773253.405783.7186877407321511610.stgit@warthog.procyon.org.uk>
In-Reply-To: <159897769535.405783.17587409235571100774.stgit@warthog.procyon.org.uk>
References: <159897769535.405783.17587409235571100774.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make __do_page_cache_readahead() use rac->_nr_pages rather than passing in
nr_to_read argument.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/ext4/verity.c        |    8 +++++---
 fs/f2fs/verity.c        |    8 +++++---
 include/linux/pagemap.h |    3 +--
 mm/internal.h           |    6 +++---
 mm/readahead.c          |   20 +++++++++++---------
 5 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
index 6fc2dbc87c0b..3d377110e839 100644
--- a/fs/ext4/verity.c
+++ b/fs/ext4/verity.c
@@ -356,10 +356,12 @@ static struct page *ext4_read_merkle_tree_page(struct inode *inode,
 
 	page = find_get_page_flags(inode->i_mapping, index, FGP_ACCESSED);
 	if (!page || !PageUptodate(page)) {
-		if (page)
+		if (page) {
 			put_page(page);
-		else if (num_ra_pages > 1)
-			page_cache_readahead_unbounded(&rac, num_ra_pages, 0);
+		} else if (num_ra_pages > 1) {
+			rac._nr_pages = num_ra_pages;
+			page_cache_readahead_unbounded(&rac, 0);
+		}
 		page = read_mapping_page(inode->i_mapping, index, NULL);
 	}
 	return page;
diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
index 392dd07f4214..8445eed5a1bc 100644
--- a/fs/f2fs/verity.c
+++ b/fs/f2fs/verity.c
@@ -235,10 +235,12 @@ static struct page *f2fs_read_merkle_tree_page(struct inode *inode,
 
 	page = find_get_page_flags(inode->i_mapping, index, FGP_ACCESSED);
 	if (!page || !PageUptodate(page)) {
-		if (page)
+		if (page) {
 			put_page(page);
-		else if (num_ra_pages > 1)
-			page_cache_readahead_unbounded(&rac, num_ra_pages, 0);
+		} else if (num_ra_pages > 1) {
+			rac._nr_pages = num_ra_pages;
+			page_cache_readahead_unbounded(&rac, 0);
+		}
 		page = read_mapping_page(inode->i_mapping, index, NULL);
 	}
 	return page;
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index cd7bde29d4cc..72e9c44d62bb 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -772,8 +772,7 @@ void delete_from_page_cache_batch(struct address_space *mapping,
 void page_cache_sync_readahead(struct readahead_control *, struct file_ra_state *);
 void page_cache_async_readahead(struct readahead_control *, struct file_ra_state *,
 				struct page *);
-void page_cache_readahead_unbounded(struct readahead_control *,
-		unsigned long nr_to_read, unsigned long lookahead_count);
+void page_cache_readahead_unbounded(struct readahead_control *, unsigned long);
 
 /*
  * Like add_to_page_cache_locked, but used to add newly allocated pages:
diff --git a/mm/internal.h b/mm/internal.h
index 2eb9f7f5f134..e1d296e76fb0 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -50,8 +50,7 @@ void unmap_page_range(struct mmu_gather *tlb,
 			     struct zap_details *details);
 
 void force_page_cache_readahead(struct readahead_control *);
-void __do_page_cache_readahead(struct readahead_control *,
-		unsigned long nr_to_read, unsigned long lookahead_size);
+void __do_page_cache_readahead(struct readahead_control *, unsigned long);
 
 /*
  * Submit IO for the read-ahead request in file_ra_state.
@@ -60,7 +59,8 @@ static inline void ra_submit(struct file_ra_state *ra,
 		struct address_space *mapping, struct file *file)
 {
 	DEFINE_READAHEAD(rac, file, mapping, ra->start);
-	__do_page_cache_readahead(&rac, ra->size, ra->async_size);
+	rac._nr_pages = ra->size;
+	__do_page_cache_readahead(&rac, ra->async_size);
 }
 
 /**
diff --git a/mm/readahead.c b/mm/readahead.c
index 7114246b4e41..28ff80304a21 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -172,10 +172,11 @@ static void read_pages(struct readahead_control *rac, struct list_head *pages,
  * May sleep, but will not reenter filesystem to reclaim memory.
  */
 void page_cache_readahead_unbounded(struct readahead_control *rac,
-		unsigned long nr_to_read, unsigned long lookahead_size)
+				    unsigned long lookahead_size)
 {
 	struct address_space *mapping = rac->mapping;
 	unsigned long index = readahead_index(rac);
+	unsigned long nr_to_read = readahead_count(rac);
 	LIST_HEAD(page_pool);
 	gfp_t gfp_mask = readahead_gfp_mask(mapping);
 	unsigned long i;
@@ -195,6 +196,7 @@ void page_cache_readahead_unbounded(struct readahead_control *rac,
 	/*
 	 * Preallocate as many pages as we will need.
 	 */
+	rac->_nr_pages = 0;
 	for (i = 0; i < nr_to_read; i++) {
 		struct page *page = xa_load(&mapping->i_pages, index + i);
 
@@ -247,7 +249,7 @@ EXPORT_SYMBOL_GPL(page_cache_readahead_unbounded);
  * We really don't want to intermingle reads and writes like that.
  */
 void __do_page_cache_readahead(struct readahead_control *rac,
-		unsigned long nr_to_read, unsigned long lookahead_size)
+			       unsigned long lookahead_size)
 {
 	struct inode *inode = rac->mapping->host;
 	unsigned long index = readahead_index(rac);
@@ -261,10 +263,10 @@ void __do_page_cache_readahead(struct readahead_control *rac,
 	if (index > end_index)
 		return;
 	/* Don't read past the page containing the last byte of the file */
-	if (nr_to_read > end_index - index)
-		nr_to_read = end_index - index + 1;
+	if (readahead_count(rac) > end_index - index)
+		rac->_nr_pages = end_index - index + 1;
 
-	page_cache_readahead_unbounded(rac, nr_to_read, lookahead_size);
+	page_cache_readahead_unbounded(rac, lookahead_size);
 }
 
 /*
@@ -297,8 +299,7 @@ void force_page_cache_readahead(struct readahead_control *rac)
 
 		rac->_index = index;
 		rac->_nr_pages = this_chunk;
-		// Do I need to modify rac->_batch_count?
-		__do_page_cache_readahead(rac, this_chunk, 0);
+		__do_page_cache_readahead(rac, 0);
 
 		index += this_chunk;
 		nr_to_read -= this_chunk;
@@ -601,7 +602,7 @@ static void ondemand_readahead(struct readahead_control *rac,
 	 * standalone, small random read
 	 * Read as is, and do not pollute the readahead state.
 	 */
-	__do_page_cache_readahead(rac, req_size, 0);
+	__do_page_cache_readahead(rac, 0);
 	return;
 
 initial_readahead:
@@ -630,7 +631,8 @@ static void ondemand_readahead(struct readahead_control *rac,
 	rac->_index = ra->start;
 	if (page && page_cache_readahead_order(rac, ra, thp_order(page)))
 		return;
-	__do_page_cache_readahead(rac, ra->size, ra->async_size);
+	rac->_nr_pages = ra->size;
+	__do_page_cache_readahead(rac, ra->async_size);
 }
 
 /**


