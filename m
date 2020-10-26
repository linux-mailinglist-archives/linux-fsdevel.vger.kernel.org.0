Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4EC299562
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 19:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1789840AbgJZSbu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 14:31:50 -0400
Received: from casper.infradead.org ([90.155.50.34]:47304 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1789826AbgJZSbs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 14:31:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ypiBWQPYg753R2cxcJwFGATQOGKcI/C+YN3lyoq6w9E=; b=iqwPpQQcxM6cSzOdAeNykBRJXR
        OeVhediX1yFK4X+i/IlGmGIaqnWxvTSQePskUiy0W84s46Nyl9f91kd5CwjN5+LDUYKQKN+koIxJs
        LTTd7ruwMZ76sV8gIik39Yf5HeRygGcckMHGnj8dqHc0ydfATSITof5ymhNvWu91qOIAayhW5Wa/r
        eve2XY99pu3p8nJzUxfKWXAdOAOEFqxKf9OZKrgmnHI9qJwWxqW5a6XAMGO9QsxOkCEOv3x58Nhq6
        NLo7epFTdDP3WrrtHZbHIpAlzNz9i3X1OBWrHwWgf5B9BG4hv79oidrXwdbosd8GXyZi1iireUy98
        x77Q07YA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kX7HT-0002kD-V5; Mon, 26 Oct 2020 18:31:44 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 9/9] mm: Fix READ_ONLY_THP warning
Date:   Mon, 26 Oct 2020 18:31:36 +0000
Message-Id: <20201026183136.10404-10-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201026183136.10404-1-willy@infradead.org>
References: <20201026183136.10404-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These counters only exist if CONFIG_READ_ONLY_THP_FOR_FS is defined,
but we should not warn if the filesystem natively supports THPs.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 86143d36d028..2c736f8ae324 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -146,7 +146,7 @@ static inline void filemap_nr_thps_inc(struct address_space *mapping)
 	if (!mapping_thp_support(mapping))
 		atomic_inc(&mapping->nr_thps);
 #else
-	WARN_ON_ONCE(1);
+	WARN_ON_ONCE(!mapping_thp_support(mapping));
 #endif
 }
 
@@ -156,7 +156,7 @@ static inline void filemap_nr_thps_dec(struct address_space *mapping)
 	if (!mapping_thp_support(mapping))
 		atomic_dec(&mapping->nr_thps);
 #else
-	WARN_ON_ONCE(1);
+	WARN_ON_ONCE(!mapping_thp_support(mapping));
 #endif
 }
 
-- 
2.28.0

