Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A13B5791B4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jul 2022 06:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234596AbiGSENj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jul 2022 00:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234998AbiGSENf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jul 2022 00:13:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5FE3E764;
        Mon, 18 Jul 2022 21:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=nKRXCtg6crCLovWpkEIg/XE7hMBwadb9/APF3hI0m/g=; b=Qx+Qjk+ceWTxPdFKKyJKEkQqR/
        +U0Ic28KrIvSIjsuCQmHR7dOKz4PlV5l2XK5Pml0LvePgwWGW1wtzfgW48azrP68NscPyKhffZXTb
        3DpULVzuzlhQAbErLaF7vKFvmDO3NuL0360LJN933BN9wJ8+lXycNMXFxLZFMFEnVwKoJlAtAwG8j
        rh2dALXIOFn05hP2Dre4/rpIzPJMAJMIa4hPmjTw+sySpAJBSus+202+geWK3qp/NUz2FTO8iIGg4
        KRMDZ5bau8NoUqWwIK3l5jtxcm8dPKn3QkcTtDFYUgeoxCu+SJLoeT1/eYY6YDfv4sJvulCjFHKcZ
        LnFtsfxA==;
Received: from 089144198117.atnat0007.highway.a1.net ([89.144.198.117] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oDebt-004jVM-En; Tue, 19 Jul 2022 04:13:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Cc:     Johannes Thumshirn <jth@kernel.org>, cluster-devel@redhat.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/4] iomap: remove iomap_writepage
Date:   Tue, 19 Jul 2022 06:13:11 +0200
Message-Id: <20220719041311.709250-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220719041311.709250-1-hch@lst.de>
References: <20220719041311.709250-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Unused now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 fs/iomap/buffered-io.c | 15 ---------------
 include/linux/iomap.h  |  3 ---
 2 files changed, 18 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index d2a9f699e17ed..1bac8bda40d0c 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1518,21 +1518,6 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
 	return 0;
 }
 
-int
-iomap_writepage(struct page *page, struct writeback_control *wbc,
-		struct iomap_writepage_ctx *wpc,
-		const struct iomap_writeback_ops *ops)
-{
-	int ret;
-
-	wpc->ops = ops;
-	ret = iomap_do_writepage(page, wbc, wpc);
-	if (!wpc->ioend)
-		return ret;
-	return iomap_submit_ioend(wpc, wpc->ioend, ret);
-}
-EXPORT_SYMBOL_GPL(iomap_writepage);
-
 int
 iomap_writepages(struct address_space *mapping, struct writeback_control *wbc,
 		struct iomap_writepage_ctx *wpc,
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index e552097c67e0b..911888560d3eb 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -303,9 +303,6 @@ void iomap_finish_ioends(struct iomap_ioend *ioend, int error);
 void iomap_ioend_try_merge(struct iomap_ioend *ioend,
 		struct list_head *more_ioends);
 void iomap_sort_ioends(struct list_head *ioend_list);
-int iomap_writepage(struct page *page, struct writeback_control *wbc,
-		struct iomap_writepage_ctx *wpc,
-		const struct iomap_writeback_ops *ops);
 int iomap_writepages(struct address_space *mapping,
 		struct writeback_control *wbc, struct iomap_writepage_ctx *wpc,
 		const struct iomap_writeback_ops *ops);
-- 
2.30.2

