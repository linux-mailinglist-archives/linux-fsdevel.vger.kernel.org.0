Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE42B1E7317
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 05:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388694AbgE2C7b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 22:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407400AbgE2C6k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 22:58:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D68C08C5CA;
        Thu, 28 May 2020 19:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=NOeVvS/Xe8KyQK/jGHWOfgM4edh2SPt/XfnzQhgpf2k=; b=S30SMl1AinKd+Zgi5pubws24Mn
        s8xlXkZe1lDBI9STBHnSM5nLj0KNraX38WPIFuCf2pEvjIx4hYqSdy0lciAMVWGgxT2bob9z1iweE
        5gPJn6lppPwxLIoGLEHqu+aGeevNAyQUmO8KHy8i3udRj0jI1OqgXRO28svI1munPlluxG1r+jiWo
        OKFZ5WprUfq1nRDnGtp6p96UjBRUbz9XeBtQOQgsRNDuowsbb3LgmmEiXpbKVCfHtGTKMmEA6mz5w
        fl9b04wNmiOM+EKdDgb/pP0mkwsCnhmZstTeorJT3e1KAhPAEuUYCoKrgN7rJqpdUfBGzvJpLianN
        ppKQEbiw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeVE2-0008QC-QE; Fri, 29 May 2020 02:58:26 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v5 06/39] mm: Introduce offset_in_thp
Date:   Thu, 28 May 2020 19:57:51 -0700
Message-Id: <20200529025824.32296-7-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200529025824.32296-1-willy@infradead.org>
References: <20200529025824.32296-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Mirroring offset_in_page(), this gives you the offset within this
particular page, no matter what size page it is.  It optimises down
to offset_in_page() if CONFIG_TRANSPARENT_HUGEPAGE is not set.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 088acbda722d..9a55dce6a535 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1577,6 +1577,7 @@ static inline void clear_page_pfmemalloc(struct page *page)
 extern void pagefault_out_of_memory(void);
 
 #define offset_in_page(p)	((unsigned long)(p) & ~PAGE_MASK)
+#define offset_in_thp(page, p)	((unsigned long)(p) & (thp_size(page) - 1))
 
 /*
  * Flags passed to show_mem() and show_free_areas() to suppress output in
-- 
2.26.2

