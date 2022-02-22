Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113124C0253
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Feb 2022 20:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235301AbiBVTtE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Feb 2022 14:49:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235282AbiBVTs4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Feb 2022 14:48:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EC9B91CB
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Feb 2022 11:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=UvenU1U/B9rNQrri+7fhmzUQHmssqNc9MTSEhGn5COU=; b=Dt0t1FVokjx7GV2/hMZpSgyLUI
        EL/Yl31aS6VGyUc9o3vFVJkzFpueZ1uR2zo62LeV/eDAvqfeQk3/nXB4eZyjVc4bbxZaogRu+PghD
        0Z8Mdnr8XPh7xUu6ESqHdHO1b4MJdO+y20DChymjTb7uKG8wVGSUehM2aLf2av+g3JPVx2uJ8xJow
        qWjBKQistprFG9aqBRD70IwlScjgFQAynwSj9haRqPFuYVsjt0DOa4XWddHNTB6B2VY0AzWd56m+8
        OaYj4yLWiDSBYydRduxqAZCllWkgm8d2qeyIH23Qlu+cjB5VDTXwRwC/QvVkph3zYQ6F/rXnXx60w
        nujkAdDA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMb96-00360P-G9; Tue, 22 Feb 2022 19:48:24 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 13/22] fs: Remove AOP_FLAG_NOFS
Date:   Tue, 22 Feb 2022 19:48:11 +0000
Message-Id: <20220222194820.737755-14-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220222194820.737755-1-willy@infradead.org>
References: <20220222194820.737755-1-willy@infradead.org>
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
---
 fs/ceph/addr.c         | 2 --
 fs/netfs/read_helper.c | 2 --
 include/linux/fs.h     | 4 ----
 mm/folio-compat.c      | 2 --
 4 files changed, 10 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index f40c34f4f526..3a2b98efebf5 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1288,8 +1288,6 @@ static int ceph_write_begin(struct file *file, struct address_space *mapping,
 	 */
 	if (ci->i_inline_version != CEPH_INLINE_NONE) {
 		unsigned int fgp_flags = FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE;
-		if (aop_flags & AOP_FLAG_NOFS)
-			fgp_flags |= FGP_NOFS;
 		folio = __filemap_get_folio(mapping, index, fgp_flags,
 					    mapping_gfp_mask(mapping));
 		if (!folio)
diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
index 501da990c259..de0dfb37746b 100644
--- a/fs/netfs/read_helper.c
+++ b/fs/netfs/read_helper.c
@@ -1090,8 +1090,6 @@ int netfs_write_begin(struct file *file, struct address_space *mapping,
 
 retry:
 	fgp_flags = FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE;
-	if (aop_flags & AOP_FLAG_NOFS)
-		fgp_flags |= FGP_NOFS;
 	folio = __filemap_get_folio(mapping, index, fgp_flags,
 				    mapping_gfp_mask(mapping));
 	if (!folio)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 4db0893750aa..bdbf5dcdb272 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -274,10 +274,6 @@ enum positive_aop_returns {
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
index 749555a232a8..540c4949e9a1 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -134,8 +134,6 @@ struct page *grab_cache_page_write_begin(struct address_space *mapping,
 {
 	unsigned fgp_flags = FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE;
 
-	if (flags & AOP_FLAG_NOFS)
-		fgp_flags |= FGP_NOFS;
 	return pagecache_get_page(mapping, index, fgp_flags,
 			mapping_gfp_mask(mapping));
 }
-- 
2.34.1

