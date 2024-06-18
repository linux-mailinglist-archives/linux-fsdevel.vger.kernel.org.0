Return-Path: <linux-fsdevel+bounces-21903-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A6190DF44
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2024 00:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E45AB20548
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 22:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9260818A955;
	Tue, 18 Jun 2024 22:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uClV9QVe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CEE186E39;
	Tue, 18 Jun 2024 22:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718750739; cv=none; b=rgl5a7TPt1LcqW82lPGzyWX8e1offUdvZADNeI3G12rqSAmiZB89LtLfWW/1LWzL94HL0RZIiMfR1Vr4Qx4+fc2X+5fzlPJIIS2dP0iYSBpBREHNg5dX44TtCPRJCAI8vjSDVjaM5vIfpnGg/jvtx2t+s/LqJZGaJJ2NTeu9QOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718750739; c=relaxed/simple;
	bh=dujWXwBtdE1rUgXOPw7cuUswvyKsdGxgOw5pbZroWtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cHGCktEqjO5m0ivgArMcdJmaNpGhTQrZUFhYl6rmVF8fYXf+OgbndMFQBDpWEYk54GNRvTMCWpSu3H1P+tkfiegj2hLhy0K/2Q5IzDzu/Bgg4HNCsJgAVh/vLYAdqzHpiKQTmRi/r2/giv9Obz0gOI7Z+IfE2xMW/2lz6Ov4SqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uClV9QVe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23272C32786;
	Tue, 18 Jun 2024 22:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718750738;
	bh=dujWXwBtdE1rUgXOPw7cuUswvyKsdGxgOw5pbZroWtk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uClV9QVeqnWs3Bvp1YQVpJiEOwnBjkTjImCIVhbKbmNGl4MICEixB+BMjnNEUYjeu
	 0ZuY7rDytNBjBK5JJ3nzZLVtnZaffzw24RtsuOznpeo3l4kikYoaV5IawT870YNLS6
	 sZBj87OSATkFTJaco2ClArz+uojvXV035RWUVK1hExQT4M43rkFt+6Vms0KZNODsxR
	 W9yJ+mBvPaZO5GDLhubo/dPWuzVKBzoceiHfD19R6zxxX0HkiKYe1YoVVaa3SiCQtV
	 UMHntcOluo1rJb4SY+Hjht9CHD8jK68mRwGvR7IPjvLu4G+QR+3OoI/JsapihLmOB4
	 Jul94qm+rvkpA==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	gregkh@linuxfoundation.org,
	linux-mm@kvack.org,
	liam.howlett@oracle.com,
	surenb@google.com,
	rppt@kernel.org,
	adobriyan@gmail.com,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v5 2/6] fs/procfs: implement efficient VMA querying API for /proc/<pid>/maps
Date: Tue, 18 Jun 2024 15:45:21 -0700
Message-ID: <20240618224527.3685213-3-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618224527.3685213-1-andrii@kernel.org>
References: <20240618224527.3685213-1-andrii@kernel.org>
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
absolutely rely on this are profilers/stack symbolizers (perf tool being one
of them). Patterns of use differ, but they generally would fall into two
categories.

In on-demand pattern, a profiler/symbolizer would normally capture stack
trace containing absolute memory addresses of some functions, and would
then use /proc/<pid>/maps file to find corresponding backing ELF files
(normally, only executable VMAs are of interest), file offsets within
them, and then continue from there to get yet more information (ELF
symbols, DWARF information) to get human-readable symbolic information.
This pattern is used by Meta's fleet-wide profiler, as one example.

In preprocessing pattern, application doesn't know the set of addresses
of interest, so it has to fetch all relevant VMAs (again, probably only
executable ones), store or cache them, then proceed with profiling and
stack trace capture. Once done, it would do symbolization based on
stored VMA information. This can happen at much later point in time.
This patterns is used by perf tool, as an example.

In either case, there are both performance and correctness requirement
involved. This address to VMA information translation has to be done as
efficiently as possible, but also not miss any VMA (especially in the
case of loading/unloading shared libraries). In practice, correctness
can't be guaranteed (due to process dying before VMA data can be
captured, or shared library being unloaded, etc), but any effort to
maximize the chance of finding the VMA is appreciated.

Unfortunately, for all the /proc/<pid>/maps file universality and
usefulness, it doesn't fit the above use cases 100%.

First, it's main purpose is to emit all VMAs sequentially, but in
practice captured addresses would fall only into a smaller subset of all
process' VMAs, mainly containing executable text. Yet, library would
need to parse most or all of the contents to find needed VMAs, as there
is no way to skip VMAs that are of no use. Efficient library can do the
linear pass and it is still relatively efficient, but it's definitely an
overhead that can be avoided, if there was a way to do more targeted
querying of the relevant VMA information.

Second, it's a text based interface, which makes its programmatic use from
applications and libraries more cumbersome and inefficient due to the
need to handle text parsing to get necessary pieces of information. The
overhead is actually payed both by kernel, formatting originally binary
VMA data into text, and then by user space application, parsing it back
into binary data for further use.

For the on-demand pattern of usage, described above, another problem
when writing generic stack trace symbolization library is an unfortunate
performance-vs-correctness tradeoff that needs to be made. Library has
to make a decision to either cache parsed contents of /proc/<pid>/maps
(after initial processing) to service future requests (if application
requests to symbolize another set of addresses (for the same process),
captured at some later time, which is typical for periodic/continuous
profiling cases) to avoid higher costs of re-parsing this file. Or it
has to choose to cache the contents in memory to speed up future
requests. In the former case, more memory is used for the cache and
there is a risk of getting stale data if application loads or unloads
shared libraries, or otherwise changed its set of VMAs somehow, e.g.,
through additional mmap() calls.  In the latter case, it's the
performance hit that comes from re-opening the file and re-parsing its
contents all over again.

This patch aims to solve this problem by providing a new API built on
top of /proc/<pid>/maps. It's meant to address both non-selectiveness
and text nature of /proc/<pid>/maps, by giving user more control of what
sort of VMA(s) needs to be queried, and being binary-based interface
eliminates the overhead of text formatting (on kernel side) and parsing
(on user space side).

It's also designed to be extensible and forward/backward compatible by
including required struct size field, which user has to provide. We use
established copy_struct_from_user() approach to handle extensibility.

User has a choice to pick either getting VMA that covers provided
address or -ENOENT if none is found (exact, least surprising, case). Or,
with an extra query flag (PROCMAP_QUERY_COVERING_OR_NEXT_VMA), they can
get either VMA that covers the address (if there is one), or the closest
next VMA (i.e., VMA with the smallest vm_start > addr). The latter allows
more efficient use, but, given it could be a surprising behavior,
requires an explicit opt-in.

There is another query flag that is useful for some use cases.
PROCMAP_QUERY_FILE_BACKED_VMA instructs this API to only return
file-backed VMAs. Combining this with PROCMAP_QUERY_COVERING_OR_NEXT_VMA
makes it possible to efficiently iterate only file-backed VMAs of the
process, which is what profilers/symbolizers are normally interested in.

All the above querying flags can be combined with (also optional) set of
desired VMA permissions flags. This allows to, for example, iterate only
an executable subset of VMAs, which is what preprocessing pattern, used
by perf tool, would benefit from, as the assumption is that captured
stack traces would have addresses of executable code. This saves time by
skipping non-executable VMAs altogether efficienty.

All these querying flags (modifiers) are orthogonal and can be combined
in a semantically meaningful and natural way.

Basing this ioctl()-based API on top of /proc/<pid>/maps's FD makes
sense given it's querying the same set of VMA data. It's also benefitial
because permission checks for /proc/<pid>/maps is performed at open time
once, and the actual data read of text contents of /proc/<pid>/maps is
done without further permission checks. We piggyback on this pattern
with ioctl()-based API as well, as that's a desired property. Both for
performance reasons, but also for security and flexibility reasons.

Allowing application to open an FD for /proc/self/maps without any extra
capabilities, and then passing it to some sort of profiling agent
through Unix-domain socket, would allow such profiling agent to not
require some of the capabilities that are otherwise expected when
opening /proc/<pid>/maps file for *another* process. This is a desirable
property for some more restricted setups.

This new ioctl-based implementation doesn't interfere with
seq_file-based implementation of /proc/<pid>/maps textual interface, and
so could be used together or independently without paying any price for
that.

Note also, that fetching VMA name (e.g., backing file path, or special
hard-coded or user-provided names) is optional just like build ID. If
user sets vma_name_size to zero, kernel code won't attempt to retrieve
it, saving resources.

Earlier versions of this patch set were adding per-VMA locking, which is
why we have a code structure that is ready for abstracting mmap_lock vs
vm_lock differences (query_vma_setup(), query_vma_teardown(), and
query_vma_find_by_addr()), but given anon_vma_name() is not yet compatible
with per-VMA locking, initial implementation sticks to using only
mmap_lock for now. It will be easy to add back per-VMA locking once all
the pieces are ready later on. Which is why we keep existing code
structure with setup/teardown/query helper functions.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 fs/proc/task_mmu.c      | 235 ++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/fs.h | 130 +++++++++++++++++++++-
 2 files changed, 364 insertions(+), 1 deletion(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 507b7dc7c4c8..674405b99d0d 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -375,11 +375,246 @@ static int pid_maps_open(struct inode *inode, struct file *file)
 	return do_maps_open(inode, file, &proc_pid_maps_op);
 }
 
+#define PROCMAP_QUERY_VMA_FLAGS (				\
+		PROCMAP_QUERY_VMA_READABLE |			\
+		PROCMAP_QUERY_VMA_WRITABLE |			\
+		PROCMAP_QUERY_VMA_EXECUTABLE |			\
+		PROCMAP_QUERY_VMA_SHARED			\
+)
+
+#define PROCMAP_QUERY_VALID_FLAGS_MASK (			\
+		PROCMAP_QUERY_COVERING_OR_NEXT_VMA |		\
+		PROCMAP_QUERY_FILE_BACKED_VMA |			\
+		PROCMAP_QUERY_VMA_FLAGS				\
+)
+
+static int query_vma_setup(struct mm_struct *mm)
+{
+	return mmap_read_lock_killable(mm);
+}
+
+static void query_vma_teardown(struct mm_struct *mm, struct vm_area_struct *vma)
+{
+	mmap_read_unlock(mm);
+}
+
+static struct vm_area_struct *query_vma_find_by_addr(struct mm_struct *mm, unsigned long addr)
+{
+	return find_vma(mm, addr);
+}
+
+static struct vm_area_struct *query_matching_vma(struct mm_struct *mm,
+						 unsigned long addr, u32 flags)
+{
+	struct vm_area_struct *vma;
+
+next_vma:
+	vma = query_vma_find_by_addr(mm, addr);
+	if (!vma)
+		goto no_vma;
+
+	/* user requested only file-backed VMA, keep iterating */
+	if ((flags & PROCMAP_QUERY_FILE_BACKED_VMA) && !vma->vm_file)
+		goto skip_vma;
+
+	/* VMA permissions should satisfy query flags */
+	if (flags & PROCMAP_QUERY_VMA_FLAGS) {
+		u32 perm = 0;
+
+		if (flags & PROCMAP_QUERY_VMA_READABLE)
+			perm |= VM_READ;
+		if (flags & PROCMAP_QUERY_VMA_WRITABLE)
+			perm |= VM_WRITE;
+		if (flags & PROCMAP_QUERY_VMA_EXECUTABLE)
+			perm |= VM_EXEC;
+		if (flags & PROCMAP_QUERY_VMA_SHARED)
+			perm |= VM_MAYSHARE;
+
+		if ((vma->vm_flags & perm) != perm)
+			goto skip_vma;
+	}
+
+	/* found covering VMA or user is OK with the matching next VMA */
+	if ((flags & PROCMAP_QUERY_COVERING_OR_NEXT_VMA) || vma->vm_start <= addr)
+		return vma;
+
+skip_vma:
+	/*
+	 * If the user needs closest matching VMA, keep iterating.
+	 */
+	addr = vma->vm_end;
+	if (flags & PROCMAP_QUERY_COVERING_OR_NEXT_VMA)
+		goto next_vma;
+no_vma:
+	return ERR_PTR(-ENOENT);
+}
+
+static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
+{
+	struct procmap_query karg;
+	struct vm_area_struct *vma;
+	struct mm_struct *mm;
+	const char *name = NULL;
+	char *name_buf = NULL;
+	__u64 usize;
+	int err;
+
+	if (copy_from_user(&usize, (void __user *)uarg, sizeof(usize)))
+		return -EFAULT;
+	/* argument struct can never be that large, reject abuse */
+	if (usize > PAGE_SIZE)
+		return -E2BIG;
+	/* argument struct should have at least query_flags and query_addr fields */
+	if (usize < offsetofend(struct procmap_query, query_addr))
+		return -EINVAL;
+	err = copy_struct_from_user(&karg, sizeof(karg), uarg, usize);
+	if (err)
+		return err;
+
+	/* reject unknown flags */
+	if (karg.query_flags & ~PROCMAP_QUERY_VALID_FLAGS_MASK)
+		return -EINVAL;
+	/* either both buffer address and size are set, or both should be zero */
+	if (!!karg.vma_name_size != !!karg.vma_name_addr)
+		return -EINVAL;
+
+	mm = priv->mm;
+	if (!mm || !mmget_not_zero(mm))
+		return -ESRCH;
+
+	err = query_vma_setup(mm);
+	if (err) {
+		mmput(mm);
+		return err;
+	}
+
+	vma = query_matching_vma(mm, karg.query_addr, karg.query_flags);
+	if (IS_ERR(vma)) {
+		err = PTR_ERR(vma);
+		vma = NULL;
+		goto out;
+	}
+
+	karg.vma_start = vma->vm_start;
+	karg.vma_end = vma->vm_end;
+
+	karg.vma_flags = 0;
+	if (vma->vm_flags & VM_READ)
+		karg.vma_flags |= PROCMAP_QUERY_VMA_READABLE;
+	if (vma->vm_flags & VM_WRITE)
+		karg.vma_flags |= PROCMAP_QUERY_VMA_WRITABLE;
+	if (vma->vm_flags & VM_EXEC)
+		karg.vma_flags |= PROCMAP_QUERY_VMA_EXECUTABLE;
+	if (vma->vm_flags & VM_MAYSHARE)
+		karg.vma_flags |= PROCMAP_QUERY_VMA_SHARED;
+
+	karg.vma_page_size = vma_kernel_pagesize(vma);
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
+	if (karg.build_id_size) {
+		__u32 build_id_sz;
+
+		err = build_id_parse(vma, build_id_buf, &build_id_sz);
+		if (err) {
+			karg.build_id_size = 0;
+		} else {
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
+	/* unlock vma or mmap_lock, and put mm_struct before copying data to user */
+	query_vma_teardown(mm, vma);
+	mmput(mm);
+
+	if (karg.vma_name_size && copy_to_user((void __user *)karg.vma_name_addr,
+					       name, karg.vma_name_size)) {
+		kfree(name_buf);
+		return -EFAULT;
+	}
+	kfree(name_buf);
+
+	if (copy_to_user(uarg, &karg, min_t(size_t, sizeof(karg), usize)))
+		return -EFAULT;
+
+	return 0;
+
+out:
+	query_vma_teardown(mm, vma);
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
+	case PROCMAP_QUERY:
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
index 45e4e64fd664..74480ed4fa78 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -333,8 +333,10 @@ typedef int __bitwise __kernel_rwf_t;
 #define RWF_SUPPORTED	(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
 			 RWF_APPEND | RWF_NOAPPEND)
 
+#define PROCFS_IOCTL_MAGIC 'f'
+
 /* Pagemap ioctl */
-#define PAGEMAP_SCAN	_IOWR('f', 16, struct pm_scan_arg)
+#define PAGEMAP_SCAN	_IOWR(PROCFS_IOCTL_MAGIC, 16, struct pm_scan_arg)
 
 /* Bitmasks provided in pm_scan_args masks and reported in page_region.categories. */
 #define PAGE_IS_WPALLOWED	(1 << 0)
@@ -393,4 +395,130 @@ struct pm_scan_arg {
 	__u64 return_mask;
 };
 
+/* /proc/<pid>/maps ioctl */
+#define PROCMAP_QUERY	_IOWR(PROCFS_IOCTL_MAGIC, 17, struct procmap_query)
+
+enum procmap_query_flags {
+	/*
+	 * VMA permission flags.
+	 *
+	 * Can be used as part of procmap_query.query_flags field to look up
+	 * only VMAs satisfying specified subset of permissions. E.g., specifying
+	 * PROCMAP_QUERY_VMA_READABLE only will return both readable and read/write VMAs,
+	 * while having PROCMAP_QUERY_VMA_READABLE | PROCMAP_QUERY_VMA_WRITABLE will only
+	 * return read/write VMAs, though both executable/non-executable and
+	 * private/shared will be ignored.
+	 *
+	 * PROCMAP_QUERY_VMA_* flags are also returned in procmap_query.vma_flags
+	 * field to specify actual VMA permissions.
+	 */
+	PROCMAP_QUERY_VMA_READABLE		= 0x01,
+	PROCMAP_QUERY_VMA_WRITABLE		= 0x02,
+	PROCMAP_QUERY_VMA_EXECUTABLE		= 0x04,
+	PROCMAP_QUERY_VMA_SHARED		= 0x08,
+	/*
+	 * Query modifier flags.
+	 *
+	 * By default VMA that covers provided address is returned, or -ENOENT
+	 * is returned. With PROCMAP_QUERY_COVERING_OR_NEXT_VMA flag set, closest
+	 * VMA with vma_start > addr will be returned if no covering VMA is
+	 * found.
+	 *
+	 * PROCMAP_QUERY_FILE_BACKED_VMA instructs query to consider only VMAs that
+	 * have file backing. Can be combined with PROCMAP_QUERY_COVERING_OR_NEXT_VMA
+	 * to iterate all VMAs with file backing.
+	 */
+	PROCMAP_QUERY_COVERING_OR_NEXT_VMA	= 0x10,
+	PROCMAP_QUERY_FILE_BACKED_VMA		= 0x20,
+};
+
+/*
+ * Input/output argument structured passed into ioctl() call. It can be used
+ * to query a set of VMAs (Virtual Memory Areas) of a process.
+ *
+ * Each field can be one of three kinds, marked in a short comment to the
+ * right of the field:
+ *   - "in", input argument, user has to provide this value, kernel doesn't modify it;
+ *   - "out", output argument, kernel sets this field with VMA data;
+ *   - "in/out", input and output argument; user provides initial value (used
+ *     to specify maximum allowable buffer size), and kernel sets it to actual
+ *     amount of data written (or zero, if there is no data).
+ *
+ * If matching VMA is found (according to criterias specified by
+ * query_addr/query_flags, all the out fields are filled out, and ioctl()
+ * returns 0. If there is no matching VMA, -ENOENT will be returned.
+ * In case of any other error, negative error code other than -ENOENT is
+ * returned.
+ *
+ * Most of the data is similar to the one returned as text in /proc/<pid>/maps
+ * file, but procmap_query provides more querying flexibility. There are no
+ * consistency guarantees between subsequent ioctl() calls, but data returned
+ * for matched VMA is self-consistent.
+ */
+struct procmap_query {
+	/* Query struct size, for backwards/forward compatibility */
+	__u64 size;
+	/*
+	 * Query flags, a combination of enum procmap_query_flags values.
+	 * Defines query filtering and behavior, see enum procmap_query_flags.
+	 *
+	 * Input argument, provided by user. Kernel doesn't modify it.
+	 */
+	__u64 query_flags;		/* in */
+	/*
+	 * Query address. By default, VMA that covers this address will
+	 * be looked up. PROCMAP_QUERY_* flags above modify this default
+	 * behavior further.
+	 *
+	 * Input argument, provided by user. Kernel doesn't modify it.
+	 */
+	__u64 query_addr;		/* in */
+	/* VMA starting (inclusive) and ending (exclusive) address, if VMA is found. */
+	__u64 vma_start;		/* out */
+	__u64 vma_end;			/* out */
+	/* VMA permissions flags. A combination of PROCMAP_QUERY_VMA_* flags. */
+	__u64 vma_flags;		/* out */
+	/* VMA backing page size granularity. */
+	__u32 vma_page_size;		/* out */
+	/*
+	 * VMA file offset. If VMA has file backing, this specifies offset
+	 * within the file that VMA's start address corresponds to.
+	 * Is set to zero if VMA has no backing file.
+	 */
+	__u64 vma_offset;		/* out */
+	/* Backing file's inode number, or zero, if VMA has no backing file. */
+	__u64 inode;			/* out */
+	/* Backing file's device major/minor number, or zero, if VMA has no backing file. */
+	__u32 dev_major;		/* out */
+	__u32 dev_minor;		/* out */
+	/*
+	 * If set to non-zero value, signals the request to return VMA name
+	 * (i.e., VMA's backing file's absolute path, with " (deleted)" suffix
+	 * appended, if file was unlinked from FS) for matched VMA. VMA name
+	 * can also be some special name (e.g., "[heap]", "[stack]") or could
+	 * be even user-supplied with prctl(PR_SET_VMA, PR_SET_VMA_ANON_NAME).
+	 *
+	 * Kernel will set this field to zero, if VMA has no associated name.
+	 * Otherwise kernel will return actual amount of bytes filled in
+	 * user-supplied buffer (see vma_name_addr field below), including the
+	 * terminating zero.
+	 *
+	 * If VMA name is longer that user-supplied maximum buffer size,
+	 * -E2BIG error is returned.
+	 *
+	 * If this field is set to non-zero value, vma_name_addr should point
+	 * to valid user space memory buffer of at least vma_name_size bytes.
+	 * If set to zero, vma_name_addr should be set to zero as well
+	 */
+	__u32 vma_name_size;		/* in/out */
+	/*
+	 * User-supplied address of a buffer of at least vma_name_size bytes
+	 * for kernel to fill with matched VMA's name (see vma_name_size field
+	 * description above for details).
+	 *
+	 * Should be set to zero if VMA name should not be returned.
+	 */
+	__u64 vma_name_addr;		/* in */
+};
+
 #endif /* _UAPI_LINUX_FS_H */
-- 
2.43.0


