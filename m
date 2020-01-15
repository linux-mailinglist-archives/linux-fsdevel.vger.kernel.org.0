Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F16813B7CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 03:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbgAOCiu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 21:38:50 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38840 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728879AbgAOCit (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 21:38:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=t2MsvrgFyKMklh8a9GSQdPemnFwCPtSVERkAiF6+ogA=; b=B8m47kZ4X+h0DMHQn1K+2rOHkY
        hwLKteFLytNaxEKnzlCSBDAJz0fJXaVd/spdpfgD0HTWbcfet0LZg+hZP4G1sqBZaNQwr4R8vvEzZ
        o3Dv6Ei3shJPPTdAqLbFiXyNvlj5/VrpfNTgt4xD0uBSu63frPzORfwhbgpYRVDfuvGTNCORNmu63
        Q6hT/xWyrtBntiw54OYBsTjk2J7buSZ/I6G6vvtTzXrbzW1rCypYEonPrY9wKI4I45WI1TMi8rp2W
        WLz8zHyQwCFyXamXHDqJ/NSvq/OmfNQiqOPKz2C2S0GDsUQW+cyQO3VQe+cPw/2uYQnCOA07g5pVL
        EiuVVrOg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1irYZy-0008AY-2O; Wed, 15 Jan 2020 02:38:46 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Chris Mason <clm@fb.com>
Subject: [PATCH v2 3/9] XArray: Add xarray_for_each_range
Date:   Tue, 14 Jan 2020 18:38:37 -0800
Message-Id: <20200115023843.31325-4-willy@infradead.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200115023843.31325-1-willy@infradead.org>
References: <20200115023843.31325-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

This function supports iterating over a range of an array.  Also add
documentation links for xarray_for_each_start().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 Documentation/core-api/xarray.rst | 10 ++++++----
 include/linux/xarray.h            | 30 ++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/Documentation/core-api/xarray.rst b/Documentation/core-api/xarray.rst
index fcedc5349ace..95a732b5c848 100644
--- a/Documentation/core-api/xarray.rst
+++ b/Documentation/core-api/xarray.rst
@@ -94,10 +94,10 @@ calling xa_clear_mark().  You can ask whether any entry in the
 XArray has a particular mark set by calling xa_marked().
 
 You can copy entries out of the XArray into a plain array by calling
-xa_extract().  Or you can iterate over the present entries in
-the XArray by calling xa_for_each().  You may prefer to use
-xa_find() or xa_find_after() to move to the next present
-entry in the XArray.
+xa_extract().  Or you can iterate over the present entries in the XArray
+by calling xa_for_each(), xa_for_each_start() or xa_for_each_range().
+You may prefer to use xa_find() or xa_find_after() to move to the next
+present entry in the XArray.
 
 Calling xa_store_range() stores the same entry in a range
 of indices.  If you do this, some of the other operations will behave
@@ -180,6 +180,8 @@ No lock needed:
 Takes RCU read lock:
  * xa_load()
  * xa_for_each()
+ * xa_for_each_start()
+ * xa_for_each_range()
  * xa_find()
  * xa_find_after()
  * xa_extract()
diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index 86eecbd98e84..a06cb555fe23 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -445,6 +445,36 @@ static inline bool xa_marked(const struct xarray *xa, xa_mark_t mark)
 	     entry;							\
 	     entry = xa_find_after(xa, &index, ULONG_MAX, XA_PRESENT))
 
+/**
+ * xa_for_each_range() - Iterate over a portion of an XArray.
+ * @xa: XArray.
+ * @index: Index of @entry.
+ * @entry: Entry retrieved from array.
+ * @start: First index to retrieve from array.
+ * @last: Last index to retrieve from array.
+ *
+ * During the iteration, @entry will have the value of the entry stored
+ * in @xa at @index.  You may modify @index during the iteration if you
+ * want to skip or reprocess indices.  It is safe to modify the array
+ * during the iteration.  At the end of the iteration, @entry will be set
+ * to NULL and @index will have a value less than or equal to max.
+ *
+ * xa_for_each_range() is O(n.log(n)) while xas_for_each() is O(n).  You have
+ * to handle your own locking with xas_for_each(), and if you have to unlock
+ * after each iteration, it will also end up being O(n.log(n)).
+ * xa_for_each_range() will spin if it hits a retry entry; if you intend to
+ * see retry entries, you should use the xas_for_each() iterator instead.
+ * The xas_for_each() iterator will expand into more inline code than
+ * xa_for_each_range().
+ *
+ * Context: Any context.  Takes and releases the RCU lock.
+ */
+#define xa_for_each_range(xa, index, entry, start, last)		\
+	for (index = start,						\
+	     entry = xa_find(xa, &index, last, XA_PRESENT);		\
+	     entry;							\
+	     entry = xa_find_after(xa, &index, last, XA_PRESENT))
+
 /**
  * xa_for_each() - Iterate over present entries in an XArray.
  * @xa: XArray.
-- 
2.24.1

