Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF375364F7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 May 2022 17:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353672AbiE0PvI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 May 2022 11:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353091AbiE0Pur (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 May 2022 11:50:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B150D134E11
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 08:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=DJY687eqHjmpDVUKm/xXxUZxBj5KWv9uItsiE/FIc4I=; b=Y8f1cRpo8fYv+eUKAfQeyS8pik
        SlRPrFW+ZvhpPNkvDEI8UGgqO26CquSyrXSTmdqXXYSOb5xddzl+KFizeqoDCvwdckwzWioTRFu2o
        BtyHp4vRjrPr6x2SlMJX1/voab0Kk3/BUT58eNr2bU3ZgoH8stycbX6EN5uAuuom0gAMaBc2nBzfB
        BfVOcdszN29s6pROELQxSfHGPS2tj/ngpZbfeuVSLtoRUYaqnSBcBLAR0nBAQz2cf97PXGHeryMP+
        zEJIifXcjGLyD2jIFhweM0CTS539uARqFxwVEvKQaUeBOEJJL0xYP/Pjd/EwddsBUElfVOI3030Ch
        6e9C4rZA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nucEa-002CWc-Tg; Fri, 27 May 2022 15:50:40 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Subject: [PATCH 09/24] nilfs2: Remove check for PageError
Date:   Fri, 27 May 2022 16:50:21 +0100
Message-Id: <20220527155036.524743-10-willy@infradead.org>
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
page with PageError set, so this test is not needed.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/nilfs2/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
index f8f4c2ff52f4..decd6471300b 100644
--- a/fs/nilfs2/dir.c
+++ b/fs/nilfs2/dir.c
@@ -194,7 +194,7 @@ static struct page *nilfs_get_page(struct inode *dir, unsigned long n)
 	if (!IS_ERR(page)) {
 		kmap(page);
 		if (unlikely(!PageChecked(page))) {
-			if (PageError(page) || !nilfs_check_page(page))
+			if (!nilfs_check_page(page))
 				goto fail;
 		}
 	}
-- 
2.34.1

