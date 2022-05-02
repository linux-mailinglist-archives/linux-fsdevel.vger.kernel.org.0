Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25BCA516A5B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 May 2022 07:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383342AbiEBFpk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 May 2022 01:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbiEBFpg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 May 2022 01:45:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2A935847;
        Sun,  1 May 2022 22:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Tqa27ZTkwRUChUFFhePcdT99JAqNU7Wtt1R4QbW6KOM=; b=EH6Lr/nkI8efcRDg36iw5nLsCC
        Mx0+fz7ITr/sUBxXRX/dl+k3LvtWo+yjOHEjks/7NE5eIKHT5x4i2Y0AU4W4p8Y2inntRuvtn1jwi
        ZZzLbGh4/rauE727HbfFMPCiGgqzMxIFhV2hCPgnOC4+Mu1d4ezgXuhlARXGesJzqVRIG0423e/X1
        U5Lm3Srx4aJZ9P1O+GptWCBraszICk6TlVhfbIzoFoZg6254Xq85a5QScBOULZiq2+G4nUJHiXq3K
        VRpqp1XJ5SdstxvIpv/8KzO2EYD1d5HVbWcOA4ec5M+0dO8pzkrPdul9HOhLuCQXOGWHBLOVyQplY
        +ch9yCzw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nlOot-00EZ01-QF; Mon, 02 May 2022 05:42:03 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        cluster-devel@redhat.com, linux-mtd@lists.infradead.org,
        linux-nfs@vger.kernel.org
Subject: [PATCH 1/3] jffs2: Pass the file pointer to jffs2_do_readpage_unlock()
Date:   Mon,  2 May 2022 06:41:57 +0100
Message-Id: <20220502054159.3471078-2-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220502054159.3471078-1-willy@infradead.org>
References: <20220502054159.3471078-1-willy@infradead.org>
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

