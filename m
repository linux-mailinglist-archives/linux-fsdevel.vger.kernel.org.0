Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940617A261A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 20:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236565AbjIOSk0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 14:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236979AbjIOSkE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 14:40:04 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050:0:465::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C863F4C06;
        Fri, 15 Sep 2023 11:39:20 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4RnNJL12VYz9sTm;
        Fri, 15 Sep 2023 20:39:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
        s=MBO0001; t=1694803154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qYagWwQkQyBo9FUt+Wer66h9atojNQ2DWonnQYgzdlw=;
        b=sLkequQ37CkU3k8W1DxxgB42DpoCWPVkiye6O36mnozEtbvveaSpVg02AQr9gRNrsG1StT
        zaL/G92Pk3Q9LxMD3dVHNbwZKUF2uE0xvuy7ixhERejXQHjckMQRVs4nVmKTcZ8B4ZlwxF
        dilFyBmIzK3geH/C55u1tMzeAId6PQM20aaVRonwgd4u+BGaOLBKOVd7hyimLCr/FrViWj
        YBvOAyGNd9SQBuLQuz8bCS/+MMijxud/FLCWs8ijotAjn63u2NB1NyM8wO0y+syInk6R+Q
        VvQVj3aV97v3/+RLzo4tjrdpk9/BPKcdYe+8EcQcR29kNlkW4twTvSq1m+u2PQ==
From:   Pankaj Raghav <kernel@pankajraghav.com>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     p.raghav@samsung.com, david@fromorbit.com, da.gomez@samsung.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        willy@infradead.org, djwong@kernel.org, linux-mm@kvack.org,
        chandan.babu@oracle.com, mcgrof@kernel.org, gost.dev@samsung.com
Subject: [RFC 08/23] filemap: align the index to mapping_min_order in filemap_get_folios_tag()
Date:   Fri, 15 Sep 2023 20:38:33 +0200
Message-Id: <20230915183848.1018717-9-kernel@pankajraghav.com>
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
the XA_STATE in filemap_get_folios_tag().

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 mm/filemap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 15bc810bfc89..21e1341526ab 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2280,7 +2280,9 @@ EXPORT_SYMBOL(filemap_get_folios_contig);
 unsigned filemap_get_folios_tag(struct address_space *mapping, pgoff_t *start,
 			pgoff_t end, xa_mark_t tag, struct folio_batch *fbatch)
 {
-	XA_STATE(xas, &mapping->i_pages, *start);
+	unsigned int min_order = mapping_min_folio_order(mapping);
+	unsigned int nrpages = 1UL << min_order;
+	XA_STATE(xas, &mapping->i_pages, round_down(*start, nrpages));
 	struct folio *folio;
 
 	rcu_read_lock();
-- 
2.40.1

