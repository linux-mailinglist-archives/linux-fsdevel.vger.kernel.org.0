Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 585781B4836
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Apr 2020 17:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbgDVPGR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Apr 2020 11:06:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:57990 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbgDVPDG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Apr 2020 11:03:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 20257AD48;
        Wed, 22 Apr 2020 15:03:03 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5BB1A1E0E6E; Wed, 22 Apr 2020 17:03:03 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 02/23] xarray: Provide xas_erase() and xas_store_noinit() helpers
Date:   Wed, 22 Apr 2020 17:02:35 +0200
Message-Id: <20200422150256.23473-3-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200422150256.23473-1-jack@suse.cz>
References: <20200422150256.23473-1-jack@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently xas_store() clears marks when stored value is NULL. This is
somewhat counter-intuitive and also causes measurable performance impact
when mark clearing is not needed (e.g. because marks are already clear).
So provide xas_erase() helper (similarly to existing xa_erase()) which
stores NULL at given index and also takes care of clearing marks. We
also introduce xas_store_noinit() helper that works like xas_store()
except that it does not initialize marks (and thus has better
performance).  In the following patches, all callers of xas_store() will
be converted either to xas_erase() or xas_store_noinit().

Signed-off-by: Jan Kara <jack@suse.cz>
---
 include/linux/xarray.h |  2 ++
 lib/xarray.c           | 59 +++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 46 insertions(+), 15 deletions(-)

diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index 14c893433139..06acef49ec95 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -1491,6 +1491,8 @@ static inline bool xas_retry(struct xa_state *xas, const void *entry)
 
 void *xas_load(struct xa_state *);
 void *xas_store(struct xa_state *, void *entry);
+void *xas_store_noinit(struct xa_state *, void *entry);
+void *xas_erase(struct xa_state *);
 void *xas_find(struct xa_state *, unsigned long max);
 void *xas_find_conflict(struct xa_state *);
 
diff --git a/lib/xarray.c b/lib/xarray.c
index dae68dd13a02..ed98fc152b17 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -753,20 +753,7 @@ static void update_node(struct xa_state *xas, struct xa_node *node,
 		xas_delete_node(xas);
 }
 
-/**
- * xas_store() - Store this entry in the XArray.
- * @xas: XArray operation state.
- * @entry: New entry.
- *
- * If @xas is operating on a multi-index entry, the entry returned by this
- * function is essentially meaningless (it may be an internal entry or it
- * may be %NULL, even if there are non-NULL entries at some of the indices
- * covered by the range).  This is not a problem for any current users,
- * and can be changed if needed.
- *
- * Return: The old entry at this index.
- */
-void *xas_store(struct xa_state *xas, void *entry)
+static void *__xas_store(struct xa_state *xas, void *entry, bool init_marks)
 {
 	struct xa_node *node;
 	void __rcu **slot = &xas->xa->xa_head;
@@ -799,7 +786,7 @@ void *xas_store(struct xa_state *xas, void *entry)
 		if (xas->xa_sibs)
 			xas_squash_marks(xas);
 	}
-	if (!entry)
+	if (init_marks)
 		xas_init_marks(xas);
 
 	for (;;) {
@@ -831,8 +818,33 @@ void *xas_store(struct xa_state *xas, void *entry)
 	update_node(xas, node, count, values);
 	return first;
 }
+
+/**
+ * xas_store() - Store this entry in the XArray.
+ * @xas: XArray operation state.
+ * @entry: New entry.
+ *
+ * If @xas is operating on a multi-index entry, the entry returned by this
+ * function is essentially meaningless (it may be an internal entry or it
+ * may be %NULL, even if there are non-NULL entries at some of the indices
+ * covered by the range).  This is not a problem for any current users,
+ * and can be changed if needed.
+ *
+ * Return: The old entry at this index.
+ */
+void *xas_store(struct xa_state *xas, void *entry)
+{
+	return __xas_store(xas, entry, true);
+}
 EXPORT_SYMBOL_GPL(xas_store);
 
+/* This is like xas_store() but does not initialize marks on stored entry */
+void *xas_store_noinit(struct xa_state *xas, void *entry)
+{
+	return __xas_store(xas, entry, false);
+}
+EXPORT_SYMBOL_GPL(xas_store_noinit);
+
 /**
  * xas_get_mark() - Returns the state of this mark.
  * @xas: XArray operation state.
@@ -1314,6 +1326,23 @@ static void *xas_result(struct xa_state *xas, void *curr)
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
+	return __xas_store(xas, NULL, true);
+}
+EXPORT_SYMBOL(xas_erase);
+
 /**
  * __xa_erase() - Erase this entry from the XArray while locked.
  * @xa: XArray.
-- 
2.16.4

