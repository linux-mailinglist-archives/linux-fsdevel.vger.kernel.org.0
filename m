Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2F07B85D4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 18:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243494AbjJDQxj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 12:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243532AbjJDQxc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:53:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65131FD;
        Wed,  4 Oct 2023 09:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ZWM/c0Bk7RP+LkIKV16/78R+lD44jh4KeYNE9FiQZ2g=; b=Aw3Cl2LAeVVsVTuLeNEwUq/VbA
        l81BMeA2S58v2J8f3iduduSKLq5Ymwo3HIDSHj2xkuXTosEziXIyE7ACXOdvHQWhHUd3P5J71NIMO
        xiGvXkUZP2C5I4rHffcnPBy9wVyXH5wXIZdFqV71NZtCtdtjIuNk9thk4UFfUpvE6etPONmOfwN65
        zUosIjQElESczPZGIu2xynSiayxES/+8eLUaYJB0EYwYG+1frJmEMX9TeHHTFefunADL5TbmnR0R7
        z5BWvZCFdQrRwZ+tua2GqBnj6E6lKbFUQ4tb4uEvGCnNpj3U9Ak8FHSTiKJeKeCNZlSrGLW0rM3HE
        66+mylQw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qo57f-004SF0-Da; Wed, 04 Oct 2023 16:53:19 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, torvalds@linux-foundation.org,
        npiggin@gmail.com
Subject: [PATCH v2 04/17] ext4: Use folio_end_read()
Date:   Wed,  4 Oct 2023 17:53:04 +0100
Message-Id: <20231004165317.1061855-5-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231004165317.1061855-1-willy@infradead.org>
References: <20231004165317.1061855-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

folio_end_read() is the perfect fit for ext4.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/readpage.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
index 3e7d160f543f..21e8f0aebb3c 100644
--- a/fs/ext4/readpage.c
+++ b/fs/ext4/readpage.c
@@ -70,15 +70,8 @@ static void __read_end_io(struct bio *bio)
 {
 	struct folio_iter fi;
 
-	bio_for_each_folio_all(fi, bio) {
-		struct folio *folio = fi.folio;
-
-		if (bio->bi_status)
-			folio_clear_uptodate(folio);
-		else
-			folio_mark_uptodate(folio);
-		folio_unlock(folio);
-	}
+	bio_for_each_folio_all(fi, bio)
+		folio_end_read(fi.folio, bio->bi_status == 0);
 	if (bio->bi_private)
 		mempool_free(bio->bi_private, bio_post_read_ctx_pool);
 	bio_put(bio);
@@ -336,8 +329,7 @@ int ext4_mpage_readpages(struct inode *inode,
 				if (ext4_need_verity(inode, folio->index) &&
 				    !fsverity_verify_folio(folio))
 					goto set_error_page;
-				folio_mark_uptodate(folio);
-				folio_unlock(folio);
+				folio_end_read(folio, true);
 				continue;
 			}
 		} else if (fully_mapped) {
-- 
2.40.1

