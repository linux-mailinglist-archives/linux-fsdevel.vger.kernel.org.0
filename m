Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34EDF21F900
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 20:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbgGNSQ7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 14:16:59 -0400
Received: from smtp-190c.mail.infomaniak.ch ([185.125.25.12]:50389 "EHLO
        smtp-190c.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729167AbgGNSQz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:16:55 -0400
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4B5pd104bdzlhLMx;
        Tue, 14 Jul 2020 20:16:53 +0200 (CEST)
Received: from localhost (unknown [94.23.54.103])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4B5pd03q4Jzlh8TF;
        Tue, 14 Jul 2020 20:16:52 +0200 (CEST)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mickael.salaun@ssi.gouv.fr>,
        Mimi Zohar <zohar@linux.ibm.com>,
        =?UTF-8?q?Philippe=20Tr=C3=A9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v6 3/7] exec: Move path_noexec() check earlier
Date:   Tue, 14 Jul 2020 20:16:34 +0200
Message-Id: <20200714181638.45751-4-mic@digikod.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714181638.45751-1-mic@digikod.net>
References: <20200714181638.45751-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

The path_noexec() check, like the regular file check, was happening too
late, letting LSMs see impossible execve()s. Check it earlier as well
in may_open() and collect the redundant fs/exec.c path_noexec() test
under the same robustness comment as the S_ISREG() check.

My notes on the call path, and related arguments, checks, etc:

do_open_execat()
    struct open_flags open_exec_flags = {
        .open_flag = O_LARGEFILE | O_RDONLY | __FMODE_EXEC,
        .acc_mode = MAY_EXEC,
        ...
    do_filp_open(dfd, filename, open_flags)
        path_openat(nameidata, open_flags, flags)
            file = alloc_empty_file(open_flags, current_cred());
            do_open(nameidata, file, open_flags)
                may_open(path, acc_mode, open_flag)
                    /* new location of MAY_EXEC vs path_noexec() test */
                    inode_permission(inode, MAY_OPEN | acc_mode)
                        security_inode_permission(inode, acc_mode)
                vfs_open(path, file)
                    do_dentry_open(file, path->dentry->d_inode, open)
                        security_file_open(f)
                        open()
    /* old location of path_noexec() test */

Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20200605160013.3954297-4-keescook@chromium.org
---
 fs/exec.c  | 12 ++++--------
 fs/namei.c |  4 ++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index bdc6a6eb5dce..4eea20c27b01 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -147,10 +147,8 @@ SYSCALL_DEFINE1(uselib, const char __user *, library)
 	 * and check again at the very end too.
 	 */
 	error = -EACCES;
-	if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode)))
-		goto exit;
-
-	if (path_noexec(&file->f_path))
+	if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode) ||
+			 path_noexec(&file->f_path)))
 		goto exit;
 
 	fsnotify_open(file);
@@ -897,10 +895,8 @@ static struct file *do_open_execat(int fd, struct filename *name, int flags)
 	 * and check again at the very end too.
 	 */
 	err = -EACCES;
-	if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode)))
-		goto exit;
-
-	if (path_noexec(&file->f_path))
+	if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode) ||
+			 path_noexec(&file->f_path)))
 		goto exit;
 
 	err = deny_write_access(file);
diff --git a/fs/namei.c b/fs/namei.c
index a559ad943970..ddc9b25540fe 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2863,6 +2863,10 @@ static int may_open(const struct path *path, int acc_mode, int flag)
 			return -EACCES;
 		flag &= ~O_TRUNC;
 		break;
+	case S_IFREG:
+		if ((acc_mode & MAY_EXEC) && path_noexec(path))
+			return -EACCES;
+		break;
 	}
 
 	error = inode_permission(inode, MAY_OPEN | acc_mode);
-- 
2.27.0

