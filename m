Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F4B7A2648
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 20:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236851AbjIOSmf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 14:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237034AbjIOSm2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 14:42:28 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2AF49E3;
        Fri, 15 Sep 2023 11:39:12 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4RnNJH1Xljz9sQf;
        Fri, 15 Sep 2023 20:39:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
        s=MBO0001; t=1694803151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fo0VXOu7M+9NKfjAGLZXjFApmoEpRKKJEPK75Mez2cA=;
        b=WfMPs8owDY4qNpPNRRBf2P7n6I/k1Vb8R9SOGAa4d0T5FLvv4ZHDjWd9yFS4HA1DKcDXoZ
        Hs9/Lc7bdPIjyElTcSGwwlLTk8E9vLbEnQREiltl5xwCZxZhmZW2W/MIWqbzt/L0UBGJkL
        Pg1tzwwKa0ivqVeh/dlhg7mGJoM5RT/rjcmVhwnmzmeYieP7bnYJI0tIsDaZcaMFCiYk9l
        eQpfZrnKOiSrp4if8lwa+VZrXN/gYt7pEAXj9fNCZan1DgEdMMHsjyF5BcnH2QER2lpu5Q
        2yAY1aQhY540+9mUaXvvL33VXZsMEat6/i+Ojfu5vHN2X5uVaD4JlKa3e5Z7bA==
From:   Pankaj Raghav <kernel@pankajraghav.com>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     p.raghav@samsung.com, david@fromorbit.com, da.gomez@samsung.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        willy@infradead.org, djwong@kernel.org, linux-mm@kvack.org,
        chandan.babu@oracle.com, mcgrof@kernel.org, gost.dev@samsung.com
Subject: [RFC 07/23] filemap: align the index to mapping_min_order in __filemap_add_folio()
Date:   Fri, 15 Sep 2023 20:38:32 +0200
Message-Id: <20230915183848.1018717-8-kernel@pankajraghav.com>
In-Reply-To: <20230915183848.1018717-1-kernel@pankajraghav.com>
References: <20230915183848.1018717-1-kernel@pankajraghav.com>
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

From: Luis Chamberlain <mcgrof@kernel.org>

Align the index to the mapping_min_order number of pages while setting
the XA_STATE and xas_set_order().

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 mm/filemap.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 33de71bfa953..15bc810bfc89 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -859,7 +859,10 @@ EXPORT_SYMBOL_GPL(replace_page_cache_folio);
 noinline int __filemap_add_folio(struct address_space *mapping,
 		struct folio *folio, pgoff_t index, gfp_t gfp, void **shadowp)
 {
-	XA_STATE(xas, &mapping->i_pages, index);
+	unsigned int min_order = mapping_min_folio_order(mapping);
+	unsigned int nr_of_pages = (1U << min_order);
+	pgoff_t rounded_index = round_down(index, nr_of_pages);
+	XA_STATE(xas, &mapping->i_pages, rounded_index);
 	int huge = folio_test_hugetlb(folio);
 	bool charged = false;
 	long nr = 1;
@@ -875,8 +878,8 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 		charged = true;
 	}
 
-	VM_BUG_ON_FOLIO(index & (folio_nr_pages(folio) - 1), folio);
-	xas_set_order(&xas, index, folio_order(folio));
+	VM_BUG_ON_FOLIO(rounded_index & (folio_nr_pages(folio) - 1), folio);
+	xas_set_order(&xas, rounded_index, folio_order(folio));
 	nr = folio_nr_pages(folio);
 
 	gfp &= GFP_RECLAIM_MASK;
@@ -913,6 +916,7 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 			}
 		}
 
+		VM_BUG_ON_FOLIO(folio_order(folio) < min_order, folio);
 		xas_store(&xas, folio);
 		if (xas_error(&xas))
 			goto unlock;
-- 
2.40.1

