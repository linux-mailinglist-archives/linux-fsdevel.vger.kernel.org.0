Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 851B216047E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Feb 2020 16:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbgBPP0z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Feb 2020 10:26:55 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41644 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgBPP0z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Feb 2020 10:26:55 -0500
Received: by mail-wr1-f66.google.com with SMTP id c9so16651188wrw.8;
        Sun, 16 Feb 2020 07:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=P5S4facSlZbi0RRRt1SBFtzfa8ZksfOkm+kaoSpuvgk=;
        b=njDZHUtcM2N26KtNTAL5gvHkrpaeg8yD5Bb0mt/tZub+7mOM8zdUK0JUPAYxUEdV/P
         hljcYx+2kB6JDBsgERlv4otaq937gZcB7xrjHAhcc9swjzJyQTGp7bxMCP5RUm+Qcrc3
         LiGqo51mkWrYF9Nv73OB0FZSx8EJ6UkQyf4LD/+Ew//jhXNVBeaGKji/L2exlb30r1AL
         xEC/Y8yB0fJ7A9vAXEbTy2+dbFgu0C7Rz4tQf7Dzn+wZ+DJXIYKUtEsIc9BrtDndtu71
         KO7uvPyRm5qLEql8H/FWJyyV6t1Iop8zOqInIpZvqVyYD3AYcwgryDdZI+PGFOTbjdV5
         iElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=P5S4facSlZbi0RRRt1SBFtzfa8ZksfOkm+kaoSpuvgk=;
        b=Nz3xsw6RCNflG/wKHb2s4gV6nM+cDEc8BszpOFccPt/WTFlw4RyMqsE1NQigtOp9gB
         V7Tb88rgH7YaQiyoIE2N5DUn29ScMu53FA6QtckCkDU8uANG7/zxgm/K5hNWAeb5qWpy
         HhfRBET+d8bcUk8YqxII5oP6QxKe2u2aPKbWgDOzKDHRn5wgAU70m1XczKVuXKs5lGrN
         lUFwmUVG5ydEzpJizICbRBy2i8MlYPoI2vfkCnfRySFJAvj0QVIVmCxZNvd4EMN3/joI
         9hCM974y3Fy5NqwEcQh4ZGxenDFHBHzrDWHM6vEjzYIyYHH8AT3hYmZFElsopvLHSiKh
         FMjQ==
X-Gm-Message-State: APjAAAXT7+eAL6Q4MJ2sNt+4ydTd9D0vTEXkyCIzZqqeEWHW6iFrFAaZ
        1kJlaHeyGJER4DqPT8A+jD2+06A=
X-Google-Smtp-Source: APXvYqwtS6VjVKmxi5tHDiqFGjVQlVdDDsSyPEAWS0G2y7mz+oKvglMRQA4VSJekNUsvizEJFKxLSA==
X-Received: by 2002:adf:fd91:: with SMTP id d17mr17434040wrr.340.1581866812145;
        Sun, 16 Feb 2020 07:26:52 -0800 (PST)
Received: from avx2 ([46.53.252.78])
        by smtp.gmail.com with ESMTPSA id c15sm16684165wrt.1.2020.02.16.07.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2020 07:26:51 -0800 (PST)
Date:   Sun, 16 Feb 2020 18:26:49 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] proc: faster open/read/close with "permanent" files
Message-ID: <20200216152649.GA2693@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that "struct proc_ops" exist we can start putting there stuff which
could not fly with VFS "struct file_operations"...

Most of fs/proc/inode.c file is dedicated to make open/read/.../close reliable
in the event of disappearing /proc entries which usually happens if module is
getting removed. Files like /proc/cpuinfo which never disappear simply do not
need such protection.

Save 2 atomic ops, 1 allocation, 1 free per open/read/close sequence for such
"permanent" files.

Enable "permanent" flag for

	/proc/cpuinfo
	/proc/kmsg
	/proc/modules
	/proc/slabinfo
	/proc/stat
	/proc/sysvipc/*
	/proc/swaps

More will come once I figure out foolproof way to prevent out module
authors from marking their stuff "permanent" for performance reasons
when it is not.

This should help with scalability: benchmark is "read /proc/cpuinfo R times
by N threads scattered over the system".

	N	R	t, s (before)	t, s (after)
	-----------------------------------------------------
	64	4096	1.582458	1.530502	-3.2%
	256	4096	6.371926	6.125168	-3.9%
	1024	4096	25.64888	24.47528	-4.6%

Benchmark source:

#include <chrono>
#include <iostream>
#include <thread>
#include <vector>

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

const int NR_CPUS = sysconf(_SC_NPROCESSORS_ONLN);
int N;
const char *filename;
int R;

int xxx = 0;

int glue(int n)
{
	cpu_set_t m;
	CPU_ZERO(&m);
	CPU_SET(n, &m);
	return sched_setaffinity(0, sizeof(cpu_set_t), &m);
}

void f(int n)
{
	glue(n % NR_CPUS);

	while (*(volatile int *)&xxx == 0) {
	}

	for (int i = 0; i < R; i++) {
		int fd = open(filename, O_RDONLY);
		char buf[4096];
		ssize_t rv = read(fd, buf, sizeof(buf));
		asm volatile ("" :: "g" (rv));
		close(fd);
	}
}

int main(int argc, char *argv[])
{
	if (argc < 4) {
		std::cerr << "usage: " << argv[0] << ' ' << "N /proc/filename R\n";
		return 1;
	}

	N = atoi(argv[1]);
	filename = argv[2];
	R = atoi(argv[3]);

	for (int i = 0; i < NR_CPUS; i++) {
		if (glue(i) == 0)
			break;
	}

	std::vector<std::thread> T;
	T.reserve(N);
	for (int i = 0; i < N; i++) {
		T.emplace_back(f, i);
	}

	auto t0 = std::chrono::system_clock::now();
	{
		*(volatile int *)&xxx = 1;
		for (auto& t: T) {
			t.join();
		}
	}
	auto t1 = std::chrono::system_clock::now();
	std::chrono::duration<double> dt = t1 - t0;
	std::cout << dt.count() << '\n';

	return 0;
}

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/cpuinfo.c       |    1 
 fs/proc/generic.c       |   31 +++++++
 fs/proc/inode.c         |  187 +++++++++++++++++++++++++++++++++++-------------
 fs/proc/internal.h      |    6 +
 fs/proc/kmsg.c          |    1 
 fs/proc/stat.c          |    1 
 include/linux/proc_fs.h |   17 ++++
 ipc/util.c              |    1 
 kernel/module.c         |    1 
 mm/slab_common.c        |    1 
 mm/swapfile.c           |    1 
 11 files changed, 194 insertions(+), 54 deletions(-)

--- a/fs/proc/cpuinfo.c
+++ b/fs/proc/cpuinfo.c
@@ -17,6 +17,7 @@ static int cpuinfo_open(struct inode *inode, struct file *file)
 }
 
 static const struct proc_ops cpuinfo_proc_ops = {
+	.proc_flags	= PROC_ENTRY_PERMANENT,
 	.proc_open	= cpuinfo_open,
 	.proc_read	= seq_read,
 	.proc_lseek	= seq_lseek,
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -531,6 +531,13 @@ struct proc_dir_entry *proc_create_reg(const char *name, umode_t mode,
 	return p;
 }
 
+static inline void pde_set_flags(struct proc_dir_entry *pde)
+{
+	if (pde->proc_ops->proc_flags & PROC_ENTRY_PERMANENT) {
+		pde->flags |= PROC_ENTRY_PERMANENT;
+	}
+}
+
 struct proc_dir_entry *proc_create_data(const char *name, umode_t mode,
 		struct proc_dir_entry *parent,
 		const struct proc_ops *proc_ops, void *data)
@@ -541,6 +548,7 @@ struct proc_dir_entry *proc_create_data(const char *name, umode_t mode,
 	if (!p)
 		return NULL;
 	p->proc_ops = proc_ops;
+	pde_set_flags(p);
 	return proc_register(parent, p);
 }
 EXPORT_SYMBOL(proc_create_data);
@@ -572,6 +580,7 @@ static int proc_seq_release(struct inode *inode, struct file *file)
 }
 
 static const struct proc_ops proc_seq_ops = {
+	/* not permanent -- can call into arbitrary seq_operations */
 	.proc_open	= proc_seq_open,
 	.proc_read	= seq_read,
 	.proc_lseek	= seq_lseek,
@@ -602,6 +611,7 @@ static int proc_single_open(struct inode *inode, struct file *file)
 }
 
 static const struct proc_ops proc_single_ops = {
+	/* not permanent -- can call into arbitrary ->single_show */
 	.proc_open	= proc_single_open,
 	.proc_read	= seq_read,
 	.proc_lseek	= seq_lseek,
@@ -662,9 +672,14 @@ void remove_proc_entry(const char *name, struct proc_dir_entry *parent)
 
 	de = pde_subdir_find(parent, fn, len);
 	if (de) {
-		rb_erase(&de->subdir_node, &parent->subdir);
-		if (S_ISDIR(de->mode)) {
-			parent->nlink--;
+		if (unlikely(pde_is_permanent(de))) {
+			WARN(1, "removing permanent /proc entry '%s'", de->name);
+			de = NULL;
+		} else {
+			rb_erase(&de->subdir_node, &parent->subdir);
+			if (S_ISDIR(de->mode)) {
+				parent->nlink--;
+			}
 		}
 	}
 	write_unlock(&proc_subdir_lock);
@@ -700,12 +715,22 @@ int remove_proc_subtree(const char *name, struct proc_dir_entry *parent)
 		write_unlock(&proc_subdir_lock);
 		return -ENOENT;
 	}
+	if (unlikely(pde_is_permanent(root))) {
+		WARN(1, "removing permanent /proc entry '%s/%s'",
+			root->parent->name, root->name);
+		return -EINVAL;
+	}
 	rb_erase(&root->subdir_node, &parent->subdir);
 
 	de = root;
 	while (1) {
 		next = pde_subdir_first(de);
 		if (next) {
+			if (unlikely(pde_is_permanent(root))) {
+				WARN(1, "removing permanent /proc entry '%s/%s'",
+					next->parent->name, next->name);
+				return -EINVAL;
+			}
 			rb_erase(&next->subdir_node, &de->subdir);
 			de = next;
 			continue;
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -195,135 +195,204 @@ void proc_entry_rundown(struct proc_dir_entry *de)
 	spin_unlock(&de->pde_unload_lock);
 }
 
+static loff_t pde_lseek(struct proc_dir_entry *pde, struct file *file, loff_t offset, int whence)
+{
+	typeof_member(struct proc_ops, proc_lseek) lseek;
+
+	lseek = pde->proc_ops->proc_lseek;
+	if (!lseek)
+		lseek = default_llseek;
+	return lseek(file, offset, whence);
+}
+
 static loff_t proc_reg_llseek(struct file *file, loff_t offset, int whence)
 {
 	struct proc_dir_entry *pde = PDE(file_inode(file));
 	loff_t rv = -EINVAL;
-	if (use_pde(pde)) {
-		typeof_member(struct proc_ops, proc_lseek) lseek;
 
-		lseek = pde->proc_ops->proc_lseek;
-		if (!lseek)
-			lseek = default_llseek;
-		rv = lseek(file, offset, whence);
+	if (pde_is_permanent(pde)) {
+		return pde_lseek(pde, file, offset, whence);
+	} else if (use_pde(pde)) {
+		rv = pde_lseek(pde, file, offset, whence);
 		unuse_pde(pde);
 	}
 	return rv;
 }
 
+static ssize_t pde_read(struct proc_dir_entry *pde, struct file *file, char __user *buf, size_t count, loff_t *ppos)
+{
+	typeof_member(struct proc_ops, proc_read) read;
+
+	read = pde->proc_ops->proc_read;
+	if (read)
+		return read(file, buf, count, ppos);
+	return -EIO;
+}
+
 static ssize_t proc_reg_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 {
 	struct proc_dir_entry *pde = PDE(file_inode(file));
 	ssize_t rv = -EIO;
-	if (use_pde(pde)) {
-		typeof_member(struct proc_ops, proc_read) read;
 
-		read = pde->proc_ops->proc_read;
-		if (read)
-			rv = read(file, buf, count, ppos);
+	if (pde_is_permanent(pde)) {
+		return pde_read(pde, file, buf, count, ppos);
+	} else if (use_pde(pde)) {
+		rv = pde_read(pde, file, buf, count, ppos);
 		unuse_pde(pde);
 	}
 	return rv;
 }
 
+static ssize_t pde_write(struct proc_dir_entry *pde, struct file *file, const char __user *buf, size_t count, loff_t *ppos)
+{
+	typeof_member(struct proc_ops, proc_write) write;
+
+	write = pde->proc_ops->proc_write;
+	if (write)
+		return write(file, buf, count, ppos);
+	return -EIO;
+}
+
 static ssize_t proc_reg_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 {
 	struct proc_dir_entry *pde = PDE(file_inode(file));
 	ssize_t rv = -EIO;
-	if (use_pde(pde)) {
-		typeof_member(struct proc_ops, proc_write) write;
 
-		write = pde->proc_ops->proc_write;
-		if (write)
-			rv = write(file, buf, count, ppos);
+	if (pde_is_permanent(pde)) {
+		return pde_write(pde, file, buf, count, ppos);
+	} else if (use_pde(pde)) {
+		rv = pde_write(pde, file, buf, count, ppos);
 		unuse_pde(pde);
 	}
 	return rv;
 }
 
+static __poll_t pde_poll(struct proc_dir_entry *pde, struct file *file, struct poll_table_struct *pts)
+{
+	typeof_member(struct proc_ops, proc_poll) poll;
+
+	poll = pde->proc_ops->proc_poll;
+	if (poll)
+		return poll(file, pts);
+	return DEFAULT_POLLMASK;
+}
+
 static __poll_t proc_reg_poll(struct file *file, struct poll_table_struct *pts)
 {
 	struct proc_dir_entry *pde = PDE(file_inode(file));
 	__poll_t rv = DEFAULT_POLLMASK;
-	if (use_pde(pde)) {
-		typeof_member(struct proc_ops, proc_poll) poll;
 
-		poll = pde->proc_ops->proc_poll;
-		if (poll)
-			rv = poll(file, pts);
+	if (pde_is_permanent(pde)) {
+		return pde_poll(pde, file, pts);
+	} else if (use_pde(pde)) {
+		rv = pde_poll(pde, file, pts);
 		unuse_pde(pde);
 	}
 	return rv;
 }
 
+static long pde_ioctl(struct proc_dir_entry *pde, struct file *file, unsigned int cmd, unsigned long arg)
+{
+	typeof_member(struct proc_ops, proc_ioctl) ioctl;
+
+	ioctl = pde->proc_ops->proc_ioctl;
+	if (ioctl)
+		return ioctl(file, cmd, arg);
+	return -ENOTTY;
+}
+
 static long proc_reg_unlocked_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct proc_dir_entry *pde = PDE(file_inode(file));
 	long rv = -ENOTTY;
-	if (use_pde(pde)) {
-		typeof_member(struct proc_ops, proc_ioctl) ioctl;
 
-		ioctl = pde->proc_ops->proc_ioctl;
-		if (ioctl)
-			rv = ioctl(file, cmd, arg);
+	if (pde_is_permanent(pde)) {
+		return pde_ioctl(pde, file, cmd, arg);
+	} else if (use_pde(pde)) {
+		rv = pde_ioctl(pde, file, cmd, arg);
 		unuse_pde(pde);
 	}
 	return rv;
 }
 
 #ifdef CONFIG_COMPAT
+static long pde_compat_ioctl(struct proc_dir_entry *pde, struct file *file, unsigned int cmd, unsigned long arg)
+{
+	typeof_member(struct proc_ops, proc_compat_ioctl) compat_ioctl;
+
+	compat_ioctl = pde->proc_ops->proc_compat_ioctl;
+	if (compat_ioctl)
+		return compat_ioctl(file, cmd, arg);
+	return -ENOTTY;
+}
+
 static long proc_reg_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct proc_dir_entry *pde = PDE(file_inode(file));
 	long rv = -ENOTTY;
-	if (use_pde(pde)) {
-		typeof_member(struct proc_ops, proc_compat_ioctl) compat_ioctl;
-
-		compat_ioctl = pde->proc_ops->proc_compat_ioctl;
-		if (compat_ioctl)
-			rv = compat_ioctl(file, cmd, arg);
+	if (pde_is_permanent(pde)) {
+		return pde_compat_ioctl(pde, file, cmd, arg);
+	} else if (use_pde(pde)) {
+		rv = pde_compat_ioctl(pde, file, cmd, arg);
 		unuse_pde(pde);
 	}
 	return rv;
 }
 #endif
 
+static int pde_mmap(struct proc_dir_entry *pde, struct file *file, struct vm_area_struct *vma)
+{
+	typeof_member(struct proc_ops, proc_mmap) mmap;
+
+	mmap = pde->proc_ops->proc_mmap;
+	if (mmap)
+		return mmap(file, vma);
+	return -EIO;
+}
+
 static int proc_reg_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct proc_dir_entry *pde = PDE(file_inode(file));
 	int rv = -EIO;
-	if (use_pde(pde)) {
-		typeof_member(struct proc_ops, proc_mmap) mmap;
 
-		mmap = pde->proc_ops->proc_mmap;
-		if (mmap)
-			rv = mmap(file, vma);
+	if (pde_is_permanent(pde)) {
+		return pde_mmap(pde, file, vma);
+	} else if (use_pde(pde)) {
+		rv = pde_mmap(pde, file, vma);
 		unuse_pde(pde);
 	}
 	return rv;
 }
 
 static unsigned long
-proc_reg_get_unmapped_area(struct file *file, unsigned long orig_addr,
+pde_get_unmapped_area(struct proc_dir_entry *pde, struct file *file, unsigned long orig_addr,
 			   unsigned long len, unsigned long pgoff,
 			   unsigned long flags)
 {
-	struct proc_dir_entry *pde = PDE(file_inode(file));
-	unsigned long rv = -EIO;
-
-	if (use_pde(pde)) {
-		typeof_member(struct proc_ops, proc_get_unmapped_area) get_area;
+	typeof_member(struct proc_ops, proc_get_unmapped_area) get_area;
 
-		get_area = pde->proc_ops->proc_get_unmapped_area;
+	get_area = pde->proc_ops->proc_get_unmapped_area;
 #ifdef CONFIG_MMU
-		if (!get_area)
-			get_area = current->mm->get_unmapped_area;
+	if (!get_area)
+		get_area = current->mm->get_unmapped_area;
 #endif
+	if (get_area)
+		return get_area(file, orig_addr, len, pgoff, flags);
+	return orig_addr;
+}
+
+static unsigned long
+proc_reg_get_unmapped_area(struct file *file, unsigned long orig_addr,
+			   unsigned long len, unsigned long pgoff,
+			   unsigned long flags)
+{
+	struct proc_dir_entry *pde = PDE(file_inode(file));
+	unsigned long rv = -EIO;
 
-		if (get_area)
-			rv = get_area(file, orig_addr, len, pgoff, flags);
-		else
-			rv = orig_addr;
+	if (pde_is_permanent(pde)) {
+		return pde_get_unmapped_area(pde, file, orig_addr, len, pgoff, flags);
+	} else if (use_pde(pde)) {
+		rv = pde_get_unmapped_area(pde, file, orig_addr, len, pgoff, flags);
 		unuse_pde(pde);
 	}
 	return rv;
@@ -337,6 +406,13 @@ static int proc_reg_open(struct inode *inode, struct file *file)
 	typeof_member(struct proc_ops, proc_release) release;
 	struct pde_opener *pdeo;
 
+	if (pde_is_permanent(pde)) {
+		open = pde->proc_ops->proc_open;
+		if (open)
+			rv = open(inode, file);
+		return rv;
+	}
+
 	/*
 	 * Ensure that
 	 * 1) PDE's ->release hook will be called no matter what
@@ -386,6 +462,17 @@ static int proc_reg_release(struct inode *inode, struct file *file)
 {
 	struct proc_dir_entry *pde = PDE(inode);
 	struct pde_opener *pdeo;
+
+	if (pde_is_permanent(pde)) {
+		typeof_member(struct proc_ops, proc_release) release;
+
+		release = pde->proc_ops->proc_release;
+		if (release) {
+			return release(inode, file);
+		}
+		return 0;
+	}
+
 	spin_lock(&pde->pde_unload_lock);
 	list_for_each_entry(pdeo, &pde->pde_openers, lh) {
 		if (pdeo->file == file) {
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -61,6 +61,7 @@ struct proc_dir_entry {
 	struct rb_node subdir_node;
 	char *name;
 	umode_t mode;
+	u8 flags;
 	u8 namelen;
 	char inline_name[];
 } __randomize_layout;
@@ -73,6 +74,11 @@ struct proc_dir_entry {
 	0)
 #define SIZEOF_PDE_INLINE_NAME (SIZEOF_PDE - sizeof(struct proc_dir_entry))
 
+static inline bool pde_is_permanent(const struct proc_dir_entry *pde)
+{
+	return pde->flags & PROC_ENTRY_PERMANENT;
+}
+
 extern struct kmem_cache *proc_dir_entry_cache;
 void pde_free(struct proc_dir_entry *pde);
 
--- a/fs/proc/kmsg.c
+++ b/fs/proc/kmsg.c
@@ -50,6 +50,7 @@ static __poll_t kmsg_poll(struct file *file, poll_table *wait)
 
 
 static const struct proc_ops kmsg_proc_ops = {
+	.proc_flags	= PROC_ENTRY_PERMANENT,
 	.proc_read	= kmsg_read,
 	.proc_poll	= kmsg_poll,
 	.proc_open	= kmsg_open,
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -224,6 +224,7 @@ static int stat_open(struct inode *inode, struct file *file)
 }
 
 static const struct proc_ops stat_proc_ops = {
+	.proc_flags	= PROC_ENTRY_PERMANENT,
 	.proc_open	= stat_open,
 	.proc_read	= seq_read,
 	.proc_lseek	= seq_lseek,
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -5,6 +5,7 @@
 #ifndef _LINUX_PROC_FS_H
 #define _LINUX_PROC_FS_H
 
+#include <linux/compiler.h>
 #include <linux/types.h>
 #include <linux/fs.h>
 
@@ -12,7 +13,21 @@ struct proc_dir_entry;
 struct seq_file;
 struct seq_operations;
 
+enum {
+	/*
+	 * All /proc entries using this ->proc_ops instance are never removed.
+	 *
+	 * If in doubt, ignore this flag.
+	 */
+#ifdef MODULE
+	PROC_ENTRY_PERMANENT = 0U,
+#else
+	PROC_ENTRY_PERMANENT = 1U << 0,
+#endif
+};
+
 struct proc_ops {
+	unsigned int proc_flags;
 	int	(*proc_open)(struct inode *, struct file *);
 	ssize_t	(*proc_read)(struct file *, char __user *, size_t, loff_t *);
 	ssize_t	(*proc_write)(struct file *, const char __user *, size_t, loff_t *);
@@ -25,7 +40,7 @@ struct proc_ops {
 #endif
 	int	(*proc_mmap)(struct file *, struct vm_area_struct *);
 	unsigned long (*proc_get_unmapped_area)(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
-};
+} __randomize_layout;
 
 #ifdef CONFIG_PROC_FS
 
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -885,6 +885,7 @@ static int sysvipc_proc_release(struct inode *inode, struct file *file)
 }
 
 static const struct proc_ops sysvipc_proc_ops = {
+	.proc_flags	= PROC_ENTRY_PERMANENT,
 	.proc_open	= sysvipc_proc_open,
 	.proc_read	= seq_read,
 	.proc_lseek	= seq_lseek,
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -4355,6 +4355,7 @@ static int modules_open(struct inode *inode, struct file *file)
 }
 
 static const struct proc_ops modules_proc_ops = {
+	.proc_flags	= PROC_ENTRY_PERMANENT,
 	.proc_open	= modules_open,
 	.proc_read	= seq_read,
 	.proc_lseek	= seq_lseek,
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1581,6 +1581,7 @@ static int slabinfo_open(struct inode *inode, struct file *file)
 }
 
 static const struct proc_ops slabinfo_proc_ops = {
+	.proc_flags	= PROC_ENTRY_PERMANENT,
 	.proc_open	= slabinfo_open,
 	.proc_read	= seq_read,
 	.proc_write	= slabinfo_write,
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2797,6 +2797,7 @@ static int swaps_open(struct inode *inode, struct file *file)
 }
 
 static const struct proc_ops swaps_proc_ops = {
+	.proc_flags	= PROC_ENTRY_PERMANENT,
 	.proc_open	= swaps_open,
 	.proc_read	= seq_read,
 	.proc_lseek	= seq_lseek,
