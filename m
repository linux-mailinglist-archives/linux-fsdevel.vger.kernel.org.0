Return-Path: <linux-fsdevel+bounces-18728-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F281B8BBCB0
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 17:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63E991F21EC2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 15:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBB64084C;
	Sat,  4 May 2024 15:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PJb+/uNv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029E51F60A;
	Sat,  4 May 2024 15:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714836521; cv=none; b=FnoPB2pmjimvEMg2NazguHHs3WS/IW5A9dRMNECW++CGVErAWoTunmt84Q9E7jns5nHpO3wSn+HE6WIN/yzq1lIqRjpolFHeObZjNUAYA/pI2pgLmk+uYMj5k9I8j4guAluE80fRwaUKcrCqR41CbZUvFebozrDE/mRWgFI1NaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714836521; c=relaxed/simple;
	bh=YlOKyI17Jjb2NRs+BJ8KRR+U+1rIZSjspXzeiBmyKKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HgYZluE/vIM9BHnZzPYzFxMF26xgBoTBd+kLHJ+zkKHXb+CbWP3LiWDk7wUBU8DPKl7EPr65L4lkMTu4PvQ2ZIkQ01stze2LBZCJXQGrzu34dVhadD5bIgnrjIcQN2Yp0jHTomvPg5og9icSh/Zph64IBEyqamQLHL2uW+c20xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PJb+/uNv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEEB6C072AA;
	Sat,  4 May 2024 15:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714836520;
	bh=YlOKyI17Jjb2NRs+BJ8KRR+U+1rIZSjspXzeiBmyKKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PJb+/uNvqesL05rkF8dsBzGbTC61V+tsUV92QeUmY3uvmNmz4xUvHBBmVHcLhVY6Q
	 xfboTCKj81e7R082XJm3JuLYaHQzV94k8en1VQ924roytn+PMIDuw5oAEOkAnVZBz3
	 E5MvTHPG9MbAFbyKc2KM7PoNZ2sHXajfscS4iXhE=
Date: Sat, 4 May 2024 17:28:36 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org,
	viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 2/5] fs/procfs: implement efficient VMA querying API for
 /proc/<pid>/maps
Message-ID: <2024050439-janitor-scoff-be04@gregkh>
References: <20240504003006.3303334-1-andrii@kernel.org>
 <20240504003006.3303334-3-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240504003006.3303334-3-andrii@kernel.org>

On Fri, May 03, 2024 at 05:30:03PM -0700, Andrii Nakryiko wrote:
> /proc/<pid>/maps file is extremely useful in practice for various tasks
> involving figuring out process memory layout, what files are backing any
> given memory range, etc. One important class of applications that
> absolutely rely on this are profilers/stack symbolizers. They would
> normally capture stack trace containing absolute memory addresses of
> some functions, and would then use /proc/<pid>/maps file to file
> corresponding backing ELF files, file offsets within them, and then
> continue from there to get yet more information (ELF symbols, DWARF
> information) to get human-readable symbolic information.
> 
> As such, there are both performance and correctness requirement
> involved. This address to VMA information translation has to be done as
> efficiently as possible, but also not miss any VMA (especially in the
> case of loading/unloading shared libraries).
> 
> Unfortunately, for all the /proc/<pid>/maps file universality and
> usefulness, it doesn't fit the above 100%.

Is this a new change or has it always been this way?

> First, it's text based, which makes its programmatic use from
> applications and libraries unnecessarily cumbersome and slow due to the
> need to do text parsing to get necessary pieces of information.

slow in what way?  How has it never been noticed before as a problem?

And exact numbers are appreciated please, yes open/read/close seems
slower than open/ioctl/close, but is it really overall an issue in the
real world for anything?

Text apis are good as everyone can handle them, ioctls are harder for
obvious reasons.

> Second, it's main purpose is to emit all VMAs sequentially, but in
> practice captured addresses would fall only into a small subset of all
> process' VMAs, mainly containing executable text. Yet, library would
> need to parse most or all of the contents to find needed VMAs, as there
> is no way to skip VMAs that are of no use. Efficient library can do the
> linear pass and it is still relatively efficient, but it's definitely an
> overhead that can be avoided, if there was a way to do more targeted
> querying of the relevant VMA information.

I don't understand, is this a bug in the current files?  If so, why not
just fix that up?

And again "efficient" need to be quantified.

> Another problem when writing generic stack trace symbolization library
> is an unfortunate performance-vs-correctness tradeoff that needs to be
> made.

What requirement has caused a "generic stack trace symbolization
library" to be needed at all?  What is the problem you are trying to
solve that is not already solved by existing tools?

> Library has to make a decision to either cache parsed contents of
> /proc/<pid>/maps for service future requests (if application requests to
> symbolize another set of addresses, captured at some later time, which
> is typical for periodic/continuous profiling cases) to avoid higher
> costs of needed to re-parse this file or caching the contents in memory
> to speed up future requests. In the former case, more memory is used for
> the cache and there is a risk of getting stale data if application
> loaded/unloaded shared libraries, or otherwise changed its set of VMAs
> through additiona mmap() calls (and other means of altering memory
> address space). In the latter case, it's the performance hit that comes
> from re-opening the file and re-reading/re-parsing its contents all over
> again.

Again, "performance hit" needs to be justified, it shouldn't be much
overall.

> This patch aims to solve this problem by providing a new API built on
> top of /proc/<pid>/maps. It is ioctl()-based and built as a binary
> interface, avoiding the cost and awkwardness of textual representation
> for programmatic use.

Some people find text easier to handle for programmatic use :)

> It's designed to be extensible and
> forward/backward compatible by including user-specified field size and
> using copy_struct_from_user() approach. But, most importantly, it allows
> to do point queries for specific single address, specified by user. And
> this is done efficiently using VMA iterator.

Ok, maybe this is the main issue, you only want one at a time?

> User has a choice to pick either getting VMA that covers provided
> address or -ENOENT if none is found (exact, least surprising, case). Or,
> with an extra query flag (PROCFS_PROCMAP_EXACT_OR_NEXT_VMA), they can
> get either VMA that covers the address (if there is one), or the closest
> next VMA (i.e., VMA with the smallest vm_start > addr). The later allows
> more efficient use, but, given it could be a surprising behavior,
> requires an explicit opt-in.
> 
> Basing this ioctl()-based API on top of /proc/<pid>/maps's FD makes
> sense given it's querying the same set of VMA data. All the permissions
> checks performed on /proc/<pid>/maps opening fit here as well.
> ioctl-based implementation is fetching remembered mm_struct reference,
> but otherwise doesn't interfere with seq_file-based implementation of
> /proc/<pid>/maps textual interface, and so could be used together or
> independently without paying any price for that.
> 
> There is one extra thing that /proc/<pid>/maps doesn't currently
> provide, and that's an ability to fetch ELF build ID, if present. User
> has control over whether this piece of information is requested or not
> by either setting build_id_size field to zero or non-zero maximum buffer
> size they provided through build_id_addr field (which encodes user
> pointer as __u64 field).
> 
> The need to get ELF build ID reliably is an important aspect when
> dealing with profiling and stack trace symbolization, and
> /proc/<pid>/maps textual representation doesn't help with this,
> requiring applications to open underlying ELF binary through
> /proc/<pid>/map_files/<start>-<end> symlink, which adds an extra
> permissions implications due giving a full access to the binary from
> (potentially) another process, while all application is interested in is
> build ID. Giving an ability to request just build ID doesn't introduce
> any additional security concerns, on top of what /proc/<pid>/maps is
> already concerned with, simplifying the overall logic.
> 
> Kernel already implements build ID fetching, which is used from BPF
> subsystem. We are reusing this code here, but plan a follow up changes
> to make it work better under more relaxed assumption (compared to what
> existing code assumes) of being called from user process context, in
> which page faults are allowed. BPF-specific implementation currently
> bails out if necessary part of ELF file is not paged in, all due to
> extra BPF-specific restrictions (like the need to fetch build ID in
> restrictive contexts such as NMI handler).
> 
> Note also, that fetching VMA name (e.g., backing file path, or special
> hard-coded or user-provided names) is optional just like build ID. If
> user sets vma_name_size to zero, kernel code won't attempt to retrieve
> it, saving resources.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Where is the userspace code that uses this new api you have created?

> ---
>  fs/proc/task_mmu.c      | 165 ++++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/fs.h |  32 ++++++++
>  2 files changed, 197 insertions(+)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 8e503a1635b7..cb7b1ff1a144 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -22,6 +22,7 @@
>  #include <linux/pkeys.h>
>  #include <linux/minmax.h>
>  #include <linux/overflow.h>
> +#include <linux/buildid.h>
>  
>  #include <asm/elf.h>
>  #include <asm/tlb.h>
> @@ -375,11 +376,175 @@ static int pid_maps_open(struct inode *inode, struct file *file)
>  	return do_maps_open(inode, file, &proc_pid_maps_op);
>  }
>  
> +static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
> +{
> +	struct procfs_procmap_query karg;
> +	struct vma_iterator iter;
> +	struct vm_area_struct *vma;
> +	struct mm_struct *mm;
> +	const char *name = NULL;
> +	char build_id_buf[BUILD_ID_SIZE_MAX], *name_buf = NULL;
> +	__u64 usize;
> +	int err;
> +
> +	if (copy_from_user(&usize, (void __user *)uarg, sizeof(usize)))
> +		return -EFAULT;
> +	if (usize > PAGE_SIZE)

Nice, where did you document that?  And how is that portable given that
PAGE_SIZE can be different on different systems?

and why aren't you checking the actual structure size instead?  You can
easily run off the end here without knowing it.

> +		return -E2BIG;
> +	if (usize < offsetofend(struct procfs_procmap_query, query_addr))
> +		return -EINVAL;

Ok, so you have two checks?  How can the first one ever fail?


> +	err = copy_struct_from_user(&karg, sizeof(karg), uarg, usize);
> +	if (err)
> +		return err;
> +
> +	if (karg.query_flags & ~PROCFS_PROCMAP_EXACT_OR_NEXT_VMA)
> +		return -EINVAL;
> +	if (!!karg.vma_name_size != !!karg.vma_name_addr)
> +		return -EINVAL;
> +	if (!!karg.build_id_size != !!karg.build_id_addr)
> +		return -EINVAL;

So you want values to be set, right?

> +
> +	mm = priv->mm;
> +	if (!mm || !mmget_not_zero(mm))
> +		return -ESRCH;

What is this error for?  Where is this documentned?

> +	if (mmap_read_lock_killable(mm)) {
> +		mmput(mm);
> +		return -EINTR;
> +	}
> +
> +	vma_iter_init(&iter, mm, karg.query_addr);
> +	vma = vma_next(&iter);
> +	if (!vma) {
> +		err = -ENOENT;
> +		goto out;
> +	}
> +	/* user wants covering VMA, not the closest next one */
> +	if (!(karg.query_flags & PROCFS_PROCMAP_EXACT_OR_NEXT_VMA) &&
> +	    vma->vm_start > karg.query_addr) {
> +		err = -ENOENT;
> +		goto out;
> +	}
> +
> +	karg.vma_start = vma->vm_start;
> +	karg.vma_end = vma->vm_end;
> +
> +	if (vma->vm_file) {
> +		const struct inode *inode = file_user_inode(vma->vm_file);
> +
> +		karg.vma_offset = ((__u64)vma->vm_pgoff) << PAGE_SHIFT;
> +		karg.dev_major = MAJOR(inode->i_sb->s_dev);
> +		karg.dev_minor = MINOR(inode->i_sb->s_dev);

So the major/minor is that of the file superblock?  Why?

> +		karg.inode = inode->i_ino;

What is userspace going to do with this?

> +	} else {
> +		karg.vma_offset = 0;
> +		karg.dev_major = 0;
> +		karg.dev_minor = 0;
> +		karg.inode = 0;

Why not set everything to 0 up above at the beginning so you never miss
anything, and you don't miss any holes accidentally in the future.

> +	}
> +
> +	karg.vma_flags = 0;
> +	if (vma->vm_flags & VM_READ)
> +		karg.vma_flags |= PROCFS_PROCMAP_VMA_READABLE;
> +	if (vma->vm_flags & VM_WRITE)
> +		karg.vma_flags |= PROCFS_PROCMAP_VMA_WRITABLE;
> +	if (vma->vm_flags & VM_EXEC)
> +		karg.vma_flags |= PROCFS_PROCMAP_VMA_EXECUTABLE;
> +	if (vma->vm_flags & VM_MAYSHARE)
> +		karg.vma_flags |= PROCFS_PROCMAP_VMA_SHARED;
> +
> +	if (karg.build_id_size) {
> +		__u32 build_id_sz = BUILD_ID_SIZE_MAX;
> +
> +		err = build_id_parse(vma, build_id_buf, &build_id_sz);
> +		if (!err) {
> +			if (karg.build_id_size < build_id_sz) {
> +				err = -ENAMETOOLONG;
> +				goto out;
> +			}
> +			karg.build_id_size = build_id_sz;
> +		}
> +	}
> +
> +	if (karg.vma_name_size) {
> +		size_t name_buf_sz = min_t(size_t, PATH_MAX, karg.vma_name_size);
> +		const struct path *path;
> +		const char *name_fmt;
> +		size_t name_sz = 0;
> +
> +		get_vma_name(vma, &path, &name, &name_fmt);
> +
> +		if (path || name_fmt || name) {
> +			name_buf = kmalloc(name_buf_sz, GFP_KERNEL);
> +			if (!name_buf) {
> +				err = -ENOMEM;
> +				goto out;
> +			}
> +		}
> +		if (path) {
> +			name = d_path(path, name_buf, name_buf_sz);
> +			if (IS_ERR(name)) {
> +				err = PTR_ERR(name);
> +				goto out;
> +			}
> +			name_sz = name_buf + name_buf_sz - name;
> +		} else if (name || name_fmt) {
> +			name_sz = 1 + snprintf(name_buf, name_buf_sz, name_fmt ?: "%s", name);
> +			name = name_buf;
> +		}
> +		if (name_sz > name_buf_sz) {
> +			err = -ENAMETOOLONG;
> +			goto out;
> +		}
> +		karg.vma_name_size = name_sz;
> +	}
> +
> +	/* unlock and put mm_struct before copying data to user */
> +	mmap_read_unlock(mm);
> +	mmput(mm);
> +
> +	if (karg.vma_name_size && copy_to_user((void __user *)karg.vma_name_addr,
> +					       name, karg.vma_name_size)) {
> +		kfree(name_buf);
> +		return -EFAULT;
> +	}
> +	kfree(name_buf);
> +
> +	if (karg.build_id_size && copy_to_user((void __user *)karg.build_id_addr,
> +					       build_id_buf, karg.build_id_size))
> +		return -EFAULT;
> +
> +	if (copy_to_user(uarg, &karg, min_t(size_t, sizeof(karg), usize)))
> +		return -EFAULT;
> +
> +	return 0;
> +
> +out:
> +	mmap_read_unlock(mm);
> +	mmput(mm);
> +	kfree(name_buf);
> +	return err;
> +}
> +
> +static long procfs_procmap_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> +{
> +	struct seq_file *seq = file->private_data;
> +	struct proc_maps_private *priv = seq->private;
> +
> +	switch (cmd) {
> +	case PROCFS_PROCMAP_QUERY:
> +		return do_procmap_query(priv, (void __user *)arg);
> +	default:
> +		return -ENOIOCTLCMD;
> +	}
> +}
> +
>  const struct file_operations proc_pid_maps_operations = {
>  	.open		= pid_maps_open,
>  	.read		= seq_read,
>  	.llseek		= seq_lseek,
>  	.release	= proc_map_release,
> +	.unlocked_ioctl = procfs_procmap_ioctl,
> +	.compat_ioctl	= procfs_procmap_ioctl,
>  };
>  
>  /*
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index 45e4e64fd664..fe8924a8d916 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -393,4 +393,36 @@ struct pm_scan_arg {
>  	__u64 return_mask;
>  };
>  
> +/* /proc/<pid>/maps ioctl */
> +#define PROCFS_IOCTL_MAGIC 0x9f

Don't you need to document this in the proper place?

> +#define PROCFS_PROCMAP_QUERY	_IOWR(PROCFS_IOCTL_MAGIC, 1, struct procfs_procmap_query)
> +
> +enum procmap_query_flags {
> +	PROCFS_PROCMAP_EXACT_OR_NEXT_VMA = 0x01,
> +};
> +
> +enum procmap_vma_flags {
> +	PROCFS_PROCMAP_VMA_READABLE = 0x01,
> +	PROCFS_PROCMAP_VMA_WRITABLE = 0x02,
> +	PROCFS_PROCMAP_VMA_EXECUTABLE = 0x04,
> +	PROCFS_PROCMAP_VMA_SHARED = 0x08,

Are these bits?  If so, please use the bit macro for it to make it
obvious.

> +};
> +
> +struct procfs_procmap_query {
> +	__u64 size;
> +	__u64 query_flags;		/* in */

Does this map to the procmap_vma_flags enum?  if so, please say so.

> +	__u64 query_addr;		/* in */
> +	__u64 vma_start;		/* out */
> +	__u64 vma_end;			/* out */
> +	__u64 vma_flags;		/* out */
> +	__u64 vma_offset;		/* out */
> +	__u64 inode;			/* out */

What is the inode for, you have an inode for the file already, why give
it another one?

> +	__u32 dev_major;		/* out */
> +	__u32 dev_minor;		/* out */

What is major/minor for?

> +	__u32 vma_name_size;		/* in/out */
> +	__u32 build_id_size;		/* in/out */
> +	__u64 vma_name_addr;		/* in */
> +	__u64 build_id_addr;		/* in */

Why not document this all using kerneldoc above the structure?

anyway, I don't like ioctls, but there is a place for them, you just
have to actually justify the use for them and not say "not efficient
enough" as that normally isn't an issue overall.

thanks,

greg k-h

