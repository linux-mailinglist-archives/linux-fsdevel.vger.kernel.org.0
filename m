Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECD2288B61
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Oct 2020 16:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388949AbgJIOcy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Oct 2020 10:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388816AbgJIObK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Oct 2020 10:31:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F980C0613D6;
        Fri,  9 Oct 2020 07:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=7u5VAtMiRg84eQRBFRLzhqfSMq0woXu9gI0XciTFBfo=; b=BPIddsLgHlfdV+iVajjIuvjIRm
        5m+SPjVF5IGNp5DQ+kIQ/W2usaGaZ8ERcMDbBc6laYoBvWK/J00fpvXlRmJKyu/TZj60d+laiyjS8
        VPYfqPFYBB4v583KBV93dh1vEaeFH4YgiWGqEN4ScuGlPPQ8bopka3nZr9ENPNE+sK7/ZWcgsAvKp
        aYlrGkftZt7dinFy3xCdrsc6n9GJkAYH/LbNqLa/jNOCmgSvfxEvf+juWvUVkLbaJIwZevAudngC+
        Y8M9LM2UmRY4e0R2r6XOfH46TIZ4TVlvRvSXGL+a48VhuEyQkj86XyTUBn1brFf7N9OrnKYCobSkU
        +TUEEzrA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQtQJ-0005uy-PZ; Fri, 09 Oct 2020 14:31:07 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, v9fs-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-afs@lists.infradead.org,
        ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
        ecryptfs@vger.kernel.org, linux-um@lists.infradead.org,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        linux-xfs@vger.kernel.org
Subject: [PATCH v2 06/16] cifs: Tell the VFS that readpage was synchronous
Date:   Fri,  9 Oct 2020 15:30:54 +0100
Message-Id: <20201009143104.22673-7-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201009143104.22673-1-willy@infradead.org>
References: <20201009143104.22673-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The cifs readpage implementation was already synchronous, so use
AOP_UPDATED_PAGE to avoid cycling the page lock.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/cifs/file.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index be46fab4c96d..533b151a9143 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -4537,7 +4537,8 @@ static int cifs_readpage_worker(struct file *file, struct page *page,
 	/* send this page to the cache */
 	cifs_readpage_to_fscache(file_inode(file), page);
 
-	rc = 0;
+	kunmap(page);
+	return AOP_UPDATED_PAGE;
 
 io_error:
 	kunmap(page);
@@ -4677,7 +4678,10 @@ static int cifs_write_begin(struct file *file, struct address_space *mapping,
 		 * an error, we don't need to return it. cifs_write_end will
 		 * do a sync write instead since PG_uptodate isn't set.
 		 */
-		cifs_readpage_worker(file, page, &page_start);
+		int err = cifs_readpage_worker(file, page, &page_start);
+
+		if (err == AOP_UPDATED_PAGE)
+			goto out;
 		put_page(page);
 		oncethru = 1;
 		goto start;
-- 
2.28.0

