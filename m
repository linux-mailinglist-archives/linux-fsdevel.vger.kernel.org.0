Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC3E83B035D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 13:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhFVL42 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 07:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbhFVL40 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 07:56:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5519C061574;
        Tue, 22 Jun 2021 04:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=9QS292CN+YJiDduNJWQG6h6/ur/xsWB8HazYEZxqLp0=; b=OUbXjYUbjLOAe9sWZZw+eCSrJF
        ax+2X7fMGMG/m66p/8kbIOk0up5StpC/WC1oyQa7kf5Ocab3S1J6ae1Wq0kYoATqJ/0PyihhgQh4O
        25pzyJwVnENN4YBZGWGTGQGOAKricRshd3vaF2ieVACQilm2H1bXUbEeahRmorUgvhD/QmOch9Yo8
        qw1p6ACsmKbynwgVislgM964nJ29D4aAMMhL/lyzWRKlDFn+4tXsrgnm14gAJkOLziDyS7/IeivHI
        EfyzbKAKwoko3pdlBt4Nx0nwNFiUG6+r1vttJK9IWdZIWmGG7yeLdQut9Lzln3HFX5AeiRfTyikK2
        OaLo8OmQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvexX-00EEI9-0r; Tue, 22 Jun 2021 11:53:09 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        David Howells <dhowells@redhat.com>
Subject: [PATCH v12 14/33] mm/filemap: Add folio_next_index()
Date:   Tue, 22 Jun 2021 12:40:59 +0100
Message-Id: <20210622114118.3388190-15-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210622114118.3388190-1-willy@infradead.org>
References: <20210622114118.3388190-1-willy@infradead.org>
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
index 3af2bcd13a9b..4b3ce5f76a7b 100644
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

