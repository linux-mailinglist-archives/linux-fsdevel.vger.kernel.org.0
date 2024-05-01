Return-Path: <linux-fsdevel+bounces-18434-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 293F28B8D28
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 17:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D34A2289E3B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 15:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0375132C23;
	Wed,  1 May 2024 15:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EezvSwcv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DACF12FF70
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 May 2024 15:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714577490; cv=none; b=HtCqw91YjeDeYWv+82CvS1GhT3TYy+dDYpNLBv+EBynonGT4UtCUh255Lgt1dG8A5XYz4fze/BFWlHYWLPGgfOpGLVQm1PZAcNVM4dzuktdJxyrmn3N9IgmvboOkKRC9XzucscaY+uKZhyFJzToHDlNbebh1FeWyocmY4mx0ShE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714577490; c=relaxed/simple;
	bh=mRhqKyKQM7kmXtTGBCehmVbF99rjAE4eA92doUiUT9M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e6QLUVPqrq5htVnOXbd9qN8H0Gcr6lYcS183laYtYca4aX5HEfbIiasOjvTISzIUtlRPOrsEA43vLjUnfnB5EdXHAN+GlPtBIEPcI38/kZ0lI+hOX+yXJUE+drHIzWu4p/Tvs1wTxwzFHhm2OzrZJaTHAz3LZtsXsdvGx1EFtks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EezvSwcv; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=XZIMUVzeCJFd/i9fs7YI0OvweKFJssoNWijoVhKZP4M=; b=EezvSwcvlmxK90Q6NuYmO18x6I
	M0B1IRc9HRN3oK2TGfh0Md5hYoTKFRBM3xcBk74Va8UJKNF+gx3dZetJZ2xQMXNe3d3AcvZo32tBR
	1jD5TSVDVzjpl/NldRB0XBrwoRZP/R3BjrErpQrviNyZyOiqNuycFP4LtCrJPXWUqh1jGmBoDw7rR
	+jFQVDbRRwj88faJp8DrxFPGW/f5IF9IqiGHbZeITDRBHomzbmFY+QH++9iAnht5qbFRJJL3tjpGY
	SaJueaYP4iRWbjJIHoFDeC4H5Wp8chmDzsIOFAfe+CZmhDAezY8VRpn5vBcCEKrQ+s7omugfTuft+
	4XmqnjDw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2BvV-0000000HBB0-2Wrz;
	Wed, 01 May 2024 15:31:21 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH] XArray: Set the marks correctly when splitting an entry
Date: Wed,  1 May 2024 16:31:18 +0100
Message-ID: <20240501153120.4094530-1-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If we created a new node to replace an entry which had search marks set,
we were setting the search mark on every entry in that node.  That works
fine when we're splitting to order 0, but when splitting to a larger
order, we must not set the search marks on the sibling entries.

Reported-by: Luis Chamberlain <mcgrof@kernel.org>
Link: https://lore.kernel.org/r/ZjFGCOYk3FK_zVy3@bombadil.infradead.org
Fixes: c010d47f107f ("mm: thp: split huge page to any lower order pages")
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 lib/test_xarray.c | 14 +++++++++++++-
 lib/xarray.c      | 23 +++++++++++++++++++----
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/lib/test_xarray.c b/lib/test_xarray.c
index 0aea6a85099d..ab9cc42a0d74 100644
--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -1788,9 +1788,11 @@ static void check_split_1(struct xarray *xa, unsigned long index,
 				unsigned int order, unsigned int new_order)
 {
 	XA_STATE_ORDER(xas, xa, index, new_order);
-	unsigned int i;
+	unsigned int i, found;
+	void *entry;
 
 	xa_store_order(xa, index, order, xa, GFP_KERNEL);
+	xa_set_mark(xa, index, XA_MARK_1);
 
 	xas_split_alloc(&xas, xa, order, GFP_KERNEL);
 	xas_lock(&xas);
@@ -1807,6 +1809,16 @@ static void check_split_1(struct xarray *xa, unsigned long index,
 	xa_set_mark(xa, index, XA_MARK_0);
 	XA_BUG_ON(xa, !xa_get_mark(xa, index, XA_MARK_0));
 
+	xas_set_order(&xas, index, 0);
+	found = 0;
+	rcu_read_lock();
+	xas_for_each_marked(&xas, entry, ULONG_MAX, XA_MARK_1) {
+		found++;
+		XA_BUG_ON(xa, xa_is_internal(entry));
+	}
+	rcu_read_unlock();
+	XA_BUG_ON(xa, found != 1 << (order - new_order));
+
 	xa_destroy(xa);
 }
 
diff --git a/lib/xarray.c b/lib/xarray.c
index 1c87d871cacf..32d4bac8c94c 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -970,8 +970,22 @@ static unsigned int node_get_marks(struct xa_node *node, unsigned int offset)
 	return marks;
 }
 
+static inline void node_mark_slots(struct xa_node *node, unsigned int sibs,
+		xa_mark_t mark)
+{
+	int i;
+
+	if (sibs == 0)
+		node_mark_all(node, mark);
+	else {
+		for (i = 0; i < XA_CHUNK_SIZE; i += sibs + 1)
+			node_set_mark(node, i, mark);
+	}
+}
+
 static void node_set_marks(struct xa_node *node, unsigned int offset,
-			struct xa_node *child, unsigned int marks)
+			struct xa_node *child, unsigned int sibs,
+			unsigned int marks)
 {
 	xa_mark_t mark = XA_MARK_0;
 
@@ -979,7 +993,7 @@ static void node_set_marks(struct xa_node *node, unsigned int offset,
 		if (marks & (1 << (__force unsigned int)mark)) {
 			node_set_mark(node, offset, mark);
 			if (child)
-				node_mark_all(child, mark);
+				node_mark_slots(child, sibs, mark);
 		}
 		if (mark == XA_MARK_MAX)
 			break;
@@ -1078,7 +1092,8 @@ void xas_split(struct xa_state *xas, void *entry, unsigned int order)
 			child->nr_values = xa_is_value(entry) ?
 					XA_CHUNK_SIZE : 0;
 			RCU_INIT_POINTER(child->parent, node);
-			node_set_marks(node, offset, child, marks);
+			node_set_marks(node, offset, child, xas->xa_sibs,
+					marks);
 			rcu_assign_pointer(node->slots[offset],
 					xa_mk_node(child));
 			if (xa_is_value(curr))
@@ -1087,7 +1102,7 @@ void xas_split(struct xa_state *xas, void *entry, unsigned int order)
 		} else {
 			unsigned int canon = offset - xas->xa_sibs;
 
-			node_set_marks(node, canon, NULL, marks);
+			node_set_marks(node, canon, NULL, 0, marks);
 			rcu_assign_pointer(node->slots[canon], entry);
 			while (offset > canon)
 				rcu_assign_pointer(node->slots[offset--],
-- 
2.43.0


