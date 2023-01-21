Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967766764AE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jan 2023 07:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjAUG6J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Jan 2023 01:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjAUG6G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Jan 2023 01:58:06 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C0660C86;
        Fri, 20 Jan 2023 22:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=bHu6JRelc+qZi6VORfZamvMyu/HPfdmrjb1TOTy3Elw=; b=o85/NWmcxDB/Xm7nZyJ0u/OaV4
        ggW//BSlYDr37PRhsjTqUedxbeyHbfv86D0FnsnWS/acgHDwbC7vRGBjt++MRUgQ/3pbPOeeMsEB+
        yjRRjbsrkonl6kRfgvlX4vfhstx9bcDnXebOYT7/I0dFKcfOFG+xhP8bJ1sS4rofk1BV3nKNKtCGc
        HP9YgxyOp5ORr9AQtDyrxpJvPs+obr8M5TM+rXPqQkOu3400e818tBxrWdFkj8ktdzJIM00uyH77B
        JKhwoaJWyaUV/XVYcRHjxVXq35tjpdi8v6cqJRfKVL3Oajn10ei14YSeO22Z6+5oB5hPcuEztJVSc
        Ss7hYuVg==;
Received: from [2001:4bb8:19a:2039:6754:cc81:9ace:36fc] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pJ7pC-00DSMf-Vk; Sat, 21 Jan 2023 06:58:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>
Cc:     linux-afs@lists.infradead.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nilfs@vger.kernel.org
Subject: [PATCH 2/7] mm: make mapping_get_entry available outside of filemap.c
Date:   Sat, 21 Jan 2023 07:57:50 +0100
Message-Id: <20230121065755.1140136-3-hch@lst.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230121065755.1140136-1-hch@lst.de>
References: <20230121065755.1140136-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

mapping_get_entry is useful for page cache API users that need to know
about xa_value internals.  Rename it and make it available in pagemap.h.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 1 +
 mm/filemap.c            | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 9f108168377195..24dedf6b12be49 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -507,6 +507,7 @@ pgoff_t page_cache_prev_miss(struct address_space *mapping,
 #define FGP_ENTRY		0x00000080
 #define FGP_STABLE		0x00000100
 
+void *filemap_get_entry(struct address_space *mapping, pgoff_t index);
 struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 		int fgp_flags, gfp_t gfp);
 struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
diff --git a/mm/filemap.c b/mm/filemap.c
index c915ded191f03f..ed0583f9e27512 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1834,7 +1834,7 @@ EXPORT_SYMBOL(page_cache_prev_miss);
  */
 
 /*
- * mapping_get_entry - Get a page cache entry.
+ * filemap_get_entry - Get a page cache entry.
  * @mapping: the address_space to search
  * @index: The page cache index.
  *
@@ -1845,7 +1845,7 @@ EXPORT_SYMBOL(page_cache_prev_miss);
  *
  * Return: The folio, swap or shadow entry, %NULL if nothing is found.
  */
-static void *mapping_get_entry(struct address_space *mapping, pgoff_t index)
+void *filemap_get_entry(struct address_space *mapping, pgoff_t index)
 {
 	XA_STATE(xas, &mapping->i_pages, index);
 	struct folio *folio;
@@ -1915,7 +1915,7 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 	struct folio *folio;
 
 repeat:
-	folio = mapping_get_entry(mapping, index);
+	folio = filemap_get_entry(mapping, index);
 	if (xa_is_value(folio)) {
 		if (fgp_flags & FGP_ENTRY)
 			return folio;
-- 
2.39.0

