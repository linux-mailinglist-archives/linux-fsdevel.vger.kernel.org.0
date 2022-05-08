Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19B751F12F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbiEHUeS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbiEHUdx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:33:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A56BE3B
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=oLd3wKHQsLmOSk0JSxNhjkm90+f/xkzJtkJwMBQHoq0=; b=vO0IfepHEylDiH7ko4NaR8nOI6
        LEY+/2/HDc6mt5eCRlEQPqoaL6ndZzutNTTT+3IGr8ZhuCqjlhLmqIUM6WZCWUgILf6eaWN7Q+cKe
        8TAa0AFPO8I5lOK2IIQ8abyZ+BaQj+DW7372Fc7NWOQh6QpNjqxcSUi1ZDmgkolo700pQzoobwu1I
        W4xisYUJAu41hLKA/RSAOgEOTOZw0ulOIQq6bhOVE3Oghp853wkiR1svFMwy1FMvHKdq2rRkw7LSF
        rAroHW+zjdpsz/jlDvDODUTPe7B75hpgOkTwAF2TQ7U179sxjAq4AvALGwFwf/xufEQIPtchWpufw
        svWxg+sg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnXT-002nZF-FP; Sun, 08 May 2022 20:29:59 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 16/25] buffer: Call aops write_begin() and write_end() directly
Date:   Sun,  8 May 2022 21:29:32 +0100
Message-Id: <20220508202941.667024-17-willy@infradead.org>
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

