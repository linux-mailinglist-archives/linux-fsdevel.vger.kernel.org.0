Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E28773A7054
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 22:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbhFNU1t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 16:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233295AbhFNU1s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 16:27:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5121C061574;
        Mon, 14 Jun 2021 13:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=XowoNG5/pQZiBInvEZUlicdv8UUQrjduvk0rLp5b9NE=; b=v07jMen6NzNaeIb6zZdtwqyeiB
        f7Ym2eY9cKCePa8+pVq3SOljxmmofeAYMDRB57qP0cm4vzoFbu/viAxnG5llE7ls1LzosDbw+8X54
        TjduM6cxAyCluYgqqzvTvELBXYodmZ/qBw3OoTT++5yAN7U7tO7sud+UUcEgS+w8SJ4gfIffzhXNY
        xp89qIuipl3ai7NQboWLvHh96gB15jm7ZvZt2D88d4SbwTJnHKCPeA1AM2uZDAOsBWd1OBlzEcuO1
        KXhpT0J8yK7y0jnscEA5TKQXarMKez6LMkqAw9dpZNZ1bGsMNfStq46x+DxcQoO8CvT2/w0nXKINK
        wewHA2Cw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lst7y-005nbV-9D; Mon, 14 Jun 2021 20:24:16 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH v11 14/33] mm/filemap: Add folio_next_index()
Date:   Mon, 14 Jun 2021 21:14:16 +0100
Message-Id: <20210614201435.1379188-15-willy@infradead.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210614201435.1379188-1-willy@infradead.org>
References: <20210614201435.1379188-1-willy@infradead.org>
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
---
 include/linux/pagemap.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 37a4b583abad..c5c7e061c77c 100644
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

