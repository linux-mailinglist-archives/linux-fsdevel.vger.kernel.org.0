Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9856E7A264E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 20:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236896AbjIOSmh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 14:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237052AbjIOSma (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 14:42:30 -0400
X-Greylist: delayed 99 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 15 Sep 2023 11:40:57 PDT
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0F446B9;
        Fri, 15 Sep 2023 11:40:57 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4RnNK03XV2z9svg;
        Fri, 15 Sep 2023 20:39:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
        s=MBO0001; t=1694803188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZopmvSWX8ME3+zE0xLlLj6n28P2bDkBcY8o03Qh+UqI=;
        b=h0SxLgQv6vJA6JwNxNVopMuk8gFh3dpnTipX3yD3gI900/92roHKFWISKT5EJI3wjM9Naf
        H6yZ4HQEjxk5IdQCF6prjkl7lI5pXvtu9GxWSpa+Du9TtKgF+FqptplkTRnG+dhPZwnA8m
        Btc1TNZQOt5CE/68d1sxPOoODwEE9dFTEUkkoPr37EiTQ50/jRoHUZmNBHz1JHwYkE+OZE
        BPHSoI9PwJXlfPk9ZynUha6TZTNjWfrH4kJTDhHqX2Ktx+PHv9KPF8iwnD9wdArlP0aZmh
        jshWljg/ktY+MJi3EV7SfFTaY2P7wzKqkE3C2+QdFUD16Ip7mIXMcOKu/Exo3Q==
From:   Pankaj Raghav <kernel@pankajraghav.com>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     p.raghav@samsung.com, david@fromorbit.com, da.gomez@samsung.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        willy@infradead.org, djwong@kernel.org, linux-mm@kvack.org,
        chandan.babu@oracle.com, mcgrof@kernel.org, gost.dev@samsung.com
Subject: [RFC 20/23] mm: round down folio split requirements
Date:   Fri, 15 Sep 2023 20:38:45 +0200
Message-Id: <20230915183848.1018717-21-kernel@pankajraghav.com>
In-Reply-To: <20230915183848.1018717-1-kernel@pankajraghav.com>
References: <20230915183848.1018717-1-kernel@pankajraghav.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4RnNK03XV2z9svg
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Luis Chamberlain <mcgrof@kernel.org>

When we truncate we always check if we can split a large folio, we do
this by checking the userspace mapped pages match folio_nr_pages() - 1,
but if we are using a filesystem or a block device which has a min order
it must be respected and we should only split rounding down to the
min order page requirements.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 mm/huge_memory.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f899b3500419..e608a805c79f 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2617,16 +2617,24 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 bool can_split_folio(struct folio *folio, int *pextra_pins)
 {
 	int extra_pins;
+	unsigned int min_order = 0;
+	unsigned int nrpages;
 
 	/* Additional pins from page cache */
-	if (folio_test_anon(folio))
+	if (folio_test_anon(folio)) {
 		extra_pins = folio_test_swapcache(folio) ?
 				folio_nr_pages(folio) : 0;
-	else
+	} else {
 		extra_pins = folio_nr_pages(folio);
+		if (folio->mapping)
+			min_order = mapping_min_folio_order(folio->mapping);
+	}
+
+	nrpages = 1UL << min_order;
+
 	if (pextra_pins)
 		*pextra_pins = extra_pins;
-	return folio_mapcount(folio) == folio_ref_count(folio) - extra_pins - 1;
+	return folio_mapcount(folio) == folio_ref_count(folio) - extra_pins - nrpages;
 }
 
 /*
-- 
2.40.1

