Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7903325C23D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Sep 2020 16:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbgICOKN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Sep 2020 10:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729153AbgICOJr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Sep 2020 10:09:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE0EC0619C0
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Sep 2020 07:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=6to6D0YT64TBlG0mLnZScY0d5oSLUY3YOnbLcSVTPls=; b=QJX4Yh/nIpmVUyVHYgSPW1NBPO
        M5J0KSRtn3/DYLMCJlY5od8RK/8M/vKtRmDxP4FFdgVsnTdM497OPHMWB4XGkXqzx/k9qdQcIu0uZ
        JGRTLhvrKX7oAPg0E0CmKWhxaeNYAlS4W60xgo46+6Unfor9+rNDQcgSoM4bjbSw9PeyQU9iDbG9c
        bjPtp2XaeFFLg25c1bNTxxHpkGh/B9nmdcIkfMsSVV9Vo7rwjAwIxvOOq5f4ds/KUZErWLkTWtmlk
        vg+4ZX5HV2mfKYU0en04m9loHtygbfqbIhjKkc51PTUqzDVDawGDWEISXwJeeVWRE2Ugwc8ubmOeE
        CyP8/rXA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDpv3-0003ip-Fv; Thu, 03 Sep 2020 14:08:53 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 9/9] mm/readahead: Pass a file_ra_state into force_page_cache_ra
Date:   Thu,  3 Sep 2020 15:08:44 +0100
Message-Id: <20200903140844.14194-10-willy@infradead.org>
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

The file_ra_state being passed into page_cache_sync_readahead() was being
ignored in favour of using the one embedded in the struct file.  The only
caller for which this makes a difference is the fsverity code if the file
has been marked as POSIX_FADV_RANDOM, but it's confusing and worth fixing.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/internal.h  | 5 +++--
 mm/readahead.c | 5 ++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 0a2e5caea2aa..ab4beb7c5cd2 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -51,12 +51,13 @@ void unmap_page_range(struct mmu_gather *tlb,
 
 void do_page_cache_ra(struct readahead_control *, unsigned long nr_to_read,
 		unsigned long lookahead_size);
-void force_page_cache_ra(struct readahead_control *, unsigned long nr);
+void force_page_cache_ra(struct readahead_control *, struct file_ra_state *,
+		unsigned long nr);
 static inline void force_page_cache_readahead(struct address_space *mapping,
 		struct file *file, pgoff_t index, unsigned long nr_to_read)
 {
 	DEFINE_READAHEAD(ractl, file, mapping, index);
-	force_page_cache_ra(&ractl, nr_to_read);
+	force_page_cache_ra(&ractl, &file->f_ra, nr_to_read);
 }
 
 /**
diff --git a/mm/readahead.c b/mm/readahead.c
index 620ac83f35cc..c6ffb76827da 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -272,11 +272,10 @@ void do_page_cache_ra(struct readahead_control *ractl,
  * memory at once.
  */
 void force_page_cache_ra(struct readahead_control *ractl,
-		unsigned long nr_to_read)
+		struct file_ra_state *ra, unsigned long nr_to_read)
 {
 	struct address_space *mapping = ractl->mapping;
 	struct backing_dev_info *bdi = inode_to_bdi(mapping->host);
-	struct file_ra_state *ra = &ractl->file->f_ra;
 	unsigned long max_pages, index;
 
 	if (unlikely(!mapping->a_ops->readpage && !mapping->a_ops->readpages &&
@@ -562,7 +561,7 @@ void page_cache_sync_ra(struct readahead_control *ractl,
 
 	/* be dumb */
 	if (ractl->file && (ractl->file->f_mode & FMODE_RANDOM)) {
-		force_page_cache_ra(ractl, req_count);
+		force_page_cache_ra(ractl, ra, req_count);
 		return;
 	}
 
-- 
2.28.0

