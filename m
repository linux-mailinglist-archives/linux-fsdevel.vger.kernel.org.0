Return-Path: <linux-fsdevel+bounces-70614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A5706CA1EE3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 00:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1D2513004455
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 23:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AD12DF13B;
	Wed,  3 Dec 2025 23:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="B8349ss5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644972D94AF
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Dec 2025 23:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764804238; cv=none; b=GZTvYjkSCB/Z2JMlBMKyWBAbbB5tTEX+crmpijJaKqlV+0KrnRReXytn5jpIc0S6kGmPdBwBdrNn/isSyiuSCmvb9Pl05IsInGorT8LXY8WSP+vouwZ8KiZ9u/4NFg3N+7t1585DWZksGx5Fi4ifwCmA+n0LH8gKfS4a/NkA03c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764804238; c=relaxed/simple;
	bh=FNna4aDf052+2z5kOvUw8cJoW5wbT0Q+6+R58S0btU4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FcQ2E0PIhx+BQKkOlqmKbfzT/vn3rkhDdjqE8VWcSD6R4Pxdea1k4VEhb9rHdkgQbDS1HXgpFiIkL2yK9N5NJrbIs4KokOoTxGcHpJiY2LQIwVCFY90fgq/qRCfbiUxWJ1ma1on8+IYL9I3a/hXnOxIoiu5E3YZPxNI5xll6scs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=B8349ss5; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=vBvkSuFDgJD3CUJ+IXbZLR1pyMERqJBhIZl55Uq7cUo=; b=B8349ss5wp7bRyLmDKwTglBcoY
	WoEpAiPcVXehN49DqsFj+4YVFWdRD7XlGs4bmJMN9x7UbtygYtlJ0GBP5UtKxTd2QMLRe/6UpRgpL
	OubHQx3i1pcT0c2KUc9JKJagp/HUK9vB3Z5DnAeXVp7UXekCnkc4vuOiqj4MjUF1+WCr/Ewk4g0as
	KUT0DvGjXj5madgB8Njyga1PMqkRcifmScI0sg3f+iaTgn77X1UnjwvEhIJBl8t/9EUl4fI6n/mVy
	jtxHRK80ZwuPiYmg9bSAnPE0uPMxdQkOe4GE81XQRkdZqykCNlg/b/olwB4fdmVG8RHRbVTWiKBUx
	mkCXbMgw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vQwCc-00000000rpQ-0WeQ;
	Wed, 03 Dec 2025 23:24:06 +0000
Date: Wed, 3 Dec 2025 23:24:06 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH][RFC][slab] static kmem_cache instances for core caches
Message-ID: <20251203232406.GH1712166@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	kmem_cache_create() and friends create new instances of
struct kmem_cache and return pointers to those.  Quite a few things in
core kernel are allocated from such caches; each allocation involves
dereferencing an assign-once pointer and for sufficiently hot ones that
dereferencing does show in profiles.

	There had been patches floating around switching some of those
to runtime_constant infrastructure.  Unfortunately, it's arch-specific
and most of the architectures lack it.

	There's an alternative approach applicable to the caches that
are never destroyed, which covers a lot of them.  No matter what,
runtime_constant for pointers is not going to be faster than plain &,
so if we had struct kmem_cache instances with static storage duration, we
would be at least no worse off than we are with runtime_constant variants.

	There are obstacles to doing that, but they turn out to be easy
to deal with.

1) as it is, struct kmem_cache is opaque for anything outside of a few
files in mm/*; that avoids serious headache with header dependencies,
etc., and it's not something we want to lose.  Solution: struct
kmem_cache_static, with the size and alignment identical to struct
kmem_cache.  Calculation of size and alignment can be done via the same
mechanism we use for asm-offsets.h and rq-offsets.h, with build-time
check for mismatches.  With that done, we get an opaque type defined in
linux/slab.h that can be used for declaring those caches.

2) real constructor of kmem_cache needs to be taught to deal with
preallocated instances.  That turns out to be easy - we already pass an
obscene amount of optional arguments via struct kmem_cache_args, so we
can stash the pointer to preallocated instance in there.  Changes in
mm/slab_common.c are very minor - we should treat preallocated caches
as unmergable, use the instance passed to us instead of allocating a
new one and we should not free them on failure.  That's it.

Patch below implements that and converts several caches (mnt_cache,
signal_cache and thread_stack_cache) to static allocation to demonstrate
the uses.  If we use that in mainline, these would obviously get
split into separate commits.

It seems to work.  There's only one real limitation at the moment
- we should never use kmem_cache_destroy() for such caches; unlike
runtime_constant, we can *use* those caches from modules - there's no
problem with that, as long as the cache itself is in the kernel proper.
The obstacle to use of kmem_cache_destroy() might be possible to lift -
the only tricky part is sysfs-related logics in kmem_cache_release().
I hadn't looked into that; there's a plenty of never-destroyed core
caches, so that thing doesn't lack applications as it is.

Review and comments would be very welcome.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/Kbuild b/Kbuild
index 13324b4bbe23..eb985a6614eb 100644
--- a/Kbuild
+++ b/Kbuild
@@ -45,13 +45,24 @@ kernel/sched/rq-offsets.s: $(offsets-file)
 $(rq-offsets-file): kernel/sched/rq-offsets.s FORCE
 	$(call filechk,offsets,__RQ_OFFSETS_H__)
 
+# generate kmem_cache_size.h
+
+kmem_cache_size-file := include/generated/kmem_cache_size.h
+
+targets += mm/kmem_cache_size.s
+
+mm/kmem_cache_size.s: $(rq-offsets-file)
+
+$(kmem_cache_size-file): mm/kmem_cache_size.s FORCE
+	$(call filechk,offsets,__KMEM_CACHE_SIZE_H__)
+
 # Check for missing system calls
 
 quiet_cmd_syscalls = CALL    $<
       cmd_syscalls = $(CONFIG_SHELL) $< $(CC) $(c_flags) $(missing_syscalls_flags)
 
 PHONY += missing-syscalls
-missing-syscalls: scripts/checksyscalls.sh $(rq-offsets-file)
+missing-syscalls: scripts/checksyscalls.sh $(kmem_cache_size-file)
 	$(call cmd,syscalls)
 
 # Check the manual modification of atomic headers
diff --git a/fs/namespace.c b/fs/namespace.c
index 4272349650b1..53610ebbe3f5 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -85,7 +85,8 @@ static u64 mnt_id_ctr = MNT_UNIQUE_ID_OFFSET;
 
 static struct hlist_head *mount_hashtable __ro_after_init;
 static struct hlist_head *mountpoint_hashtable __ro_after_init;
-static struct kmem_cache *mnt_cache __ro_after_init;
+static struct kmem_cache_opaque __mnt_cache;
+#define mnt_cache to_kmem_cache(&__mnt_cache)
 static DECLARE_RWSEM(namespace_sem);
 static HLIST_HEAD(unmounted);	/* protected by namespace_sem */
 static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
@@ -6016,8 +6017,9 @@ void __init mnt_init(void)
 {
 	int err;
 
-	mnt_cache = kmem_cache_create("mnt_cache", sizeof(struct mount),
-			0, SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT, NULL);
+	kmem_cache_setup("mnt_cache", sizeof(struct mount),
+			0, SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
+			NULL, mnt_cache);
 
 	mount_hashtable = alloc_large_system_hash("Mount-cache",
 				sizeof(struct hlist_head),
diff --git a/include/linux/slab.h b/include/linux/slab.h
index cf443f064a66..89de72bf2e99 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -22,6 +22,15 @@
 #include <linux/cleanup.h>
 #include <linux/hash.h>
 
+#ifndef COMPILE_OFFSETS
+#include <generated/kmem_cache_size.h>
+
+/* same size and alignment as struct kmem_cache: */
+struct kmem_cache_opaque {
+	unsigned char opaque[KMEM_CACHE_SIZE];
+} __aligned(KMEM_CACHE_ALIGN);
+#endif
+
 enum _slab_flag_bits {
 	_SLAB_CONSISTENCY_CHECKS,
 	_SLAB_RED_ZONE,
@@ -261,11 +270,17 @@ enum _slab_flag_bits {
 
 struct list_lru;
 struct mem_cgroup;
+struct kmem_cache_opaque;
 /*
  * struct kmem_cache related prototypes
  */
 bool slab_is_available(void);
 
+static inline struct kmem_cache *to_kmem_cache(struct kmem_cache_opaque *p)
+{
+	return (struct kmem_cache *)p;
+}
+
 /**
  * struct kmem_cache_args - Less common arguments for kmem_cache_create()
  *
@@ -366,6 +381,7 @@ struct kmem_cache_args {
 	 * %0 means no sheaves will be created.
 	 */
 	unsigned int sheaf_capacity;
+	struct kmem_cache *preallocated;
 };
 
 struct kmem_cache *__kmem_cache_create_args(const char *name,
@@ -493,6 +509,34 @@ int kmem_cache_shrink(struct kmem_cache *s);
 				.usersize	= sizeof_field(struct __struct, __field),	\
 			}, (__flags))
 
+static inline int
+kmem_cache_setup_usercopy(const char *name, unsigned int size,
+			  unsigned int align, slab_flags_t flags,
+			  unsigned int useroffset, unsigned int usersize,
+			  void (*ctor)(void *), struct kmem_cache *s)
+{
+	struct kmem_cache *res;
+
+	res = __kmem_cache_create_args(name, size,
+				       &(struct kmem_cache_args) {
+						.align		= align,
+						.ctor		= ctor,
+						.useroffset	= useroffset,
+						.usersize	= usersize,
+						.preallocated	= s},
+				       flags);
+	return PTR_ERR_OR_ZERO(res);
+}
+
+static inline int
+kmem_cache_setup(const char *name, unsigned int size,
+		 unsigned int align, slab_flags_t flags,
+		 void (*ctor)(void *), struct kmem_cache *s)
+{
+	return kmem_cache_setup_usercopy(name, size, align, flags,
+					 0, 0, ctor, s);
+}
+
 /*
  * Common kmalloc functions provided by all allocators
  */
diff --git a/kernel/fork.c b/kernel/fork.c
index 3da0f08615a9..e9fcbb55f2f6 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -379,7 +379,8 @@ static void free_thread_stack(struct task_struct *tsk)
 
 #else /* !(THREAD_SIZE >= PAGE_SIZE) */
 
-static struct kmem_cache *thread_stack_cache;
+static struct kmem_cache_opaque __thread_stack_cache;
+#define thread_stack_cache to_kmem_cache(&__thread_stack_cache)
 
 static void thread_stack_free_rcu(struct rcu_head *rh)
 {
@@ -410,17 +411,17 @@ static void free_thread_stack(struct task_struct *tsk)
 
 void thread_stack_cache_init(void)
 {
-	thread_stack_cache = kmem_cache_create_usercopy("thread_stack",
-					THREAD_SIZE, THREAD_SIZE, 0, 0,
-					THREAD_SIZE, NULL);
-	BUG_ON(thread_stack_cache == NULL);
+	kmem_cache_setup_usercopy("thread_stack", THREAD_SIZE, THREAD_SIZE,
+				  SLAB_PANIC, 0, THREAD_SIZE, NULL,
+				  thread_stack_cache);
 }
 
 #endif /* THREAD_SIZE >= PAGE_SIZE */
 #endif /* CONFIG_VMAP_STACK */
 
 /* SLAB cache for signal_struct structures (tsk->signal) */
-static struct kmem_cache *signal_cachep;
+static struct kmem_cache_opaque signal_cache;
+#define signal_cachep to_kmem_cache(&signal_cache)
 
 /* SLAB cache for sighand_struct structures (tsk->sighand) */
 struct kmem_cache *sighand_cachep;
@@ -2980,10 +2981,10 @@ void __init proc_caches_init(void)
 			sizeof(struct sighand_struct), 0,
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_TYPESAFE_BY_RCU|
 			SLAB_ACCOUNT, sighand_ctor);
-	signal_cachep = kmem_cache_create("signal_cache",
+	kmem_cache_setup("signal_cache",
 			sizeof(struct signal_struct), 0,
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
-			NULL);
+			NULL, signal_cachep);
 	files_cachep = kmem_cache_create("files_cache",
 			sizeof(struct files_struct), 0,
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
diff --git a/mm/kmem_cache_size.c b/mm/kmem_cache_size.c
new file mode 100644
index 000000000000..1ddbfa41a507
--- /dev/null
+++ b/mm/kmem_cache_size.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Generate definitions needed by the preprocessor.
+ * This code generates raw asm output which is post-processed
+ * to extract and format the required data.
+ */
+
+#define COMPILE_OFFSETS
+#include <linux/kbuild.h>
+#include "slab.h"
+
+int main(void)
+{
+	/* The constants to put into include/generated/kmem_cache_size.h */
+	DEFINE(KMEM_CACHE_SIZE, sizeof(struct kmem_cache));
+	DEFINE(KMEM_CACHE_ALIGN, __alignof(struct kmem_cache));
+	/* End of constants */
+
+	return 0;
+}
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 932d13ada36c..fc6c2864fe8a 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -224,33 +224,30 @@ static struct kmem_cache *create_cache(const char *name,
 				       struct kmem_cache_args *args,
 				       slab_flags_t flags)
 {
-	struct kmem_cache *s;
+	struct kmem_cache *s = args->preallocated;
 	int err;
 
 	/* If a custom freelist pointer is requested make sure it's sane. */
-	err = -EINVAL;
 	if (args->use_freeptr_offset &&
 	    (args->freeptr_offset >= object_size ||
 	     !(flags & SLAB_TYPESAFE_BY_RCU) ||
 	     !IS_ALIGNED(args->freeptr_offset, __alignof__(freeptr_t))))
-		goto out;
+		return ERR_PTR(-EINVAL);
 
-	err = -ENOMEM;
-	s = kmem_cache_zalloc(kmem_cache, GFP_KERNEL);
-	if (!s)
-		goto out;
+	if (!s) {
+		s = kmem_cache_zalloc(kmem_cache, GFP_KERNEL);
+		if (!s)
+			return ERR_PTR(-ENOMEM);
+	}
 	err = do_kmem_cache_create(s, name, object_size, args, flags);
-	if (err)
-		goto out_free_cache;
-
+	if (unlikely(err)) {
+		if (!args->preallocated)
+			kmem_cache_free(kmem_cache, s);
+		return ERR_PTR(err);
+	}
 	s->refcount = 1;
 	list_add(&s->list, &slab_caches);
 	return s;
-
-out_free_cache:
-	kmem_cache_free(kmem_cache, s);
-out:
-	return ERR_PTR(err);
 }
 
 /**
@@ -324,6 +321,9 @@ struct kmem_cache *__kmem_cache_create_args(const char *name,
 		    object_size - args->usersize < args->useroffset))
 		args->usersize = args->useroffset = 0;
 
+	if (args->preallocated)
+		flags |= SLAB_NO_MERGE;
+
 	if (!args->usersize && !args->sheaf_capacity)
 		s = __kmem_cache_alias(name, object_size, args->align, flags,
 				       args->ctor);
diff --git a/mm/slub.c b/mm/slub.c
index a0b905c2a557..faab13c6aaf9 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -8465,6 +8465,12 @@ void __init kmem_cache_init(void)
 		boot_kmem_cache_node;
 	int node;
 
+	/* verify that kmem_cache_opaque is correct */
+	BUILD_BUG_ON(sizeof(struct kmem_cache) !=
+		     sizeof(struct kmem_cache_opaque));
+	BUILD_BUG_ON(__alignof(struct kmem_cache) !=
+		     __alignof(struct kmem_cache_opaque));
+
 	if (debug_guardpage_minorder())
 		slub_max_order = 0;
 

