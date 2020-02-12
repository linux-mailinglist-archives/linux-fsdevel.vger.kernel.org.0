Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C198215A015
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 05:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbgBLEUS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 23:20:18 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53876 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727960AbgBLESq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 23:18:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=G02P3NwoSCoisXgQ/IS2rHa3w6ThGczr5ALv3SgsGPE=; b=si99YFEQ0elcNaPbG1Sa7xumtX
        V7eGl8RRqn/ROGpPEuHPSmuTWjQIm5vo7lQlpOZyNr13m5VvzeRnukA8bO75KMxjKUMkqCvVFh9RC
        bAGhuFS7oXGvdVwJlWCSFVy2qtN1ME4nHd27PKLOLRcFpRUQbNZhMNAwiN2REv3fDHGKextlNerDD
        AakK2U6Jo2OqyZdebCrhKzIsfldMP9qoKNsSszalDBnlEhAMnq5Knq12SDN/Xf2sQKEbysUiSHdRV
        Xn/xPbEVn5qH1t/ema2JlwYjN6p69/bDPnkIZG02tw99eCasVDKlwm2YRsUoTroeE1jDg5M3G8Pfg
        rq46tHlQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1jU6-0006mQ-Hd; Wed, 12 Feb 2020 04:18:46 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/25] mm: Optimise find_subpage for !THP
Date:   Tue, 11 Feb 2020 20:18:22 -0800
Message-Id: <20200212041845.25879-3-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200212041845.25879-1-willy@infradead.org>
References: <20200212041845.25879-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

If THP is disabled, find_subpage can become a no-op.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 75bdfec49710..0842622cca90 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -340,7 +340,7 @@ static inline struct page *find_subpage(struct page *page, pgoff_t offset)
 
 	VM_BUG_ON_PAGE(PageTail(page), page);
 
-	return page + (offset & (compound_nr(page) - 1));
+	return page + (offset & (hpage_nr_pages(page) - 1));
 }
 
 struct page *find_get_entry(struct address_space *mapping, pgoff_t offset);
-- 
2.25.0

