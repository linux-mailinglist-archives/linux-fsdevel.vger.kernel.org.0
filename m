Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9A0814F843
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Feb 2020 16:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbgBAPMn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Feb 2020 10:12:43 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51790 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbgBAPMm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Feb 2020 10:12:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7T6itBiApRciaky4TlalX8Xey/dXpsbhmN7GfbwBCQQ=; b=EsWLez9kTGd6EaoT9SAbd2LujH
        fmHq7OV1St1lovoCDhgD7eVFl1qY1QPAkRPH+0+6/eLviLQI9K115SysliSx+2JmgxuYVfWirMK5v
        q6gthZlrowrCEYkfyaaOTTq4yFGGQ2aDZuv2SLhb1CKh5SZVG5gj/zJqyTlUAdQPo+Y/3GvS6g3M/
        08Xth5WAAiF7zzjzCohSq6IaHrxffG92XKzowTCFaoj1QxrRyCQUO0Pu6eBeys9UZjbdebia9wVi7
        /3D3m0mo+NHYkitIDnpR/K68huWv76tD5+XSl8lzy1RN4ONqA4m/JigpdHDksQHPaSAKPCusJ4ol8
        IWO6ApeQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixuRu-0006HH-2G; Sat, 01 Feb 2020 15:12:42 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 01/12] mm: Fix the return type of __do_page_cache_readahead
Date:   Sat,  1 Feb 2020 07:12:29 -0800
Message-Id: <20200201151240.24082-2-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200201151240.24082-1-willy@infradead.org>
References: <20200201151240.24082-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

ra_submit() which is a wrapper around __do_page_cache_readahead() already
returns an unsigned long, and the 'nr_to_read' parameter is an unsigned
long, so fix __do_page_cache_readahead() to return an unsigned long,
even though I'm pretty sure we're not going to readahead more than 2^32
pages ever.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/internal.h  | 2 +-
 mm/readahead.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 3cf20ab3ca01..41b93c4b3ab7 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -49,7 +49,7 @@ void unmap_page_range(struct mmu_gather *tlb,
 			     unsigned long addr, unsigned long end,
 			     struct zap_details *details);
 
-extern unsigned int __do_page_cache_readahead(struct address_space *mapping,
+extern unsigned long __do_page_cache_readahead(struct address_space *mapping,
 		struct file *filp, pgoff_t offset, unsigned long nr_to_read,
 		unsigned long lookahead_size);
 
diff --git a/mm/readahead.c b/mm/readahead.c
index 2fe72cd29b47..6bf73ef33b7e 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -152,7 +152,7 @@ static int read_pages(struct address_space *mapping, struct file *filp,
  *
  * Returns the number of pages requested, or the maximum amount of I/O allowed.
  */
-unsigned int __do_page_cache_readahead(struct address_space *mapping,
+unsigned long __do_page_cache_readahead(struct address_space *mapping,
 		struct file *filp, pgoff_t offset, unsigned long nr_to_read,
 		unsigned long lookahead_size)
 {
@@ -161,7 +161,7 @@ unsigned int __do_page_cache_readahead(struct address_space *mapping,
 	unsigned long end_index;	/* The last page we want to read */
 	LIST_HEAD(page_pool);
 	int page_idx;
-	unsigned int nr_pages = 0;
+	unsigned long nr_pages = 0;
 	loff_t isize = i_size_read(inode);
 	gfp_t gfp_mask = readahead_gfp_mask(mapping);
 
-- 
2.24.1

