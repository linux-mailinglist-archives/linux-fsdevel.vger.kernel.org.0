Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEF683B8AA7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jul 2021 00:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbhF3W7y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Jun 2021 18:59:54 -0400
Received: from smtp-8fae.mail.infomaniak.ch ([83.166.143.174]:57655 "EHLO
        smtp-8fae.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232397AbhF3W7x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Jun 2021 18:59:53 -0400
X-Greylist: delayed 476 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Jun 2021 18:59:52 EDT
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4GFc3R1nvNzMq1Tt;
        Thu,  1 Jul 2021 00:49:23 +0200 (CEST)
Received: from localhost (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4GFc3Q6W1yzlh8T2;
        Thu,  1 Jul 2021 00:49:22 +0200 (CEST)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Serge Hallyn <serge@hallyn.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Andy Lutomirski <luto@amacapital.net>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>
Subject: [PATCH v1 2/4] landlock: Add filesystem rule caching
Date:   Thu,  1 Jul 2021 00:48:54 +0200
Message-Id: <20210630224856.1313928-3-mic@digikod.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210630224856.1313928-1-mic@digikod.net>
References: <20210630224856.1313928-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mickaël Salaün <mic@linux.microsoft.com>

Because of the unprivileged nature of Landlock, the main issue with the
current implementation is that path access checks require to walk from
the leaf file to the (real) root directory for each open-like syscall.
To limit this path walk, leverage the new resolve_path_at() hook to
reuse cached accesses collected for files at open time, when these files
are then used for relative path resolution (e.g. dirfd in openat()-like
syscalls).

Indeed, in practice, software walking through the filesystem (e.g.
"find" tool) trigger a lot of access checks.  However, efficient walk
implementations reuse opened directory file descriptors to continue the
walk to children directories.  Being able to cache such access checks
leads to significant performance improvements.

This cache mechanism is implemented thanks to new Landlock security
blobs attached to tasks and files.  Each landlocked task keeps a
(weak) reference to the last file used to open a path.  If the
referenced base path matches a directory in the current path walk and if
the access request was already granted to the base path, then the path
walk stops early and access is granted.

Each file opened by a landlocked task gets a cache that will be valid as
long as the backing struct file exists.  This cache also references the
domain for which the cached accesses are valid.

Running the "find" tool on a directory with Linux source files (version
5.13, which contains a depth of less than 10 nested source directories)
is used as a metric because it is a real-life worse case that requires
to walk through a lot of files in different directories.  To highlight
the measured performance impact, we put these source files in directories
of different depth: 1, 10 and 20.  Here are the times taken by
Landlock for an open syscall after 10,000 iterations with the mainline
kernel and the caching changes:

Depth of 1: /0/
- v5.13: 28%
- this patch: 22%

Depth of 10: /0/1/.../9/
- v5.13: 43%
- this patch: 25%

Depth of 20: /0/1/.../19/
- v5.13: 54%
- this patch: 30%

The performance impact for such worth case is significantly reduced:
theoretically going from O(n) with n as the depth of a path, to O(1),
but as we can see there is still an increased penalty with the depth.
This may be explained with the relative ".." resolutions that don't
benefit from this caching.  As a side note, the getdents64 syscall (not
impacted by Landlock) takes 18 times longer than the openat syscall in
is this scenario.

Cc: James Morris <jmorris@namei.org>
Cc: Jann Horn <jannh@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Serge Hallyn <serge@hallyn.com>
Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
Link: https://lore.kernel.org/r/20210630224856.1313928-3-mic@digikod.net
---
 security/landlock/cache.h |  77 +++++++++++++
 security/landlock/cred.c  |  15 ++-
 security/landlock/cred.h  |  20 +++-
 security/landlock/fs.c    | 224 +++++++++++++++++++++++++++++++++++---
 security/landlock/fs.h    |  29 +++++
 security/landlock/setup.c |   2 +
 6 files changed, 350 insertions(+), 17 deletions(-)
 create mode 100644 security/landlock/cache.h

diff --git a/security/landlock/cache.h b/security/landlock/cache.h
new file mode 100644
index 000000000000..7ceaa3b15671
--- /dev/null
+++ b/security/landlock/cache.h
@@ -0,0 +1,77 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Landlock LSM - Generic cache management
+ *
+ * Copyright © 2021 Microsoft Corporation
+ */
+
+#ifndef _SECURITY_LANDLOCK_CACHE_H
+#define _SECURITY_LANDLOCK_CACHE_H
+
+#include <linux/compiler.h>
+#include <linux/refcount.h>
+#include <linux/types.h>
+
+#include "ruleset.h"
+
+/**
+ * struct landlock_cache - Generic access cache for an object
+ *
+ * Store cached access rights for a Landlock object (i.e. tied to specific
+ * domain).  Allowed accesses are set once (e.g. at file opening) and never
+ * change after that.  As a side effect, this means that such cache created
+ * before a domain transition will not get an up to date allowed accesses.
+ * This implies to always check a cached domain against the current domain
+ * thanks to landlock_cache_is_valid().
+ *
+ * This struct is part of a typed cache (e.g. &struct landlock_fs_cache.core)
+ * that identifies the tied object.
+ */
+struct landlock_cache {
+	/**
+	 * @dangling_domain: If not NULL, points to the domain for which
+	 * @allowed_accesses is valid.  This brings two constraints:
+	 * - @dangling_domain must only be read with READ_ONCE() and written
+	 *   with WRITE_ONCE() (except at initialization).
+	 * - @dangling_domain can only be safely dereferenced by the cache
+	 *   owner (e.g. with landlock_disable_cache() when the underlying file
+	 *   is being closed).
+	 */
+	void *dangling_domain;
+	/**
+	 * @usage: This counter is used to keep a cache alive while it can
+	 * still be checked against.
+	 */
+	refcount_t usage;
+	/**
+	 * @allowed_accesses: Mask of absolute known-to-be allowed accesses to
+	 * an object at creation-time (e.g. at open-time for the file hierarchy
+	 * of a file descriptor).  A bit not set doesn't mean that the related
+	 * access is denied.  The type of access is inferred from the type of
+	 * the related object.  The task domain may not be the same as the
+	 * cached one and they must then be checked against each other when
+	 * evaluating @allowed_accesses thanks to landlock_cache_is_valid().
+	 */
+	u16 allowed_accesses;
+};
+
+static inline void landlock_disable_cache(struct landlock_cache *cache)
+{
+	struct landlock_ruleset *const dom = cache->dangling_domain;
+
+	/* Atomically marks the cache as disabled. */
+	WRITE_ONCE(cache->dangling_domain, NULL);
+	/*
+	 * There is no need for other synchronisation mechanism because the
+	 * domain is never dereferenced elsewhere.
+	 */
+	landlock_put_ruleset(dom);
+}
+
+static inline bool landlock_cache_is_valid(const struct landlock_cache *cache,
+		const struct landlock_ruleset *domain)
+{
+	return (domain && domain == READ_ONCE(cache->dangling_domain));
+}
+
+#endif /* _SECURITY_LANDLOCK_CACHE_H */
diff --git a/security/landlock/cred.c b/security/landlock/cred.c
index 6725af24c684..8c9408dd46e1 100644
--- a/security/landlock/cred.c
+++ b/security/landlock/cred.c
@@ -1,16 +1,19 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Landlock LSM - Credential hooks
+ * Landlock LSM - Credential and task hooks
  *
  * Copyright © 2017-2020 Mickaël Salaün <mic@digikod.net>
  * Copyright © 2018-2020 ANSSI
+ * Copyright © 2021 Microsoft Corporation
  */
 
 #include <linux/cred.h>
 #include <linux/lsm_hooks.h>
+#include <linux/sched.h>
 
 #include "common.h"
 #include "cred.h"
+#include "fs.h"
 #include "ruleset.h"
 #include "setup.h"
 
@@ -34,9 +37,19 @@ static void hook_cred_free(struct cred *const cred)
 		landlock_put_ruleset_deferred(dom);
 }
 
+static void hook_task_free(struct task_struct *const task)
+{
+	struct landlock_fs_cache *const last_at_cache =
+		landlock_task(task)->cache.last_at;
+
+	landlock_put_fs_cache(last_at_cache);
+}
+
 static struct security_hook_list landlock_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(cred_prepare, hook_cred_prepare),
 	LSM_HOOK_INIT(cred_free, hook_cred_free),
+
+	LSM_HOOK_INIT(task_free, hook_task_free),
 };
 
 __init void landlock_add_cred_hooks(void)
diff --git a/security/landlock/cred.h b/security/landlock/cred.h
index 5f99d3decade..0734a14933c1 100644
--- a/security/landlock/cred.h
+++ b/security/landlock/cred.h
@@ -1,9 +1,10 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Landlock LSM - Credential hooks
+ * Landlock LSM - Credential and task hooks
  *
  * Copyright © 2019-2020 Mickaël Salaün <mic@digikod.net>
  * Copyright © 2019-2020 ANSSI
+ * Copyright © 2021 Microsoft Corporation
  */
 
 #ifndef _SECURITY_LANDLOCK_CRED_H
@@ -13,6 +14,7 @@
 #include <linux/init.h>
 #include <linux/rcupdate.h>
 
+#include "fs.h"
 #include "ruleset.h"
 #include "setup.h"
 
@@ -20,13 +22,27 @@ struct landlock_cred_security {
 	struct landlock_ruleset *domain;
 };
 
+struct landlock_task_cache {
+	struct landlock_fs_cache *last_at;
+};
+
+struct landlock_task_security {
+	struct landlock_task_cache cache;
+};
+
 static inline struct landlock_cred_security *landlock_cred(
 		const struct cred *cred)
 {
 	return cred->security + landlock_blob_sizes.lbs_cred;
 }
 
-static inline const struct landlock_ruleset *landlock_get_current_domain(void)
+static inline struct landlock_task_security *landlock_task(
+		const struct task_struct *task)
+{
+	return task->security + landlock_blob_sizes.lbs_task;
+}
+
+static inline struct landlock_ruleset *landlock_get_current_domain(void)
 {
 	return landlock_cred(current_cred())->domain;
 }
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 97b8e421f617..f9ea08f4078f 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -4,6 +4,7 @@
  *
  * Copyright © 2016-2020 Mickaël Salaün <mic@digikod.net>
  * Copyright © 2018-2020 ANSSI
+ * Copyright © 2021 Microsoft Corporation
  */
 
 #include <linux/atomic.h>
@@ -20,6 +21,7 @@
 #include <linux/lsm_hooks.h>
 #include <linux/mount.h>
 #include <linux/namei.h>
+#include <linux/overflow.h>
 #include <linux/path.h>
 #include <linux/rcupdate.h>
 #include <linux/spinlock.h>
@@ -29,6 +31,7 @@
 #include <linux/workqueue.h>
 #include <uapi/linux/landlock.h>
 
+#include "cache.h"
 #include "common.h"
 #include "cred.h"
 #include "fs.h"
@@ -37,6 +40,78 @@
 #include "ruleset.h"
 #include "setup.h"
 
+/* Cache management */
+
+/**
+ * struct landlock_fs_cache - Landlock access cache for the filesystem
+ *
+ * Cached accesses for a filesystem object relative to a specific domain.
+ */
+struct landlock_fs_cache {
+	/**
+	 * @dangling_path: Enables identifying a path (same mnt and dentry
+	 * fields), iff the other path is held and
+	 * READ_ONCE(core->dangling_domain) is not NULL.  Because there is no
+	 * synchronization mechanism, @dangling_path can only be safely
+	 * derefenced by the cache owner (e.g. with create_fs_cache()).
+	 */
+	struct path dangling_path;
+	/**
+	 * @core: Stores the generic caching.
+	 */
+	struct landlock_cache core;
+};
+
+static void build_check_cache(void)
+{
+	const struct landlock_cache cache = {
+		.allowed_accesses = ~0,
+	};
+	struct landlock_layer *layer;
+	struct landlock_ruleset *ruleset;
+
+	BUILD_BUG_ON(cache.allowed_accesses < LANDLOCK_MASK_ACCESS_FS);
+	BUILD_BUG_ON(!__same_type(cache.allowed_accesses, layer->access));
+	BUILD_BUG_ON(!__same_type(cache.allowed_accesses,
+				ruleset->fs_access_masks[0]));
+}
+
+static struct landlock_fs_cache *create_fs_cache(
+		struct landlock_ruleset *domain, const u16 allowed_accesses,
+		struct path *const path)
+{
+	struct landlock_fs_cache *cache;
+
+	build_check_cache();
+
+	/* Only creates useful cache. */
+	if (!allowed_accesses)
+		return NULL;
+
+	cache = kzalloc(sizeof(*cache), GFP_KERNEL_ACCOUNT);
+	if (!cache)
+		return NULL;
+
+	landlock_get_ruleset(domain);
+	cache->core.dangling_domain = domain;
+	cache->core.allowed_accesses = allowed_accesses;
+	path_get(path);
+	cache->dangling_path = *path;
+	refcount_set(&cache->core.usage, 1);
+	return cache;
+}
+
+static void landlock_get_fs_cache(struct landlock_fs_cache *cache)
+{
+	refcount_inc(&cache->core.usage);
+}
+
+void landlock_put_fs_cache(struct landlock_fs_cache *cache)
+{
+	if (cache && refcount_dec_and_test(&cache->core.usage))
+		kfree(cache);
+}
+
 /* Underlying object management */
 
 static void release_inode(struct landlock_object *const object)
@@ -180,10 +255,42 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
 
 /* Access-control management */
 
+static inline bool is_allowed_in_cache(
+		const struct landlock_ruleset *const domain,
+		const struct path *const path, const u32 access_request,
+		u16 (*const denied_cache)[])
+{
+	size_t i;
+	struct landlock_fs_cache *const fs_cache =
+		landlock_task(current)->cache.last_at;
+
+	if (!fs_cache)
+		return false;
+	/*
+	 * This domain check protects against race conditions when checking if
+	 * @path is equal to fs_cache->dangling_path because we own @path and
+	 * fs_cache->dangling_path is only reset after the cache is disabled.
+	 */
+	if (!landlock_cache_is_valid(&fs_cache->core, domain))
+		return false;
+	/* path_equal() doesn't dereference the mnt and dentry fields. */
+	if (!path_equal(path, &fs_cache->dangling_path))
+		return false;
+
+	/* Fills the returned cache as much as possible. */
+	for (i = 0; i < domain->num_layers; i++)
+		/* Removes allowed accesses from the denied lists. */
+		(*denied_cache)[i] &= ~fs_cache->core.allowed_accesses;
+
+	if ((access_request & fs_cache->core.allowed_accesses) != access_request)
+		return false;
+	return true;
+}
+
 static inline u64 unmask_layers(
 		const struct landlock_ruleset *const domain,
 		const struct path *const path, const u32 access_request,
-		u64 layer_mask)
+		u64 layer_mask, u16 (*const denied_cache)[])
 {
 	const struct landlock_rule *rule;
 	const struct inode *inode;
@@ -212,19 +319,20 @@ static inline u64 unmask_layers(
 		const u64 layer_level = BIT_ULL(layer->level - 1);
 
 		/* Checks that the layer grants access to the full request. */
-		if ((layer->access & access_request) == access_request) {
+		if ((layer->access & access_request) == access_request)
 			layer_mask &= ~layer_level;
 
-			if (layer_mask == 0)
-				return layer_mask;
-		}
+		/* Removes allowed accesses from the denied lists. */
+		(*denied_cache)[layer->level - 1] &= ~layer->access;
 	}
 	return layer_mask;
 }
 
 static int check_access_path(const struct landlock_ruleset *const domain,
-		const struct path *const path, u32 access_request)
+		const struct path *const path, const u32 access_request,
+		u16 *const allowed_accesses)
 {
+	typeof(*allowed_accesses) denied_cache[LANDLOCK_MAX_NUM_LAYERS];
 	bool allowed = false;
 	struct path walker_path;
 	u64 layer_mask;
@@ -252,6 +360,8 @@ static int check_access_path(const struct landlock_ruleset *const domain,
 	/* Saves all layers handling a subset of requested accesses. */
 	layer_mask = 0;
 	for (i = 0; i < domain->num_layers; i++) {
+		/* Stores potentially denied accesses. */
+		denied_cache[i] = domain->fs_access_masks[i];
 		if (domain->fs_access_masks[i] & access_request)
 			layer_mask |= BIT_ULL(i);
 	}
@@ -268,8 +378,15 @@ static int check_access_path(const struct landlock_ruleset *const domain,
 	while (true) {
 		struct dentry *parent_dentry;
 
+		if (is_allowed_in_cache(domain, &walker_path,
+					access_request, &denied_cache)) {
+			/* Stops when access request is allowed by a cache. */
+			allowed = true;
+			break;
+		}
+
 		layer_mask = unmask_layers(domain, &walker_path,
-				access_request, layer_mask);
+				access_request, layer_mask, &denied_cache);
 		if (layer_mask == 0) {
 			/* Stops when a rule from each layer grants access. */
 			allowed = true;
@@ -304,6 +421,15 @@ static int check_access_path(const struct landlock_ruleset *const domain,
 		walker_path.dentry = parent_dentry;
 	}
 	path_put(&walker_path);
+
+	if (allowed_accesses) {
+		typeof(*allowed_accesses) allowed_cache =
+			LANDLOCK_MASK_ACCESS_FS;
+
+		for (i = 0; i < domain->num_layers; i++)
+			allowed_cache &= ~denied_cache[i];
+		*allowed_accesses = allowed_cache;
+	}
 	return allowed ? 0 : -EACCES;
 }
 
@@ -315,7 +441,7 @@ static inline int current_check_access_path(const struct path *const path,
 
 	if (!dom)
 		return 0;
-	return check_access_path(dom, path, access_request);
+	return check_access_path(dom, path, access_request, NULL);
 }
 
 /* Inode hooks */
@@ -560,7 +686,8 @@ static int hook_path_link(struct dentry *const old_dentry,
 	if (unlikely(d_is_negative(old_dentry)))
 		return -ENOENT;
 	return check_access_path(dom, new_dir,
-			get_mode_access(d_backing_inode(old_dentry)->i_mode));
+			get_mode_access(d_backing_inode(old_dentry)->i_mode),
+			NULL);
 }
 
 static inline u32 maybe_remove(const struct dentry *const dentry)
@@ -590,7 +717,8 @@ static int hook_path_rename(const struct path *const old_dir,
 	/* RENAME_EXCHANGE is handled because directories are the same. */
 	return check_access_path(dom, old_dir, maybe_remove(old_dentry) |
 			maybe_remove(new_dentry) |
-			get_mode_access(d_backing_inode(old_dentry)->i_mode));
+			get_mode_access(d_backing_inode(old_dentry)->i_mode),
+			NULL);
 }
 
 static int hook_path_mkdir(const struct path *const dir,
@@ -608,7 +736,7 @@ static int hook_path_mknod(const struct path *const dir,
 
 	if (!dom)
 		return 0;
-	return check_access_path(dom, dir, get_mode_access(mode));
+	return check_access_path(dom, dir, get_mode_access(mode), NULL);
 }
 
 static int hook_path_symlink(const struct path *const dir,
@@ -651,17 +779,83 @@ static inline u32 get_file_access(const struct file *const file)
 
 static int hook_file_open(struct file *const file)
 {
-	const struct landlock_ruleset *const dom =
-		landlock_get_current_domain();
+	int ret;
+	u16 allowed_accesses = 0;
+	struct landlock_ruleset *const dom = landlock_get_current_domain();
 
 	if (!dom)
 		return 0;
+
 	/*
 	 * Because a file may be opened with O_PATH, get_file_access() may
 	 * return 0.  This case will be handled with a future Landlock
 	 * evolution.
 	 */
-	return check_access_path(dom, &file->f_path, get_file_access(file));
+	ret = check_access_path(dom, &file->f_path, get_file_access(file),
+			&allowed_accesses);
+
+	/*
+	 * Ignores (accounted) memory allocation errors: just don't
+	 * create a cache.
+	 */
+	landlock_file(file)->cache = create_fs_cache(dom,
+			allowed_accesses, &file->f_path);
+	return ret;
+}
+
+static void hook_file_free_security(struct file *const file)
+{
+	struct landlock_fs_cache *const file_cache =
+		landlock_file(file)->cache;
+
+	if (!file_cache)
+		return;
+
+	/*
+	 * If there is a cache, it is well alive because it was created at this
+	 * file opening and is owned by this file.  Disables the cache and puts
+	 * the (dangling) object reference; the order doesn't matter.  There is
+	 * no access-control race-condition in is_allowed_in_cache() because
+	 * the dangling path can only match if it is also owned by the caller.
+	 */
+	landlock_disable_cache(&file_cache->core);
+	/*
+	 * Releases dangling_path; it may be freed at the end of file_free().
+	 * Even if it is not required, resets dangling_path as a safety
+	 * measure.
+	 */
+	path_put_init(&file_cache->dangling_path);
+	landlock_put_fs_cache(file_cache);
+}
+
+static int hook_resolve_path_at(const struct path *path_at,
+		struct file *file_at, int lookup_flags)
+{
+	const struct landlock_ruleset *const dom =
+		landlock_get_current_domain();
+	struct landlock_fs_cache **const current_at_cache =
+		&landlock_task(current)->cache.last_at;
+
+	if (!dom)
+		return 0;
+
+	/* Clean up previous cache, if any. */
+	landlock_put_fs_cache(*current_at_cache);
+	*current_at_cache = NULL;
+
+	if (file_at) {
+		struct landlock_fs_cache *const file_at_cache =
+			landlock_file(file_at)->cache;
+
+		if (!file_at_cache)
+			return 0;
+		/* Don't update existing cached accesses. */
+		if (!landlock_cache_is_valid(&file_at_cache->core, dom))
+			return 0;
+		landlock_get_fs_cache(file_at_cache);
+		*current_at_cache = file_at_cache;
+	}
+	return 0;
 }
 
 static struct security_hook_list landlock_hooks[] __lsm_ro_after_init = {
@@ -683,6 +877,8 @@ static struct security_hook_list landlock_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(path_rmdir, hook_path_rmdir),
 
 	LSM_HOOK_INIT(file_open, hook_file_open),
+	LSM_HOOK_INIT(file_free_security, hook_file_free_security),
+	LSM_HOOK_INIT(resolve_path_at, hook_resolve_path_at),
 };
 
 __init void landlock_add_fs_hooks(void)
diff --git a/security/landlock/fs.h b/security/landlock/fs.h
index 187284b421c9..2c57406f73b4 100644
--- a/security/landlock/fs.h
+++ b/security/landlock/fs.h
@@ -4,6 +4,7 @@
  *
  * Copyright © 2017-2020 Mickaël Salaün <mic@digikod.net>
  * Copyright © 2018-2020 ANSSI
+ * Copyright © 2021 Microsoft Corporation
  */
 
 #ifndef _SECURITY_LANDLOCK_FS_H
@@ -12,7 +13,9 @@
 #include <linux/fs.h>
 #include <linux/init.h>
 #include <linux/rcupdate.h>
+#include <linux/refcount.h>
 
+#include "object.h"
 #include "ruleset.h"
 #include "setup.h"
 
@@ -50,6 +53,24 @@ struct landlock_superblock_security {
 	atomic_long_t inode_refs;
 };
 
+struct landlock_fs_cache;
+
+/**
+ * struct landlock_file_security - File security blob
+ *
+ * Cached access right for an open file.
+ */
+struct landlock_file_security {
+	/**
+	 * @cache: This cache is set once at the file opening and never change
+	 * after that (except when freeing the file).  This means that a file
+	 * open before a domain transition will not get an updated cache, but
+	 * the domain tied to the cache must always be checked with
+	 * landlock_cache_is_valid().
+	 */
+	struct landlock_fs_cache *cache;
+};
+
 static inline struct landlock_inode_security *landlock_inode(
 		const struct inode *const inode)
 {
@@ -62,8 +83,16 @@ static inline struct landlock_superblock_security *landlock_superblock(
 	return superblock->s_security + landlock_blob_sizes.lbs_superblock;
 }
 
+static inline struct landlock_file_security *landlock_file(
+		const struct file *const file)
+{
+	return file->f_security + landlock_blob_sizes.lbs_file;
+}
+
 __init void landlock_add_fs_hooks(void);
 
+void landlock_put_fs_cache(struct landlock_fs_cache *cache);
+
 int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
 		const struct path *const path, u32 access_hierarchy);
 
diff --git a/security/landlock/setup.c b/security/landlock/setup.c
index f8e8e980454c..42d381dd0f0c 100644
--- a/security/landlock/setup.c
+++ b/security/landlock/setup.c
@@ -19,8 +19,10 @@ bool landlock_initialized __lsm_ro_after_init = false;
 
 struct lsm_blob_sizes landlock_blob_sizes __lsm_ro_after_init = {
 	.lbs_cred = sizeof(struct landlock_cred_security),
+	.lbs_file = sizeof(struct landlock_file_security),
 	.lbs_inode = sizeof(struct landlock_inode_security),
 	.lbs_superblock = sizeof(struct landlock_superblock_security),
+	.lbs_task = sizeof(struct landlock_task_security),
 };
 
 static int __init landlock_init(void)
-- 
2.32.0

