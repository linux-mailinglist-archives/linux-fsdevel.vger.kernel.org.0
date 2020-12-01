Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF912CAC1C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Dec 2020 20:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404358AbgLATZE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 14:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731286AbgLATZD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 14:25:03 -0500
Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch [IPv6:2001:1600:4:17::42ae])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78A0C061A4E;
        Tue,  1 Dec 2020 11:23:38 -0800 (PST)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ClsTN6FJ6zlhjDS;
        Tue,  1 Dec 2020 20:23:36 +0100 (CET)
Received: from localhost (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4ClsTM4GjVzlh8TJ;
        Tue,  1 Dec 2020 20:23:35 +0100 (CET)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>
Subject: [PATCH v25 06/12] fs,security: Add sb_delete hook
Date:   Tue,  1 Dec 2020 20:23:16 +0100
Message-Id: <20201201192322.213239-7-mic@digikod.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201201192322.213239-1-mic@digikod.net>
References: <20201201192322.213239-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mickaël Salaün <mic@linux.microsoft.com>

The sb_delete security hook is called when shutting down a superblock,
which may be useful to release kernel objects tied to the superblock's
lifetime (e.g. inodes).

This new hook is needed by Landlock to release (ephemerally) tagged
struct inodes.  This comes from the unprivileged nature of Landlock
described in the next commit.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: James Morris <jmorris@namei.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Serge E. Hallyn <serge@hallyn.com>
Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
Reviewed-by: Jann Horn <jannh@google.com>
---

Changes since v22:
* Add Reviewed-by: Jann Horn <jannh@google.com>

Changes since v17:
* Initial patch to replace the direct call to landlock_release_inodes()
  (requested by James Morris).
  https://lore.kernel.org/lkml/alpine.LRH.2.21.2005150536440.7929@namei.org/
---
 fs/super.c                    | 1 +
 include/linux/lsm_hook_defs.h | 1 +
 include/linux/lsm_hooks.h     | 2 ++
 include/linux/security.h      | 4 ++++
 security/security.c           | 5 +++++
 5 files changed, 13 insertions(+)

diff --git a/fs/super.c b/fs/super.c
index 98bb0629ee10..751cad8c081f 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -454,6 +454,7 @@ void generic_shutdown_super(struct super_block *sb)
 		evict_inodes(sb);
 		/* only nonzero refcount inodes can have marks */
 		fsnotify_sb_delete(sb);
+		security_sb_delete(sb);
 
 		if (sb->s_dio_done_wq) {
 			destroy_workqueue(sb->s_dio_done_wq);
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 32a940117e7a..1ba9b4dfecb3 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -59,6 +59,7 @@ LSM_HOOK(int, 0, fs_context_dup, struct fs_context *fc,
 LSM_HOOK(int, -ENOPARAM, fs_context_parse_param, struct fs_context *fc,
 	 struct fs_parameter *param)
 LSM_HOOK(int, 0, sb_alloc_security, struct super_block *sb)
+LSM_HOOK(void, LSM_RET_VOID, sb_delete, struct super_block *sb)
 LSM_HOOK(void, LSM_RET_VOID, sb_free_security, struct super_block *sb)
 LSM_HOOK(void, LSM_RET_VOID, sb_free_mnt_opts, void *mnt_opts)
 LSM_HOOK(int, 0, sb_eat_lsm_opts, char *orig, void **mnt_opts)
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index ff0f03a45c56..dbfcec05a176 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -108,6 +108,8 @@
  *	allocated.
  *	@sb contains the super_block structure to be modified.
  *	Return 0 if operation was successful.
+ * @sb_delete:
+ *	Release objects tied to a superblock (e.g. inodes).
  * @sb_free_security:
  *	Deallocate and clear the sb->s_security field.
  *	@sb contains the super_block structure to be modified.
diff --git a/include/linux/security.h b/include/linux/security.h
index bc2725491560..a4603b62d444 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -287,6 +287,7 @@ void security_bprm_committed_creds(struct linux_binprm *bprm);
 int security_fs_context_dup(struct fs_context *fc, struct fs_context *src_fc);
 int security_fs_context_parse_param(struct fs_context *fc, struct fs_parameter *param);
 int security_sb_alloc(struct super_block *sb);
+void security_sb_delete(struct super_block *sb);
 void security_sb_free(struct super_block *sb);
 void security_free_mnt_opts(void **mnt_opts);
 int security_sb_eat_lsm_opts(char *options, void **mnt_opts);
@@ -619,6 +620,9 @@ static inline int security_sb_alloc(struct super_block *sb)
 	return 0;
 }
 
+static inline void security_sb_delete(struct super_block *sb)
+{ }
+
 static inline void security_sb_free(struct super_block *sb)
 { }
 
diff --git a/security/security.c b/security/security.c
index 4ffd6c3af9d7..4563e7a79216 100644
--- a/security/security.c
+++ b/security/security.c
@@ -899,6 +899,11 @@ int security_sb_alloc(struct super_block *sb)
 	return rc;
 }
 
+void security_sb_delete(struct super_block *sb)
+{
+	call_void_hook(sb_delete, sb);
+}
+
 void security_sb_free(struct super_block *sb)
 {
 	call_void_hook(sb_free_security, sb);
-- 
2.29.2

