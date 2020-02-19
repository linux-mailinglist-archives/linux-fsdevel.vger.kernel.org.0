Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70A50165106
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 22:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgBSVBH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 16:01:07 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35870 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbgBSVBF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 16:01:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=kI+e3DKHZCvuETM0kGlQ5Wq6KkhuqIaWlS8EiD2lk0A=; b=ZzC5IVFh0zlc1y+RlFNcNpnUtw
        Rge9z5CBVAmxghZo5qqYsD0k2HEyUgXnAgk0o1iJvoENMLpE1iyVC53S+MIvgvKsQ7v098DYPZc2m
        KF32Sjd1voZIcKRvwP8HuYAU8AoNCWgXiGYtvHra3cRAKlyf/kexaB6/QH43CRRhuIQGSXUZ+HtfS
        8hu9zW+gfrUNOvtp+JCnoAMo6GnCXTByaQRymMZ2omEv+9/G9JWerFHF7ao5084aXIYWiRNI3h62w
        yMud0oTZuBULmwcHEZAf3C8oIapUf/waEYUsFR02ezCMGOo/qJrfJqrG+7AAtFgyZifl8unYi8fx/
        KfHDS9Cw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4WSv-0008Ti-0Z; Wed, 19 Feb 2020 21:01:05 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, ocfs2-devel@oss.oracle.com,
        linux-xfs@vger.kernel.org
Subject: [PATCH v7 08/24] mm: Remove 'page_offset' from readahead loop
Date:   Wed, 19 Feb 2020 13:00:47 -0800
Message-Id: <20200219210103.32400-9-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200219210103.32400-1-willy@infradead.org>
References: <20200219210103.32400-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Replace the page_offset variable with 'index + i'.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/readahead.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 8a25fc7e2bf2..83df5c061d33 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -181,12 +181,10 @@ void __do_page_cache_readahead(struct address_space *mapping,
 	 * Preallocate as many pages as we will need.
 	 */
 	for (i = 0; i < nr_to_read; i++) {
-		pgoff_t page_offset = index + i;
-
-		if (page_offset > end_index)
+		if (index + i > end_index)
 			break;
 
-		page = xa_load(&mapping->i_pages, page_offset);
+		page = xa_load(&mapping->i_pages, index + i);
 		if (page && !xa_is_value(page)) {
 			/*
 			 * Page already present?  Kick off the current batch of
@@ -200,7 +198,7 @@ void __do_page_cache_readahead(struct address_space *mapping,
 		page = __page_cache_alloc(gfp_mask);
 		if (!page)
 			break;
-		page->index = page_offset;
+		page->index = index + i;
 		list_add(&page->lru, &page_pool);
 		if (i == nr_to_read - lookahead_size)
 			SetPageReadahead(page);
-- 
2.25.0

