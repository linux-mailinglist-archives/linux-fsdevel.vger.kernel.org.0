Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECCDB1F5CEB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 22:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgFJUSG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 16:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730518AbgFJUNr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:13:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4941C03E96B;
        Wed, 10 Jun 2020 13:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=a6bntLUvQ0tR7N/aMeU2zpyWKO2+RHf9NYJ0TB23leA=; b=ES+Sfxy+2oGIgIAmOW/I+p76fw
        qcPQqsG/73jemyJRer3+UjVnFFYLHVhkXkhsOZxvbDVdfaxrs8dIjC8cBBcdzK7zb/1YAMGtViobv
        E4OSMFg5GQlh+bhKZZ51XuWVi+onf+ucWA1IeqIffN5derpB0OCxfCNSGwMrj0wvaB68R571Ft4b0
        jS/v42UxtraBVF1FSe9nchpywSSnisn5Gu9+L5VfjTS/jm1k9qBVx01aejUktPjYOXQE77kQhM8Ml
        8VKqo4AarBlMKAm7s/S+867z77I9uroThzBOvWBQHlR+1afGTF+QxbeIt6kkmu5ycnhjB0nhxY/W1
        sf0IMA9w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jj76Z-0003TU-Gq; Wed, 10 Jun 2020 20:13:47 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 07/51] mm: Move page-flags include to top of file
Date:   Wed, 10 Jun 2020 13:13:01 -0700
Message-Id: <20200610201345.13273-8-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200610201345.13273-1-willy@infradead.org>
References: <20200610201345.13273-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

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
2.26.2

