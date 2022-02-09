Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA804AFE2F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 21:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbiBIUWc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 15:22:32 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbiBIUWX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:22:23 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9CBE040C8D
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 12:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=HF9ECbktFFKlSJ23iiBMfzV6AiY73hTRqLYxZkzOm+0=; b=ndV40fmAXQGHVXu3oydmfKWxl2
        ErGHsbM9Bm0ohbL/mEBojRsC4IDPXO6qPqOJNQHonUbMWZTp1n2NcFJR7no5Rdkr7Ow3frRWE9VnD
        ZMiOzCMDWWkOKKeW0Y3u0gpMWBnIFQItuMO5qscJ9cLGASp9DWIeATuBUyB1sfCRYcBIGYyC9/ZzW
        lI+s2o2Jwf15yYzsTJECit9WmVH3qaSptkyCaYUl/Iod7DOZcoyTU07YA8OnlKTRi75R4KMjBzqqD
        p1O83ytSiy/viQsBBekE7lB8/dFQQUWhssLrPN7IpJT8FhOetYM8uy/dmEVhn12EfFMh0YjDd4+LY
        cMdzvH7g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHtTs-008cpo-4f; Wed, 09 Feb 2022 20:22:24 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 12/56] ext4: Use folio_invalidate()
Date:   Wed,  9 Feb 2022 20:21:31 +0000
Message-Id: <20220209202215.2055748-13-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220209202215.2055748-1-willy@infradead.org>
References: <20220209202215.2055748-1-willy@infradead.org>
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

Instead of calling ->invalidatepage directly, use folio_invalidate().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/inode.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 01c9e4f743ba..57800ecbe466 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1971,6 +1971,7 @@ static int __ext4_journalled_writepage(struct page *page,
 static int ext4_writepage(struct page *page,
 			  struct writeback_control *wbc)
 {
+	struct folio *folio = page_folio(page);
 	int ret = 0;
 	loff_t size;
 	unsigned int len;
@@ -1980,8 +1981,8 @@ static int ext4_writepage(struct page *page,
 	bool keep_towrite = false;
 
 	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb)))) {
-		inode->i_mapping->a_ops->invalidatepage(page, 0, PAGE_SIZE);
-		unlock_page(page);
+		folio_invalidate(folio, 0, folio_size(folio));
+		folio_unlock(folio);
 		return -EIO;
 	}
 
-- 
2.34.1

