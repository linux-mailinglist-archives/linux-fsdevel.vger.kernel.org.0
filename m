Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB19B2FA708
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jan 2021 18:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406921AbhARRGe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 12:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406810AbhARRET (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 12:04:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A3FC0613ED;
        Mon, 18 Jan 2021 09:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=cTOpJKpaWG1T2olInxdo/JtYe/CGbbNz/gPOn4Fxrq8=; b=p6E17oGJgO7ca7drhZoZJR4lZT
        xxu34oeTRCxsNIquO7WC0+nBCAGmKRFwXddlh+q2zv01RvxrrW4CC/f6uUbmhF3HATUxP0cYfzKRS
        taOO2mli0NWSv6g+pOCkIPEoiQMflnX7AuC228Q7kdtsRFcVJwg5VpVPO3U4z+CQ2k4c0Q185AJZH
        rQhcdJskwqxUD5W39N55foJV651CllKXZ3au9IOPYeDsKyLC12Ns5GjJ6TfTELRVIW6r2gyY+7IY2
        iJr+frT09M94ofbwC0ljOja5UBnwEVJlj2WAEBGuUsgpB/g9b/9A5voGXBaGtjvC44PKO4pPNyNa8
        Sd6y0lZw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l1XwF-00D7XQ-3l; Mon, 18 Jan 2021 17:03:35 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 27/27] cachefiles: Switch to wait_page_key
Date:   Mon, 18 Jan 2021 17:01:48 +0000
Message-Id: <20210118170148.3126186-28-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210118170148.3126186-1-willy@infradead.org>
References: <20210118170148.3126186-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Cachefiles was relying on wait_page_key and wait_bit_key being the
same layout, which is fragile.  Now that wait_page_key is exposed in
the pagemap.h header, we can remove that fragility.  Also switch it
to use the folio directly instead of the page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/cachefiles/rdwr.c    | 13 ++++++-------
 include/linux/pagemap.h |  1 -
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/cachefiles/rdwr.c b/fs/cachefiles/rdwr.c
index 8bda092e60c5..f64b2d01578b 100644
--- a/fs/cachefiles/rdwr.c
+++ b/fs/cachefiles/rdwr.c
@@ -24,22 +24,21 @@ static int cachefiles_read_waiter(wait_queue_entry_t *wait, unsigned mode,
 		container_of(wait, struct cachefiles_one_read, monitor);
 	struct cachefiles_object *object;
 	struct fscache_retrieval *op = monitor->op;
-	struct wait_bit_key *key = _key;
-	struct page *page = wait->private;
+	struct wait_page_key *key = _key;
+	struct folio *folio = wait->private;
 
 	ASSERT(key);
 
 	_enter("{%lu},%u,%d,{%p,%u}",
 	       monitor->netfs_page->index, mode, sync,
-	       key->flags, key->bit_nr);
+	       key->folio, key->bit_nr);
 
-	if (key->flags != &page->flags ||
-	    key->bit_nr != PG_locked)
+	if (key->folio != folio || key->bit_nr != PG_locked)
 		return 0;
 
-	_debug("--- monitor %p %lx ---", page, page->flags);
+	_debug("--- monitor %p %lx ---", folio, folio->page.flags);
 
-	if (!PageUptodate(page) && !PageError(page)) {
+	if (!FolioUptodate(folio) && !FolioError(folio)) {
 		/* unlocked, not uptodate and not erronous? */
 		_debug("page probably truncated");
 	}
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index cf235fd60478..a0c5345041be 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -592,7 +592,6 @@ static inline pgoff_t linear_page_index(struct vm_area_struct *vma,
 	return pgoff;
 }
 
-/* This has the same layout as wait_bit_key - see fs/cachefiles/rdwr.c */
 struct wait_page_key {
 	struct folio *folio;
 	int bit_nr;
-- 
2.29.2

