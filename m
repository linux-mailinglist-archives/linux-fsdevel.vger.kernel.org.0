Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF5E51F5CD0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 22:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730917AbgFJUQ7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 16:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730542AbgFJUNt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:13:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B077C0A88B4;
        Wed, 10 Jun 2020 13:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=78nHOizw+EWRinzuA/mQKnq3TFssCLkrB+hP2+3ZTSU=; b=WJlfH1qcHthNYhpNssG2ts7bW9
        ZLR7XRa3dIHv+Zrs2yb31eOEQQDU8OYKVvYwX+ul3o9tt2oar2VaK/IUaYfLTwGOeDPDBS0Bgk9gc
        GLOpvCF0XyxW2jHTOHLld13d8x8nYvD0TCGu+OW9CIfjXDTYt0DL6+YI9H5/EKl7bq+OvXWCjAdDM
        YkB7wbFtYm2K+vhYxWotrB39+oYIqp9Yl7DkUVfDjdZtU0D5b0Fn6pklltYmVUrXkFUOHD5vE66If
        dwKqAsKDkcD+Sy/obPNTgjnXO7Ix9OhrO4AsDvcxKcKkdeb5czPcyebiLYQTEtNM7VswwxqtwEJlu
        TC0ffTxQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jj76a-0003V3-1h; Wed, 10 Jun 2020 20:13:48 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 21/51] block: Support THPs in page_is_mergeable
Date:   Wed, 10 Jun 2020 13:13:15 -0700
Message-Id: <20200610201345.13273-22-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200610201345.13273-1-willy@infradead.org>
References: <20200610201345.13273-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

page_is_mergeable() would incorrectly claim that two IOs were on different
pages because they were on different base pages rather than on the
same THP.  This led to a reference counting bug in iomap.  Simplify the
'same_page' test by just comparing whether we have the same struct page
instead of doing arithmetic on the physical addresses.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 block/bio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index 5235da6434aa..cd677cde853d 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -747,7 +747,7 @@ static inline bool page_is_mergeable(const struct bio_vec *bv,
 	if (xen_domain() && !xen_biovec_phys_mergeable(bv, page))
 		return false;
 
-	*same_page = ((vec_end_addr & PAGE_MASK) == page_addr);
+	*same_page = bv->bv_page == page;
 	if (!*same_page && pfn_to_page(PFN_DOWN(vec_end_addr)) + 1 != page)
 		return false;
 	return true;
-- 
2.26.2

