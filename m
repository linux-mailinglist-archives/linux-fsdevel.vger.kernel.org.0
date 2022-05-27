Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58AF65364EA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 May 2022 17:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353087AbiE0Puq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 May 2022 11:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346627AbiE0Puo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 May 2022 11:50:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C1A134E1C
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 08:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=gjB7ffm4OT663eqxVe5L5iGJXsteQdmweyBBvgi2xdk=; b=kW4L8s63H6FeU0oDydp2sGJXlW
        OguZ3jTDRVe0fIiI+IjLSFregSWXlFrZqq3DM0lj3yV+oiMIuht5osEzWyB/eg0DGN6NHnSZiOgLg
        qtUpcJXwbShAqNOpibv8pPlnDt3ObhUKWVEFtVOT+P4PolnjeNCIB1OohxA1LuSznDSTojF5SE7BO
        PV9qG95xIivcso6ERu8n3RmLAIiHLdsoScf+44i6Doe200HF4Kq6e4UCGN2B238AkpGXdPM07R/mB
        mACIEOoWe7v/9OmfWs9u+EXwMrxwbFdNNzPm8oXPcRPQy2jQ8FcaL2zNCkHDb1SWVhUCQdMx+XkFV
        CgcK07jw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nucEb-002CX3-BZ; Fri, 27 May 2022 15:50:41 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Subject: [PATCH 14/24] remap_range: Remove check of uptodate flag
Date:   Fri, 27 May 2022 16:50:26 +0100
Message-Id: <20220527155036.524743-15-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220527155036.524743-1-willy@infradead.org>
References: <20220527155036.524743-1-willy@infradead.org>
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

read_mapping_folio() returns an ERR_PTR if the folio is not
uptodate, so this check is simply dead code.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/remap_range.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/fs/remap_range.c b/fs/remap_range.c
index e112b5424cdb..f1a3795812ce 100644
--- a/fs/remap_range.c
+++ b/fs/remap_range.c
@@ -148,16 +148,7 @@ static int generic_remap_check_len(struct inode *inode_in,
 /* Read a page's worth of file data into the page cache. */
 static struct folio *vfs_dedupe_get_folio(struct file *file, loff_t pos)
 {
-	struct folio *folio;
-
-	folio = read_mapping_folio(file->f_mapping, pos >> PAGE_SHIFT, file);
-	if (IS_ERR(folio))
-		return folio;
-	if (!folio_test_uptodate(folio)) {
-		folio_put(folio);
-		return ERR_PTR(-EIO);
-	}
-	return folio;
+	return read_mapping_folio(file->f_mapping, pos >> PAGE_SHIFT, file);
 }
 
 /*
-- 
2.34.1

