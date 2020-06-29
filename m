Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2F520E339
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jun 2020 00:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387648AbgF2VMs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jun 2020 17:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730143AbgF2S5o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:57:44 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EA7C030790
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jun 2020 08:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=mgRyF4t388omSRz/7T6tzwex9Fbu7NAPN3gXzzR0XVQ=; b=oxJiuoz35GYzywp31X41L001WB
        XGBVvf59YdLLonY2HTqhqUXYet+Y+uVWlnfhwnStjzWSwwlIdV0avNvkOG0mhwPKmabt8j+BEPDUR
        HWsKCt60iTl+lWvm3MxA4o3JLi5n+fSFT+gkOKjWGpS75QpGFoS+Lu7bjsigc/xV5bqg/SGMiDvIi
        PZxbAulXlm3OlmH0XgII8VxBYlEV5rcxROaXaX8SST9U3W3EggFSgZh4jQyjZRRZS0MAOAx1x/yxD
        msPsl6JsEJU5rYsOb/uTYIHLERy82eYSucK8D/RDj4Q0QUahKQZqv3lwithuD4Fhi7A5SRWTDyV23
        RrcJJxYA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jpvZq-0004Cj-B4; Mon, 29 Jun 2020 15:20:10 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH 7/7] mm: Introduce offset_in_thp
Date:   Mon, 29 Jun 2020 16:19:59 +0100
Message-Id: <20200629151959.15779-8-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200629151959.15779-1-willy@infradead.org>
References: <20200629151959.15779-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Mirroring offset_in_page(), this gives you the offset within this
particular page, no matter what size page it is.  It optimises down
to offset_in_page() if CONFIG_TRANSPARENT_HUGEPAGE is not set.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6c29b663135f..3fc7e8121216 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1583,6 +1583,7 @@ static inline void clear_page_pfmemalloc(struct page *page)
 extern void pagefault_out_of_memory(void);
 
 #define offset_in_page(p)	((unsigned long)(p) & ~PAGE_MASK)
+#define offset_in_thp(page, p)	((unsigned long)(p) & (thp_size(page) - 1))
 
 /*
  * Flags passed to show_mem() and show_free_areas() to suppress output in
-- 
2.27.0

