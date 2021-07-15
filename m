Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 917FD3C976B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 06:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236656AbhGOEbx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 00:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbhGOEbx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 00:31:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADD2C06175F;
        Wed, 14 Jul 2021 21:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=HkzEL+P4RoA9lEpGuWVdgdutSkoMwcFoNSDxLURGf2I=; b=BRULnDI2ti7j2ouCrbmnXR9nWY
        9gPVfLu3UWHehgsGF3J9UnNXRovwPaxQarXu+iBmAsm0r2yaXynXymy8ewSpVtkmUOwqu/UHG655E
        mW01YzvYR7MlfRxK5AKJS2rtXww0MLP8/5ScO7Lpas5JY/m8VA8intlNA7b63mCsnxfcR81mRlBvw
        cCmHNnhZwSKCmycowBsypr72PFe77ukWoqnCHst3xaIXNUKtbQ3k1kjwxmSN5Pi9BQxALvnTumkGV
        QZ1icbsUQJOoRHWfs50N2xSJSNM0/YTkPdG63EDNfAg22HgBMfBgg/MuJgXtiFqY4v8uVb2QuWerz
        woObk+PQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3sxq-002xM8-Tm; Thu, 15 Jul 2021 04:27:27 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v14 063/138] mm/writeback: Rename __add_wb_stat() to wb_stat_mod()
Date:   Thu, 15 Jul 2021 04:35:49 +0100
Message-Id: <20210715033704.692967-64-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make this look like the newly renamed vmstat functions.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/backing-dev.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 44df4fcef65c..a852876bb6e2 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -64,7 +64,7 @@ static inline bool bdi_has_dirty_io(struct backing_dev_info *bdi)
 	return atomic_long_read(&bdi->tot_write_bandwidth);
 }
 
-static inline void __add_wb_stat(struct bdi_writeback *wb,
+static inline void wb_stat_mod(struct bdi_writeback *wb,
 				 enum wb_stat_item item, s64 amount)
 {
 	percpu_counter_add_batch(&wb->stat[item], amount, WB_STAT_BATCH);
@@ -72,12 +72,12 @@ static inline void __add_wb_stat(struct bdi_writeback *wb,
 
 static inline void inc_wb_stat(struct bdi_writeback *wb, enum wb_stat_item item)
 {
-	__add_wb_stat(wb, item, 1);
+	wb_stat_mod(wb, item, 1);
 }
 
 static inline void dec_wb_stat(struct bdi_writeback *wb, enum wb_stat_item item)
 {
-	__add_wb_stat(wb, item, -1);
+	wb_stat_mod(wb, item, -1);
 }
 
 static inline s64 wb_stat(struct bdi_writeback *wb, enum wb_stat_item item)
-- 
2.30.2

