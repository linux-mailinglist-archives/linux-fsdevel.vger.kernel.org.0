Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD76517D86
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 May 2022 08:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiECGoe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 May 2022 02:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbiECGn4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 May 2022 02:43:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F8962E1
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 May 2022 23:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=X9KRB5HztTBHbcbradeeuPmxnugGH4lxxu89NI0o210=; b=rGiY8fhSPHK5Alk9rcIIwam2G7
        txjyqMhc3wyq7MILHu7L9jWBp3KuHb7BPMloqXzOywIUmn3AaGP8vDT+fZzB2P8OyLINCNBK6ho9D
        KrWcmONj//jPU0rFCZEvaWXp2KJU2JXCCTWuvg2+Tu5obugzr0zLdvIWR0qIF5Sznw93lBzPpjssN
        BRIMiPn1+/HhvwiiBu2wL7CsjW4Qs1dsYAz12cABHkxQaYCtWTIxy6SD4U/ap9RydiOS5xBZk+xWE
        gk+WHLqwjkLMOCD8nP/m1gonuEDUChndbuFGF3merodDbkgKtWrr37IqHO10oQwFUPIg4aSNE/SE5
        pUysfEHQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nlmCh-00FRxK-UY; Tue, 03 May 2022 06:40:12 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [RFC PATCH 04/10] iomap: Accept a NULL iomap_writepage_ctx in iomap_submit_ioend()
Date:   Tue,  3 May 2022 07:40:02 +0100
Message-Id: <20220503064008.3682332-5-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220503064008.3682332-1-willy@infradead.org>
References: <20220503064008.3682332-1-willy@infradead.org>
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

Prepare for I/O without an iomap_writepage_ctx() by accepting a NULL
wpc.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 1bf361446267..85bcdb0dc66c 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1204,7 +1204,7 @@ iomap_submit_ioend(struct iomap_writepage_ctx *wpc, struct iomap_ioend *ioend,
 	ioend->io_bio->bi_private = ioend;
 	ioend->io_bio->bi_end_io = iomap_writepage_end_bio;
 
-	if (wpc->ops->prepare_ioend)
+	if (wpc && wpc->ops->prepare_ioend)
 		error = wpc->ops->prepare_ioend(ioend, error);
 	if (error) {
 		/*
-- 
2.34.1

