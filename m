Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192E3724FF8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 00:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240079AbjFFWf2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 18:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239930AbjFFWe4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 18:34:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA1C1BEB
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jun 2023 15:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=EpkciJE0cf4CC6YyIRSuST7oQ3gwfKQp0080Wo4Pa/0=; b=fuqpC6yoih5kMnJnrShxLZitZY
        XY+LFvBUbwR1JegxMrfRSi/djam0X8bg8UHnuqddnJ+DdJK7Rkoxm7LscDPnSO0cuhg3dlfEbhVk1
        Hbj/Y9kc3XDbbkP7PrKuO9Vb7DwoiTvCjvjucic6IYmoiI0Y37dd2/b74R3cVM/Uj1OaRxMRJeJUK
        KKz/jQ7fe6/I6frhznGk2xwscjJee2PRndvWk39GM77sw/B1EczGpPMceomHchU4n2Z8jA4u9cW1c
        E0qc9ytuYpIW+wnqLqiq/2PsTBrAAZve9Qs+4jA70o0zzol2TOqU09jLMrfbh63cqvYRk2sytz2lO
        On5uBxdQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q6fFU-00DbEU-Ko; Tue, 06 Jun 2023 22:33:56 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        cluster-devel@redhat.com, Hannes Reinecke <hare@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>
Subject: [PATCH v2 01/14] gfs2: Use a folio inside gfs2_jdata_writepage()
Date:   Tue,  6 Jun 2023 23:33:33 +0100
Message-Id: <20230606223346.3241328-2-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230606223346.3241328-1-willy@infradead.org>
References: <20230606223346.3241328-1-willy@infradead.org>
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

Replace a few implicit calls to compound_head() with one explicit one.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Tested-by: Bob Peterson <rpeterso@redhat.com>
Reviewed-by: Bob Peterson <rpeterso@redhat.com>
---
 fs/gfs2/aops.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index a5f4be6b9213..0518861df783 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -150,20 +150,21 @@ static int __gfs2_jdata_writepage(struct page *page, struct writeback_control *w
 
 static int gfs2_jdata_writepage(struct page *page, struct writeback_control *wbc)
 {
+	struct folio *folio = page_folio(page);
 	struct inode *inode = page->mapping->host;
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
 
 	if (gfs2_assert_withdraw(sdp, gfs2_glock_is_held_excl(ip->i_gl)))
 		goto out;
-	if (PageChecked(page) || current->journal_info)
+	if (folio_test_checked(folio) || current->journal_info)
 		goto out_ignore;
-	return __gfs2_jdata_writepage(page, wbc);
+	return __gfs2_jdata_writepage(&folio->page, wbc);
 
 out_ignore:
-	redirty_page_for_writepage(wbc, page);
+	folio_redirty_for_writepage(wbc, folio);
 out:
-	unlock_page(page);
+	folio_unlock(folio);
 	return 0;
 }
 
-- 
2.39.2

