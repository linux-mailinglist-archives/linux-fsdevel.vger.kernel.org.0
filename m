Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 673EA51F13C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbiEHUeE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbiEHUdv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:33:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340FEDFFD
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ha8ebKgRGxtayEYqUXJ+XYzoZ7W6fZr5XiakkCOM3DA=; b=rgZsGj3HLxHX//6HnBmQnyAW+k
        aPjKaBMNlDvEndL+NR1BXhxO58BrQiTyzn4y/VYeGIsAjU2f/YdrtmsHtqFz29+XlPbCklSRiDxm9
        HIm0w3zUxxMLCRNXaPBFaX4pYg7ljwq/HiJRXQmoFT54C3o523P7VICLUOa+yFjkSVuatKPrcxz5T
        d0INecJe5ZWW2An7EfoRsRa94RTf6Kox/bJlQDsJSSw9qQGEOYoqfQYBDHTBmI/+pGGeYwLvWN1h5
        sfElQk/DF604OGUP9YR0sRTLeVtJ4qmo4f8Fo37gSW+VUiH6okwESf9H7s4bGMb7QmIdOJcLAUyS8
        EsNbObLg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnXS-002nYK-I1; Sun, 08 May 2022 20:29:58 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 09/25] fs: Remove AOP_FLAG_NOFS
Date:   Sun,  8 May 2022 21:29:25 +0100
Message-Id: <20220508202941.667024-10-willy@infradead.org>
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

With all users of this flag gone, we can stop testing whether it's set.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/netfs/buffered_read.c | 6 +-----
 include/linux/fs.h       | 4 ----
 mm/folio-compat.c        | 2 --
 3 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 281a88a5b8dc..65c17c5a5567 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -302,7 +302,6 @@ static bool netfs_skip_folio_read(struct folio *folio, loff_t pos, size_t len,
  * @mapping: The mapping to read from
  * @pos: File position at which the write will begin
  * @len: The length of the write (may extend beyond the end of the folio chosen)
- * @aop_flags: AOP_* flags
  * @_folio: Where to put the resultant folio
  * @_fsdata: Place for the netfs to store a cookie
  *
@@ -335,16 +334,13 @@ int netfs_write_begin(struct file *file, struct address_space *mapping,
 	struct netfs_io_request *rreq;
 	struct netfs_i_context *ctx = netfs_i_context(file_inode(file ));
 	struct folio *folio;
-	unsigned int fgp_flags;
+	unsigned int fgp_flags = FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE;
 	pgoff_t index = pos >> PAGE_SHIFT;
 	int ret;
 
 	DEFINE_READAHEAD(ractl, file, NULL, mapping, index);
 
 retry:
-	fgp_flags = FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE;
-	if (aop_flags & AOP_FLAG_NOFS)
-		fgp_flags |= FGP_NOFS;
 	folio = __filemap_get_folio(mapping, index, fgp_flags,
 				    mapping_gfp_mask(mapping));
 	if (!folio)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e108aff23a28..f81bc5cbcbb6 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -275,10 +275,6 @@ enum positive_aop_returns {
 	AOP_TRUNCATED_PAGE	= 0x80001,
 };
 
-#define AOP_FLAG_NOFS			0x0002 /* used by filesystem to direct
-						* helper code (eg buffer layer)
-						* to clear GFP_FS from alloc */
-
 /*
  * oh the beauties of C type declarations.
  */
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index 46fa179e32fb..3e42ddb81918 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -135,8 +135,6 @@ struct page *grab_cache_page_write_begin(struct address_space *mapping,
 {
 	unsigned fgp_flags = FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE;
 
-	if (flags & AOP_FLAG_NOFS)
-		fgp_flags |= FGP_NOFS;
 	return pagecache_get_page(mapping, index, fgp_flags,
 			mapping_gfp_mask(mapping));
 }
-- 
2.34.1

