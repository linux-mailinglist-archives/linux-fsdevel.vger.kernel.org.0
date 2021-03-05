Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA81232E0C5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Mar 2021 05:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbhCEE2a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Mar 2021 23:28:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhCEE23 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Mar 2021 23:28:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B291CC061574;
        Thu,  4 Mar 2021 20:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=+gAkfU1JkXjwF3GYBjHXsSgNo4U4uzwhoammc6XTTH4=; b=tPyoTVAHCI/oKld3COtQHSG4d5
        jTUi/S4CcVcRjWU0x1gYM8xrxwsLTVT3/D4sW8GHjZ1A3Us5Fq9MZY4Cu2k5okWptNfzXy5oWsOPR
        9K0vHa1UNHJXnV8tAwYmZJd01ZD5KDiT/v5iR3oX5hfxCsz56FYJZl7p2iZfTnSHYcud3asMJeFRU
        FimJlvT3uCpOOkFUun3gRAHsRHU12BSgPyWyZJ0P0+ws/D5zqoZdXdvJlRrSofvJg549zYJVUxOzg
        ft4ulMBjCX4tM0Drdkj+EIQEvU5JZQpUQNDSDNWnVgIvm3l8FaMwOM9knEU8LWYUTB947bEusnOI9
        ljeTaWBw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lI23Y-00A5SZ-2K; Fri, 05 Mar 2021 04:27:29 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 25/25] cachefiles: Switch to wait_page_key
Date:   Fri,  5 Mar 2021 04:19:01 +0000
Message-Id: <20210305041901.2396498-26-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210305041901.2396498-1-willy@infradead.org>
References: <20210305041901.2396498-1-willy@infradead.org>
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
index e027c718ca01..b1dbc484a9c7 100644
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
index 2236f726bf01..699a6a0bcc54 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -609,7 +609,6 @@ static inline pgoff_t linear_page_index(struct vm_area_struct *vma,
 	return pgoff;
 }
 
-/* This has the same layout as wait_bit_key - see fs/cachefiles/rdwr.c */
 struct wait_page_key {
 	struct folio *folio;
 	int bit_nr;
-- 
2.30.0

