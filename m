Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3720E22B461
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jul 2020 19:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbgGWRMk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jul 2020 13:12:40 -0400
Received: from smtp-8fae.mail.infomaniak.ch ([83.166.143.174]:42551 "EHLO
        smtp-8fae.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730184AbgGWRMj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jul 2020 13:12:39 -0400
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4BCJmj2Cl5zlhZMw;
        Thu, 23 Jul 2020 19:12:37 +0200 (CEST)
Received: from localhost (unknown [94.23.54.103])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4BCJmh5yFczlh8TQ;
        Thu, 23 Jul 2020 19:12:36 +0200 (CEST)
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
        Mimi Zohar <zohar@linux.ibm.com>,
        =?UTF-8?q?Philippe=20Tr=C3=A9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Thibaut Sautereau <thibaut.sautereau@clip-os.org>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v7 2/7] exec: Move S_ISREG() check earlier
Date:   Thu, 23 Jul 2020 19:12:22 +0200
Message-Id: <20200723171227.446711-3-mic@digikod.net>
X-Mailer: git-send-email 2.28.0.rc1
In-Reply-To: <20200723171227.446711-1-mic@digikod.net>
References: <20200723171227.446711-1-mic@digikod.net>
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

The execve(2)/uselib(2) syscalls have always rejected non-regular
files. Recently, it was noticed that a deadlock was introduced when trying
to execute pipes, as the S_ISREG() test was happening too late. This was
fixed in commit 73601ea5b7b1 ("fs/open.c: allow opening only regular files
during execve()"), but it was added after inode_permission() had already
run, which meant LSMs could see bogus attempts to execute non-regular
files.

Move the test into the other inode type checks (which already look
for other pathological conditions[1]). Since there is no need to use
FMODE_EXEC while we still have access to "acc_mode", also switch the
test to MAY_EXEC.

Also include a comment with the redundant S_ISREG() checks at the end of
execve(2)/uselib(2) to note that they are present to avoid any mistakes.

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
		    /* new location of MAY_EXEC vs S_ISREG() test */
                    inode_permission(inode, MAY_OPEN | acc_mode)
                        security_inode_permission(inode, acc_mode)
                vfs_open(path, file)
                    do_dentry_open(file, path->dentry->d_inode, open)
                        /* old location of FMODE_EXEC vs S_ISREG() test */
                        security_file_open(f)
                        open()

[1] https://lore.kernel.org/lkml/202006041910.9EF0C602@keescook/

Signed-off-by: Mickaël Salaün <mic@digikod.net>
Signed-off-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20200605160013.3954297-3-keescook@chromium.org
---
 fs/exec.c  | 14 ++++++++++++--
 fs/namei.c |  6 ++++--
 fs/open.c  |  6 ------
 3 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index d7c937044d10..bdc6a6eb5dce 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -141,8 +141,13 @@ SYSCALL_DEFINE1(uselib, const char __user *, library)
 	if (IS_ERR(file))
 		goto out;
 
+	/*
+	 * may_open() has already checked for this, so it should be
+	 * impossible to trip now. But we need to be extra cautious
+	 * and check again at the very end too.
+	 */
 	error = -EACCES;
-	if (!S_ISREG(file_inode(file)->i_mode))
+	if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode)))
 		goto exit;
 
 	if (path_noexec(&file->f_path))
@@ -886,8 +891,13 @@ static struct file *do_open_execat(int fd, struct filename *name, int flags)
 	if (IS_ERR(file))
 		goto out;
 
+	/*
+	 * may_open() has already checked for this, so it should be
+	 * impossible to trip now. But we need to be extra cautious
+	 * and check again at the very end too.
+	 */
 	err = -EACCES;
-	if (!S_ISREG(file_inode(file)->i_mode))
+	if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode)))
 		goto exit;
 
 	if (path_noexec(&file->f_path))
diff --git a/fs/namei.c b/fs/namei.c
index 72d4219c93ac..a559ad943970 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2849,16 +2849,18 @@ static int may_open(const struct path *path, int acc_mode, int flag)
 	case S_IFLNK:
 		return -ELOOP;
 	case S_IFDIR:
-		if (acc_mode & MAY_WRITE)
+		if (acc_mode & (MAY_WRITE | MAY_EXEC))
 			return -EISDIR;
 		break;
 	case S_IFBLK:
 	case S_IFCHR:
 		if (!may_open_dev(path))
 			return -EACCES;
-		/*FALLTHRU*/
+		fallthrough;
 	case S_IFIFO:
 	case S_IFSOCK:
+		if (acc_mode & MAY_EXEC)
+			return -EACCES;
 		flag &= ~O_TRUNC;
 		break;
 	}
diff --git a/fs/open.c b/fs/open.c
index 6cd48a61cda3..623b7506a6db 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -784,12 +784,6 @@ static int do_dentry_open(struct file *f,
 		return 0;
 	}
 
-	/* Any file opened for execve()/uselib() has to be a regular file. */
-	if (unlikely(f->f_flags & FMODE_EXEC && !S_ISREG(inode->i_mode))) {
-		error = -EACCES;
-		goto cleanup_file;
-	}
-
 	if (f->f_mode & FMODE_WRITE && !special_file(inode->i_mode)) {
 		error = get_write_access(inode);
 		if (unlikely(error))
-- 
2.27.0

