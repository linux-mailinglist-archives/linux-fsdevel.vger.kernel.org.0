Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8851B4832
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Apr 2020 17:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgDVPDG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Apr 2020 11:03:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:57982 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725980AbgDVPDF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Apr 2020 11:03:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 225EEAD7C;
        Wed, 22 Apr 2020 15:03:03 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5F6931E0E72; Wed, 22 Apr 2020 17:03:03 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 03/23] xarray: Use xas_store_noinit() in __xa_store, __xa_insert, __xa_alloc
Date:   Wed, 22 Apr 2020 17:02:36 +0200
Message-Id: <20200422150256.23473-4-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200422150256.23473-1-jack@suse.cz>
References: <20200422150256.23473-1-jack@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These three functions never store NULL in the array so xas_store() is
equivalent to xas_store_noinit(). Replace it.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 lib/xarray.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/xarray.c b/lib/xarray.c
index ed98fc152b17..2eb634e8bf15 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -1079,7 +1079,7 @@ EXPORT_SYMBOL_GPL(__xas_next);
  *
  * If no entry is found and the array is smaller than @max, the iterator
  * is set to the smallest index not yet in the array.  This allows @xas
- * to be immediately passed to xas_store().
+ * to be immediately passed to xas_store_noinit().
  *
  * Return: The entry, if found, otherwise %NULL.
  */
@@ -1145,7 +1145,7 @@ EXPORT_SYMBOL_GPL(xas_find);
  * If no marked entry is found and the array is smaller than @max, @xas is
  * set to the bounds state and xas->xa_index is set to the smallest index
  * not yet in the array.  This allows @xas to be immediately passed to
- * xas_store().
+ * xas_store_noinit().
  *
  * If no entry is found before @max is reached, @xas is set to the restart
  * state.
@@ -1412,7 +1412,7 @@ void *__xa_store(struct xarray *xa, unsigned long index, void *entry, gfp_t gfp)
 		entry = XA_ZERO_ENTRY;
 
 	do {
-		curr = xas_store(&xas, entry);
+		curr = xas_store_noinit(&xas, entry);
 		if (xa_track_free(xa))
 			xas_clear_mark(&xas, XA_FREE_MARK);
 	} while (__xas_nomem(&xas, gfp));
@@ -1517,7 +1517,7 @@ int __xa_insert(struct xarray *xa, unsigned long index, void *entry, gfp_t gfp)
 	do {
 		curr = xas_load(&xas);
 		if (!curr) {
-			xas_store(&xas, entry);
+			xas_store_noinit(&xas, entry);
 			if (xa_track_free(xa))
 				xas_clear_mark(&xas, XA_FREE_MARK);
 		} else {
@@ -1653,7 +1653,7 @@ int __xa_alloc(struct xarray *xa, u32 *id, void *entry,
 			xas_set_err(&xas, -EBUSY);
 		else
 			*id = xas.xa_index;
-		xas_store(&xas, entry);
+		xas_store_noinit(&xas, entry);
 		xas_clear_mark(&xas, XA_FREE_MARK);
 	} while (__xas_nomem(&xas, gfp));
 
-- 
2.16.4

