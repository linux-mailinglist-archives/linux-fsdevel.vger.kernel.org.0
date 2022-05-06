Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546FB51DD3F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 May 2022 18:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443585AbiEFQPC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 May 2022 12:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443662AbiEFQNb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 May 2022 12:13:31 -0400
Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch [IPv6:2001:1600:4:17::42ae])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8886D6E8E9
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 May 2022 09:09:44 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KvwWB71K8zMqT97;
        Fri,  6 May 2022 18:09:42 +0200 (CEST)
Received: from localhost (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4KvwWB0WxwzlhMCD;
        Fri,  6 May 2022 18:09:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1651853382;
        bh=b5lWOGyqbT8zcn7hnQNEb4CQX/FmgRw1H4bzPQKGJyU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CbyDGM7AXAkJCl97UG6ucyopswscsHddqEjcb+yitepZtIUTujo5MzJx4jzsuoVj/
         VHpSs/3/Bi8Dv9OF5O/FcHUGUJTT26bpnYStpE2AFC9pXwD0zqAPwqvwXba0fnuy0B
         MBvlLOSByZn3iLMnBKho7sAewRH4PHPac7RMbQ9E=
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
        Kentaro Takeda <takedakn@nttdata.co.jp>
Subject: [PATCH v3 06/12] LSM: Remove double path_rename hook calls for RENAME_EXCHANGE
Date:   Fri,  6 May 2022 18:10:56 +0200
Message-Id: <20220506161102.525323-7-mic@digikod.net>
In-Reply-To: <20220506161102.525323-1-mic@digikod.net>
References: <20220506161102.525323-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In order to be able to identify a file exchange with renameat2(2) and
RENAME_EXCHANGE, which will be useful for Landlock [1], propagate the
rename flags to LSMs.  This may also improve performance because of the
switch from two set of LSM hook calls to only one, and because LSMs
using this hook may optimize the double check (e.g. only one lock,
reduce the number of path walks).

AppArmor, Landlock and Tomoyo are updated to leverage this change.  This
should not change the current behavior (same check order), except
(different level of) speed boosts.

[1] https://lore.kernel.org/r/20220221212522.320243-1-mic@digikod.net

Cc: James Morris <jmorris@namei.org>
Cc: Kentaro Takeda <takedakn@nttdata.co.jp>
Cc: Serge E. Hallyn <serge@hallyn.com>
Acked-by: John Johansen <john.johansen@canonical.com>
Acked-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reviewed-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20220506161102.525323-7-mic@digikod.net
---

Changes since v2:
* Add Reviewed-by: Paul Moore.
* Format security/landlock/fs.c with clang-format.

Changes since v1:
* Import patch from
  https://lore.kernel.org/r/20220222175332.384545-1-mic@digikod.net
* Add Acked-by: Tetsuo Handa.
* Add Acked-by: John Johansen.
---
 include/linux/lsm_hook_defs.h |  2 +-
 include/linux/lsm_hooks.h     |  1 +
 security/apparmor/lsm.c       | 30 +++++++++++++++++++++++++-----
 security/landlock/fs.c        | 11 ++++++++++-
 security/security.c           |  9 +--------
 security/tomoyo/tomoyo.c      | 11 ++++++++++-
 6 files changed, 48 insertions(+), 16 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index db924fe379c9..eafa1d2489fd 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -100,7 +100,7 @@ LSM_HOOK(int, 0, path_link, struct dentry *old_dentry,
 	 const struct path *new_dir, struct dentry *new_dentry)
 LSM_HOOK(int, 0, path_rename, const struct path *old_dir,
 	 struct dentry *old_dentry, const struct path *new_dir,
-	 struct dentry *new_dentry)
+	 struct dentry *new_dentry, unsigned int flags)
 LSM_HOOK(int, 0, path_chmod, const struct path *path, umode_t mode)
 LSM_HOOK(int, 0, path_chown, const struct path *path, kuid_t uid, kgid_t gid)
 LSM_HOOK(int, 0, path_chroot, const struct path *path)
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 419b5febc3ca..9acf5e368d73 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -358,6 +358,7 @@
  *	@old_dentry contains the dentry structure of the old link.
  *	@new_dir contains the path structure for parent of the new link.
  *	@new_dentry contains the dentry structure of the new link.
+ *	@flags may contain rename options such as RENAME_EXCHANGE.
  *	Return 0 if permission is granted.
  * @path_chmod:
  *	Check for permission to change a mode of the file @path. The new
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 4f0eecb67dde..900bc540656a 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -354,13 +354,16 @@ static int apparmor_path_link(struct dentry *old_dentry, const struct path *new_
 }
 
 static int apparmor_path_rename(const struct path *old_dir, struct dentry *old_dentry,
-				const struct path *new_dir, struct dentry *new_dentry)
+				const struct path *new_dir, struct dentry *new_dentry,
+				const unsigned int flags)
 {
 	struct aa_label *label;
 	int error = 0;
 
 	if (!path_mediated_fs(old_dentry))
 		return 0;
+	if ((flags & RENAME_EXCHANGE) && !path_mediated_fs(new_dentry))
+		return 0;
 
 	label = begin_current_label_crit_section();
 	if (!unconfined(label)) {
@@ -374,10 +377,27 @@ static int apparmor_path_rename(const struct path *old_dir, struct dentry *old_d
 			d_backing_inode(old_dentry)->i_mode
 		};
 
-		error = aa_path_perm(OP_RENAME_SRC, label, &old_path, 0,
-				     MAY_READ | AA_MAY_GETATTR | MAY_WRITE |
-				     AA_MAY_SETATTR | AA_MAY_DELETE,
-				     &cond);
+		if (flags & RENAME_EXCHANGE) {
+			struct path_cond cond_exchange = {
+				i_uid_into_mnt(mnt_userns, d_backing_inode(new_dentry)),
+				d_backing_inode(new_dentry)->i_mode
+			};
+
+			error = aa_path_perm(OP_RENAME_SRC, label, &new_path, 0,
+					     MAY_READ | AA_MAY_GETATTR | MAY_WRITE |
+					     AA_MAY_SETATTR | AA_MAY_DELETE,
+					     &cond_exchange);
+			if (!error)
+				error = aa_path_perm(OP_RENAME_DEST, label, &old_path,
+						     0, MAY_WRITE | AA_MAY_SETATTR |
+						     AA_MAY_CREATE, &cond_exchange);
+		}
+
+		if (!error)
+			error = aa_path_perm(OP_RENAME_SRC, label, &old_path, 0,
+					     MAY_READ | AA_MAY_GETATTR | MAY_WRITE |
+					     AA_MAY_SETATTR | AA_MAY_DELETE,
+					     &cond);
 		if (!error)
 			error = aa_path_perm(OP_RENAME_DEST, label, &new_path,
 					     0, MAY_WRITE | AA_MAY_SETATTR |
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 7b7860039a08..30b42cdee52e 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -622,10 +622,12 @@ static int hook_path_link(struct dentry *const old_dentry,
 static int hook_path_rename(const struct path *const old_dir,
 			    struct dentry *const old_dentry,
 			    const struct path *const new_dir,
-			    struct dentry *const new_dentry)
+			    struct dentry *const new_dentry,
+			    const unsigned int flags)
 {
 	const struct landlock_ruleset *const dom =
 		landlock_get_current_domain();
+	u32 exchange_access = 0;
 
 	if (!dom)
 		return 0;
@@ -633,12 +635,19 @@ static int hook_path_rename(const struct path *const old_dir,
 	if (old_dir->dentry != new_dir->dentry)
 		/* Gracefully forbids reparenting. */
 		return -EXDEV;
+	if (flags & RENAME_EXCHANGE) {
+		if (unlikely(d_is_negative(new_dentry)))
+			return -ENOENT;
+		exchange_access =
+			get_mode_access(d_backing_inode(new_dentry)->i_mode);
+	}
 	if (unlikely(d_is_negative(old_dentry)))
 		return -ENOENT;
 	/* RENAME_EXCHANGE is handled because directories are the same. */
 	return check_access_path(
 		dom, old_dir,
 		maybe_remove(old_dentry) | maybe_remove(new_dentry) |
+			exchange_access |
 			get_mode_access(d_backing_inode(old_dentry)->i_mode));
 }
 
diff --git a/security/security.c b/security/security.c
index b7cf5cbfdc67..c9bfc0b70b28 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1197,15 +1197,8 @@ int security_path_rename(const struct path *old_dir, struct dentry *old_dentry,
 		     (d_is_positive(new_dentry) && IS_PRIVATE(d_backing_inode(new_dentry)))))
 		return 0;
 
-	if (flags & RENAME_EXCHANGE) {
-		int err = call_int_hook(path_rename, 0, new_dir, new_dentry,
-					old_dir, old_dentry);
-		if (err)
-			return err;
-	}
-
 	return call_int_hook(path_rename, 0, old_dir, old_dentry, new_dir,
-				new_dentry);
+				new_dentry, flags);
 }
 EXPORT_SYMBOL(security_path_rename);
 
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index b6a31901f289..71e82d855ebf 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -264,17 +264,26 @@ static int tomoyo_path_link(struct dentry *old_dentry, const struct path *new_di
  * @old_dentry: Pointer to "struct dentry".
  * @new_parent: Pointer to "struct path".
  * @new_dentry: Pointer to "struct dentry".
+ * @flags: Rename options.
  *
  * Returns 0 on success, negative value otherwise.
  */
 static int tomoyo_path_rename(const struct path *old_parent,
 			      struct dentry *old_dentry,
 			      const struct path *new_parent,
-			      struct dentry *new_dentry)
+			      struct dentry *new_dentry,
+			      const unsigned int flags)
 {
 	struct path path1 = { .mnt = old_parent->mnt, .dentry = old_dentry };
 	struct path path2 = { .mnt = new_parent->mnt, .dentry = new_dentry };
 
+	if (flags & RENAME_EXCHANGE) {
+		const int err = tomoyo_path2_perm(TOMOYO_TYPE_RENAME, &path2,
+				&path1);
+
+		if (err)
+			return err;
+	}
 	return tomoyo_path2_perm(TOMOYO_TYPE_RENAME, &path1, &path2);
 }
 
-- 
2.35.1

