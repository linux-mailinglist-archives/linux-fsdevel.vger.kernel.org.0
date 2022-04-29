Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2EF5151E1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 19:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379674AbiD2R3s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 13:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379523AbiD2R3Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:29:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC54B972FC
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 10:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=eBwsOuO41PPe1bFLp/Nt2l81HUxjuF3P4f7UhnknnGo=; b=v5KFB1rXhdkeOCG58gvpdxnIDs
        r6elDCZk3UvQo0Kb+lgYq9CS3CmA85Qc39A45wP7t9AjExO0PpTrIZzeZDPh2N+JZwKzzLDgrCh6s
        LkErfWA1MyOz2GTNnfHJ/PwXgs1bKXv84sHl9LVfmFSvv6b33kzZHumgi/1Fda4tOsF3XF2ArZuO0
        ChjvuDlWaf8Xhwiu7/cLVlcDWN9avfVg4oN+aN01+6IE2hBxpdEb/7hFLkByTQIS7EszoR9Q9oMPW
        9XYjG81vsnRJf7PGoS13zTCNfQfChOCCw2IpUHgmdSgHOqdmnLAwTU3WfnzQq7+f0CMwI0rAjdcqm
        LsD1Gchw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkUNZ-00CdYx-0Q; Fri, 29 Apr 2022 17:26:05 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 23/69] f2fs: Call aops write_begin() and write_end() directly
Date:   Fri, 29 Apr 2022 18:25:10 +0100
Message-Id: <20220429172556.3011843-24-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220429172556.3011843-1-willy@infradead.org>
References: <20220429172556.3011843-1-willy@infradead.org>
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

pagecache_write_begin() and pagecache_write_end() are now trivial
wrappers, so call the aops directly.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/verity.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
index 3d793202cc9f..65395ae188aa 100644
--- a/fs/f2fs/verity.c
+++ b/fs/f2fs/verity.c
@@ -74,6 +74,9 @@ static int pagecache_read(struct inode *inode, void *buf, size_t count,
 static int pagecache_write(struct inode *inode, const void *buf, size_t count,
 			   loff_t pos)
 {
+	struct address_space *mapping = inode->i_mapping;
+	const struct address_space_operations *aops = mapping->a_ops;
+
 	if (pos + count > inode->i_sb->s_maxbytes)
 		return -EFBIG;
 
@@ -85,8 +88,7 @@ static int pagecache_write(struct inode *inode, const void *buf, size_t count,
 		void *addr;
 		int res;
 
-		res = pagecache_write_begin(NULL, inode->i_mapping, pos, n, 0,
-					    &page, &fsdata);
+		res = aops->write_begin(NULL, mapping, pos, n, &page, &fsdata);
 		if (res)
 			return res;
 
@@ -94,8 +96,7 @@ static int pagecache_write(struct inode *inode, const void *buf, size_t count,
 		memcpy(addr + offset_in_page(pos), buf, n);
 		kunmap_atomic(addr);
 
-		res = pagecache_write_end(NULL, inode->i_mapping, pos, n, n,
-					  page, fsdata);
+		res = aops->write_end(NULL, mapping, pos, n, n, page, fsdata);
 		if (res < 0)
 			return res;
 		if (res != n)
-- 
2.34.1

