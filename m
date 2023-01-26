Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 914B367D604
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 21:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbjAZUQF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 15:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjAZUQC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 15:16:02 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B8476A8
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jan 2023 12:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=ewxYBF8rCgV9/rysFXLSjcXueedMcKRMGf5oGjYm2XM=; b=UsTx/4ALB9cFNh15XNo+OrOl5t
        q/Pq1uGc0bwb+6ugOPQ2mrvEyhqLwLSYVzsCNBRmJjqsJISUPk0LkG+zx3eFwL5b6rMY7kXfaswJZ
        u/I8zM5lv7rpNF/W2CV+cAYSA6C/TpDLDQEiIcOiv/FflEr2Ag6hYc48ya9ZTPDsNolPbj4BQrT3X
        EUDc7GYJ/ye0gGIPJvDhj7jS4f2Y+uI7lMNd7vYW4DtlEXc9lzgQDdoUY5REIkAldrhrbv77ke9F9
        iQrOFsbpsKjowzR7q9GjUD93Za704felpCbz+FLm+ugzu9qDKFEXIqzI1VYOrCbJgNt3cyKufoC1T
        okqCB+hA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pL8f5-0073Sj-3U; Thu, 26 Jan 2023 20:15:55 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] mm: Add memcpy_from_file_folio()
Date:   Thu, 26 Jan 2023 20:15:52 +0000
Message-Id: <20230126201552.1681588-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is the equivalent of memcpy_from_page().  It differs in that it
takes the position in a file instead of offset in a folio, it accepts
the total number of bytes to be copied (instead of the number of bytes
to be copied from this folio) and it returns how many bytes were copied
from the folio, rather than making the caller calculate that and then
checking if the caller got it right.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/highmem.h    | 29 +++++++++++++++++++++++++++++
 include/linux/page-flags.h |  1 +
 2 files changed, 30 insertions(+)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index e22509420ac6..b517707b028d 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -413,6 +413,35 @@ static inline void memzero_page(struct page *page, size_t offset, size_t len)
 	kunmap_local(addr);
 }
 
+/**
+ * memcpy_from_file_folio - Copy some bytes from a file folio.
+ * @to: The destination buffer.
+ * @folio: The folio to copy from.
+ * @pos: The position in the file.
+ * @len: The maximum number of bytes to copy.
+ *
+ * Copy up to @len bytes from this folio.  This may be limited by PAGE_SIZE
+ * if the folio comes from HIGHMEM, and by the size of the folio.
+ *
+ * Return: The number of bytes copied from the folio.
+ */
+static inline size_t memcpy_from_file_folio(char *to, struct folio *folio,
+		loff_t pos, size_t len)
+{
+	size_t offset = offset_in_folio(folio, pos);
+	char *from = kmap_local_folio(folio, offset);
+
+	if (folio_test_highmem(folio))
+		len = min(len, PAGE_SIZE - offset);
+	else
+		len = min(len, folio_size(folio) - offset);
+
+	memcpy(to, from, len);
+	kunmap_local(from);
+
+	return len;
+}
+
 /**
  * folio_zero_segments() - Zero two byte ranges in a folio.
  * @folio: The folio to write to.
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 09804ad91927..0425f22a9c82 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -531,6 +531,7 @@ PAGEFLAG(Readahead, readahead, PF_NO_COMPOUND)
  * available at this point.
  */
 #define PageHighMem(__p) is_highmem_idx(page_zonenum(__p))
+#define folio_test_highmem(__f)	is_highmem_idx(folio_zonenum(__f))
 #else
 PAGEFLAG_FALSE(HighMem, highmem)
 #endif
-- 
2.35.1

