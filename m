Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A61181B481B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Apr 2020 17:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbgDVPDu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Apr 2020 11:03:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:58096 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728122AbgDVPDI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Apr 2020 11:03:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9AC64AEE1;
        Wed, 22 Apr 2020 15:03:03 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B14CB1E0E83; Wed, 22 Apr 2020 17:03:03 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 21/23] testing: Introduce xa_erase_order() and use it
Date:   Wed, 22 Apr 2020 17:02:54 +0200
Message-Id: <20200422150256.23473-22-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200422150256.23473-1-jack@suse.cz>
References: <20200422150256.23473-1-jack@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce helper xa_erase_order() and call it from places that want to
erase entries from xarray instead of using xa_store_order(). This also
explicitely takes care of clearing possibly existing xarray marks
(although no current test seems to need it).

Signed-off-by: Jan Kara <jack@suse.cz>
---
 lib/test_xarray.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/lib/test_xarray.c b/lib/test_xarray.c
index 2cf3ef5d5014..fc16eac1cbb9 100644
--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -83,6 +83,16 @@ static void *xa_store_order(struct xarray *xa, unsigned long index,
 	return curr;
 }
 
+static void xa_erase_order(struct xarray *xa, unsigned long index,
+		unsigned order)
+{
+	XA_STATE_ORDER(xas, xa, index, order);
+
+	xas_lock(&xas);
+	xas_erase(&xas);
+	xas_unlock(&xas);
+}
+
 static noinline void check_xa_err(struct xarray *xa)
 {
 	XA_BUG_ON(xa, xa_err(xa_store_index(xa, 0, GFP_NOWAIT)) != 0);
@@ -608,13 +618,13 @@ static noinline void check_multi_store(struct xarray *xa)
 	rcu_read_unlock();
 
 	/* We can erase multiple values with a single store */
-	xa_store_order(xa, 0, BITS_PER_LONG - 1, NULL, GFP_KERNEL);
+	xa_erase_order(xa, 0, BITS_PER_LONG - 1);
 	XA_BUG_ON(xa, !xa_empty(xa));
 
 	/* Even when the first slot is empty but the others aren't */
 	xa_store_index(xa, 1, GFP_KERNEL);
 	xa_store_index(xa, 2, GFP_KERNEL);
-	xa_store_order(xa, 0, 2, NULL, GFP_KERNEL);
+	xa_erase_order(xa, 0, 2);
 	XA_BUG_ON(xa, !xa_empty(xa));
 
 	for (i = 0; i < max_order; i++) {
-- 
2.16.4

