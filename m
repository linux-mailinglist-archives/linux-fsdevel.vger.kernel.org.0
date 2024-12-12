Return-Path: <linux-fsdevel+bounces-37244-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD249EFFC9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 00:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5376818815A2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 23:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF901DE8AA;
	Thu, 12 Dec 2024 23:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hp8+eV8X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB491B07AE
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 23:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734044645; cv=none; b=m6/K4/fCYru+1Ttyk5l/h71yySDJcELN5wtSMAOJ4Ze+AQGsR3kdo/5khH1O+5vQLm10rBL5/mO9RCqiNx/ufUVZ160Q021L/IT+VhABsCTDT6Yuinn/YKuWLQMWL5QHypq+4GlzzwnX+l/rii4M/b8nvlKNmdUQZ9gqzYDwTTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734044645; c=relaxed/simple;
	bh=4VJSAxr2Q4F8FPOlzf8qOeMrTUOemf6hhrS7fHfl8Cs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xp2RE8y8KA6sVTfkbLyAhLOb2suDpGCOflvRCduvBoQPcLiAJ1SPgi2IIECnRMko/5AcBLWIaq19OnfZEFPI3LF0hcX87shZ8a4T77dr16rky73zqp04ZKTtK7nN5N+SSxBVEoO12TmnEnE6rUJNBt4ESVzoV9sYkWrLSeKcW2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hp8+eV8X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46BDDC4CEDD;
	Thu, 12 Dec 2024 23:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734044644;
	bh=4VJSAxr2Q4F8FPOlzf8qOeMrTUOemf6hhrS7fHfl8Cs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Hp8+eV8X76rZrlneVWn8hxyhqVo5frzFQIREqoXyaAqG86qPCtwyUdBy0MiL7EOWo
	 moZsq2tBaxZXNcxpwr3oDaYhQ1WUIg7DIDx+9K7vfDB7K8wjuDG+GL103bbNPdCogX
	 MmsxUUAwzBsILN9sSzymKuthcvrf94Z28fHNGOZPDNAR8AEqMT0h5VWpS7XApQo1LT
	 izxbtmfTiEROiDIFri4kwqbiRBCTEJybIQ0aLLzhX6QcDEckuXJWpqmy7wbwFGiTaI
	 +hvc3QfGGjD2rxkl+NI2zns0MAlK6Em0q6Tt/DfK8zEJ557ZexbU9e3tPZ18pfzui4
	 RPnMMcC8OZW9Q==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 13 Dec 2024 00:03:43 +0100
Subject: [PATCH v3 04/10] rculist: add list_bidir_{del,prev}_rcu()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-work-mount-rbtree-lockless-v3-4-6e3cdaf9b280@kernel.org>
References: <20241213-work-mount-rbtree-lockless-v3-0-6e3cdaf9b280@kernel.org>
In-Reply-To: <20241213-work-mount-rbtree-lockless-v3-0-6e3cdaf9b280@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, 
 Peter Ziljstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3310; i=brauner@kernel.org;
 h=from:subject:message-id; bh=4VJSAxr2Q4F8FPOlzf8qOeMrTUOemf6hhrS7fHfl8Cs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRHZ9+S0YwK0g6PXiRx6KYQj9/6vHs7jf0+1eglLAv1W
 Tb/rXdnRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwESWpDD8r3hib5Wg7sQhfJUt
 +Ntd3i9fK3e4PpSZluWdLs5WvrR7LSPD0zNrRdfPb17/dP1NnX+BmeqBOTpN9crn9RhmHjl4b+Y
 WJgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Currently there is no primitive for retrieving the previous list member.
To do this we need a new deletion primitive that doesn't poison the prev
pointer and a corresponding retrieval helper. Note that it is not valid
to ues both list_del_rcu() and list_bidir_del_rcu() on the same list.

Suggested-by: "Paul E. McKenney" <paulmck@kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/rculist.h | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/include/linux/rculist.h b/include/linux/rculist.h
index 14dfa6008467e803d57f98cfa0275569f1c6a181..270a9ee2f7976b1736545667973265a3bfb7ec41 100644
--- a/include/linux/rculist.h
+++ b/include/linux/rculist.h
@@ -30,6 +30,17 @@ static inline void INIT_LIST_HEAD_RCU(struct list_head *list)
  * way, we must not access it directly
  */
 #define list_next_rcu(list)	(*((struct list_head __rcu **)(&(list)->next)))
+/*
+ * Return the ->prev pointer of a list_head in an rcu safe way. Don't
+ * access it directly.
+ *
+ * Any list traversed with list_bidir_prev_rcu() must never use
+ * list_del_rcu().  Doing so will poison the ->prev pointer that
+ * list_bidir_prev_rcu() relies on, which will result in segfaults.
+ * To prevent these segfaults, use list_bidir_del_rcu() instead
+ * of list_del_rcu().
+ */
+#define list_bidir_prev_rcu(list) (*((struct list_head __rcu **)(&(list)->prev)))
 
 /**
  * list_tail_rcu - returns the prev pointer of the head of the list
@@ -158,6 +169,42 @@ static inline void list_del_rcu(struct list_head *entry)
 	entry->prev = LIST_POISON2;
 }
 
+/**
+ * list_bidir_del_rcu - deletes entry from list without re-initialization
+ * @entry: the element to delete from the list.
+ *
+ * In contrast to list_del_rcu() doesn't poison the prev pointer thus
+ * allowing backwards traversal via list_bidir_prev_rcu().
+ *
+ * Note: list_empty() on entry does not return true after this because
+ * the entry is in a special undefined state that permits RCU-based
+ * lockfree reverse traversal. In particular this means that we can not
+ * poison the forward and backwards pointers that may still be used for
+ * walking the list.
+ *
+ * The caller must take whatever precautions are necessary (such as
+ * holding appropriate locks) to avoid racing with another list-mutation
+ * primitive, such as list_bidir_del_rcu() or list_add_rcu(), running on
+ * this same list. However, it is perfectly legal to run concurrently
+ * with the _rcu list-traversal primitives, such as
+ * list_for_each_entry_rcu().
+ *
+ * Noe that the it is not allowed to use list_del_rcu() and
+ * list_bidir_del_rcu() on the same list.
+ *
+ * Note that list_del_rcu() and list_bidir_del_rcu() must not be used on
+ * the same list.
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


