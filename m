Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286E252DDE9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 21:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244092AbiESTop (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 15:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240779AbiESToo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 15:44:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822E9BC6FC
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 May 2022 12:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=lsqGn3eyK2DrcqkGnGxhUNX0KbccC55iqHUDsH+ISxQ=; b=m3krLVnnv6dE0c0ZuTMUF3caxM
        yHZVlcnaml88CSGkYPGUYgSQL6o7KbXO+kHJRWnrwNqoa7ukkg4o8k7UwqHfcuIFjRHMs9VRznhjF
        faiVC4q71JfZLFRVTefy9vnjG8Neqco1uDPDMlF1VvZ6I716ZUveWQKwCluJQNy1AMmba48qpJ2Vw
        a/6TLzbnRRmk1npTlySlFXRrcmcSHxLaNc24axP9tLlzjvRMUdeIvJbJ0CN54FhjyOKlfClafkxV4
        dsAwwiIAZHJvAf1mmRePQ5XJJ9ergenfPddR/qJpidQzJ4+MWNNpJ0uJp2cNDWsly/GispnHCNSIl
        Krfq+OhQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrm4a-00D3FG-Ea; Thu, 19 May 2022 19:44:36 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH] jfs: Release even dirty metapages on invalidate
Date:   Thu, 19 May 2022 20:44:35 +0100
Message-Id: <20220519194435.3110635-1-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
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

This isn't going to apply to your tree; it will apply to today's -next
though.  Happy to take this on top of my current pagecache patch set
with appropriate acks.  Maybe it's the wrong fix; I haven't spent very
long trying to understand what all the parts of mp mean ... maybe it
should only override the META_Dirty check and it needs to do something
else for the other two checks?

--- 8< ---

For ->release_folio(), we can fail to release the metapage if, for
example, it's dirty.  For ->invalidate_folio(), we must release the
metapage as the page is being removed and will be freed.  Failing to
release the metapage results in xfstests generic/537 hitting BUG reports
like this:

BUG: Bad page state in process umount  pfn:12b03a
page:000000000c3e2db5 refcount:0 mapcount:0 mapping:0000000000000000 index:0x10 pfn:0x12b03a
flags: 0x8000000000002004(uptodate|private|zone=2)
raw: 8000000000002004 ffffea000417a5c8 ffff88810a41bbe0 0000000000000000
raw: 0000000000000010 ffff888124e12680 00000000ffffffff 0000000000000000
page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set

as the page allocator checks that the page no longer has private data.

Add a bool argument to inform the release routine whether to override
the checks and release the metapage anyway.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/jfs/jfs_metapage.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
index 2e8461ce74de..5b4f0cd8d276 100644
--- a/fs/jfs/jfs_metapage.c
+++ b/fs/jfs/jfs_metapage.c
@@ -524,7 +524,8 @@ static int metapage_read_folio(struct file *fp, struct folio *folio)
 	return -EIO;
 }
 
-static bool metapage_release_folio(struct folio *folio, gfp_t gfp_mask)
+static bool __metapage_release_folio(struct folio *folio, gfp_t gfp_mask,
+		bool force)
 {
 	struct metapage *mp;
 	bool ret = true;
@@ -537,8 +538,9 @@ static bool metapage_release_folio(struct folio *folio, gfp_t gfp_mask)
 			continue;
 
 		jfs_info("metapage_release_folio: mp = 0x%p", mp);
-		if (mp->count || mp->nohomeok ||
-		    test_bit(META_dirty, &mp->flag)) {
+		if (!force &&
+		    (mp->count || mp->nohomeok ||
+		     test_bit(META_dirty, &mp->flag))) {
 			jfs_info("count = %ld, nohomeok = %d", mp->count,
 				 mp->nohomeok);
 			ret = false;
@@ -553,6 +555,11 @@ static bool metapage_release_folio(struct folio *folio, gfp_t gfp_mask)
 	return ret;
 }
 
+static bool metapage_release_folio(struct folio *folio, gfp_t gfp)
+{
+	return __metapage_release_folio(folio, gfp, false);
+}
+
 static void metapage_invalidate_folio(struct folio *folio, size_t offset,
 				    size_t length)
 {
@@ -560,7 +567,7 @@ static void metapage_invalidate_folio(struct folio *folio, size_t offset,
 
 	BUG_ON(folio_test_writeback(folio));
 
-	metapage_release_folio(folio, 0);
+	__metapage_release_folio(folio, 0, true);
 }
 
 const struct address_space_operations jfs_metapage_aops = {
-- 
2.34.1

