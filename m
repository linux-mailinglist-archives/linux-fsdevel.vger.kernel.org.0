Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1FD7A2650
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 20:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236770AbjIOSml (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 14:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236981AbjIOSmS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 14:42:18 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A324695;
        Fri, 15 Sep 2023 11:40:54 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4RnNJt60W1z9sTy;
        Fri, 15 Sep 2023 20:39:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
        s=MBO0001; t=1694803182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LywLEuPyM84LvnszU9bu3yYyFXSjfbQxmSaZo0Anuqo=;
        b=sPBj7+lPJjN1O52TPN3bPIvCgfHWewlpa4lD2gPArpjJc42qjZjYB0ivxNzVoPtgWUV2X9
        baXqoaVEy427TKtHRyh9CuvB1dGk4UoKPWdumhCVK/Zj7hjnyV/9B5lvcIJez7O/RYML7a
        7BbpTXkSIEysivDSIn8uG2RYC8Ka8TO0B9P19XqbBg8Pj8JfaNqqdtPoeNMsD2lb4sD0eY
        cFRHPxdkrbiSJb37sUgM291kELuaAdt9gvlmR97ZVvHYeejas3FF4Zlhd05N2OYrwNWsrp
        2xibhXY+ahHHlr/15+T/ltQEQlsnkfS5en8VhTucFA1GfYp0wjO7bbHAmSHM9Q==
From:   Pankaj Raghav <kernel@pankajraghav.com>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     p.raghav@samsung.com, david@fromorbit.com, da.gomez@samsung.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        willy@infradead.org, djwong@kernel.org, linux-mm@kvack.org,
        chandan.babu@oracle.com, mcgrof@kernel.org, gost.dev@samsung.com
Subject: [RFC 18/23] readahead: align ra start and size to mapping_min_order in ondemand_ra()
Date:   Fri, 15 Sep 2023 20:38:43 +0200
Message-Id: <20230915183848.1018717-19-kernel@pankajraghav.com>
In-Reply-To: <20230915183848.1018717-1-kernel@pankajraghav.com>
References: <20230915183848.1018717-1-kernel@pankajraghav.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4RnNJt60W1z9sTy
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Luis Chamberlain <mcgrof@kernel.org>

Align the ra->start and ra->size to mapping_min_order in
ondemand_readahead(). This will ensure the folios added to the
page_cache will be aligned to mapping_min_order number of pages.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 mm/readahead.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 7c2660815a01..03fa6f6c8145 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -605,7 +605,11 @@ static void ondemand_readahead(struct readahead_control *ractl,
 	unsigned long add_pages;
 	pgoff_t index = readahead_index(ractl);
 	pgoff_t expected, prev_index;
-	unsigned int order = folio ? folio_order(folio) : 0;
+	unsigned int min_order = mapping_min_folio_order(ractl->mapping);
+	unsigned int min_nrpages = 1UL << min_order;
+	unsigned int order = folio ? folio_order(folio) : min_order;
+
+	VM_BUG_ON(ractl->_index & (min_nrpages - 1));
 
 	/*
 	 * If the request exceeds the readahead window, allow the read to
@@ -627,9 +631,13 @@ static void ondemand_readahead(struct readahead_control *ractl,
 	expected = round_up(ra->start + ra->size - ra->async_size,
 			1UL << order);
 	if (index == expected || index == (ra->start + ra->size)) {
-		ra->start += ra->size;
-		ra->size = get_next_ra_size(ra, max_pages);
+		ra->start += round_down(ra->size, min_nrpages);
+		ra->size = get_next_ra_size(ra, min_order, max_pages);
 		ra->async_size = ra->size;
+
+		VM_BUG_ON(ra->size & ((1UL << min_order) - 1));
+		VM_BUG_ON(ra->start & ((1UL << min_order) - 1));
+
 		goto readit;
 	}
 
@@ -647,13 +655,19 @@ static void ondemand_readahead(struct readahead_control *ractl,
 				max_pages);
 		rcu_read_unlock();
 
+		start = round_down(start, min_nrpages);
+
+		VM_BUG_ON(start & (min_nrpages - 1));
+		VM_BUG_ON(folio->index & (folio_nr_pages(folio) - 1));
+
 		if (!start || start - index > max_pages)
 			return;
 
 		ra->start = start;
 		ra->size = start - index;	/* old async_size */
-		ra->size += req_size;
-		ra->size = get_next_ra_size(ra, max_pages);
+		VM_BUG_ON(ra->size & (min_nrpages - 1));
+		ra->size += round_up(req_size, min_nrpages);
+		ra->size = get_next_ra_size(ra, min_order, max_pages);
 		ra->async_size = ra->size;
 		goto readit;
 	}
@@ -690,7 +704,7 @@ static void ondemand_readahead(struct readahead_control *ractl,
 
 initial_readahead:
 	ra->start = index;
-	ra->size = get_init_ra_size(req_size, max_pages);
+	ra->size = get_init_ra_size(req_size, min_order, max_pages);
 	ra->async_size = ra->size > req_size ? ra->size - req_size : ra->size;
 
 readit:
@@ -701,7 +715,7 @@ static void ondemand_readahead(struct readahead_control *ractl,
 	 * Take care of maximum IO pages as above.
 	 */
 	if (index == ra->start && ra->size == ra->async_size) {
-		add_pages = get_next_ra_size(ra, max_pages);
+		add_pages = get_next_ra_size(ra, min_order, max_pages);
 		if (ra->size + add_pages <= max_pages) {
 			ra->async_size = add_pages;
 			ra->size += add_pages;
@@ -712,6 +726,7 @@ static void ondemand_readahead(struct readahead_control *ractl,
 	}
 
 	ractl->_index = ra->start;
+	VM_BUG_ON(ractl->_index & (min_nrpages - 1));
 	page_cache_ra_order(ractl, ra, order);
 }
 
-- 
2.40.1

