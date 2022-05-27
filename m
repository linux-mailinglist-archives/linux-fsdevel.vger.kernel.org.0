Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384B55364F0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 May 2022 17:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352173AbiE0PvA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 May 2022 11:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351976AbiE0Pup (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 May 2022 11:50:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7532A134E29
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 08:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=tCiC/LNfeYVDL+hpPkwMSf65SMCxXRoZcgr2jCxRYnI=; b=T5uqWMX/dp9SRQ8FhdUZqQnkhX
        6xnjbD0GqE9Qx4q8o6rCGdxsr9Im0SFwCMgqR39gkk8jgDFF7t/hEBrzaNI4i2cT8GONwXkEwS9MD
        yqDrVd4htYqstbiquy+//WpUQgObnWFDDOLAWtCqA1Rcw0WISWYhO/5Fdm14eMr9B+Hdv5hCSJDOY
        BBEXkWlvb4lepoh+Kqc500dozdqxWcnlkGdfdjQng4ndCP07gzIVvE9FBoxVjsBY4uApMw4e0ToUS
        2uLbNig6eQ/7JP1gMwsqO4PDaI/YwF5hFBH1rppCuqB9v15ej1aDmm4Js4lIHvWoWrdOr4FnSIoxq
        VSKqJ0Fw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nucEb-002CXR-QV; Fri, 27 May 2022 15:50:41 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Subject: [PATCH 18/24] buffer: Remove check for PageError
Date:   Fri, 27 May 2022 16:50:30 +0100
Message-Id: <20220527155036.524743-19-willy@infradead.org>
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

If a buffer is completed with an error, its uptodate flag will be clear,
so the page_uptodate variable will have been set to 0.  There's no
need to check PageError here.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 898c7f301b1b..c37a9c3bfb2f 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -282,10 +282,10 @@ static void end_buffer_async_read(struct buffer_head *bh, int uptodate)
 	spin_unlock_irqrestore(&first->b_uptodate_lock, flags);
 
 	/*
-	 * If none of the buffers had errors and they are all
-	 * uptodate then we can set the page uptodate.
+	 * If all of the buffers are uptodate then we can set the page
+	 * uptodate.
 	 */
-	if (page_uptodate && !PageError(page))
+	if (page_uptodate)
 		SetPageUptodate(page);
 	unlock_page(page);
 	return;
-- 
2.34.1

