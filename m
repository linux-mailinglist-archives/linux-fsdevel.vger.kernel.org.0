Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6118661E54
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jan 2023 06:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236181AbjAIFSX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 00:18:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234167AbjAIFSS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 00:18:18 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D669CE17;
        Sun,  8 Jan 2023 21:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=b0czJbVeNEC59VHM8B9sq3qAwimTZQLD9J+IkbH6tGY=; b=ROGJTN6UntJy+YzsThEJJrxCJi
        TtVnoQq6up+P0EtHyGjHt6GeNnEoNZZk5bvjdgDBnt5U65teg3i0Q/vxeBhKrad0sQs5iCaUJ9aai
        hCoVJCKYxDMlWwNLtSUIdhPNwVYFZp7rjLsp1+yMFDTlOZEtR/uM5wKsrSTfHHqwDseBTLtSg1DqX
        9fj9xRKQeflkeQLrCnDNMoea62skAbanZyCf2l5+xZAyzuXC4pRHywBj+sm5Z1MGsJ/DbzLeUgH2w
        RCVS9uE/Mi1NxFEeqnCNUT4mhbmgSj9IAKRM104Ix+jlmWWqNram/pb4oU6K2cN5Lppll1ajraNhZ
        0ddXvYzQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pEkYD-0020x5-JH; Mon, 09 Jan 2023 05:18:25 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jeff Layton <jlayton@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 06/11] filemap: Convert filemap_write_and_wait_range() to use errseq
Date:   Mon,  9 Jan 2023 05:18:18 +0000
Message-Id: <20230109051823.480289-7-willy@infradead.org>
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

Use the errseq APIs to discover writeback errors instead of
filemap_check_errors().  This gives us more precise information
about whether this writeback generated the error.  This will no
longer clear errors, so they will be visible to other users, which
is what we want.  Take this opportunity to de-indent
filemap_write_and_wait_range().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 48daedc224d9..c72b2e1140d7 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -659,26 +659,27 @@ EXPORT_SYMBOL_GPL(filemap_range_has_writeback);
 int filemap_write_and_wait_range(struct address_space *mapping,
 				 loff_t lstart, loff_t lend)
 {
-	int err = 0, err2;
+	int err;
+	errseq_t since;
 
 	if (lend < lstart)
 		return 0;
+	if (!mapping_needs_writeback(mapping))
+		return 0;
 
-	if (mapping_needs_writeback(mapping)) {
-		err = __filemap_fdatawrite_range(mapping, lstart, lend,
-						 WB_SYNC_ALL);
-		/*
-		 * Even if the above returned error, the pages may be
-		 * written partially (e.g. -ENOSPC), so we wait for it.
-		 * But the -EIO is special case, it may indicate the worst
-		 * thing (e.g. bug) happened, so we avoid waiting for it.
-		 */
-		if (err != -EIO)
-			__filemap_fdatawait_range(mapping, lstart, lend);
-	}
-	err2 = filemap_check_errors(mapping);
+	since = filemap_sample_wb_err(mapping);
+	err = __filemap_fdatawrite_range(mapping, lstart, lend, WB_SYNC_ALL);
+	/*
+	 * Even if the above returned an error, the pages may be written
+	 * partially (e.g. -ENOSPC), so we wait for it.  But the -EIO
+	 * is a special case, it may indicate the worst thing (e.g. bug)
+	 * happened, so we avoid waiting for it.
+	 */
+	if (err != -EIO)
+		__filemap_fdatawait_range(mapping, lstart, lend);
 	if (!err)
-		err = err2;
+		err = filemap_check_wb_err(mapping, since);
+
 	return err;
 }
 EXPORT_SYMBOL(filemap_write_and_wait_range);
-- 
2.35.1

