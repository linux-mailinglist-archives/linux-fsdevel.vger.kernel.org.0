Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 809FE1B4816
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Apr 2020 17:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbgDVPDi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Apr 2020 11:03:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:58160 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728128AbgDVPDJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Apr 2020 11:03:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9A4EAAEA1;
        Wed, 22 Apr 2020 15:03:03 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A7A421E0E81; Wed, 22 Apr 2020 17:03:03 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 19/23] testing: Use xas_erase() to remove entries from xarray
Date:   Wed, 22 Apr 2020 17:02:52 +0200
Message-Id: <20200422150256.23473-20-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200422150256.23473-1-jack@suse.cz>
References: <20200422150256.23473-1-jack@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use xas_erase() instead of xas_store(... NULL) for removing entries from
xarray.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 lib/test_xarray.c               | 10 +++++-----
 tools/testing/radix-tree/test.c |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/test_xarray.c b/lib/test_xarray.c
index d4f97925dbd8..434031fe8d54 100644
--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -318,7 +318,7 @@ static noinline void check_xa_shrink(struct xarray *xa)
 	XA_BUG_ON(xa, xas_load(&xas) != xa_mk_value(1));
 	node = xas.xa_node;
 	XA_BUG_ON(xa, xa_entry_locked(xa, node, 0) != xa_mk_value(0));
-	XA_BUG_ON(xa, xas_store(&xas, NULL) != xa_mk_value(1));
+	XA_BUG_ON(xa, xas_erase(&xas) != xa_mk_value(1));
 	XA_BUG_ON(xa, xa_load(xa, 1) != NULL);
 	XA_BUG_ON(xa, xas.xa_node != XAS_BOUNDS);
 	XA_BUG_ON(xa, xa_entry_locked(xa, node, 0) != XA_RETRY_ENTRY);
@@ -488,13 +488,13 @@ static noinline void check_xas_erase(struct xarray *xa)
 		} while (xas_nomem(&xas, GFP_KERNEL));
 
 		xas_lock(&xas);
-		xas_store(&xas, NULL);
+		xas_erase(&xas);
 
 		xas_set(&xas, 0);
 		j = i;
 		xas_for_each(&xas, entry, ULONG_MAX) {
 			XA_BUG_ON(xa, entry != xa_mk_index(j));
-			xas_store(&xas, NULL);
+			xas_erase(&xas);
 			j++;
 		}
 		xas_unlock(&xas);
@@ -537,7 +537,7 @@ static noinline void check_multi_store_2(struct xarray *xa, unsigned long index,
 	xas_lock(&xas);
 	XA_BUG_ON(xa, xas_store(&xas, xa_mk_value(1)) != xa_mk_value(0));
 	XA_BUG_ON(xa, xas.xa_index != index);
-	XA_BUG_ON(xa, xas_store(&xas, NULL) != xa_mk_value(1));
+	XA_BUG_ON(xa, xas_erase(&xas) != xa_mk_value(1));
 	xas_unlock(&xas);
 	XA_BUG_ON(xa, !xa_empty(xa));
 }
@@ -1582,7 +1582,7 @@ static noinline void shadow_remove(struct xarray *xa)
 		xas.xa_offset = node->offset;
 		xas.xa_shift = node->shift + XA_CHUNK_SHIFT;
 		xas_set_update(&xas, test_update_node);
-		xas_store(&xas, NULL);
+		xas_erase(&xas);
 	}
 	xa_unlock(xa);
 }
diff --git a/tools/testing/radix-tree/test.c b/tools/testing/radix-tree/test.c
index a15d0512e633..07dc2b4dc587 100644
--- a/tools/testing/radix-tree/test.c
+++ b/tools/testing/radix-tree/test.c
@@ -261,7 +261,7 @@ void item_kill_tree(struct xarray *xa)
 		if (!xa_is_value(entry)) {
 			item_free(entry, xas.xa_index);
 		}
-		xas_store(&xas, NULL);
+		xas_erase(&xas);
 	}
 
 	assert(xa_empty(xa));
-- 
2.16.4

