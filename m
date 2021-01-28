Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 960DB306E19
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 08:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbhA1HF6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 02:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbhA1HFb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:05:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086BEC0613ED;
        Wed, 27 Jan 2021 23:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=4D9LWaYYEO6XvVKPXeU5gxfohP3/nOnS5kH5caHsSPA=; b=bi5N6cNcjOcScdIcerQfP0chRv
        RWpB9Q006pY4IrCNOS5VzrZXi0tQaNy/U+4SFe/2XNWdMU/NePRJKTQ1nWzTbUSWl0zjEQPX9GnZk
        twWLLqITzVSFI3YR9Bk0iMi2vHp5dLjnyxp+BpuZBQDlO1mn01UUfixDv2vVcJWnr2GDvBrbYR/cf
        CquH0WVFueQfhLmWp55j7JYuodsfhFGvf5O/WUC/K0NdSm5rh9F8U6x+BjJB28A+5cPUdzXJvOMzT
        kWtnZUS0PQffxcv0NEAduMzupHKG345bymnnN6PZj+672yPre7mo1WWu+HY7YWFGEICDiOfzowZPE
        QhjOEBrw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l51Lh-00846U-1g; Thu, 28 Jan 2021 07:04:13 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 05/25] mm: Add put_folio
Date:   Thu, 28 Jan 2021 07:03:44 +0000
Message-Id: <20210128070404.1922318-6-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210128070404.1922318-1-willy@infradead.org>
References: <20210128070404.1922318-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If we know we have a folio, we can call put_folio() instead of put_page()
and save the overhead of calling compound_head().  Also skips the
devmap checks.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7d787229dd40..873d649107ba 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1220,9 +1220,15 @@ static inline __must_check bool try_get_page(struct page *page)
 	return true;
 }
 
+static inline void put_folio(struct folio *folio)
+{
+	if (put_page_testzero(&folio->page))
+		__put_page(&folio->page);
+}
+
 static inline void put_page(struct page *page)
 {
-	page = compound_head(page);
+	struct folio *folio = page_folio(page);
 
 	/*
 	 * For devmap managed pages we need to catch refcount transition from
@@ -1230,13 +1236,12 @@ static inline void put_page(struct page *page)
 	 * need to inform the device driver through callback. See
 	 * include/linux/memremap.h and HMM for details.
 	 */
-	if (page_is_devmap_managed(page)) {
-		put_devmap_managed_page(page);
+	if (page_is_devmap_managed(&folio->page)) {
+		put_devmap_managed_page(&folio->page);
 		return;
 	}
 
-	if (put_page_testzero(page))
-		__put_page(page);
+	put_folio(folio);
 }
 
 /*
-- 
2.29.2

