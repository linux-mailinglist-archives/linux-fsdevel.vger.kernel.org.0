Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72BD41BDDC8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 15:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgD2NhD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 09:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbgD2Ng7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 09:36:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61896C035495;
        Wed, 29 Apr 2020 06:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Yi1wYt4iXlkSO38vWez4amiBBSDF7tSr77p/65sccCE=; b=SZc9+QONeaWnQfhpZwMykTT0We
        gzaZj2YKRGIYSlnXGd+e23wDBmGYEAYxqpT78aApEI3LyzjZ84XCMRxSv9kuXJJw+vQXa7SoYppXd
        pVyDoz+hUZSCDSnLqRfwfXp50wQbt/rptwJ2sPcX/LfDx7V7W8KzK8U6+cWmhf88XkQ4Cb0V8qFU6
        Z73OXdNi4/Nq/EEbjbN32WJoLPWDdEMSuOPVUTWcvzAwAyPmIhGWlLo4DxqS51pfJGDFbfTACszb5
        V9G87+OG9myxtn+UxccqD7HPrVKC3R9d8M05VwVZp2OAAgtNI2r1AfBV8ALYFkfrCvS52L8ZY7eoN
        aJw7KWvg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTmtX-0005uZ-75; Wed, 29 Apr 2020 13:36:59 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/25] mm: Introduce offset_in_thp
Date:   Wed, 29 Apr 2020 06:36:36 -0700
Message-Id: <20200429133657.22632-5-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200429133657.22632-1-willy@infradead.org>
References: <20200429133657.22632-1-willy@infradead.org>
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

