Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0DD3E883B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 04:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbhHKCvT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 22:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbhHKCvR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 22:51:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14BDC061765;
        Tue, 10 Aug 2021 19:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=aJEbVaA0d3mf/4VrqeSJ1O+yG2WR7cL9r65Na0UkcCE=; b=FdcqifsOgfTGd60CVz7WnDVY0S
        ApHcgXuT/3DbZ4xXwejXCyQcHqGOyieE3DZdLjMmVPkvnCyzjKmXSIwx+B79PRz1h0uQz0Piu8XAC
        W5fWMqOSKP8tzvIFv1XgZOQ2zB5LCjZ8EbFZ0dox69nl/oSezlFskBG3n5hG7gg5B2bELPmB+/LN1
        jFkkYWJlEaHNvaJpHvSi6P4kxDAZCZ+tgXVqUR46iv47ABu89z3Oia0McZIXIvNUr+PO2CF4TtHSQ
        cvvkuwGqGO5NsaCKtzqTmgw4MaVBkNe2tV2G6+oJcDFnl1+K2aUkWO3OpLrFGc2gybFy1AI8tfayF
        kNvC/SpQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mDeJ5-00CsE3-SC; Wed, 11 Aug 2021 02:49:40 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 4/8] iomap: Accept a NULL iomap_writepage_ctx in iomap_submit_ioend()
Date:   Wed, 11 Aug 2021 03:46:43 +0100
Message-Id: <20210811024647.3067739-5-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210811024647.3067739-1-willy@infradead.org>
References: <20210811024647.3067739-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index d92943332c6c..ad9d8fe97f2e 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1172,7 +1172,7 @@ iomap_submit_ioend(struct iomap_writepage_ctx *wpc, struct iomap_ioend *ioend,
 	ioend->io_bio->bi_private = ioend;
 	ioend->io_bio->bi_end_io = iomap_writepage_end_bio;
 
-	if (wpc->ops->prepare_ioend)
+	if (wpc && wpc->ops->prepare_ioend)
 		error = wpc->ops->prepare_ioend(ioend, error);
 	if (error) {
 		/*
-- 
2.30.2

