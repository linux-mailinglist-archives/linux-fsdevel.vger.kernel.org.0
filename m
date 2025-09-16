Return-Path: <linux-fsdevel+bounces-61597-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E065AB58A28
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9D641B2516A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5381B1AC43A;
	Tue, 16 Sep 2025 00:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSy7jGUS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A050CFC1D;
	Tue, 16 Sep 2025 00:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757983933; cv=none; b=p7DaFHVTdxka/aSvGWcdPJPwNd5pyH6YReD4hi98DrlL8Ik8LPQAaFeCeWfAID/AE5QPxvsRb6kLt5AdTaT2le5bxIOyOJl7KaaFCrkE7Z9TERzfjpcP8uB034Pe11/vCHAI2BuX/49Kzo5SBhma9s7xAdwgPULlTkpX5AdK4x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757983933; c=relaxed/simple;
	bh=lf+08GdWdFR1dWusoXZWFCjg958B1RrpyY7aH6EeIwI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NfBFiylikIiuz4oRoITpwcnXBhOiKsb4QfJ2T07Hb5miUaDk54CxLc6eCQSiN++NN1G9Zt6nZ0z/blhWlmi3z3+1xVuI+gHebtugOmR2J1+RcUgVKBb4rqNt6zqDBT5KUlZCh42qkz/itxS0VWCfM+bryw8p6Z+v/UrlBKWO+0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSy7jGUS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 629B4C4CEF1;
	Tue, 16 Sep 2025 00:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757983933;
	bh=lf+08GdWdFR1dWusoXZWFCjg958B1RrpyY7aH6EeIwI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=HSy7jGUSMxzah38JZxlpOhkWcdQsSwHqetAKyNoPXP0ck9NG7a+BJBh3SXaAIcNo7
	 jGCuQjdIZoeCUGSi0xdFRvbQqWN53tHJrqxZbLcjHpB480Vg7pMgrnwbLsHibYvw3L
	 u6lpClX1KTdCihZ7/qfBxF6e7E7LEfD3ejElAWf2XVSq+SQkLpKkMkGq4b31fWpqBA
	 3CihkzjL9mZx0c35uD2afDIyAnMhgtN8M9NqwvVd/8xBuLGoOa33fkjYCv0yEqjhmR
	 puOT0oUiUQDOayd5pcFemi8HRqyg98HHIXHQY0y3o4HIsjNXPFqhzYOKK3OPZr3C2c
	 oY3Nqpg8BfSHw==
Date: Mon, 15 Sep 2025 17:52:12 -0700
Subject: [PATCH 06/21] libsupport: port the kernel list.h to libsupport
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, amir73il@gmail.com,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, John@groves.net,
 bernd@bsbernd.com, joannelkoong@gmail.com
Message-ID: <175798160884.389252.10587862948187647786.stgit@frogsfrogsfrogs>
In-Reply-To: <175798160681.389252.3813376553626224026.stgit@frogsfrogsfrogs>
References: <175798160681.389252.3813376553626224026.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

In the next patch, we're going to add the xfsprogs cache manager code to
e2fsprogs.  That code is going into libsupport so that it doesn't become
part of the libext2fs ABI, and it depends on a richer set of list_head
helpers than what is in kernel-list.h, so port the Linux 6.17 list.h to
libsupport and drop the one in libext2fs.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/ext2fs/jfs_compat.h  |    2 
 lib/ext2fs/kernel-list.h |  111 ------
 lib/support/list.h       |  894 ++++++++++++++++++++++++++++++++++++++++++++++
 debugfs/Makefile.in      |   12 -
 e2fsck/Makefile.in       |   56 +--
 fuse4fs/Makefile.in      |    6 
 lib/e2p/Makefile.in      |    4 
 lib/ext2fs/Makefile.in   |   14 -
 misc/Makefile.in         |   12 -
 misc/tune2fs.c           |    4 
 10 files changed, 947 insertions(+), 168 deletions(-)
 delete mode 100644 lib/ext2fs/kernel-list.h
 create mode 100644 lib/support/list.h


diff --git a/lib/ext2fs/jfs_compat.h b/lib/ext2fs/jfs_compat.h
index 30b05822b6fd4d..8e598bcfa73ef7 100644
--- a/lib/ext2fs/jfs_compat.h
+++ b/lib/ext2fs/jfs_compat.h
@@ -2,7 +2,7 @@
 #ifndef _JFS_COMPAT_H
 #define _JFS_COMPAT_H
 
-#include "kernel-list.h"
+#include "support/list.h"
 #include <errno.h>
 #ifdef HAVE_NETINET_IN_H
 #include <netinet/in.h>
diff --git a/lib/ext2fs/kernel-list.h b/lib/ext2fs/kernel-list.h
deleted file mode 100644
index dd7b8e07dd56c4..00000000000000
--- a/lib/ext2fs/kernel-list.h
+++ /dev/null
@@ -1,111 +0,0 @@
-#ifndef _LINUX_LIST_H
-#define _LINUX_LIST_H
-
-#include "compiler.h"
-
-/*
- * Simple doubly linked list implementation.
- *
- * Some of the internal functions ("__xxx") are useful when
- * manipulating whole lists rather than single entries, as
- * sometimes we already know the next/prev entries and we can
- * generate better code by using them directly rather than
- * using the generic single-entry routines.
- */
-
-struct list_head {
-	struct list_head *next, *prev;
-};
-
-#define LIST_HEAD_INIT(name) { &(name), &(name) }
-
-#define INIT_LIST_HEAD(ptr) do { \
-	(ptr)->next = (ptr); (ptr)->prev = (ptr); \
-} while (0)
-
-#if (!defined(__GNUC__) && !defined(__WATCOMC__))
-#define __inline__
-#endif
-
-/*
- * Insert a new entry between two known consecutive entries.
- *
- * This is only for internal list manipulation where we know
- * the prev/next entries already!
- */
-static __inline__ void __list_add(struct list_head * new,
-	struct list_head * prev,
-	struct list_head * next)
-{
-	next->prev = new;
-	new->next = next;
-	new->prev = prev;
-	prev->next = new;
-}
-
-/*
- * Insert a new entry after the specified head..
- */
-static __inline__ void list_add(struct list_head *new, struct list_head *head)
-{
-	__list_add(new, head, head->next);
-}
-
-/*
- * Insert a new entry at the tail
- */
-static __inline__ void list_add_tail(struct list_head *new, struct list_head *head)
-{
-	__list_add(new, head->prev, head);
-}
-
-/*
- * Delete a list entry by making the prev/next entries
- * point to each other.
- *
- * This is only for internal list manipulation where we know
- * the prev/next entries already!
- */
-static __inline__ void __list_del(struct list_head * prev,
-				  struct list_head * next)
-{
-	next->prev = prev;
-	prev->next = next;
-}
-
-static __inline__ void list_del(struct list_head *entry)
-{
-	__list_del(entry->prev, entry->next);
-}
-
-static __inline__ int list_empty(struct list_head *head)
-{
-	return head->next == head;
-}
-
-/*
- * Splice in "list" into "head"
- */
-static __inline__ void list_splice(struct list_head *list, struct list_head *head)
-{
-	struct list_head *first = list->next;
-
-	if (first != list) {
-		struct list_head *last = list->prev;
-		struct list_head *at = head->next;
-
-		first->prev = head;
-		head->next = first;
-
-		last->next = at;
-		at->prev = last;
-	}
-}
-
-#define list_entry(ptr, type, member) \
-	container_of(ptr, type, member)
-
-#define list_for_each(pos, head) \
-        for (pos = (head)->next; pos != (head); pos = pos->next)
-
-#endif
diff --git a/lib/support/list.h b/lib/support/list.h
new file mode 100644
index 00000000000000..df6c99708e4a8e
--- /dev/null
+++ b/lib/support/list.h
@@ -0,0 +1,894 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_LIST_H
+#define _LINUX_LIST_H
+
+#include <stdbool.h>
+
+struct list_head {
+	struct list_head *next, *prev;
+};
+
+#ifdef __GNUC__
+#define container_of(ptr, type, member) ({				\
+	__typeof__( ((type *)0)->member ) *__mptr = (ptr);	\
+	(type *)( (char *)__mptr - offsetof(type,member) );})
+#else
+#define container_of(ptr, type, member)				\
+	((type *)((char *)(ptr) - offsetof(type, member)))
+#endif
+
+/*
+ * Circular doubly linked list implementation.
+ *
+ * Some of the internal functions ("__xxx") are useful when
+ * manipulating whole lists rather than single entries, as
+ * sometimes we already know the next/prev entries and we can
+ * generate better code by using them directly rather than
+ * using the generic single-entry routines.
+ */
+
+#define LIST_HEAD_INIT(name) { &(name), &(name) }
+
+#define LIST_HEAD(name) \
+	struct list_head name = LIST_HEAD_INIT(name)
+
+/**
+ * INIT_LIST_HEAD - Initialize a list_head structure
+ * @list: list_head structure to be initialized.
+ *
+ * Initializes the list_head to point to itself.  If it is a list header,
+ * the result is an empty list.
+ */
+static inline void INIT_LIST_HEAD(struct list_head *list)
+{
+	list->next = list;
+	list->prev = list;
+}
+
+#ifdef CONFIG_LIST_HARDENED
+
+#ifdef CONFIG_DEBUG_LIST
+# define __list_valid_slowpath
+#else
+# define __list_valid_slowpath __cold __preserve_most
+#endif
+
+/*
+ * Performs the full set of list corruption checks before __list_add().
+ * On list corruption reports a warning, and returns false.
+ */
+bool __list_valid_slowpath __list_add_valid_or_report(struct list_head *new,
+						      struct list_head *prev,
+						      struct list_head *next);
+
+/*
+ * Performs list corruption checks before __list_add(). Returns false if a
+ * corruption is detected, true otherwise.
+ *
+ * With CONFIG_LIST_HARDENED only, performs minimal list integrity checking
+ * inline to catch non-faulting corruptions, and only if a corruption is
+ * detected calls the reporting function __list_add_valid_or_report().
+ */
+static __always_inline bool __list_add_valid(struct list_head *new,
+					     struct list_head *prev,
+					     struct list_head *next)
+{
+	bool ret = true;
+
+	if (!IS_ENABLED(CONFIG_DEBUG_LIST)) {
+		/*
+		 * With the hardening version, elide checking if next and prev
+		 * are NULL, since the immediate dereference of them below would
+		 * result in a fault if NULL.
+		 *
+		 * With the reduced set of checks, we can afford to inline the
+		 * checks, which also gives the compiler a chance to elide some
+		 * of them completely if they can be proven at compile-time. If
+		 * one of the pre-conditions does not hold, the slow-path will
+		 * show a report which pre-condition failed.
+		 */
+		if (likely(next->prev == prev && prev->next == next && new != prev && new != next))
+			return true;
+		ret = false;
+	}
+
+	ret &= __list_add_valid_or_report(new, prev, next);
+	return ret;
+}
+
+/*
+ * Performs the full set of list corruption checks before __list_del_entry().
+ * On list corruption reports a warning, and returns false.
+ */
+bool __list_valid_slowpath __list_del_entry_valid_or_report(struct list_head *entry);
+
+/*
+ * Performs list corruption checks before __list_del_entry(). Returns false if a
+ * corruption is detected, true otherwise.
+ *
+ * With CONFIG_LIST_HARDENED only, performs minimal list integrity checking
+ * inline to catch non-faulting corruptions, and only if a corruption is
+ * detected calls the reporting function __list_del_entry_valid_or_report().
+ */
+static __always_inline bool __list_del_entry_valid(struct list_head *entry)
+{
+	bool ret = true;
+
+	if (!IS_ENABLED(CONFIG_DEBUG_LIST)) {
+		struct list_head *prev = entry->prev;
+		struct list_head *next = entry->next;
+
+		/*
+		 * With the hardening version, elide checking if next and prev
+		 * are NULL, LIST_POISON1 or LIST_POISON2, since the immediate
+		 * dereference of them below would result in a fault.
+		 */
+		if (likely(prev->next == entry && next->prev == entry))
+			return true;
+		ret = false;
+	}
+
+	ret &= __list_del_entry_valid_or_report(entry);
+	return ret;
+}
+#else
+static inline bool __list_add_valid(struct list_head *new,
+				struct list_head *prev,
+				struct list_head *next)
+{
+	return true;
+}
+static inline bool __list_del_entry_valid(struct list_head *entry)
+{
+	return true;
+}
+#endif
+
+/*
+ * Insert a new entry between two known consecutive entries.
+ *
+ * This is only for internal list manipulation where we know
+ * the prev/next entries already!
+ */
+static inline void __list_add(struct list_head *new,
+			      struct list_head *prev,
+			      struct list_head *next)
+{
+	if (!__list_add_valid(new, prev, next))
+		return;
+
+	next->prev = new;
+	new->next = next;
+	new->prev = prev;
+	prev->next = new;
+}
+
+/**
+ * list_add - add a new entry
+ * @new: new entry to be added
+ * @head: list head to add it after
+ *
+ * Insert a new entry after the specified head.
+ * This is good for implementing stacks.
+ */
+static inline void list_add(struct list_head *new, struct list_head *head)
+{
+	__list_add(new, head, head->next);
+}
+
+
+/**
+ * list_add_tail - add a new entry
+ * @new: new entry to be added
+ * @head: list head to add it before
+ *
+ * Insert a new entry before the specified head.
+ * This is useful for implementing queues.
+ */
+static inline void list_add_tail(struct list_head *new, struct list_head *head)
+{
+	__list_add(new, head->prev, head);
+}
+
+/*
+ * Delete a list entry by making the prev/next entries
+ * point to each other.
+ *
+ * This is only for internal list manipulation where we know
+ * the prev/next entries already!
+ */
+static inline void __list_del(struct list_head * prev, struct list_head * next)
+{
+	next->prev = prev;
+	prev->next = next;
+}
+
+/*
+ * Delete a list entry and clear the 'prev' pointer.
+ *
+ * This is a special-purpose list clearing method used in the networking code
+ * for lists allocated as per-cpu, where we don't want to incur the extra
+ * WRITE_ONCE() overhead of a regular list_del_init(). The code that uses this
+ * needs to check the node 'prev' pointer instead of calling list_empty().
+ */
+static inline void __list_del_clearprev(struct list_head *entry)
+{
+	__list_del(entry->prev, entry->next);
+	entry->prev = NULL;
+}
+
+static inline void __list_del_entry(struct list_head *entry)
+{
+	if (!__list_del_entry_valid(entry))
+		return;
+
+	__list_del(entry->prev, entry->next);
+}
+
+/**
+ * list_del - deletes entry from list.
+ * @entry: the element to delete from the list.
+ * Note: list_empty() on entry does not return true after this, the entry is
+ * in an undefined state.
+ */
+static inline void list_del(struct list_head *entry)
+{
+	__list_del_entry(entry);
+	entry->next = NULL;
+	entry->prev = NULL;
+}
+
+/**
+ * list_replace - replace old entry by new one
+ * @old : the element to be replaced
+ * @new : the new element to insert
+ *
+ * If @old was empty, it will be overwritten.
+ */
+static inline void list_replace(struct list_head *old,
+				struct list_head *new)
+{
+	new->next = old->next;
+	new->next->prev = new;
+	new->prev = old->prev;
+	new->prev->next = new;
+}
+
+/**
+ * list_replace_init - replace old entry by new one and initialize the old one
+ * @old : the element to be replaced
+ * @new : the new element to insert
+ *
+ * If @old was empty, it will be overwritten.
+ */
+static inline void list_replace_init(struct list_head *old,
+				     struct list_head *new)
+{
+	list_replace(old, new);
+	INIT_LIST_HEAD(old);
+}
+
+/**
+ * list_swap - replace entry1 with entry2 and re-add entry1 at entry2's position
+ * @entry1: the location to place entry2
+ * @entry2: the location to place entry1
+ */
+static inline void list_swap(struct list_head *entry1,
+			     struct list_head *entry2)
+{
+	struct list_head *pos = entry2->prev;
+
+	list_del(entry2);
+	list_replace(entry1, entry2);
+	if (pos == entry1)
+		pos = entry2;
+	list_add(entry1, pos);
+}
+
+/**
+ * list_del_init - deletes entry from list and reinitialize it.
+ * @entry: the element to delete from the list.
+ */
+static inline void list_del_init(struct list_head *entry)
+{
+	__list_del_entry(entry);
+	INIT_LIST_HEAD(entry);
+}
+
+/**
+ * list_move - delete from one list and add as another's head
+ * @list: the entry to move
+ * @head: the head that will precede our entry
+ */
+static inline void list_move(struct list_head *list, struct list_head *head)
+{
+	__list_del_entry(list);
+	list_add(list, head);
+}
+
+/**
+ * list_move_tail - delete from one list and add as another's tail
+ * @list: the entry to move
+ * @head: the head that will follow our entry
+ */
+static inline void list_move_tail(struct list_head *list,
+				  struct list_head *head)
+{
+	__list_del_entry(list);
+	list_add_tail(list, head);
+}
+
+/**
+ * list_bulk_move_tail - move a subsection of a list to its tail
+ * @head: the head that will follow our entry
+ * @first: first entry to move
+ * @last: last entry to move, can be the same as first
+ *
+ * Move all entries between @first and including @last before @head.
+ * All three entries must belong to the same linked list.
+ */
+static inline void list_bulk_move_tail(struct list_head *head,
+				       struct list_head *first,
+				       struct list_head *last)
+{
+	first->prev->next = last->next;
+	last->next->prev = first->prev;
+
+	head->prev->next = first;
+	first->prev = head->prev;
+
+	last->next = head;
+	head->prev = last;
+}
+
+/**
+ * list_is_first -- tests whether @list is the first entry in list @head
+ * @list: the entry to test
+ * @head: the head of the list
+ */
+static inline int list_is_first(const struct list_head *list, const struct list_head *head)
+{
+	return list->prev == head;
+}
+
+/**
+ * list_is_last - tests whether @list is the last entry in list @head
+ * @list: the entry to test
+ * @head: the head of the list
+ */
+static inline int list_is_last(const struct list_head *list, const struct list_head *head)
+{
+	return list->next == head;
+}
+
+/**
+ * list_is_head - tests whether @list is the list @head
+ * @list: the entry to test
+ * @head: the head of the list
+ */
+static inline int list_is_head(const struct list_head *list, const struct list_head *head)
+{
+	return list == head;
+}
+
+/**
+ * list_empty - tests whether a list is empty
+ * @head: the list to test.
+ */
+static inline int list_empty(const struct list_head *head)
+{
+	return head->next == head;
+}
+
+/**
+ * list_rotate_left - rotate the list to the left
+ * @head: the head of the list
+ */
+static inline void list_rotate_left(struct list_head *head)
+{
+	struct list_head *first;
+
+	if (!list_empty(head)) {
+		first = head->next;
+		list_move_tail(first, head);
+	}
+}
+
+/**
+ * list_rotate_to_front() - Rotate list to specific item.
+ * @list: The desired new front of the list.
+ * @head: The head of the list.
+ *
+ * Rotates list so that @list becomes the new front of the list.
+ */
+static inline void list_rotate_to_front(struct list_head *list,
+					struct list_head *head)
+{
+	/*
+	 * Deletes the list head from the list denoted by @head and
+	 * places it as the tail of @list, this effectively rotates the
+	 * list so that @list is at the front.
+	 */
+	list_move_tail(head, list);
+}
+
+/**
+ * list_is_singular - tests whether a list has just one entry.
+ * @head: the list to test.
+ */
+static inline int list_is_singular(const struct list_head *head)
+{
+	return !list_empty(head) && (head->next == head->prev);
+}
+
+static inline void __list_cut_position(struct list_head *list,
+		struct list_head *head, struct list_head *entry)
+{
+	struct list_head *new_first = entry->next;
+	list->next = head->next;
+	list->next->prev = list;
+	list->prev = entry;
+	entry->next = list;
+	head->next = new_first;
+	new_first->prev = head;
+}
+
+/**
+ * list_cut_position - cut a list into two
+ * @list: a new list to add all removed entries
+ * @head: a list with entries
+ * @entry: an entry within head, could be the head itself
+ *	and if so we won't cut the list
+ *
+ * This helper moves the initial part of @head, up to and
+ * including @entry, from @head to @list. You should
+ * pass on @entry an element you know is on @head. @list
+ * should be an empty list or a list you do not care about
+ * losing its data.
+ *
+ */
+static inline void list_cut_position(struct list_head *list,
+		struct list_head *head, struct list_head *entry)
+{
+	if (list_empty(head))
+		return;
+	if (list_is_singular(head) && !list_is_head(entry, head) && (entry != head->next))
+		return;
+	if (list_is_head(entry, head))
+		INIT_LIST_HEAD(list);
+	else
+		__list_cut_position(list, head, entry);
+}
+
+/**
+ * list_cut_before - cut a list into two, before given entry
+ * @list: a new list to add all removed entries
+ * @head: a list with entries
+ * @entry: an entry within head, could be the head itself
+ *
+ * This helper moves the initial part of @head, up to but
+ * excluding @entry, from @head to @list.  You should pass
+ * in @entry an element you know is on @head.  @list should
+ * be an empty list or a list you do not care about losing
+ * its data.
+ * If @entry == @head, all entries on @head are moved to
+ * @list.
+ */
+static inline void list_cut_before(struct list_head *list,
+				   struct list_head *head,
+				   struct list_head *entry)
+{
+	if (head->next == entry) {
+		INIT_LIST_HEAD(list);
+		return;
+	}
+	list->next = head->next;
+	list->next->prev = list;
+	list->prev = entry->prev;
+	list->prev->next = list;
+	head->next = entry;
+	entry->prev = head;
+}
+
+static inline void __list_splice(const struct list_head *list,
+				 struct list_head *prev,
+				 struct list_head *next)
+{
+	struct list_head *first = list->next;
+	struct list_head *last = list->prev;
+
+	first->prev = prev;
+	prev->next = first;
+
+	last->next = next;
+	next->prev = last;
+}
+
+/**
+ * list_splice - join two lists, this is designed for stacks
+ * @list: the new list to add.
+ * @head: the place to add it in the first list.
+ */
+static inline void list_splice(const struct list_head *list,
+				struct list_head *head)
+{
+	if (!list_empty(list))
+		__list_splice(list, head, head->next);
+}
+
+/**
+ * list_splice_tail - join two lists, each list being a queue
+ * @list: the new list to add.
+ * @head: the place to add it in the first list.
+ */
+static inline void list_splice_tail(struct list_head *list,
+				struct list_head *head)
+{
+	if (!list_empty(list))
+		__list_splice(list, head->prev, head);
+}
+
+/**
+ * list_splice_init - join two lists and reinitialise the emptied list.
+ * @list: the new list to add.
+ * @head: the place to add it in the first list.
+ *
+ * The list at @list is reinitialised
+ */
+static inline void list_splice_init(struct list_head *list,
+				    struct list_head *head)
+{
+	if (!list_empty(list)) {
+		__list_splice(list, head, head->next);
+		INIT_LIST_HEAD(list);
+	}
+}
+
+/**
+ * list_splice_tail_init - join two lists and reinitialise the emptied list
+ * @list: the new list to add.
+ * @head: the place to add it in the first list.
+ *
+ * Each of the lists is a queue.
+ * The list at @list is reinitialised
+ */
+static inline void list_splice_tail_init(struct list_head *list,
+					 struct list_head *head)
+{
+	if (!list_empty(list)) {
+		__list_splice(list, head->prev, head);
+		INIT_LIST_HEAD(list);
+	}
+}
+
+/**
+ * list_entry - get the struct for this entry
+ * @ptr:	the &struct list_head pointer.
+ * @type:	the type of the struct this is embedded in.
+ * @member:	the name of the list_head within the struct.
+ */
+#define list_entry(ptr, type, member) \
+	container_of(ptr, type, member)
+
+/**
+ * list_first_entry - get the first element from a list
+ * @ptr:	the list head to take the element from.
+ * @type:	the type of the struct this is embedded in.
+ * @member:	the name of the list_head within the struct.
+ *
+ * Note, that list is expected to be not empty.
+ */
+#define list_first_entry(ptr, type, member) \
+	list_entry((ptr)->next, type, member)
+
+/**
+ * list_last_entry - get the last element from a list
+ * @ptr:	the list head to take the element from.
+ * @type:	the type of the struct this is embedded in.
+ * @member:	the name of the list_head within the struct.
+ *
+ * Note, that list is expected to be not empty.
+ */
+#define list_last_entry(ptr, type, member) \
+	list_entry((ptr)->prev, type, member)
+
+/**
+ * list_first_entry_or_null - get the first element from a list
+ * @ptr:	the list head to take the element from.
+ * @type:	the type of the struct this is embedded in.
+ * @member:	the name of the list_head within the struct.
+ *
+ * Note that if the list is empty, it returns NULL.
+ */
+#define list_first_entry_or_null(ptr, type, member) ({ \
+	struct list_head *head__ = (ptr); \
+	struct list_head *pos__ = head__->next; \
+	pos__ != head__ ? list_entry(pos__, type, member) : NULL; \
+})
+
+/**
+ * list_next_entry - get the next element in list
+ * @pos:	the type * to cursor
+ * @member:	the name of the list_head within the struct.
+ */
+#define list_next_entry(pos, member) \
+	list_entry((pos)->member.next, typeof(*(pos)), member)
+
+/**
+ * list_next_entry_circular - get the next element in list
+ * @pos:	the type * to cursor.
+ * @head:	the list head to take the element from.
+ * @member:	the name of the list_head within the struct.
+ *
+ * Wraparound if pos is the last element (return the first element).
+ * Note, that list is expected to be not empty.
+ */
+#define list_next_entry_circular(pos, head, member) \
+	(list_is_last(&(pos)->member, head) ? \
+	list_first_entry(head, typeof(*(pos)), member) : list_next_entry(pos, member))
+
+/**
+ * list_prev_entry - get the prev element in list
+ * @pos:	the type * to cursor
+ * @member:	the name of the list_head within the struct.
+ */
+#define list_prev_entry(pos, member) \
+	list_entry((pos)->member.prev, typeof(*(pos)), member)
+
+/**
+ * list_prev_entry_circular - get the prev element in list
+ * @pos:	the type * to cursor.
+ * @head:	the list head to take the element from.
+ * @member:	the name of the list_head within the struct.
+ *
+ * Wraparound if pos is the first element (return the last element).
+ * Note, that list is expected to be not empty.
+ */
+#define list_prev_entry_circular(pos, head, member) \
+	(list_is_first(&(pos)->member, head) ? \
+	list_last_entry(head, typeof(*(pos)), member) : list_prev_entry(pos, member))
+
+/**
+ * list_for_each	-	iterate over a list
+ * @pos:	the &struct list_head to use as a loop cursor.
+ * @head:	the head for your list.
+ */
+#define list_for_each(pos, head) \
+	for (pos = (head)->next; !list_is_head(pos, (head)); pos = pos->next)
+
+/**
+ * list_for_each_rcu - Iterate over a list in an RCU-safe fashion
+ * @pos:	the &struct list_head to use as a loop cursor.
+ * @head:	the head for your list.
+ */
+#define list_for_each_rcu(pos, head)		  \
+	for (pos = rcu_dereference((head)->next); \
+	     !list_is_head(pos, (head)); \
+	     pos = rcu_dereference(pos->next))
+
+/**
+ * list_for_each_continue - continue iteration over a list
+ * @pos:	the &struct list_head to use as a loop cursor.
+ * @head:	the head for your list.
+ *
+ * Continue to iterate over a list, continuing after the current position.
+ */
+#define list_for_each_continue(pos, head) \
+	for (pos = pos->next; !list_is_head(pos, (head)); pos = pos->next)
+
+/**
+ * list_for_each_prev	-	iterate over a list backwards
+ * @pos:	the &struct list_head to use as a loop cursor.
+ * @head:	the head for your list.
+ */
+#define list_for_each_prev(pos, head) \
+	for (pos = (head)->prev; !list_is_head(pos, (head)); pos = pos->prev)
+
+/**
+ * list_for_each_safe - iterate over a list safe against removal of list entry
+ * @pos:	the &struct list_head to use as a loop cursor.
+ * @n:		another &struct list_head to use as temporary storage
+ * @head:	the head for your list.
+ */
+#define list_for_each_safe(pos, n, head) \
+	for (pos = (head)->next, n = pos->next; \
+	     !list_is_head(pos, (head)); \
+	     pos = n, n = pos->next)
+
+/**
+ * list_for_each_prev_safe - iterate over a list backwards safe against removal of list entry
+ * @pos:	the &struct list_head to use as a loop cursor.
+ * @n:		another &struct list_head to use as temporary storage
+ * @head:	the head for your list.
+ */
+#define list_for_each_prev_safe(pos, n, head) \
+	for (pos = (head)->prev, n = pos->prev; \
+	     !list_is_head(pos, (head)); \
+	     pos = n, n = pos->prev)
+
+/**
+ * list_count_nodes - count nodes in the list
+ * @head:	the head for your list.
+ */
+static inline size_t list_count_nodes(struct list_head *head)
+{
+	struct list_head *pos;
+	size_t count = 0;
+
+	list_for_each(pos, head)
+		count++;
+
+	return count;
+}
+
+/**
+ * list_entry_is_head - test if the entry points to the head of the list
+ * @pos:	the type * to cursor
+ * @head:	the head for your list.
+ * @member:	the name of the list_head within the struct.
+ */
+#define list_entry_is_head(pos, head, member)				\
+	list_is_head(&pos->member, (head))
+
+/**
+ * list_for_each_entry	-	iterate over list of given type
+ * @pos:	the type * to use as a loop cursor.
+ * @head:	the head for your list.
+ * @member:	the name of the list_head within the struct.
+ */
+#define list_for_each_entry(pos, head, member)				\
+	for (pos = list_first_entry(head, typeof(*pos), member);	\
+	     !list_entry_is_head(pos, head, member);			\
+	     pos = list_next_entry(pos, member))
+
+/**
+ * list_for_each_entry_reverse - iterate backwards over list of given type.
+ * @pos:	the type * to use as a loop cursor.
+ * @head:	the head for your list.
+ * @member:	the name of the list_head within the struct.
+ */
+#define list_for_each_entry_reverse(pos, head, member)			\
+	for (pos = list_last_entry(head, typeof(*pos), member);		\
+	     !list_entry_is_head(pos, head, member); 			\
+	     pos = list_prev_entry(pos, member))
+
+/**
+ * list_prepare_entry - prepare a pos entry for use in list_for_each_entry_continue()
+ * @pos:	the type * to use as a start point
+ * @head:	the head of the list
+ * @member:	the name of the list_head within the struct.
+ *
+ * Prepares a pos entry for use as a start point in list_for_each_entry_continue().
+ */
+#define list_prepare_entry(pos, head, member) \
+	((pos) ? : list_entry(head, typeof(*pos), member))
+
+/**
+ * list_for_each_entry_continue - continue iteration over list of given type
+ * @pos:	the type * to use as a loop cursor.
+ * @head:	the head for your list.
+ * @member:	the name of the list_head within the struct.
+ *
+ * Continue to iterate over list of given type, continuing after
+ * the current position.
+ */
+#define list_for_each_entry_continue(pos, head, member) 		\
+	for (pos = list_next_entry(pos, member);			\
+	     !list_entry_is_head(pos, head, member);			\
+	     pos = list_next_entry(pos, member))
+
+/**
+ * list_for_each_entry_continue_reverse - iterate backwards from the given point
+ * @pos:	the type * to use as a loop cursor.
+ * @head:	the head for your list.
+ * @member:	the name of the list_head within the struct.
+ *
+ * Start to iterate over list of given type backwards, continuing after
+ * the current position.
+ */
+#define list_for_each_entry_continue_reverse(pos, head, member)		\
+	for (pos = list_prev_entry(pos, member);			\
+	     !list_entry_is_head(pos, head, member);			\
+	     pos = list_prev_entry(pos, member))
+
+/**
+ * list_for_each_entry_from - iterate over list of given type from the current point
+ * @pos:	the type * to use as a loop cursor.
+ * @head:	the head for your list.
+ * @member:	the name of the list_head within the struct.
+ *
+ * Iterate over list of given type, continuing from current position.
+ */
+#define list_for_each_entry_from(pos, head, member) 			\
+	for (; !list_entry_is_head(pos, head, member);			\
+	     pos = list_next_entry(pos, member))
+
+/**
+ * list_for_each_entry_from_reverse - iterate backwards over list of given type
+ *                                    from the current point
+ * @pos:	the type * to use as a loop cursor.
+ * @head:	the head for your list.
+ * @member:	the name of the list_head within the struct.
+ *
+ * Iterate backwards over list of given type, continuing from current position.
+ */
+#define list_for_each_entry_from_reverse(pos, head, member)		\
+	for (; !list_entry_is_head(pos, head, member);			\
+	     pos = list_prev_entry(pos, member))
+
+/**
+ * list_for_each_entry_safe - iterate over list of given type safe against removal of list entry
+ * @pos:	the type * to use as a loop cursor.
+ * @n:		another type * to use as temporary storage
+ * @head:	the head for your list.
+ * @member:	the name of the list_head within the struct.
+ */
+#define list_for_each_entry_safe(pos, n, head, member)			\
+	for (pos = list_first_entry(head, typeof(*pos), member),	\
+		n = list_next_entry(pos, member);			\
+	     !list_entry_is_head(pos, head, member); 			\
+	     pos = n, n = list_next_entry(n, member))
+
+/**
+ * list_for_each_entry_safe_continue - continue list iteration safe against removal
+ * @pos:	the type * to use as a loop cursor.
+ * @n:		another type * to use as temporary storage
+ * @head:	the head for your list.
+ * @member:	the name of the list_head within the struct.
+ *
+ * Iterate over list of given type, continuing after current point,
+ * safe against removal of list entry.
+ */
+#define list_for_each_entry_safe_continue(pos, n, head, member) 		\
+	for (pos = list_next_entry(pos, member), 				\
+		n = list_next_entry(pos, member);				\
+	     !list_entry_is_head(pos, head, member);				\
+	     pos = n, n = list_next_entry(n, member))
+
+/**
+ * list_for_each_entry_safe_from - iterate over list from current point safe against removal
+ * @pos:	the type * to use as a loop cursor.
+ * @n:		another type * to use as temporary storage
+ * @head:	the head for your list.
+ * @member:	the name of the list_head within the struct.
+ *
+ * Iterate over list of given type from current point, safe against
+ * removal of list entry.
+ */
+#define list_for_each_entry_safe_from(pos, n, head, member) 			\
+	for (n = list_next_entry(pos, member);					\
+	     !list_entry_is_head(pos, head, member);				\
+	     pos = n, n = list_next_entry(n, member))
+
+/**
+ * list_for_each_entry_safe_reverse - iterate backwards over list safe against removal
+ * @pos:	the type * to use as a loop cursor.
+ * @n:		another type * to use as temporary storage
+ * @head:	the head for your list.
+ * @member:	the name of the list_head within the struct.
+ *
+ * Iterate backwards over list of given type, safe against removal
+ * of list entry.
+ */
+#define list_for_each_entry_safe_reverse(pos, n, head, member)		\
+	for (pos = list_last_entry(head, typeof(*pos), member),		\
+		n = list_prev_entry(pos, member);			\
+	     !list_entry_is_head(pos, head, member); 			\
+	     pos = n, n = list_prev_entry(n, member))
+
+/**
+ * list_safe_reset_next - reset a stale list_for_each_entry_safe loop
+ * @pos:	the loop cursor used in the list_for_each_entry_safe loop
+ * @n:		temporary storage used in list_for_each_entry_safe
+ * @member:	the name of the list_head within the struct.
+ *
+ * list_safe_reset_next is not safe to use in general if the list may be
+ * modified concurrently (eg. the lock is dropped in the loop body). An
+ * exception to this is if the cursor element (pos) is pinned in the list,
+ * and list_safe_reset_next is called after re-taking the lock and before
+ * completing the current iteration of the loop body.
+ */
+#define list_safe_reset_next(pos, n, member)				\
+	n = list_next_entry(pos, member)
+
+#endif
diff --git a/debugfs/Makefile.in b/debugfs/Makefile.in
index 689bf0c4a3c13d..700ae87418c268 100644
--- a/debugfs/Makefile.in
+++ b/debugfs/Makefile.in
@@ -195,7 +195,7 @@ debugfs.o: $(srcdir)/debugfs.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/support/dqblk_v2.h \
  $(top_srcdir)/lib/support/quotaio_tree.h $(top_srcdir)/version.h \
  $(srcdir)/../e2fsck/jfs_user.h $(top_srcdir)/lib/ext2fs/kernel-jbd.h \
- $(top_srcdir)/lib/ext2fs/jfs_compat.h $(top_srcdir)/lib/ext2fs/kernel-list.h \
+ $(top_srcdir)/lib/ext2fs/jfs_compat.h $(top_srcdir)/lib/support/list.h \
  $(top_srcdir)/lib/ext2fs/compiler.h $(top_srcdir)/lib/support/plausible.h
 util.o: $(srcdir)/util.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(top_srcdir)/lib/ss/ss.h \
@@ -287,7 +287,7 @@ logdump.o: $(srcdir)/logdump.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/support/dqblk_v2.h \
  $(top_srcdir)/lib/support/quotaio_tree.h $(srcdir)/../e2fsck/jfs_user.h \
  $(top_srcdir)/lib/ext2fs/kernel-jbd.h $(top_srcdir)/lib/ext2fs/jfs_compat.h \
- $(top_srcdir)/lib/ext2fs/kernel-list.h $(top_srcdir)/lib/ext2fs/compiler.h \
+ $(top_srcdir)/lib/support/list.h $(top_srcdir)/lib/ext2fs/compiler.h \
  $(top_srcdir)/lib/ext2fs/fast_commit.h
 htree.o: $(srcdir)/htree.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(srcdir)/debugfs.h $(top_srcdir)/lib/ss/ss.h \
@@ -408,7 +408,7 @@ journal.o: $(srcdir)/journal.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/ext2fs/ext2_io.h $(top_builddir)/lib/ext2fs/ext2_err.h \
  $(top_srcdir)/lib/ext2fs/ext2_ext_attr.h $(top_srcdir)/lib/ext2fs/hashmap.h \
  $(top_srcdir)/lib/ext2fs/bitops.h $(top_srcdir)/lib/ext2fs/kernel-jbd.h \
- $(top_srcdir)/lib/ext2fs/jfs_compat.h $(top_srcdir)/lib/ext2fs/kernel-list.h \
+ $(top_srcdir)/lib/ext2fs/jfs_compat.h $(top_srcdir)/lib/support/list.h \
  $(top_srcdir)/lib/ext2fs/compiler.h
 revoke.o: $(srcdir)/../e2fsck/revoke.c $(srcdir)/../e2fsck/jfs_user.h \
  $(top_builddir)/lib/config.h $(top_builddir)/lib/dirpaths.h \
@@ -418,7 +418,7 @@ revoke.o: $(srcdir)/../e2fsck/revoke.c $(srcdir)/../e2fsck/jfs_user.h \
  $(top_builddir)/lib/ext2fs/ext2_err.h \
  $(top_srcdir)/lib/ext2fs/ext2_ext_attr.h $(top_srcdir)/lib/ext2fs/hashmap.h \
  $(top_srcdir)/lib/ext2fs/bitops.h $(top_srcdir)/lib/ext2fs/kernel-jbd.h \
- $(top_srcdir)/lib/ext2fs/jfs_compat.h $(top_srcdir)/lib/ext2fs/kernel-list.h \
+ $(top_srcdir)/lib/ext2fs/jfs_compat.h $(top_srcdir)/lib/support/list.h \
  $(top_srcdir)/lib/ext2fs/compiler.h
 recovery.o: $(srcdir)/../e2fsck/recovery.c $(srcdir)/../e2fsck/jfs_user.h \
  $(top_builddir)/lib/config.h $(top_builddir)/lib/dirpaths.h \
@@ -428,7 +428,7 @@ recovery.o: $(srcdir)/../e2fsck/recovery.c $(srcdir)/../e2fsck/jfs_user.h \
  $(top_builddir)/lib/ext2fs/ext2_err.h \
  $(top_srcdir)/lib/ext2fs/ext2_ext_attr.h $(top_srcdir)/lib/ext2fs/hashmap.h \
  $(top_srcdir)/lib/ext2fs/bitops.h $(top_srcdir)/lib/ext2fs/kernel-jbd.h \
- $(top_srcdir)/lib/ext2fs/jfs_compat.h $(top_srcdir)/lib/ext2fs/kernel-list.h \
+ $(top_srcdir)/lib/ext2fs/jfs_compat.h $(top_srcdir)/lib/support/list.h \
  $(top_srcdir)/lib/ext2fs/compiler.h
 do_journal.o: $(srcdir)/do_journal.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(srcdir)/debugfs.h $(top_srcdir)/lib/ss/ss.h \
@@ -442,7 +442,7 @@ do_journal.o: $(srcdir)/do_journal.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/support/dqblk_v2.h \
  $(top_srcdir)/lib/support/quotaio_tree.h \
  $(top_srcdir)/lib/ext2fs/kernel-jbd.h $(top_srcdir)/lib/ext2fs/jfs_compat.h \
- $(top_srcdir)/lib/ext2fs/kernel-list.h $(top_srcdir)/lib/ext2fs/compiler.h \
+ $(top_srcdir)/lib/support/list.h $(top_srcdir)/lib/ext2fs/compiler.h \
  $(srcdir)/journal.h $(srcdir)/../e2fsck/jfs_user.h
 do_orphan.o: $(srcdir)/do_orphan.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(srcdir)/debugfs.h $(top_srcdir)/lib/ss/ss.h \
diff --git a/e2fsck/Makefile.in b/e2fsck/Makefile.in
index fbb7b156d5c759..52fad9cbfd2b23 100644
--- a/e2fsck/Makefile.in
+++ b/e2fsck/Makefile.in
@@ -282,7 +282,7 @@ e2fsck.o: $(srcdir)/e2fsck.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/support/dqblk_v2.h \
  $(top_srcdir)/lib/support/quotaio_tree.h \
  $(top_srcdir)/lib/ext2fs/fast_commit.h $(top_srcdir)/lib/ext2fs/jfs_compat.h \
- $(top_srcdir)/lib/ext2fs/kernel-list.h $(top_srcdir)/lib/ext2fs/compiler.h \
+ $(top_srcdir)/lib/support/list.h $(top_srcdir)/lib/ext2fs/compiler.h \
  $(srcdir)/problem.h
 super.o: $(srcdir)/super.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(srcdir)/e2fsck.h \
@@ -296,7 +296,7 @@ super.o: $(srcdir)/super.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/support/dqblk_v2.h \
  $(top_srcdir)/lib/support/quotaio_tree.h \
  $(top_srcdir)/lib/ext2fs/fast_commit.h $(top_srcdir)/lib/ext2fs/jfs_compat.h \
- $(top_srcdir)/lib/ext2fs/kernel-list.h $(top_srcdir)/lib/ext2fs/compiler.h \
+ $(top_srcdir)/lib/support/list.h $(top_srcdir)/lib/ext2fs/compiler.h \
  $(srcdir)/problem.h
 pass1.o: $(srcdir)/pass1.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(srcdir)/e2fsck.h \
@@ -310,7 +310,7 @@ pass1.o: $(srcdir)/pass1.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/support/dqblk_v2.h \
  $(top_srcdir)/lib/support/quotaio_tree.h \
  $(top_srcdir)/lib/ext2fs/fast_commit.h $(top_srcdir)/lib/ext2fs/jfs_compat.h \
- $(top_srcdir)/lib/ext2fs/kernel-list.h $(top_srcdir)/lib/ext2fs/compiler.h \
+ $(top_srcdir)/lib/support/list.h $(top_srcdir)/lib/ext2fs/compiler.h \
  $(top_srcdir)/lib/e2p/e2p.h $(srcdir)/problem.h
 pass1b.o: $(srcdir)/pass1b.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(top_srcdir)/lib/et/com_err.h \
@@ -324,7 +324,7 @@ pass1b.o: $(srcdir)/pass1b.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/support/dqblk_v2.h \
  $(top_srcdir)/lib/support/quotaio_tree.h \
  $(top_srcdir)/lib/ext2fs/fast_commit.h $(top_srcdir)/lib/ext2fs/jfs_compat.h \
- $(top_srcdir)/lib/ext2fs/kernel-list.h $(top_srcdir)/lib/ext2fs/compiler.h \
+ $(top_srcdir)/lib/support/list.h $(top_srcdir)/lib/ext2fs/compiler.h \
  $(srcdir)/problem.h $(top_srcdir)/lib/support/dict.h
 pass2.o: $(srcdir)/pass2.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(srcdir)/e2fsck.h \
@@ -338,7 +338,7 @@ pass2.o: $(srcdir)/pass2.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/support/dqblk_v2.h \
  $(top_srcdir)/lib/support/quotaio_tree.h \
  $(top_srcdir)/lib/ext2fs/fast_commit.h $(top_srcdir)/lib/ext2fs/jfs_compat.h \
- $(top_srcdir)/lib/ext2fs/kernel-list.h $(top_srcdir)/lib/ext2fs/compiler.h \
+ $(top_srcdir)/lib/support/list.h $(top_srcdir)/lib/ext2fs/compiler.h \
  $(srcdir)/problem.h $(top_srcdir)/lib/support/dict.h
 pass3.o: $(srcdir)/pass3.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(srcdir)/e2fsck.h \
@@ -352,7 +352,7 @@ pass3.o: $(srcdir)/pass3.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/support/dqblk_v2.h \
  $(top_srcdir)/lib/support/quotaio_tree.h \
  $(top_srcdir)/lib/ext2fs/fast_commit.h $(top_srcdir)/lib/ext2fs/jfs_compat.h \
- $(top_srcdir)/lib/ext2fs/kernel-list.h $(top_srcdir)/lib/ext2fs/compiler.h \
+ $(top_srcdir)/lib/support/list.h $(top_srcdir)/lib/ext2fs/compiler.h \
  $(srcdir)/problem.h
 pass4.o: $(srcdir)/pass4.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(srcdir)/e2fsck.h \
@@ -366,7 +366,7 @@ pass4.o: $(srcdir)/pass4.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/support/dqblk_v2.h \
  $(top_srcdir)/lib/support/quotaio_tree.h \
  $(top_srcdir)/lib/ext2fs/fast_commit.h $(top_srcdir)/lib/ext2fs/jfs_compat.h \
- $(top_srcdir)/lib/ext2fs/kernel-list.h $(top_srcdir)/lib/ext2fs/compiler.h \
+ $(top_srcdir)/lib/support/list.h $(top_srcdir)/lib/ext2fs/compiler.h \
  $(srcdir)/problem.h
 pass5.o: $(srcdir)/pass5.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(srcdir)/e2fsck.h \
@@ -380,7 +380,7 @@ pass5.o: $(srcdir)/pass5.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/support/dqblk_v2.h \
  $(top_srcdir)/lib/support/quotaio_tree.h \
  $(top_srcdir)/lib/ext2fs/fast_commit.h $(top_srcdir)/lib/ext2fs/jfs_compat.h \
- $(top_srcdir)/lib/ext2fs/kernel-list.h $(top_srcdir)/lib/ext2fs/compiler.h \
+ $(top_srcdir)/lib/support/list.h $(top_srcdir)/lib/ext2fs/compiler.h \
  $(srcdir)/problem.h
 journal.o: $(srcdir)/journal.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(srcdir)/jfs_user.h $(srcdir)/e2fsck.h \
@@ -394,7 +394,7 @@ journal.o: $(srcdir)/journal.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/support/dqblk_v2.h \
  $(top_srcdir)/lib/support/quotaio_tree.h \
  $(top_srcdir)/lib/ext2fs/fast_commit.h $(top_srcdir)/lib/ext2fs/jfs_compat.h \
- $(top_srcdir)/lib/ext2fs/kernel-list.h $(top_srcdir)/lib/ext2fs/compiler.h \
+ $(top_srcdir)/lib/support/list.h $(top_srcdir)/lib/ext2fs/compiler.h \
  $(top_srcdir)/lib/ext2fs/kernel-jbd.h $(srcdir)/problem.h
 recovery.o: $(srcdir)/recovery.c $(srcdir)/jfs_user.h \
  $(top_builddir)/lib/config.h $(top_builddir)/lib/dirpaths.h \
@@ -408,7 +408,7 @@ recovery.o: $(srcdir)/recovery.c $(srcdir)/jfs_user.h \
  $(top_srcdir)/lib/support/dqblk_v2.h \
  $(top_srcdir)/lib/support/quotaio_tree.h \
  $(top_srcdir)/lib/ext2fs/fast_commit.h $(top_srcdir)/lib/ext2fs/jfs_compat.h \
- $(top_srcdir)/lib/ext2fs/kernel-list.h $(top_srcdir)/lib/ext2fs/compiler.h \
+ $(top_srcdir)/lib/support/list.h $(top_srcdir)/lib/ext2fs/compiler.h \
  $(top_srcdir)/lib/ext2fs/kernel-jbd.h
 revoke.o: $(srcdir)/revoke.c $(srcdir)/jfs_user.h \
  $(top_builddir)/lib/config.h $(top_builddir)/lib/dirpaths.h \
@@ -422,7 +422,7 @@ revoke.o: $(srcdir)/revoke.c $(srcdir)/jfs_user.h \
  $(top_srcdir)/lib/support/dqblk_v2.h \
  $(top_srcdir)/lib/support/quotaio_tree.h \
  $(top_srcdir)/lib/ext2fs/fast_commit.h $(top_srcdir)/lib/ext2fs/jfs_compat.h \
- $(top_srcdir)/lib/ext2fs/kernel-list.h $(top_srcdir)/lib/ext2fs/compiler.h \
+ $(top_srcdir)/lib/support/list.h $(top_srcdir)/lib/ext2fs/compiler.h \
  $(top_srcdir)/lib/ext2fs/kernel-jbd.h
 badblocks.o: $(srcdir)/badblocks.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(top_srcdir)/lib/et/com_err.h \
@@ -436,7 +436,7 @@ badblocks.o: $(srcdir)/badblocks.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/support/dqblk_v2.h \
  $(top_srcdir)/lib/support/quotaio_tree.h \
  $(top_srcdir)/lib/ext2fs/fast_commit.h $(top_srcdir)/lib/ext2fs/jfs_compat.h \
- $(top_srcdir)/lib/ext2fs/kernel-list.h $(top_srcdir)/lib/ext2fs/compiler.h
+ $(top_srcdir)/lib/support/list.h $(top_srcdir)/lib/ext2fs/compiler.h
 util.o: $(srcdir)/util.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(srcdir)/e2fsck.h \
  $(top_srcdir)/lib/ext2fs/ext2_fs.h $(top_builddir)/lib/ext2fs/ext2_types.h \
@@ -449,7 +449,7 @@ util.o: $(srcdir)/util.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/support/dqblk_v2.h \
  $(top_srcdir)/lib/support/quotaio_tree.h \
  $(top_srcdir)/lib/ext2fs/fast_commit.h $(top_srcdir)/lib/ext2fs/jfs_compat.h \
- $(top_srcdir)/lib/ext2fs/kernel-list.h $(top_srcdir)/lib/ext2fs/compiler.h
+ $(top_srcdir)/lib/support/list.h $(top_srcdir)/lib/ext2fs/compiler.h
 unix.o: $(srcdir)/unix.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(top_srcdir)/lib/e2p/e2p.h \
  $(top_srcdir)/lib/ext2fs/ext2_fs.h $(top_builddir)/lib/ext2fs/ext2_types.h \
@@ -463,7 +463,7 @@ unix.o: $(srcdir)/unix.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/support/dqblk_v2.h \
  $(top_srcdir)/lib/support/quotaio_tree.h \
  $(top_srcdir)/lib/ext2fs/fast_commit.h $(top_srcdir)/lib/ext2fs/jfs_compat.h \
- $(top_srcdir)/lib/ext2fs/kernel-list.h $(top_srcdir)/lib/ext2fs/compiler.h \
+ $(top_srcdir)/lib/support/list.h $(top_srcdir)/lib/ext2fs/compiler.h \
  $(srcdir)/problem.h $(srcdir)/jfs_user.h \
  $(top_srcdir)/lib/ext2fs/kernel-jbd.h $(top_srcdir)/version.h
 dirinfo.o: $(srcdir)/dirinfo.c $(top_builddir)/lib/config.h \
@@ -478,7 +478,7 @@ dirinfo.o: $(srcdir)/dirinfo.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/support/dqblk_v2.h \
  $(top_srcdir)/lib/support/quotaio_tree.h \
  $(top_srcdir)/lib/ext2fs/fast_commit.h $(top_srcdir)/lib/ext2fs/jfs_compat.h \
- $(top_srcdir)/lib/ext2fs/kernel-list.h $(top_srcdir)/lib/ext2fs/compiler.h \
+ $(top_srcdir)/lib/support/list.h $(top_srcdir)/lib/ext2fs/compiler.h \
  $(top_srcdir)/lib/ext2fs/tdb.h
 dx_dirinfo.o: $(srcdir)/dx_dirinfo.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(srcdir)/e2fsck.h \
@@ -492,7 +492,7 @@ dx_dirinfo.o: $(srcdir)/dx_dirinfo.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/support/dqblk_v2.h \
  $(top_srcdir)/lib/support/quotaio_tree.h \
  $(top_srcdir)/lib/ext2fs/fast_commit.h $(top_srcdir)/lib/ext2fs/jfs_compat.h \
- $(top_srcdir)/lib/ext2fs/kernel-list.h $(top_srcdir)/lib/ext2fs/compiler.h
+ $(top_srcdir)/lib/support/list.h $(top_srcdir)/lib/ext2fs/compiler.h
 ehandler.o: $(srcdir)/ehandler.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(srcdir)/e2fsck.h \
  $(top_srcdir)/lib/ext2fs/ext2_fs.h $(top_builddir)/lib/ext2fs/ext2_types.h \
@@ -505,7 +505,7 @@ ehandler.o: $(srcdir)/ehandler.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/support/dqblk_v2.h \
  $(top_srcdir)/lib/support/quotaio_tree.h \
  $(top_srcdir)/lib/ext2fs/fast_commit.h $(top_srcdir)/lib/ext2fs/jfs_compat.h \
- $(top_srcdir)/lib/ext2fs/kernel-list.h $(top_srcdir)/lib/ext2fs/compiler.h
+ $(top_srcdir)/lib/support/list.h $(top_srcdir)/lib/ext2fs/compiler.h
 problem.o: $(srcdir)/problem.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(srcdir)/e2fsck.h \
  $(top_srcdir)/lib/ext2fs/ext2_fs.h $(top_builddir)/lib/ext2fs/ext2_types.h \
@@ -518,7 +518,7 @@ problem.o: $(srcdir)/problem.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/support/dqblk_v2.h \
  $(top_srcdir)/lib/support/quotaio_tree.h \
  $(top_srcdir)/lib/ext2fs/fast_commit.h $(top_srcdir)/lib/ext2fs/jfs_compat.h \
- $(top_srcdir)/lib/ext2fs/kernel-list.h $(top_srcdir)/lib/ext2fs/compiler.h \
+ $(top_srcdir)/lib/support/list.h $(top_srcdir)/lib/ext2fs/compiler.h \
  $(srcdir)/problem.h $(srcdir)/problemP.h
 message.o: $(srcdir)/message.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(top_srcdir)/lib/support/quotaio.h \
@@ -531,7 +531,7 @@ message.o: $(srcdir)/message.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/support/quotaio_tree.h $(srcdir)/e2fsck.h \
  $(top_srcdir)/lib/support/profile.h $(top_builddir)/lib/support/prof_err.h \
  $(top_srcdir)/lib/ext2fs/fast_commit.h $(top_srcdir)/lib/ext2fs/jfs_compat.h \
- $(top_srcdir)/lib/ext2fs/kernel-list.h $(top_srcdir)/lib/ext2fs/compiler.h \
+ $(top_srcdir)/lib/support/list.h $(top_srcdir)/lib/ext2fs/compiler.h \
  $(srcdir)/problem.h
 ea_refcount.o: $(srcdir)/ea_refcount.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(srcdir)/e2fsck.h \
@@ -545,7 +545,7 @@ ea_refcount.o: $(srcdir)/ea_refcount.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/support/dqblk_v2.h \
  $(top_srcdir)/lib/support/quotaio_tree.h \
  $(top_srcdir)/lib/ext2fs/fast_commit.h $(top_srcdir)/lib/ext2fs/jfs_compat.h \
- $(top_srcdir)/lib/ext2fs/kernel-list.h $(top_srcdir)/lib/ext2fs/compiler.h
+ $(top_srcdir)/lib/support/list.h $(top_srcdir)/lib/ext2fs/compiler.h
 rehash.o: $(srcdir)/rehash.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(srcdir)/e2fsck.h \
  $(top_srcdir)/lib/ext2fs/ext2_fs.h $(top_builddir)/lib/ext2fs/ext2_types.h \
@@ -558,7 +558,7 @@ rehash.o: $(srcdir)/rehash.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/support/dqblk_v2.h \
  $(top_srcdir)/lib/support/quotaio_tree.h \
  $(top_srcdir)/lib/ext2fs/fast_commit.h $(top_srcdir)/lib/ext2fs/jfs_compat.h \
- $(top_srcdir)/lib/ext2fs/kernel-list.h $(top_srcdir)/lib/ext2fs/compiler.h \
+ $(top_srcdir)/lib/support/list.h $(top_srcdir)/lib/ext2fs/compiler.h \
  $(srcdir)/problem.h $(top_srcdir)/lib/support/sort_r.h
 readahead.o: $(srcdir)/readahead.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(srcdir)/e2fsck.h \
@@ -572,7 +572,7 @@ readahead.o: $(srcdir)/readahead.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/support/dqblk_v2.h \
  $(top_srcdir)/lib/support/quotaio_tree.h \
  $(top_srcdir)/lib/ext2fs/fast_commit.h $(top_srcdir)/lib/ext2fs/jfs_compat.h \
- $(top_srcdir)/lib/ext2fs/kernel-list.h $(top_srcdir)/lib/ext2fs/compiler.h
+ $(top_srcdir)/lib/support/list.h $(top_srcdir)/lib/ext2fs/compiler.h
 region.o: $(srcdir)/region.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(srcdir)/e2fsck.h \
  $(top_srcdir)/lib/ext2fs/ext2_fs.h $(top_builddir)/lib/ext2fs/ext2_types.h \
@@ -585,7 +585,7 @@ region.o: $(srcdir)/region.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/support/dqblk_v2.h \
  $(top_srcdir)/lib/support/quotaio_tree.h \
  $(top_srcdir)/lib/ext2fs/fast_commit.h $(top_srcdir)/lib/ext2fs/jfs_compat.h \
- $(top_srcdir)/lib/ext2fs/kernel-list.h $(top_srcdir)/lib/ext2fs/compiler.h
+ $(top_srcdir)/lib/support/list.h $(top_srcdir)/lib/ext2fs/compiler.h
 sigcatcher.o: $(srcdir)/sigcatcher.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(srcdir)/e2fsck.h \
  $(top_srcdir)/lib/ext2fs/ext2_fs.h $(top_builddir)/lib/ext2fs/ext2_types.h \
@@ -598,7 +598,7 @@ sigcatcher.o: $(srcdir)/sigcatcher.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/support/dqblk_v2.h \
  $(top_srcdir)/lib/support/quotaio_tree.h \
  $(top_srcdir)/lib/ext2fs/fast_commit.h $(top_srcdir)/lib/ext2fs/jfs_compat.h \
- $(top_srcdir)/lib/ext2fs/kernel-list.h $(top_srcdir)/lib/ext2fs/compiler.h
+ $(top_srcdir)/lib/support/list.h $(top_srcdir)/lib/ext2fs/compiler.h
 logfile.o: $(srcdir)/logfile.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(srcdir)/e2fsck.h \
  $(top_srcdir)/lib/ext2fs/ext2_fs.h $(top_builddir)/lib/ext2fs/ext2_types.h \
@@ -611,7 +611,7 @@ logfile.o: $(srcdir)/logfile.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/support/dqblk_v2.h \
  $(top_srcdir)/lib/support/quotaio_tree.h \
  $(top_srcdir)/lib/ext2fs/fast_commit.h $(top_srcdir)/lib/ext2fs/jfs_compat.h \
- $(top_srcdir)/lib/ext2fs/kernel-list.h $(top_srcdir)/lib/ext2fs/compiler.h
+ $(top_srcdir)/lib/support/list.h $(top_srcdir)/lib/ext2fs/compiler.h
 quota.o: $(srcdir)/quota.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(srcdir)/e2fsck.h \
  $(top_srcdir)/lib/ext2fs/ext2_fs.h $(top_builddir)/lib/ext2fs/ext2_types.h \
@@ -624,7 +624,7 @@ quota.o: $(srcdir)/quota.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/support/dqblk_v2.h \
  $(top_srcdir)/lib/support/quotaio_tree.h \
  $(top_srcdir)/lib/ext2fs/fast_commit.h $(top_srcdir)/lib/ext2fs/jfs_compat.h \
- $(top_srcdir)/lib/ext2fs/kernel-list.h $(top_srcdir)/lib/ext2fs/compiler.h \
+ $(top_srcdir)/lib/support/list.h $(top_srcdir)/lib/ext2fs/compiler.h \
  $(srcdir)/problem.h
 extents.o: $(srcdir)/extents.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(srcdir)/e2fsck.h \
@@ -638,7 +638,7 @@ extents.o: $(srcdir)/extents.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/support/dqblk_v2.h \
  $(top_srcdir)/lib/support/quotaio_tree.h \
  $(top_srcdir)/lib/ext2fs/fast_commit.h $(top_srcdir)/lib/ext2fs/jfs_compat.h \
- $(top_srcdir)/lib/ext2fs/kernel-list.h $(top_srcdir)/lib/ext2fs/compiler.h \
+ $(top_srcdir)/lib/support/list.h $(top_srcdir)/lib/ext2fs/compiler.h \
  $(srcdir)/problem.h
 encrypted_files.o: $(srcdir)/encrypted_files.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(srcdir)/e2fsck.h \
@@ -652,5 +652,5 @@ encrypted_files.o: $(srcdir)/encrypted_files.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/support/dqblk_v2.h \
  $(top_srcdir)/lib/support/quotaio_tree.h \
  $(top_srcdir)/lib/ext2fs/fast_commit.h $(top_srcdir)/lib/ext2fs/jfs_compat.h \
- $(top_srcdir)/lib/ext2fs/kernel-list.h $(top_srcdir)/lib/ext2fs/compiler.h \
+ $(top_srcdir)/lib/support/list.h $(top_srcdir)/lib/ext2fs/compiler.h \
  $(srcdir)/problem.h $(top_srcdir)/lib/ext2fs/rbtree.h
diff --git a/fuse4fs/Makefile.in b/fuse4fs/Makefile.in
index bc137a765ee2b7..6b41d1dd5ffe8d 100644
--- a/fuse4fs/Makefile.in
+++ b/fuse4fs/Makefile.in
@@ -160,7 +160,7 @@ journal.o: $(srcdir)/../debugfs/journal.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/support/dqblk_v2.h \
  $(top_srcdir)/lib/support/quotaio_tree.h \
  $(top_srcdir)/lib/ext2fs/fast_commit.h $(top_srcdir)/lib/ext2fs/jfs_compat.h \
- $(top_srcdir)/lib/ext2fs/kernel-list.h $(top_srcdir)/lib/ext2fs/compiler.h \
+ $(top_srcdir)/lib/support/list.h $(top_srcdir)/lib/ext2fs/compiler.h \
  $(top_srcdir)/lib/ext2fs/kernel-jbd.h
 revoke.o: $(srcdir)/../e2fsck/revoke.c $(srcdir)/../e2fsck/jfs_user.h \
  $(top_builddir)/lib/config.h $(top_builddir)/lib/dirpaths.h \
@@ -174,7 +174,7 @@ revoke.o: $(srcdir)/../e2fsck/revoke.c $(srcdir)/../e2fsck/jfs_user.h \
  $(top_srcdir)/lib/support/dqblk_v2.h \
  $(top_srcdir)/lib/support/quotaio_tree.h \
  $(top_srcdir)/lib/ext2fs/fast_commit.h $(top_srcdir)/lib/ext2fs/jfs_compat.h \
- $(top_srcdir)/lib/ext2fs/kernel-list.h $(top_srcdir)/lib/ext2fs/compiler.h \
+ $(top_srcdir)/lib/support/list.h $(top_srcdir)/lib/ext2fs/compiler.h \
  $(top_srcdir)/lib/ext2fs/kernel-jbd.h
 recovery.o: $(srcdir)/../e2fsck/recovery.c $(srcdir)/../e2fsck/jfs_user.h \
  $(top_builddir)/lib/config.h $(top_builddir)/lib/dirpaths.h \
@@ -188,5 +188,5 @@ recovery.o: $(srcdir)/../e2fsck/recovery.c $(srcdir)/../e2fsck/jfs_user.h \
  $(top_srcdir)/lib/support/dqblk_v2.h \
  $(top_srcdir)/lib/support/quotaio_tree.h \
  $(top_srcdir)/lib/ext2fs/fast_commit.h $(top_srcdir)/lib/ext2fs/jfs_compat.h \
- $(top_srcdir)/lib/ext2fs/kernel-list.h $(top_srcdir)/lib/ext2fs/compiler.h \
+ $(top_srcdir)/lib/support/list.h $(top_srcdir)/lib/ext2fs/compiler.h \
  $(top_srcdir)/lib/ext2fs/kernel-jbd.h
diff --git a/lib/e2p/Makefile.in b/lib/e2p/Makefile.in
index 92d9c018fe46c8..f642f5ec367c93 100644
--- a/lib/e2p/Makefile.in
+++ b/lib/e2p/Makefile.in
@@ -130,7 +130,7 @@ feature.o: $(srcdir)/feature.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/ext2fs/ext2_err.h \
  $(top_srcdir)/lib/ext2fs/ext2_ext_attr.h $(top_srcdir)/lib/ext2fs/hashmap.h \
  $(top_srcdir)/lib/ext2fs/bitops.h $(top_srcdir)/lib/ext2fs/kernel-jbd.h \
- $(top_srcdir)/lib/ext2fs/jfs_compat.h $(top_srcdir)/lib/ext2fs/kernel-list.h \
+ $(top_srcdir)/lib/ext2fs/jfs_compat.h $(top_srcdir)/lib/support/list.h \
  $(top_srcdir)/lib/ext2fs/compiler.h
 fgetflags.o: $(srcdir)/fgetflags.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(srcdir)/e2p.h \
@@ -173,7 +173,7 @@ ljs.o: $(srcdir)/ljs.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/ext2fs/ext2_ext_attr.h $(top_srcdir)/lib/ext2fs/hashmap.h \
  $(top_srcdir)/lib/ext2fs/bitops.h $(srcdir)/e2p.h \
  $(top_srcdir)/lib/ext2fs/kernel-jbd.h $(top_srcdir)/lib/ext2fs/jfs_compat.h \
- $(top_srcdir)/lib/ext2fs/kernel-list.h $(top_srcdir)/lib/ext2fs/compiler.h
+ $(top_srcdir)/lib/support/list.h $(top_srcdir)/lib/ext2fs/compiler.h
 mntopts.o: $(srcdir)/mntopts.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(srcdir)/e2p.h \
  $(top_srcdir)/lib/ext2fs/ext2_fs.h $(top_builddir)/lib/ext2fs/ext2_types.h
diff --git a/lib/ext2fs/Makefile.in b/lib/ext2fs/Makefile.in
index e9a6ced244ea26..1d0991defff804 100644
--- a/lib/ext2fs/Makefile.in
+++ b/lib/ext2fs/Makefile.in
@@ -1032,7 +1032,7 @@ mkjournal.o: $(srcdir)/mkjournal.c $(top_builddir)/lib/config.h \
  $(srcdir)/ext3_extents.h $(top_srcdir)/lib/et/com_err.h $(srcdir)/ext2_io.h \
  $(top_builddir)/lib/ext2fs/ext2_err.h $(srcdir)/ext2_ext_attr.h \
  $(srcdir)/hashmap.h $(srcdir)/bitops.h $(srcdir)/kernel-jbd.h \
- $(srcdir)/jfs_compat.h $(srcdir)/kernel-list.h $(srcdir)/compiler.h
+ $(srcdir)/jfs_compat.h $(srcdir)/../support/list.h $(srcdir)/compiler.h
 mmp.o: $(srcdir)/mmp.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(srcdir)/ext2_fs.h \
  $(top_builddir)/lib/ext2fs/ext2_types.h $(srcdir)/ext2fs.h \
@@ -1263,7 +1263,7 @@ debugfs.o: $(top_srcdir)/debugfs/debugfs.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/support/quotaio.h $(top_srcdir)/lib/support/dqblk_v2.h \
  $(top_srcdir)/lib/support/quotaio_tree.h $(top_srcdir)/debugfs/../version.h \
  $(srcdir)/../../e2fsck/jfs_user.h $(srcdir)/kernel-jbd.h \
- $(srcdir)/jfs_compat.h $(srcdir)/kernel-list.h $(srcdir)/compiler.h \
+ $(srcdir)/jfs_compat.h $(srcdir)/../support/list.h $(srcdir)/compiler.h \
  $(top_srcdir)/lib/support/plausible.h
 util.o: $(top_srcdir)/debugfs/util.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(top_srcdir)/lib/ss/ss.h \
@@ -1353,7 +1353,7 @@ logdump.o: $(top_srcdir)/debugfs/logdump.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/debugfs/../misc/create_inode.h $(top_srcdir)/lib/e2p/e2p.h \
  $(top_srcdir)/lib/support/quotaio.h $(top_srcdir)/lib/support/dqblk_v2.h \
  $(top_srcdir)/lib/support/quotaio_tree.h $(srcdir)/../../e2fsck/jfs_user.h \
- $(srcdir)/kernel-jbd.h $(srcdir)/jfs_compat.h $(srcdir)/kernel-list.h \
+ $(srcdir)/kernel-jbd.h $(srcdir)/jfs_compat.h $(srcdir)/../support/list.h \
  $(srcdir)/compiler.h $(srcdir)/fast_commit.h
 htree.o: $(top_srcdir)/debugfs/htree.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(top_srcdir)/debugfs/debugfs.h \
@@ -1469,14 +1469,14 @@ journal.o: $(top_srcdir)/debugfs/journal.c $(top_builddir)/lib/config.h \
  $(srcdir)/ext3_extents.h $(top_srcdir)/lib/et/com_err.h $(srcdir)/ext2_io.h \
  $(top_builddir)/lib/ext2fs/ext2_err.h $(srcdir)/ext2_ext_attr.h \
  $(srcdir)/hashmap.h $(srcdir)/bitops.h $(srcdir)/kernel-jbd.h \
- $(srcdir)/jfs_compat.h $(srcdir)/kernel-list.h $(srcdir)/compiler.h
+ $(srcdir)/jfs_compat.h $(srcdir)/../support/list.h $(srcdir)/compiler.h
 revoke.o: $(top_srcdir)/e2fsck/revoke.c $(top_srcdir)/e2fsck/jfs_user.h \
  $(top_builddir)/lib/config.h $(top_builddir)/lib/dirpaths.h \
  $(srcdir)/ext2_fs.h $(top_builddir)/lib/ext2fs/ext2_types.h \
  $(srcdir)/ext2fs.h $(srcdir)/ext3_extents.h $(top_srcdir)/lib/et/com_err.h \
  $(srcdir)/ext2_io.h $(top_builddir)/lib/ext2fs/ext2_err.h \
  $(srcdir)/ext2_ext_attr.h $(srcdir)/hashmap.h $(srcdir)/bitops.h \
- $(srcdir)/kernel-jbd.h $(srcdir)/jfs_compat.h $(srcdir)/kernel-list.h \
+ $(srcdir)/kernel-jbd.h $(srcdir)/jfs_compat.h $(srcdir)/../support/list.h \
  $(srcdir)/compiler.h
 recovery.o: $(top_srcdir)/e2fsck/recovery.c $(top_srcdir)/e2fsck/jfs_user.h \
  $(top_builddir)/lib/config.h $(top_builddir)/lib/dirpaths.h \
@@ -1484,7 +1484,7 @@ recovery.o: $(top_srcdir)/e2fsck/recovery.c $(top_srcdir)/e2fsck/jfs_user.h \
  $(srcdir)/ext2fs.h $(srcdir)/ext3_extents.h $(top_srcdir)/lib/et/com_err.h \
  $(srcdir)/ext2_io.h $(top_builddir)/lib/ext2fs/ext2_err.h \
  $(srcdir)/ext2_ext_attr.h $(srcdir)/hashmap.h $(srcdir)/bitops.h \
- $(srcdir)/kernel-jbd.h $(srcdir)/jfs_compat.h $(srcdir)/kernel-list.h \
+ $(srcdir)/kernel-jbd.h $(srcdir)/jfs_compat.h $(srcdir)/../support/list.h \
  $(srcdir)/compiler.h
 do_journal.o: $(top_srcdir)/debugfs/do_journal.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(top_srcdir)/debugfs/debugfs.h \
@@ -1497,7 +1497,7 @@ do_journal.o: $(top_srcdir)/debugfs/do_journal.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/debugfs/../misc/create_inode.h $(top_srcdir)/lib/e2p/e2p.h \
  $(top_srcdir)/lib/support/quotaio.h $(top_srcdir)/lib/support/dqblk_v2.h \
  $(top_srcdir)/lib/support/quotaio_tree.h $(srcdir)/kernel-jbd.h \
- $(srcdir)/jfs_compat.h $(srcdir)/kernel-list.h $(srcdir)/compiler.h \
+ $(srcdir)/jfs_compat.h $(srcdir)/../support/list.h $(srcdir)/compiler.h \
  $(top_srcdir)/debugfs/journal.h $(srcdir)/../../e2fsck/jfs_user.h
 do_orphan.o: $(top_srcdir)/debugfs/do_orphan.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(top_srcdir)/debugfs/debugfs.h \
diff --git a/misc/Makefile.in b/misc/Makefile.in
index b63a0424b19fec..ec964688acd623 100644
--- a/misc/Makefile.in
+++ b/misc/Makefile.in
@@ -736,7 +736,7 @@ tune2fs.o: $(srcdir)/tune2fs.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/ext2fs/ext2_io.h $(top_builddir)/lib/ext2fs/ext2_err.h \
  $(top_srcdir)/lib/ext2fs/ext2_ext_attr.h $(top_srcdir)/lib/ext2fs/hashmap.h \
  $(top_srcdir)/lib/ext2fs/bitops.h $(top_srcdir)/lib/ext2fs/kernel-jbd.h \
- $(top_srcdir)/lib/ext2fs/jfs_compat.h $(top_srcdir)/lib/ext2fs/kernel-list.h \
+ $(top_srcdir)/lib/ext2fs/jfs_compat.h $(top_srcdir)/lib/support/list.h \
  $(top_srcdir)/lib/ext2fs/compiler.h $(top_srcdir)/lib/support/plausible.h \
  $(top_srcdir)/lib/support/quotaio.h $(top_srcdir)/lib/support/dqblk_v2.h \
  $(top_srcdir)/lib/support/quotaio_tree.h $(top_srcdir)/lib/support/devname.h \
@@ -789,7 +789,7 @@ dumpe2fs.o: $(srcdir)/dumpe2fs.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/ext2fs/ext2_ext_attr.h $(top_srcdir)/lib/ext2fs/hashmap.h \
  $(top_srcdir)/lib/ext2fs/bitops.h $(top_srcdir)/lib/e2p/e2p.h \
  $(top_srcdir)/lib/ext2fs/kernel-jbd.h $(top_srcdir)/lib/ext2fs/jfs_compat.h \
- $(top_srcdir)/lib/ext2fs/kernel-list.h $(top_srcdir)/lib/ext2fs/compiler.h \
+ $(top_srcdir)/lib/support/list.h $(top_srcdir)/lib/ext2fs/compiler.h \
  $(top_srcdir)/lib/support/devname.h $(top_srcdir)/lib/support/nls-enable.h \
  $(top_srcdir)/lib/support/plausible.h $(top_srcdir)/version.h
 badblocks.o: $(srcdir)/badblocks.c $(top_builddir)/lib/config.h \
@@ -812,7 +812,7 @@ util.o: $(srcdir)/util.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/ext2fs/ext2_err.h \
  $(top_srcdir)/lib/ext2fs/ext2_ext_attr.h $(top_srcdir)/lib/ext2fs/hashmap.h \
  $(top_srcdir)/lib/ext2fs/bitops.h $(top_srcdir)/lib/ext2fs/kernel-jbd.h \
- $(top_srcdir)/lib/ext2fs/jfs_compat.h $(top_srcdir)/lib/ext2fs/kernel-list.h \
+ $(top_srcdir)/lib/ext2fs/jfs_compat.h $(top_srcdir)/lib/support/list.h \
  $(top_srcdir)/lib/ext2fs/compiler.h $(top_srcdir)/lib/support/nls-enable.h \
  $(top_srcdir)/lib/support/devname.h $(srcdir)/util.h
 uuidgen.o: $(srcdir)/uuidgen.c $(top_builddir)/lib/config.h \
@@ -907,7 +907,7 @@ journal.o: $(srcdir)/../debugfs/journal.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/support/dqblk_v2.h \
  $(top_srcdir)/lib/support/quotaio_tree.h \
  $(top_srcdir)/lib/ext2fs/fast_commit.h $(top_srcdir)/lib/ext2fs/jfs_compat.h \
- $(top_srcdir)/lib/ext2fs/kernel-list.h $(top_srcdir)/lib/ext2fs/compiler.h \
+ $(top_srcdir)/lib/support/list.h $(top_srcdir)/lib/ext2fs/compiler.h \
  $(top_srcdir)/lib/ext2fs/kernel-jbd.h
 revoke.o: $(srcdir)/../e2fsck/revoke.c $(srcdir)/../e2fsck/jfs_user.h \
  $(top_builddir)/lib/config.h $(top_builddir)/lib/dirpaths.h \
@@ -921,7 +921,7 @@ revoke.o: $(srcdir)/../e2fsck/revoke.c $(srcdir)/../e2fsck/jfs_user.h \
  $(top_srcdir)/lib/support/dqblk_v2.h \
  $(top_srcdir)/lib/support/quotaio_tree.h \
  $(top_srcdir)/lib/ext2fs/fast_commit.h $(top_srcdir)/lib/ext2fs/jfs_compat.h \
- $(top_srcdir)/lib/ext2fs/kernel-list.h $(top_srcdir)/lib/ext2fs/compiler.h \
+ $(top_srcdir)/lib/support/list.h $(top_srcdir)/lib/ext2fs/compiler.h \
  $(top_srcdir)/lib/ext2fs/kernel-jbd.h
 recovery.o: $(srcdir)/../e2fsck/recovery.c $(srcdir)/../e2fsck/jfs_user.h \
  $(top_builddir)/lib/config.h $(top_builddir)/lib/dirpaths.h \
@@ -935,5 +935,5 @@ recovery.o: $(srcdir)/../e2fsck/recovery.c $(srcdir)/../e2fsck/jfs_user.h \
  $(top_srcdir)/lib/support/dqblk_v2.h \
  $(top_srcdir)/lib/support/quotaio_tree.h \
  $(top_srcdir)/lib/ext2fs/fast_commit.h $(top_srcdir)/lib/ext2fs/jfs_compat.h \
- $(top_srcdir)/lib/ext2fs/kernel-list.h $(top_srcdir)/lib/ext2fs/compiler.h \
+ $(top_srcdir)/lib/support/list.h $(top_srcdir)/lib/ext2fs/compiler.h \
  $(top_srcdir)/lib/ext2fs/kernel-jbd.h
diff --git a/misc/tune2fs.c b/misc/tune2fs.c
index 3db57632c88d42..ac440176351e83 100644
--- a/misc/tune2fs.c
+++ b/misc/tune2fs.c
@@ -2857,10 +2857,6 @@ static int expand_inode_table(ext2_filsys fs, unsigned long new_ino_size)
 }
 
 
-#define list_for_each_safe(pos, pnext, head) \
-	for (pos = (head)->next, pnext = pos->next; pos != (head); \
-	     pos = pnext, pnext = pos->next)
-
 static void free_blk_move_list(void)
 {
 	struct list_head *entry, *tmp;


