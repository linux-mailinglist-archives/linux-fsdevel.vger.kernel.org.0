Return-Path: <linux-fsdevel+bounces-37150-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6E59EE60E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 13:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 740C728686E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 12:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247B02153D8;
	Thu, 12 Dec 2024 11:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XF2zBCVj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F47D2153D5
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 11:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734004583; cv=none; b=TKkDbDBJKnrKqoymv2SYLCe9hyVGQ1sJaSZa6IDKBUPsjSb/p6Cg4EsDbznrMYMzH8uaMjZnjU56whO+IX5bQepmLLwWJP97ipcWKX+Frj3b0dZzw7JM17xUpxmTe6v/KstlpF/flkNqTcsHj0u8BhubdDEievjCTTLtOlQkPEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734004583; c=relaxed/simple;
	bh=cmLS3GlKdZz8MW8KJcFOeOz0qdAgcy+OM7/l7RvuS3g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vy+NtxbIZj3nhkJ+y1bhQTAlEif2/srqhtBP6G02e0UFWVoa7JaJT+Tq9gqO7UZ/mwbhKgsWWbmMpoM/k7Q+eGoseO/gDWugy4Q2KZE2qvqjCupA0Ke4PXAIuMF8nq10Uh0sRwziShPPlYGX9hFAubJq28mZLpvAC63es8xDplA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XF2zBCVj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A92AC4CEDD;
	Thu, 12 Dec 2024 11:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734004582;
	bh=cmLS3GlKdZz8MW8KJcFOeOz0qdAgcy+OM7/l7RvuS3g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XF2zBCVj5lchKRgDwUmwOvJTwp59nX8C07qD9DEGXjBtDc5L+EzivCTvSI6sGNwkp
	 c3aG5SadNLRwI/Iy/BwFs8QiHs5gra7G5QQWLeUC1TT6LyoasX9Qdc7cyA+T45eWM8
	 6xkzPt1f0gQqEDreiqM9cXKoNBQPnD241eGLpyjpGLbbiJkYBM0HT3cxEJ6DlAE1qb
	 ahkJigWBXxtd1VZy4UuN7t1cNRKuq+iqR9vBcZkuTtwmlLIMRhRdvzz53H2MoF5jDA
	 KZ+xisLABZGrK+V/JkI/X+1bFGPJKY6qsg5dl4++FZIGpi9nYki94aSAACCKX+Wvzh
	 g8qBX6Uaj/+NQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 12 Dec 2024 12:56:03 +0100
Subject: [PATCH v2 4/8] rculist: add list_bidir_{del,prev}_rcu()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-work-mount-rbtree-lockless-v2-4-4fe6cef02534@kernel.org>
References: <20241212-work-mount-rbtree-lockless-v2-0-4fe6cef02534@kernel.org>
In-Reply-To: <20241212-work-mount-rbtree-lockless-v2-0-4fe6cef02534@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, 
 Peter Ziljstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3022; i=brauner@kernel.org;
 h=from:subject:message-id; bh=cmLS3GlKdZz8MW8KJcFOeOz0qdAgcy+OM7/l7RvuS3g=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRHnY/x3nPl0klftqOnFhkdSlz7fqLy08dl7UKMnh367
 yQ/1BuxdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExEnp3hf8CiL7c1fD6LaN1O
 nsdhLJukHXtuyvGjQqvT+lYu1QhzkGRk2PsuLN30omBFSVe/x4kg54kP7/89uzVRJsvea+37sFB
 +PgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Currently there is no primite for retrieving the previous list member.
To do this we need a new deletion primite that doesn't poison the prev
pointer and a corresponding retrieval helper. Note that it is not valid
to ues both list_del_rcu() and list_bidir_del_rcu() on the same list.

Suggested-by: "Paul E. McKenney" <paulmck@kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/rculist.h | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/include/linux/rculist.h b/include/linux/rculist.h
index 14dfa6008467e803d57f98cfa0275569f1c6a181..c81f9e5a789928ae6825c89325396d638b3e48c5 100644
--- a/include/linux/rculist.h
+++ b/include/linux/rculist.h
@@ -30,6 +30,14 @@ static inline void INIT_LIST_HEAD_RCU(struct list_head *list)
  * way, we must not access it directly
  */
 #define list_next_rcu(list)	(*((struct list_head __rcu **)(&(list)->next)))
+/*
+ * Return the ->prev pointer of a list_head in an rcu safe way. Don't
+ * access it directly.
+ *
+ * In order to use list_bidir_prev_rcu() deletions must only be done via
+ * list_bidir_del() to avoid poisoning the ->prev pointer.
+ */
+#define list_bidir_prev_rcu(list) (*((struct list_head __rcu **)(&(list)->prev)))
 
 /**
  * list_tail_rcu - returns the prev pointer of the head of the list
@@ -158,6 +166,41 @@ static inline void list_del_rcu(struct list_head *entry)
 	entry->prev = LIST_POISON2;
 }
 
+/**
+ * list_bidir_del_rcu - deletes entry from list without re-initialization
+ * @entry: the element to delete from the list.
+ *
+ * In contrat to list_del_rcu() doesn't poison the previous pointer thus
+ * allowing to go backwards via list_prev_bidir_rcu().
+ *
+ * Note: list_empty() on entry does not return true after this,
+ * the entry is in an undefined state. It is useful for RCU based
+ * lockfree traversal.
+ *
+ * In particular, it means that we can not poison the forward
+ * pointers that may still be used for walking the list.
+ *
+ * The caller must take whatever precautions are necessary
+ * (such as holding appropriate locks) to avoid racing
+ * with another list-mutation primitive, such as list_bidir_del_rcu()
+ * or list_add_rcu(), running on this same list.
+ * However, it is perfectly legal to run concurrently with
+ * the _rcu list-traversal primitives, such as
+ * list_for_each_entry_rcu().
+ *
+ * Noe that the it is not allowed to use list_del_rcu() and
+ * list_bidir_del_rcu() on the same list.
+ *
+ * Note that the caller is not permitted to immediately free
+ * the newly deleted entry.  Instead, either synchronize_rcu()
+ * or call_rcu() must be used to defer freeing until an RCU
+ * grace period has elapsed.
+ */
+static inline void list_bidir_del_rcu(struct list_head *entry)
+{
+	__list_del_entry(entry);
+}
+
 /**
  * hlist_del_init_rcu - deletes entry from hash list with re-initialization
  * @n: the element to delete from the hash list.

-- 
2.45.2


