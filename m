Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37CC851F18D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbiEHUha (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232768AbiEHUga (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:36:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C69B627F
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=/8NXq4B/+lQw+d2WGEpv8i3KdGQFasf2YdVBHnpnOEU=; b=lsi1fzXUjl7BhZ6Du0G60jTRnF
        pSXa3r0pUoi+9C45TfuU/N8YIAbrjIfT8lqr3ukgvydcoHzcDP8V5MhPk3YQYIvi1S2j7v2qtA0D7
        ZvndLSji/SMdVO1DLWOZjCcGBnQDYsuKhaZHLRaFMuCuwCm32k7c/QhQeAKCAWXtnnsCUQr/hG4Ww
        e+jL7BR7WFJ6bbQEtKGwDp4vpDCcVXQUfgfOc+SdsH9DYRxFUy39dg39hVFYOnAhoX9JRhSTnRRhj
        WhbrJphYodEXvcRkbWTsRXKwvza2IW7EZ60E52vMulPsvaUjirdr0KLWN17pJ7Y3Ujr+A4u9Lhon0
        LUzKg5cQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnna0-002nxu-Ep; Sun, 08 May 2022 20:32:36 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/4] jffs2: Pass the file pointer to jffs2_do_readpage_unlock()
Date:   Sun,  8 May 2022 21:32:31 +0100
Message-Id: <20220508203234.668623-2-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220508203234.668623-1-willy@infradead.org>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
 <20220508203234.668623-1-willy@infradead.org>
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

In preparation for unifying the read_cache_page() and read_folio()
implementations, make jffs2_do_readpage_unlock() get the inode
from the page instead of passing it in from read_cache_page().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/jffs2/file.c | 4 ++--
 fs/jffs2/gc.c   | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/jffs2/file.c b/fs/jffs2/file.c
index f8616683fbee..492fb2da0403 100644
--- a/fs/jffs2/file.c
+++ b/fs/jffs2/file.c
@@ -112,7 +112,7 @@ static int jffs2_do_readpage_nolock (struct inode *inode, struct page *pg)
 
 int jffs2_do_readpage_unlock(void *data, struct page *pg)
 {
-	int ret = jffs2_do_readpage_nolock(data, pg);
+	int ret = jffs2_do_readpage_nolock(pg->mapping->host, pg);
 	unlock_page(pg);
 	return ret;
 }
@@ -124,7 +124,7 @@ static int jffs2_read_folio(struct file *file, struct folio *folio)
 	int ret;
 
 	mutex_lock(&f->sem);
-	ret = jffs2_do_readpage_unlock(folio->mapping->host, &folio->page);
+	ret = jffs2_do_readpage_unlock(file, &folio->page);
 	mutex_unlock(&f->sem);
 	return ret;
 }
diff --git a/fs/jffs2/gc.c b/fs/jffs2/gc.c
index 373b3b7c9f44..a53bac7569b6 100644
--- a/fs/jffs2/gc.c
+++ b/fs/jffs2/gc.c
@@ -1327,7 +1327,7 @@ static int jffs2_garbage_collect_dnode(struct jffs2_sb_info *c, struct jffs2_era
 	 * trying to write out, read_cache_page() will not deadlock. */
 	mutex_unlock(&f->sem);
 	page = read_cache_page(inode->i_mapping, start >> PAGE_SHIFT,
-			       jffs2_do_readpage_unlock, inode);
+			       jffs2_do_readpage_unlock, NULL);
 	if (IS_ERR(page)) {
 		pr_warn("read_cache_page() returned error: %ld\n",
 			PTR_ERR(page));
-- 
2.34.1

