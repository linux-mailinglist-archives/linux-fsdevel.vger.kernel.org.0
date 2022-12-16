Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A10A64F2C6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Dec 2022 21:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbiLPUyc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Dec 2022 15:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbiLPUyH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Dec 2022 15:54:07 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9696357B6B;
        Fri, 16 Dec 2022 12:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Axde40IIYnLKGgHM+KLoKUK+4c/QX0KAEOS8G4YPE4k=; b=uafEFe2OC9tj5Bfbw7SW+6Q9VS
        qUrULM2Nu6G2v9FnuwFtal6ZWyOdUi4TAm77ZhTRrW8Y9SM2ZW6iL90wbrt2BIAagseKjOE7bIO/L
        FoAA97k1Twq/d4KOarYci6kYF6wVNC9mHfVA2vI5OQJToAIbwlf75w9mi0rELiMTBhTJDMnNnlmxp
        1NdKtBiYdqRp7NeG63PjGe1ZGHwN7+O4pDHOHMZ8GFT7bMQBecrVpXX3luji5DOPqYF9yyIk7wPmR
        PJS5vVTCEOdgmta/CCsg0apK1hY6e+MxRahh1Z/ngZaQp/UEzKfabdxfYpMFS/5xyjD629WqrG+aZ
        WzkBO6kw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p6HiI-00Frfo-2t; Fri, 16 Dec 2022 20:53:50 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     reiserfs-devel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH 4/8] reiserfs: Convert reiserfs_delete_item() to use kmap_local_folio()
Date:   Fri, 16 Dec 2022 20:53:43 +0000
Message-Id: <20221216205348.3781217-5-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221216205348.3781217-1-willy@infradead.org>
References: <20221216205348.3781217-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

kmap_atomic() is deprecated, and so is bh->b_page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/reiserfs/stree.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/reiserfs/stree.c b/fs/reiserfs/stree.c
index 84c12a1947b2..309c61bd90e0 100644
--- a/fs/reiserfs/stree.c
+++ b/fs/reiserfs/stree.c
@@ -1359,12 +1359,13 @@ int reiserfs_delete_item(struct reiserfs_transaction_handle *th,
 		 * -clm
 		 */
 
-		data = kmap_atomic(un_bh->b_page);
-		off = ((le_ih_k_offset(&s_ih) - 1) & (PAGE_SIZE - 1));
-		memcpy(data + off,
+		off = offset_in_folio(un_bh->b_folio,
+					le_ih_k_offset(&s_ih) - 1);
+		data = kmap_local_folio(un_bh->b_folio, off);
+		memcpy(data,
 		       ih_item_body(PATH_PLAST_BUFFER(path), &s_ih),
 		       ret_value);
-		kunmap_atomic(data);
+		kunmap_local(data);
 	}
 
 	/* Perform balancing after all resources have been collected at once. */
-- 
2.35.1

