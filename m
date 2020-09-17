Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E06B026DF63
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 17:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgIQPQA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 11:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727958AbgIQPLm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 11:11:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDD2C061356;
        Thu, 17 Sep 2020 08:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=VYle+Dy78vGTLJwXqjetxI7H6ckJt5lDFPp8DD2uNGg=; b=V0mCKcOWAD8LZwIpL8pYZJAODz
        ks+ksIQuf2jXnakiEJa2r+1ydB3o4OV0U8IbKATo2l/9ikpsHf1fkR+V3rxyB66/wQOUhBaLbMdLj
        6ndjrHb5ife/voKvoE6tbqaARAJh8rBEPWbqNhl4pM+DcKaPCG+C1d+1eawTVjva18TxCLbTbPxvN
        VlX+BF7sHG36BMaf3mqJvTuHegLCTJaT1VK/d0j1mqUuF6P2GH1tGCTjYNgYtaAh9FTNOwnYoIozA
        P+PcpgZmeJGFJRA/lFJknTpeXa2yh/EVHrCtzQ9dV1oP9s1Oc75pRO5fPsB43W7ntB/iyA0nyqwco
        DGNIOLZA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIvYl-0001Qk-4V; Thu, 17 Sep 2020 15:10:55 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, v9fs-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-afs@lists.infradead.org,
        ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
        ecryptfs@vger.kernel.org, linux-um@lists.infradead.org,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH 12/13] udf: Tell the VFS that readpage was synchronous
Date:   Thu, 17 Sep 2020 16:10:49 +0100
Message-Id: <20200917151050.5363-13-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200917151050.5363-1-willy@infradead.org>
References: <20200917151050.5363-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The udf inline data readpage implementation was already synchronous,
so use AOP_UPDATED_PAGE to avoid cycling the page lock.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/udf/file.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/udf/file.c b/fs/udf/file.c
index 628941a6b79a..52bbe92d7c43 100644
--- a/fs/udf/file.c
+++ b/fs/udf/file.c
@@ -61,9 +61,8 @@ static int udf_adinicb_readpage(struct file *file, struct page *page)
 {
 	BUG_ON(!PageLocked(page));
 	__udf_adinicb_readpage(page);
-	unlock_page(page);
 
-	return 0;
+	return AOP_UPDATED_PAGE;
 }
 
 static int udf_adinicb_writepage(struct page *page,
-- 
2.28.0

