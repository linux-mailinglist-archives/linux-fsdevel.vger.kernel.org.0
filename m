Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC201F4B80
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 04:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbgFJCjl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 22:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbgFJCjl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 22:39:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20425C05BD1E
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jun 2020 19:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Vv8bvXiX1qPH7NGlI8CBFw5+3LL/jDCA14X6pY9LJzA=; b=R5nHtFKtqZeoG+gcc0fGS3gaOL
        y89AMGAupuYd7etNIIFBQELJ1UHM/DCMVX8ujCe5NzM2yAmJWnrlWPeFemJw1U1JCxZZ01ESpZYFr
        054q+WBfj9en/w+vBbPZ/pbZJ5l+Ug51QcaBbgVEdSPQDJbK51eaYBXPHS4FO1LVMI4ojLwqi7JR9
        4hPhxLNgtyxbMQBGoDlB1U4RCsY9lDmVKA2LGYVtw1IRYM6/n7KyL+yqEbYRlIo9G4CdjucM2OREM
        mfHjfRIfycMQfL5ZeuObmP7iZVhOaRNs37cttj0V8nZ7vwN+SYjCENOvsi6Mx4dCF1XXcDDXmqeAf
        ZALu5hsQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jiqeS-0002lr-2e; Wed, 10 Jun 2020 02:39:40 +0000
Date:   Tue, 9 Jun 2020 19:39:39 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     Andres Freund <andres@anarazel.de>
Subject: [RFC] page cache drop-behind
Message-ID: <20200610023939.GI19604@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Andres reported a problem recently where reading a file several times
the size of memory causes intermittent stalls.  My suspicion is that
page allocation eventually runs into the low watermark and starts to
do reclaim.  Some shrinkers take a long time to run and have a low chance
of actually freeing a page (eg the dentry cache needs to free 21 dentries
which all happen to be on the same pair of pages to free those two pages).

This patch attempts to free pages from the file that we're currently
reading from if there are no pages readily available.  If that doesn't
work, we'll run all the shrinkers just as we did before.

This should solve Andres' problem, although it's a bit narrow in scope.
It might be better to look through the inactive page list, regardless of
which file they were allocated for.  That could solve the "weekly backup"
problem with lots of little files.

I'm not really set up to do performance testing at the moment, so this
is just me thinking hard about the problem.

diff --git a/mm/readahead.c b/mm/readahead.c
index 3c9a8dd7c56c..3531e1808e24 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -111,9 +111,24 @@ int read_cache_pages(struct address_space *mapping, struct list_head *pages,
 	}
 	return ret;
 }
-
 EXPORT_SYMBOL(read_cache_pages);
 
+/*
+ * Attempt to detect a streaming workload which exceeds memory and
+ * handle it by dropping the page cache behind the active part of the
+ * file.
+ */
+static void discard_behind(struct file *file, struct address_space *mapping)
+{
+	unsigned long keep = file->f_ra.ra_pages * 2;
+
+	if (mapping->nrpages < 1000)
+		return;
+	if (file->f_ra.start < keep)
+		return;
+	invalidate_mapping_pages(mapping, 0, file->f_ra.start - keep);
+}
+
 static void read_pages(struct readahead_control *rac, struct list_head *pages,
 		bool skip_page)
 {
@@ -179,6 +194,7 @@ void page_cache_readahead_unbounded(struct address_space *mapping,
 {
 	LIST_HEAD(page_pool);
 	gfp_t gfp_mask = readahead_gfp_mask(mapping);
+	gfp_t light_gfp = gfp_mask & ~__GFP_DIRECT_RECLAIM;
 	struct readahead_control rac = {
 		.mapping = mapping,
 		.file = file,
@@ -219,7 +235,11 @@ void page_cache_readahead_unbounded(struct address_space *mapping,
 			continue;
 		}
 
-		page = __page_cache_alloc(gfp_mask);
+		page = __page_cache_alloc(light_gfp);
+		if (!page) {
+			discard_behind(file, mapping);
+			page = __page_cache_alloc(gfp_mask);
+		}
 		if (!page)
 			break;
 		if (mapping->a_ops->readpages) {
