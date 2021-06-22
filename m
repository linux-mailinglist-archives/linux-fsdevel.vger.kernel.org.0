Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2CFD3B04A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 14:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbhFVMhI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 08:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbhFVMhH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:37:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6BBC061574;
        Tue, 22 Jun 2021 05:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=3pnIGezyLg2uitqRe0DCTnJwktJCWKNOvWRkQFvpOYk=; b=ct5TFw1E+pxXLWYcc7ztJs/sJQ
        gJvwfszu1ZMykySyTR8lcRYPK5S1srDqx0/Xty2E9PDiYmGHSLqZwLFr3JL6SQpCnh5fQN9r+A8wH
        3QK3obibM4NEEa5bI0oCI9cXsEVdneWgui0euoSyAUZdOBgKpaCULcFycyZqeqHpZYOVAH/fizcff
        XdI6n2yXb6mYWzZ1myY0wUSvTZc1NbZiPdsTzpwZ4yBuWQcZrk9WrGKZQCS1JI4bUD9kHdslJjW+2
        t9MIkvGpMLCvmo5XnZTFNGpJWnx8QmQEZB889yBsnFCphF2tqfcel25665O6kt69jO1w8ANoY+rs6
        terMjEIg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvfaZ-00EHRW-5l; Tue, 22 Jun 2021 12:33:34 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 21/46] mm/writeback: Rename __add_wb_stat() to wb_stat_mod()
Date:   Tue, 22 Jun 2021 13:15:26 +0100
Message-Id: <20210622121551.3398730-22-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210622121551.3398730-1-willy@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make this look like the newly renamed vmstat functions.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
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

