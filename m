Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF32671945
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 11:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjARKlZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 05:41:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjARKje (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 05:39:34 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AF6C41C9;
        Wed, 18 Jan 2023 01:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=1tivNYnlYVjl+dCfTLCmKC5DzLdFgx18xVeklobnFOc=; b=oK86k6pKeZIcKg+Va0m3zSYnjp
        gdfBbtk752RFEObSR9dD/b0hSJZ+q6liwdtaOTuc+dZZjdn0uEBzCqUHQzMjPvwG/Uy75gc4xEjYT
        Zc6N0l/AGGagjNvK0usj0Ru2kn67AlvrxYxEIlLGFWVxDaD3WX4PRNuqYGnhJ+eTsWFF4cJ/nIic7
        8ZA18lYUNGRHuUCEsd4YsVPU+DUCq5f/B4gOa9Vj5CrRRw+uKTHIiRdsE0s7zrKs48MkWSVwFXKmZ
        CcxQZeEif++QTTZv/8MNZaoq60DHPDo1DfYTsTFm1cnoaVz2hBTo7sJJbPBtPznpgeAWzzQ/Vqvco
        bg2FpGKQ==;
Received: from 213-147-167-250.nat.highway.webapn.at ([213.147.167.250] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pI4yx-0009xj-Fn; Wed, 18 Jan 2023 09:43:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>
Cc:     linux-afs@lists.infradead.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nilfs@vger.kernel.org
Subject: [PATCH 3/9] mm: use filemap_get_entry in filemap_get_incore_folio
Date:   Wed, 18 Jan 2023 10:43:23 +0100
Message-Id: <20230118094329.9553-4-hch@lst.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230118094329.9553-1-hch@lst.de>
References: <20230118094329.9553-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

filemap_get_incore_folio wants to look at the details of xa_is_value
entries, but doesn't need any of the other logic in filemap_get_folio.
Switch it to use the lower-level filemap_get_entry interface.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/swap_state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index cb9aaa00951d99..c39ea34bc4fc10 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -380,7 +380,7 @@ struct folio *filemap_get_incore_folio(struct address_space *mapping,
 {
 	swp_entry_t swp;
 	struct swap_info_struct *si;
-	struct folio *folio = __filemap_get_folio(mapping, index, FGP_ENTRY, 0);
+	struct folio *folio = filemap_get_entry(mapping, index);
 
 	if (!xa_is_value(folio))
 		goto out;
-- 
2.39.0

