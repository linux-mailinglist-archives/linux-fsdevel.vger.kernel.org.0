Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E565373F54
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 18:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233851AbhEEQOk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 12:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbhEEQOk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 12:14:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5D1C061574;
        Wed,  5 May 2021 09:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=3pnIGezyLg2uitqRe0DCTnJwktJCWKNOvWRkQFvpOYk=; b=GpA8YHH9F4mm0UYPmB/iOxRqvf
        yP+6aJDb2der7Fx50w5bJ/sxqlACAPhkF+iO2E+N9Zk74RMtdEhJKp4AWFlN/BxlN2zglvZ3j0vlK
        fzpWeGz+w4McRQdcjdoWlpIfD6mK5nxtF/0ksfVPsV4HUYeNVpULyfnjjfi/KOqUMUO1CuABCa304
        BdJ3sIQ0LauOoASjHOudcMjrT41QYcLJUUHzcnO8eD9d8VIzun40OCaFLc2sP71XyCPJ3NyU1CsxM
        SdzDJrSoH+dy1nwXvbRvufOvgRYEnUCXIae7zjl6vcwK+PkttMCybtmBaaedaurRWh7rhaLUCT0z8
        65omRL/Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leK7m-000ZTH-4s; Wed, 05 May 2021 16:11:51 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 54/96] mm/writeback: Rename __add_wb_stat to wb_stat_mod
Date:   Wed,  5 May 2021 16:05:46 +0100
Message-Id: <20210505150628.111735-55-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210505150628.111735-1-willy@infradead.org>
References: <20210505150628.111735-1-willy@infradead.org>
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

