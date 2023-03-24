Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD646C846B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 19:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbjCXSEB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 14:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbjCXSC1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 14:02:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6624F1CF7E;
        Fri, 24 Mar 2023 11:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=7JmN+9SsTrOVuR3U9s6cPTX78SVj5kDXNdVOIgSxghc=; b=CSUt6XsXbzHmp6n7xQY5Ige94+
        aAShX/2DOcob2VEvxd4EST95lqZkJCAGvs/k1LrtN8X3tKTeITaqiBZHtTWXQLl2n60leIsiD3ljh
        hpdw9vhi1GqFFcvD0qtfQvr11hmj6LSICYfhKhecAF/5e1o6BBU8rzkZv6uZHdYmb0TcTowW9mjkJ
        JriP4kCaoPKL4PiITBYc4HSjVCFlBwuxU6aj27dK1DgYHmxnjeH6G02EyJMM+qybqL6JrfT4Hpr+I
        oXRutivS9HP10H+OCTB1YWC6f7s9WK3wctymBsWde3Kom5XmsnH/MOrQ8gnzp/UquTIgv5/6Dw6Yo
        tab3P41Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pfljO-0057cD-Qm; Fri, 24 Mar 2023 18:01:38 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 29/29] ext4: Use a folio in ext4_read_merkle_tree_page
Date:   Fri, 24 Mar 2023 18:01:29 +0000
Message-Id: <20230324180129.1220691-30-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230324180129.1220691-1-willy@infradead.org>
References: <20230324180129.1220691-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an implementation of fsverity_operations read_merkle_tree_page,
so it must still return the precise page asked for, but we can use the
folio API to reduce the number of conversions between folios & pages.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/verity.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
index afe847c967a4..3b01247066dd 100644
--- a/fs/ext4/verity.c
+++ b/fs/ext4/verity.c
@@ -361,21 +361,21 @@ static struct page *ext4_read_merkle_tree_page(struct inode *inode,
 					       pgoff_t index,
 					       unsigned long num_ra_pages)
 {
-	struct page *page;
+	struct folio *folio;
 
 	index += ext4_verity_metadata_pos(inode) >> PAGE_SHIFT;
 
-	page = find_get_page_flags(inode->i_mapping, index, FGP_ACCESSED);
-	if (!page || !PageUptodate(page)) {
+	folio = __filemap_get_folio(inode->i_mapping, index, FGP_ACCESSED, 0);
+	if (!folio || !folio_test_uptodate(folio)) {
 		DEFINE_READAHEAD(ractl, NULL, NULL, inode->i_mapping, index);
 
-		if (page)
-			put_page(page);
+		if (folio)
+			folio_put(folio);
 		else if (num_ra_pages > 1)
 			page_cache_ra_unbounded(&ractl, num_ra_pages, 0);
-		page = read_mapping_page(inode->i_mapping, index, NULL);
+		folio = read_mapping_folio(inode->i_mapping, index, NULL);
 	}
-	return page;
+	return folio_file_page(folio, index);
 }
 
 static int ext4_write_merkle_tree_block(struct inode *inode, const void *buf,
-- 
2.39.2

