Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F365BB6E0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Sep 2022 09:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiIQHPV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Sep 2022 03:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiIQHPT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Sep 2022 03:15:19 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210622CDE6;
        Sat, 17 Sep 2022 00:15:18 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id e17so34465692edc.5;
        Sat, 17 Sep 2022 00:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=GW3G9CPyZ/e6f+PeJ0YJUBKqoF26V+P69n21Mik8xTY=;
        b=ooTxO4oKlg8NFE/ngWakqALuouhdnYGFQZFhWaW/lzvlcS1kdlo1Hw3/rmB64BmvyR
         tp99iVmkA5nn+5hSqOFee7umZaDXNadWLvX6hi+gq3Oirb4shHh/y9OcL/gni0LlGSQh
         1n7QbxTB4s5ebEGWTsoavbaz5K8nV0b5yZzoNLh8UyYJukn1wtiEbekwUJ32fsy7u+zW
         jlypfRECQia4gR4sM8tA6HoxK3PCjK91kqiKQEcJ0sgmvybo/DYVNDl41l34CdY8/mdx
         toZahZc0W7TYEDEKcV/XpsaUhMbsP3fXYgtzt06/fafZUe3szf+eM75T+Yugdu7PULC/
         DABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=GW3G9CPyZ/e6f+PeJ0YJUBKqoF26V+P69n21Mik8xTY=;
        b=nEuwPro9sAw6tvztkZ77FTb+yWAEGQ7R4FLNBBmz8GNK/I2RxbsWGNDRhxMcAKRtTZ
         3iIrMxOP7RA3JSfnFVR5iE4wklncA84WLg5B351y0LUeJMMNJcdD5p4dwZFQKoi6v44S
         cTOsMdg6oGwRUlM7MzDfUwBSAqmemRFLPHKoCtxOvjnXf+bufRdtXBHhZ1gJITcyblP0
         sdYV6FTVE76RJopdX6lnBIx7GEfxYnsdmfqyXl7Km/jUgGl/lGElvTn/4TZa/J23X9AQ
         BT1+o2Y9UTVt4Dj7wLFDe2HzwuvT52bhVBi5TWlRwcwxC4bBPo6el1931IJ4ql4Ll7sM
         QLeQ==
X-Gm-Message-State: ACrzQf3fLstPbUbQwg17iVWbSqyBBCH7z4Vha5+fNnLXl4Biax/rFII/
        W2rSn41ufM9ub1vHezK6Fw==
X-Google-Smtp-Source: AMsMyM6tBFmWeUJugtFTxJVYyiBhdoA6F5N5aw9uQArSzWaGvMJlmQXPGD+oNVY/CQxK2SV5u95a8Q==
X-Received: by 2002:a05:6402:3988:b0:44e:6f08:ddfb with SMTP id fk8-20020a056402398800b0044e6f08ddfbmr6776249edb.89.1663398916501;
        Sat, 17 Sep 2022 00:15:16 -0700 (PDT)
Received: from localhost.localdomain ([46.53.254.94])
        by smtp.gmail.com with ESMTPSA id gu2-20020a170906f28200b00718e4e64b7bsm11527318ejb.79.2022.09.17.00.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Sep 2022 00:15:15 -0700 (PDT)
Date:   Sat, 17 Sep 2022 10:15:13 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Ivan Babrou <ivan@cloudflare.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
        Kalesh Singh <kaleshsingh@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RFC] proc: report open files as size in stat() for /proc/pid/fd
Message-ID: <YyV0AZ9+Zz4aopq4@localhost.localdomain>
References: <20220916230853.49056-1-ivan@cloudflare.com>
 <20220916170115.35932cba34e2cc2d923b03b5@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220916170115.35932cba34e2cc2d923b03b5@linux-foundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 16, 2022 at 05:01:15PM -0700, Andrew Morton wrote:
> (cc's added)
> 
> On Fri, 16 Sep 2022 16:08:52 -0700 Ivan Babrou <ivan@cloudflare.com> wrote:
> 
> > Many monitoring tools include open file count as a metric. Currently
> > the only way to get this number is to enumerate the files in /proc/pid/fd.
> > 
> > The problem with the current approach is that it does many things people
> > generally don't care about when they need one number for a metric.
> > In our tests for cadvisor, which reports open file counts per cgroup,
> > we observed that reading the number of open files is slow. Out of 35.23%
> > of CPU time spent in `proc_readfd_common`, we see 29.43% spent in
> > `proc_fill_cache`, which is responsible for filling dentry info.
> > Some of this extra time is spinlock contention, but it's a contention
> > for the lock we don't want to take to begin with.
> > 
> > We considered putting the number of open files in /proc/pid/stat.
> > Unfortunately, counting the number of fds involves iterating the fdtable,
> > which means that it might slow down /proc/pid/stat for processes
> > with many open files. Instead we opted to put this info in /proc/pid/fd
> > as a size member of the stat syscall result. Previously the reported
> > number was zero, so there's very little risk of breaking anything,
> > while still providing a somewhat logical way to count the open files.
> 
> Documentation/filesystems/proc.rst would be an appropriate place to
> document this ;)
> 
> > Previously:
> > 
> > ```
> > $ sudo stat /proc/1/fd | head -n2
> >   File: /proc/1/fd
> >   Size: 0         	Blocks: 0          IO Block: 1024   directory
> > ```
> > 
> > With this patch:
> > 
> > ```
> > $ sudo stat /proc/1/fd | head -n2
> >   File: /proc/1/fd
> >   Size: 65        	Blocks: 0          IO Block: 1024   directory

Yes. This is natural place.

> > ```
> > 
> > Correctness check:
> > 
> > ```
> > $ sudo ls /proc/1/fd | wc -l
> > 65
> > ```
> > 
> > There are two alternatives to this approach that I can see:
> > 
> > * Expose /proc/pid/fd_count with a count there

> > * Make fd count acces O(1) and expose it in /proc/pid/status

This is doable, next to FDSize.

Below is doable too.

> > --- a/fs/proc/fd.c
> > +++ b/fs/proc/fd.c
> > @@ -279,6 +279,29 @@ static int proc_readfd_common(struct file *file, struct dir_context *ctx,
> >  	return 0;
> >  }
> >  
> > +static int proc_readfd_count(struct inode *inode)
> > +{
> > +	struct task_struct *p = get_proc_task(inode);
> > +	unsigned int fd = 0, count = 0;
> > +
> > +	if (!p)
> > +		return -ENOENT;
> > +
> > +	rcu_read_lock();
> > +	while (task_lookup_next_fd_rcu(p, &fd)) {
> > +		rcu_read_unlock();
> > +
> > +		count++;
> > +		fd++;
> > +
> > +		cond_resched();
> > +		rcu_read_lock();
> > +	}
> > +	rcu_read_unlock();
> > +	put_task_struct(p);
> > +	return count;
> > +}
> > +
> >  static int proc_readfd(struct file *file, struct dir_context *ctx)
> >  {
> >  	return proc_readfd_common(file, ctx, proc_fd_instantiate);
> > @@ -319,9 +342,33 @@ int proc_fd_permission(struct user_namespace *mnt_userns,
> >  	return rv;
> >  }
> >  
> > +int proc_fd_getattr(struct user_namespace *mnt_userns,
> > +			const struct path *path, struct kstat *stat,
> > +			u32 request_mask, unsigned int query_flags)
> > +{
> > +	struct inode *inode = d_inode(path->dentry);
> > +	struct proc_dir_entry *de = PDE(inode);
> > +
> > +	if (de) {
> > +		nlink_t nlink = READ_ONCE(de->nlink);
> > +
> > +		if (nlink > 0)
> > +			set_nlink(inode, nlink);
> > +	}
> > +
> > +	generic_fillattr(&init_user_ns, inode, stat);
			 ^^^^^^^^^^^^^

Is this correct? I'm not userns guy at all.

> > +
> > +	/* If it's a directory, put the number of open fds there */
> > +	if (S_ISDIR(inode->i_mode))
> > +		stat->size = proc_readfd_count(inode);

ENOENT can get there. In principle this is OK, userspace can live with it.

> >  const struct inode_operations proc_fd_inode_operations = {
> >  	.lookup		= proc_lookupfd,
> >  	.permission	= proc_fd_permission,
> > +	.getattr	= proc_fd_getattr,
> >  	.setattr	= proc_setattr,
