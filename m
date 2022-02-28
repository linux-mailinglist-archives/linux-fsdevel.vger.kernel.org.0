Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB0F4C7C90
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Feb 2022 22:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbiB1WA3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 17:00:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbiB1WA1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 17:00:27 -0500
Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch [IPv6:2001:1600:3:17::42a9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24382B25B;
        Mon, 28 Feb 2022 13:59:46 -0800 (PST)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4K6vS06NrPzMprMT;
        Mon, 28 Feb 2022 22:59:44 +0100 (CET)
Received: from localhost (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4K6vRy3MsRzlhNts;
        Mon, 28 Feb 2022 22:59:42 +0100 (CET)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Eric Paris <eparis@parisplace.org>,
        James Morris <jmorris@namei.org>,
        John Johansen <john.johansen@canonical.com>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Steve French <sfrench@samba.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>
Subject: [PATCH v1] fs: Fix inconsistent f_mode
Date:   Mon, 28 Feb 2022 22:59:35 +0100
Message-Id: <20220228215935.748017-1-mic@digikod.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mickaël Salaün <mic@linux.microsoft.com>

While transitionning to ACC_MODE() with commit 5300990c0370 ("Sanitize
f_flags helpers") and then fixing it with commit 6d125529c6cb ("Fix
ACC_MODE() for real"), we lost an open flags consistency check.  Opening
a file with O_WRONLY | O_RDWR leads to an f_flags containing MAY_READ |
MAY_WRITE (thanks to the ACC_MODE() helper) and an empty f_mode.
Indeed, the OPEN_FMODE() helper transforms 3 (an incorrect value) to 0.

Fortunately, vfs_read() and vfs_write() both check for FMODE_READ, or
respectively FMODE_WRITE, and return an EBADF error if it is absent.
Before commit 5300990c0370 ("Sanitize f_flags helpers"), opening a file
with O_WRONLY | O_RDWR returned an EINVAL error.  Let's restore this safe
behavior.

To make it consistent with ACC_MODE(), this patch also changes
OPEN_FMODE() to return FMODE_READ | FMODE_WRITE for O_WRONLY | O_RDWR.
This may help protect from potential spurious issues.

This issue could result in inconsistencies with AppArmor, Landlock and
SELinux, but the VFS checks would still forbid read and write accesses.
Tomoyo uses the ACC_MODE() transformation which is correct, and Smack
doesn't check the file mode.  Filesystems using OPEN_FMODE() should also
be protected by the VFS checks.

Fixes: 5300990c0370 ("Sanitize f_flags helpers")
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Casey Schaufler <casey@schaufler-ca.com>
Cc: Darrick J. Wong <djwong@kernel.org>
Cc: Eric Paris <eparis@parisplace.org>
Cc: John Johansen <john.johansen@canonical.com>
Cc: Kentaro Takeda <takedakn@nttdata.co.jp>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Steve French <sfrench@samba.org>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
Link: https://lore.kernel.org/r/20220228215935.748017-1-mic@digikod.net
---
 fs/file_table.c    | 3 +++
 include/linux/fs.h | 5 +++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index 7d2e692b66a9..b936f69525d0 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -135,6 +135,9 @@ static struct file *__alloc_file(int flags, const struct cred *cred)
 	struct file *f;
 	int error;
 
+	if ((flags & O_ACCMODE) == O_ACCMODE)
+		return ERR_PTR(-EINVAL);
+
 	f = kmem_cache_zalloc(filp_cachep, GFP_KERNEL);
 	if (unlikely(!f))
 		return ERR_PTR(-ENOMEM);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e2d892b201b0..83bc5aaf1c41 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3527,8 +3527,9 @@ int __init list_bdev_fs_names(char *buf, size_t size);
 #define __FMODE_NONOTIFY	((__force int) FMODE_NONOTIFY)
 
 #define ACC_MODE(x) ("\004\002\006\006"[(x)&O_ACCMODE])
-#define OPEN_FMODE(flag) ((__force fmode_t)(((flag + 1) & O_ACCMODE) | \
-					    (flag & __FMODE_NONOTIFY)))
+#define OPEN_FMODE(flag) ((__force fmode_t)( \
+			(((flag + 1) & O_ACCMODE) ?: O_ACCMODE) | \
+			(flag & __FMODE_NONOTIFY)))
 
 static inline bool is_sxid(umode_t mode)
 {

base-commit: 7e57714cd0ad2d5bb90e50b5096a0e671dec1ef3
-- 
2.35.1

