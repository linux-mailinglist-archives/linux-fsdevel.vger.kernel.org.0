Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C394AFE47
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 21:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbiBIUW3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 15:22:29 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:49908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbiBIUWW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:22:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54198E039C4F
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 12:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=i6Ccmmii5fiKaaUJVDta0DOiHEuUbCyGzZu4XnEK0Ho=; b=lDMSyWNz5YUkGtSLE0iPdHRYMr
        9LDV3Bwqs1Y1lO260rPZl4JphR5HlNeNIX9Oi/w8Ek2lAYJ3xJKlMevWDARSCO67bdUkXItFBiEuH
        aOVIZDdZieY56ANVbMU2uZkn/b805ttwZa4mge+8MxHbGd4GYoCaN5OaLSPCohQiEb+SAyWPE/uIP
        KhiekV+RZi04GpzQTf2SREVuV1kZA6UjBr4i5Abbo+AIQoDCm/hYohZNmMaxaFsDDZ9nmqqZF4OHZ
        tAISdpNNlBg8e6WNd+Sn6ZL2LMbnnjJQuHdGgayPbPvVv4zSpo/9RRJB6dA71U60VzsE2bPDxmCx5
        R2cQmkIQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHtTq-008cp0-MI; Wed, 09 Feb 2022 20:22:22 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 03/56] iomap: Fix iomap_invalidatepage tracepoint
Date:   Wed,  9 Feb 2022 20:21:22 +0000
Message-Id: <20220209202215.2055748-4-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220209202215.2055748-1-willy@infradead.org>
References: <20220209202215.2055748-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This tracepoint is defined to take an offset in the file, not an
offset in the folio.

Fixes: 1ac994525b9d ("iomap: Remove pgoff from tracepoints")
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 6c51a75d0be6..d020a2e81a24 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -480,7 +480,8 @@ EXPORT_SYMBOL_GPL(iomap_releasepage);
 
 void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t len)
 {
-	trace_iomap_invalidatepage(folio->mapping->host, offset, len);
+	trace_iomap_invalidatepage(folio->mapping->host,
+					folio_pos(folio) + offset, len);
 
 	/*
 	 * If we're invalidating the entire folio, clear the dirty state
-- 
2.34.1

