Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73172342AF4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Mar 2021 06:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbhCTFmB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Mar 2021 01:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbhCTFli (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Mar 2021 01:41:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1712DC061762;
        Fri, 19 Mar 2021 22:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=pn2iQp4NtMy0xorKKEZu32ELGGpc4Q/aglrDWynXG6M=; b=pU2p3ETmfB40L3ipkMkQXWcidD
        js2WlqlZukO/jJeR/PAT+ycIXhZWye6WUVPJmOUHiRLtxTqKOSraz8kzvsHrbZ6ZYUm9dvPW4eUHq
        hvwY8OsdbBhT1UbbKDkoxOhvYGxoUPk4HSl8cjL5p4s8c6yTQRqebv07ckMSARzuuvqwk5QrLtXnT
        o31KSouJsZdJC6EUeV9D4y77Gh8mGYjxfJmswwpVIZ3MABtGLV4LOKAZqsm4bWCOPrvWd99grp8R5
        HIvHeYssYjSaZ4lArK8XQQzohOeGXxYYOon5kdj8GzryZmb20DiP0W+OwaDAD72zbvriXYXmPTtv6
        MOTLKXhg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lNUMP-005SPi-Mj; Sat, 20 Mar 2021 05:41:19 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org
Subject: [PATCH v5 01/27] fs/cachefiles: Remove wait_bit_key layout dependency
Date:   Sat, 20 Mar 2021 05:40:38 +0000
Message-Id: <20210320054104.1300774-2-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210320054104.1300774-1-willy@infradead.org>
References: <20210320054104.1300774-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Cachefiles was relying on wait_page_key and wait_bit_key being the
same layout, which is fragile.  Now that wait_page_key is exposed in
the pagemap.h header, we can remove that fragility

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/cachefiles/rdwr.c    | 7 +++----
 include/linux/pagemap.h | 1 -
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/cachefiles/rdwr.c b/fs/cachefiles/rdwr.c
index e027c718ca01..8ffc40e84a59 100644
--- a/fs/cachefiles/rdwr.c
+++ b/fs/cachefiles/rdwr.c
@@ -24,17 +24,16 @@ static int cachefiles_read_waiter(wait_queue_entry_t *wait, unsigned mode,
 		container_of(wait, struct cachefiles_one_read, monitor);
 	struct cachefiles_object *object;
 	struct fscache_retrieval *op = monitor->op;
-	struct wait_bit_key *key = _key;
+	struct wait_page_key *key = _key;
 	struct page *page = wait->private;
 
 	ASSERT(key);
 
 	_enter("{%lu},%u,%d,{%p,%u}",
 	       monitor->netfs_page->index, mode, sync,
-	       key->flags, key->bit_nr);
+	       key->page, key->bit_nr);
 
-	if (key->flags != &page->flags ||
-	    key->bit_nr != PG_locked)
+	if (key->page != page || key->bit_nr != PG_locked)
 		return 0;
 
 	_debug("--- monitor %p %lx ---", page, page->flags);
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index f68fe61c1dec..139678f382ff 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -574,7 +574,6 @@ static inline pgoff_t linear_page_index(struct vm_area_struct *vma,
 	return pgoff;
 }
 
-/* This has the same layout as wait_bit_key - see fs/cachefiles/rdwr.c */
 struct wait_page_key {
 	struct page *page;
 	int bit_nr;
-- 
2.30.2

