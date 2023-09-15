Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596417A2621
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 20:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236548AbjIOSk6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 14:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236766AbjIOSka (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 14:40:30 -0400
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350D346B7;
        Fri, 15 Sep 2023 11:39:09 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4RnNJB14wvz9spX;
        Fri, 15 Sep 2023 20:39:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
        s=MBO0001; t=1694803146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v1ROluVJSO7Og0x78gpfVtBYiLqeXgpCBUoOyNe/wDk=;
        b=gScikhRfoSfUAACxzO+p12H84XzAf0M/1y/sXgTZwi/SgPURdSIOMvREaunNOLzkA85V5k
        CkYo7Lcirhjq/rxs9lLFIlbq+saLu5YE4wAsu553hUQgaAdLpnd6lWIJPRf79Do52gShSl
        MApjJ5VYI5gdB2GmwbCQdVfYyscSdpvjxz/UD/mMTo3yWb5Oo9lRMwslcX/s5/Dme/ByaM
        pvoVjRe/LuOWXOvQ4z+1rMTn2nLNkOeteypbQeBaG7pl4lV2R9pYHLCIU7ryNihhJRCQKb
        P/Zo3IhJskWPDN4dnUQANxUvg31hX/f2ObFgnkjEJb2nLswBC4EENX4tks9G3g==
From:   Pankaj Raghav <kernel@pankajraghav.com>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     p.raghav@samsung.com, david@fromorbit.com, da.gomez@samsung.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        willy@infradead.org, djwong@kernel.org, linux-mm@kvack.org,
        chandan.babu@oracle.com, mcgrof@kernel.org, gost.dev@samsung.com
Subject: [RFC 05/23] filemap: align index to mapping_min_order in filemap_range_has_page()
Date:   Fri, 15 Sep 2023 20:38:30 +0200
Message-Id: <20230915183848.1018717-6-kernel@pankajraghav.com>
In-Reply-To: <20230915183848.1018717-1-kernel@pankajraghav.com>
References: <20230915183848.1018717-1-kernel@pankajraghav.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4RnNJB14wvz9spX
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Luis Chamberlain <mcgrof@kernel.org>

page cache is mapping min_folio_order aligned. Use mapping min_folio_order
to align the start_byte and end_byte in filemap_range_has_page().

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 mm/filemap.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 2c47729dc8b0..4dee24b5b61c 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -477,9 +477,12 @@ EXPORT_SYMBOL(filemap_flush);
 bool filemap_range_has_page(struct address_space *mapping,
 			   loff_t start_byte, loff_t end_byte)
 {
+	unsigned int min_order = mapping_min_folio_order(mapping);
+	unsigned int nrpages = 1UL << min_order;
+	pgoff_t index = round_down(start_byte >> PAGE_SHIFT, nrpages);
 	struct folio *folio;
-	XA_STATE(xas, &mapping->i_pages, start_byte >> PAGE_SHIFT);
-	pgoff_t max = end_byte >> PAGE_SHIFT;
+	XA_STATE(xas, &mapping->i_pages, index);
+	pgoff_t max = round_down(end_byte >> PAGE_SHIFT, nrpages);
 
 	if (end_byte < start_byte)
 		return false;
-- 
2.40.1

