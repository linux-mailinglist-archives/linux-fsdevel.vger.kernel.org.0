Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F28D516A7D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 May 2022 07:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383400AbiEBF76 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 May 2022 01:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357925AbiEBF7s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 May 2022 01:59:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCEC1FA7C
        for <linux-fsdevel@vger.kernel.org>; Sun,  1 May 2022 22:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=qNzd44PPEiAzLf5bTtgx2nhl9p2qxofuDkZGmg88mxg=; b=VyRSqBd07F3cBukSxMiAOVVKoF
        8lxCy6aNqvwqIGyU2YcJ5c2ZLeqJ4xZBgQB0U1bq12SUQH11vM0k/Gb5YuBvW2erACpbsktwkHyV3
        iKJaQvRLXS8SlNcIU3pUPFenX7djfu1VcNtIyfNvdCsOl12sG01lkiDbGchVkAJJxZNILnCSNnS6k
        xZ+X8tPGCj07mtCQHZJkLIxsf+xobBYR/yZsFWlh87plvtdeEc7neD9x29+Jl/I28EfNOCOAIxLWf
        5rfHWh1XUnTQICmoTVgXhkuqmdQx9Khgyq80TP7Me5EtLxM1WbCDGZyTEciIA6nueihBJEZ1NfSwu
        o58ZEngA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nlP2f-00EZVq-JH; Mon, 02 May 2022 05:56:17 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 06/26] ceph: Convert to release_folio
Date:   Mon,  2 May 2022 06:55:54 +0100
Message-Id: <20220502055614.3473032-7-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220502055614.3473032-1-willy@infradead.org>
References: <20220502055614.3473032-1-willy@infradead.org>
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

Use a folio throughout ceph_release_folio().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ceph/addr.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index e040b92bb17c..737d13931d52 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -162,24 +162,24 @@ static void ceph_invalidate_folio(struct folio *folio, size_t offset,
 	folio_wait_fscache(folio);
 }
 
-static int ceph_releasepage(struct page *page, gfp_t gfp)
+static bool ceph_release_folio(struct folio *folio, gfp_t gfp)
 {
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = folio->mapping->host;
 
-	dout("%llx:%llx releasepage %p idx %lu (%sdirty)\n",
-	     ceph_vinop(inode), page,
-	     page->index, PageDirty(page) ? "" : "not ");
+	dout("%llx:%llx release_folio idx %lu (%sdirty)\n",
+	     ceph_vinop(inode),
+	     folio->index, folio_test_dirty(folio) ? "" : "not ");
 
-	if (PagePrivate(page))
-		return 0;
+	if (folio_test_private(folio))
+		return false;
 
-	if (PageFsCache(page)) {
+	if (folio_test_fscache(folio)) {
 		if (current_is_kswapd() || !(gfp & __GFP_FS))
-			return 0;
-		wait_on_page_fscache(page);
+			return false;
+		folio_wait_fscache(folio);
 	}
 	ceph_fscache_note_page_release(inode);
-	return 1;
+	return true;
 }
 
 static void ceph_netfs_expand_readahead(struct netfs_io_request *rreq)
@@ -1380,7 +1380,7 @@ const struct address_space_operations ceph_aops = {
 	.write_end = ceph_write_end,
 	.dirty_folio = ceph_dirty_folio,
 	.invalidate_folio = ceph_invalidate_folio,
-	.releasepage = ceph_releasepage,
+	.release_folio = ceph_release_folio,
 	.direct_IO = noop_direct_IO,
 };
 
-- 
2.34.1

