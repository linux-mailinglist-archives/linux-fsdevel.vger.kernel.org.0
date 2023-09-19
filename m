Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4027A58FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 06:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbjISExH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 00:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbjISEwc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 00:52:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89397102;
        Mon, 18 Sep 2023 21:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=9fxuIUmv0rn3plQF4/og445RxsuZjG3jMIUqfxIahw8=; b=BFaYsLdAmE7gx/PdwTImssQtTC
        R3BHPO08LdZ/3NOe3UnaYNyA5T+h74fBjO/dQ3DQ2k2mvGCXpO6sCdOlRDFkW2rFPLvhGxcX1cejV
        8va1HkPghMIs3g1aqcQFF22ZBkJbCakeV2qQxnwJIXoW3E8R/v87B6ybyvhgM12J+uc2R/wOoDC60
        uwar+aEergefltYvlguaRjvNidrrTrwg6LA0c68y51IHET1tQV2kWWuc586cGqR40fCw5WeFVQyYn
        QsEm7H89GPpjrRvgk67mJJYnXcqi3vp9+B/jLtlZCgtQ0/fRK38kc7800mNwfT5ZBAlnb2Rez3fwZ
        4FzLFRJg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qiSi2-00FFkJ-6R; Tue, 19 Sep 2023 04:51:38 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
        linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
        reiserfs-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 02/26] mpage: Convert map_buffer_to_folio() to folio_create_empty_buffers()
Date:   Tue, 19 Sep 2023 05:51:11 +0100
Message-Id: <20230919045135.3635437-3-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230919045135.3635437-1-willy@infradead.org>
References: <20230919045135.3635437-1-willy@infradead.org>
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

Saves a folio->page->folio conversion.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/mpage.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/mpage.c b/fs/mpage.c
index 242e213ee064..964a6efe594d 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -119,8 +119,7 @@ static void map_buffer_to_folio(struct folio *folio, struct buffer_head *bh,
 			folio_mark_uptodate(folio);
 			return;
 		}
-		create_empty_buffers(&folio->page, i_blocksize(inode), 0);
-		head = folio_buffers(folio);
+		head = folio_create_empty_buffers(folio, i_blocksize(inode), 0);
 	}
 
 	page_bh = head;
-- 
2.40.1

