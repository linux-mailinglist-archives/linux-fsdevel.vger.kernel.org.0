Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236FE4BEC85
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Feb 2022 22:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234809AbiBUVX2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Feb 2022 16:23:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233398AbiBUVXT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Feb 2022 16:23:19 -0500
Received: from smtp-8faf.mail.infomaniak.ch (smtp-8faf.mail.infomaniak.ch [IPv6:2001:1600:3:17::8faf])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3732ADC
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Feb 2022 13:22:51 -0800 (PST)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4K2Znq5JnGzMqJfp;
        Mon, 21 Feb 2022 22:15:11 +0100 (CET)
Received: from localhost (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4K2Znq2tlgzlhPJX;
        Mon, 21 Feb 2022 22:15:11 +0100 (CET)
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
Subject: [PATCH v1 01/11] landlock: Define access_mask_t to enforce a consistent access mask size
Date:   Mon, 21 Feb 2022 22:25:12 +0100
Message-Id: <20220221212522.320243-2-mic@digikod.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220221212522.320243-1-mic@digikod.net>
References: <20220221212522.320243-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mickaël Salaün <mic@linux.microsoft.com>

Create and use the access_mask_t typedef to enforce a consistent access
mask size and uniformly use a 16-bits type.  This will helps transition
to a 32-bits value one day.

Add a build check to make sure all (filesystem) access rights fit in.
This will be extended with a following commit.

Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
Link: https://lore.kernel.org/r/20220221212522.320243-2-mic@digikod.net
---
 security/landlock/fs.c      | 19 ++++++++++---------
 security/landlock/fs.h      |  2 +-
 security/landlock/limits.h  |  2 ++
 security/landlock/ruleset.c |  6 ++++--
 security/landlock/ruleset.h | 17 +++++++++++++----
 5 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 97b8e421f617..9de2a460a762 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -150,7 +150,7 @@ static struct landlock_object *get_inode_object(struct inode *const inode)
  * @path: Should have been checked by get_path_from_fd().
  */
 int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
-		const struct path *const path, u32 access_rights)
+		const struct path *const path, access_mask_t access_rights)
 {
 	int err;
 	struct landlock_object *object;
@@ -182,8 +182,8 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
 
 static inline u64 unmask_layers(
 		const struct landlock_ruleset *const domain,
-		const struct path *const path, const u32 access_request,
-		u64 layer_mask)
+		const struct path *const path,
+		const access_mask_t access_request, u64 layer_mask)
 {
 	const struct landlock_rule *rule;
 	const struct inode *inode;
@@ -223,7 +223,8 @@ static inline u64 unmask_layers(
 }
 
 static int check_access_path(const struct landlock_ruleset *const domain,
-		const struct path *const path, u32 access_request)
+		const struct path *const path,
+		const access_mask_t access_request)
 {
 	bool allowed = false;
 	struct path walker_path;
@@ -308,7 +309,7 @@ static int check_access_path(const struct landlock_ruleset *const domain,
 }
 
 static inline int current_check_access_path(const struct path *const path,
-		const u32 access_request)
+		const access_mask_t access_request)
 {
 	const struct landlock_ruleset *const dom =
 		landlock_get_current_domain();
@@ -511,7 +512,7 @@ static int hook_sb_pivotroot(const struct path *const old_path,
 
 /* Path hooks */
 
-static inline u32 get_mode_access(const umode_t mode)
+static inline access_mask_t get_mode_access(const umode_t mode)
 {
 	switch (mode & S_IFMT) {
 	case S_IFLNK:
@@ -563,7 +564,7 @@ static int hook_path_link(struct dentry *const old_dentry,
 			get_mode_access(d_backing_inode(old_dentry)->i_mode));
 }
 
-static inline u32 maybe_remove(const struct dentry *const dentry)
+static inline access_mask_t maybe_remove(const struct dentry *const dentry)
 {
 	if (d_is_negative(dentry))
 		return 0;
@@ -631,9 +632,9 @@ static int hook_path_rmdir(const struct path *const dir,
 
 /* File hooks */
 
-static inline u32 get_file_access(const struct file *const file)
+static inline access_mask_t get_file_access(const struct file *const file)
 {
-	u32 access = 0;
+	access_mask_t access = 0;
 
 	if (file->f_mode & FMODE_READ) {
 		/* A directory can only be opened in read mode. */
diff --git a/security/landlock/fs.h b/security/landlock/fs.h
index 187284b421c9..74be312aad96 100644
--- a/security/landlock/fs.h
+++ b/security/landlock/fs.h
@@ -65,6 +65,6 @@ static inline struct landlock_superblock_security *landlock_superblock(
 __init void landlock_add_fs_hooks(void);
 
 int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
-		const struct path *const path, u32 access_hierarchy);
+		const struct path *const path, access_mask_t access_hierarchy);
 
 #endif /* _SECURITY_LANDLOCK_FS_H */
diff --git a/security/landlock/limits.h b/security/landlock/limits.h
index 2a0a1095ee27..458d1de32ed5 100644
--- a/security/landlock/limits.h
+++ b/security/landlock/limits.h
@@ -9,6 +9,7 @@
 #ifndef _SECURITY_LANDLOCK_LIMITS_H
 #define _SECURITY_LANDLOCK_LIMITS_H
 
+#include <linux/bitops.h>
 #include <linux/limits.h>
 #include <uapi/linux/landlock.h>
 
@@ -17,5 +18,6 @@
 
 #define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_MAKE_SYM
 #define LANDLOCK_MASK_ACCESS_FS		((LANDLOCK_LAST_ACCESS_FS << 1) - 1)
+#define LANDLOCK_NUM_ACCESS_FS		__const_hweight64(LANDLOCK_MASK_ACCESS_FS)
 
 #endif /* _SECURITY_LANDLOCK_LIMITS_H */
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index ec72b9262bf3..4e7aa8024fff 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -44,7 +44,8 @@ static struct landlock_ruleset *create_ruleset(const u32 num_layers)
 	return new_ruleset;
 }
 
-struct landlock_ruleset *landlock_create_ruleset(const u32 fs_access_mask)
+struct landlock_ruleset *landlock_create_ruleset(
+		const access_mask_t fs_access_mask)
 {
 	struct landlock_ruleset *new_ruleset;
 
@@ -228,7 +229,8 @@ static void build_check_layer(void)
 
 /* @ruleset must be locked by the caller. */
 int landlock_insert_rule(struct landlock_ruleset *const ruleset,
-		struct landlock_object *const object, const u32 access)
+		struct landlock_object *const object,
+		const access_mask_t access)
 {
 	struct landlock_layer layers[] = {{
 		.access = access,
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index 2d3ed7ec5a0a..7e7cac68e443 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -9,13 +9,20 @@
 #ifndef _SECURITY_LANDLOCK_RULESET_H
 #define _SECURITY_LANDLOCK_RULESET_H
 
+#include <linux/bitops.h>
+#include <linux/build_bug.h>
 #include <linux/mutex.h>
 #include <linux/rbtree.h>
 #include <linux/refcount.h>
 #include <linux/workqueue.h>
 
+#include "limits.h"
 #include "object.h"
 
+typedef u16 access_mask_t;
+/* Makes sure all filesystem access rights can be stored. */
+static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_ACCESS_FS);
+
 /**
  * struct landlock_layer - Access rights for a given layer
  */
@@ -28,7 +35,7 @@ struct landlock_layer {
 	 * @access: Bitfield of allowed actions on the kernel object.  They are
 	 * relative to the object type (e.g. %LANDLOCK_ACTION_FS_READ).
 	 */
-	u16 access;
+	access_mask_t access;
 };
 
 /**
@@ -135,18 +142,20 @@ struct landlock_ruleset {
 			 * layers are set once and never changed for the
 			 * lifetime of the ruleset.
 			 */
-			u16 fs_access_masks[];
+			access_mask_t fs_access_masks[];
 		};
 	};
 };
 
-struct landlock_ruleset *landlock_create_ruleset(const u32 fs_access_mask);
+struct landlock_ruleset *landlock_create_ruleset(
+		const access_mask_t fs_access_mask);
 
 void landlock_put_ruleset(struct landlock_ruleset *const ruleset);
 void landlock_put_ruleset_deferred(struct landlock_ruleset *const ruleset);
 
 int landlock_insert_rule(struct landlock_ruleset *const ruleset,
-		struct landlock_object *const object, const u32 access);
+		struct landlock_object *const object,
+		const access_mask_t access);
 
 struct landlock_ruleset *landlock_merge_ruleset(
 		struct landlock_ruleset *const parent,
-- 
2.35.1

