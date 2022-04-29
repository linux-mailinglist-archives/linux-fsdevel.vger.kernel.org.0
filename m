Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73B35151DF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 19:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379628AbiD2R3p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 13:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379519AbiD2R3Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:29:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94AA9E9D2
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 10:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=PIbS69XPyfEWg59JWx0WNAEQv+JtVO+L2gtIxkTD4P8=; b=mBSEtIBIQU3fXgad+0Q7oeZWC9
        XjzyfFRWlMd2aRUYLlIL/q4j7dVpYLHecvET3Ffx7CG1r32xLmd7Zllm2UhgwUqAeEy4aWrWqOCqQ
        7WRpaFzXwb1yHjutDfMO/ahXb0Qmkx/kv332TD4shC4sDWMtEXh2fnHxwE8Mz4rVSX5o1DNg1mJPM
        hmzE3pSP3Mmyl4AFh3EfOyjBmMkySkhxPSoA5TPjJKDeWtf9YkECdXVOwpWvY0ist90ajPprRkzhA
        IK3vbvlQFg17lJYhjD/48WfzwH+JT9PzN49BRizG9fIV6ZN8s+zdEsJlGR7uXMYLrzENviaw0QLE0
        8IEJyxqw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkUNY-00CdYs-Sd; Fri, 29 Apr 2022 17:26:04 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 22/69] ext4: Call aops write_begin() and write_end() directly
Date:   Fri, 29 Apr 2022 18:25:09 +0100
Message-Id: <20220429172556.3011843-23-willy@infradead.org>
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
 fs/ext4/verity.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
index eacbd489e3bf..b051d19b5c8a 100644
--- a/fs/ext4/verity.c
+++ b/fs/ext4/verity.c
@@ -69,6 +69,9 @@ static int pagecache_read(struct inode *inode, void *buf, size_t count,
 static int pagecache_write(struct inode *inode, const void *buf, size_t count,
 			   loff_t pos)
 {
+	struct address_space *mapping = inode->i_mapping;
+	const struct address_space_operations *aops = mapping->a_ops;
+
 	if (pos + count > inode->i_sb->s_maxbytes)
 		return -EFBIG;
 
@@ -79,15 +82,13 @@ static int pagecache_write(struct inode *inode, const void *buf, size_t count,
 		void *fsdata;
 		int res;
 
-		res = pagecache_write_begin(NULL, inode->i_mapping, pos, n, 0,
-					    &page, &fsdata);
+		res = aops->write_begin(NULL, mapping, pos, n, &page, &fsdata);
 		if (res)
 			return res;
 
 		memcpy_to_page(page, offset_in_page(pos), buf, n);
 
-		res = pagecache_write_end(NULL, inode->i_mapping, pos, n, n,
-					  page, fsdata);
+		res = aops->write_end(NULL, mapping, pos, n, n, page, fsdata);
 		if (res < 0)
 			return res;
 		if (res != n)
-- 
2.34.1

