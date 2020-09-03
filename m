Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDCD125C3C2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Sep 2020 16:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbgICO6A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Sep 2020 10:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729144AbgICOJQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Sep 2020 10:09:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9D3C0611E0
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Sep 2020 07:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=s8Y9NHR6VFmBSMmMh1rZLBkl40U5H74KzuWSPSFD8/8=; b=tNrJZj08hu8NN1BUitoYvBZVUF
        F0tJeTdfRb8qEKvczxSGMbBzXWLauiRYZ2+4qjBR1Img4Cr/mdfIhEPMkhshHgJ+ntt7I3GMZ2+r8
        VJQMp2noQkUV0Jjelsy31pouTMtvfu5rthJV3J/AYCcDWzBW50ELLDtAL1AmxG9Wpe51FLG66hP/G
        39OtBEs4aU2zgu4wqD3hCLlNSoHDgFsjZxQCgTo8ORHBhIbZW0unGqu60Tl3ibs4svQ4/nAuB5PwC
        S9tUuhXGPGYgfzKSOZJg1gJ4dhO0vCKJGO+/iBR3T3kSWS6PVTFSyr+1bK/V7EBlPfCPRhUw2eaQA
        HXyf91aA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDpv2-0003iT-LD; Thu, 03 Sep 2020 14:08:52 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 6/9] mm/readahead: Pass readahead_control to force_page_cache_ra
Date:   Thu,  3 Sep 2020 15:08:41 +0100
Message-Id: <20200903140844.14194-7-willy@infradead.org>
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

Reimplement force_page_cache_readahead() as a wrapper around
force_page_cache_ra().  Pass the existing readahead_control from
page_cache_sync_readahead().

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/internal.h  | 13 +++++++++----
 mm/readahead.c | 18 ++++++++++--------
 2 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 6aef85f62b9d..5533e85bd123 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -49,10 +49,15 @@ void unmap_page_range(struct mmu_gather *tlb,
 			     unsigned long addr, unsigned long end,
 			     struct zap_details *details);
 
-void force_page_cache_readahead(struct address_space *, struct file *,
-		pgoff_t index, unsigned long nr_to_read);
-void do_page_cache_ra(struct readahead_control *,
-		unsigned long nr_to_read, unsigned long lookahead_size);
+void do_page_cache_ra(struct readahead_control *, unsigned long nr_to_read,
+		unsigned long lookahead_size);
+void force_page_cache_ra(struct readahead_control *, unsigned long nr);
+static inline void force_page_cache_readahead(struct address_space *mapping,
+		struct file *file, pgoff_t index, unsigned long nr_to_read)
+{
+	DEFINE_READAHEAD(ractl, file, mapping, index);
+	force_page_cache_ra(&ractl, nr_to_read);
+}
 
 /*
  * Submit IO for the read-ahead request in file_ra_state.
diff --git a/mm/readahead.c b/mm/readahead.c
index 73110c4148f8..3115ced5faae 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -271,13 +271,13 @@ void do_page_cache_ra(struct readahead_control *ractl,
  * Chunk the readahead into 2 megabyte units, so that we don't pin too much
  * memory at once.
  */
-void force_page_cache_readahead(struct address_space *mapping,
-		struct file *file, pgoff_t index, unsigned long nr_to_read)
+void force_page_cache_ra(struct readahead_control *ractl,
+		unsigned long nr_to_read)
 {
-	DEFINE_READAHEAD(ractl, file, mapping, index);
+	struct address_space *mapping = ractl->mapping;
 	struct backing_dev_info *bdi = inode_to_bdi(mapping->host);
-	struct file_ra_state *ra = &file->f_ra;
-	unsigned long max_pages;
+	struct file_ra_state *ra = &ractl->file->f_ra;
+	unsigned long max_pages, index;
 
 	if (unlikely(!mapping->a_ops->readpage && !mapping->a_ops->readpages &&
 			!mapping->a_ops->readahead))
@@ -287,14 +287,16 @@ void force_page_cache_readahead(struct address_space *mapping,
 	 * If the request exceeds the readahead window, allow the read to
 	 * be up to the optimal hardware IO size
 	 */
+	index = readahead_index(ractl);
 	max_pages = max_t(unsigned long, bdi->io_pages, ra->ra_pages);
-	nr_to_read = min(nr_to_read, max_pages);
+	nr_to_read = min_t(unsigned long, nr_to_read, max_pages);
 	while (nr_to_read) {
 		unsigned long this_chunk = (2 * 1024 * 1024) / PAGE_SIZE;
 
 		if (this_chunk > nr_to_read)
 			this_chunk = nr_to_read;
-		do_page_cache_ra(&ractl, this_chunk, 0);
+		ractl->_index = index;
+		do_page_cache_ra(ractl, this_chunk, 0);
 
 		index += this_chunk;
 		nr_to_read -= this_chunk;
@@ -576,7 +578,7 @@ void page_cache_sync_readahead(struct address_space *mapping,
 
 	/* be dumb */
 	if (filp && (filp->f_mode & FMODE_RANDOM)) {
-		force_page_cache_readahead(mapping, filp, index, req_count);
+		force_page_cache_ra(&ractl, req_count);
 		return;
 	}
 
-- 
2.28.0

