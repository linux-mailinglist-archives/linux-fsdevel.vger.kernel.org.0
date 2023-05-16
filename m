Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087B670570F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 21:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjEPT11 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 15:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjEPT10 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 15:27:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46F935AD;
        Tue, 16 May 2023 12:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=6ZrPYDjwLGlRaReyRClDuqn4qyu9lZUT+0fYgFgPHu0=; b=d9EZO9asjupb3jlC/brALJtbtQ
        0uTLJKKO/MBmoyBlZFNzPjU5vpkp7nzh0TEEqF8F96GaTWqQXGVFWeILRLRtOHx3EDHY0fz4kjZl2
        zEyXiWoTA4L/JsClBdSg3fWJgxokSlu/olWCz90JAL+BtFW3tiB3nVC4HLP/UCmAhlgpQ+p7tOWfA
        VOPYmYFPO7v7Ffd4UBuraYVz+UOixrLKtwq2D8LLBvZPx01ZWc4QQkDrwojm2TwfuKxWW+rJcdUPR
        0MxfVjh2P7DlyXqomzBQ8swQAdBZBcq759vVD/RjAsvztddgSxdioiksfUnKA/8Mqvy0JnZPHOqi7
        w60ndHdw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pz0KR-004UVv-7Y; Tue, 16 May 2023 19:27:23 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 6/5] ext4: Call fsverity_verify_folio()
Date:   Tue, 16 May 2023 20:27:13 +0100
Message-Id: <20230516192713.1070469-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1684122756.git.ritesh.list@gmail.com>
References: <cover.1684122756.git.ritesh.list@gmail.com>
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

Now that fsverity supports working on entire folios, call
fsverity_verify_folio() instead of fsverity_verify_page()

Reported-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/readpage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
index 6f46823fba61..3e7d160f543f 100644
--- a/fs/ext4/readpage.c
+++ b/fs/ext4/readpage.c
@@ -334,7 +334,7 @@ int ext4_mpage_readpages(struct inode *inode,
 					  folio_size(folio));
 			if (first_hole == 0) {
 				if (ext4_need_verity(inode, folio->index) &&
-				    !fsverity_verify_page(&folio->page))
+				    !fsverity_verify_folio(folio))
 					goto set_error_page;
 				folio_mark_uptodate(folio);
 				folio_unlock(folio);
-- 
2.39.2

