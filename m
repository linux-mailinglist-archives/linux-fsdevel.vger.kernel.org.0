Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04A2F46BEDD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Dec 2021 16:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238722AbhLGPNm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 10:13:42 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:35280 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238582AbhLGPNb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 10:13:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CB67AB817FA;
        Tue,  7 Dec 2021 15:09:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C72A6C341CC;
        Tue,  7 Dec 2021 15:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638889798;
        bh=WGd7fsWYuMGyr6AETtwoydvmq5KCu2yy5Rl4gz2YBqM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BOsjzz8/1Em8VynfKZe/2Z8ZxwnUnb1k4R8N6YsZShy2vFedtJtO4LtnTt3p9nLnK
         n3TUuy1PtTKlPlZ0cbYqM3ho1Y3Rw/YnwftbbYLAPbfBJElqFEwzhpRbkm26MgD7E1
         wQSG/2tziZFQ+M49CPs3PoVcQhk2WSasHXJ+5v8abGgj18Kfki/5QLQxMe0CCJaxWY
         p+jmh1Z63dZ9jxB5NE7Sb/dtENuyS6YWgxeS6YfbztPm83rjslMtUY3shmprFCQ81p
         nJ1iDy5frS4/pIsTu7v6GCeZmlflYEnMGGa2H9SjxBkeeASpPcOz99ZXeqHtPHWF3Y
         ijf8wxGIJWW0g==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        kernel test robot <lkp@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tejun Heo <tj@kernel.org>, kernelci@groups.io,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [RFC 1/3] headers: add more types to linux/types.h
Date:   Tue,  7 Dec 2021 16:09:25 +0100
Message-Id: <20211207150927.3042197-2-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211207150927.3042197-1-arnd@kernel.org>
References: <20211207150927.3042197-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

There are a couple types for atomics, uid, timespec, and isolate_mode_t
that are used in other central header files like linux/fs.h to define
larger data structures.

The headers that traditionally define these in turn include other headers
recursively, which adds considerable bloat to the preprocessed source
files and requires rebuilding large parts of the kernel for any change
to indirectly included headers.

Moving these into linux/types.h means we can build on top of the structure
with a much smaller set of indirect includes.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arc/include/asm/atomic64-arcv2.h |  4 --
 arch/arm/include/asm/atomic.h         |  4 --
 arch/x86/include/asm/atomic64_32.h    |  4 --
 include/asm-generic/atomic64.h        |  4 --
 include/linux/atomic/atomic-long.h    |  4 +-
 include/linux/ktime.h                 |  3 -
 include/linux/list_bl.h               |  7 ---
 include/linux/list_lru.h              | 15 -----
 include/linux/llist.h                 |  8 ---
 include/linux/mmzone.h                |  3 -
 include/linux/plist.h                 | 10 ---
 include/linux/time64.h                | 13 ----
 include/linux/types.h                 | 90 ++++++++++++++++++++++++++-
 include/linux/uidgid.h                |  9 ---
 include/linux/uuid.h                  |  6 --
 15 files changed, 89 insertions(+), 95 deletions(-)

diff --git a/arch/arc/include/asm/atomic64-arcv2.h b/arch/arc/include/asm/atomic64-arcv2.h
index c5a8010fdc97..25f7ac390e57 100644
--- a/arch/arc/include/asm/atomic64-arcv2.h
+++ b/arch/arc/include/asm/atomic64-arcv2.h
@@ -8,10 +8,6 @@
 #ifndef _ASM_ARC_ATOMIC64_ARCV2_H
 #define _ASM_ARC_ATOMIC64_ARCV2_H
 
-typedef struct {
-	s64 __aligned(8) counter;
-} atomic64_t;
-
 #define ATOMIC64_INIT(a) { (a) }
 
 static inline s64 arch_atomic64_read(const atomic64_t *v)
diff --git a/arch/arm/include/asm/atomic.h b/arch/arm/include/asm/atomic.h
index db8512d9a918..df41a46a46e7 100644
--- a/arch/arm/include/asm/atomic.h
+++ b/arch/arm/include/asm/atomic.h
@@ -243,10 +243,6 @@ ATOMIC_OPS(xor, ^=, eor)
 #define arch_atomic_xchg(v, new) (arch_xchg(&((v)->counter), new))
 
 #ifndef CONFIG_GENERIC_ATOMIC64
-typedef struct {
-	s64 counter;
-} atomic64_t;
-
 #define ATOMIC64_INIT(i) { (i) }
 
 #ifdef CONFIG_ARM_LPAE
diff --git a/arch/x86/include/asm/atomic64_32.h b/arch/x86/include/asm/atomic64_32.h
index 5efd01b548d1..c74f58a719da 100644
--- a/arch/x86/include/asm/atomic64_32.h
+++ b/arch/x86/include/asm/atomic64_32.h
@@ -8,10 +8,6 @@
 
 /* An 64bit atomic type */
 
-typedef struct {
-	s64 __aligned(8) counter;
-} atomic64_t;
-
 #define ATOMIC64_INIT(val)	{ (val) }
 
 #define __ATOMIC64_DECL(sym) void atomic64_##sym(atomic64_t *, ...)
diff --git a/include/asm-generic/atomic64.h b/include/asm-generic/atomic64.h
index 100d24b02e52..a824626346a3 100644
--- a/include/asm-generic/atomic64.h
+++ b/include/asm-generic/atomic64.h
@@ -9,10 +9,6 @@
 #define _ASM_GENERIC_ATOMIC64_H
 #include <linux/types.h>
 
-typedef struct {
-	s64 counter;
-} atomic64_t;
-
 #define ATOMIC64_INIT(i)	{ (i) }
 
 extern s64 generic_atomic64_read(const atomic64_t *v);
diff --git a/include/linux/atomic/atomic-long.h b/include/linux/atomic/atomic-long.h
index 800b8c35992d..82a6971600c3 100644
--- a/include/linux/atomic/atomic-long.h
+++ b/include/linux/atomic/atomic-long.h
@@ -7,15 +7,13 @@
 #define _LINUX_ATOMIC_LONG_H
 
 #include <linux/compiler.h>
-#include <asm/types.h>
+#include <linux/types.h>
 
 #ifdef CONFIG_64BIT
-typedef atomic64_t atomic_long_t;
 #define ATOMIC_LONG_INIT(i)		ATOMIC64_INIT(i)
 #define atomic_long_cond_read_acquire	atomic64_cond_read_acquire
 #define atomic_long_cond_read_relaxed	atomic64_cond_read_relaxed
 #else
-typedef atomic_t atomic_long_t;
 #define ATOMIC_LONG_INIT(i)		ATOMIC_INIT(i)
 #define atomic_long_cond_read_acquire	atomic_cond_read_acquire
 #define atomic_long_cond_read_relaxed	atomic_cond_read_relaxed
diff --git a/include/linux/ktime.h b/include/linux/ktime.h
index 73f20deb497d..4bd945df3446 100644
--- a/include/linux/ktime.h
+++ b/include/linux/ktime.h
@@ -25,9 +25,6 @@
 #include <linux/jiffies.h>
 #include <asm/bug.h>
 
-/* Nanosecond scalar representation for kernel time values */
-typedef s64	ktime_t;
-
 /**
  * ktime_set - Set a ktime_t variable from a seconds/nanoseconds value
  * @secs:	seconds to set
diff --git a/include/linux/list_bl.h b/include/linux/list_bl.h
index ae1b541446c9..d3d6038d748b 100644
--- a/include/linux/list_bl.h
+++ b/include/linux/list_bl.h
@@ -31,13 +31,6 @@
 #endif
 
 
-struct hlist_bl_head {
-	struct hlist_bl_node *first;
-};
-
-struct hlist_bl_node {
-	struct hlist_bl_node *next, **pprev;
-};
 #define INIT_HLIST_BL_HEAD(ptr) \
 	((ptr)->first = NULL)
 
diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index 1b5fceb565df..a2d175f0c3d5 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -25,12 +25,6 @@ enum lru_status {
 				   internally, but has to return locked. */
 };
 
-struct list_lru_one {
-	struct list_head	list;
-	/* may become negative during memcg reparenting */
-	long			nr_items;
-};
-
 struct list_lru_memcg {
 	struct rcu_head		rcu;
 	/* array of per cgroup lists, indexed by memcg_cache_id */
@@ -49,15 +43,6 @@ struct list_lru_node {
 	long nr_items;
 } ____cacheline_aligned_in_smp;
 
-struct list_lru {
-	struct list_lru_node	*node;
-#ifdef CONFIG_MEMCG_KMEM
-	struct list_head	list;
-	int			shrinker_id;
-	bool			memcg_aware;
-#endif
-};
-
 void list_lru_destroy(struct list_lru *lru);
 int __list_lru_init(struct list_lru *lru, bool memcg_aware,
 		    struct lock_class_key *key, struct shrinker *shrinker);
diff --git a/include/linux/llist.h b/include/linux/llist.h
index 85bda2d02d65..99cc3c30f79c 100644
--- a/include/linux/llist.h
+++ b/include/linux/llist.h
@@ -53,14 +53,6 @@
 #include <linux/stddef.h>
 #include <linux/types.h>
 
-struct llist_head {
-	struct llist_node *first;
-};
-
-struct llist_node {
-	struct llist_node *next;
-};
-
 #define LLIST_HEAD_INIT(name)	{ NULL }
 #define LLIST_HEAD(name)	struct llist_head name = LLIST_HEAD_INIT(name)
 
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 58e744b78c2c..852fb61a0817 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -331,9 +331,6 @@ struct lruvec {
 /* Isolate unevictable pages */
 #define ISOLATE_UNEVICTABLE	((__force isolate_mode_t)0x8)
 
-/* LRU Isolation modes. */
-typedef unsigned __bitwise isolate_mode_t;
-
 enum zone_watermarks {
 	WMARK_MIN,
 	WMARK_LOW,
diff --git a/include/linux/plist.h b/include/linux/plist.h
index 0f352c1d3c80..7e236c166191 100644
--- a/include/linux/plist.h
+++ b/include/linux/plist.h
@@ -79,16 +79,6 @@
 
 #include <asm/bug.h>
 
-struct plist_head {
-	struct list_head node_list;
-};
-
-struct plist_node {
-	int			prio;
-	struct list_head	prio_list;
-	struct list_head	node_list;
-};
-
 /**
  * PLIST_HEAD_INIT - static struct plist_head initializer
  * @head:	struct plist_head variable name
diff --git a/include/linux/time64.h b/include/linux/time64.h
index 81b9686a2079..7e323c97ca6c 100644
--- a/include/linux/time64.h
+++ b/include/linux/time64.h
@@ -5,21 +5,8 @@
 #include <linux/math64.h>
 #include <vdso/time64.h>
 
-typedef __s64 time64_t;
-typedef __u64 timeu64_t;
-
 #include <uapi/linux/time.h>
 
-struct timespec64 {
-	time64_t	tv_sec;			/* seconds */
-	long		tv_nsec;		/* nanoseconds */
-};
-
-struct itimerspec64 {
-	struct timespec64 it_interval;
-	struct timespec64 it_value;
-};
-
 /* Located here for timespec[64]_valid_strict */
 #define TIME64_MAX			((s64)~((u64)1 << 63))
 #define TIME64_MIN			(-TIME64_MAX - 1)
diff --git a/include/linux/types.h b/include/linux/types.h
index ac825ad90e44..390492c2a8a2 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -46,6 +46,14 @@ typedef __kernel_old_gid_t	old_gid_t;
 typedef __kernel_loff_t		loff_t;
 #endif
 
+typedef struct {
+	uid_t val;
+} kuid_t;
+
+typedef struct {
+	gid_t val;
+} kgid_t;
+
 /*
  * The following typedefs are also protected by individual ifdefs for
  * historical reasons:
@@ -169,10 +177,14 @@ typedef struct {
 
 #define ATOMIC_INIT(i) { (i) }
 
-#ifdef CONFIG_64BIT
 typedef struct {
-	s64 counter;
+	s64 __aligned(8) counter;
 } atomic64_t;
+
+#ifdef CONFIG_64BIT
+typedef atomic64_t atomic_long_t;
+#else
+typedef atomic_t atomic_long_t;
 #endif
 
 struct list_head {
@@ -187,6 +199,47 @@ struct hlist_node {
 	struct hlist_node *next, **pprev;
 };
 
+struct hlist_bl_head {
+	struct hlist_bl_node *first;
+};
+
+struct hlist_bl_node {
+	struct hlist_bl_node *next, **pprev;
+};
+
+struct llist_head {
+	struct llist_node *first;
+};
+
+struct llist_node {
+	struct llist_node *next;
+};
+
+struct list_lru_one {
+	struct list_head	list;
+	/* may become negative during memcg reparenting */
+	long			nr_items;
+};
+
+struct list_lru {
+	struct list_lru_node	*node;
+#ifdef CONFIG_MEMCG_KMEM
+	struct list_head	list;
+	int			shrinker_id;
+	bool			memcg_aware;
+#endif
+};
+
+struct plist_head {
+	struct list_head node_list;
+};
+
+struct plist_node {
+	int			prio;
+	struct list_head	prio_list;
+	struct list_head	node_list;
+};
+
 struct ustat {
 	__kernel_daddr_t	f_tfree;
 #ifdef CONFIG_ARCH_32BIT_USTAT_F_TINODE
@@ -231,5 +284,38 @@ typedef void (*swap_func_t)(void *a, void *b, int size);
 typedef int (*cmp_r_func_t)(const void *a, const void *b, const void *priv);
 typedef int (*cmp_func_t)(const void *a, const void *b);
 
+#define UUID_SIZE 16
+typedef struct {
+	__u8 b[UUID_SIZE];
+} uuid_t;
+
+/* LRU Isolation modes. */
+typedef unsigned __bitwise isolate_mode_t;
+
+enum pid_type
+{
+	PIDTYPE_PID,
+	PIDTYPE_TGID,
+	PIDTYPE_PGID,
+	PIDTYPE_SID,
+	PIDTYPE_MAX,
+};
+
+typedef __s64 time64_t;
+typedef __u64 timeu64_t;
+
+struct timespec64 {
+	time64_t	tv_sec;			/* seconds */
+	long		tv_nsec;		/* nanoseconds */
+};
+
+struct itimerspec64 {
+	struct timespec64 it_interval;
+	struct timespec64 it_value;
+};
+
+/* Nanosecond scalar representation for kernel time values */
+typedef s64	ktime_t;
+
 #endif /*  __ASSEMBLY__ */
 #endif /* _LINUX_TYPES_H */
diff --git a/include/linux/uidgid.h b/include/linux/uidgid.h
index b0542cd11aeb..1f6e849173be 100644
--- a/include/linux/uidgid.h
+++ b/include/linux/uidgid.h
@@ -18,15 +18,6 @@
 struct user_namespace;
 extern struct user_namespace init_user_ns;
 
-typedef struct {
-	uid_t val;
-} kuid_t;
-
-
-typedef struct {
-	gid_t val;
-} kgid_t;
-
 #define KUIDT_INIT(value) (kuid_t){ value }
 #define KGIDT_INIT(value) (kgid_t){ value }
 
diff --git a/include/linux/uuid.h b/include/linux/uuid.h
index 8cdc0d3567cd..4c078613facd 100644
--- a/include/linux/uuid.h
+++ b/include/linux/uuid.h
@@ -11,12 +11,6 @@
 #include <uapi/linux/uuid.h>
 #include <linux/string.h>
 
-#define UUID_SIZE 16
-
-typedef struct {
-	__u8 b[UUID_SIZE];
-} uuid_t;
-
 #define UUID_INIT(a, b, c, d0, d1, d2, d3, d4, d5, d6, d7)			\
 ((uuid_t)								\
 {{ ((a) >> 24) & 0xff, ((a) >> 16) & 0xff, ((a) >> 8) & 0xff, (a) & 0xff, \
-- 
2.29.2

