Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5868E4BEC79
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Feb 2022 22:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234799AbiBUVXV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Feb 2022 16:23:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234781AbiBUVXS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Feb 2022 16:23:18 -0500
X-Greylist: delayed 460 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 21 Feb 2022 13:22:52 PST
Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch [IPv6:2001:1600:3:17::8fab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B253F272B
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Feb 2022 13:22:51 -0800 (PST)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4K2Znt0nkfzMqK3X;
        Mon, 21 Feb 2022 22:15:14 +0100 (CET)
Received: from localhost (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4K2Zns65J9zljTgK;
        Mon, 21 Feb 2022 22:15:13 +0100 (CET)
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
Subject: [PATCH v1 05/11] landlock: Move filesystem helpers and add a new one
Date:   Mon, 21 Feb 2022 22:25:16 +0100
Message-Id: <20220221212522.320243-6-mic@digikod.net>
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

Move the SB_NOUSER and IS_PRIVATE dentry check to a standalone
is_nouser_or_private() helper.  This will be useful for a following
commit.

Move get_mode_access() and maybe_remove() to make them usable by new
code provided by a following commit.

Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
Link: https://lore.kernel.org/r/20220221212522.320243-6-mic@digikod.net
---
 security/landlock/fs.c | 87 ++++++++++++++++++++++--------------------
 1 file changed, 46 insertions(+), 41 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 9662f9fb3cd0..3886f9ad1a60 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -257,6 +257,18 @@ static inline bool unmask_layers(const struct landlock_rule *const rule,
 	return false;
 }
 
+static inline bool is_nouser_or_private(const struct dentry *dentry)
+{
+	/*
+	 * Allows access to pseudo filesystems that will never be mountable
+	 * (e.g. sockfs, pipefs), but can still be reachable through
+	 * /proc/<pid>/fd/<file-descriptor> .
+	 */
+	return (dentry->d_sb->s_flags & SB_NOUSER) ||
+			(d_is_positive(dentry) &&
+			 unlikely(IS_PRIVATE(d_backing_inode(dentry))));
+}
+
 static int check_access_path(const struct landlock_ruleset *const domain,
 		const struct path *const path,
 		const access_mask_t access_request)
@@ -270,14 +282,7 @@ static int check_access_path(const struct landlock_ruleset *const domain,
 		return 0;
 	if (WARN_ON_ONCE(!domain || !path))
 		return 0;
-	/*
-	 * Allows access to pseudo filesystems that will never be mountable
-	 * (e.g. sockfs, pipefs), but can still be reachable through
-	 * /proc/<pid>/fd/<file-descriptor> .
-	 */
-	if ((path->dentry->d_sb->s_flags & SB_NOUSER) ||
-			(d_is_positive(path->dentry) &&
-			 unlikely(IS_PRIVATE(d_backing_inode(path->dentry)))))
+	if (is_nouser_or_private(path->dentry))
 		return 0;
 	if (WARN_ON_ONCE(domain->num_layers < 1))
 		return -EACCES;
@@ -356,6 +361,39 @@ static inline int current_check_access_path(const struct path *const path,
 	return check_access_path(dom, path, access_request);
 }
 
+static inline access_mask_t get_mode_access(const umode_t mode)
+{
+	switch (mode & S_IFMT) {
+	case S_IFLNK:
+		return LANDLOCK_ACCESS_FS_MAKE_SYM;
+	case 0:
+		/* A zero mode translates to S_IFREG. */
+	case S_IFREG:
+		return LANDLOCK_ACCESS_FS_MAKE_REG;
+	case S_IFDIR:
+		return LANDLOCK_ACCESS_FS_MAKE_DIR;
+	case S_IFCHR:
+		return LANDLOCK_ACCESS_FS_MAKE_CHAR;
+	case S_IFBLK:
+		return LANDLOCK_ACCESS_FS_MAKE_BLOCK;
+	case S_IFIFO:
+		return LANDLOCK_ACCESS_FS_MAKE_FIFO;
+	case S_IFSOCK:
+		return LANDLOCK_ACCESS_FS_MAKE_SOCK;
+	default:
+		WARN_ON_ONCE(1);
+		return 0;
+	}
+}
+
+static inline access_mask_t maybe_remove(const struct dentry *const dentry)
+{
+	if (d_is_negative(dentry))
+		return 0;
+	return d_is_dir(dentry) ? LANDLOCK_ACCESS_FS_REMOVE_DIR :
+		LANDLOCK_ACCESS_FS_REMOVE_FILE;
+}
+
 /* Inode hooks */
 
 static void hook_inode_free_security(struct inode *const inode)
@@ -549,31 +587,6 @@ static int hook_sb_pivotroot(const struct path *const old_path,
 
 /* Path hooks */
 
-static inline access_mask_t get_mode_access(const umode_t mode)
-{
-	switch (mode & S_IFMT) {
-	case S_IFLNK:
-		return LANDLOCK_ACCESS_FS_MAKE_SYM;
-	case 0:
-		/* A zero mode translates to S_IFREG. */
-	case S_IFREG:
-		return LANDLOCK_ACCESS_FS_MAKE_REG;
-	case S_IFDIR:
-		return LANDLOCK_ACCESS_FS_MAKE_DIR;
-	case S_IFCHR:
-		return LANDLOCK_ACCESS_FS_MAKE_CHAR;
-	case S_IFBLK:
-		return LANDLOCK_ACCESS_FS_MAKE_BLOCK;
-	case S_IFIFO:
-		return LANDLOCK_ACCESS_FS_MAKE_FIFO;
-	case S_IFSOCK:
-		return LANDLOCK_ACCESS_FS_MAKE_SOCK;
-	default:
-		WARN_ON_ONCE(1);
-		return 0;
-	}
-}
-
 /*
  * Creating multiple links or renaming may lead to privilege escalations if not
  * handled properly.  Indeed, we must be sure that the source doesn't gain more
@@ -601,14 +614,6 @@ static int hook_path_link(struct dentry *const old_dentry,
 			get_mode_access(d_backing_inode(old_dentry)->i_mode));
 }
 
-static inline access_mask_t maybe_remove(const struct dentry *const dentry)
-{
-	if (d_is_negative(dentry))
-		return 0;
-	return d_is_dir(dentry) ? LANDLOCK_ACCESS_FS_REMOVE_DIR :
-		LANDLOCK_ACCESS_FS_REMOVE_FILE;
-}
-
 static int hook_path_rename(const struct path *const old_dir,
 		struct dentry *const old_dentry,
 		const struct path *const new_dir,
-- 
2.35.1

