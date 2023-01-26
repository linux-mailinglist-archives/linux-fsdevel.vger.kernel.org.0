Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5082867D63F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 21:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbjAZUYj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 15:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbjAZUYZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 15:24:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323E54B8AE;
        Thu, 26 Jan 2023 12:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=5mlgMvqIZNbmGESykCx2U0lIh2Wy+L5n/rR+hSRI+8s=; b=LSzJbp6OyUeJ93wtuiU4gMcyXR
        tGIzw19LOzJiZaBL6g+gu4Rw2Aw7sX5kElrC+XGgX9dHtCsCYu2+sxgxCZ8lYedz+USEOcKJN4Jwz
        1a/Em/KZS0Vkojb7JW/Hj/5GRdzZfztp1kYZ3SeB4EKf/fmqtidkrnE+nolxMPKamx1gvIGU2oOSD
        +pP46HjPh7oMcm597CxdGAcw2DoMb7TQKhxJMYuv7+AkNF7aNW2Qxk8/caIc4F2tFDyjyUd0ikONB
        uXfoA2B7TEncsavlLKB0izTS4+ATjG2wacl3RILTTLMNh3XjiYdcYppIzv9cqPxqk9n7fCQUaGKqi
        CTVUgMXw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pL8nF-0073le-Fv; Thu, 26 Jan 2023 20:24:21 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Theodore Tso" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 26/31] ext4: Convert ext4_writepage() to take a folio
Date:   Thu, 26 Jan 2023 20:24:10 +0000
Message-Id: <20230126202415.1682629-27-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230126202415.1682629-1-willy@infradead.org>
References: <20230126202415.1682629-1-willy@infradead.org>
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

Its one caller already has a folio.  Saves a call to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/inode.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 507c7f88d737..9bcf7459a0c0 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2015,10 +2015,9 @@ static int __ext4_journalled_writepage(struct folio *folio,
  * But since we don't do any block allocation we should not deadlock.
  * Page also have the dirty flag cleared so we don't get recurive page_lock.
  */
-static int ext4_writepage(struct page *page,
+static int ext4_writepage(struct folio *folio,
 			  struct writeback_control *wbc)
 {
-	struct folio *folio = page_folio(page);
 	int ret = 0;
 	loff_t size;
 	size_t len;
@@ -2032,7 +2031,7 @@ static int ext4_writepage(struct page *page,
 		return -EIO;
 	}
 
-	trace_ext4_writepage(page);
+	trace_ext4_writepage(&folio->page);
 	size = i_size_read(inode);
 	len = folio_size(folio);
 	if (folio_pos(folio) + len > size &&
@@ -2719,7 +2718,7 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 static int ext4_writepage_cb(struct folio *folio, struct writeback_control *wbc,
 			     void *data)
 {
-	return ext4_writepage(&folio->page, wbc);
+	return ext4_writepage(folio, wbc);
 }
 
 static int ext4_do_writepages(struct mpage_da_data *mpd)
-- 
2.35.1

