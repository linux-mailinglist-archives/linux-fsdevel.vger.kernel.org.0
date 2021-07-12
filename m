Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 525F63C41C2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 05:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbhGLD23 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jul 2021 23:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbhGLD22 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jul 2021 23:28:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E27C0613DD;
        Sun, 11 Jul 2021 20:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Ls0PDTK4GmPt7o8GB9HWSuuERwLuQPqR3wzi6YV9cbE=; b=qmEy+35H1yw1Awi/FIgiuf9eQe
        8uHqs7d+y4evBeK8XRHAS8b2I/a6PRmJDSAuvhJudwdgaRFAjsJLgBDYRtWnprV2F0Wl3z9FVVMv+
        dKQ3zSnWQfYL7IZo2A1Xeo6H5q3o1RKlDkcVybcZsbTf6i6HgwYG/l+c4iQegvr0cDakY8ZTS3B1v
        0ckYasGAhJntTm9JrfUbAxyfFeuy+UMXtcWc0AscqeiNa0ofQqecheteiYfpuMoTyFUoV0e+cX52i
        BkLIn9xNw6w2v5aLxVSYqtOm+npML4TtEBscYcF4i98a8P6nb6UksyIhfTnc5tHGuY/y8eqXVDt8o
        QwXaF+kg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2mYu-00Go0p-Kj; Mon, 12 Jul 2021 03:24:56 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v13 033/137] mm: Add folio_nid()
Date:   Mon, 12 Jul 2021 04:05:17 +0100
Message-Id: <20210712030701.4000097-34-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712030701.4000097-1-willy@infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is the folio equivalent of page_to_nid().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/mm.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a856c078e040..80f27eb151ba 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1427,6 +1427,11 @@ static inline int page_to_nid(const struct page *page)
 }
 #endif
 
+static inline int folio_nid(const struct folio *folio)
+{
+	return page_to_nid(&folio->page);
+}
+
 #ifdef CONFIG_NUMA_BALANCING
 static inline int cpu_pid_to_cpupid(int cpu, int pid)
 {
-- 
2.30.2

