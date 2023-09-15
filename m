Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72D27A2637
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 20:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236807AbjIOSmE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 14:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236825AbjIOSlp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 14:41:45 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A344206;
        Fri, 15 Sep 2023 11:40:22 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4RnNJg0GXfz9spB;
        Fri, 15 Sep 2023 20:39:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
        s=MBO0001; t=1694803171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=591wcX/aNYK1i2+Gpz2G47nBurFy4yzLeb3z8BH/s7c=;
        b=vcPcMUF61bQ2Sox+rVmcmmFCT5EqJKJRSDzMWuT3qx6Cthz50vAI4MWCBIJ+/FXhvQQT73
        aUeCtC3yGQQ9yF6AYkBBl/xbuC7mwlJcI6rdrJUfFIxTR6mKGWW+d8riBrqwJycp2FTOK+
        rSdoOS7Y9ZY2iIqkKtC/1Mzz0BmkWZt3aY7oRXjFsQGGWCf7vZNYfMMwkyXPXqdMYBuSqv
        YshJdlp/P1VfVHttkHmJg2rDfDIzV5tFlpdaI9rPLXUlzcICnaqjt1ipzU55sAxa6mse0B
        f3qJ8/OF95BjLF3LDOCPsStttf1OOn3/f/YPMTzUtd/kfRx+XXvz7QdxF3gFbA==
From:   Pankaj Raghav <kernel@pankajraghav.com>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     p.raghav@samsung.com, david@fromorbit.com, da.gomez@samsung.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        willy@infradead.org, djwong@kernel.org, linux-mm@kvack.org,
        chandan.babu@oracle.com, mcgrof@kernel.org, gost.dev@samsung.com
Subject: [RFC 14/23] readahead: allocate folios with mapping_min_order in ra_unbounded()
Date:   Fri, 15 Sep 2023 20:38:39 +0200
Message-Id: <20230915183848.1018717-15-kernel@pankajraghav.com>
In-Reply-To: <20230915183848.1018717-1-kernel@pankajraghav.com>
References: <20230915183848.1018717-1-kernel@pankajraghav.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4RnNJg0GXfz9spB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Pankaj Raghav <p.raghav@samsung.com>

Allocate folios with mapping_min_order order in
page_cache_ra_unbounded(). Also adjust the accounting to take the
folio_nr_pages in the loop.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 mm/readahead.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 5c4e7ee64dc1..2a9e9020b7cf 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -250,7 +250,8 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 			continue;
 		}
 
-		folio = filemap_alloc_folio(gfp_mask, 0);
+		folio = filemap_alloc_folio(gfp_mask,
+					    mapping_min_folio_order(mapping));
 		if (!folio)
 			break;
 		if (filemap_add_folio(mapping, folio, index + i,
@@ -264,7 +265,8 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 		if (i == nr_to_read - lookahead_size)
 			folio_set_readahead(folio);
 		ractl->_workingset |= folio_test_workingset(folio);
-		ractl->_nr_pages++;
+		ractl->_nr_pages += folio_nr_pages(folio);
+		i += folio_nr_pages(folio) - 1;
 	}
 
 	/*
-- 
2.40.1

