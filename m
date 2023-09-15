Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 850697A2600
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 20:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236592AbjIOSh5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 14:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236464AbjIOShW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 14:37:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8288010D9;
        Fri, 15 Sep 2023 11:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=aanqWz7LXsKQhB1oKoWrq/hhDEToXtz4R83zwTN5ek4=; b=eFAUDvC1j+eUES+EbIT45gn1R1
        ++XVlsh8I4oCrZdiCg6UnYc8aXWJEyHdUZQIC4cvEomnlBym8xe2PELLXDw/GqKgpT01e0JbE/VrW
        XHeSvudWZJ81qKFqooD32XIzGJsN00TKCoOlRmGvKrDKb31R3frDJY0JM5CS0AVOPhI/BwNftt6yQ
        xafCSe2PErcOIYuJ1W09lM5nqBETq5QoJRNHE9qNtIKOBvHrg/NwGWvndtPBaqHXMOiMCCAJqCC5P
        j3JNlJZnH0fLf7twNFL5cWWTzaY5KIF1HaGYRjeDBwPu8c3Q5cviTs9Sxn+VH6fP/S3xKFSNZD52s
        8Is8ufIQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qhDgj-00BMIf-HO; Fri, 15 Sep 2023 18:37:09 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        torvalds@linux-foundation.org, Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 06/17] iomap: Use folio_end_read()
Date:   Fri, 15 Sep 2023 19:36:56 +0100
Message-Id: <20230915183707.2707298-7-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230915183707.2707298-1-willy@infradead.org>
References: <20230915183707.2707298-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Combine the setting of the uptodate flag with the clearing of the
locked flag.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index cade15b70627..e59831bd9217 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -274,10 +274,8 @@ static void iomap_finish_folio_read(struct folio *folio, size_t off,
 		spin_unlock_irqrestore(&ifs->state_lock, flags);
 	}
 
-	if (uptodate)
-		folio_mark_uptodate(folio);
 	if (finished)
-		folio_unlock(folio);
+		folio_end_read(folio, uptodate);
 }
 
 static void iomap_read_end_io(struct bio *bio)
-- 
2.40.1

