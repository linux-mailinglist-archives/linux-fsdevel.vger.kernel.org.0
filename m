Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 855071ED90C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jun 2020 01:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbgFCXYR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Jun 2020 19:24:17 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40577 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgFCXYQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Jun 2020 19:24:16 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jgcjz-00009i-BX; Wed, 03 Jun 2020 23:24:11 +0000
Date:   Thu, 4 Jun 2020 01:24:10 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kyle Evans <self@kyle-evans.net>,
        Victor Stinner <victor.stinner@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: [PATCH v5 0/3] close_range()
Message-ID: <20200603232410.i3opsbmepv5ktsjq@wittgenstein>
References: <20200602204219.186620-1-christian.brauner@ubuntu.com>
 <CAHk-=wjy234P7tvpQb6bnd1rhO78Uc+B0g1CPg9VOhJNTxmtWw@mail.gmail.com>
 <20200602233355.zdwcfow3ff4o2dol@wittgenstein>
 <CAHk-=wimp3tNuMcix2Z3uCF0sFfQt5GhVku=yhJAmSALucYGjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wimp3tNuMcix2Z3uCF0sFfQt5GhVku=yhJAmSALucYGjg@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 02, 2020 at 05:08:22PM -0700, Linus Torvalds wrote:
> On Tue, Jun 2, 2020 at 4:33 PM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> > >
> > > And maybe this _did_ get mentioned last time, and I just don't find
> > > it. I also don't see anything like that in the patches, although the
> > > flags argument is there.
> >
> > I spent some good time digging and I couldn't find this mentioned
> > anywhere so maybe it just never got sent to the list?
> 
> It's entirely possible that it was just a private musing, and you
> re-opening this issue just resurrected the thought.
> 
> I'm not sure how simple it would be to implement, but looking at it it
> shouldn't be problematic to add a "max_fd" argument to unshare_fd()
> and dup_fd().
> 
> Although the range for unsharing is obviously reversed, so I'd suggest
> not trying to make "dup_fd()" take the exact range into account.
> 
> More like just making __close_range() do basically something like
> 
>         rcu_read_lock();
>         cur_max = files_fdtable(files)->max_fds;
>         rcu_read_unlock();
> 
>         if (flags & CLOSE_RANGE_UNSHARE) {
>                 unsigned int max_unshare_fd = ~0u;
>                 if (cur_max >= max_fd)
>                         max_unshare_fd = fd;
>                 unshare_fd(max_unsgare_fd);
>         }
> 
>         .. do the rest of __close_range() here ..
> 
> and all that "max_unsgare_fd" would do would be to limit the top end
> of the file descriptor table unsharing: we'd still do the exact range
> handling in __close_range() itself.
> 
> Because teaching unshare_fd() and dup_fd() about anything more complex
> than the above doesn't sound worth it, but adding a way to just avoid
> the unnecessary copy of any high file descriptors sounds simple
> enough.

Ok, here's what I have. (I think in your example above cur_max and
max_fd are switched or I might have missed your point completely.) I was
a little in doubt whether capping dup_fd() between NR_OPEN_DEFAULT and
open_files was a sane thing to do but I think it is. Torture testing
this with a proper test-suite and with all debugging options enabled
didn't yet find any obvious issues. Does the below look somewhat sane?:

From 4ee3fdac02f3cd70e31669e35d3f494913f3fd3f Mon Sep 17 00:00:00 2001
From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Wed, 3 Jun 2020 21:48:55 +0200
Subject: [PATCH 1/2] close_range: add CLOSE_RANGE_UNSHARE

One of the use-cases of close_range() is to drop file descriptors just before
execve(). This would usually be expressed in the sequence:

unshare(CLONE_FILES);
close_range(3, ~0U);

as pointed out by Linus it might be desirable to have this be a part of
close_range() itself under a new flag CLOSE_RANGE_UNSHARE.

This expands {dup,unshare)_fd() to take a max_fds argument that indicates the
maximum number of file descriptors to copy from the old struct files. When the
user requests that all file descriptors are supposed to be closed via
close_range(min, max) then we can cap via unshare_fd(min) and hence don't need
to do any of the heavy fput() work for everything above min.

The patch makes it so that if CLOSE_RANGE_UNSHARE is requested and we do in
fact currently share our file descriptor table we create a new private copy.
We then close all fds in the requested range and finally after we're done we
install the new fd table.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/file.c                        | 65 ++++++++++++++++++++++++++++----
 fs/open.c                        |  5 +--
 include/linux/fdtable.h          |  8 ++--
 include/uapi/linux/close_range.h |  9 +++++
 kernel/fork.c                    | 11 +++---
 5 files changed, 79 insertions(+), 19 deletions(-)
 create mode 100644 include/uapi/linux/close_range.h

diff --git a/fs/file.c b/fs/file.c
index e260bfe687d1..718356ed6682 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -19,6 +19,7 @@
 #include <linux/bitops.h>
 #include <linux/spinlock.h>
 #include <linux/rcupdate.h>
+#include <linux/close_range.h>
 
 unsigned int sysctl_nr_open __read_mostly = 1024*1024;
 unsigned int sysctl_nr_open_min = BITS_PER_LONG;
@@ -265,12 +266,22 @@ static unsigned int count_open_files(struct fdtable *fdt)
 	return i;
 }
 
+static unsigned int sane_fdtable_size(struct fdtable *fdt, unsigned int max_fds)
+{
+	unsigned int count;
+
+	count = count_open_files(fdt);
+	if (max_fds < NR_OPEN_DEFAULT)
+		max_fds = NR_OPEN_DEFAULT;
+	return min(count, max_fds);
+}
+
 /*
  * Allocate a new files structure and copy contents from the
  * passed in files structure.
  * errorp will be valid only when the returned files_struct is NULL.
  */
-struct files_struct *dup_fd(struct files_struct *oldf, int *errorp)
+struct files_struct *dup_fd(struct files_struct *oldf, unsigned int max_fds, int *errorp)
 {
 	struct files_struct *newf;
 	struct file **old_fds, **new_fds;
@@ -297,7 +308,7 @@ struct files_struct *dup_fd(struct files_struct *oldf, int *errorp)
 
 	spin_lock(&oldf->file_lock);
 	old_fdt = files_fdtable(oldf);
-	open_files = count_open_files(old_fdt);
+	open_files = sane_fdtable_size(old_fdt, max_fds);
 
 	/*
 	 * Check whether we need to allocate a larger fd array and fd set.
@@ -328,7 +339,7 @@ struct files_struct *dup_fd(struct files_struct *oldf, int *errorp)
 		 */
 		spin_lock(&oldf->file_lock);
 		old_fdt = files_fdtable(oldf);
-		open_files = count_open_files(old_fdt);
+		open_files = sane_fdtable_size(old_fdt, max_fds);
 	}
 
 	copy_fd_bitmaps(new_fdt, old_fdt, open_files);
@@ -665,30 +676,70 @@ EXPORT_SYMBOL(__close_fd); /* for ksys_close() */
  * This closes a range of file descriptors. All file descriptors
  * from @fd up to and including @max_fd are closed.
  */
-int __close_range(struct files_struct *files, unsigned fd, unsigned max_fd)
+int __close_range(unsigned fd, unsigned max_fd, unsigned int flags)
 {
 	unsigned int cur_max;
+	struct task_struct *me = current;
+	struct files_struct *cur_fds = me->files, *fds = NULL;
+
+	if (flags & ~CLOSE_RANGE_UNSHARE)
+		return -EINVAL;
 
 	if (fd > max_fd)
 		return -EINVAL;
 
 	rcu_read_lock();
-	cur_max = files_fdtable(files)->max_fds;
+	cur_max = files_fdtable(cur_fds)->max_fds;
 	rcu_read_unlock();
 
+	if (flags & CLOSE_RANGE_UNSHARE) {
+		int ret;
+		unsigned int max_unshare_fds = NR_OPEN_MAX;
+
+		/*
+		 * If the requested range is greater than the current maximum,
+		 * we're closing everything so only copy all file descriptors
+		 * beneath the lowest file descriptor.
+		 */
+		if ((max_fd + 1) >= cur_max)
+			max_unshare_fds = fd;
+
+		ret = unshare_fd(CLONE_FILES, max_unshare_fds, &fds);
+		if (ret)
+			return ret;
+
+		/*
+		 * We used to share our file descriptor table, and have now
+		 * created a private one, make sure we're using it below.
+		 */
+		if (fds)
+			swap(cur_fds, fds);
+	}
+
 	/* cap to last valid index into fdtable */
 	max_fd = min(max_fd, (cur_max - 1));
 	while (fd <= max_fd) {
 		struct file *file;
 
-		file = pick_file(files, fd++);
+		file = pick_file(cur_fds, fd++);
 		if (!file)
 			continue;
 
-		filp_close(file, files);
+		filp_close(file, cur_fds);
 		cond_resched();
 	}
 
+	if (fds) {
+		/*
+		 * We're done closing the files we were supposed to. Time to install
+		 * the new file descriptor table and drop the old one.
+		 */
+		task_lock(me);
+		me->files = cur_fds;
+		task_unlock(me);
+		put_files_struct(fds);
+	}
+
 	return 0;
 }
 
diff --git a/fs/open.c b/fs/open.c
index 87e076e9e127..28c561734ece 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1293,10 +1293,7 @@ SYSCALL_DEFINE1(close, unsigned int, fd)
 SYSCALL_DEFINE3(close_range, unsigned int, fd, unsigned int, max_fd,
 		unsigned int, flags)
 {
-	if (flags)
-		return -EINVAL;
-
-	return __close_range(current->files, fd, max_fd);
+	return __close_range(fd, max_fd, flags);
 }
 
 /*
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index fcd07181a365..a32bf47c593e 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -22,6 +22,7 @@
  * as this is the granularity returned by copy_fdset().
  */
 #define NR_OPEN_DEFAULT BITS_PER_LONG
+#define NR_OPEN_MAX ~0U
 
 struct fdtable {
 	unsigned int max_fds;
@@ -109,7 +110,7 @@ struct files_struct *get_files_struct(struct task_struct *);
 void put_files_struct(struct files_struct *fs);
 void reset_files_struct(struct files_struct *);
 int unshare_files(struct files_struct **);
-struct files_struct *dup_fd(struct files_struct *, int *) __latent_entropy;
+struct files_struct *dup_fd(struct files_struct *, unsigned, int *) __latent_entropy;
 void do_close_on_exec(struct files_struct *);
 int iterate_fd(struct files_struct *, unsigned,
 		int (*)(const void *, struct file *, unsigned),
@@ -121,9 +122,10 @@ extern void __fd_install(struct files_struct *files,
 		      unsigned int fd, struct file *file);
 extern int __close_fd(struct files_struct *files,
 		      unsigned int fd);
-extern int __close_range(struct files_struct *files, unsigned int fd,
-			 unsigned int max_fd);
+extern int __close_range(unsigned int fd, unsigned int max_fd, unsigned int flags);
 extern int __close_fd_get_file(unsigned int fd, struct file **res);
+extern int unshare_fd(unsigned long unshare_flags, unsigned int max_fds,
+		      struct files_struct **new_fdp);
 
 extern struct kmem_cache *files_cachep;
 
diff --git a/include/uapi/linux/close_range.h b/include/uapi/linux/close_range.h
new file mode 100644
index 000000000000..6928a9fdee3c
--- /dev/null
+++ b/include/uapi/linux/close_range.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_CLOSE_RANGE_H
+#define _UAPI_LINUX_CLOSE_RANGE_H
+
+/* Unshare the file descriptor table before closing file descriptors. */
+#define CLOSE_RANGE_UNSHARE	(1U << 1)
+
+#endif /* _UAPI_LINUX_CLOSE_RANGE_H */
+
diff --git a/kernel/fork.c b/kernel/fork.c
index 48ed22774efa..836976aa7ab9 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1466,7 +1466,7 @@ static int copy_files(unsigned long clone_flags, struct task_struct *tsk)
 		goto out;
 	}
 
-	newf = dup_fd(oldf, &error);
+	newf = dup_fd(oldf, NR_OPEN_MAX, &error);
 	if (!newf)
 		goto out;
 
@@ -2894,14 +2894,15 @@ static int unshare_fs(unsigned long unshare_flags, struct fs_struct **new_fsp)
 /*
  * Unshare file descriptor table if it is being shared
  */
-static int unshare_fd(unsigned long unshare_flags, struct files_struct **new_fdp)
+int unshare_fd(unsigned long unshare_flags, unsigned int max_fds,
+	       struct files_struct **new_fdp)
 {
 	struct files_struct *fd = current->files;
 	int error = 0;
 
 	if ((unshare_flags & CLONE_FILES) &&
 	    (fd && atomic_read(&fd->count) > 1)) {
-		*new_fdp = dup_fd(fd, &error);
+		*new_fdp = dup_fd(fd, max_fds, &error);
 		if (!*new_fdp)
 			return error;
 	}
@@ -2961,7 +2962,7 @@ int ksys_unshare(unsigned long unshare_flags)
 	err = unshare_fs(unshare_flags, &new_fs);
 	if (err)
 		goto bad_unshare_out;
-	err = unshare_fd(unshare_flags, &new_fd);
+	err = unshare_fd(unshare_flags, NR_OPEN_MAX, &new_fd);
 	if (err)
 		goto bad_unshare_cleanup_fs;
 	err = unshare_userns(unshare_flags, &new_cred);
@@ -3050,7 +3051,7 @@ int unshare_files(struct files_struct **displaced)
 	struct files_struct *copy = NULL;
 	int error;
 
-	error = unshare_fd(CLONE_FILES, &copy);
+	error = unshare_fd(CLONE_FILES, NR_OPEN_MAX, &copy);
 	if (error || !copy) {
 		*displaced = NULL;
 		return error;
-- 
2.27.0

