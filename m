Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81477661E61
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jan 2023 06:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236406AbjAIFS6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 00:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234878AbjAIFSY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 00:18:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69A6DE80;
        Sun,  8 Jan 2023 21:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ka5+iF4ZHGa0/h4sTq7sbQGVl9e8Q3iYzmlIIaQ/sWI=; b=i/qCQROxWBGYJBbp7WWwA2/Yvw
        Dp51Rqs4Jyu0jDo2hlrt+BgXNzbaN0GGMq7jiZbomx7g2Z1moIfQd4S26iD20Wx1lgwxVcVVLJlfB
        m3oJgbKQ7cxdKfhGyEArj6Pdh/Vavd0nsnL+WwFB9DYdYPvjEMdayAceV2jqlDwDfoc1bB9+8xv/W
        2sD8mcl3FP9+WTM0o7s8uiBCj5KapY4EWuMdX7aB0vExNWT2/2+ku+8olFqdDnvPmw9+fspzT718R
        3MzT+pW9s1EyjLZYJH8nv6yJcMkiJnMmFZLvaNPl+bbgf4FKlttTj+F+vUdAZFW0YOKrcSrFt4Nfx
        AQo3heCw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pEkYD-0020wp-46; Mon, 09 Jan 2023 05:18:25 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jeff Layton <jlayton@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 02/11] filemap: Remove filemap_check_and_keep_errors()
Date:   Mon,  9 Jan 2023 05:18:14 +0000
Message-Id: <20230109051823.480289-3-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230109051823.480289-1-willy@infradead.org>
References: <20230109051823.480289-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert both callers to use the "new" errseq infrastructure.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index c4d4ace9cc70..48daedc224d9 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -355,16 +355,6 @@ int filemap_check_errors(struct address_space *mapping)
 }
 EXPORT_SYMBOL(filemap_check_errors);
 
-static int filemap_check_and_keep_errors(struct address_space *mapping)
-{
-	/* Check for outstanding write errors */
-	if (test_bit(AS_EIO, &mapping->flags))
-		return -EIO;
-	if (test_bit(AS_ENOSPC, &mapping->flags))
-		return -ENOSPC;
-	return 0;
-}
-
 /**
  * filemap_fdatawrite_wbc - start writeback on mapping dirty pages in range
  * @mapping:	address space structure to write
@@ -567,8 +557,10 @@ EXPORT_SYMBOL(filemap_fdatawait_range);
 int filemap_fdatawait_range_keep_errors(struct address_space *mapping,
 		loff_t start_byte, loff_t end_byte)
 {
+	errseq_t since = filemap_sample_wb_err(mapping);
+
 	__filemap_fdatawait_range(mapping, start_byte, end_byte);
-	return filemap_check_and_keep_errors(mapping);
+	return filemap_check_wb_err(mapping, since);
 }
 EXPORT_SYMBOL(filemap_fdatawait_range_keep_errors);
 
@@ -613,8 +605,10 @@ EXPORT_SYMBOL(file_fdatawait_range);
  */
 int filemap_fdatawait_keep_errors(struct address_space *mapping)
 {
+	errseq_t since = filemap_sample_wb_err(mapping);
+
 	__filemap_fdatawait_range(mapping, 0, LLONG_MAX);
-	return filemap_check_and_keep_errors(mapping);
+	return filemap_check_wb_err(mapping, since);
 }
 EXPORT_SYMBOL(filemap_fdatawait_keep_errors);
 
-- 
2.35.1

