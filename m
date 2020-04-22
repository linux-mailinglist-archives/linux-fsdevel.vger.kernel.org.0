Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8C31B4812
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Apr 2020 17:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbgDVPDJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Apr 2020 11:03:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:58110 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728118AbgDVPDI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Apr 2020 11:03:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 915BAAE84;
        Wed, 22 Apr 2020 15:03:03 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B8E611E0F8C; Wed, 22 Apr 2020 17:03:03 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 23/23] xarray: Remove xas_store()
Date:   Wed, 22 Apr 2020 17:02:56 +0200
Message-Id: <20200422150256.23473-24-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200422150256.23473-1-jack@suse.cz>
References: <20200422150256.23473-1-jack@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

xas_store() now has no users as every call site has been transitioned
either to xas_erase() or to xas_store_noinit(). Remove xas_store() and
all remaining traces of it.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 Documentation/core-api/xarray.rst |  4 ++--
 include/linux/xarray.h            |  1 -
 lib/xarray.c                      | 14 ++++----------
 3 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/Documentation/core-api/xarray.rst b/Documentation/core-api/xarray.rst
index 640934b6f7b4..1c201628a15a 100644
--- a/Documentation/core-api/xarray.rst
+++ b/Documentation/core-api/xarray.rst
@@ -394,7 +394,7 @@ You can use xas_init_marks() to reset the marks on an entry
 to their default state.  This is usually all marks clear, unless the
 XArray is marked with ``XA_FLAGS_TRACK_FREE``, in which case mark 0 is set
 and all other marks are clear.  Replacing one entry with another using
-xas_store() will not reset the marks on that entry; if you want
+xas_store_noinit() will not reset the marks on that entry; if you want
 the marks reset, you should do that explicitly.
 
 The xas_load() will walk the xa_state as close to the entry
@@ -458,7 +458,7 @@ save substantial quantities of memory; for example tying 512 entries
 together will save over 4kB.
 
 You can create a multi-index entry by using XA_STATE_ORDER()
-or xas_set_order() followed by a call to xas_store().
+or xas_set_order() followed by a call to xas_store_noinit().
 Calling xas_load() with a multi-index xa_state will walk the
 xa_state to the right location in the tree, but the return value is not
 meaningful, potentially being an internal entry or ``NULL`` even when there
diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index 06acef49ec95..680c0dcaeb12 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -1490,7 +1490,6 @@ static inline bool xas_retry(struct xa_state *xas, const void *entry)
 }
 
 void *xas_load(struct xa_state *);
-void *xas_store(struct xa_state *, void *entry);
 void *xas_store_noinit(struct xa_state *, void *entry);
 void *xas_erase(struct xa_state *);
 void *xas_find(struct xa_state *, unsigned long max);
diff --git a/lib/xarray.c b/lib/xarray.c
index d87045d120ad..2912d706dc01 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -625,7 +625,7 @@ static int xas_expand(struct xa_state *xas, void *head)
  * @allow_root: %true if we can store the entry in the root directly
  *
  * Most users will not need to call this function directly, as it is called
- * by xas_store().  It is useful for doing conditional store operations
+ * by xas_store_noinit().  It is useful for doing conditional store operations
  * (see the xa_cmpxchg() implementation for an example).
  *
  * Return: If the slot already existed, returns the contents of this slot.
@@ -820,7 +820,7 @@ static void *__xas_store(struct xa_state *xas, void *entry, bool init_marks)
 }
 
 /**
- * xas_store() - Store this entry in the XArray.
+ * xas_store_noinit() - Store this entry in the XArray.
  * @xas: XArray operation state.
  * @entry: New entry.
  *
@@ -828,17 +828,11 @@ static void *__xas_store(struct xa_state *xas, void *entry, bool init_marks)
  * function is essentially meaningless (it may be an internal entry or it
  * may be %NULL, even if there are non-NULL entries at some of the indices
  * covered by the range).  This is not a problem for any current users,
- * and can be changed if needed.
+ * and can be changed if needed. Note that this function does not affect
+ * xarray marks.
  *
  * Return: The old entry at this index.
  */
-void *xas_store(struct xa_state *xas, void *entry)
-{
-	return __xas_store(xas, entry, true);
-}
-EXPORT_SYMBOL_GPL(xas_store);
-
-/* This is like xas_store() but does not initialize marks on stored entry */
 void *xas_store_noinit(struct xa_state *xas, void *entry)
 {
 	return __xas_store(xas, entry, false);
-- 
2.16.4

