Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95F57A47CF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 13:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239151AbjIRLFw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 07:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbjIRLFY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 07:05:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B06C3;
        Mon, 18 Sep 2023 04:05:18 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6F10321AAD;
        Mon, 18 Sep 2023 11:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1695035117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KWAyNqeHPBaQf4arjiE4/hRGo9wqjgCUyjPtyne5gYU=;
        b=WK6HshtwytK408unLa4mLWjYwBxhCZof6DdLQTgZ4AI/XaZWm46GdBKQZEQhUun+bTWOMq
        zDyElD/cOxaztc7PuC7to8biBd9xz+hji12mH1PWnb7m+WgdYaMbrzqabhSLucUleZGedS
        xqBahdCO6Lp/uSpQXdxtjMq61SksZDg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1695035117;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KWAyNqeHPBaQf4arjiE4/hRGo9wqjgCUyjPtyne5gYU=;
        b=MiKmQv4b8JyQ48UMYHZHdCOWKmcq6/cHLqwZN1mnyA7ApnQDVGpjIC5NlM/v7CzkwPNajE
        X1Yag6fVltG9tsDQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id DC7102C143;
        Mon, 18 Sep 2023 11:05:16 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id E5DCB51CD13F; Mon, 18 Sep 2023 13:05:16 +0200 (CEST)
From:   Hannes Reinecke <hare@suse.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Pankaj Raghav <p.raghav@samsung.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 01/18] mm/readahead: rework loop in page_cache_ra_unbounded()
Date:   Mon, 18 Sep 2023 13:04:53 +0200
Message-Id: <20230918110510.66470-2-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230918110510.66470-1-hare@suse.de>
References: <20230918110510.66470-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rework the loop in page_cache_ra_unbounded() to advance with
the number of pages in a folio instead of just one page at a time.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 mm/readahead.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index e815c114de21..40a5f1f65281 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -208,7 +208,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 	struct address_space *mapping = ractl->mapping;
 	unsigned long index = readahead_index(ractl);
 	gfp_t gfp_mask = readahead_gfp_mask(mapping);
-	unsigned long i;
+	unsigned long i = 0;
 
 	/*
 	 * Partway through the readahead operation, we will have added
@@ -226,7 +226,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 	/*
 	 * Preallocate as many pages as we will need.
 	 */
-	for (i = 0; i < nr_to_read; i++) {
+	do {
 		struct folio *folio = xa_load(&mapping->i_pages, index + i);
 
 		if (folio && !xa_is_value(folio)) {
@@ -239,8 +239,8 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 			 * not worth getting one just for that.
 			 */
 			read_pages(ractl);
-			ractl->_index++;
-			i = ractl->_index + ractl->_nr_pages - index - 1;
+			ractl->_index += folio_nr_pages(folio);
+			i = ractl->_index + ractl->_nr_pages - index;
 			continue;
 		}
 
@@ -251,15 +251,16 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 					gfp_mask) < 0) {
 			folio_put(folio);
 			read_pages(ractl);
-			ractl->_index++;
-			i = ractl->_index + ractl->_nr_pages - index - 1;
+			ractl->_index += folio_nr_pages(folio);
+			i = ractl->_index + ractl->_nr_pages - index;
 			continue;
 		}
 		if (i == nr_to_read - lookahead_size)
 			folio_set_readahead(folio);
 		ractl->_workingset |= folio_test_workingset(folio);
-		ractl->_nr_pages++;
-	}
+		ractl->_nr_pages += folio_nr_pages(folio);
+		i += folio_nr_pages(folio);
+	} while (i < nr_to_read);
 
 	/*
 	 * Now start the IO.  We ignore I/O errors - if the folio is not
-- 
2.35.3

