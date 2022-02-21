Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD294BEC87
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Feb 2022 22:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234825AbiBUVXa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Feb 2022 16:23:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234717AbiBUVXU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Feb 2022 16:23:20 -0500
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [185.125.25.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14DF2AD9
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Feb 2022 13:22:51 -0800 (PST)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4K2Znt54SbzMqHdH;
        Mon, 21 Feb 2022 22:15:14 +0100 (CET)
Received: from localhost (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4K2Znt2z92zljTgK;
        Mon, 21 Feb 2022 22:15:14 +0100 (CET)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Paul Moore <paul@paul-moore.com>,
        Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>
Subject: [PATCH v1 06/11] landlock: Add support for file reparenting with LANDLOCK_ACCESS_FS_REFER
Date:   Mon, 21 Feb 2022 22:25:17 +0100
Message-Id: <20220221212522.320243-7-mic@digikod.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220221212522.320243-1-mic@digikod.net>
References: <20220221212522.320243-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mickaël Salaün <mic@linux.microsoft.com>

Add a new LANDLOCK_ACCESS_FS_REFER access right to enable policy writers
to allow sandboxed processes to link and rename files from and to a
specific set of file hierarchies.  This access right should be composed
with LANDLOCK_ACCESS_FS_MAKE_* for the destination of a link or rename,
and with LANDLOCK_ACCESS_FS_REMOVE_* for a source of a rename.  This
lift a Landlock limitation that always denied changing the parent of an
inode.

Renaming or linking to the same directory is still always allowed,
whatever LANDLOCK_ACCESS_FS_REFER is used or not, because it is not
considered a threat to user data.

However, creating multiple links or renaming to a different parent
directory may lead to privilege escalations if not handled properly.
Indeed, we must be sure that the source doesn't gain more privileges by
being accessible from the destination.  This is handled by making sure
that the source hierarchy (including the referenced file or directory
itself) restricts at least as much the destination hierarchy.  If it is
not the case, an EXDEV error is returned, making it potentially possible
for user space to copy the file hierarchy instead of moving or linking
it.

Instead of creating different access rights for the source and the
destination, we choose to make it simple and consistent for users.
Indeed, considering the previous constraint, it would be weird to
require such destination access right to be also granted to the source
(to make it a superset).

See the provided documentation for additional details.

New tests are provided with a following commit.

Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
Link: https://lore.kernel.org/r/20220221212522.320243-7-mic@digikod.net
---
 include/uapi/linux/landlock.h                |  27 +-
 security/landlock/fs.c                       | 550 ++++++++++++++++---
 security/landlock/limits.h                   |   2 +-
 security/landlock/syscalls.c                 |   2 +-
 tools/testing/selftests/landlock/base_test.c |   2 +-
 tools/testing/selftests/landlock/fs_test.c   |   3 +-
 6 files changed, 516 insertions(+), 70 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index b3d952067f59..f433d58a58f2 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -21,8 +21,14 @@ struct landlock_ruleset_attr {
 	/**
 	 * @handled_access_fs: Bitmask of actions (cf. `Filesystem flags`_)
 	 * that is handled by this ruleset and should then be forbidden if no
-	 * rule explicitly allow them.  This is needed for backward
-	 * compatibility reasons.
+	 * rule explicitly allow them: it is a deny-by-default list that should
+	 * contain as much Landlock access rights as possible. Indeed, all
+	 * Landlock filesystem access rights that are not part of
+	 * handled_access_fs are allowed.  This is needed for backward
+	 * compatibility reasons.  One exception is the
+	 * LANDLOCK_ACCESS_FS_REFER access right, which is always implicitly
+	 * handled, but must still be explicitly handled to add new rules with
+	 * this access right.
 	 */
 	__u64 handled_access_fs;
 };
@@ -109,6 +115,22 @@ struct landlock_path_beneath_attr {
  * - %LANDLOCK_ACCESS_FS_MAKE_FIFO: Create (or rename or link) a named pipe.
  * - %LANDLOCK_ACCESS_FS_MAKE_BLOCK: Create (or rename or link) a block device.
  * - %LANDLOCK_ACCESS_FS_MAKE_SYM: Create (or rename or link) a symbolic link.
+ * - %LANDLOCK_ACCESS_FS_REFER: Link or rename a file from or to a different
+ *   directory (i.e. reparent a file hierarchy).  This access right is
+ *   available since the second version of the Landlock ABI.  This is also the
+ *   only access right which is always considered handled by any ruleset in
+ *   such a way that reparenting a file hierarchy is always denied by default.
+ *   To avoid privilege escalation, it is not enough to add a rule with this
+ *   access right.  When linking or renaming a file, the destination directory
+ *   hierarchy must also always have the same or a superset of restrictions of
+ *   the source hierarchy.  If it is not the case, or if the domain doesn't
+ *   handle this access right, such actions are denied by default with errno
+ *   set to EXDEV.  Linking also requires a LANDLOCK_ACCESS_FS_MAKE_* access
+ *   right on the destination directory, and renaming also requires a
+ *   LANDLOCK_ACCESS_FS_REMOVE_* access right on the source's (file or
+ *   directory) parent.  Otherwise, such actions are denied with errno set to
+ *   EACCES.  The EACCES errno prevails over EXDEV to let user space
+ *   efficiently deal with an unrecoverable error.
  *
  * .. warning::
  *
@@ -133,5 +155,6 @@ struct landlock_path_beneath_attr {
 #define LANDLOCK_ACCESS_FS_MAKE_FIFO			(1ULL << 10)
 #define LANDLOCK_ACCESS_FS_MAKE_BLOCK			(1ULL << 11)
 #define LANDLOCK_ACCESS_FS_MAKE_SYM			(1ULL << 12)
+#define LANDLOCK_ACCESS_FS_REFER			(1ULL << 13)
 
 #endif /* _UAPI_LINUX_LANDLOCK_H */
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 3886f9ad1a60..c7c7ce4e7cd5 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -4,6 +4,7 @@
  *
  * Copyright © 2016-2020 Mickaël Salaün <mic@digikod.net>
  * Copyright © 2018-2020 ANSSI
+ * Copyright © 2021-2022 Microsoft Corporation
  */
 
 #include <linux/atomic.h>
@@ -269,16 +270,188 @@ static inline bool is_nouser_or_private(const struct dentry *dentry)
 			 unlikely(IS_PRIVATE(d_backing_inode(dentry))));
 }
 
-static int check_access_path(const struct landlock_ruleset *const domain,
-		const struct path *const path,
+static inline access_mask_t get_handled_accesses(
+		const struct landlock_ruleset *const domain)
+{
+	access_mask_t access_dom = 0;
+	unsigned long access_bit;
+
+	for (access_bit = 0; access_bit < LANDLOCK_NUM_ACCESS_FS;
+			access_bit++) {
+		size_t layer_level;
+
+		for (layer_level = 0; layer_level < domain->num_layers;
+				layer_level++) {
+			if (domain->fs_access_masks[layer_level] &
+					BIT_ULL(access_bit)) {
+				access_dom |= BIT_ULL(access_bit);
+				break;
+			}
+		}
+	}
+	return access_dom;
+}
+
+static inline access_mask_t init_layer_masks(
+		const struct landlock_ruleset *const domain,
+		const access_mask_t access_request,
+		layer_mask_t (*const layer_masks)[LANDLOCK_NUM_ACCESS_FS])
+{
+	access_mask_t handled_accesses = 0;
+	size_t layer_level;
+
+	memset(layer_masks, 0, sizeof(*layer_masks));
+	if (WARN_ON_ONCE(!access_request))
+		return 0;
+
+	/* Saves all handled accesses per layer. */
+	for (layer_level = 0; layer_level < domain->num_layers;
+			layer_level++) {
+		const unsigned long access_req = access_request;
+		unsigned long access_bit;
+
+		for_each_set_bit(access_bit, &access_req,
+				ARRAY_SIZE(*layer_masks)) {
+			if (domain->fs_access_masks[layer_level] &
+					BIT_ULL(access_bit)) {
+				(*layer_masks)[access_bit] |=
+					BIT_ULL(layer_level);
+				handled_accesses |= BIT_ULL(access_bit);
+			}
+		}
+	}
+	return handled_accesses;
+}
+
+/*
+ * Check that a destination file hierarchy has more restrictions than a source
+ * file hierarchy.  This is only used for link and rename actions.
+ */
+static inline bool is_superset(bool child_is_directory,
+		const layer_mask_t (*const
+			layer_masks_dst_parent)[LANDLOCK_NUM_ACCESS_FS],
+		const layer_mask_t (*const
+			layer_masks_src_parent)[LANDLOCK_NUM_ACCESS_FS],
+		const layer_mask_t (*const
+			layer_masks_child)[LANDLOCK_NUM_ACCESS_FS])
+{
+	unsigned long access_bit;
+
+	for (access_bit = 0; access_bit < ARRAY_SIZE(*layer_masks_dst_parent);
+			access_bit++) {
+		/* Ignores accesses that only make sense for directories. */
+		if (!child_is_directory && !(BIT_ULL(access_bit) & ACCESS_FILE))
+			continue;
+
+		/*
+		 * Checks if the destination restrictions are a superset of the
+		 * source ones (i.e. inherited access rights without child
+		 * exceptions).
+		 */
+		if ((((*layer_masks_src_parent)[access_bit] & (*layer_masks_child)[access_bit]) |
+					(*layer_masks_dst_parent)[access_bit]) !=
+				(*layer_masks_dst_parent)[access_bit])
+			return false;
+	}
+	return true;
+}
+
+/*
+ * Removes @layer_masks accesses that are not requested.
+ *
+ * Returns true if the request is allowed, false otherwise.
+ */
+static inline bool scope_to_request(const access_mask_t access_request,
+		layer_mask_t (*const layer_masks)[LANDLOCK_NUM_ACCESS_FS])
+{
+	const unsigned long access_req = access_request;
+	unsigned long access_bit;
+
+	if (WARN_ON_ONCE(!layer_masks))
+		return true;
+
+	for_each_clear_bit(access_bit, &access_req, ARRAY_SIZE(*layer_masks))
+		(*layer_masks)[access_bit] = 0;
+	return !memchr_inv(layer_masks, 0, sizeof(*layer_masks));
+}
+
+/*
+ * Returns true if there is at least one access right different than
+ * LANDLOCK_ACCESS_FS_REFER.
+ */
+static inline bool is_eacces(
+		const layer_mask_t (*const
+			layer_masks)[LANDLOCK_NUM_ACCESS_FS],
 		const access_mask_t access_request)
 {
-	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {};
-	bool allowed = false, has_access = false;
+	unsigned long access_bit;
+	/* LANDLOCK_ACCESS_FS_REFER alone must return -EXDEV. */
+	const unsigned long access_check = access_request &
+		~LANDLOCK_ACCESS_FS_REFER;
+
+	if (!layer_masks)
+		return false;
+
+	for_each_set_bit(access_bit, &access_check, ARRAY_SIZE(*layer_masks)) {
+		if ((*layer_masks)[access_bit])
+			return true;
+	}
+	return false;
+}
+
+/**
+ * check_access_path_dual - Check a source and a destination accesses
+ *
+ * @domain: Domain to check against.
+ * @path: File hierarchy to walk through.
+ * @child_is_directory: Must be set to true if the (original) leaf is a
+ *     directory, false otherwise.
+ * @access_request_dst_parent: Accesses to check, once @layer_masks_dst_parent
+ *     is equal to @layer_masks_src_parent (if any).
+ * @layer_masks_dst_parent: Pointer to a matrix of layer masks per access
+ *     masks, identifying the layers that forbid a specific access.  Bits from
+ *     this matrix can be unset according to the @path walk.  An empty matrix
+ *     means that @domain allows all possible Landlock accesses (i.e. not only
+ *     those identified by @access_request_dst_parent).  This matrix can
+ *     initially refer to domain layer masks and, when the accesses for the
+ *     destination and source are the same, to request layer masks.
+ * @access_request_src_parent: Similar to @access_request_dst_parent but for an
+ *     initial source path request.  Only taken into account if
+ *     @layer_masks_src_parent is not NULL.
+ * @layer_masks_src_parent: Similar to @layer_masks_dst_parent but for an
+ *     initial source path walk.  This can be NULL if only dealing with a
+ *     destination access request (i.e. not a rename nor a link action).
+ * @layer_masks_child: Similar to @layer_masks_src_parent but only for the
+ *     linked or renamed inode (without hierarchy).  This is only used if
+ *     @layer_masks_src_parent is not NULL.
+ *
+ * This helper first checks that the destination has a superset of restrictions
+ * compared to the source (if any) for a common path.  It then checks that the
+ * collected accesses and the remaining ones are enough to allow the request.
+ *
+ * Returns:
+ * - 0 if the access request is granted;
+ * - -EACCES if it is denied because of access right other than
+ *   LANDLOCK_ACCESS_FS_REFER;
+ * - -EXDEV if the renaming or linking would be a privileged escalation
+ *   (according to each layered policies), or if LANDLOCK_ACCESS_FS_REFER is
+ *   not allowed by the source or the destination.
+ */
+static int check_access_path_dual(const struct landlock_ruleset *const domain,
+		const struct path *const path,
+		bool child_is_directory,
+		const access_mask_t access_request_dst_parent,
+		layer_mask_t (*const
+			layer_masks_dst_parent)[LANDLOCK_NUM_ACCESS_FS],
+		const access_mask_t access_request_src_parent,
+		layer_mask_t (*layer_masks_src_parent)[LANDLOCK_NUM_ACCESS_FS],
+		layer_mask_t (*layer_masks_child)[LANDLOCK_NUM_ACCESS_FS])
+{
+	bool allowed_dst_parent = false, allowed_src_parent = false, is_dom_check;
 	struct path walker_path;
-	size_t i;
+	access_mask_t access_masked_dst_parent, access_masked_src_parent;
 
-	if (!access_request)
+	if (!access_request_dst_parent && !access_request_src_parent)
 		return 0;
 	if (WARN_ON_ONCE(!domain || !path))
 		return 0;
@@ -287,22 +460,20 @@ static int check_access_path(const struct landlock_ruleset *const domain,
 	if (WARN_ON_ONCE(domain->num_layers < 1))
 		return -EACCES;
 
-	/* Saves all layers handling a subset of requested accesses. */
-	for (i = 0; i < domain->num_layers; i++) {
-		const unsigned long access_req = access_request;
-		unsigned long access_bit;
-
-		for_each_set_bit(access_bit, &access_req,
-				ARRAY_SIZE(layer_masks)) {
-			if (domain->fs_access_masks[i] & BIT_ULL(access_bit)) {
-				layer_masks[access_bit] |= BIT_ULL(i);
-				has_access = true;
-			}
-		}
+	BUILD_BUG_ON(!layer_masks_dst_parent);
+	if (layer_masks_src_parent) {
+		if (WARN_ON_ONCE(!layer_masks_child))
+			return -EACCES;
+		access_masked_dst_parent = access_masked_src_parent =
+			get_handled_accesses(domain);
+		is_dom_check = true;
+	} else {
+		if (WARN_ON_ONCE(layer_masks_child))
+			return -EACCES;
+		access_masked_dst_parent = access_request_dst_parent;
+		access_masked_src_parent = access_request_src_parent;
+		is_dom_check = false;
 	}
-	/* An access request not handled by the domain is allowed. */
-	if (!has_access)
-		return 0;
 
 	walker_path = *path;
 	path_get(&walker_path);
@@ -312,11 +483,50 @@ static int check_access_path(const struct landlock_ruleset *const domain,
 	 */
 	while (true) {
 		struct dentry *parent_dentry;
+		const struct landlock_rule *rule;
+
+		/*
+		 * If at least all accesses allowed on the destination are
+		 * already allowed on the source, respectively if there is at
+		 * least as much as restrictions on the destination than on the
+		 * source, then we can safely refer files from the source to
+		 * the destination without risking a privilege escalation.
+		 * This is crucial for standalone multilayered security
+		 * policies.  Furthermore, this helps avoid policy writers to
+		 * shoot themselves in the foot.
+		 */
+		if (is_dom_check && is_superset(child_is_directory,
+					layer_masks_dst_parent,
+					layer_masks_src_parent,
+					layer_masks_child)) {
+			allowed_dst_parent =
+				scope_to_request(access_request_dst_parent,
+						layer_masks_dst_parent);
+			allowed_src_parent =
+				scope_to_request(access_request_src_parent,
+						layer_masks_src_parent);
+
+			/* Stops when all accesses are granted. */
+			if (allowed_dst_parent && allowed_src_parent)
+				break;
+
+			/*
+			 * Downgrades checks from domain handled accesses to
+			 * requested accesses.
+			 */
+			is_dom_check = false;
+			access_masked_dst_parent = access_request_dst_parent;
+			access_masked_src_parent = access_request_src_parent;
+		}
+
+		rule = find_rule(domain, walker_path.dentry);
+		allowed_dst_parent = unmask_layers(rule, access_masked_dst_parent,
+				layer_masks_dst_parent);
+		allowed_src_parent = unmask_layers(rule, access_masked_src_parent,
+				layer_masks_src_parent);
 
-		allowed = unmask_layers(find_rule(domain, walker_path.dentry),
-				access_request, &layer_masks);
-		if (allowed)
-			/* Stops when a rule from each layer grants access. */
+		/* Stops when a rule from each layer grants access. */
+		if (allowed_dst_parent && allowed_src_parent)
 			break;
 
 jump_up:
@@ -329,7 +539,7 @@ static int check_access_path(const struct landlock_ruleset *const domain,
 				 * Stops at the real root.  Denies access
 				 * because not all layers have granted access.
 				 */
-				allowed = false;
+				allowed_dst_parent = false;
 				break;
 			}
 		}
@@ -339,7 +549,8 @@ static int check_access_path(const struct landlock_ruleset *const domain,
 			 * access to internal filesystems (e.g. nsfs, which is
 			 * reachable through /proc/<pid>/ns/<namespace>).
 			 */
-			allowed = !!(walker_path.mnt->mnt_flags & MNT_INTERNAL);
+			allowed_dst_parent = !!(walker_path.mnt->mnt_flags &
+					MNT_INTERNAL);
 			break;
 		}
 		parent_dentry = dget_parent(walker_path.dentry);
@@ -347,7 +558,40 @@ static int check_access_path(const struct landlock_ruleset *const domain,
 		walker_path.dentry = parent_dentry;
 	}
 	path_put(&walker_path);
-	return allowed ? 0 : -EACCES;
+
+	if (allowed_dst_parent && allowed_src_parent)
+		return 0;
+
+	/*
+	 * Unfortunately, we cannot prioritize EACCES over EXDEV for all
+	 * RENAME_EXCHANGE cases because it depends on the source and
+	 * destination order.  This could be changed with a new
+	 * security_path_rename hook implementation.
+	 */
+	if (likely(is_eacces(layer_masks_dst_parent, access_request_dst_parent)
+				|| is_eacces(layer_masks_src_parent,
+					access_request_src_parent)))
+		return -EACCES;
+
+	/*
+	 * Gracefully forbids reparenting if the destination directory
+	 * hierarchy is not a superset of restrictions of the source directory
+	 * hierarchy, or if LANDLOCK_ACCESS_FS_REFER is not allowed by the
+	 * source or the destination.
+	 */
+	return -EXDEV;
+}
+
+static inline int check_access_path(const struct landlock_ruleset *const domain,
+		const struct path *const path,
+		access_mask_t access_request)
+{
+	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {};
+
+	access_request = init_layer_masks(domain, access_request,
+			&layer_masks);
+	return check_access_path_dual(domain, path, d_is_dir(path->dentry),
+			access_request, &layer_masks, 0, NULL, NULL);
 }
 
 static inline int current_check_access_path(const struct path *const path,
@@ -394,6 +638,217 @@ static inline access_mask_t maybe_remove(const struct dentry *const dentry)
 		LANDLOCK_ACCESS_FS_REMOVE_FILE;
 }
 
+/**
+ * collect_domain_accesses - Walk through a file path and collect accesses
+ *
+ * @domain: Domain to check against.
+ * @mnt_root: Last directory to check.
+ * @dir: Directory to start the walk from.
+ * @layer_masks_dom: Where to store the collected accesses.
+ *
+ * This helper is useful to begin a path walk from the @dir directory to a
+ * @mnt_root directory used as a mount point.  This mount point is the common
+ * ancestor between the source and the destination of a renamed and linked
+ * file.  While walking from @dir to @mnt_root, we record all the domain's
+ * allowed accesses in @layer_masks_dom.
+ *
+ * This is similar to check_access_path_dual() but much simpler because it only
+ * handles walking on the same mount point and only check one set of accesses.
+ *
+ * Returns:
+ * - true if all the domain access rights are allowed for @dir;
+ * - false if the walk reached @mnt_root.
+ */
+static bool collect_domain_accesses(
+		const struct landlock_ruleset *const domain,
+		const struct dentry *const mnt_root, struct dentry *dir,
+		layer_mask_t (*const layer_masks_dom)[LANDLOCK_NUM_ACCESS_FS])
+{
+	unsigned long access_dom;
+	bool ret = false;
+
+	BUILD_BUG_ON(!layer_masks_dom);
+	if (WARN_ON_ONCE(!domain || !mnt_root || !dir))
+		return true;
+	if (is_nouser_or_private(dir))
+		return true;
+
+	access_dom = init_layer_masks(domain, LANDLOCK_MASK_ACCESS_FS,
+			layer_masks_dom);
+
+	dget(dir);
+	while (true) {
+		struct dentry *parent_dentry;
+
+		/* Gets all layers allowing all domain accesses. */
+		if (unmask_layers(find_rule(domain, dir), access_dom,
+					layer_masks_dom)) {
+			/*
+			 * Stops when all handled accesses are allowed by at
+			 * least one rule in each layer.
+			 */
+			ret = true;
+			break;
+		}
+
+		/* We should not reach a root other than @mnt_root. */
+		if (dir == mnt_root || WARN_ON_ONCE(IS_ROOT(dir))) {
+			ret = false;
+			break;
+		}
+
+		parent_dentry = dget_parent(dir);
+		dput(dir);
+		dir = parent_dentry;
+	}
+	dput(dir);
+	return ret;
+}
+
+/**
+ * current_check_refer_path - Check if a rename or link action is allowed
+ *
+ * @old_dentry: File or directory requested to be moved or linked.
+ * @new_dir: Destination parent directory.
+ * @new_dentry: Destination file or directory.
+ * @removable: Sets to true if it is a rename operation.
+ *
+ * Because of its unprivileged constraints, Landlock relies on file hierarchies
+ * (and not only inodes) to tie access rights to files.  Being able to link or
+ * rename a file hierarchy brings some challenges.  Indeed, moving or linking a
+ * file (i.e. creating a new reference to an inode) can have an impact on the
+ * actions allowed for a set of files if it would change its parent directory
+ * (i.e. reparenting).
+ *
+ * To avoid trivial access right bypasses, Landlock first checks if the file or
+ * directory requested to be moved would gain new access rights inherited from
+ * its new hierarchy.  Before returning any error, Landlock then checks that
+ * the parent source hierarchy and the destination hierarchy would allow the
+ * link or rename action.  If it is not the case, an error with EACCES is
+ * returned to inform user space that there is no way to remove or create the
+ * requested source file type.  If it should be allowed but the new inherited
+ * access rights would be greater than the source access rights, then the
+ * kernel returns an error with EXDEV.  Prioritizing EACCES over EXDEV enables
+ * user space to abort the whole operation if there is no way to do it, or to
+ * manually copy the source to the destination if this remains allowed, e.g.
+ * because file creation is allowed on the destination directory but not direct
+ * linking.
+ *
+ * To achieve this goal, the kernel needs to compare two file hierarchies: the
+ * one identifying the source file or directory (including itself), and the
+ * destination one.  This can be seen as a multilayer partial ordering problem.
+ * The kernel walks through these paths and collect in a matrix the access
+ * rights that are denied per layer.  These matrices are then compared to see
+ * if the destination one has more (or the same) restrictions as the source
+ * one.  If this is the case, the requested action will not return EXDEV, which
+ * doesn't mean the action is allowed.  The parent hierarchy of the source
+ * (i.e. parent directory), and the destination hierarchy must also be checked
+ * to verify that they explicitly allow such action (i.e.  referencing,
+ * creation and potentially removal rights).  The kernel implementation is then
+ * required to rely on three matrices of access rights: one for the source file
+ * or directory (i.e. the child), one for the source parent hierarchy and one
+ * for the destination hierarchy.  These ephemeral matrices take some space on
+ * the stack, which limits the number of layers to a deemed reasonable number:
+ * 16.
+ *
+ * Returns:
+ * - 0 if access is allowed;
+ * - -EXDEV if @old_dentry would inherit new access rights from @new_dir;
+ * - -EACCES if file removal or creation is denied.
+ */
+static int current_check_refer_path(struct dentry *const old_dentry,
+		const struct path *const new_dir,
+		struct dentry *const new_dentry,
+		bool removable)
+{
+	const struct landlock_ruleset *const dom =
+		landlock_get_current_domain();
+	bool allow_dst_parent, allow_src_parent;
+	access_mask_t access_request_dst_parent, access_request_src_parent,
+		      access_child;
+	struct path mnt_dir;
+	layer_mask_t layer_masks_dst_parent[LANDLOCK_NUM_ACCESS_FS],
+	    layer_masks_src_parent[LANDLOCK_NUM_ACCESS_FS],
+	    layer_masks_child[LANDLOCK_NUM_ACCESS_FS];
+
+	if (!dom)
+		return 0;
+	if (WARN_ON_ONCE(dom->num_layers < 1))
+		return -EACCES;
+	if (unlikely(d_is_negative(old_dentry)))
+		return -ENOENT;
+
+	access_request_dst_parent =
+		get_mode_access(d_backing_inode(old_dentry)->i_mode);
+	access_request_src_parent = 0;
+	if (removable) {
+		access_request_dst_parent |= maybe_remove(new_dentry);
+		access_request_src_parent |= maybe_remove(old_dentry);
+	}
+
+	/* The mount points are the same for old and new paths, cf. EXDEV. */
+	if (old_dentry->d_parent == new_dir->dentry) {
+		/*
+		 * The LANDLOCK_ACCESS_FS_REFER access right is not required
+		 * for same-directory referer (i.e. no reparenting).
+		 */
+		access_request_dst_parent = init_layer_masks(dom,
+				access_request_dst_parent | access_request_src_parent,
+				&layer_masks_dst_parent);
+		return check_access_path_dual(dom, new_dir, d_is_dir(old_dentry),
+				access_request_dst_parent, &layer_masks_dst_parent,
+				0, NULL, NULL);
+	}
+
+	/* Backward compatibility: no reparenting support. */
+	if (!(get_handled_accesses(dom) & LANDLOCK_ACCESS_FS_REFER))
+		return -EXDEV;
+
+	access_request_src_parent |= LANDLOCK_ACCESS_FS_REFER;
+	access_request_dst_parent |= LANDLOCK_ACCESS_FS_REFER;
+
+	/* Saves the common mount point. */
+	mnt_dir.mnt = new_dir->mnt;
+	mnt_dir.dentry = new_dir->mnt->mnt_root;
+
+	/* new_dir->dentry is equal to new_dentry->d_parent */
+	allow_dst_parent = collect_domain_accesses(dom, mnt_dir.dentry,
+			new_dir->dentry, &layer_masks_dst_parent);
+	allow_src_parent = collect_domain_accesses(dom, mnt_dir.dentry,
+			old_dentry->d_parent, &layer_masks_src_parent);
+
+	if (allow_src_parent) {
+		/* No need to go further if everything is allowed. */
+		if (allow_dst_parent)
+			return 0;
+
+		/* @new_dentry can only gain more restrictions. */
+		if (scope_to_request(access_request_dst_parent,
+					&layer_masks_dst_parent))
+			return 0;
+
+		return check_access_path_dual(dom, &mnt_dir, d_is_dir(old_dentry),
+				access_request_dst_parent, &layer_masks_dst_parent,
+				0, NULL, NULL);
+	}
+
+	/*
+	 * To be able to compare source and destination domain access rights,
+	 * take into account the @old_dentry access rights aggregated with its
+	 * parent access rights.  This will be useful to compare with the
+	 * destination parent access rights.
+	 */
+	access_child = init_layer_masks(dom, LANDLOCK_MASK_ACCESS_FS,
+			&layer_masks_child);
+	unmask_layers(find_rule(dom, old_dentry), access_child,
+			&layer_masks_child);
+
+	return check_access_path_dual(dom, &mnt_dir, d_is_dir(old_dentry),
+			access_request_dst_parent, &layer_masks_dst_parent,
+			access_request_src_parent, &layer_masks_src_parent,
+			&layer_masks_child);
+}
+
 /* Inode hooks */
 
 static void hook_inode_free_security(struct inode *const inode)
@@ -587,31 +1042,11 @@ static int hook_sb_pivotroot(const struct path *const old_path,
 
 /* Path hooks */
 
-/*
- * Creating multiple links or renaming may lead to privilege escalations if not
- * handled properly.  Indeed, we must be sure that the source doesn't gain more
- * privileges by being accessible from the destination.  This is getting more
- * complex when dealing with multiple layers.  The whole picture can be seen as
- * a multilayer partial ordering problem.  A future version of Landlock will
- * deal with that.
- */
 static int hook_path_link(struct dentry *const old_dentry,
 		const struct path *const new_dir,
 		struct dentry *const new_dentry)
 {
-	const struct landlock_ruleset *const dom =
-		landlock_get_current_domain();
-
-	if (!dom)
-		return 0;
-	/* The mount points are the same for old and new paths, cf. EXDEV. */
-	if (old_dentry->d_parent != new_dir->dentry)
-		/* Gracefully forbids reparenting. */
-		return -EXDEV;
-	if (unlikely(d_is_negative(old_dentry)))
-		return -ENOENT;
-	return check_access_path(dom, new_dir,
-			get_mode_access(d_backing_inode(old_dentry)->i_mode));
+	return current_check_refer_path(old_dentry, new_dir, new_dentry, false);
 }
 
 static int hook_path_rename(const struct path *const old_dir,
@@ -619,21 +1054,8 @@ static int hook_path_rename(const struct path *const old_dir,
 		const struct path *const new_dir,
 		struct dentry *const new_dentry)
 {
-	const struct landlock_ruleset *const dom =
-		landlock_get_current_domain();
-
-	if (!dom)
-		return 0;
-	/* The mount points are the same for old and new paths, cf. EXDEV. */
-	if (old_dir->dentry != new_dir->dentry)
-		/* Gracefully forbids reparenting. */
-		return -EXDEV;
-	if (unlikely(d_is_negative(old_dentry)))
-		return -ENOENT;
-	/* RENAME_EXCHANGE is handled because directories are the same. */
-	return check_access_path(dom, old_dir, maybe_remove(old_dentry) |
-			maybe_remove(new_dentry) |
-			get_mode_access(d_backing_inode(old_dentry)->i_mode));
+	/* old_dir refers to old_dentry->d_parent and new_dir->mnt */
+	return current_check_refer_path(old_dentry, new_dir, new_dentry, true);
 }
 
 static int hook_path_mkdir(const struct path *const dir,
diff --git a/security/landlock/limits.h b/security/landlock/limits.h
index 126d1ec04d34..26c8166d0265 100644
--- a/security/landlock/limits.h
+++ b/security/landlock/limits.h
@@ -16,7 +16,7 @@
 #define LANDLOCK_MAX_NUM_LAYERS		16
 #define LANDLOCK_MAX_NUM_RULES		U32_MAX
 
-#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_MAKE_SYM
+#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_REFER
 #define LANDLOCK_MASK_ACCESS_FS		((LANDLOCK_LAST_ACCESS_FS << 1) - 1)
 #define LANDLOCK_NUM_ACCESS_FS		__const_hweight64(LANDLOCK_MASK_ACCESS_FS)
 
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 32396962f04d..fa14f09b6bf4 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -128,7 +128,7 @@ static const struct file_operations ruleset_fops = {
 	.write = fop_dummy_write,
 };
 
-#define LANDLOCK_ABI_VERSION	1
+#define LANDLOCK_ABI_VERSION	2
 
 /**
  * sys_landlock_create_ruleset - Create a new ruleset
diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
index ca40abe9daa8..99aab93d50e1 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -67,7 +67,7 @@ TEST(abi_version) {
 	const struct landlock_ruleset_attr ruleset_attr = {
 		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
 	};
-	ASSERT_EQ(1, landlock_create_ruleset(NULL, 0,
+	ASSERT_EQ(2, landlock_create_ruleset(NULL, 0,
 				LANDLOCK_CREATE_RULESET_VERSION));
 
 	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 1ac41bfa7382..0568d1193492 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -381,7 +381,7 @@ TEST_F_FORK(layout1, inval)
 	LANDLOCK_ACCESS_FS_WRITE_FILE | \
 	LANDLOCK_ACCESS_FS_READ_FILE)
 
-#define ACCESS_LAST LANDLOCK_ACCESS_FS_MAKE_SYM
+#define ACCESS_LAST LANDLOCK_ACCESS_FS_REFER
 
 #define ACCESS_ALL ( \
 	ACCESS_FILE | \
@@ -394,6 +394,7 @@ TEST_F_FORK(layout1, inval)
 	LANDLOCK_ACCESS_FS_MAKE_SOCK | \
 	LANDLOCK_ACCESS_FS_MAKE_FIFO | \
 	LANDLOCK_ACCESS_FS_MAKE_BLOCK | \
+	LANDLOCK_ACCESS_FS_MAKE_SYM | \
 	ACCESS_LAST)
 
 TEST_F_FORK(layout1, file_access_rights)
-- 
2.35.1

