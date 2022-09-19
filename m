Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC935BC423
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Sep 2022 10:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiISITA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Sep 2022 04:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiISIS7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Sep 2022 04:18:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB24205CC;
        Mon, 19 Sep 2022 01:18:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2DBD60E74;
        Mon, 19 Sep 2022 08:18:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A75C433C1;
        Mon, 19 Sep 2022 08:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663575536;
        bh=zyMiFNyTUZzN5Vl8V4xhRkUXsVoPi/7RrGTWVVS39HY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=clyPeZHwyvocUxt9XrhblunGcgpM1uDLI+w2I2IB1iHn0BswcvzsJAzeTG7go0Ld6
         TlVLgOVC44pbj27IJ2YhYzg8CP/zvDM3EvEWO9jChcECQCv4BQSH8UQtxFt9Ly4WoV
         mWSedfT6BGUco0Y0yPMzO32Wf6+ZAE1Bf+pFNoHkEsj1LSvLONWDzkiOyXbBZZnCsn
         qdwmvyVaW0OYtIrCb097D6zXCaP+nr8wgD1qxsWCQrtUYXmDPOKu6xvGXgiGBaGl/3
         Bu9E3Bbfw+aW9PJWzlyQCOzyuM4N/rxDKAHcPh3mhaoCwFklTFGC1olCAWqraBOV0h
         obnbA43FinXvg==
Date:   Mon, 19 Sep 2022 10:18:50 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ivan Babrou <ivan@cloudflare.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com, Kalesh Singh <kaleshsingh@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RFC] proc: report open files as size in stat() for /proc/pid/fd
Message-ID: <20220919081850.4xgsuyvumi4y2xn7@wittgenstein>
References: <20220916230853.49056-1-ivan@cloudflare.com>
 <20220916170115.35932cba34e2cc2d923b03b5@linux-foundation.org>
 <YyV0AZ9+Zz4aopq4@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YyV0AZ9+Zz4aopq4@localhost.localdomain>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 17, 2022 at 10:15:13AM +0300, Alexey Dobriyan wrote:
> On Fri, Sep 16, 2022 at 05:01:15PM -0700, Andrew Morton wrote:
> > (cc's added)
> > 
> > On Fri, 16 Sep 2022 16:08:52 -0700 Ivan Babrou <ivan@cloudflare.com> wrote:
> > 
> > > Many monitoring tools include open file count as a metric. Currently
> > > the only way to get this number is to enumerate the files in /proc/pid/fd.
> > > 
> > > The problem with the current approach is that it does many things people
> > > generally don't care about when they need one number for a metric.
> > > In our tests for cadvisor, which reports open file counts per cgroup,
> > > we observed that reading the number of open files is slow. Out of 35.23%
> > > of CPU time spent in `proc_readfd_common`, we see 29.43% spent in
> > > `proc_fill_cache`, which is responsible for filling dentry info.
> > > Some of this extra time is spinlock contention, but it's a contention
> > > for the lock we don't want to take to begin with.
> > > 
> > > We considered putting the number of open files in /proc/pid/stat.
> > > Unfortunately, counting the number of fds involves iterating the fdtable,
> > > which means that it might slow down /proc/pid/stat for processes
> > > with many open files. Instead we opted to put this info in /proc/pid/fd
> > > as a size member of the stat syscall result. Previously the reported
> > > number was zero, so there's very little risk of breaking anything,
> > > while still providing a somewhat logical way to count the open files.
> > 
> > Documentation/filesystems/proc.rst would be an appropriate place to
> > document this ;)
> > 
> > > Previously:
> > > 
> > > ```
> > > $ sudo stat /proc/1/fd | head -n2
> > >   File: /proc/1/fd
> > >   Size: 0         	Blocks: 0          IO Block: 1024   directory
> > > ```
> > > 
> > > With this patch:
> > > 
> > > ```
> > > $ sudo stat /proc/1/fd | head -n2
> > >   File: /proc/1/fd
> > >   Size: 65        	Blocks: 0          IO Block: 1024   directory
> 
> Yes. This is natural place.
> 
> > > ```
> > > 
> > > Correctness check:
> > > 
> > > ```
> > > $ sudo ls /proc/1/fd | wc -l
> > > 65
> > > ```
> > > 
> > > There are two alternatives to this approach that I can see:
> > > 
> > > * Expose /proc/pid/fd_count with a count there
> 
> > > * Make fd count acces O(1) and expose it in /proc/pid/status
> 
> This is doable, next to FDSize.
> 
> Below is doable too.
> 
> > > --- a/fs/proc/fd.c
> > > +++ b/fs/proc/fd.c
> > > @@ -279,6 +279,29 @@ static int proc_readfd_common(struct file *file, struct dir_context *ctx,
> > >  	return 0;
> > >  }
> > >  
> > > +static int proc_readfd_count(struct inode *inode)
> > > +{
> > > +	struct task_struct *p = get_proc_task(inode);
> > > +	unsigned int fd = 0, count = 0;
> > > +
> > > +	if (!p)
> > > +		return -ENOENT;
> > > +
> > > +	rcu_read_lock();
> > > +	while (task_lookup_next_fd_rcu(p, &fd)) {
> > > +		rcu_read_unlock();
> > > +
> > > +		count++;
> > > +		fd++;
> > > +
> > > +		cond_resched();
> > > +		rcu_read_lock();
> > > +	}
> > > +	rcu_read_unlock();
> > > +	put_task_struct(p);
> > > +	return count;
> > > +}
> > > +
> > >  static int proc_readfd(struct file *file, struct dir_context *ctx)
> > >  {
> > >  	return proc_readfd_common(file, ctx, proc_fd_instantiate);
> > > @@ -319,9 +342,33 @@ int proc_fd_permission(struct user_namespace *mnt_userns,
> > >  	return rv;
> > >  }
> > >  
> > > +int proc_fd_getattr(struct user_namespace *mnt_userns,
> > > +			const struct path *path, struct kstat *stat,
> > > +			u32 request_mask, unsigned int query_flags)
> > > +{
> > > +	struct inode *inode = d_inode(path->dentry);
> > > +	struct proc_dir_entry *de = PDE(inode);
> > > +
> > > +	if (de) {
> > > +		nlink_t nlink = READ_ONCE(de->nlink);
> > > +
> > > +		if (nlink > 0)
> > > +			set_nlink(inode, nlink);
> > > +	}
> > > +
> > > +	generic_fillattr(&init_user_ns, inode, stat);
> 			 ^^^^^^^^^^^^^
> 
> Is this correct? I'm not userns guy at all.

This is correct. :)
