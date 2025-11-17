Return-Path: <linux-fsdevel+bounces-68802-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 362F6C66793
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 23:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id D28B72A3D2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 22:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6675334E771;
	Mon, 17 Nov 2025 22:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c0Fotxn3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EAB34DCE1
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 22:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763419642; cv=none; b=q5INySKdwf6LjdKhnQTUrxlUULykply0PSzQ6RZJZUInK5OUX/dSlboiY5aGSDwOElueWRvoiLpkpoiekoSQS4vEoMGSgPMujiyfcCjzpy4oBAbqf74TlRDWUg+/LZWgyXHyRIHlb0V5L2hTGeqCgQsAQ4p9LvugBEH9q3WG+bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763419642; c=relaxed/simple;
	bh=rm96RSIZb4LTBvdrh7YmVYysakvIeRYfKKwfcyCMsaM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fWyfx0Gd/OzrSisvvKwKD19BMcFFSLXoJk0p4xtLYEU124dyUZuR0GZzdKg4e1PvkiFjf75IwnrIWu/S7royQl02qODpeBAQWK+VCq//+aIJq1qTCgIHBLCFkw9ish4OF5DXELCjyl66y6kAizjNwcQeRI2/BLeLusaJJtcIJoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c0Fotxn3; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-297f587dc2eso84161055ad.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 14:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763419640; x=1764024440; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h49/4ez8nB53RwngFZBAQKZZnMeHtus1TaIAc+Tmfyk=;
        b=c0Fotxn336osBdfMC25aWx0+mzKseoAmoIBsxrkeZMfxrC/n8NnOVangr+fOi5K3F2
         2E5CcegaucEoDd+htJcqn4nc/Tgh4pTqA24ecaNrOdi/xayAmbcKrxylx6u95ePkSJkO
         ucYYAxKJRFHhex2yKwUZeSqnsKs9KAXFCrrqR3w94YFAhOkRQkrOkhGcx8yG6YZUaNSy
         ujN6oulyt9LM3KDQHBkmUWbcpDp84/TBF4xxnuGTRwHUGWXMyTGW4avwHgaWl4dy5pi3
         sphe1LP5e4mdP4DznX/wcKxAgFcD5ATuCmU50A3KogbEUvE0W2EBP2pExe1u41sOLlsM
         HBMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763419640; x=1764024440;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h49/4ez8nB53RwngFZBAQKZZnMeHtus1TaIAc+Tmfyk=;
        b=o8QInC4iWHuXZFzuwAE12pvzlF99a8pfo84MIH+vpnaYo9OgqM9BdNiGCrHjLM5Ljz
         CUYjfxFfgK1JBQycwrSbb/rGR1BUgRpfalshii2jLA8ENUf/yWjq1mrYx25f1yBWAw6M
         NNrAYQ1yqYjtl4Z2I2A+W8Wp7C8aBt/tby4Wva3HiTwXSf1/wxUJ7VTj7PeuuPl1BE0C
         0mc4JbJ4YfbUgW77NoRFX26D2nz1bJueZrVToJR8MKq6qbuMyUYXPdgcaAXWUuqUA5Oa
         cwMXDv6ZB6EwLEOaEvycQItCrZPdtAaSeMsQVoWAdeic2GyI4KcYSa3+ZmoS03APYu0T
         UpWA==
X-Forwarded-Encrypted: i=1; AJvYcCUvIidfSE3chA0G1BptAamZJiGUADDWIk0C8quH9cvURnvXz/AzYCpz3fhcjRttJJR1OFMBq3VEDevCw9gU@vger.kernel.org
X-Gm-Message-State: AOJu0YzcVUYOmDJiayb5qhlqZKZ77pXlV1Em+2uG5FhJPLHGWItKzdm7
	pTxgkUGLuVunipTY3m+GmxKaG8uz/J23x+2bL8UfeGyqo4ZS7SzRNLHbWkKrcsscOWbiloiKc1j
	oSzRkc/vqD7Fcy8k0QkqX2y6XGQ==
X-Google-Smtp-Source: AGHT+IHWA3n4fRLuQQDbvqes2g4fdvBQx26NqKHJhSXAuqe2xxxf8ttHYK65SO+WREJuuBGajBPt+OclghSCG+uvxQ==
X-Received: from plok14.prod.google.com ([2002:a17:903:3bce:b0:297:ecd0:777a])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f691:b0:295:6a9:cb62 with SMTP id d9443c01a7336-2986a73b4a7mr170440805ad.35.1763419639915;
 Mon, 17 Nov 2025 14:47:19 -0800 (PST)
Date: Mon, 17 Nov 2025 14:47:00 -0800
In-Reply-To: <20251117224701.1279139-1-ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251117224701.1279139-1-ackerleytng@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251117224701.1279139-4-ackerleytng@google.com>
Subject: [RFC PATCH 3/4] XArray: Support splitting for arbitrarily large entries
From: Ackerley Tng <ackerleytng@google.com>
To: willy@infradead.org, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: david@redhat.com, michael.roth@amd.com, vannapurve@google.com, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

The existing xas_split() function primarily supports splitting an entry
into multiple siblings within the current node, or creating child nodes for
one level below.

It does not handle scenarios where the requested split order requires
wiring up multiple levels of new intermediate nodes to form a deeper
subtree. This limits the xas_split() from splitting arbitrarily large
entries.

This commit extends xas_split() to build subtrees of XArray nodes and then
set these subtrees as children of the node where the split is requested.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---

I had a recursive implementation which I believe was easier to understand, but I
went with a iterative implementation using a stack because I was concerned about
stack depths in the kernel. Let me know if the recursive implementation is
preferred!

Feedback is always appreciated, and I'd specifically like feedback on:

+ RCU-related handling
+ Handling of xas_update() calls
+ Use of node_set_marks() - can/should that be refactored to be node-focused,
  rather than in some cases also updating the child?
+ Can/should xas_split_alloc() read entry using xas_load(), rather than rely on
  void *entry passed as an argument?


 lib/xarray.c | 158 +++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 121 insertions(+), 37 deletions(-)

diff --git a/lib/xarray.c b/lib/xarray.c
index b7c44a75bb03..6fdace2e73df 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -1105,52 +1105,136 @@ EXPORT_SYMBOL_GPL(xas_split_alloc);
 void xas_split(struct xa_state *xas, void *entry, unsigned int order)
 {
 	unsigned int sibs = (1 << (order % XA_CHUNK_SHIFT)) - 1;
-	unsigned int offset, marks;
+	struct xa_node *node_to_split;
+	unsigned int offset_to_split;
+	struct xa_node *stack;
 	struct xa_node *node;
-	void *curr = xas_load(xas);
-	int values = 0;
+	unsigned int offset;
+	unsigned int marks;
+	unsigned int i;
+	void *sibling;

-	node = xas->xa_node;
-	if (xas_top(node))
+	xas_load(xas);
+	node_to_split = xas->xa_node;
+	if (xas_top(node_to_split))
 		return;

-	marks = node_get_marks(node, xas->xa_offset);
+	marks = node_get_marks(node_to_split, xas->xa_offset);

-	offset = xas->xa_offset + sibs;
-	do {
-		if (xas->xa_shift < node->shift) {
-			struct xa_node *child = xas->xa_alloc;
-
-			xas->xa_alloc = rcu_dereference_raw(child->parent);
-			__xas_init_node_for_split(xas, child, entry);
-			child->shift = node->shift - XA_CHUNK_SHIFT;
-			child->offset = offset;
-			child->count = XA_CHUNK_SIZE;
-			child->nr_values = xa_is_value(entry) ?
-					XA_CHUNK_SIZE : 0;
-			RCU_INIT_POINTER(child->parent, node);
-			node_set_marks(node, offset, child, xas->xa_sibs,
-					marks);
-			rcu_assign_pointer(node->slots[offset],
-					xa_mk_node(child));
-			if (xa_is_value(curr))
-				values--;
-			xas_update(xas, child);
+	/* Horizontal split: just fill in values in existing node. */
+	if (node_to_split->shift == xas->xa_shift) {
+		offset = xas->xa_offset;
+
+		for (i = offset; i < offset + sibs + 1; i++) {
+			if ((i & xas->xa_sibs) == 0) {
+				node_set_marks(node_to_split, i, NULL, 0, marks);
+				rcu_assign_pointer(node_to_split->slots[i], entry);
+
+				sibling = xa_mk_sibling(i);
+			} else {
+				rcu_assign_pointer(node_to_split->slots[i], sibling);
+			}
+		}
+
+		xas_update(xas, node_to_split);
+		return;
+	}
+
+	/*
+	 * Vertical split: build tree bottom-up, so that on any RCU lookup (on
+	 * the original tree), the tree is consistent.
+	 */
+	offset_to_split = get_offset(xas->xa_index, node_to_split);
+	stack = NULL;
+	offset = 0;
+	for (;;) {
+		unsigned int next_offset;
+
+		if (stack &&
+		    stack->shift == node_to_split->shift - XA_CHUNK_SHIFT &&
+		    stack->offset == offset_to_split + sibs)
+			break;
+
+		if (stack && stack->offset == XA_CHUNK_SIZE - 1) {
+			unsigned int child_shift;
+
+			node = xas->xa_alloc;
+			xas->xa_alloc = rcu_dereference_raw(node->parent);
+
+			child_shift = stack->shift;
+			for (i = 0; i < XA_CHUNK_SIZE; i++) {
+				struct xa_node *child = stack;
+
+				stack = child->parent;
+
+				node_set_marks(node, child->offset, NULL, 0, marks);
+
+				RCU_INIT_POINTER(child->parent, node);
+				RCU_INIT_POINTER(node->slots[child->offset], xa_mk_node(child));
+			}
+
+			node->array = xas->xa;
+			node->count = XA_CHUNK_SIZE;
+			node->nr_values = 0;
+			node->shift = child_shift + XA_CHUNK_SHIFT;
+			node->offset = 0;
+			if (node->shift == node_to_split->shift - XA_CHUNK_SHIFT)
+				node->offset = offset_to_split;
+			if (stack && stack->shift == node->shift)
+				node->offset = stack->offset + 1;
+
+			next_offset = 0;
+
+			xas_update(xas, node);
 		} else {
-			unsigned int canon = offset - xas->xa_sibs;
+			node = xas->xa_alloc;
+			xas->xa_alloc = rcu_dereference_raw(node->parent);

-			node_set_marks(node, canon, NULL, 0, marks);
-			rcu_assign_pointer(node->slots[canon], entry);
-			while (offset > canon)
-				rcu_assign_pointer(node->slots[offset--],
-						xa_mk_sibling(canon));
-			values += (xa_is_value(entry) - xa_is_value(curr)) *
-					(xas->xa_sibs + 1);
+			for (i = 0; i < XA_CHUNK_SIZE; i++) {
+				if ((i & xas->xa_sibs) == 0) {
+					node_set_marks(node, i, NULL, 0, marks);
+					RCU_INIT_POINTER(node->slots[i], entry);
+
+					sibling = xa_mk_sibling(i);
+				} else {
+					RCU_INIT_POINTER(node->slots[i], sibling);
+				}
+			}
+
+			node->array = xas->xa;
+			node->count = XA_CHUNK_SIZE;
+			node->nr_values = xa_is_value(entry) ? XA_CHUNK_SIZE : 0;
+			node->shift = xas->xa_shift;
+			node->offset = offset;
+			if (node->shift == node_to_split->shift - XA_CHUNK_SHIFT)
+				node->offset = offset_to_split;
+			if (stack && stack->shift == node->shift)
+				node->offset = stack->offset + 1;
+
+			next_offset = offset + 1;
 		}
-	} while (offset-- > xas->xa_offset);

-	node->nr_values += values;
-	xas_update(xas, node);
+		node->parent = stack;
+		stack = node;
+
+		offset = next_offset;
+	}
+
+	/* Combine all the new nodes on the stack into node_to_split. */
+	for (i = 0; i < sibs + 1; i++) {
+		node = stack;
+		stack = node->parent;
+
+		node_set_marks(node_to_split, node->offset, NULL, 0, marks);
+
+		rcu_assign_pointer(node->parent, node_to_split);
+		rcu_assign_pointer(node_to_split->slots[node->offset], xa_mk_node(node));
+	}
+
+	WARN_ON(stack);
+
+	node_to_split->nr_values -= xa_is_value(entry) ? sibs + 1 : 0;
+	xas_update(xas, node_to_split);
 }
 EXPORT_SYMBOL_GPL(xas_split);

--
2.52.0.rc1.455.g30608eb744-goog

