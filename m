Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C7C5364EC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 May 2022 17:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353133AbiE0Puu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 May 2022 11:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351474AbiE0Puo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 May 2022 11:50:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BD6134E1F
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 08:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=qRH6hDYB4+yS9n8y2k8u+XGjqusFj7Bxpzd2Aqkf8kE=; b=OcJ5vYOVl6ojRj59rrC2Ue9m6I
        9sLen2ehKuPsVe94n6+VTYycTZwxWbgiKQ/JzozbK3rMiUO/IkG0OPLn3aO3Ej5pzcHNkDvRXPVkY
        bRe94WphLj9tH54EdYD9cik0HwuVncYM6GXSpWciSBxxO9M1UJSOmK7ya6drkJ6cfyVelKMCVII01
        WaKNnvn301v9FOVgBErswLFHGfiC9VUBLbQVDoYQ6sgPcaaWYQk8vyICRTb/eeCa0AViNw/KINJgV
        YBIQxETfusC2xNlYvNfp9HnmRHQro7VE6b8iru92v5Eh23tTf8FSA9dm1lSDm2yQ4vSC0E66tOiab
        olcH/EJQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nucEb-002CXF-It; Fri, 27 May 2022 15:50:41 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Subject: [PATCH 16/24] iomap: Remove test for folio error
Date:   Fri, 27 May 2022 16:50:28 +0100
Message-Id: <20220527155036.524743-17-willy@infradead.org>
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

Just because there has been a read error doesn't mean we should avoid
marking this part of the folio as uptodate.  Indeed, it may overwrite
the error part of the folio and let us mark the entire folio uptodate.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index d2a9f699e17e..66278a14bfa7 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -154,9 +154,6 @@ static void iomap_iop_set_range_uptodate(struct folio *folio,
 static void iomap_set_range_uptodate(struct folio *folio,
 		struct iomap_page *iop, size_t off, size_t len)
 {
-	if (folio_test_error(folio))
-		return;
-
 	if (iop)
 		iomap_iop_set_range_uptodate(folio, iop, off, len);
 	else
-- 
2.34.1

