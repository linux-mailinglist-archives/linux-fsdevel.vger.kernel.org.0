Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB1C715213
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2019 18:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfEFQ4O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 May 2019 12:56:14 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:60150 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbfEFQ4O (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 May 2019 12:56:14 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 08D03A0134;
        Mon,  6 May 2019 18:56:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter06.heinlein-hosting.de (spamfilter06.heinlein-hosting.de [80.241.56.125]) (amavisd-new, port 10030)
        with ESMTP id a3GxmnUIcuje; Mon,  6 May 2019 18:55:58 +0200 (CEST)
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        Christian Brauner <christian@brauner.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        containers@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v6 5/6] binfmt_*: scope path resolution of interpreters
Date:   Tue,  7 May 2019 02:54:38 +1000
Message-Id: <20190506165439.9155-6-cyphar@cyphar.com>
In-Reply-To: <20190506165439.9155-1-cyphar@cyphar.com>
References: <20190506165439.9155-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The need to be able to scope path resolution of interpreters became
clear with one of the possible vectors used in CVE-2019-5736 (which
most major container runtimes were vulnerable to).

Naively, it might seem that openat(2) -- which supports path scoping --
can be combined with execveat(AT_EMPTY_PATH) to trivially scope the
binary being executed. Unfortunately, a "bad binary" (usually a symlink)
could be written as a #!-style script with the symlink target as the
interpreter -- which would be completely missed by just scoping the
openat(2). An example of this being exploitable is CVE-2019-5736.

In order to get around this, we need to pass down to each binfmt_*
implementation the scoping flags requested in execveat(2). In order to
maintain backwards-compatibility we only pass the scoping AT_* flags.

To avoid breaking userspace (in the exceptionally rare cases where you
have #!-scripts with a relative path being execveat(2)-ed with dfd !=
AT_FDCWD), we only pass dfd down to binfmt_* if any of our new flags are
set in execveat(2).

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 fs/binfmt_elf.c            |  2 +-
 fs/binfmt_elf_fdpic.c      |  2 +-
 fs/binfmt_em86.c           |  4 ++--
 fs/binfmt_misc.c           |  2 +-
 fs/binfmt_script.c         |  2 +-
 fs/exec.c                  | 26 ++++++++++++++++++++++----
 include/linux/binfmts.h    |  1 +
 include/linux/fs.h         |  9 +++++++--
 include/uapi/linux/fcntl.h |  6 ++++++
 9 files changed, 42 insertions(+), 12 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 7d09d125f148..473420eed477 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -772,7 +772,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 			if (elf_interpreter[elf_ppnt->p_filesz - 1] != '\0')
 				goto out_free_interp;
 
-			interpreter = open_exec(elf_interpreter);
+			interpreter = openat_exec(bprm->dfd, elf_interpreter, bprm->flags);
 			retval = PTR_ERR(interpreter);
 			if (IS_ERR(interpreter))
 				goto out_free_interp;
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index b53bb3729ac1..c463c6428f77 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -263,7 +263,7 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
 			kdebug("Using ELF interpreter %s", interpreter_name);
 
 			/* replace the program with the interpreter */
-			interpreter = open_exec(interpreter_name);
+			interpreter = openat_exec(bprm->dfd, interpreter_name, bprm->flags);
 			retval = PTR_ERR(interpreter);
 			if (IS_ERR(interpreter)) {
 				interpreter = NULL;
diff --git a/fs/binfmt_em86.c b/fs/binfmt_em86.c
index dd2d3f0cd55d..3ee46b0dc0d4 100644
--- a/fs/binfmt_em86.c
+++ b/fs/binfmt_em86.c
@@ -81,10 +81,10 @@ static int load_em86(struct linux_binprm *bprm)
 
 	/*
 	 * OK, now restart the process with the interpreter's inode.
-	 * Note that we use open_exec() as the name is now in kernel
+	 * Note that we use openat_exec() as the name is now in kernel
 	 * space, and we don't need to copy it.
 	 */
-	file = open_exec(interp);
+	file = openat_exec(binprm->dfd, interp, binprm->flags);
 	if (IS_ERR(file))
 		return PTR_ERR(file);
 
diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index aa4a7a23ff99..573ef06ff5a1 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -209,7 +209,7 @@ static int load_misc_binary(struct linux_binprm *bprm)
 		if (!IS_ERR(interp_file))
 			deny_write_access(interp_file);
 	} else {
-		interp_file = open_exec(fmt->interpreter);
+		interp_file = openat_exec(bprm->dfd, fmt->interpreter, bprm->flags);
 	}
 	retval = PTR_ERR(interp_file);
 	if (IS_ERR(interp_file))
diff --git a/fs/binfmt_script.c b/fs/binfmt_script.c
index e996174cbfc0..aaff12d12bfd 100644
--- a/fs/binfmt_script.c
+++ b/fs/binfmt_script.c
@@ -137,7 +137,7 @@ static int load_script(struct linux_binprm *bprm)
 	/*
 	 * OK, now restart the process with the interpreter's dentry.
 	 */
-	file = open_exec(i_name);
+	file = openat_exec(bprm->dfd, i_name, bprm->flags);
 	if (IS_ERR(file))
 		return PTR_ERR(file);
 
diff --git a/fs/exec.c b/fs/exec.c
index 2e0033348d8e..d0f244d9a541 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -846,12 +846,24 @@ static struct file *do_open_execat(int fd, struct filename *name, int flags)
 		.lookup_flags = LOOKUP_FOLLOW,
 	};
 
-	if ((flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)) != 0)
+	if ((flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH | AT_BENEATH |
+		       AT_XDEV | AT_NO_MAGICLINKS | AT_NO_SYMLINKS |
+		       AT_THIS_ROOT)) != 0)
 		return ERR_PTR(-EINVAL);
 	if (flags & AT_SYMLINK_NOFOLLOW)
 		open_exec_flags.lookup_flags &= ~LOOKUP_FOLLOW;
 	if (flags & AT_EMPTY_PATH)
 		open_exec_flags.lookup_flags |= LOOKUP_EMPTY;
+	if (flags & AT_BENEATH)
+		open_exec_flags.lookup_flags |= LOOKUP_BENEATH;
+	if (flags & AT_XDEV)
+		open_exec_flags.lookup_flags |= LOOKUP_XDEV;
+	if (flags & AT_NO_MAGICLINKS)
+		open_exec_flags.lookup_flags |= LOOKUP_NO_MAGICLINKS;
+	if (flags & AT_NO_SYMLINKS)
+		open_exec_flags.lookup_flags |= LOOKUP_NO_SYMLINKS;
+	if (flags & AT_THIS_ROOT)
+		open_exec_flags.lookup_flags |= LOOKUP_IN_ROOT;
 
 	file = do_filp_open(fd, name, &open_exec_flags);
 	if (IS_ERR(file))
@@ -879,18 +891,18 @@ static struct file *do_open_execat(int fd, struct filename *name, int flags)
 	return ERR_PTR(err);
 }
 
-struct file *open_exec(const char *name)
+struct file *openat_exec(int dfd, const char *name, int flags)
 {
 	struct filename *filename = getname_kernel(name);
 	struct file *f = ERR_CAST(filename);
 
 	if (!IS_ERR(filename)) {
-		f = do_open_execat(AT_FDCWD, filename, 0);
+		f = do_open_execat(dfd, filename, flags);
 		putname(filename);
 	}
 	return f;
 }
-EXPORT_SYMBOL(open_exec);
+EXPORT_SYMBOL(openat_exec);
 
 int kernel_read_file(struct file *file, void **buf, loff_t *size,
 		     loff_t max_size, enum kernel_read_file_id id)
@@ -1762,6 +1774,12 @@ static int __do_execve_file(int fd, struct filename *filename,
 
 	sched_exec();
 
+	bprm->flags = flags & (AT_XDEV | AT_NO_MAGICLINKS | AT_NO_SYMLINKS |
+			       AT_THIS_ROOT);
+	bprm->dfd = AT_FDCWD;
+	if (bprm->flags)
+		bprm->dfd = fd;
+
 	bprm->file = file;
 	if (!filename) {
 		bprm->filename = "none";
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 688ab0de7810..e4da2d36e97f 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -50,6 +50,7 @@ struct linux_binprm {
 	unsigned int taso:1;
 #endif
 	unsigned int recursion_depth; /* only for search_binary_handler() */
+	int dfd, flags;		/* passed down to execat_open() */
 	struct file * file;
 	struct cred *cred;	/* new credentials */
 	int unsafe;		/* how unsafe this exec is (mask of LSM_UNSAFE_*) */
diff --git a/include/linux/fs.h b/include/linux/fs.h
index fe94c48481a6..cdcd2e021101 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2945,8 +2945,13 @@ extern int kernel_read_file_from_fd(int, void **, loff_t *, loff_t,
 extern ssize_t kernel_read(struct file *, void *, size_t, loff_t *);
 extern ssize_t kernel_write(struct file *, const void *, size_t, loff_t *);
 extern ssize_t __kernel_write(struct file *, const void *, size_t, loff_t *);
-extern struct file * open_exec(const char *);
- 
+
+extern struct file *openat_exec(int, const char *, int);
+static inline struct file *open_exec(const char *name)
+{
+	return openat_exec(AT_FDCWD, name, 0);
+}
+
 /* fs/dcache.c -- generic fs support functions */
 extern bool is_subdir(struct dentry *, struct dentry *);
 extern bool path_is_under(const struct path *, const struct path *);
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index 1d338357df8a..bfca7f87cd2a 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -93,5 +93,11 @@
 
 #define AT_RECURSIVE		0x8000	/* Apply to the entire subtree */
 
+#define AT_RESOLUTION_TYPE	0x1F0000 /* Type of path-resolution scoping we are applying. */
+#define AT_BENEATH		0x010000 /* - Block "lexical" trickery like "..", symlinks, absolute paths, etc. */
+#define AT_XDEV			0x020000 /* - Block mount-point crossings (includes bind-mounts). */
+#define AT_NO_MAGICLINKS	0x040000 /* - Block procfs-style "magic" symlinks. */
+#define AT_NO_SYMLINKS		0x080000 /* - Block all symlinks (implies AT_NO_MAGICLINKS). */
+#define AT_THIS_ROOT		0x100000 /* - Scope ".." resolution to dirfd (like chroot(2)). */
 
 #endif /* _UAPI_LINUX_FCNTL_H */
-- 
2.21.0

