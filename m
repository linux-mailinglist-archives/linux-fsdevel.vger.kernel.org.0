Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B413C47EC17
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Dec 2021 07:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351662AbhLXGXf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Dec 2021 01:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351630AbhLXGX2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Dec 2021 01:23:28 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC8BC06175A;
        Thu, 23 Dec 2021 22:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=r+AMuPryeJoy2wrq9K15sJ1nejOu1rxTBJkjMvsXyDE=; b=z4eRv7Fl9AqjwK/lNx9juM7Cmq
        k6Hc8b2V26lacogdFySDr019Kxi4KjtXhjUIHZSdY6fDOHWwaGHffYk2I32QNMfCA8r9y50/Yp6sd
        nJ2YzNT5O6G/IqjoDimjLbcRDrlIGrBaB/kIK7WH1V0CTl6I4J8LL0YciDHsCCw3Rk+7aJgLoi8RW
        Hu/S3JKAhaHTRIf2NjM18Zp3HTf8DKF/ifG/Xqm0wTvk3/wDLgTZVGPCuMFmIffAldcXzKhuZDdkO
        q0FUgpF0pGoaE1dgFRTFsvmAdgNU8jVEK+ObqaHp2DdX1uureqgus80sVuc2YZvK4QbWILbkCSQxL
        fL2CjNcA==;
Received: from p4fdb0b85.dip0.t-ipconnect.de ([79.219.11.133] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0dz4-00Dn7b-JI; Fri, 24 Dec 2021 06:23:19 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 10/13] frontswap: simplify frontswap_register_ops
Date:   Fri, 24 Dec 2021 07:22:43 +0100
Message-Id: <20211224062246.1258487-11-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211224062246.1258487-1-hch@lst.de>
References: <20211224062246.1258487-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Given that frontswap_register_ops must be called from built-in code,
there is no need to handle the case of swapfiles coming online before
or during it, so delete the code that deals with that case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/frontswap.c | 41 -----------------------------------------
 1 file changed, 41 deletions(-)

diff --git a/mm/frontswap.c b/mm/frontswap.c
index f51159f0d75d5..35040fa4eba83 100644
--- a/mm/frontswap.c
+++ b/mm/frontswap.c
@@ -99,25 +99,6 @@ static inline void inc_frontswap_invalidates(void) { }
  */
 void frontswap_register_ops(struct frontswap_ops *ops)
 {
-	DECLARE_BITMAP(a, MAX_SWAPFILES);
-	DECLARE_BITMAP(b, MAX_SWAPFILES);
-	struct swap_info_struct *si;
-	unsigned int i;
-
-	bitmap_zero(a, MAX_SWAPFILES);
-	bitmap_zero(b, MAX_SWAPFILES);
-
-	spin_lock(&swap_lock);
-	plist_for_each_entry(si, &swap_active_head, list) {
-		if (!WARN_ON(!si->frontswap_map))
-			__set_bit(si->type, a);
-	}
-	spin_unlock(&swap_lock);
-
-	/* the new ops needs to know the currently active swap devices */
-	for_each_set_bit(i, a, MAX_SWAPFILES)
-		ops->init(i);
-
 	/*
 	 * Setting frontswap_ops must happen after the ops->init() calls
 	 * above; cmpxchg implies smp_mb() which will ensure the init is
@@ -128,28 +109,6 @@ void frontswap_register_ops(struct frontswap_ops *ops)
 	} while (cmpxchg(&frontswap_ops, ops->next, ops) != ops->next);
 
 	static_branch_inc(&frontswap_enabled_key);
-
-	spin_lock(&swap_lock);
-	plist_for_each_entry(si, &swap_active_head, list) {
-		if (si->frontswap_map)
-			__set_bit(si->type, b);
-	}
-	spin_unlock(&swap_lock);
-
-	/*
-	 * On the very unlikely chance that a swap device was added or
-	 * removed between setting the "a" list bits and the ops init
-	 * calls, we re-check and do init or invalidate for any changed
-	 * bits.
-	 */
-	if (unlikely(!bitmap_equal(a, b, MAX_SWAPFILES))) {
-		for (i = 0; i < MAX_SWAPFILES; i++) {
-			if (!test_bit(i, a) && test_bit(i, b))
-				ops->init(i);
-			else if (test_bit(i, a) && !test_bit(i, b))
-				ops->invalidate_area(i);
-		}
-	}
 }
 
 /*
-- 
2.30.2

