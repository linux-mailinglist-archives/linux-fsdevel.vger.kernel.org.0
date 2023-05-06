Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE0A6F92FF
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 May 2023 18:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjEFQEh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 May 2023 12:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjEFQEh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 May 2023 12:04:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79BD8685
        for <linux-fsdevel@vger.kernel.org>; Sat,  6 May 2023 09:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=behTiREaMc5g42beO1FZ84CdMnER08mqJB7qg1qhoeA=; b=BFolmZ/DBV0UdxhzRYlJ6x+qKv
        Qx1c/U7tYvCG9w1ZotIRaWd0y5e9iQUR1gUmeszrWARl7xlaef96EHB+jcsxef+z9QpNgk+w7RIop
        5ZbSBFaWoe6kw6jwQbAHMSWF7iGYYaaRvUvC+jUtC8CqXyiCpiP5OS1dKqmjVLOOAAUtLrA9PSDml
        /bLjFi6BgutwYxxZ7F4SKd87pKu8CHd7dDMjwefXbUq+h3uHiBsG36DtGZsSWeGRbBkn+lgawU+O6
        TFDG+3oVF/Hh6WfcnL3QC7GJXBjWRCKVe75T4oig9jBPdrpL2HEdim6Yx29OTTrvE74NU8rt3R5lv
        vJglS7sA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pvKOa-00CYNk-Kf; Sat, 06 May 2023 16:04:28 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@linaro.org>,
        syzbot+48011b86c8ea329af1b9@syzkaller.appspotmail.com,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH] filemap: Handle error return from __filemap_get_folio()
Date:   Sat,  6 May 2023 17:04:14 +0100
Message-Id: <20230506160415.2992089-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
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

Smatch reports that filemap_fault() was missed in the conversion of
__filemap_get_folio() error returns from NULL to ERR_PTR.

Fixes: 66dabbb65d67 ("mm: return an ERR_PTR from __filemap_get_folio")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Reported-by: syzbot+48011b86c8ea329af1b9@syzkaller.appspotmail.com
Reported-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index a34abfe8c654..b4c9bd368b7e 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3378,7 +3378,7 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	 * re-find the vma and come back and find our hopefully still populated
 	 * page.
 	 */
-	if (folio)
+	if (!IS_ERR(folio))
 		folio_put(folio);
 	if (mapping_locked)
 		filemap_invalidate_unlock_shared(mapping);
-- 
2.39.2

