Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D13720E31D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jun 2020 00:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388502AbgF2VL6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jun 2020 17:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730166AbgF2S5p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:57:45 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9219C03078B
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jun 2020 08:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=menTY62kjyGrIRN3icws339nMBHzO/L6TdGFnfxXMz4=; b=iEibZzk2LDFfymlDWnch/quZ2i
        pnh4wAzX8lJlVwdQs6gSVsGx4AtL0pO3UUsF80HydBruohQ+P3LVYMKOaLAHJQ8Xd9rMpg2MXFa6f
        EwEeuUTRpnDoGCxRq0W7uQftYxdWnKzIGkYy/xSsLWXIq/V373yZS+kAYg/p8M3/LIORmvsDmM8jK
        wxwZeTr2ZPVep9YjxQyrx1xxxAAas/caO5SANlxSQMzjj0QD8j5Jo43hm9ylGyOFQP2M8AmYBMna/
        s+JpwWx5rBFQ2HNGggYIO2gtzSmVjzHG55Y0CNHumRNL9oHB71ntyL4aRskmIWTeIsTaqR/NRk7GD
        6ydrbjSg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jpvZn-0004C6-SO; Mon, 29 Jun 2020 15:20:08 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 2/7] mm: Move page-flags include to top of file
Date:   Mon, 29 Jun 2020 16:19:54 +0100
Message-Id: <20200629151959.15779-3-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200629151959.15779-1-willy@infradead.org>
References: <20200629151959.15779-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Give up on the notion that we can remove page-flags.h from mm.h.
There are currently 14 inline functions which use a PageFoo function.
Also, two of the files directly included by mm.h include page-flags.h
themselves, and there are probably more indirect inclusions.  So just
include it at the top like any other header file.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index af0305ad090f..6c29b663135f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -24,6 +24,7 @@
 #include <linux/resource.h>
 #include <linux/page_ext.h>
 #include <linux/err.h>
+#include <linux/page-flags.h>
 #include <linux/page_ref.h>
 #include <linux/memremap.h>
 #include <linux/overflow.h>
@@ -667,11 +668,6 @@ int vma_is_stack_for_current(struct vm_area_struct *vma);
 struct mmu_gather;
 struct inode;
 
-/*
- * FIXME: take this include out, include page-flags.h in
- * files which need it (119 of them)
- */
-#include <linux/page-flags.h>
 #include <linux/huge_mm.h>
 
 /*
-- 
2.27.0

