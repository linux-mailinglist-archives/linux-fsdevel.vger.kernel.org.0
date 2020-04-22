Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 289ED1B4811
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Apr 2020 17:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbgDVPDK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Apr 2020 11:03:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:58166 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728132AbgDVPDJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Apr 2020 11:03:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A5C5FAEEC;
        Wed, 22 Apr 2020 15:03:03 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id AC4221E0E82; Wed, 22 Apr 2020 17:03:03 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 20/23] testing: Use xas_store_noinit() for non-NULL entries
Date:   Wed, 22 Apr 2020 17:02:53 +0200
Message-Id: <20200422150256.23473-21-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200422150256.23473-1-jack@suse.cz>
References: <20200422150256.23473-1-jack@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When we store value different from NULL, xas_store_noinit() is
equivalent to xas_store(). Transition these places to
xas_store_noinit().

Signed-off-by: Jan Kara <jack@suse.cz>
---
 lib/test_xarray.c                          | 28 ++++++++++++++--------------
 tools/testing/radix-tree/iteration_check.c |  2 +-
 tools/testing/radix-tree/multiorder.c      |  2 +-
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/lib/test_xarray.c b/lib/test_xarray.c
index 434031fe8d54..2cf3ef5d5014 100644
--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -130,13 +130,13 @@ static noinline void check_xas_retry(struct xarray *xa)
 	/* Make sure we can iterate through retry entries */
 	xas_lock(&xas);
 	xas_set(&xas, 0);
-	xas_store(&xas, XA_RETRY_ENTRY);
+	xas_store_noinit(&xas, XA_RETRY_ENTRY);
 	xas_set(&xas, 1);
-	xas_store(&xas, XA_RETRY_ENTRY);
+	xas_store_noinit(&xas, XA_RETRY_ENTRY);
 
 	xas_set(&xas, 0);
 	xas_for_each(&xas, entry, ULONG_MAX) {
-		xas_store(&xas, xa_mk_index(xas.xa_index));
+		xas_store_noinit(&xas, xa_mk_index(xas.xa_index));
 	}
 	xas_unlock(&xas);
 
@@ -475,7 +475,7 @@ static noinline void check_xas_erase(struct xarray *xa)
 			xas_set(&xas, j);
 			do {
 				xas_lock(&xas);
-				xas_store(&xas, xa_mk_index(j));
+				xas_store_noinit(&xas, xa_mk_index(j));
 				xas_unlock(&xas);
 			} while (xas_nomem(&xas, GFP_KERNEL));
 		}
@@ -483,7 +483,7 @@ static noinline void check_xas_erase(struct xarray *xa)
 		xas_set(&xas, ULONG_MAX);
 		do {
 			xas_lock(&xas);
-			xas_store(&xas, xa_mk_value(0));
+			xas_store_noinit(&xas, xa_mk_value(0));
 			xas_unlock(&xas);
 		} while (xas_nomem(&xas, GFP_KERNEL));
 
@@ -517,7 +517,7 @@ static noinline void check_multi_store_1(struct xarray *xa, unsigned long index,
 	XA_BUG_ON(xa, xa_load(xa, min - 1) != NULL);
 
 	xas_lock(&xas);
-	XA_BUG_ON(xa, xas_store(&xas, xa_mk_index(min)) != xa_mk_index(index));
+	XA_BUG_ON(xa, xas_store_noinit(&xas, xa_mk_index(min)) != xa_mk_index(index));
 	xas_unlock(&xas);
 	XA_BUG_ON(xa, xa_load(xa, min) != xa_mk_index(min));
 	XA_BUG_ON(xa, xa_load(xa, max - 1) != xa_mk_index(min));
@@ -535,7 +535,7 @@ static noinline void check_multi_store_2(struct xarray *xa, unsigned long index,
 	xa_store_order(xa, index, order, xa_mk_value(0), GFP_KERNEL);
 
 	xas_lock(&xas);
-	XA_BUG_ON(xa, xas_store(&xas, xa_mk_value(1)) != xa_mk_value(0));
+	XA_BUG_ON(xa, xas_store_noinit(&xas, xa_mk_value(1)) != xa_mk_value(0));
 	XA_BUG_ON(xa, xas.xa_index != index);
 	XA_BUG_ON(xa, xas_erase(&xas) != xa_mk_value(1));
 	xas_unlock(&xas);
@@ -854,7 +854,7 @@ static noinline void __check_store_iter(struct xarray *xa, unsigned long start,
 		XA_BUG_ON(xa, entry > xa_mk_index(start + (1UL << order) - 1));
 		count++;
 	}
-	xas_store(&xas, xa_mk_index(start));
+	xas_store_noinit(&xas, xa_mk_index(start));
 	xas_unlock(&xas);
 	if (xas_nomem(&xas, GFP_KERNEL)) {
 		count = 0;
@@ -1365,7 +1365,7 @@ static noinline void xa_store_many_order(struct xarray *xa,
 		if (xas_error(&xas))
 			goto unlock;
 		for (i = 0; i < (1U << order); i++) {
-			XA_BUG_ON(xa, xas_store(&xas, xa_mk_index(index + i)));
+			XA_BUG_ON(xa, xas_store_noinit(&xas, xa_mk_index(index + i)));
 			xas_next(&xas);
 		}
 unlock:
@@ -1420,7 +1420,7 @@ static noinline void check_create_range_4(struct xarray *xa,
 		if (xas_error(&xas))
 			goto unlock;
 		for (i = 0; i < (1UL << order); i++) {
-			void *old = xas_store(&xas, xa_mk_index(base + i));
+			void *old = xas_store_noinit(&xas, xa_mk_index(base + i));
 			if (xas.xa_index == index)
 				XA_BUG_ON(xa, old != xa_mk_index(base + i));
 			else
@@ -1594,9 +1594,9 @@ static noinline void check_workingset(struct xarray *xa, unsigned long index)
 
 	do {
 		xas_lock(&xas);
-		xas_store(&xas, xa_mk_value(0));
+		xas_store_noinit(&xas, xa_mk_value(0));
 		xas_next(&xas);
-		xas_store(&xas, xa_mk_value(1));
+		xas_store_noinit(&xas, xa_mk_value(1));
 		xas_unlock(&xas);
 	} while (xas_nomem(&xas, GFP_KERNEL));
 
@@ -1604,10 +1604,10 @@ static noinline void check_workingset(struct xarray *xa, unsigned long index)
 
 	xas_lock(&xas);
 	xas_next(&xas);
-	xas_store(&xas, &xas);
+	xas_store_noinit(&xas, &xas);
 	XA_BUG_ON(xa, !list_empty(&shadow_nodes));
 
-	xas_store(&xas, xa_mk_value(2));
+	xas_store_noinit(&xas, xa_mk_value(2));
 	xas_unlock(&xas);
 	XA_BUG_ON(xa, list_empty(&shadow_nodes));
 
diff --git a/tools/testing/radix-tree/iteration_check.c b/tools/testing/radix-tree/iteration_check.c
index e9908bcb06dd..ce110e96757c 100644
--- a/tools/testing/radix-tree/iteration_check.c
+++ b/tools/testing/radix-tree/iteration_check.c
@@ -31,7 +31,7 @@ void my_item_insert(struct xarray *xa, unsigned long index)
 		item->order = order;
 		if (xas_find_conflict(&xas))
 			continue;
-		xas_store(&xas, item);
+		xas_store_noinit(&xas, item);
 		xas_set_mark(&xas, TAG);
 		break;
 	}
diff --git a/tools/testing/radix-tree/multiorder.c b/tools/testing/radix-tree/multiorder.c
index 9eae0fb5a67d..695a562d5ff1 100644
--- a/tools/testing/radix-tree/multiorder.c
+++ b/tools/testing/radix-tree/multiorder.c
@@ -20,7 +20,7 @@ static int item_insert_order(struct xarray *xa, unsigned long index,
 
 	do {
 		xas_lock(&xas);
-		xas_store(&xas, item);
+		xas_store_noinit(&xas, item);
 		xas_unlock(&xas);
 	} while (xas_nomem(&xas, GFP_KERNEL));
 
-- 
2.16.4

