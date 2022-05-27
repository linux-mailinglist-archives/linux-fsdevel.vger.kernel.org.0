Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F7E536507
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 May 2022 17:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353705AbiE0Pvc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 May 2022 11:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353712AbiE0Pva (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 May 2022 11:51:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C0C1038
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 08:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Jx21YCMfVRPPtzra5uUZP9j4fCW3PrPAxum0BhgJe/Q=; b=HUSlDZ11G9WQp367CVuD3LEo4i
        iR4xSq+OazPUd9RZVT/cqwsKeSKL8qg99HmawCwbLR7jc4Svq48NZRi8thVsEdpzcKNRZo1rfxFc6
        emAfCyGAJ955R9nDtu0RSvbPap9XWZqAtb3KbUs36NIhvlSEgFaIhXrpTlhENx+Z1a6hdMWAx2sR7
        Tg4x88kpmgNcuwVJ34ldHzIh09ZH2MKNsgmPOnEhSDvofx32+pNJH7U4fVqsWs9YbnxuIC4Viu2PT
        /5VD8qPbOMEPP3ZGRxTZ6EhAd+Amz87NFUhoIMz1ppzhvL/Yd7NoC8JARCJdJbW/Ko1/EEwYfxLKh
        Dg9AIWVQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nucEa-002CWQ-Fa; Fri, 27 May 2022 15:50:40 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Subject: [PATCH 03/24] freevxfs: Remove check of PageError
Date:   Fri, 27 May 2022 16:50:15 +0100
Message-Id: <20220527155036.524743-4-willy@infradead.org>
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

If read_mapping_page() encounters an error, it returns an errno, not a
page with PageError set, so this is dead code.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/freevxfs/vxfs_subr.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/freevxfs/vxfs_subr.c b/fs/freevxfs/vxfs_subr.c
index 6143ebab940d..041e818c4577 100644
--- a/fs/freevxfs/vxfs_subr.c
+++ b/fs/freevxfs/vxfs_subr.c
@@ -75,15 +75,9 @@ vxfs_get_page(struct address_space *mapping, u_long n)
 		kmap(pp);
 		/** if (!PageChecked(pp)) **/
 			/** vxfs_check_page(pp); **/
-		if (PageError(pp))
-			goto fail;
 	}
 	
 	return (pp);
-		 
-fail:
-	vxfs_put_page(pp);
-	return ERR_PTR(-EIO);
 }
 
 /**
-- 
2.34.1

