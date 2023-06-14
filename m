Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108FD73007F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 15:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245229AbjFNNtW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 09:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245212AbjFNNtB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 09:49:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C57211D;
        Wed, 14 Jun 2023 06:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=YUYLV41TVK+6fLHciRiUG8RZM08+qNBoSJWj5+js9ak=; b=QmaH8g8UU0Wgd/sUXye/0NXQXe
        /+SDZmQlbS0xKt7Ec2pr+XJrDWpB2pTlAtIxOFNM2tpAxsZBPACSWm8gUAMw6mnvcoXspLfw5K7MR
        bcYgqWnth2CoSA/qGpxFZQWphUuCPHWU1JqtjPAtHRyxtxz8XNnpMfyEJezGdYeo5uN8eDdWCQHjl
        hwGSvqMEop/V9HlTO6U99JR4HHlnhSJK0Hk2i0oNc+QErbJ1imJnv7ZILNvcxyTsatws1e7xsniOJ
        FPnnnxcx7Payy4B0WcnBhnUUYBksWzu1/OXZeJ+hdkoUZdEsFjGnj+3Kr89kKHF9ZyQ6g3rx1z+jx
        9dxdscqg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q9Qro-006Nna-4e; Wed, 14 Jun 2023 13:48:56 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 1/2] highmem: Add memcpy_to_folio()
Date:   Wed, 14 Jun 2023 14:48:52 +0100
Message-Id: <20230614134853.1521439-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230614114637.89759-1-hare@suse.de>
References: <20230614114637.89759-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is the folio equivalent of memcpy_to_page(), but it handles large
highmem folios.  It may be a little too big to inline on systems that
have CONFIG_HIGHMEM enabled but on systems we actually care about almost
all the code will be eliminated.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/highmem.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 4de1dbcd3ef6..ec39f544113d 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -507,6 +507,35 @@ static inline void folio_zero_range(struct folio *folio,
 	zero_user_segments(&folio->page, start, start + length, 0, 0);
 }
 
+/**
+ * memcpy_to_folio - Copy a range of bytes to a folio
+ * @folio: The folio to write to.
+ * @offset: The first byte in the folio to store to.
+ * @from: The memory to copy from.
+ * @len: The number of bytes to copy.
+ */
+static inline void memcpy_to_folio(struct folio *folio, size_t offset,
+		const char *from, size_t len)
+{
+	size_t n = len;
+
+	VM_BUG_ON(offset + len > folio_size(folio));
+
+	if (folio_test_highmem(folio))
+		n = min(len, PAGE_SIZE - offset_in_page(offset));
+	for (;;) {
+		char *to = kmap_local_folio(folio, offset);
+		memcpy(to, from, n);
+		kunmap_local(to);
+		if (!folio_test_highmem(folio) || n == len)
+			break;
+		offset += n;
+		len -= n;
+		n = min(len, PAGE_SIZE);
+	}
+	flush_dcache_folio(folio);
+}
+
 static inline void put_and_unmap_page(struct page *page, void *addr)
 {
 	kunmap_local(addr);
-- 
2.39.2

