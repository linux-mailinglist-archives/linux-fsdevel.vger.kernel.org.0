Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B36783A6FFD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 22:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbhFNUSB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 16:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233094AbhFNUSB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 16:18:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA977C061574;
        Mon, 14 Jun 2021 13:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=6KptNewexBMUEyryOpK7yMpsXAQDBNZwxKyAxEZVkSY=; b=lLxaerzIWyBQLchra/d55MUKN3
        TqXwv2EfCaLH0N5TTcvth/vzEAXRyOAZPf5BhUBWK8xzf8IRpUg1DUaexjQ60T0IR4stS1+9qOMct
        A3qYSHPA9NDmq8d2g880VkqK/bHE8ylnEqaC5NjJ537oh39DO7ws8tsAPjq4VrqSa6Ludqr3pQkFs
        F3MEFWvfJEZM9QB4kwHudbmNyJWJJYi/M8u3flldNKWxQ5AHneM4ZtAqik5XFOBno9v4WQjg78w7F
        vAQi68qBjY+IwPYPPS1yYCJeqExPOZMSQTXCS9p93umhBqdm6oa/nzgvOTqrfkxFCUxoQbXrShHD9
        nHFWk1Jg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lssyz-005moe-Bb; Mon, 14 Jun 2021 20:15:00 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v11 01/33] mm: Convert get_page_unless_zero() to return bool
Date:   Mon, 14 Jun 2021 21:14:03 +0100
Message-Id: <20210614201435.1379188-2-willy@infradead.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210614201435.1379188-1-willy@infradead.org>
References: <20210614201435.1379188-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

atomic_add_unless() returns bool, so remove the widening casts to int
in page_ref_add_unless() and get_page_unless_zero().  This causes gcc
to produce slightly larger code in isolate_migratepages_block(), but
it's not clear that it's worse code.  Net +19 bytes of text.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h       | 2 +-
 include/linux/page_ref.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9c9430f063a7..877eb8730eea 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -757,7 +757,7 @@ static inline int put_page_testzero(struct page *page)
  * This can be called when MMU is off so it must not access
  * any of the virtual mappings.
  */
-static inline int get_page_unless_zero(struct page *page)
+static inline bool get_page_unless_zero(struct page *page)
 {
 	return page_ref_add_unless(page, 1, 0);
 }
diff --git a/include/linux/page_ref.h b/include/linux/page_ref.h
index 7ad46f45df39..3a799de8ad52 100644
--- a/include/linux/page_ref.h
+++ b/include/linux/page_ref.h
@@ -161,9 +161,9 @@ static inline int page_ref_dec_return(struct page *page)
 	return ret;
 }
 
-static inline int page_ref_add_unless(struct page *page, int nr, int u)
+static inline bool page_ref_add_unless(struct page *page, int nr, int u)
 {
-	int ret = atomic_add_unless(&page->_refcount, nr, u);
+	bool ret = atomic_add_unless(&page->_refcount, nr, u);
 
 	if (page_ref_tracepoint_active(page_ref_mod_unless))
 		__page_ref_mod_unless(page, nr, ret);
-- 
2.30.2

