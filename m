Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75612373E8C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 17:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbhEEPcV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 11:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbhEEPcU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 11:32:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D400C061574;
        Wed,  5 May 2021 08:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=gUoExV306Y7Xrq48Y1czNMrtCl1FtU2ibChLj/7K4h4=; b=SLr48Y9DqgUpZh1Kv9SUgU5RHm
        TdUkaqLA/YBYc5JuTsH12tU36PZNI4AF0NfV04bxgU6lVMsquQfCTSuyqDEvbtIqYZpSkxySaFLlU
        8Lixl74J2QWnLi5PTYjpoiLnlCrMr+Dbh1yWaDh+jVrlno7tm5WT3hmbGMMira4uGCUtm+RNJD/DM
        YBeaf8WkrxTXq63qad+DFQ7/StdUof7uep9lD2OGWGTttzisVLT794bdlIfP571zAfbUax2TW7qK/
        dwCadTiKwg/Jie0+/yUS5X/DuSQ2T8bq28HQhINKP27RjHda6bjFVZze2ZecD3g07g1y0ldHylAq0
        4R7Uq0ew==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leJT8-000VAR-Hh; Wed, 05 May 2021 15:30:20 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v9 21/96] mm/filemap: Add folio_offset and folio_file_offset
Date:   Wed,  5 May 2021 16:05:13 +0100
Message-Id: <20210505150628.111735-22-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210505150628.111735-1-willy@infradead.org>
References: <20210505150628.111735-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These are just wrappers around their page counterpart.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/pagemap.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 5ccc73c760b1..2df82e356821 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -634,6 +634,16 @@ static inline loff_t page_file_offset(struct page *page)
 	return ((loff_t)page_index(page)) << PAGE_SHIFT;
 }
 
+static inline loff_t folio_offset(struct folio *folio)
+{
+	return page_offset(&folio->page);
+}
+
+static inline loff_t folio_file_offset(struct folio *folio)
+{
+	return page_file_offset(&folio->page);
+}
+
 extern pgoff_t linear_hugepage_index(struct vm_area_struct *vma,
 				     unsigned long address);
 
-- 
2.30.2

