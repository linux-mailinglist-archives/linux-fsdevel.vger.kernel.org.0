Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F435BB4D6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Sep 2022 02:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiIQABX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Sep 2022 20:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiIQABW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Sep 2022 20:01:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE53BA9C27;
        Fri, 16 Sep 2022 17:01:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 631EBB8299C;
        Sat, 17 Sep 2022 00:01:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8F9EC433D6;
        Sat, 17 Sep 2022 00:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1663372877;
        bh=pC/Zqjp4o0E3LYANuehsjm/nSSR6oLHYY0mTJm0FXHA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tpI1TtkXX3ZdqEwU880NQ0dedHNsr1MQYTTQhqABv/M7Wms/VG+In4wr3yq6KZmgE
         VO74NU7yLT4XiXgoB1xlIq7OZ7oDJjisvdfu+hahf9vje6jS3uoQgxGAKeXVV+0uaT
         iz5c4aWsiylEp4u9kyt1dWCMFAMZSbjIkQqZJ3DY=
Date:   Fri, 16 Sep 2022 17:01:15 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Ivan Babrou <ivan@cloudflare.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com, Kalesh Singh <kaleshsingh@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RFC] proc: report open files as size in stat() for
 /proc/pid/fd
Message-Id: <20220916170115.35932cba34e2cc2d923b03b5@linux-foundation.org>
In-Reply-To: <20220916230853.49056-1-ivan@cloudflare.com>
References: <20220916230853.49056-1-ivan@cloudflare.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

(cc's added)

On Fri, 16 Sep 2022 16:08:52 -0700 Ivan Babrou <ivan@cloudflare.com> wrote:

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
> We considered putting the number of open files in /proc/pid/stat.
> Unfortunately, counting the number of fds involves iterating the fdtable,
> which means that it might slow down /proc/pid/stat for processes
> with many open files. Instead we opted to put this info in /proc/pid/fd
> as a size member of the stat syscall result. Previously the reported
> number was zero, so there's very little risk of breaking anything,
> while still providing a somewhat logical way to count the open files.

Documentation/filesystems/proc.rst would be an appropriate place to
document this ;)

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
> There are two alternatives to this approach that I can see:
> 
> * Expose /proc/pid/fd_count with a count there
> * Make fd count acces O(1) and expose it in /proc/pid/status
> 
> I can probably figure out how to do the former, but the latter
> will require somebody with more experience in file code than myself.
> 
> Signed-off-by: Ivan Babrou <ivan@cloudflare.com>
> ---
>  fs/proc/fd.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/fs/proc/fd.c b/fs/proc/fd.c
> index 913bef0d2a36..c7ac142500a8 100644
> --- a/fs/proc/fd.c
> +++ b/fs/proc/fd.c
> @@ -279,6 +279,29 @@ static int proc_readfd_common(struct file *file, struct dir_context *ctx,
>  	return 0;
>  }
>  
> +static int proc_readfd_count(struct inode *inode)
> +{
> +	struct task_struct *p = get_proc_task(inode);
> +	unsigned int fd = 0, count = 0;
> +
> +	if (!p)
> +		return -ENOENT;
> +
> +	rcu_read_lock();
> +	while (task_lookup_next_fd_rcu(p, &fd)) {
> +		rcu_read_unlock();
> +
> +		count++;
> +		fd++;
> +
> +		cond_resched();
> +		rcu_read_lock();
> +	}
> +	rcu_read_unlock();
> +	put_task_struct(p);
> +	return count;
> +}
> +
>  static int proc_readfd(struct file *file, struct dir_context *ctx)
>  {
>  	return proc_readfd_common(file, ctx, proc_fd_instantiate);
> @@ -319,9 +342,33 @@ int proc_fd_permission(struct user_namespace *mnt_userns,
>  	return rv;
>  }
>  
> +int proc_fd_getattr(struct user_namespace *mnt_userns,
> +			const struct path *path, struct kstat *stat,
> +			u32 request_mask, unsigned int query_flags)
> +{
> +	struct inode *inode = d_inode(path->dentry);
> +	struct proc_dir_entry *de = PDE(inode);
> +
> +	if (de) {
> +		nlink_t nlink = READ_ONCE(de->nlink);
> +
> +		if (nlink > 0)
> +			set_nlink(inode, nlink);
> +	}
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
