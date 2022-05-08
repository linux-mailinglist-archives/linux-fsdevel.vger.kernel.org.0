Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C4251F138
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbiEHUeT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbiEHUd5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:33:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406AEE018
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=EY88G43WjdyudKh5Yl3ezx6267meKLzch+pMC3VXPRo=; b=FU4S4BN0aluO6eFlnP7j0Gzg8w
        ewxLxJ7ESnnn/Ut7J1N9nsOxaXmGU8PAecXRj5wSIsExIBEfjs3LC6rOSZXe5Zzi6B/vRDZy3vWAF
        ORN5mnEM3V2uk904yqNe+HMMs2CE1JwPKB2t8w5JiW53MvldW3yYD99/zSiZJmZJh9YwyFhyYaa7M
        tGD6riX7xnRIV1TMQpLaR1CHQ0A9p0ajBcsGwaG7yNYPyzxpwHmuK7X+DO3HsSTUPF5qWWewD3kls
        SJZRK9cD6zPXBv3u28D+KxdB8LpgkYznNd04yzWZsPs/y1l805cexD0tjA/BfGSNjl0lcOXjjBPFd
        tLJgz7OQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnXU-002nZr-9h; Sun, 08 May 2022 20:30:00 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 23/25] f2fs: Call aops write_begin() and write_end() directly
Date:   Sun,  8 May 2022 21:29:39 +0100
Message-Id: <20220508202941.667024-24-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220508202941.667024-1-willy@infradead.org>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
 <20220508202941.667024-1-willy@infradead.org>
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

pagecache_write_begin() and pagecache_write_end() are now trivial
wrappers, so call the aops directly.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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

