Return-Path: <linux-fsdevel+bounces-12521-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 382DE8603BA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 21:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B95971F2775C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 20:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC9973F13;
	Thu, 22 Feb 2024 20:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FCE3ddyv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A25C3B287;
	Thu, 22 Feb 2024 20:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708634266; cv=none; b=pC2sWsYeUI7YuTseTg+MlGOhsmNZSpeRR9B67XGCKDb8y4udGVUoe8+cI5bNnKratbaViyRwS4Q8K0cLaYTNYMyPRJbY9XiD9jjgAv/JM22/er3zpw8wmWbUUdoshdngwwbpyecwhOEaXyNduW1Jcz0a0HNK/MiPc2uLjBBuL5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708634266; c=relaxed/simple;
	bh=foi30S03e03NqMuz5yX3oHZkLkPdIIwof/2iWVxsAcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oedR/waznDKP71la6mCI473DXuX9kV4X4Qq6BNFD8AcLXtxlcpWsOMXDA5KnQxRJZCKC2Cr+6Nc5p02C3Ubc3wpI6UVfjC5biHC8q/Yi4jYrng56RQGsTm1DyBCJ8HhE3qzCqEbpjn7jiI7VtlML09SqxqUU62Zdb8MYYDHZCW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FCE3ddyv; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=IdIoa2fGGdx9bTgXiNT0cfh8Xx8WjBDzXS7doHf22rE=; b=FCE3ddyvC5g95ilGYMwiv5t067
	JyOMfD3h/LDNiOQUxY1ja0/NCH8qKL72tSrAwV0onxZX0u9/AgKZa6djL2uju3OOpJMAbv2xrTXz1
	/YsHR4zCXCMDSLuClw7ZBxlJ1gBYkOMM9xxPg7TIiVwlb1bG5nXjy0pjCV5L+MV0c+St7IYT8FQ+B
	eJ37RxX4oFyYCwoKzQDp/w061tPKZWD/rdPruIHBzNJxNgBi71Htk6Ac2oMh3N9ereTaZrJqeuhEt
	sEkrReQZhiuv+V0NtXYiaeKkvagK8a+acn/UlaFmvKtcPFx5PP2OiF2eXMEOyGj19No+1cFDxvHIq
	CGsCGwTQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdFp1-00000004cew-0QxG;
	Thu, 22 Feb 2024 20:37:35 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Thomas Graf <tgraf@suug.ch>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	netdev@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	maple-tree@lists.infradead.org,
	rcu@vger.kernel.org
Subject: [PATCH 1/1] rosebush: Add new data structure
Date: Thu, 22 Feb 2024 20:37:24 +0000
Message-ID: <20240222203726.1101861-2-willy@infradead.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240222203726.1101861-1-willy@infradead.org>
References: <20240222203726.1101861-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rosebush is a resizing hash table.  See
Docuemntation/core-api/rosebush.rst for details.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 Documentation/core-api/index.rst    |   1 +
 Documentation/core-api/rosebush.rst | 135 ++++++
 MAINTAINERS                         |   8 +
 include/linux/rosebush.h            |  41 ++
 lib/Kconfig.debug                   |   3 +
 lib/Makefile                        |   3 +-
 lib/rosebush.c                      | 707 ++++++++++++++++++++++++++++
 lib/test_rosebush.c                 | 135 ++++++
 8 files changed, 1032 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/core-api/rosebush.rst
 create mode 100644 include/linux/rosebush.h
 create mode 100644 lib/rosebush.c
 create mode 100644 lib/test_rosebush.c

diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
index 7a3a08d81f11..380dfb30b073 100644
--- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -36,6 +36,7 @@ Library functionality that is used throughout the kernel.
    kobject
    kref
    assoc_array
+   rosebush
    xarray
    maple_tree
    idr
diff --git a/Documentation/core-api/rosebush.rst b/Documentation/core-api/rosebush.rst
new file mode 100644
index 000000000000..ed17b2572f06
--- /dev/null
+++ b/Documentation/core-api/rosebush.rst
@@ -0,0 +1,135 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+========
+Rosebush
+========
+
+:Author: Matthew Wilcox
+
+Overview
+========
+
+Rosebush is a hashtable, different from the rhashtable.  It is scalable
+(one spinlock per bucket), resizing in two dimensions (number and size
+of buckets), and concurrent (can be iterated under the RCU read lock).
+It is designed to minimise dependent cache misses, which can stall a
+modern CPU for thousands of instructions.
+
+Objects stored in a rosebush do not have an embedded linked list.
+They can therefore be placed into the same rosebush multiple times and
+be placed in multiple rosebushes.  It is also possible to store pointers
+which have special meaning like ERR_PTR().  It is not possible to store
+a NULL pointer in a rosebush, as this is the return value that indicates
+the iteration has finished.
+
+The user of the rosebush is responsible for calculating their own hash.
+A high quality hash is desirable to keep the scalable properties of
+the rosebush, but a hash with poor distribution in the lower bits will
+not lead to a catastrophic breakdown.  It may lead to excessive memory
+consumption and a lot of CPU time spent during lookup.
+
+Rosebush is not yet IRQ or BH safe.  It can be iterated in interrupt
+context, but not modified.
+
+RCU Iteration
+-------------
+
+There is no rosebush_lookup() function.  This is because the hash value
+may not be unique.  Instead, the user should iterate the rosebush,
+which will return pointers which probably have matching hash values.
+It is the user's responsibility to determine if the returned pointer is
+one they are interested in.
+
+Rosebush iteration guarantees to return all pointers which have a
+matching hash, were in the rosebush before the iteration started and
+remain in the rosebush after iteration ends.  It may return additional
+pointers, including pointers which do not have a matching hash value,
+but it guarantees not to skip any pointers, and it guarantees to only
+return pointers which have (at some point) been stored in the rosebush.
+
+If the rosebush is modified while the iteration is in progress, newly
+added entries may or may not be returned and removed entries may or may
+not be returned.  Causality is not honoured; e.g. if Entry A is known
+to be inserted before Entry B, it is possible for an iteration to return
+Entry B and not Entry A.
+
+Functions and structures
+========================
+
+.. kernel-doc:: include/linux/rosebush.h
+.. kernel-doc:: lib/rosebush.c
+
+Internals
+=========
+
+The rosebush is organised into a top level table which contains pointers
+to buckets.  Each bucket contains a spinlock (for modifications to the
+bucket), the number of entries in the bucket and a contention counter.
+
+The top level table is a power of two in size.  The bottom M bits of
+the hash are used to index into this table, which contains a bucket.
+The bucket contains W hash values followed by W pointers.  We also track
+a contention count, which lets us know if this spinlock is overloaded
+and we should split the bucket to improve scalability.
+
+If the bucket is full, we can increase the size of the bucket.  Currently
+we double the size of the bucket because the slab allocator has slabs for
+powers of two.  We could use any size bucket, or even create slab caches
+for our own buckets (eg a 584 byte bucket would give us 48 entries and
+we'd get 7 buckets per page).  The larger the bucket is, the longer it
+will take to walk the bucket, for modifications and lookup, so there's
+a reasonable limit on the size of an individual bucket.
+
+When we decide that the table needs to be resized, we allocate a new
+table, and duplicate the current contents of the table into each half
+of the new table.  At this point, all buckets in the table are shared.
+A bucket may be shared between multiple table entries.  For simplicity,
+we require that all buckets are shared between a power-of-two number
+of slots.  For example, a table with 8 entries might have entries that
+point to buckets 0, 1, 0, 1, 0, 2, 0, 3.  If we were to then split bucket
+0, we would have to replace either the first or last pair of pointers
+with pointers to bucket 4.  This is akin to the buddy page allocator.
+
+We need to decide when to unshare a bucket.  The most eager option would
+be to do it at table resize, but this seems like a high penalty
+for the unlucky caller who causes a table resize.  Slightly more lazy is
+when we're about to insert into a bucket and discover that it is shared.
+Lazier again would be when we discover that a bucket has no free entries
+in it.  Laziest of all would be to only unshare a bucket when it has been
+grown to the maximum size possible.  All these options have consequences
+for lookup, insertion & deletion time.
+
+In all but the first case, we also need to decide how far to unshare
+the bucket.  For example, if a bucket is currently shared between eight
+slots, do we allocate two new buckets (shared between four slots each),
+three new buckets (one for four slots, two for two slots) or four new
+buckets (one for four slots, one for two slots, and two unshared buckets)?
+Unless the hash is of poor quality, or one particular bucket is highly
+contended, we are unlikely to encounter this situation.  We also need
+to decide how large a bucket to allocate when unsharing a bucket; we
+can count the number of entries that will be in it and choose a bucket
+at least x% larger.  Or we can assume that the new bucket will grow to
+at least the current size.
+
+IRQ / BH safety
+---------------
+
+If we decide to make the rosebush modifiable in IRQ context, we need
+to take the locks in an irq-safe way; we need to figure out how to
+allocate the top level table without vmalloc(), and we need to manage
+without kvfree_rcu_mightsleep().  These all have solutions, but those
+solutions have a cost that isn't worth paying until we have users.
+
+Some of those problems go away if we limit our support to removal in IRQ
+context and only allow insertions in process context (as we do not need
+to reallocate the table or bucket when removing an item).
+
+Small rosebushes
+----------------
+
+As an optimisation, if the rosebush has no entries, the buckets pointer
+is NULL.  If the rosebush has only a few entries, there are only two
+buckets (allocated as a single allocation) and the table pointer points
+directly to the first one instead of pointing to a table.  In this case,
+both buckets are very small and the rosebush is likely to allocate a
+table and separate buckets very early on.
diff --git a/MAINTAINERS b/MAINTAINERS
index 722b894f305e..d8296f0aebf2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19008,6 +19008,14 @@ F:	include/net/rose.h
 F:	include/uapi/linux/rose.h
 F:	net/rose/
 
+ROSEBUSH DATA STRUCTURE
+M:	Matthew Wilcox <willy@infradead.org>
+L:	maple-tree@lists.infradead.org
+S:	Supported
+F:	Documentation/core-api/rosebush.rst
+F:	include/linux/rosebush.h
+F:	lib/*rosebush.c
+
 ROTATION DRIVER FOR ALLWINNER A83T
 M:	Jernej Skrabec <jernej.skrabec@gmail.com>
 L:	linux-media@vger.kernel.org
diff --git a/include/linux/rosebush.h b/include/linux/rosebush.h
new file mode 100644
index 000000000000..8f96f6f9743e
--- /dev/null
+++ b/include/linux/rosebush.h
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* See lib/rosebush.c */
+
+#include <linux/spinlock.h>
+
+/*
+ * Embed this struct in your struct, don't allocate it separately.
+ * None of this is for customers to use; treat it as opaque.
+ * In particular, taking the rbh_resize_lock will prevent only rbh_table
+ * from being reallocated; buckets can still be grown and split without
+ * the lock.  But you will get incomprehensible lockdep warnings!
+ */
+struct rbh {
+	spinlock_t	rbh_resize_lock;
+	unsigned long	rbh_table;	/* A tagged pointer */
+};
+
+#define DEFINE_ROSEBUSH(name)	struct rbh name = \
+	{ .rbh_resize_lock = __SPIN_LOCK_UNLOCKED(name.lock), }
+
+int rbh_insert(struct rbh *rbh, u32 hash, void *p);
+int rbh_reserve(struct rbh *rbh, u32 hash);
+int rbh_use(struct rbh *rbh, u32 hash, void *p);
+int rbh_remove(struct rbh *rbh, u32 hash, void *p);
+
+struct rbh_iter {
+	struct rbh *rbh;
+	struct rbh_bucket *bucket;
+	u32 hash;
+	unsigned int index;
+};
+
+#define RBH_ITER(name, _rbh, _hash)					\
+	struct rbh_iter name = { .rbh = _rbh, .hash = _hash, }
+
+void *rbh_next(struct rbh_iter *rbhi);
+
+void rbh_iter_remove(struct rbh_iter *rbhi, void *p);
+void rbh_iter_lock(struct rbh_iter *rbhi);
+void rbh_iter_unlock(struct rbh_iter *rbhi);
+
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 975a07f9f1cc..d78f5effa310 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2396,6 +2396,9 @@ config TEST_RHASHTABLE
 
 	  If unsure, say N.
 
+config TEST_ROSEBUSH
+	tristate "Test the Rosebush data structure"
+
 config TEST_IDA
 	tristate "Perform selftest on IDA functions"
 
diff --git a/lib/Makefile b/lib/Makefile
index 6b09731d8e61..61592aa5374d 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -28,7 +28,7 @@ CFLAGS_string.o += -fno-stack-protector
 endif
 
 lib-y := ctype.o string.o vsprintf.o cmdline.o \
-	 rbtree.o radix-tree.o timerqueue.o xarray.o \
+	 rosebush.o rbtree.o radix-tree.o timerqueue.o xarray.o \
 	 maple_tree.o idr.o extable.o irq_regs.o argv_split.o \
 	 flex_proportions.o ratelimit.o \
 	 is_single_threaded.o plist.o decompress.o kobject_uevent.o \
@@ -75,6 +75,7 @@ obj-$(CONFIG_TEST_LIST_SORT) += test_list_sort.o
 obj-$(CONFIG_TEST_MIN_HEAP) += test_min_heap.o
 obj-$(CONFIG_TEST_LKM) += test_module.o
 obj-$(CONFIG_TEST_VMALLOC) += test_vmalloc.o
+obj-$(CONFIG_TEST_ROSEBUSH) += test_rosebush.o
 obj-$(CONFIG_TEST_RHASHTABLE) += test_rhashtable.o
 obj-$(CONFIG_TEST_SORT) += test_sort.o
 obj-$(CONFIG_TEST_USER_COPY) += test_user_copy.o
diff --git a/lib/rosebush.c b/lib/rosebush.c
new file mode 100644
index 000000000000..405ec864ef35
--- /dev/null
+++ b/lib/rosebush.c
@@ -0,0 +1,707 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Rosebush, a resizing bucket hash table
+ * Copyright (c) 2024 Oracle Corporation
+ * Author: Matthew Wilcox <willy@infradead.org>
+ */
+
+#include <linux/rosebush.h>
+#include <linux/rcupdate.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+
+/*
+ * The lock is held whenever we are modifying the contents of the bucket.
+ * The contention counter tracks whether we need to split the bucket due
+ * to contention on the spinlock.
+ * Entries tells us how many hashes (and therefore how many slots) we have.
+ * The bucket also contains the slots, but C doesn't let you declare
+ * two unsized arrays next to each other.
+ */
+struct rbh_bucket {
+	spinlock_t	rbh_lock;
+	u16		rbh_contention;
+	u16		rbh_entries;
+	u32		rbh_hashes[] __counted_by(rbh_entries);
+};
+
+struct rbh_table {
+	DECLARE_FLEX_ARRAY(struct rbh_bucket __rcu *, buckets);
+};
+
+#ifdef CONFIG_64BIT
+#define INITIAL_SLOTS	10
+/* 10 (128), 20 (248), 42 (512), 84 (1016), 170 (2048), 340 (4088) */
+#define MAX_SLOTS	340
+#else
+#define INITIAL_SLOTS	15
+/* 15 (128), 31 (256), 63 (512), 127 (1024), 255 (2048, 511 (4096) */
+#define MAX_SLOTS	511
+#endif
+
+static inline unsigned int next_bucket_size(unsigned int nr)
+{
+#ifdef CONFIG_64BIT
+	if (nr % 4 == 0)
+		return nr * 2 + 2;
+	return nr * 2;
+#else
+	return nr * 2 + 1;
+#endif
+}
+
+#define ENTRY_SIZE	(sizeof(int) + sizeof(void *))
+#define BUCKET_SIZE(nr)	(sizeof(struct rbh_bucket) + ENTRY_SIZE * (nr))
+#define INITIAL_SIZE	BUCKET_SIZE(INITIAL_SLOTS)
+
+struct rbh_initial_bucket {
+	struct rbh_bucket b;
+	struct {
+		u32		rbh_hashes[INITIAL_SLOTS];
+		void __rcu *	rbh_slots[INITIAL_SLOTS];
+	} i;
+};
+
+struct rbh_initial_table {
+	struct rbh_initial_bucket buckets[2];
+};
+
+static void __rcu **bucket_slots(const struct rbh_bucket *bucket,
+		unsigned int size)
+{
+	unsigned long p = (unsigned long)&bucket->rbh_hashes[size];
+	return (void __rcu **)((p | (sizeof(void *) - 1)) + 1);
+}
+
+/*
+ * As far as lockdep is concerned, all buckets in the same rosebush use
+ * the same lock.  We use the classes to distinguish the rbh resize lock
+ * from the bucket locks.  The only time we take two bucket locks is
+ * when we already hold the resize lock, so there is no need to define
+ * an order between bucket locks.
+ */
+#ifdef CONFIG_DEBUG_SPINLOCK
+#define bucket_lock_init(rbh, bucket)					\
+	__raw_spin_lock_init(spinlock_check(&(bucket)->rbh_lock),	\
+		"rbh", (rbh)->rbh_resize_lock.dep_map.key, LD_WAIT_SPIN)
+#else
+#define bucket_lock_init(rbh, bucket)					\
+	spin_lock_init(&(bucket)->rbh_lock)
+#endif
+
+#define rbh_resize_lock(rbh)	spin_lock_nested(&(rbh)->rbh_resize_lock, 2)
+#define rbh_resize_unlock(rbh)	spin_unlock(&(rbh)->rbh_resize_lock)
+
+enum split_state {
+	SPLIT_MAYBE,	/* Willing to try to split */
+	SPLIT_SHOULD,	/* Try to split */
+	SPLIT_DONE,	/* Already tried to split a bucket */
+};
+
+struct insert_state {
+	enum split_state split;
+	u32 mask;
+};
+
+/*
+ * A very complicated way of spelling &rbh->bucket[hash].
+ *
+ * The first complication is that we encode the number of buckets
+ * in the pointer so that we can get both in an atomic load.
+ *
+ * The second complication is that small hash tables don't have a top
+ * level table; instead the buckets pointer points to a pair of buckets
+ * of size 128 bytes.
+ *
+ * The third complication is that we reuse the first two slots of the
+ * table for RCU freeing, so we have to check that didn't happen before
+ * we return the pointer.  That does not absolve us of rechecking after
+ * we get the lock in the caller; we have to check here that we have a
+ * pointer to a bucket, and we have to check after we get the lock that
+ * this bucket is still the current bucket.
+ */
+static struct rbh_bucket *get_bucket(struct rbh *rbh, u32 hash,
+		struct insert_state *state)
+{
+	unsigned long tagged;
+	struct rbh_table *table;
+	struct rbh_initial_table *initial_table;
+	u32 mask;
+	unsigned int bid;
+
+	/* rcu_dereference(), but not a pointer */
+	tagged = READ_ONCE(rbh->rbh_table);
+	if (!tagged)
+		return NULL;
+
+	/* The lowest bits indicates how many buckets the table holds */
+	table = (struct rbh_table *)(tagged & (tagged + 1));
+	mask = tagged - (unsigned long)table;
+	bid = hash & mask;
+	if (mask != 1) {
+		if (state) {
+			if (state->split == SPLIT_MAYBE) {
+				u32 buddy = bid ^ ((mask + 1) / 2);
+				if (table->buckets[bid] ==
+				    table->buckets[buddy])
+					state->split = SPLIT_SHOULD;
+				else
+					state->split = SPLIT_DONE;
+			}
+			state->mask = mask;
+		}
+		return rcu_dereference(table->buckets[bid]);
+	}
+	initial_table = (struct rbh_initial_table *)table;
+	if (state) {
+		state->split = SPLIT_DONE;
+		state->mask = mask;
+	}
+	return &initial_table->buckets[bid].b;
+}
+
+static struct rbh_bucket *lock_bucket(struct rbh *rbh, u32 hash)
+	__cond_acquires(&bucket->rbh_lock)
+{
+	struct rbh_bucket *bucket, *new_bucket;
+
+	bucket = get_bucket(rbh, hash, NULL);
+	if (!bucket)
+		return bucket;
+again:
+	spin_lock(&bucket->rbh_lock);
+	new_bucket = get_bucket(rbh, hash, NULL);
+	if (bucket == new_bucket)
+		return bucket;
+	spin_unlock(&bucket->rbh_lock);
+	bucket = new_bucket;
+	goto again;
+}
+
+static bool rbh_first(struct rbh *rbh, u32 hash)
+{
+	struct rbh_initial_table *table;
+	int i;
+
+printk("%s: table size %zd\n", __func__, sizeof(*table));
+	table = kmalloc(sizeof(*table), GFP_KERNEL);
+	if (!table)
+		return false;
+
+	rbh_resize_lock(rbh);
+	if (rbh->rbh_table) {
+		rbh_resize_unlock(rbh);
+		/* Somebody else resized it for us */
+		kfree(table);
+		return true;
+	}
+
+	bucket_lock_init(rbh, &table->buckets[0].b);
+	table->buckets[0].b.rbh_entries = INITIAL_SLOTS;
+	table->buckets[0].b.rbh_contention = 0;
+	bucket_lock_init(rbh, &table->buckets[1].b);
+	table->buckets[1].b.rbh_entries = INITIAL_SLOTS;
+	table->buckets[1].b.rbh_contention = 0;
+	for (i = 0; i < INITIAL_SLOTS; i++) {
+		table->buckets[0].b.rbh_hashes[i] = ~0;
+		table->buckets[1].b.rbh_hashes[i] = 0;
+	}
+	/* rcu_assign_pointer() but not a pointer */
+	smp_store_release(&rbh->rbh_table, (unsigned long)table | 1);
+	rbh_resize_unlock(rbh);
+
+printk("%s: new table = %px\n", __func__, table);
+	return true;
+}
+
+static void copy_initial_buckets(const struct rbh *rbh,
+		struct rbh_table *table, struct rbh_initial_table *init_table)
+	__acquires(&init_table->buckets[0].b.rbh_lock)
+	__acquires(&init_table->buckets[1].b.rbh_lock)
+{
+	struct rbh_bucket *bucket;
+
+	bucket = (void __force *)table->buckets[0];
+	spin_lock(&init_table->buckets[0].b.rbh_lock);
+	memcpy(bucket, &init_table->buckets[0], sizeof(init_table->buckets[0]));
+	bucket_lock_init(rbh, bucket);
+
+	bucket = (void __force *)table->buckets[1];
+	spin_lock_nested(&init_table->buckets[1].b.rbh_lock, 1);
+	memcpy(bucket, &init_table->buckets[1], sizeof(init_table->buckets[1]));
+	bucket_lock_init(rbh, bucket);
+}
+
+/*
+ * When we grow the table, we duplicate the bucket pointers so this
+ * thread doesn't pay the entire cost of growing the table.
+ */
+static int rbh_grow_table(struct rbh *rbh, u32 hash)
+{
+	struct rbh_table *table, *old_table;
+	struct rbh_initial_table *init_table;
+	unsigned long tagged;
+	u32 mask, buddy;
+	size_t size;
+
+	/* If the bucket is shared, we don't need to grow the table */
+	tagged = READ_ONCE(rbh->rbh_table);
+	table = (struct rbh_table *)(tagged & (tagged + 1));
+	mask = tagged - (unsigned long)table;
+	buddy = (hash ^ ((mask + 1) / 2)) & mask;
+	if (mask > 1 && table->buckets[hash & mask] == table->buckets[buddy])
+		return 0;
+
+	old_table = table;
+	size = (mask + 1) * 2 * sizeof(void *);
+	if (size > 4 * PAGE_SIZE)
+		/* XXX: NUMA_NO_NODE doesn't necessarily interleave */
+		table = __vmalloc_node(size, size, GFP_KERNEL, NUMA_NO_NODE,
+				&table);
+	else
+		table = kvmalloc(size, GFP_KERNEL);
+	if (!table) {
+		/* Maybe somebody resized it for us */
+		if (READ_ONCE(rbh->rbh_table) != tagged)
+			return 0;
+		return -ENOMEM;
+	}
+
+	if (mask == 1) {
+		/* Don't need to bother with RCU until we publish the table */
+		table->buckets[0] = (void __rcu *)kmalloc(INITIAL_SIZE, GFP_KERNEL);
+		if (!table->buckets[0])
+			goto free_all;
+		table->buckets[1] = (void __rcu *)kmalloc(INITIAL_SIZE, GFP_KERNEL);
+		if (!table->buckets[1])
+			goto free_all;
+	}
+
+	rbh_resize_lock(rbh);
+	if (rbh->rbh_table != tagged) {
+		rbh_resize_unlock(rbh);
+		/* Somebody else resized it for us */
+		kvfree(table);
+		return 0;
+	}
+
+printk("%s: replacing old_table %px with table %px mask %d\n", __func__, old_table, table, mask);
+	if (mask == 1) {
+		init_table = (void *)old_table;
+		copy_initial_buckets(rbh, table, init_table);
+	} else {
+		memcpy(&table->buckets, &old_table->buckets,
+				(mask + 1) * sizeof(void *));
+	}
+	memcpy(&table->buckets[mask + 1], &table->buckets[0],
+			(mask + 1) * sizeof(void *));
+
+	tagged = ((unsigned long)table) | (mask << 1) | 1;
+	/* rcu_assign_pointer() but not a pointer */
+	smp_store_release(&rbh->rbh_table, tagged);
+	rbh_resize_unlock(rbh);
+	if (mask == 1) {
+		spin_unlock(&init_table->buckets[0].b.rbh_lock);
+		spin_unlock(&init_table->buckets[1].b.rbh_lock);
+	}
+	kvfree_rcu_mightsleep(old_table);
+
+	return 0;
+free_all:
+	kfree((void __force *)table->buckets[0]);
+	kvfree(table);
+	return false;
+}
+
+static void bucket_copy(const struct rbh *rbh, struct rbh_bucket *bucket,
+		const struct rbh_bucket *old_bucket, unsigned int nr,
+		u32 hash, u32 mask)
+{
+	unsigned int old_nr = old_bucket->rbh_entries;
+	void __rcu **old_slots = bucket_slots(old_bucket, old_nr);
+	void __rcu **slots = bucket_slots(bucket, nr);
+	unsigned int i, j = 0;
+
+	bucket->rbh_entries = nr;
+	bucket_lock_init(rbh, bucket);
+	for (i = 0; i < old_nr; i++) {
+		if ((old_bucket->rbh_hashes[i] & mask) != (hash & mask))
+			continue;
+		bucket->rbh_hashes[j] = old_bucket->rbh_hashes[i];
+		slots[j++] = old_slots[i];
+	}
+printk("%s: bucket:%px(%d) copied %d/%d entries from %px hash:%x mask:%x\n", __func__, bucket, nr, j, old_nr, old_bucket, hash, mask);
+
+	while (j < nr)
+		bucket->rbh_hashes[j++] = ~hash;
+}
+
+#define rbh_dereference_protected(p, rbh)				\
+	rcu_dereference_protected(p, lockdep_is_held(&(rbh)->rbh_resize_lock))
+
+/*
+ */
+static void rbh_split_bucket(struct rbh *rbh,
+		struct rbh_bucket *old_bucket, unsigned int nr, u32 hash)
+{
+	struct rbh_table *table;
+	unsigned long tagged;
+	u32 mask, bit;
+	struct rbh_bucket *bucket = kmalloc(BUCKET_SIZE(nr), GFP_KERNEL);
+
+printk("%s: adding bucket %px for hash %d\n", __func__, bucket, hash);
+	if (!bucket)
+		return;
+
+	rbh_resize_lock(rbh);
+	tagged = rbh->rbh_table;
+	table = (struct rbh_table *)(tagged & (tagged + 1));
+	mask = tagged - (unsigned long)table;
+	hash &= mask;
+	if (rbh_dereference_protected(table->buckets[hash], rbh) != old_bucket)
+		goto free;
+
+	/* Figure out how many buckets we need to fill */
+	bit = (mask + 1) / 2;
+	mask = 0;
+	while (bit > 1) {
+printk("hash:%d buddy:%d\n", hash, hash ^ bit);
+		if (rbh_dereference_protected(table->buckets[hash ^ bit], rbh)
+				!= old_bucket)
+			break;
+		mask |= bit;
+		bit /= 2;
+	}
+	if (!mask)
+		goto free;
+
+	spin_lock(&old_bucket->rbh_lock);
+	bucket->rbh_contention = 0;
+	bucket_copy(rbh, bucket, old_bucket, nr, hash, mask | 1);
+
+	mask = (mask & (mask - 1)) / 2;
+printk("hash:%d mask:%d bit:%d\n", hash, mask, bit);
+	hash &= ~mask;
+	for (;;) {
+printk("assigning bucket %px to index %d\n", bucket, hash);
+		rcu_assign_pointer(table->buckets[hash], bucket);
+		if (hash == (hash | mask))
+			break;
+		hash += bit;
+	}
+	spin_unlock(&old_bucket->rbh_lock);
+	bucket = NULL;
+free:
+	rbh_resize_unlock(rbh);
+printk("%s: freeing bucket %px\n", __func__, bucket);
+	kfree(bucket);
+}
+
+/*
+ * thorns are leftovers from when this bucket was shared.  If they are
+ * sufficiently numerous, we'll just allocate another bucket of this size.
+ * Otherwise we'll allocate a larger bucket.
+ */
+static int rbh_expand_bucket(struct rbh *rbh,
+		struct rbh_bucket *old_bucket, unsigned int nr,
+		unsigned int thorns, u32 hash, u32 old_mask)
+{
+	unsigned long tagged;
+	struct rbh_table *table;
+	struct rbh_bucket *bucket;
+	u32 mask;
+
+	/* Can't expand an initial bucket, must create a table */
+	if (old_mask == 1)
+		return rbh_grow_table(rbh, hash);
+	if (thorns < nr / 4)
+		nr = next_bucket_size(nr);
+	if (nr > MAX_SLOTS)
+		return -E2BIG;
+
+	bucket = kmalloc(BUCKET_SIZE(nr), GFP_KERNEL);
+	if (!bucket)
+		return -ENOMEM;
+
+printk("%s: adding bucket %px for hash %d\n", __func__, bucket, hash);
+	rbh_resize_lock(rbh);
+	tagged = READ_ONCE(rbh->rbh_table);
+	table = (struct rbh_table *)(tagged & (tagged + 1));
+	mask = tagged - (unsigned long)table;
+
+	/* If the table expanded while we slept just try again */
+	if (old_mask != mask)
+		goto free;
+	hash &= mask;
+	if (rbh_dereference_protected(table->buckets[hash], rbh) != old_bucket)
+		goto free;
+
+	spin_lock(&old_bucket->rbh_lock);
+	bucket->rbh_contention = old_bucket->rbh_contention;
+	bucket_copy(rbh, bucket, old_bucket, nr, hash, mask);
+	rcu_assign_pointer(table->buckets[hash], bucket);
+
+	spin_unlock(&old_bucket->rbh_lock);
+	bucket = NULL;
+free:
+	rbh_resize_unlock(rbh);
+printk("%s: freeing bucket %px\n", __func__, bucket);
+	kfree(bucket);
+	if (bucket)
+		kvfree_rcu_mightsleep(old_bucket);
+
+	return 0;
+}
+
+static int __rbh_insert(struct rbh *rbh, u32 hash, void *p)
+{
+	struct rbh_bucket *bucket, *new_bucket;
+	unsigned int i, nr, thorns = 0;
+	int err;
+	struct insert_state state = { .split = SPLIT_MAYBE, };
+
+restart:
+	rcu_read_lock();
+	bucket = get_bucket(rbh, hash, &state);
+	if (unlikely(!bucket)) {
+		rcu_read_unlock();
+		if (!rbh_first(rbh, hash))
+			return -ENOMEM;
+		goto restart;
+	}
+
+again:
+	if (spin_trylock(&bucket->rbh_lock)) {
+		if (bucket->rbh_contention)
+			bucket->rbh_contention--;
+	} else {
+		spin_lock(&bucket->rbh_lock);
+		/* Numbers chosen ad-hoc */
+		bucket->rbh_contention += 10;
+		if (unlikely(bucket->rbh_contention > 5000)) {
+			spin_unlock(&bucket->rbh_lock);
+			rcu_read_unlock();
+			/* OK if this fails; it's only contention */
+			rbh_grow_table(rbh, hash);
+
+			rcu_read_lock();
+			bucket = get_bucket(rbh, hash, &state);
+			spin_lock(&bucket->rbh_lock);
+		}
+	}
+
+	new_bucket = get_bucket(rbh, hash, &state);
+	if (bucket != new_bucket) {
+		spin_unlock(&bucket->rbh_lock);
+		bucket = new_bucket;
+		goto again;
+	}
+
+printk("%s: bucket:%px hash %d\n", __func__, bucket, hash);
+	nr = bucket->rbh_entries;
+	/* If the bucket is shared, split it before inserting a new element */
+	if (state.split == SPLIT_SHOULD) {
+		spin_unlock(&bucket->rbh_lock);
+		rcu_read_unlock();
+		rbh_split_bucket(rbh, bucket, nr, hash);
+		state.split = SPLIT_DONE;
+		goto restart;
+	}
+
+	/* Deleted elements differ in their bottom bit */
+	for (i = 0; i < nr; i++) {
+		void __rcu **slots;
+		u32 bhash = bucket->rbh_hashes[i];
+
+		if ((bhash & state.mask) != (hash & state.mask))
+			thorns++;
+		if ((bhash & 1) == (hash & 1))
+			continue;
+printk("%s: hash:%x bhash:%x index %d\n", __func__, hash, bhash, i);
+		slots = bucket_slots(bucket, nr);
+		rcu_assign_pointer(slots[i], p);
+		/* This array is read under RCU */
+		WRITE_ONCE(bucket->rbh_hashes[i], hash);
+
+		spin_unlock(&bucket->rbh_lock);
+		rcu_read_unlock();
+		return 0;
+	}
+
+	/* No space in this bucket */
+	spin_unlock(&bucket->rbh_lock);
+	rcu_read_unlock();
+
+	err = rbh_expand_bucket(rbh, bucket, nr, thorns, hash, state.mask);
+	if (err == -ENOMEM)
+		return -ENOMEM;
+	if (err == -E2BIG) {
+		if (rbh_grow_table(rbh, hash) < 0)
+			return -ENOMEM;
+	}
+	state.split = SPLIT_MAYBE;
+	goto restart;
+}
+
+/**
+ * rbh_insert - Add a pointer to a rosebush.
+ * @rbh: The rosebush.
+ * @hash: The hash value for this pointer.
+ * @p: The pointer to add.
+ *
+ * Return: 0 on success, -ENOMEM if memory allocation fails,
+ * -EINVAL if @p is NULL.
+ */
+int rbh_insert(struct rbh *rbh, u32 hash, void *p)
+{
+	if (p == NULL)
+		return -EINVAL;
+	return __rbh_insert(rbh, hash, p);
+}
+EXPORT_SYMBOL(rbh_insert);
+
+/**
+ * rbh_remove - Remove a pointer from a rosebush.
+ * @rbh: The rosebush.
+ * @hash: The hash value for this pointer.
+ * @p: The pointer to remove.
+ *
+ * Return: 0 on success, -ENOENT if this pointer could not be found.
+ */
+int rbh_remove(struct rbh *rbh, u32 hash, void *p)
+{
+	struct rbh_bucket *bucket;
+	void __rcu **slots;
+	unsigned int i, nr;
+	int err = -ENOENT;
+
+	rcu_read_lock();
+	bucket = lock_bucket(rbh, hash);
+	if (!bucket)
+		goto rcu_unlock;
+
+	nr = bucket->rbh_entries;
+	slots = bucket_slots(bucket, nr);
+	for (i = 0; i < nr; i++) {
+		if (bucket->rbh_hashes[i] != hash)
+			continue;
+		if (rcu_dereference_protected(slots[i],
+				lockdep_is_held(&bucket->rbh_lock)) != p)
+			continue;
+		bucket->rbh_hashes[i] = ~hash;
+		/* Do not modify the slot */
+		err = 0;
+		break;
+	}
+
+	spin_unlock(&bucket->rbh_lock);
+rcu_unlock:
+	rcu_read_unlock();
+	return err;
+}
+EXPORT_SYMBOL(rbh_remove);
+
+/**
+ * rbh_reserve - Reserve a slot in a rosebush for later use.
+ * @rbh: The rosebush.
+ * @hash: The hash value that will be used.
+ *
+ * Some callers need to take another lock before inserting an object
+ * into the rosebush.  This function reserves space for them to do that.
+ * A subsequent call to rbh_use() will not allocate memory.  If you find
+ * that you do not need the reserved space any more, call rbh_remove(),
+ * passing NULL as the pointer.
+ *
+ * Return: 0 on success, -ENOMEM on failure.
+ */
+int rbh_reserve(struct rbh *rbh, u32 hash)
+{
+	return __rbh_insert(rbh, hash, NULL);
+}
+EXPORT_SYMBOL(rbh_reserve);
+
+/**
+ * rbh_use - Use a reserved slot in a rosebush.
+ * @rbh: The rosebush.
+ * @hash: The hash value for this pointer.
+ * @p: The pointer to add.
+ *
+ * Return: 0 on success, -EINVAL if @p is NULL,
+ * -ENOENT if no reserved slot could be found.
+ */
+int rbh_use(struct rbh *rbh, u32 hash, void *p)
+{
+	struct rbh_bucket *bucket;
+	void __rcu **slots;
+	unsigned int i, nr;
+	int err = -ENOENT;
+
+	rcu_read_lock();
+	bucket = lock_bucket(rbh, hash);
+	if (!bucket)
+		goto rcu_unlock;
+
+	nr = bucket->rbh_entries;
+	slots = bucket_slots(bucket, nr);
+	for (i = 0; i < nr; i++) {
+		if (bucket->rbh_hashes[i] != hash)
+			continue;
+		if (slots[i] != NULL)
+			continue;
+		rcu_assign_pointer(slots[i], p);
+		err = 0;
+		break;
+	}
+
+	spin_unlock(&bucket->rbh_lock);
+rcu_unlock:
+	rcu_read_unlock();
+	return err;
+}
+EXPORT_SYMBOL(rbh_use);
+
+/**
+ * rbh_next - Find the next entry matching this hash
+ * @rbhi: The rosebush iterator.
+ *
+ * Return: NULL if there are no more matching hash values, otherwise
+ * the next pointer.
+ */
+void *rbh_next(struct rbh_iter *rbhi)
+{
+	struct rbh_bucket *bucket = rbhi->bucket;
+	unsigned int nr;
+	void __rcu **slots;
+	void *p;
+
+	if (!bucket) {
+		bucket = get_bucket(rbhi->rbh, rbhi->hash, NULL);
+		if (!bucket)
+			return NULL;
+		rbhi->bucket = bucket;
+		rbhi->index = UINT_MAX;
+	}
+
+	nr = bucket->rbh_entries;
+	slots = bucket_slots(bucket, nr);
+
+	while (++rbhi->index < nr) {
+		if (READ_ONCE(bucket->rbh_hashes[rbhi->index]) != rbhi->hash)
+			continue;
+		p = rcu_dereference(slots[rbhi->index]);
+		if (p)
+			return p;
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL(rbh_next);
+
+/*
+ * TODO:
+ * * convert the dcache
+ * * 2 byte hashes in the bucket.  Once the table has 2^17 buckets, we can
+ *   use 10 bytes per entry instead of 12
+ * * 1 byte hashes in the bucket.  Once the table has 2^25 buckets, we can
+ *   use 9 bytes per entry instead of 10?
+ */
diff --git a/lib/test_rosebush.c b/lib/test_rosebush.c
new file mode 100644
index 000000000000..344479cb8a94
--- /dev/null
+++ b/lib/test_rosebush.c
@@ -0,0 +1,135 @@
+#include <linux/rosebush.h>
+#include <kunit/test.h>
+
+static void iter_rbh(struct kunit *test, struct rbh *rbh, u32 hash, void *p)
+{
+	RBH_ITER(iter, rbh, hash);
+	void *q;
+
+	rcu_read_lock();
+	q = rbh_next(&iter);
+	rcu_read_unlock();
+	KUNIT_EXPECT_PTR_EQ_MSG(test, p, q,
+		"rbh_next hash:%u returned %px, expected %px", hash, q, p);
+}
+
+static void check_empty_rbh(struct kunit *test, struct rbh *rbh)
+{
+	iter_rbh(test, rbh, 0, NULL);
+	iter_rbh(test, rbh, 1, NULL);
+	iter_rbh(test, rbh, 17, NULL);
+	iter_rbh(test, rbh, 42, NULL);
+}
+
+static void insert(struct kunit *test, struct rbh *rbh, u32 hash)
+{
+	void *p = (void *)((hash << 1) | 1UL);
+	int err;
+
+	err = rbh_insert(rbh, hash, p);
+	KUNIT_EXPECT_EQ(test, err, 0);
+
+	iter_rbh(test, rbh, hash, p);
+}
+
+static void reserve(struct kunit *test, struct rbh *rbh, u32 hash)
+{
+	int err;
+
+	err = rbh_reserve(rbh, hash);
+	KUNIT_EXPECT_EQ(test, err, 0);
+
+	iter_rbh(test, rbh, hash, NULL);
+}
+
+static void use(struct kunit *test, struct rbh *rbh, u32 hash)
+{
+	void *p = (void *)((hash << 1) | 1UL);
+	int err;
+
+	err = rbh_use(rbh, hash, p);
+	KUNIT_EXPECT_EQ(test, err, 0);
+
+	iter_rbh(test, rbh, hash, p);
+}
+
+static void remove(struct kunit *test, struct rbh *rbh, u32 hash)
+{
+	void *p = (void *)((hash << 1) | 1UL);
+	int err;
+
+	err = rbh_remove(rbh, hash, p);
+	KUNIT_EXPECT_EQ(test, err, 0);
+
+	iter_rbh(test, rbh, hash, NULL);
+}
+
+static DEFINE_ROSEBUSH(rosebush);
+
+/*
+ * Conduct a number of tests on a rosebush that has never been used.
+ * They should all return NULL or an errno.  We're looking for crashes
+ * here.
+ */
+static void empty(struct kunit *test)
+{
+	int err;
+
+	check_empty_rbh(test, &rosebush);
+	err = rbh_remove(&rosebush, 0, test);
+	KUNIT_EXPECT_EQ(test, err, -ENOENT);
+	err = rbh_use(&rosebush, 0, test);
+	KUNIT_EXPECT_EQ(test, err, -ENOENT);
+	KUNIT_EXPECT_EQ(test, rosebush.rbh_table, 0);
+}
+
+static void first(struct kunit *test)
+{
+	int err;
+
+	insert(test, &rosebush, 5);
+	check_empty_rbh(test, &rosebush);
+	remove(test, &rosebush, 5);
+	check_empty_rbh(test, &rosebush);
+
+	err = rbh_remove(&rosebush, 5, NULL);
+	KUNIT_EXPECT_EQ(test, err, -ENOENT);
+	reserve(test, &rosebush, 5);
+	err = rbh_remove(&rosebush, 5, test);
+	KUNIT_EXPECT_EQ(test, err, -ENOENT);
+	err = rbh_remove(&rosebush, 5, NULL);
+	KUNIT_EXPECT_EQ(test, err, 0);
+	err = rbh_remove(&rosebush, 5, NULL);
+	KUNIT_EXPECT_EQ(test, err, -ENOENT);
+
+	reserve(test, &rosebush, 5);
+	use(test, &rosebush, 5);
+	err = rbh_remove(&rosebush, 5, NULL);
+	KUNIT_EXPECT_EQ(test, err, -ENOENT);
+	remove(test, &rosebush, 5);
+}
+
+static void grow(struct kunit *test)
+{
+	int i;
+
+	for (i = 3; i < 3333; i += 2)
+		insert(test, &rosebush, i);
+}
+
+static struct kunit_case rosebush_cases[] __refdata = {
+	KUNIT_CASE(empty),
+	KUNIT_CASE(first),
+	KUNIT_CASE(grow),
+	{}
+};
+
+static struct kunit_suite rosebush_suite = {
+	.name = "rosebush",
+	.test_cases = rosebush_cases,
+};
+
+kunit_test_suite(rosebush_suite);
+
+MODULE_AUTHOR("Matthew Wilcox (Oracle) <willy@infradead.org>");
+MODULE_LICENSE("GPL");
-- 
2.43.0


