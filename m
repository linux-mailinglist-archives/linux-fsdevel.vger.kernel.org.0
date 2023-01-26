Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B3967D64A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 21:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232878AbjAZUYr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 15:24:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232814AbjAZUY1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 15:24:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABF64E530;
        Thu, 26 Jan 2023 12:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=WTuEV+v2QAuZHEKsjDbJY0gaIFuqsdJFbqMpvu3aCW8=; b=QXqIZC3Y51EOe4da4Sl4rQ4Sb4
        cIZC1FK2XCt18qJMJCKTfkVoF7f1us+Jl7tyl9GjJYXkm8UOhLbmoDs94hyhHX2r1eHcIV2bDQVD9
        cyCpiDzgTaxvRv++bPKE0vcJtJbi8ZZcurlH+aHJift91mwScRYtP49iItY5KppMR2NOaMJuNcegh
        uzA6bH0XRB6NPf92CkEPaXKz3HDiQcQcLAieO73+n4cwJ9rA1Fswlr/dwk/8LEw+5SwfVbhffBbRF
        OqZ30/6pjs06oRY+tZ0s223BBmaJh09hlSy7E4EPy3uQVg+0PH82pyNKGUXZLkiCiF0iQqvOEkBO2
        4uzBU5lw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pL8nG-0073mC-1t; Thu, 26 Jan 2023 20:24:22 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Theodore Tso" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 30/31] ext4: Convert pagecache_read() to use a folio
Date:   Thu, 26 Jan 2023 20:24:14 +0000
Message-Id: <20230126202415.1682629-31-willy@infradead.org>
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

Use the folio API and support folios of arbitrary sizes.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/verity.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
index e4da1704438e..afe847c967a4 100644
--- a/fs/ext4/verity.c
+++ b/fs/ext4/verity.c
@@ -42,18 +42,16 @@ static int pagecache_read(struct inode *inode, void *buf, size_t count,
 			  loff_t pos)
 {
 	while (count) {
-		size_t n = min_t(size_t, count,
-				 PAGE_SIZE - offset_in_page(pos));
-		struct page *page;
+		struct folio *folio;
+		size_t n;
 
-		page = read_mapping_page(inode->i_mapping, pos >> PAGE_SHIFT,
+		folio = read_mapping_folio(inode->i_mapping, pos >> PAGE_SHIFT,
 					 NULL);
-		if (IS_ERR(page))
-			return PTR_ERR(page);
-
-		memcpy_from_page(buf, page, offset_in_page(pos), n);
+		if (IS_ERR(folio))
+			return PTR_ERR(folio);
 
-		put_page(page);
+		n = memcpy_from_file_folio(buf, folio, pos, count);
+		folio_put(folio);
 
 		buf += n;
 		pos += n;
-- 
2.35.1

