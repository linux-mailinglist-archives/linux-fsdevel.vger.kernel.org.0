Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACED373E98
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 17:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233426AbhEEPem (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 11:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbhEEPem (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 11:34:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD34AC061574;
        Wed,  5 May 2021 08:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=n0jrc9yXOZFqM1+RQ8nbm9n1a9h7Lyetp7NHKvmt03o=; b=ha6OMxiAhE8aQO7i/+sJO2zye8
        VVaX+lYovmy1pilg+Aoxv5H2e8G+VQoqafin2Kok6q2oF9tFbMU8Nm1zoetmlE1d5Fe1eTsjx/NTv
        y0jtuzNQfHA1ga3u56AC7TDhSndup/ZliI1vlZNmEpQtXVhjuvwyNojx52WsYLWQHTgfpWI5Uyg8b
        5AxfNgQIo8hDG2cJ9bmRQUjzQIY+Ml8cfuWKlzXw3YcgBDZ9MDU62sQ1+3R1vMNEF9X5Imo7E8y8G
        Hez+qCf4JOts10k6kozsfrqs2m7gzJ3LMMYeD63CTZzMERLh94ykt04fZxNkCMUmtNn3/9N4lKk6N
        9Ea6T/Iw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leJUq-000VLJ-Ga; Wed, 05 May 2021 15:31:53 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v9 23/96] mm: Add folio_mapcount
Date:   Wed,  5 May 2021 16:05:15 +0100
Message-Id: <20210505150628.111735-24-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210505150628.111735-1-willy@infradead.org>
References: <20210505150628.111735-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is the folio equivalent of page_mapcount().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/mm.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index fb779dca5ee8..bca3e2518e5e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -883,6 +883,22 @@ static inline int page_mapcount(struct page *page)
 	return atomic_read(&page->_mapcount) + 1;
 }
 
+/**
+ * folio_mapcount - The number of mappings of this folio.
+ * @folio: The folio.
+ *
+ * The result includes the number of times any of the pages in the
+ * folio are mapped to userspace.
+ *
+ * Return: The number of page table entries which refer to this folio.
+ */
+static inline int folio_mapcount(struct folio *folio)
+{
+	if (unlikely(folio_multi(folio)))
+		return __page_mapcount(&folio->page);
+	return atomic_read(&folio->_mapcount) + 1;
+}
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 int total_mapcount(struct page *page);
 int page_trans_huge_mapcount(struct page *page, int *total_mapcount);
-- 
2.30.2

