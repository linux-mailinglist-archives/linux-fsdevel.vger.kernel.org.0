Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0663673E6A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 19:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjFZRg2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 13:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjFZRgC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 13:36:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B418295C;
        Mon, 26 Jun 2023 10:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ImqynQi+azeOKkPbJPWnsB36hvgJ5MojMLeTL2XpTIs=; b=EnXvWYXx+3E+jBbF7Z3B+1Gi/T
        yYgl8ytz+fZoD1bsHwC8cXajllUXh279ulAn62xGFuLds1WNXkGTXCQQEyIO2oWdLPtMZma2d/AMg
        5Su9uB7fPivq5SeGFfjxhRCguvBEtuQ+YT74zwhANJ5gvelakTfU9l8U8T0yUP1L00nf5upXTXCP+
        Tl1v60WsSro8t+8iDng1kThDvglAI8CetB6z50p5gO6KiKgThZkNJZBBkCDUuV1iH9gr8bU4TyNAL
        wyAv9pc62eib4kBG2gca6eQc6JVqDCIx0YaYqXUQ3JQrqmBSOGcIkls/+Yr7M2SL3Upaqt+O1iEA3
        6Vw5OxJw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qDq7Y-001vVM-AH; Mon, 26 Jun 2023 17:35:24 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.com>, David Howells <dhowells@redhat.com>
Subject: [PATCH 12/12] writeback: Remove a use of write_cache_pages() from do_writepages()
Date:   Mon, 26 Jun 2023 18:35:21 +0100
Message-Id: <20230626173521.459345-13-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230626173521.459345-1-willy@infradead.org>
References: <20230626173521.459345-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the new for_each_writeback_folio() directly instead of indirecting
through a callback.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/page-writeback.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 245d6318dfb2..55832679af21 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2557,13 +2557,21 @@ int write_cache_pages(struct address_space *mapping,
 }
 EXPORT_SYMBOL(write_cache_pages);
 
-static int writepage_cb(struct folio *folio, struct writeback_control *wbc,
-		void *data)
+static int writeback_use_writepage(struct address_space *mapping,
+		struct writeback_control *wbc)
 {
-	struct address_space *mapping = data;
-	int ret = mapping->a_ops->writepage(&folio->page, wbc);
-	mapping_set_error(mapping, ret);
-	return ret;
+	struct blk_plug plug;
+	struct folio *folio;
+	int err;
+
+	blk_start_plug(&plug);
+	for_each_writeback_folio(mapping, wbc, folio, err) {
+		err = mapping->a_ops->writepage(&folio->page, wbc);
+		mapping_set_error(mapping, err);
+	}
+	blk_finish_plug(&plug);
+
+	return err;
 }
 
 int do_writepages(struct address_space *mapping, struct writeback_control *wbc)
@@ -2579,12 +2587,7 @@ int do_writepages(struct address_space *mapping, struct writeback_control *wbc)
 		if (mapping->a_ops->writepages) {
 			ret = mapping->a_ops->writepages(mapping, wbc);
 		} else if (mapping->a_ops->writepage) {
-			struct blk_plug plug;
-
-			blk_start_plug(&plug);
-			ret = write_cache_pages(mapping, wbc, writepage_cb,
-						mapping);
-			blk_finish_plug(&plug);
+			ret = writeback_use_writepage(mapping, wbc);
 		} else {
 			/* deal with chardevs and other special files */
 			ret = 0;
-- 
2.39.2

