Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B07FF36FF90
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Apr 2021 19:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbhD3Rdk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Apr 2021 13:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbhD3Rdh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Apr 2021 13:33:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC7DC06174A
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Apr 2021 10:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=azsNkQzXElyIzJuUMmTts2EKSUJP8PUH3fVrpjR5ykw=; b=WRoVIwtu+5i6yxwswpY31J5qzz
        cHn2XhAwtL2NKBT3GuPHBP4/xzdMNbeB7muxns3j9PI9k8mB0WjjQTKLOaoZ2uWRYMSIclRKj+uNV
        2YTH1HQfY76VLz7vKCyqEihlhyXsQxoAefIzyX1TVMfGh9HLAUgWpnVQj/CisVC7UrzgFqrvWHChA
        oztbM18GmM3zXfZc3fnxvR2KMvFISqFdeCgz2lt4gXs/QyiN7Ma6M2WK8zIxRtzk4O86ZJYo0ZQQJ
        dwUAt/KlwjT3in5QeTg11I1MNxmnOXfSP0zFSNXcewl3snZvh9aIQ1ddi921WrjWzVmIeZXdi562M
        hFU/qy/w==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lcWzL-00BJm7-Dg; Fri, 30 Apr 2021 17:31:49 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v8 12/27] mm/filemap: Add folio_next_index
Date:   Fri, 30 Apr 2021 18:22:20 +0100
Message-Id: <20210430172235.2695303-13-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210430172235.2695303-1-willy@infradead.org>
References: <20210430172235.2695303-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This helper returns the page index of the next folio in the file (ie
the end of this folio, plus one).

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/pagemap.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 58c9b98604d0..5301131cc5b3 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -482,6 +482,17 @@ static inline pgoff_t folio_index(struct folio *folio)
         return folio->index;
 }
 
+/**
+ * folio_next_index - Get the index of the next folio.
+ * @folio: The current folio.
+ *
+ * Return: The index of the folio which follows this folio in the file.
+ */
+static inline pgoff_t folio_next_index(struct folio *folio)
+{
+	return folio->index + folio_nr_pages(folio);
+}
+
 /**
  * folio_file_page - The page for a particular index.
  * @folio: The folio which contains this index.
-- 
2.30.2

