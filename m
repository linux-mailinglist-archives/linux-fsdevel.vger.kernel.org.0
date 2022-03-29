Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA98B4EADB9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 14:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236857AbiC2MxO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 08:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237150AbiC2Mw7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 08:52:59 -0400
Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [IPv6:2001:1600:4:17::190a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48D3E0AB
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 05:51:00 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KSTvQ73NDzMq176;
        Tue, 29 Mar 2022 14:50:58 +0200 (CEST)
Received: from localhost (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4KSTvQ4FQnzlhMCC;
        Tue, 29 Mar 2022 14:50:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1648558258;
        bh=V0QiE06mm1XiML32F73M5RFbgacxnLfvqx49xLlyRWs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zQ2QS3Rw86KnXSGeZJiq3E+ECvNzLyShIQA+Dxhx/8ckKJtg8j1CHD5IpNJ8Tny1D
         05QDPxTz0//QwWO4nEA9ZuXOdzyF+pPE3ERFqvPAk9le2Giw8eAPzbDsLv1Y8OFY7/
         QhAxi28qupbY5W3snsFmc2dQRI3ezLlSMLImma4U=
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jann Horn <jannh@google.com>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Paul Moore <paul@paul-moore.com>,
        Shuah Khan <shuah@kernel.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>
Subject: [PATCH v2 01/12] landlock: Define access_mask_t to enforce a consistent access mask size
Date:   Tue, 29 Mar 2022 14:51:06 +0200
Message-Id: <20220329125117.1393824-2-mic@digikod.net>
In-Reply-To: <20220329125117.1393824-1-mic@digikod.net>
References: <20220329125117.1393824-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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

Reviewed-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
Link: https://lore.kernel.org/r/20220329125117.1393824-2-mic@digikod.net
---

Changes since v1:
* Add Reviewed-by: Paul Moore.
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

