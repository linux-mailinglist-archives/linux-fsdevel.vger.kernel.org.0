Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1135A29093E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Oct 2020 18:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409179AbgJPQFB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Oct 2020 12:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410570AbgJPQE6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Oct 2020 12:04:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEAFC061755
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2020 09:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=SoeUdKTgaEeumdsHlwEayshKcw/8MedETPawI1HuSQI=; b=ttpJPHVlwPcHBv8GebSCBxmnTN
        FgDC+gvxcb4jjRfWafVrRUlszkL3p2ZH/wDyiMXLAxROoLSOd3qXSDvluAjKtLxa3CKjnHS7JoucY
        FS2gH4JDqyxK2M7G65tJClc/4bFQOpPeiqdDzmmpASQ9H9t9ey90G2x5KUTHdCBIbT6DFv/1Xniyg
        qA+GkAe6/672Av6nUceAbFncdGTzkZ3GFOCZpeFH6ssnvByVXDBLy7pmew02Qq27SfRdvip7T/Yqr
        NARqnczlDAHM6hQYfgeMZRzphYz7MvMCc/a7HJ3fYZChkY9O4dt/L0a5ypr/VJ8f779g1LCJv7Kha
        emZS026w==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kTSDs-0004uV-HZ; Fri, 16 Oct 2020 16:04:52 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, Jan Kara <jack@suse.cz>
Subject: [PATCH v3 17/18] udf: Tell the VFS that readpage was synchronous
Date:   Fri, 16 Oct 2020 17:04:42 +0100
Message-Id: <20201016160443.18685-18-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201016160443.18685-1-willy@infradead.org>
References: <20201016160443.18685-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The udf inline data readpage implementation was already synchronous,
so use AOP_UPDATED_PAGE to avoid cycling the page lock.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Jan Kara <jack@suse.cz>
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

