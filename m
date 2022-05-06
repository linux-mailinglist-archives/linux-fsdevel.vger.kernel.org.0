Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C04F51DD41
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 May 2022 18:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443530AbiEFQPD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 May 2022 12:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443531AbiEFQNa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 May 2022 12:13:30 -0400
Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch [IPv6:2001:1600:4:17::42ae])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE9D12ACE
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 May 2022 09:09:43 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KvwW94tCNzMprrw;
        Fri,  6 May 2022 18:09:41 +0200 (CEST)
Received: from localhost (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4KvwW92rDwzlhSM0;
        Fri,  6 May 2022 18:09:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1651853381;
        bh=cmILz4WmKumtNbX1pB4Es0uoK/Hp1d7jlUzEE1O4U1k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=epbVYSobZJouR2NgBHN1XJmNMj/OslJrof2xy4sV4WzBDF1jrkjdhPQ/FxjFtYI1q
         YaLfWBeszs3aO/RfLl7SjLFcfB01mogK9T553hG/gNcp5rgy+a6BlY1DkIe4mESOl4
         LDi0XIUZY82ilIv9Rb/iivKHdvsYcCSCLXvk3KuY=
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
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH v3 05/12] landlock: Move filesystem helpers and add a new one
Date:   Fri,  6 May 2022 18:10:55 +0200
Message-Id: <20220506161102.525323-6-mic@digikod.net>
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

Move the SB_NOUSER and IS_PRIVATE dentry check to a standalone
is_nouser_or_private() helper.  This will be useful for a following
commit.

Move get_mode_access() and maybe_remove() to make them usable by new
code provided by a following commit.

Reviewed-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20220506161102.525323-6-mic@digikod.net
---

Changes since v2:
* Format with clang-format and rebase.

Changes since v1:
* Move is_nouser_or_private() explanation up to a function header
  comment block as suggested by Paul Moore.
* Add Reviewed-by: Paul Moore.
---
 security/landlock/fs.c | 87 ++++++++++++++++++++++--------------------
 1 file changed, 46 insertions(+), 41 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index c5749301b37d..7b7860039a08 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -261,6 +261,18 @@ unmask_layers(const struct landlock_rule *const rule,
 	return false;
 }
 
+/*
+ * Allows access to pseudo filesystems that will never be mountable (e.g.
+ * sockfs, pipefs), but can still be reachable through
+ * /proc/<pid>/fd/<file-descriptor>
+ */
+static inline bool is_nouser_or_private(const struct dentry *dentry)
+{
+	return (dentry->d_sb->s_flags & SB_NOUSER) ||
+	       (d_is_positive(dentry) &&
+		unlikely(IS_PRIVATE(d_backing_inode(dentry))));
+}
+
 static int check_access_path(const struct landlock_ruleset *const domain,
 			     const struct path *const path,
 			     const access_mask_t access_request)
@@ -274,14 +286,7 @@ static int check_access_path(const struct landlock_ruleset *const domain,
 		return 0;
 	if (WARN_ON_ONCE(!domain || !path))
 		return 0;
-	/*
-	 * Allows access to pseudo filesystems that will never be mountable
-	 * (e.g. sockfs, pipefs), but can still be reachable through
-	 * /proc/<pid>/fd/<file-descriptor> .
-	 */
-	if ((path->dentry->d_sb->s_flags & SB_NOUSER) ||
-	    (d_is_positive(path->dentry) &&
-	     unlikely(IS_PRIVATE(d_backing_inode(path->dentry)))))
+	if (is_nouser_or_private(path->dentry))
 		return 0;
 	if (WARN_ON_ONCE(domain->num_layers < 1))
 		return -EACCES;
@@ -360,6 +365,39 @@ static inline int current_check_access_path(const struct path *const path,
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
+				  LANDLOCK_ACCESS_FS_REMOVE_FILE;
+}
+
 /* Inode hooks */
 
 static void hook_inode_free_security(struct inode *const inode)
@@ -553,31 +591,6 @@ static int hook_sb_pivotroot(const struct path *const old_path,
 
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
@@ -606,14 +619,6 @@ static int hook_path_link(struct dentry *const old_dentry,
 		get_mode_access(d_backing_inode(old_dentry)->i_mode));
 }
 
-static inline access_mask_t maybe_remove(const struct dentry *const dentry)
-{
-	if (d_is_negative(dentry))
-		return 0;
-	return d_is_dir(dentry) ? LANDLOCK_ACCESS_FS_REMOVE_DIR :
-				  LANDLOCK_ACCESS_FS_REMOVE_FILE;
-}
-
 static int hook_path_rename(const struct path *const old_dir,
 			    struct dentry *const old_dentry,
 			    const struct path *const new_dir,
-- 
2.35.1

