Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F298602090
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 03:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiJRBrE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 21:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiJRBrD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 21:47:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D14C267D;
        Mon, 17 Oct 2022 18:47:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 058FF61350;
        Tue, 18 Oct 2022 01:47:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4618C433D7;
        Tue, 18 Oct 2022 01:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1666057621;
        bh=GSwzMI+fxz7A5+Z7H3gcMHBja9DcnY/xhhumYR74sI4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=m6PzhQDK6dZDJ4Va7ieuzZ9iN36l/0IFs2IuMVX20Qc1MH++e9+NkouxG+oMEX3Fo
         3XeWg3Z3/CLP85cvgIPUEt+Wr/bxxy/mUtGLIMQOri0RB2Ot+nrHPx0G2UGzg/hX1e
         UEp6T3pyyTeVSuF2bPyU7zK0r+PxthpyOi5tGMr8=
Date:   Mon, 17 Oct 2022 18:47:00 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Ivan Babrou <ivan@cloudflare.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com, Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Theodore Ts'o" <tytso@mit.edu>,
        David Laight <David.Laight@aculab.com>,
        Jonathan Corbet <corbet@lwn.net>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>,
        Mike Rapoport <rppt@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Kalesh Singh <kaleshsingh@google.com>
Subject: Re: [PATCH v2] proc: report open files as size in stat() for
 /proc/pid/fd
Message-Id: <20221017184700.e1e6944e743bfc38e9abd953@linux-foundation.org>
In-Reply-To: <20220922224027.59266-1-ivan@cloudflare.com>
References: <20220922224027.59266-1-ivan@cloudflare.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 22 Sep 2022 15:40:26 -0700 Ivan Babrou <ivan@cloudflare.com> wrote:

> Many monitoring tools include open file count as a metric. Currently
> the only way to get this number is to enumerate the files in /proc/pid/fd.
> 
> The problem with the current approach is that it does many things people
> generally don't care about when they need one number for a metric.
> In our tests for cadvisor, which reports open file counts per cgroup,
> we observed that reading the number of open files is slow. Out of 35.23%
> of CPU time spent in `proc_readfd_common`, we see 29.43% spent in
> `proc_fill_cache`, which is responsible for filling dentry info.
> Some of this extra time is spinlock contention, but it's a contention
> for the lock we don't want to take to begin with.
> 
> We considered putting the number of open files in /proc/pid/status.
> Unfortunately, counting the number of fds involves iterating the open_files
> bitmap, which has a linear complexity in proportion with the number
> of open files (bitmap slots really, but it's close). We don't want
> to make /proc/pid/status any slower, so instead we put this info
> in /proc/pid/fd as a size member of the stat syscall result.

That sounds awfully logical.

> Previously the reported number was zero, so there's very little
> risk of breaking anything, while still providing a somewhat logical
> way to count the open files with a fallback if it's zero.
> 
> RFC for this patch included iterating open fds under RCU. Thanks
> to Frank Hofmann for the suggestion to use the bitmap instead.
> 
> Previously:
> 
> ```
> $ sudo stat /proc/1/fd | head -n2
>   File: /proc/1/fd
>   Size: 0         	Blocks: 0          IO Block: 1024   directory
> ```
> 
> With this patch:
> 
> ```
> $ sudo stat /proc/1/fd | head -n2
>   File: /proc/1/fd
>   Size: 65        	Blocks: 0          IO Block: 1024   directory
> ```
> 
> Correctness check:
> 
> ```
> $ sudo ls /proc/1/fd | wc -l
> 65
> ```
> 
> I added the docs for /proc/<pid>/fd while I'm at it.
> 

Dang that's a good changelog.

> index e7aafc82be99..394548d26187 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -47,6 +47,7 @@ fixes/update part 1.1  Stefani Seibold <stefani@seibold.net>    June 9 2009
>    3.10  /proc/<pid>/timerslack_ns - Task timerslack value
>    3.11	/proc/<pid>/patch_state - Livepatch patch operation state
>    3.12	/proc/<pid>/arch_status - Task architecture specific information
> +  3.13  /proc/<pid>/fd - List of symlinks to open files
>  
>    4	Configuring procfs
>    4.1	Mount options
> @@ -2145,6 +2146,22 @@ AVX512_elapsed_ms
>    the task is unlikely an AVX512 user, but depends on the workload and the
>    scheduling scenario, it also could be a false negative mentioned above.
>  
> +3.13 /proc/<pid>/fd - List of symlinks to open files
> +-------------------------------------------------------
> +This directory contains symbolic links which represent open files
> +the process is maintaining.  Example output::
> +
> +  lr-x------ 1 root root 64 Sep 20 17:53 0 -> /dev/null
> +  l-wx------ 1 root root 64 Sep 20 17:53 1 -> /dev/null
> +  lrwx------ 1 root root 64 Sep 20 17:53 10 -> 'socket:[12539]'
> +  lrwx------ 1 root root 64 Sep 20 17:53 11 -> 'socket:[12540]'
> +  lrwx------ 1 root root 64 Sep 20 17:53 12 -> 'socket:[12542]'
> +
> +The number of open files for the process is stored in 'size' member
> +of stat() output for /proc/<pid>/fd for fast access.
> +-------------------------------------------------------
> +
> +
>  Chapter 4: Configuring procfs
>  =============================
>  
> diff --git a/fs/proc/fd.c b/fs/proc/fd.c
> index 913bef0d2a36..ff526dfc5faa 100644
> --- a/fs/proc/fd.c
> +++ b/fs/proc/fd.c
> @@ -279,6 +279,34 @@ static int proc_readfd_common(struct file *file, struct dir_context *ctx,
>  	return 0;
>  }
>  
> +static int proc_readfd_count(struct inode *inode)
> +{
> +	struct task_struct *p = get_proc_task(inode);
> +	struct fdtable *fdt;
> +	unsigned int i, size, open_fds = 0;
> +
> +	if (!p)
> +		return -ENOENT;
> +
> +	task_lock(p);
> +	if (p->files) {
> +		rcu_read_lock();
> +
> +		fdt = files_fdtable(p->files);
> +		size = fdt->max_fds;
> +
> +		for (i = size / BITS_PER_LONG; i > 0;)
> +			open_fds += hweight64(fdt->open_fds[--i]);

Could BITMAP_WEIGHT() or __bitmap_weight() or bitmap_weight() be used here?

> +		rcu_read_unlock();
> +	}
> +	task_unlock(p);
> +
> +	put_task_struct(p);
> +
> +	return open_fds;
> +}
> +
>  static int proc_readfd(struct file *file, struct dir_context *ctx)
>  {
>  	return proc_readfd_common(file, ctx, proc_fd_instantiate);
> @@ -319,9 +347,25 @@ int proc_fd_permission(struct user_namespace *mnt_userns,
>  	return rv;
>  }
>  
> +static int proc_fd_getattr(struct user_namespace *mnt_userns,
> +			const struct path *path, struct kstat *stat,
> +			u32 request_mask, unsigned int query_flags)
> +{
> +	struct inode *inode = d_inode(path->dentry);
> +
> +	generic_fillattr(&init_user_ns, inode, stat);
> +
> +	/* If it's a directory, put the number of open fds there */
> +	if (S_ISDIR(inode->i_mode))
> +		stat->size = proc_readfd_count(inode);
> +
> +	return 0;
> +}
> +
>  const struct inode_operations proc_fd_inode_operations = {
>  	.lookup		= proc_lookupfd,
>  	.permission	= proc_fd_permission,
> +	.getattr	= proc_fd_getattr,
>  	.setattr	= proc_setattr,
>  };
>  
> -- 
> 2.37.2
