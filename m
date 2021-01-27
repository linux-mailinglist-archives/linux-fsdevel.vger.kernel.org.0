Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8CD2305688
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 10:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235104AbhA0JJ1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 04:09:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:47384 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234367AbhA0JGS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 04:06:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611738329; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Frtjky50lhuCvhdjT76CPWeRZ4wg+efgdrWBbOOrsRo=;
        b=HEdTRyd7SvJg/XAQxhbRI7kwZArGDUP8Bfa5ruY6Zz9Lh5KvanjsFGFvcYG6e9Yk0sX6/n
        g42Pxw2b/GcalFfAglpeh+HvgT/22fH/pleNNTn0H5tDOKQNrO70p+2tBQ/+gqeupvnPut
        W9oZam+8xUskfiC8LH/7tPEML5Q4Acc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0FEBFAD57;
        Wed, 27 Jan 2021 09:05:29 +0000 (UTC)
Date:   Wed, 27 Jan 2021 10:05:26 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     surenb@google.com, minchan@kernel.org, gregkh@linuxfoundation.org,
        hridya@google.com, jannh@google.com, kernel-team@android.com,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Michel Lespinasse <walken@google.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Andrei Vagin <avagin@gmail.com>,
        Yafang Shao <laoar.shao@gmail.com>, Hui Su <sh_def@163.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH] procfs/dmabuf: Add /proc/<pid>/task/<tid>/dmabuf_fds
Message-ID: <20210127090526.GB827@dhcp22.suse.cz>
References: <20210126225138.1823266-1-kaleshsingh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210126225138.1823266-1-kaleshsingh@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[Cc linux-api as this is a new user interface]

On Tue 26-01-21 22:51:28, Kalesh Singh wrote:
> In order to measure how much memory a process actually consumes, it is
> necessary to include the DMA buffer sizes for that process in the memory
> accounting. Since the handle to DMA buffers are raw FDs, it is important
> to be able to identify which processes have FD references to a DMA buffer.
> 
> Currently, DMA buffer FDs can be accounted using /proc/<pid>/fd/* and
> /proc/<pid>/fdinfo -- both of which are only root readable, as follows:
>   1. Do a readlink on each FD.
>   2. If the target path begins with "/dmabuf", then the FD is a dmabuf FD.
>   3. stat the file to get the dmabuf inode number.
>   4. Read/ proc/<pid>/fdinfo/<fd>, to get the DMA buffer size.
> 
> Android captures per-process system memory state when certain low memory
> events (e.g a foreground app kill) occur, to identify potential memory
> hoggers. To include a process’s dmabuf usage as part of its memory state,
> the data collection needs to be fast enough to reflect the memory state at
> the time of such events.
> 
> Since reading /proc/<pid>/fd/ and /proc/<pid>/fdinfo/ requires root
> privileges, this approach is not suitable for production builds. Granting
> root privileges even to a system process increases the attack surface and
> is highly undesirable. Additionally this is slow as it requires many
> context switches for searching and getting the dma-buf info.
> 
> With the addition of per-buffer dmabuf stats in sysfs [1], the DMA buffer
> details can be queried using their unique inode numbers.
> 
> This patch proposes adding a /proc/<pid>/task/<tid>/dmabuf_fds interface.
> 
> /proc/<pid>/task/<tid>/dmabuf_fds contains a list of inode numbers for
> every DMA buffer FD that the task has. Entries with the same inode
> number can appear more than once, indicating the total FD references
> for the associated DMA buffer.
> 
> If a thread shares the same files as the group leader then its
> dmabuf_fds file will be empty, as these dmabufs are reported by the
> group leader.
> 
> The interface requires PTRACE_MODE_READ_FSCRED (same as /proc/<pid>/maps)
> and allows the efficient accounting of per-process DMA buffer usage without
> requiring root privileges. (See data below)
> 
> Performance Comparison:
> -----------------------
> 
> The following data compares the time to capture the sizes of all DMA
> buffers referenced by FDs for all processes on an arm64 android device.
> 
> -------------------------------------------------------
>                    |  Core 0 (Little)  |  Core 7 (Big) |
> -------------------------------------------------------
> >From <pid>/fdinfo  |      318 ms       |     145 ms    |
> -------------------------------------------------------
> Inodes from        |      114 ms       |      27 ms    |
> dmabuf_fds;        |    (2.8x  ^)      |   (5.4x  ^)   |
> data from sysfs    |                   |               |
> -------------------------------------------------------
> 
> It can be inferred that in the worst case there is a 2.8x speedup for
> determining per-process DMA buffer FD sizes, when using the proposed
> interfaces.
> 
> [1] https://lore.kernel.org/dri-devel/20210119225723.388883-1-hridya@google.com/
> 
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> ---
>  Documentation/filesystems/proc.rst |  30 ++++++
>  drivers/dma-buf/dma-buf.c          |   7 +-
>  fs/proc/Makefile                   |   1 +
>  fs/proc/base.c                     |   1 +
>  fs/proc/dma_bufs.c                 | 159 +++++++++++++++++++++++++++++
>  fs/proc/internal.h                 |   1 +
>  include/linux/dma-buf.h            |   5 +
>  7 files changed, 198 insertions(+), 6 deletions(-)
>  create mode 100644 fs/proc/dma_bufs.c
> 
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 2fa69f710e2a..757dd47ab679 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -47,6 +47,7 @@ fixes/update part 1.1  Stefani Seibold <stefani@seibold.net>    June 9 2009
>    3.10  /proc/<pid>/timerslack_ns - Task timerslack value
>    3.11	/proc/<pid>/patch_state - Livepatch patch operation state
>    3.12	/proc/<pid>/arch_status - Task architecture specific information
> +  3.13	/proc/<pid>/task/<tid>/dmabuf_fds - DMA buffers referenced by an FD
>  
>    4	Configuring procfs
>    4.1	Mount options
> @@ -2131,6 +2132,35 @@ AVX512_elapsed_ms
>    the task is unlikely an AVX512 user, but depends on the workload and the
>    scheduling scenario, it also could be a false negative mentioned above.
>  
> +3.13 /proc/<pid>/task/<tid>/dmabuf_fds - DMA buffers referenced by an FD
> +-------------------------------------------------------------------------
> +This file  exposes a list of the inode numbers for every DMA buffer
> +FD that the task has.
> +
> +The same inode number can appear more than once, indicating the total
> +FD references for the associated DMA buffer.
> +
> +The inode number can be used to lookup the DMA buffer information in
> +the sysfs interface /sys/kernel/dmabuf/buffers/<inode-no>/.
> +
> +Example Output
> +~~~~~~~~~~~~~~
> +$ cat /proc/612/task/612/dmabuf_fds
> +30972 30973 45678 49326
> +
> +Permission to access this file is governed by a ptrace access mode
> +PTRACE_MODE_READ_FSCREDS.
> +
> +Threads can have different files when created without specifying
> +the CLONE_FILES flag. For this reason the interface is presented as
> +/proc/<pid>/task/<tid>/dmabuf_fds and not /proc/<pid>/dmabuf_fds.
> +This simplifies kernel code and aggregation can be handled in
> +userspace.
> +
> +If a thread has the same files as its group leader, then its dmabuf_fds
> +file will be empty as these dmabufs are already reported by the
> +group leader.
> +
>  Chapter 4: Configuring procfs
>  =============================
>  
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index 9ad6397aaa97..0660c06be4c6 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -29,8 +29,6 @@
>  #include <uapi/linux/dma-buf.h>
>  #include <uapi/linux/magic.h>
>  
> -static inline int is_dma_buf_file(struct file *);
> -
>  struct dma_buf_list {
>  	struct list_head head;
>  	struct mutex lock;
> @@ -434,10 +432,7 @@ static const struct file_operations dma_buf_fops = {
>  	.show_fdinfo	= dma_buf_show_fdinfo,
>  };
>  
> -/*
> - * is_dma_buf_file - Check if struct file* is associated with dma_buf
> - */
> -static inline int is_dma_buf_file(struct file *file)
> +int is_dma_buf_file(struct file *file)
>  {
>  	return file->f_op == &dma_buf_fops;
>  }
> diff --git a/fs/proc/Makefile b/fs/proc/Makefile
> index bd08616ed8ba..91a67f43ddf4 100644
> --- a/fs/proc/Makefile
> +++ b/fs/proc/Makefile
> @@ -16,6 +16,7 @@ proc-y	+= cmdline.o
>  proc-y	+= consoles.o
>  proc-y	+= cpuinfo.o
>  proc-y	+= devices.o
> +proc-y	+= dma_bufs.o
>  proc-y	+= interrupts.o
>  proc-y	+= loadavg.o
>  proc-y	+= meminfo.o
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index b3422cda2a91..af15a60b9831 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -3598,6 +3598,7 @@ static const struct pid_entry tid_base_stuff[] = {
>  #ifdef CONFIG_SECCOMP_CACHE_DEBUG
>  	ONE("seccomp_cache", S_IRUSR, proc_pid_seccomp_cache),
>  #endif
> +	REG("dmabuf_fds", 0444, proc_tid_dmabuf_fds_operations),
>  };
>  
>  static int proc_tid_base_readdir(struct file *file, struct dir_context *ctx)
> diff --git a/fs/proc/dma_bufs.c b/fs/proc/dma_bufs.c
> new file mode 100644
> index 000000000000..46ea9cf968ed
> --- /dev/null
> +++ b/fs/proc/dma_bufs.c
> @@ -0,0 +1,159 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Per-process DMA-BUF Stats
> + *
> + * Copyright (C) 2021 Google LLC.
> + */
> +
> +#include <linux/dma-buf.h>
> +#include <linux/fdtable.h>
> +#include <linux/ptrace.h>
> +#include <linux/seq_file.h>
> +
> +#include "internal.h"
> +
> +struct dmabuf_fds_private {
> +	struct inode *inode;
> +	struct task_struct *task;
> +	struct file *dmabuf_file;
> +};
> +
> +static loff_t *next_dmabuf(struct dmabuf_fds_private *priv,
> +		loff_t *pos)
> +{
> +	struct fdtable *fdt;
> +	struct file *file;
> +
> +	rcu_read_lock();
> +	fdt = files_fdtable(priv->task->files);
> +	for (; *pos < fdt->max_fds; ++*pos) {
> +		file = files_lookup_fd_rcu(priv->task->files, (unsigned int) *pos);
> +		if (file && is_dma_buf_file(file) && get_file_rcu(file)) {
> +			priv->dmabuf_file = file;
> +			break;
> +		}
> +	}
> +	if (*pos >= fdt->max_fds)
> +		pos = NULL;
> +	rcu_read_unlock();
> +
> +	return pos;
> +}
> +
> +static void *dmabuf_fds_seq_start(struct seq_file *s, loff_t *pos)
> +{
> +	struct dmabuf_fds_private *priv = s->private;
> +	struct files_struct *group_leader_files;
> +
> +	priv->task = get_proc_task(priv->inode);
> +
> +	if (!priv->task)
> +		return ERR_PTR(-ESRCH);
> +
> +	/* Hold task lock for duration that files need to be stable */
> +	task_lock(priv->task);
> +
> +	/*
> +	 * If this task is not the group leader but shares the same files, leave file empty.
> +	 * These dmabufs are already reported in the group leader's dmabuf_fds.
> +	 */
> +	group_leader_files = priv->task->group_leader->files;
> +	if (priv->task != priv->task->group_leader && priv->task->files == group_leader_files) {
> +		task_unlock(priv->task);
> +		put_task_struct(priv->task);
> +		priv->task = NULL;
> +		return NULL;
> +	}
> +
> +	return next_dmabuf(priv, pos);
> +}
> +
> +static void *dmabuf_fds_seq_next(struct seq_file *s, void *v, loff_t *pos)
> +{
> +	++*pos;
> +	return next_dmabuf(s->private, pos);
> +}
> +
> +static void dmabuf_fds_seq_stop(struct seq_file *s, void *v)
> +{
> +	struct dmabuf_fds_private *priv = s->private;
> +
> +	if (priv->task) {
> +		task_unlock(priv->task);
> +		put_task_struct(priv->task);
> +
> +	}
> +	if (priv->dmabuf_file)
> +		fput(priv->dmabuf_file);
> +}
> +
> +static int dmabuf_fds_seq_show(struct seq_file *s, void *v)
> +{
> +	struct dmabuf_fds_private *priv = s->private;
> +	struct file *file = priv->dmabuf_file;
> +	struct dma_buf *dmabuf = file->private_data;
> +
> +	if (!dmabuf)
> +		return -ESRCH;
> +
> +	seq_printf(s, "%8lu ", file_inode(file)->i_ino);
> +
> +	fput(priv->dmabuf_file);
> +	priv->dmabuf_file = NULL;
> +
> +	return 0;
> +}
> +
> +static const struct seq_operations proc_tid_dmabuf_fds_seq_ops = {
> +	.start = dmabuf_fds_seq_start,
> +	.next  = dmabuf_fds_seq_next,
> +	.stop  = dmabuf_fds_seq_stop,
> +	.show  = dmabuf_fds_seq_show
> +};
> +
> +static int proc_dmabuf_fds_open(struct inode *inode, struct file *file,
> +		     const struct seq_operations *ops)
> +{
> +	struct dmabuf_fds_private *priv;
> +	struct task_struct *task;
> +	bool allowed = false;
> +
> +	task = get_proc_task(inode);
> +	if (!task)
> +		return -ESRCH;
> +
> +	allowed = ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS);
> +	put_task_struct(task);
> +
> +	if (!allowed)
> +		return -EACCES;
> +
> +	priv = __seq_open_private(file, ops, sizeof(*priv));
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->inode = inode;
> +	priv->task = NULL;
> +	priv->dmabuf_file = NULL;
> +
> +	return 0;
> +}
> +
> +static int proc_dmabuf_fds_release(struct inode *inode, struct file *file)
> +{
> +	return seq_release_private(inode, file);
> +}
> +
> +static int tid_dmabuf_fds_open(struct inode *inode, struct file *file)
> +{
> +	return proc_dmabuf_fds_open(inode, file,
> +			&proc_tid_dmabuf_fds_seq_ops);
> +}
> +
> +const struct file_operations proc_tid_dmabuf_fds_operations = {
> +	.open		= tid_dmabuf_fds_open,
> +	.read		= seq_read,
> +	.llseek		= seq_lseek,
> +	.release	= proc_dmabuf_fds_release,
> +};
> +
> diff --git a/fs/proc/internal.h b/fs/proc/internal.h
> index f60b379dcdc7..4ca74220db9c 100644
> --- a/fs/proc/internal.h
> +++ b/fs/proc/internal.h
> @@ -303,6 +303,7 @@ extern const struct file_operations proc_pid_smaps_operations;
>  extern const struct file_operations proc_pid_smaps_rollup_operations;
>  extern const struct file_operations proc_clear_refs_operations;
>  extern const struct file_operations proc_pagemap_operations;
> +extern const struct file_operations proc_tid_dmabuf_fds_operations;
>  
>  extern unsigned long task_vsize(struct mm_struct *);
>  extern unsigned long task_statm(struct mm_struct *,
> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> index cf72699cb2bc..087e11f7f193 100644
> --- a/include/linux/dma-buf.h
> +++ b/include/linux/dma-buf.h
> @@ -27,6 +27,11 @@ struct device;
>  struct dma_buf;
>  struct dma_buf_attachment;
>  
> +/**
> + * Check if struct file* is associated with dma_buf.
> + */
> +int is_dma_buf_file(struct file *file);
> +
>  /**
>   * struct dma_buf_ops - operations possible on struct dma_buf
>   * @vmap: [optional] creates a virtual mapping for the buffer into kernel
> -- 
> 2.30.0.280.ga3ce27912f-goog

-- 
Michal Hocko
SUSE Labs
