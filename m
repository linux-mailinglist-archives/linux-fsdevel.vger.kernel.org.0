Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 513673C96E4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 06:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbhGOEIL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 00:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbhGOEIL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 00:08:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F6EC06175F;
        Wed, 14 Jul 2021 21:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=SUn1Nx+JnnxbWTWC1UlGFubzbFx2wwJSqJVAFW18gAg=; b=dqGGGpaF6YqsuVb72MEP40KLqW
        PTV6rQEbhgbSkcKFzwPuglo0qlOyunrczrSisHOAQEOPipb5XtsEV+TLjs7QV3+6ff447m89+m6xN
        /eQjUmlUWGxauUsETHDk89eg1QBX1ktubzFcoJkZb9G2xajMNsj1q9KDKFMHZnhyQhYpVkseYhf/P
        MyAauXzj3yANJWpFBfRe5ElPJN402no+I6MbYVtnIv6ss1vmn3URMZBWFF2AZ5zCZHoujw+HHSOH7
        vp6yL8QnOvmmyScmxzFQz4JbPkG0Lcu4NHT8DgwHTrgMjG0XiL0EUaFhwEnLirmEqElHP2WzrMcNB
        ygGtq2PQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3sb6-002vs0-Pl; Thu, 15 Jul 2021 04:03:53 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v14 033/138] mm: Add folio_nid()
Date:   Thu, 15 Jul 2021 04:35:19 +0100
Message-Id: <20210715033704.692967-34-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
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
index 8b79d9dfa6cb..c6e2a1682a6d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1428,6 +1428,11 @@ static inline int page_to_nid(const struct page *page)
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

