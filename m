Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B65B7296AE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2019 13:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390918AbfEXLLM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 May 2019 07:11:12 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36033 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390927AbfEXLLL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 May 2019 07:11:11 -0400
Received: by mail-io1-f68.google.com with SMTP id e19so7455561iob.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 May 2019 04:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rhZAWZY420W9eejDuzCNsrLPgaOVr7Or4/K0Jy7i4yY=;
        b=FsbV2qgS3N+bVZHxN3JVxPsqc4B3V8qaQXmxV4OSZQAlj+rZLT0hbsg2sRRu/q76XG
         M75g7npf866RubtVyNiJB2ciarkgFIrLG5h2ZmTDjjOHqo2nqt/OeslQaG9fA+KKedlC
         BuUQ+cR3O0OgqjLUry2PGogJfTk1Vgwd3mrABF3oqMi9pIYCI6pRlvgPrFqZxF+8sSFO
         mg1nf369dCNnZvQabk4uyd+Eguz7R1OTr+QU7BYZsSzpTh3v2V5Qlbr6qq+zWpm1XmSJ
         ayu2v3Tg+KmX8apAgW2uj+sUJAUBQBpgfA5kn8aLTgaOt1gQq2y3rxG/Tugk6+flQj79
         oNBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rhZAWZY420W9eejDuzCNsrLPgaOVr7Or4/K0Jy7i4yY=;
        b=TY0I58/UEdchT0BgO5p1IOE4lgqQRX55uSuRTxgNH7iu9+TPDJmRJ5x+tUC8SjKejn
         sIYs0wY4WQJ8X5Cgd+tB+h8z5hQLIT8eduHgUlUuqxe4rmthtGV6yqQHcBXBpo5wqdH1
         K5QjO7n/dwJUP9dyW6opisAVPSjGTe28+6rHG163o0oiXd1Po8uEc1TlpnEfKnEC1cad
         IM5uONTynjV8hsapyxlyn8ZqTzQlp5p978I5dY3XPDdTjyL/zQX7gzgeaqr3poUY0ZaM
         3zwGJYn/+5i67BMtlFOWfcskNQTH7+VseFWhFi4seZV33/cPTQbHC80DiA6GMEOQ59Tw
         p5CA==
X-Gm-Message-State: APjAAAUjbCow8b02D8jNlqzPcDrxqoGrADdNs41gjz7E4Q5U9GBjnQLq
        XZJ4iccIdZ1wEnV4Od+UvQQD3Q==
X-Google-Smtp-Source: APXvYqyC27AGz+E8syYbUonNFIOlkFmC6aJmHw+if9hOc5r+80bA5k/WcqtKuqsLame8oA8UxA4OqA==
X-Received: by 2002:a5d:9758:: with SMTP id c24mr36952128ioo.114.1558696270600;
        Fri, 24 May 2019 04:11:10 -0700 (PDT)
Received: from localhost.localdomain ([172.56.12.37])
        by smtp.gmail.com with ESMTPSA id y194sm1024771itb.34.2019.05.24.04.11.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 04:11:09 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        fweimer@redhat.com
Cc:     jannh@google.com, oleg@redhat.com, tglx@linutronix.de,
        arnd@arndb.de, shuah@kernel.org, dhowells@redhat.com,
        tkjos@android.com, ldv@altlinux.org, miklos@szeredi.hu,
        Christian Brauner <christian@brauner.io>,
        linux-api@vger.kernel.org
Subject: [PATCH v3 1/3] open: add close_range()
Date:   Fri, 24 May 2019 13:10:45 +0200
Message-Id: <20190524111047.6892-2-christian@brauner.io>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190524111047.6892-1-christian@brauner.io>
References: <20190524111047.6892-1-christian@brauner.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds the close_range() syscall. It allows to efficiently close a range
of file descriptors up to all file descriptors of a calling task.

The syscall came up in a recent discussion around the new mount API and
making new file descriptor types cloexec by default. During this
discussion, Al suggested the close_range() syscall (cf. [1]). Note, a
syscall in this manner has been requested by various people over time.

First, it helps to close all file descriptors of an exec()ing task. This
can be done safely via (quoting Al's example from [1] verbatim):

        /* that exec is sensitive */
        unshare(CLONE_FILES);
        /* we don't want anything past stderr here */
        close_range(3, ~0U);
        execve(....);

The code snippet above is one way of working around the problem that file
descriptors are not cloexec by default. This is aggravated by the fact that
we can't just switch them over without massively regressing userspace. For
a whole class of programs having an in-kernel method of closing all file
descriptors is very helpful (e.g. demons, service managers, programming
language standard libraries, container managers etc.).
(Please note, unshare(CLONE_FILES) should only be needed if the calling
 task is multi-threaded and shares the file descriptor table with another
 thread in which case two threads could race with one thread allocating
 file descriptors and the other one closing them via close_range(). For the
 general case close_range() before the execve() is sufficient.)

Second, it allows userspace to avoid implementing closing all file
descriptors by parsing through /proc/<pid>/fd/* and calling close() on each
file descriptor. From looking at various large(ish) userspace code bases
this or similar patterns are very common in:
- service managers (cf. [4])
- libcs (cf. [6])
- container runtimes (cf. [5])
- programming language runtimes/standard libraries
  - Python (cf. [2])
  - Rust (cf. [7], [8])
As Dmitry pointed out there's even a long-standing glibc bug about missing
kernel support for this task (cf. [3]).
In addition, the syscall will also work for tasks that do not have procfs
mounted and on kernels that do not have procfs support compiled in. In such
situations the only way to make sure that all file descriptors are closed
is to call close() on each file descriptor up to UINT_MAX or RLIMIT_NOFILE,
OPEN_MAX trickery (cf. comment [8] on Rust).

The performance is striking. For good measure, comparing the following
simple close_all_fds() userspace implementation that is essentially just
glibc's version in [6]:

static int close_all_fds(void)
{
        int dir_fd;
        DIR *dir;
        struct dirent *direntp;

        dir = opendir("/proc/self/fd");
        if (!dir)
                return -1;
        dir_fd = dirfd(dir);
        while ((direntp = readdir(dir))) {
                int fd;
                if (strcmp(direntp->d_name, ".") == 0)
                        continue;
                if (strcmp(direntp->d_name, "..") == 0)
                        continue;
                fd = atoi(direntp->d_name);
                if (fd == dir_fd || fd == 0 || fd == 1 || fd == 2)
                        continue;
                close(fd);
        }
        closedir(dir);
        return 0;
}

to close_range() yields:
1. closing 4 open files:
   - close_all_fds(): ~280 us
   - close_range():    ~24 us

2. closing 1000 open files:
   - close_all_fds(): ~5000 us
   - close_range():   ~800 us

close_range() is designed to allow for some flexibility. Specifically, it
does not simply always close all open file descriptors of a task. Instead,
callers can specify an upper bound.
This is e.g. useful for scenarios where specific file descriptors are
created with well-known numbers that are supposed to be excluded from
getting closed.
For extra paranoia close_range() comes with a flags argument. This can e.g.
be used to implement extension. Once can imagine userspace wanting to stop
at the first error instead of ignoring errors under certain circumstances.
There might be other valid ideas in the future. In any case, a flag
argument doesn't hurt and keeps us on the safe side.

From an implementation side this is kept rather dumb. It saw some input
from David and Jann but all nonsense is obviously my own!
- Errors to close file descriptors are currently ignored. (Could be changed
  by setting a flag in the future if needed.)
- __close_range() is a rather simplistic wrapper around __close_fd().
  My reasoning behind this is based on the nature of how __close_fd() needs
  to release an fd. But maybe I misunderstood specifics:
  We take the files_lock and rcu-dereference the fdtable of the calling
  task, we find the entry in the fdtable, get the file and need to release
  files_lock before calling filp_close().
  In the meantime the fdtable might have been altered so we can't just
  retake the spinlock and keep the old rcu-reference of the fdtable
  around. Instead we need to grab a fresh reference to the fdtable.
  If my reasoning is correct then there's really no point in fancyfying
  __close_range(): We just need to rcu-dereference the fdtable of the
  calling task once to cap the max_fd value correctly and then go on
  calling __close_fd() in a loop.

/* References */
[1]: https://lore.kernel.org/lkml/20190516165021.GD17978@ZenIV.linux.org.uk/
[2]: https://github.com/python/cpython/blob/9e4f2f3a6b8ee995c365e86d976937c141d867f8/Modules/_posixsubprocess.c#L220
[3]: https://sourceware.org/bugzilla/show_bug.cgi?id=10353#c7
[4]: https://github.com/systemd/systemd/blob/5238e9575906297608ff802a27e2ff9effa3b338/src/basic/fd-util.c#L217
[5]: https://github.com/lxc/lxc/blob/ddf4b77e11a4d08f09b7b9cd13e593f8c047edc5/src/lxc/start.c#L236
[6]: https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/unix/sysv/linux/grantpt.c;h=2030e07fa6e652aac32c775b8c6e005844c3c4eb;hb=HEAD#l17
     Note that this is an internal implementation that is not exported.
     Currently, libc seems to not provide an exported version of this
     because of missing kernel support to do this.
[7]: https://github.com/rust-lang/rust/issues/12148
[8]: https://github.com/rust-lang/rust/blob/5f47c0613ed4eb46fca3633c1297364c09e5e451/src/libstd/sys/unix/process2.rs#L303-L308
     Rust's solution is slightly different but is equally unperformant.
     Rust calls getdtablesize() which is a glibc library function that
     simply returns the current RLIMIT_NOFILE or OPEN_MAX values. Rust then
     goes on to call close() on each fd. That's obviously overkill for most
     tasks. Rarely, tasks - especially non-demons - hit RLIMIT_NOFILE or
     OPEN_MAX.
     Let's be nice and assume an unprivileged user with RLIMIT_NOFILE set
     to 1024. Even in this case, there's a very high chance that in the
     common case Rust is calling the close() syscall 1021 times pointlessly
     if the task just has 0, 1, and 2 open.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Christian Brauner <christian@brauner.io>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jann Horn <jannh@google.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Dmitry V. Levin <ldv@altlinux.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: linux-api@vger.kernel.org
---
v1:
- Linus Torvalds <torvalds@linux-foundation.org>:
  - add cond_resched() to yield cpu when closing a lot of file descriptors
- Al Viro <viro@zeniv.linux.org.uk>:
  - add cond_resched() to yield cpu when closing a lot of file descriptors
v2: unchanged
v3:
- Oleg Nesterov <oleg@redhat.com>:
  - fix braino: s/max()/min()/
---
 fs/file.c                | 62 ++++++++++++++++++++++++++++++++++------
 fs/open.c                | 20 +++++++++++++
 include/linux/fdtable.h  |  2 ++
 include/linux/syscalls.h |  2 ++
 4 files changed, 78 insertions(+), 8 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 3da91a112bab..e896d87f4431 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -10,6 +10,7 @@
 #include <linux/syscalls.h>
 #include <linux/export.h>
 #include <linux/fs.h>
+#include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/sched/signal.h>
 #include <linux/slab.h>
@@ -615,12 +616,9 @@ void fd_install(unsigned int fd, struct file *file)
 
 EXPORT_SYMBOL(fd_install);
 
-/*
- * The same warnings as for __alloc_fd()/__fd_install() apply here...
- */
-int __close_fd(struct files_struct *files, unsigned fd)
+static struct file *pick_file(struct files_struct *files, unsigned fd)
 {
-	struct file *file;
+	struct file *file = NULL;
 	struct fdtable *fdt;
 
 	spin_lock(&files->file_lock);
@@ -632,15 +630,63 @@ int __close_fd(struct files_struct *files, unsigned fd)
 		goto out_unlock;
 	rcu_assign_pointer(fdt->fd[fd], NULL);
 	__put_unused_fd(files, fd);
-	spin_unlock(&files->file_lock);
-	return filp_close(file, files);
 
 out_unlock:
 	spin_unlock(&files->file_lock);
-	return -EBADF;
+	return file;
+}
+
+/*
+ * The same warnings as for __alloc_fd()/__fd_install() apply here...
+ */
+int __close_fd(struct files_struct *files, unsigned fd)
+{
+	struct file *file;
+
+	file = pick_file(files, fd);
+	if (!file)
+		return -EBADF;
+
+	return filp_close(file, files);
 }
 EXPORT_SYMBOL(__close_fd); /* for ksys_close() */
 
+/**
+ * __close_range() - Close all file descriptors in a given range.
+ *
+ * @fd:     starting file descriptor to close
+ * @max_fd: last file descriptor to close
+ *
+ * This closes a range of file descriptors. All file descriptors
+ * from @fd up to and including @max_fd are closed.
+ */
+int __close_range(struct files_struct *files, unsigned fd, unsigned max_fd)
+{
+	unsigned int cur_max;
+
+	if (fd > max_fd)
+		return -EINVAL;
+
+	rcu_read_lock();
+	cur_max = files_fdtable(files)->max_fds;
+	rcu_read_unlock();
+
+	/* cap to last valid index into fdtable */
+	max_fd = min(max_fd, (cur_max - 1));
+	while (fd <= max_fd) {
+		struct file *file;
+
+		file = pick_file(files, fd++);
+		if (!file)
+			continue;
+
+		filp_close(file, files);
+		cond_resched();
+	}
+
+	return 0;
+}
+
 /*
  * variant of __close_fd that gets a ref on the file for later fput
  */
diff --git a/fs/open.c b/fs/open.c
index 9c7d724a6f67..c7baaee7aa47 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1174,6 +1174,26 @@ SYSCALL_DEFINE1(close, unsigned int, fd)
 	return retval;
 }
 
+/**
+ * close_range() - Close all file descriptors in a given range.
+ *
+ * @fd:     starting file descriptor to close
+ * @max_fd: last file descriptor to close
+ * @flags:  reserved for future extensions
+ *
+ * This closes a range of file descriptors. All file descriptors
+ * from @fd up to and including @max_fd are closed.
+ * Currently, errors to close a given file descriptor are ignored.
+ */
+SYSCALL_DEFINE3(close_range, unsigned int, fd, unsigned int, max_fd,
+		unsigned int, flags)
+{
+	if (flags)
+		return -EINVAL;
+
+	return __close_range(current->files, fd, max_fd);
+}
+
 /*
  * This routine simulates a hangup on the tty, to arrange that users
  * are given clean terminals at login time.
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index f07c55ea0c22..fcd07181a365 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -121,6 +121,8 @@ extern void __fd_install(struct files_struct *files,
 		      unsigned int fd, struct file *file);
 extern int __close_fd(struct files_struct *files,
 		      unsigned int fd);
+extern int __close_range(struct files_struct *files, unsigned int fd,
+			 unsigned int max_fd);
 extern int __close_fd_get_file(unsigned int fd, struct file **res);
 
 extern struct kmem_cache *files_cachep;
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index e2870fe1be5b..c0189e223255 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -441,6 +441,8 @@ asmlinkage long sys_fchown(unsigned int fd, uid_t user, gid_t group);
 asmlinkage long sys_openat(int dfd, const char __user *filename, int flags,
 			   umode_t mode);
 asmlinkage long sys_close(unsigned int fd);
+asmlinkage long sys_close_range(unsigned int fd, unsigned int max_fd,
+				unsigned int flags);
 asmlinkage long sys_vhangup(void);
 
 /* fs/pipe.c */
-- 
2.21.0

