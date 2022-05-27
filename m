Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7062D536500
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 May 2022 17:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353709AbiE0PvV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 May 2022 11:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353307AbiE0PvI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 May 2022 11:51:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1711356AB
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 08:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Ggb+L4sMKnorrrtIPTNimFUmJzMqRu7Oqnlpuif96os=; b=e9KrqStoM/jiiAAHayqHw8X13L
        NY/Z+vZ/wdzDxP9zB2ZRSWif0GPyHqG5rQ6HYbDvlVR4+58lBVTnz0ittCd4NE6f4wW/w9auYq0zU
        HN7Dc2Nqt7RBJ8t0wcnBlFHyYvLTOC95tqrn/YWb6w1naLTrVrzP1x3Coz6X+/WDm8qdphjp/xLnC
        lug7NWiGfXwJ3JQ+dfRMshIM8hbivBzNycwKX2dv/gk0bA4+u0WgN1P+D1PaHLdClSbyr7Qe9ROMi
        TP/JCspmbTTkW1uC4d2ELDsxqPiegTml8/WkvTjAGQ1s5JEry2c2c0gjp4R20edfoc4Dxdx+gCTk3
        VsaLK0Kw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nucEa-002CWY-P7; Fri, 27 May 2022 15:50:40 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Subject: [PATCH 07/24] ntfs: Remove check for PageError
Date:   Fri, 27 May 2022 16:50:19 +0100
Message-Id: <20220527155036.524743-8-willy@infradead.org>
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
 fs/ntfs/file.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index e1392a9b8ceb..37224ebdcd10 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -219,11 +219,6 @@ static int ntfs_attr_extend_initialized(ntfs_inode *ni, const s64 new_init_size)
 			err = PTR_ERR(page);
 			goto init_err_out;
 		}
-		if (unlikely(PageError(page))) {
-			put_page(page);
-			err = -EIO;
-			goto init_err_out;
-		}
 		/*
 		 * Update the initialized size in the ntfs inode.  This is
 		 * enough to make ntfs_writepage() work.
-- 
2.34.1

