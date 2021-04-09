Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B884F35A68D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 21:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234912AbhDITCS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Apr 2021 15:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234892AbhDITCL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Apr 2021 15:02:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1E5C061762;
        Fri,  9 Apr 2021 12:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=+L2JPL9JCrFGe/hBWTS9q325gvf03q7WNrS88KwFMTI=; b=JqjQzmWmRKUjZIChBEPPY1IUyG
        pEs8cCVGD3wbUzo4ecMpKNA0JHD/tOBzJyYTKkN+6rUZKi38wL3hqKmwAZrU3ucJ4A40jPETYuOnG
        jNqMp1E6hvtJ4WlMQZVE6uGqAWOv1YxKtdmple1Eh09zv07cmpN+6Dr845F9wppIWKWjbJgHLp0db
        mDjZDQU+kUiZuDRU5eGaOdGVPySR4NwT+hQUb/kA+35umL4P0qZSj4/WveLlxxFBDR38i8TrplB+c
        rPFV42qfIccDHCCC9hRH12MrepHbO2yiK77+HhXzS+Ofmyjykae1aLGl/1zZ5q9njbeJDlzWVqEaI
        yQdd6ZqA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lUwMb-000ntI-Rh; Fri, 09 Apr 2021 19:00:35 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v7 13/28] mm/filemap: Add folio_offset and folio_file_offset
Date:   Fri,  9 Apr 2021 19:50:50 +0100
Message-Id: <20210409185105.188284-14-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210409185105.188284-1-willy@infradead.org>
References: <20210409185105.188284-1-willy@infradead.org>
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
index 5130503519b0..c15e72ee9ea8 100644
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

