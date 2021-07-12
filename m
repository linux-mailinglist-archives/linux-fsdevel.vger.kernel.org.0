Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07A0C3C4185
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 05:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbhGLDTB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jul 2021 23:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbhGLDTB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jul 2021 23:19:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F2BC0613DD;
        Sun, 11 Jul 2021 20:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=0KdZB3gPghk1DGDKMUM+cSe9HgLJApMZfQlb0sKNdL8=; b=CtHxUF4D8sz6EWKVABLFIEKpTl
        LbJTj9v1Zfa32pjlUFjR0SeVjQ5V5s8Mf5s2Xkdnh0rjMum57G/rrX66zq1Zg5oLNitku9SBCiCCC
        /WWstKmOsXs70o7OWOoguZFNf9wjUOdwXAm+3TDnvRxyz1eq6W+j029/hFGw5dsXcAZyMvkmq7RB1
        OgMh67F+g16PUd60ZvjMsN2peEIeOYKLdeHH18se1N3MwduL/tohtdyTLGkaPcvNYUdEPGs7xQ4/F
        Lfg4rPboLprPM1wsBKx3llnoX88KzUw1Xk+2xO2EZe9XH93i/NMITCYCYj953gGv1gaX/GxUHt0O+
        BtGFJXbw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2mQ2-00GnIY-6Y; Mon, 12 Jul 2021 03:15:48 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        David Howells <dhowells@redhat.com>
Subject: [PATCH v13 014/137] mm/filemap: Add folio_next_index()
Date:   Mon, 12 Jul 2021 04:04:58 +0100
Message-Id: <20210712030701.4000097-15-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712030701.4000097-1-willy@infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This helper returns the page index of the next folio in the file (ie
the end of this folio, plus one).

No changes to generated code.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jeff Layton <jlayton@kernel.org>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
Reviewed-by: David Howells <dhowells@redhat.com>
---
 include/linux/pagemap.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 8cc67ddb47d4..aac447fbaddd 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -406,6 +406,17 @@ static inline pgoff_t folio_index(struct folio *folio)
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

