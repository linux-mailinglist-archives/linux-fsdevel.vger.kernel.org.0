Return-Path: <linux-fsdevel+bounces-18704-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E848BB8BD
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 02:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC538B22069
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 00:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB53710A3D;
	Sat,  4 May 2024 00:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WrZP0Xur"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D726F9CC;
	Sat,  4 May 2024 00:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714782615; cv=none; b=ll/IaOKf2b7sY1thk9MRAe20gBFz3hGC8dzEqUioVGhOFgXAmjBtKXda9HwDh1oHaXShD3APfDAEYEDhXUaCRbJYa+gPbxNaltmA9lYg/84f2H4wIWf4DRD0TNCmcE6aWEf26Ir8AYMY3q+y7GdpSsZIZYJF0b6RYSeFTw0Z+Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714782615; c=relaxed/simple;
	bh=bA1/zohcH7zJsizG/omlxjWAua+BN8I1Y4tME/v2yWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L8t+biKDGVUDAoxOA4J6xyBJJD1n+Q7vcEzxN4+k3XYYCf2y5MT876Zj95PstU9uxBlGbixBX51s//ZQFL19kNSHdcsysqLltRuAthPsaj/Rk1am0Lqyl9hI3dNezIyRA61l0WPp5CDuqW1w+mx0wZ9Ln8nJy9JKWRSpPw4ZNyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WrZP0Xur; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A6F0C4AF1A;
	Sat,  4 May 2024 00:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714782614;
	bh=bA1/zohcH7zJsizG/omlxjWAua+BN8I1Y4tME/v2yWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WrZP0Xurp/ZbvPWVA9809rCs+L7l7mQdgZ6yIM7b3QF7cm1v8nXt0fYOnCQot2oYV
	 Htd5hqWJbw/65G5zv7QzELJ1Bvtnm7BYXkZvSA3tEF4KIdTGk2Dk1b3JJV2Cb3JuB6
	 zpi/B66/gqNai2l5MacYx/9thT+2dV7eazaB5jcGfLFlFKkbzp6DAzwWCAmT6+69Fl
	 ZoEWzDkmQ/ilrjCyJOy9DvQp3Kqxrgk22MYfhSewopFKprmBeeGEq7It8VkQzvdQLB
	 /518wopvnYHsQ7bGeYM666wy2ecaLcENtma7+7VIQHj1kTX+FXzxhPuwXxqXWh/tgY
	 HoNfZSLtDEqJA==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	gregkh@linuxfoundation.org,
	linux-mm@kvack.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH 2/5] fs/procfs: implement efficient VMA querying API for /proc/<pid>/maps
Date: Fri,  3 May 2024 17:30:03 -0700
Message-ID: <20240504003006.3303334-3-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240504003006.3303334-1-andrii@kernel.org>
References: <20240504003006.3303334-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

/proc/<pid>/maps file is extremely useful in practice for various tasks
involving figuring out process memory layout, what files are backing any
given memory range, etc. One important class of applications that
absolutely rely on this are profilers/stack symbolizers. They would
normally capture stack trace containing absolute memory addresses of
some functions, and would then use /proc/<pid>/maps file to file
corresponding backing ELF files, file offsets within them, and then
continue from there to get yet more information (ELF symbols, DWARF
information) to get human-readable symbolic information.

As such, there are both performance and correctness requirement
involved. This address to VMA information translation has to be done as
efficiently as possible, but also not miss any VMA (especially in the
case of loading/unloading shared libraries).

Unfortunately, for all the /proc/<pid>/maps file universality and
usefulness, it doesn't fit the above 100%.

First, it's text based, which makes its programmatic use from
applications and libraries unnecessarily cumbersome and slow due to the
need to do text parsing to get necessary pieces of information.

Second, it's main purpose is to emit all VMAs sequentially, but in
practice captured addresses would fall only into a small subset of all
process' VMAs, mainly containing executable text. Yet, library would
need to parse most or all of the contents to find needed VMAs, as there
is no way to skip VMAs that are of no use. Efficient library can do the
linear pass and it is still relatively efficient, but it's definitely an
overhead that can be avoided, if there was a way to do more targeted
querying of the relevant VMA information.

Another problem when writing generic stack trace symbolization library
is an unfortunate performance-vs-correctness tradeoff that needs to be
made. Library has to make a decision to either cache parsed contents of
/proc/<pid>/maps for service future requests (if application requests to
symbolize another set of addresses, captured at some later time, which
is typical for periodic/continuous profiling cases) to avoid higher
costs of needed to re-parse this file or caching the contents in memory
to speed up future requests. In the former case, more memory is used for
the cache and there is a risk of getting stale data if application
loaded/unloaded shared libraries, or otherwise changed its set of VMAs
through additiona mmap() calls (and other means of altering memory
address space). In the latter case, it's the performance hit that comes
from re-opening the file and re-reading/re-parsing its contents all over
again.

This patch aims to solve this problem by providing a new API built on
top of /proc/<pid>/maps. It is ioctl()-based and built as a binary
interface, avoiding the cost and awkwardness of textual representation
for programmatic use. It's designed to be extensible and
forward/backward compatible by including user-specified field size and
using copy_struct_from_user() approach. But, most importantly, it allows
to do point queries for specific single address, specified by user. And
this is done efficiently using VMA iterator.

User has a choice to pick either getting VMA that covers provided
address or -ENOENT if none is found (exact, least surprising, case). Or,
with an extra query flag (PROCFS_PROCMAP_EXACT_OR_NEXT_VMA), they can
get either VMA that covers the address (if there is one), or the closest
next VMA (i.e., VMA with the smallest vm_start > addr). The later allows
more efficient use, but, given it could be a surprising behavior,
requires an explicit opt-in.

Basing this ioctl()-based API on top of /proc/<pid>/maps's FD makes
sense given it's querying the same set of VMA data. All the permissions
checks performed on /proc/<pid>/maps opening fit here as well.
ioctl-based implementation is fetching remembered mm_struct reference,
but otherwise doesn't interfere with seq_file-based implementation of
/proc/<pid>/maps textual interface, and so could be used together or
independently without paying any price for that.

There is one extra thing that /proc/<pid>/maps doesn't currently
provide, and that's an ability to fetch ELF build ID, if present. User
has control over whether this piece of information is requested or not
by either setting build_id_size field to zero or non-zero maximum buffer
size they provided through build_id_addr field (which encodes user
pointer as __u64 field).

The need to get ELF build ID reliably is an important aspect when
dealing with profiling and stack trace symbolization, and
/proc/<pid>/maps textual representation doesn't help with this,
requiring applications to open underlying ELF binary through
/proc/<pid>/map_files/<start>-<end> symlink, which adds an extra
permissions implications due giving a full access to the binary from
(potentially) another process, while all application is interested in is
build ID. Giving an ability to request just build ID doesn't introduce
any additional security concerns, on top of what /proc/<pid>/maps is
already concerned with, simplifying the overall logic.

Kernel already implements build ID fetching, which is used from BPF
subsystem. We are reusing this code here, but plan a follow up changes
to make it work better under more relaxed assumption (compared to what
existing code assumes) of being called from user process context, in
which page faults are allowed. BPF-specific implementation currently
bails out if necessary part of ELF file is not paged in, all due to
extra BPF-specific restrictions (like the need to fetch build ID in
restrictive contexts such as NMI handler).

Note also, that fetching VMA name (e.g., backing file path, or special
hard-coded or user-provided names) is optional just like build ID. If
user sets vma_name_size to zero, kernel code won't attempt to retrieve
it, saving resources.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 fs/proc/task_mmu.c      | 165 ++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/fs.h |  32 ++++++++
 2 files changed, 197 insertions(+)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 8e503a1635b7..cb7b1ff1a144 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -22,6 +22,7 @@
 #include <linux/pkeys.h>
 #include <linux/minmax.h>
 #include <linux/overflow.h>
+#include <linux/buildid.h>
 
 #include <asm/elf.h>
 #include <asm/tlb.h>
@@ -375,11 +376,175 @@ static int pid_maps_open(struct inode *inode, struct file *file)
 	return do_maps_open(inode, file, &proc_pid_maps_op);
 }
 
+static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
+{
+	struct procfs_procmap_query karg;
+	struct vma_iterator iter;
+	struct vm_area_struct *vma;
+	struct mm_struct *mm;
+	const char *name = NULL;
+	char build_id_buf[BUILD_ID_SIZE_MAX], *name_buf = NULL;
+	__u64 usize;
+	int err;
+
+	if (copy_from_user(&usize, (void __user *)uarg, sizeof(usize)))
+		return -EFAULT;
+	if (usize > PAGE_SIZE)
+		return -E2BIG;
+	if (usize < offsetofend(struct procfs_procmap_query, query_addr))
+		return -EINVAL;
+	err = copy_struct_from_user(&karg, sizeof(karg), uarg, usize);
+	if (err)
+		return err;
+
+	if (karg.query_flags & ~PROCFS_PROCMAP_EXACT_OR_NEXT_VMA)
+		return -EINVAL;
+	if (!!karg.vma_name_size != !!karg.vma_name_addr)
+		return -EINVAL;
+	if (!!karg.build_id_size != !!karg.build_id_addr)
+		return -EINVAL;
+
+	mm = priv->mm;
+	if (!mm || !mmget_not_zero(mm))
+		return -ESRCH;
+	if (mmap_read_lock_killable(mm)) {
+		mmput(mm);
+		return -EINTR;
+	}
+
+	vma_iter_init(&iter, mm, karg.query_addr);
+	vma = vma_next(&iter);
+	if (!vma) {
+		err = -ENOENT;
+		goto out;
+	}
+	/* user wants covering VMA, not the closest next one */
+	if (!(karg.query_flags & PROCFS_PROCMAP_EXACT_OR_NEXT_VMA) &&
+	    vma->vm_start > karg.query_addr) {
+		err = -ENOENT;
+		goto out;
+	}
+
+	karg.vma_start = vma->vm_start;
+	karg.vma_end = vma->vm_end;
+
+	if (vma->vm_file) {
+		const struct inode *inode = file_user_inode(vma->vm_file);
+
+		karg.vma_offset = ((__u64)vma->vm_pgoff) << PAGE_SHIFT;
+		karg.dev_major = MAJOR(inode->i_sb->s_dev);
+		karg.dev_minor = MINOR(inode->i_sb->s_dev);
+		karg.inode = inode->i_ino;
+	} else {
+		karg.vma_offset = 0;
+		karg.dev_major = 0;
+		karg.dev_minor = 0;
+		karg.inode = 0;
+	}
+
+	karg.vma_flags = 0;
+	if (vma->vm_flags & VM_READ)
+		karg.vma_flags |= PROCFS_PROCMAP_VMA_READABLE;
+	if (vma->vm_flags & VM_WRITE)
+		karg.vma_flags |= PROCFS_PROCMAP_VMA_WRITABLE;
+	if (vma->vm_flags & VM_EXEC)
+		karg.vma_flags |= PROCFS_PROCMAP_VMA_EXECUTABLE;
+	if (vma->vm_flags & VM_MAYSHARE)
+		karg.vma_flags |= PROCFS_PROCMAP_VMA_SHARED;
+
+	if (karg.build_id_size) {
+		__u32 build_id_sz = BUILD_ID_SIZE_MAX;
+
+		err = build_id_parse(vma, build_id_buf, &build_id_sz);
+		if (!err) {
+			if (karg.build_id_size < build_id_sz) {
+				err = -ENAMETOOLONG;
+				goto out;
+			}
+			karg.build_id_size = build_id_sz;
+		}
+	}
+
+	if (karg.vma_name_size) {
+		size_t name_buf_sz = min_t(size_t, PATH_MAX, karg.vma_name_size);
+		const struct path *path;
+		const char *name_fmt;
+		size_t name_sz = 0;
+
+		get_vma_name(vma, &path, &name, &name_fmt);
+
+		if (path || name_fmt || name) {
+			name_buf = kmalloc(name_buf_sz, GFP_KERNEL);
+			if (!name_buf) {
+				err = -ENOMEM;
+				goto out;
+			}
+		}
+		if (path) {
+			name = d_path(path, name_buf, name_buf_sz);
+			if (IS_ERR(name)) {
+				err = PTR_ERR(name);
+				goto out;
+			}
+			name_sz = name_buf + name_buf_sz - name;
+		} else if (name || name_fmt) {
+			name_sz = 1 + snprintf(name_buf, name_buf_sz, name_fmt ?: "%s", name);
+			name = name_buf;
+		}
+		if (name_sz > name_buf_sz) {
+			err = -ENAMETOOLONG;
+			goto out;
+		}
+		karg.vma_name_size = name_sz;
+	}
+
+	/* unlock and put mm_struct before copying data to user */
+	mmap_read_unlock(mm);
+	mmput(mm);
+
+	if (karg.vma_name_size && copy_to_user((void __user *)karg.vma_name_addr,
+					       name, karg.vma_name_size)) {
+		kfree(name_buf);
+		return -EFAULT;
+	}
+	kfree(name_buf);
+
+	if (karg.build_id_size && copy_to_user((void __user *)karg.build_id_addr,
+					       build_id_buf, karg.build_id_size))
+		return -EFAULT;
+
+	if (copy_to_user(uarg, &karg, min_t(size_t, sizeof(karg), usize)))
+		return -EFAULT;
+
+	return 0;
+
+out:
+	mmap_read_unlock(mm);
+	mmput(mm);
+	kfree(name_buf);
+	return err;
+}
+
+static long procfs_procmap_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct seq_file *seq = file->private_data;
+	struct proc_maps_private *priv = seq->private;
+
+	switch (cmd) {
+	case PROCFS_PROCMAP_QUERY:
+		return do_procmap_query(priv, (void __user *)arg);
+	default:
+		return -ENOIOCTLCMD;
+	}
+}
+
 const struct file_operations proc_pid_maps_operations = {
 	.open		= pid_maps_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
 	.release	= proc_map_release,
+	.unlocked_ioctl = procfs_procmap_ioctl,
+	.compat_ioctl	= procfs_procmap_ioctl,
 };
 
 /*
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 45e4e64fd664..fe8924a8d916 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -393,4 +393,36 @@ struct pm_scan_arg {
 	__u64 return_mask;
 };
 
+/* /proc/<pid>/maps ioctl */
+#define PROCFS_IOCTL_MAGIC 0x9f
+#define PROCFS_PROCMAP_QUERY	_IOWR(PROCFS_IOCTL_MAGIC, 1, struct procfs_procmap_query)
+
+enum procmap_query_flags {
+	PROCFS_PROCMAP_EXACT_OR_NEXT_VMA = 0x01,
+};
+
+enum procmap_vma_flags {
+	PROCFS_PROCMAP_VMA_READABLE = 0x01,
+	PROCFS_PROCMAP_VMA_WRITABLE = 0x02,
+	PROCFS_PROCMAP_VMA_EXECUTABLE = 0x04,
+	PROCFS_PROCMAP_VMA_SHARED = 0x08,
+};
+
+struct procfs_procmap_query {
+	__u64 size;
+	__u64 query_flags;		/* in */
+	__u64 query_addr;		/* in */
+	__u64 vma_start;		/* out */
+	__u64 vma_end;			/* out */
+	__u64 vma_flags;		/* out */
+	__u64 vma_offset;		/* out */
+	__u64 inode;			/* out */
+	__u32 dev_major;		/* out */
+	__u32 dev_minor;		/* out */
+	__u32 vma_name_size;		/* in/out */
+	__u32 build_id_size;		/* in/out */
+	__u64 vma_name_addr;		/* in */
+	__u64 build_id_addr;		/* in */
+};
+
 #endif /* _UAPI_LINUX_FS_H */
-- 
2.43.0


