Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B589516A8C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 May 2022 07:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383382AbiEBGAl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 May 2022 02:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383406AbiEBGA1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 May 2022 02:00:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8211FA5D
        for <linux-fsdevel@vger.kernel.org>; Sun,  1 May 2022 22:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=WThcIuILzYXjRyQ6Q47PU+2U9iL1M+RIGUvQ2azAxZI=; b=c2pqzvzVK367eWc3c+k3+CVa5I
        Qpc7tKelQs3Ab6OD63vIIb5XgnRvPve395CALBV2rQIYCPClZ3wXTrxvFYwb77r1NSkd8Du88vPwW
        MuiuiX7DeQvnzbMqZOk5eNcd/w3JEQS1aubb3Ni0JlOKFs3L7NJsIKxu5/Zzm/KhY/B0F/DlyN7o0
        XcXTL01+iSRK6mh60mkBTtYtLdL3gFbEl2f5aVSRh+kN9e/4OYx/1NSSWLTkecjyBFwoWO5v2vI4/
        q2Fu1g2/j4IsGxZEUJfz0nXoZUuWKmMuzhVjw81ev9CZ9nNz4aNgOW5rJxTsErcIKUphJ823WgMrh
        +NCvaMVg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nlP2h-00EZX4-MS; Mon, 02 May 2022 05:56:19 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 21/26] fs: Remove last vestiges of releasepage
Date:   Mon,  2 May 2022 06:56:09 +0100
Message-Id: <20220502055614.3473032-22-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220502055614.3473032-1-willy@infradead.org>
References: <20220502055614.3473032-1-willy@infradead.org>
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

All users are now converted to release_folio

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/fs.h         | 1 -
 include/linux/page-flags.h | 2 +-
 mm/filemap.c               | 2 --
 3 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index ad768f13f485..1cee64d9724b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -356,7 +356,6 @@ struct address_space_operations {
 	sector_t (*bmap)(struct address_space *, sector_t);
 	void (*invalidate_folio) (struct folio *, size_t offset, size_t len);
 	bool (*release_folio)(struct folio *, gfp_t);
-	int (*releasepage) (struct page *, gfp_t);
 	void (*freepage)(struct page *);
 	ssize_t (*direct_IO)(struct kiocb *, struct iov_iter *iter);
 	/*
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 9d8eeaa67d05..af10149a6c31 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -516,7 +516,7 @@ PAGEFLAG(SwapBacked, swapbacked, PF_NO_TAIL)
 /*
  * Private page markings that may be used by the filesystem that owns the page
  * for its own purposes.
- * - PG_private and PG_private_2 cause releasepage() and co to be invoked
+ * - PG_private and PG_private_2 cause release_folio() and co to be invoked
  */
 PAGEFLAG(Private, private, PF_ANY)
 PAGEFLAG(Private2, private_2, PF_ANY) TESTSCFLAG(Private2, private_2, PF_ANY)
diff --git a/mm/filemap.c b/mm/filemap.c
index 40df5704ec39..7d55bb53bff7 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3958,8 +3958,6 @@ bool filemap_release_folio(struct folio *folio, gfp_t gfp)
 
 	if (mapping && mapping->a_ops->release_folio)
 		return mapping->a_ops->release_folio(folio, gfp);
-	if (mapping && mapping->a_ops->releasepage)
-		return mapping->a_ops->releasepage(&folio->page, gfp);
 	return try_to_free_buffers(&folio->page);
 }
 EXPORT_SYMBOL(filemap_release_folio);
-- 
2.34.1

