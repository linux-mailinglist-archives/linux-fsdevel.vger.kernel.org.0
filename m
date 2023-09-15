Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869DE7A262A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 20:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236557AbjIOSla (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 14:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236807AbjIOSlG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 14:41:06 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050:0:465::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D679C44B6;
        Fri, 15 Sep 2023 11:39:04 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4RnNJ46BJgz9sVy;
        Fri, 15 Sep 2023 20:39:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
        s=MBO0001; t=1694803140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FLdOtec4vpzZfm3InvylkSWZf3/uIigm2EerkCxMy5w=;
        b=r+lyXdNhKhaZUDV6ta1NOOz4t9XIqBsPWGKdpL52UeGGpc0w2l1GrjQoagDyLq1XmHgALR
        g1EqfgXzxsfYSrEIgCmHV7nHfJUR65ZXBz1qPyVMU38LzQvwBAQfX8hG15HCbnG3RfUlUX
        iSsWS6wC7+rnNjpeSwf3O99fKY75M5jL78ggnhb2038nR0JjItKOOiGG6wCGGFRnuDZBUU
        NgPx6r4jz+JR36KDLUuFNvBWQsWENMcB0tcPeeRxQuUQ5ZEuJPrOFCuxxalzPD+24MFPdX
        zSeo8UqEgsrlR9EtOCgcPXonCPqSD7HdZB8KudYD6ZpQglZJPmDfFUMnntpKfw==
From:   Pankaj Raghav <kernel@pankajraghav.com>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     p.raghav@samsung.com, david@fromorbit.com, da.gomez@samsung.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        willy@infradead.org, djwong@kernel.org, linux-mm@kvack.org,
        chandan.babu@oracle.com, mcgrof@kernel.org, gost.dev@samsung.com
Subject: [RFC 03/23] filemap: add folio with at least mapping_min_order in __filemap_get_folio
Date:   Fri, 15 Sep 2023 20:38:28 +0200
Message-Id: <20230915183848.1018717-4-kernel@pankajraghav.com>
In-Reply-To: <20230915183848.1018717-1-kernel@pankajraghav.com>
References: <20230915183848.1018717-1-kernel@pankajraghav.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4RnNJ46BJgz9sVy
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Pankaj Raghav <p.raghav@samsung.com>

__filemap_get_folio() with FGP_CREAT should allocate at least folio of
filemap's min_order set using folio_set_mapping_orders().

A higher order folio than min_order by definition is a multiple of the
min_order. If an index is aligned to an order higher than a min_order, it
will also be aligned to the min order.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 mm/filemap.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 8962d1255905..b1ce63143df5 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1862,6 +1862,10 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 		fgf_t fgp_flags, gfp_t gfp)
 {
 	struct folio *folio;
+	int min_order = mapping_min_folio_order(mapping);
+	int nr_of_pages = (1U << min_order);
+
+	index = round_down(index, nr_of_pages);
 
 repeat:
 	folio = filemap_get_entry(mapping, index);
@@ -1929,8 +1933,14 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 			err = -ENOMEM;
 			if (order == 1)
 				order = 0;
+			if (order < min_order)
+				order = min_order;
 			if (order > 0)
 				alloc_gfp |= __GFP_NORETRY | __GFP_NOWARN;
+
+			if (min_order)
+				VM_BUG_ON(index & ((1UL << order) - 1));
+
 			folio = filemap_alloc_folio(alloc_gfp, order);
 			if (!folio)
 				continue;
@@ -1944,7 +1954,7 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 				break;
 			folio_put(folio);
 			folio = NULL;
-		} while (order-- > 0);
+		} while (order-- > min_order);
 
 		if (err == -EEXIST)
 			goto repeat;
-- 
2.40.1

