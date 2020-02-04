Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03921151C1E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2020 15:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbgBDOZW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Feb 2020 09:25:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:49674 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727242AbgBDOZV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Feb 2020 09:25:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 801A9AF37;
        Tue,  4 Feb 2020 14:25:18 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E754E1E0BB3; Tue,  4 Feb 2020 15:25:15 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 2/8] xarray: Provide xas_erase() helper
Date:   Tue,  4 Feb 2020 15:25:08 +0100
Message-Id: <20200204142514.15826-3-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200204142514.15826-1-jack@suse.cz>
References: <20200204142514.15826-1-jack@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently xas_store() clears marks when stored value is NULL. This is
somewhat counter-intuitive and also causes measurable performance impact
when mark clearing is not needed (e.g. because marks are already clear).
So provide xas_erase() helper (similarly to existing xa_erase()) which
stores NULL at given index and also takes care of clearing marks. Use
this helper from __xa_erase() and item_kill_tree() in tools/testing.  In
the following patches, callers that use the mark-clearing property of
xas_store() will be converted to xas_erase() and remaining users can
enjoy better performance.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 include/linux/xarray.h          |  1 +
 lib/xarray.c                    | 24 +++++++++++++++++++++++-
 tools/testing/radix-tree/test.c |  2 +-
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index 5370716d7010..be6c6950837e 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -1491,6 +1491,7 @@ static inline bool xas_retry(struct xa_state *xas, const void *entry)
 
 void *xas_load(struct xa_state *);
 void *xas_store(struct xa_state *, void *entry);
+void *xas_erase(struct xa_state *);
 void *xas_find(struct xa_state *, unsigned long max);
 void *xas_find_conflict(struct xa_state *);
 
diff --git a/lib/xarray.c b/lib/xarray.c
index 1d9fab7db8da..ae8b7070e82c 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -1319,6 +1319,28 @@ static void *xas_result(struct xa_state *xas, void *curr)
 	return curr;
 }
 
+/**
+ * xas_erase() - Erase this entry from the XArray
+ * @xas: XArray operation state.
+ *
+ * After this function returns, loading from @index will return %NULL. The
+ * function also clears all marks associated with the @index.  If the index is
+ * part of a multi-index entry, all indices will be erased and none of the
+ * entries will be part of a multi-index entry.
+ *
+ * Return: The entry which used to be at this index.
+ */
+void *xas_erase(struct xa_state *xas)
+{
+	void *entry;
+
+	entry = xas_store(xas, NULL);
+	xas_init_marks(xas);
+
+	return entry;
+}
+EXPORT_SYMBOL(xas_erase);
+
 /**
  * __xa_erase() - Erase this entry from the XArray while locked.
  * @xa: XArray.
@@ -1334,7 +1356,7 @@ static void *xas_result(struct xa_state *xas, void *curr)
 void *__xa_erase(struct xarray *xa, unsigned long index)
 {
 	XA_STATE(xas, xa, index);
-	return xas_result(&xas, xas_store(&xas, NULL));
+	return xas_result(&xas, xas_erase(&xas));
 }
 EXPORT_SYMBOL(__xa_erase);
 
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

