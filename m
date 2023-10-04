Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64EC7B85CD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 18:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243529AbjJDQxg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 12:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243513AbjJDQxc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:53:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCC6F2;
        Wed,  4 Oct 2023 09:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=U/Vyp0aKIbZ3gNGHQHjQi68gNh+m4QRK2qf3WFlHu+A=; b=hqTAtSridyfli6pM0HAtD5mGUD
        x3UeVRaQnugrAHI9tVmxaGGWCylda42PfRvDvDTCfZosLAJOrtxXWncHhy7ugK5RC+8zwpsSMQiHx
        zjILixsx8KeS/GggIiiCKJzhv2UGKpZCzBgV6BeAQu5ok/eK9hSUAyQrJ1O3ENZIUjeaQ7kp/7Nwe
        L0Ys+GJYDUnAgy3jIgg1/c1F8Haysgu81TvbZFxBtDXotFrU5uUqVVjYfr3jI4tBbrlSM/3o9pUXv
        9MHl2Ue6kGqBxr1af3neVOGUntd1/rGg9l1B+TgD81IChLPjBy4PBM5P7HDY2256LbtVQFNhiR8m3
        aDTshtSg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qo57f-004SF5-Iy; Wed, 04 Oct 2023 16:53:19 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, torvalds@linux-foundation.org,
        npiggin@gmail.com
Subject: [PATCH v2 06/17] iomap: Use folio_end_read()
Date:   Wed,  4 Oct 2023 17:53:06 +0100
Message-Id: <20231004165317.1061855-7-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231004165317.1061855-1-willy@infradead.org>
References: <20231004165317.1061855-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
index 4a996c5327ef..5d19a2b47b6a 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -270,10 +270,8 @@ static void iomap_finish_folio_read(struct folio *folio, size_t off,
 
 	if (error)
 		folio_set_error(folio);
-	if (uptodate)
-		folio_mark_uptodate(folio);
 	if (finished)
-		folio_unlock(folio);
+		folio_end_read(folio, uptodate);
 }
 
 static void iomap_read_end_io(struct bio *bio)
-- 
2.40.1

