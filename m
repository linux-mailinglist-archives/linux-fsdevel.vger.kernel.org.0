Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E4062FDC9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Nov 2022 20:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235341AbiKRTLt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Nov 2022 14:11:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235056AbiKRTLr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Nov 2022 14:11:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9285F47
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Nov 2022 11:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668798652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NqA4BxQQXQQzSXtVZRe2POsdg5SmvU98u40yOhzQLSg=;
        b=Z21iGFlXX+NA0AsJqyW8FIpAXoE71bZ43AZxHP0QLhC46BDKL0+ym6tGe7yaZlgbhe1LWc
        kysQtxQJfS6VdQjOt/FwrdZKOZpHh7l/mUR8ph/ZIZIz0/W4i0nbZm3B6dqpNV6dSq1CQF
        JpwCwEpwnDIwb7nUKQxvE1dwDWTYdE0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-626-LcZdyxL9PsOPJyH2GPo2KA-1; Fri, 18 Nov 2022 14:10:48 -0500
X-MC-Unique: LcZdyxL9PsOPJyH2GPo2KA-1
Received: by mail-qv1-f71.google.com with SMTP id d8-20020a0cfe88000000b004bb65193fdcso5389838qvs.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Nov 2022 11:10:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NqA4BxQQXQQzSXtVZRe2POsdg5SmvU98u40yOhzQLSg=;
        b=jsaT7TkWS0P3wKMB7rDsMMVu9IJ9XI8HSuYEz5dEkvufhB0A+UAQI4c3Cei5euDy29
         F/86mMro6ZLLMaVyTLXS1PLayYwci8FoVglYNkEEABbUGL4hdduGjWK2jMfrdGcjzaJK
         W8fRow9X7A+sVMlclCpm9gk5V4UgJMVrPNEIfiUooRgSqWsDA7YRm9fuCHn3kvHNikKp
         UvcFgr5rsxyZe8MLeQ//dNebPP8DrMIJ5c6Fn1HKdSa6/Wdij9RFONYO3/IDL35BiuTk
         MvsVXAv0+cl8/zPsTW+scqVO+J8jWom52350/B2u1RTKjxAVdWnlbriuQyAcIGROO/It
         0bmA==
X-Gm-Message-State: ANoB5pljOdYXdKTy5SH5KGMO2VMB0c+hj5AuBq5W0x3PmuaKWl1GMBvP
        qkhCbMjEmknloltwLEFgUXhXhBAsYRe0yjS/THbKypOum7A1R4YvEC2nZdQeHk3v8q24lQezTpn
        INfZLMezBMQyxMLNgK3oUQF9ROw==
X-Received: by 2002:ad4:4e0e:0:b0:4bb:73a4:c1dc with SMTP id dl14-20020ad44e0e000000b004bb73a4c1dcmr8032040qvb.41.1668798648105;
        Fri, 18 Nov 2022 11:10:48 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6tl+/eZWiHYmFhSxfNlvwgmqWib1jXdbwcCoj/G5+PCUlEJWPJdjdBAzB35gUH6yoFm+UqsA==
X-Received: by 2002:ad4:4e0e:0:b0:4bb:73a4:c1dc with SMTP id dl14-20020ad44e0e000000b004bb73a4c1dcmr8032009qvb.41.1668798647816;
        Fri, 18 Nov 2022 11:10:47 -0800 (PST)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id 2-20020ac85642000000b003a5612c3f28sm2435124qtt.56.2022.11.18.11.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 11:10:47 -0800 (PST)
Date:   Fri, 18 Nov 2022 14:10:51 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Ivan Babrou <ivan@cloudflare.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com, Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Theodore Ts'o <tytso@mit.edu>,
        David Laight <David.Laight@aculab.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>,
        Mike Rapoport <rppt@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Kalesh Singh <kaleshsingh@google.com>
Subject: Re: [PATCH v4] proc: report open files as size in stat() for
 /proc/pid/fd
Message-ID: <Y3fYu2VCBgREBBau@bfoster>
References: <20221024173140.30673-1-ivan@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024173140.30673-1-ivan@cloudflare.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 24, 2022 at 10:31:40AM -0700, Ivan Babrou wrote:
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
> Signed-off-by: Ivan Babrou <ivan@cloudflare.com>
> 
> ---
> v4: Return errno from proc_fd_getattr() instead of setting negative size.
>     Added an explicit include for linux/bitmap.h.
> v3: Made use of bitmap_weight() to count the bits.
> v2: Added missing rcu_read_lock() / rcu_read_unlock(),
>     task_lock() / task_unlock() and put_task_struct().
> ---
>  Documentation/filesystems/proc.rst | 17 +++++++++++
>  fs/proc/fd.c                       | 45 ++++++++++++++++++++++++++++++
>  2 files changed, 62 insertions(+)
> 
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 898c99eae8e4..ec6cfdf1796a 100644
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
> @@ -2149,6 +2150,22 @@ AVX512_elapsed_ms
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
> index 913bef0d2a36..fc46d6fe080c 100644
> --- a/fs/proc/fd.c
> +++ b/fs/proc/fd.c
> @@ -7,6 +7,7 @@
>  #include <linux/namei.h>
>  #include <linux/pid.h>
>  #include <linux/ptrace.h>
> +#include <linux/bitmap.h>
>  #include <linux/security.h>
>  #include <linux/file.h>
>  #include <linux/seq_file.h>
> @@ -279,6 +280,30 @@ static int proc_readfd_common(struct file *file, struct dir_context *ctx,
>  	return 0;
>  }
>  
> +static int proc_readfd_count(struct inode *inode, loff_t *count)
> +{
> +	struct task_struct *p = get_proc_task(inode);
> +	struct fdtable *fdt;
> +
> +	if (!p)
> +		return -ENOENT;
> +
> +	task_lock(p);
> +	if (p->files) {
> +		rcu_read_lock();
> +
> +		fdt = files_fdtable(p->files);
> +		*count = bitmap_weight(fdt->open_fds, fdt->max_fds);
> +
> +		rcu_read_unlock();
> +	}
> +	task_unlock(p);
> +
> +	put_task_struct(p);
> +
> +	return 0;
> +}
> +
>  static int proc_readfd(struct file *file, struct dir_context *ctx)
>  {
>  	return proc_readfd_common(file, ctx, proc_fd_instantiate);
> @@ -319,9 +344,29 @@ int proc_fd_permission(struct user_namespace *mnt_userns,
>  	return rv;
>  }
>  
> +static int proc_fd_getattr(struct user_namespace *mnt_userns,
> +			const struct path *path, struct kstat *stat,
> +			u32 request_mask, unsigned int query_flags)
> +{
> +	struct inode *inode = d_inode(path->dentry);
> +	int rv = 0;
> +
> +	generic_fillattr(&init_user_ns, inode, stat);
> +

Sorry I missed this on v3, but shouldn't this pass through the
mnt_userns parameter?

> +	/* If it's a directory, put the number of open fds there */
> +	if (S_ISDIR(inode->i_mode)) {
> +		rv = proc_readfd_count(inode, &stat->size);
> +		if (rv < 0)
> +			return rv;
> +	}

Also I suppose this could just do:

	if (S_ISDIR(inode->i_mode))
		rv = proc_readfd_count(inode, &stat->size);

	return rv;

But that's a nit. Otherwise seems reasonable to me.

Brian

> +
> +	return rv;
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
> 2.37.3
> 

