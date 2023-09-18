Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEB87A47DF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 13:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241235AbjIRLF6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 07:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235741AbjIRLF0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 07:05:26 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E122101;
        Mon, 18 Sep 2023 04:05:19 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 814BD1FE00;
        Mon, 18 Sep 2023 11:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1695035117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zOEpzxJooswozjT85Ui4aOBC3IjFJwXMatMEtlRVlTE=;
        b=rYAqHJnVkJwB51wZE49UY0JLIbmEbebfQPosKcEIQPnT9C7oTK+ewb1dKjwyIpbvHBDAn1
        YdrFtwlyK+k3TI9hE5R8DAq30TRJEDIwHr8/JQzIiFeVxqxAIUHUPu1EuPxTsMI++q/PmN
        gfgVes7FcHkjUaERvIJsXT3SJtJ9qkI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1695035117;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zOEpzxJooswozjT85Ui4aOBC3IjFJwXMatMEtlRVlTE=;
        b=QCrgXxXzcqU5sBvHxJolByfPw9kozqKuDFDd0aVs49tOeIhHZVn/cxrmUlfCTBny1Y/uy9
        TJhtZSrw0dt1dMDw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 670712C15C;
        Mon, 18 Sep 2023 11:05:17 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 5C0F851CD159; Mon, 18 Sep 2023 13:05:17 +0200 (CEST)
From:   Hannes Reinecke <hare@suse.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Pankaj Raghav <p.raghav@samsung.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 14/18] brd: use memcpy_{to,from}_folio()
Date:   Mon, 18 Sep 2023 13:05:06 +0200
Message-Id: <20230918110510.66470-15-hare@suse.de>
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

Simplify copy routines by using memcpy_to_folio()/memcpy_from_folio().

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/block/brd.c | 39 ++++-----------------------------------
 1 file changed, 4 insertions(+), 35 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index d6595b1a22e8..90e1b6c4fbc8 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -163,7 +163,6 @@ static void copy_to_brd(struct brd_device *brd, const void *src,
 			sector_t sector, size_t n)
 {
 	struct folio *folio;
-	void *dst;
 	unsigned int rd_sector_size = PAGE_SIZE;
 	unsigned int offset = brd_sector_offset(brd, sector);
 	size_t copy;
@@ -172,21 +171,7 @@ static void copy_to_brd(struct brd_device *brd, const void *src,
 	folio = brd_lookup_folio(brd, sector);
 	BUG_ON(!folio);
 
-	dst = kmap_local_folio(folio, offset);
-	memcpy(dst, src, copy);
-	kunmap_local(dst);
-
-	if (copy < n) {
-		src += copy;
-		sector += copy >> SECTOR_SHIFT;
-		copy = n - copy;
-		folio = brd_lookup_folio(brd, sector);
-		BUG_ON(!folio);
-
-		dst = kmap_local_folio(folio, 0);
-		memcpy(dst, src, copy);
-		kunmap_local(dst);
-	}
+	memcpy_to_folio(folio, offset, src, copy);
 }
 
 /*
@@ -196,32 +181,16 @@ static void copy_from_brd(void *dst, struct brd_device *brd,
 			sector_t sector, size_t n)
 {
 	struct folio *folio;
-	void *src;
 	unsigned int rd_sector_size = PAGE_SIZE;
 	unsigned int offset = brd_sector_offset(brd, sector);
 	size_t copy;
 
 	copy = min_t(size_t, n, rd_sector_size - offset);
 	folio = brd_lookup_folio(brd, sector);
-	if (folio) {
-		src = kmap_local_folio(folio, offset);
-		memcpy(dst, src, copy);
-		kunmap_local(src);
-	} else
+	if (folio)
+		memcpy_from_folio(dst, folio, offset, copy);
+	else
 		memset(dst, 0, copy);
-
-	if (copy < n) {
-		dst += copy;
-		sector += copy >> SECTOR_SHIFT;
-		copy = n - copy;
-		folio = brd_lookup_folio(brd, sector);
-		if (folio) {
-			src = kmap_local_folio(folio, 0);
-			memcpy(dst, src, copy);
-			kunmap_local(src);
-		} else
-			memset(dst, 0, copy);
-	}
 }
 
 /*
-- 
2.35.3

