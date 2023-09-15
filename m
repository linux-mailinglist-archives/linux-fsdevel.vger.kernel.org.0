Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6DE27A2645
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 20:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236708AbjIOSmd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 14:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236964AbjIOSmP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 14:42:15 -0400
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E86469F;
        Fri, 15 Sep 2023 11:39:07 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4RnNJ73F62z9spF;
        Fri, 15 Sep 2023 20:39:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
        s=MBO0001; t=1694803143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vFsIs+qRJRSVkUkhUlyZ9H4Jh3BsQexeaTYNPM7knQw=;
        b=hVgB1L3L+hfbOFs9pzt7JSZ0hL75va+f5dGTqbKq35/LHth7vuCtJyolpUYaCtZSdpXEix
        JXkNguxLkbblJKEYeBRWw4sugGoImquURo+WUPFARno3LgpZs20LLYLTi+D1WoWj+VLGNq
        uk+eLY+KxGkhRGjoDU09147fIC6cq8HBY7YH1MqbB89sTKYaddEmbOywPuL2wAm0HAG1d7
        uT6Hp9zxX7OT0WFkFyl90rEJTT/PqBgWimlkD0UmghcqOvuwIJ8F+Ojn/orHfim//bDchH
        UtjJ+Oczct31qILqny72oU57MW1XThTi8wVKz646qcGe6HdWO6Pw8qfKMm7E8Q==
From:   Pankaj Raghav <kernel@pankajraghav.com>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     p.raghav@samsung.com, david@fromorbit.com, da.gomez@samsung.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        willy@infradead.org, djwong@kernel.org, linux-mm@kvack.org,
        chandan.babu@oracle.com, mcgrof@kernel.org, gost.dev@samsung.com
Subject: [RFC 04/23] filemap: set the order of the index in page_cache_delete_batch()
Date:   Fri, 15 Sep 2023 20:38:29 +0200
Message-Id: <20230915183848.1018717-5-kernel@pankajraghav.com>
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

Similar to page_cache_delete(), call xas_set_order for non-hugetlb pages
while deleting an entry from the page cache. Also put BUG_ON if the
order of the folio is less than the mapping min_order.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 mm/filemap.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index b1ce63143df5..2c47729dc8b0 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -126,6 +126,7 @@
 static void page_cache_delete(struct address_space *mapping,
 				   struct folio *folio, void *shadow)
 {
+	unsigned int min_order = mapping_min_folio_order(mapping);
 	XA_STATE(xas, &mapping->i_pages, folio->index);
 	long nr = 1;
 
@@ -134,6 +135,7 @@ static void page_cache_delete(struct address_space *mapping,
 	xas_set_order(&xas, folio->index, folio_order(folio));
 	nr = folio_nr_pages(folio);
 
+	VM_BUG_ON_FOLIO(folio_order(folio) < min_order, folio);
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 
 	xas_store(&xas, shadow);
@@ -276,6 +278,7 @@ void filemap_remove_folio(struct folio *folio)
 static void page_cache_delete_batch(struct address_space *mapping,
 			     struct folio_batch *fbatch)
 {
+	unsigned int min_order = mapping_min_folio_order(mapping);
 	XA_STATE(xas, &mapping->i_pages, fbatch->folios[0]->index);
 	long total_pages = 0;
 	int i = 0;
@@ -304,6 +307,11 @@ static void page_cache_delete_batch(struct address_space *mapping,
 
 		WARN_ON_ONCE(!folio_test_locked(folio));
 
+		/* hugetlb pages are represented by a single entry in the xarray */
+		if (!folio_test_hugetlb(folio)) {
+			VM_BUG_ON_FOLIO(folio_order(folio) < min_order, folio);
+			xas_set_order(&xas, folio->index, folio_order(folio));
+		}
 		folio->mapping = NULL;
 		/* Leave folio->index set: truncation lookup relies on it */
 
-- 
2.40.1

