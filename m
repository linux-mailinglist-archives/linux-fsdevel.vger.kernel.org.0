Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B9B5151D6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 19:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379612AbiD2R3b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 13:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377195AbiD2R3Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:29:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55FF986D9
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 10:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ha8ebKgRGxtayEYqUXJ+XYzoZ7W6fZr5XiakkCOM3DA=; b=OaXJ2LSwFsfEqRUeCbaot+K7Ng
        8G4ErGJ+dNymu62YwVsE+mjV/jT4G/hF4J+u729lvWdDHAmweHf5vI9rS5z6uxR58B3L1LpfdQRpb
        2bQGSbbxq5CBCvk7Zk/miFidUlANFv7DXeBtuB8LoicH6H60+CYrU+pT8BVdcckpqoViZviZ2d6xy
        4+z8Mb8+1heTQx6FVwJYrxTbNyplX+APtE2bCvbN/9rMOdDi9BCaHNRgNul3Mpd2hn/i5sf2x92a4
        dc1tIyFJuXL8xWUgkkd+2BRvF1093Q4MnzcEvbACbSBeO4XfRNHX+GjBDFnZZBAIWwsi7urC2TNoH
        70nri9Eg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkUNX-00CdXf-1D; Fri, 29 Apr 2022 17:26:03 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 10/69] fs: Remove AOP_FLAG_NOFS
Date:   Fri, 29 Apr 2022 18:24:57 +0100
Message-Id: <20220429172556.3011843-11-willy@infradead.org>
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

