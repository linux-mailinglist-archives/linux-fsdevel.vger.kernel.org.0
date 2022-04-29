Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F375151DB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 19:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379623AbiD2R3h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 13:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379510AbiD2R3Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:29:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB209D06D
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 10:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=HjnRYAbJ+5kbXyHJ7/0H9QbKM79C+qHmGeEOMq2GrLA=; b=FExHvEErGUlAF3jXdaaVmpctv8
        gfc23L6DvOpXS9XYLFr6cDKwTn6dmSBEgPgU/rkZoLdHd7iGh+5iGc8Sys2gtrSGuvVq36LoPzi5f
        +JtQf7TzsuP1bHLw4ycZ/IS3R9tgEL+2V3YAyDwiTteDtXcCGpTm22x0uJgeuy2AuMHbUUsntL9jv
        IlaBl5BYk63GI6tzLYZUB7iFSSOmYsdO7Not9V+kkrtyq9Ke7impnFL2mgghKpa0toZ3xZLAZUDAv
        vFJOhWcxfPym0y65Jj/XmHZA6ljnAIvZA4Gzk8OWym/skRPmzhaxNO1h6TXoISo8MQ90L7BU9ObPc
        iOzlh57Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkUNY-00CdYO-8F; Fri, 29 Apr 2022 17:26:04 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 17/69] buffer: Call aops write_begin() and write_end() directly
Date:   Fri, 29 Apr 2022 18:25:04 +0100
Message-Id: <20220429172556.3011843-18-willy@infradead.org>
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
 fs/buffer.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 02b50e3e4fbb..d538495a0553 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2344,6 +2344,7 @@ EXPORT_SYMBOL(block_read_full_page);
 int generic_cont_expand_simple(struct inode *inode, loff_t size)
 {
 	struct address_space *mapping = inode->i_mapping;
+	const struct address_space_operations *aops = mapping->a_ops;
 	struct page *page;
 	void *fsdata;
 	int err;
@@ -2352,11 +2353,11 @@ int generic_cont_expand_simple(struct inode *inode, loff_t size)
 	if (err)
 		goto out;
 
-	err = pagecache_write_begin(NULL, mapping, size, 0, 0, &page, &fsdata);
+	err = aops->write_begin(NULL, mapping, size, 0, &page, &fsdata);
 	if (err)
 		goto out;
 
-	err = pagecache_write_end(NULL, mapping, size, 0, 0, page, fsdata);
+	err = aops->write_end(NULL, mapping, size, 0, 0, page, fsdata);
 	BUG_ON(err > 0);
 
 out:
@@ -2368,6 +2369,7 @@ static int cont_expand_zero(struct file *file, struct address_space *mapping,
 			    loff_t pos, loff_t *bytes)
 {
 	struct inode *inode = mapping->host;
+	const struct address_space_operations *aops = mapping->a_ops;
 	unsigned int blocksize = i_blocksize(inode);
 	struct page *page;
 	void *fsdata;
@@ -2387,12 +2389,12 @@ static int cont_expand_zero(struct file *file, struct address_space *mapping,
 		}
 		len = PAGE_SIZE - zerofrom;
 
-		err = pagecache_write_begin(file, mapping, curpos, len, 0,
+		err = aops->write_begin(file, mapping, curpos, len,
 					    &page, &fsdata);
 		if (err)
 			goto out;
 		zero_user(page, zerofrom, len);
-		err = pagecache_write_end(file, mapping, curpos, len, len,
+		err = aops->write_end(file, mapping, curpos, len, len,
 						page, fsdata);
 		if (err < 0)
 			goto out;
@@ -2420,12 +2422,12 @@ static int cont_expand_zero(struct file *file, struct address_space *mapping,
 		}
 		len = offset - zerofrom;
 
-		err = pagecache_write_begin(file, mapping, curpos, len, 0,
+		err = aops->write_begin(file, mapping, curpos, len,
 					    &page, &fsdata);
 		if (err)
 			goto out;
 		zero_user(page, zerofrom, len);
-		err = pagecache_write_end(file, mapping, curpos, len, len,
+		err = aops->write_end(file, mapping, curpos, len, len,
 						page, fsdata);
 		if (err < 0)
 			goto out;
-- 
2.34.1

