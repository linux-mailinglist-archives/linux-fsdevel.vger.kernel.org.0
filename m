Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9174138CA68
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 May 2021 17:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbhEUPvs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 May 2021 11:51:48 -0400
Received: from mail-pl1-f172.google.com ([209.85.214.172]:46018 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbhEUPvr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 May 2021 11:51:47 -0400
Received: by mail-pl1-f172.google.com with SMTP id s4so9640101plg.12;
        Fri, 21 May 2021 08:50:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=60o19uG3Uo5g6e87CzW4o+uDrYBj0/S1vmD5UQ1AMh8=;
        b=BcPb2ZYFGHMwI57v8DfG8TnTUu/LFuGBhV9GyBDuL2AcuKhvCrnojSnLO05mVHAAc+
         93m7atneA2z/j471PZbwnYcmBqf9J60MNVhqus9JrNhtCsjlf1jn2nGB7N1fOPF6Q7aZ
         Umi/NEVMJ95nBKFe1SxcU8citQZTXWMqiYyDXXRij6xIAK8E9c5Elc/heon/BLNHKQi5
         pGcgwWuRgFFyIPRZf96kGo6gKi9W1yMdU31XtdGe01JIjaaw6B+ldPT8KudIl1hHNN7T
         G+1yA08U6ARKRF/l3E2Vcbb00+VKv3a31zoGIwK5cima3ip2iI1Z8v7WFLhp1L4OQ3tW
         X+ug==
X-Gm-Message-State: AOAM531xCx3gTZUbqluyI/8ySVrseTAVhv+C1mtyKMxZ3m7X4JtFTl5n
        F4cPZPZFnQtmLWiQ0hdOAfo=
X-Google-Smtp-Source: ABdhPJwrzncsvoLgqoiG5aI4Dng/0cs1R2ml4bkxiQ8CBKjM+V91ysl5hL/y33lWJAZbc/JP1o68rg==
X-Received: by 2002:a17:90a:c284:: with SMTP id f4mr11308629pjt.83.1621612222493;
        Fri, 21 May 2021 08:50:22 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id a9sm4699642pfl.57.2021.05.21.08.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 08:50:21 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id A2173402D7; Fri, 21 May 2021 15:50:20 +0000 (UTC)
Date:   Fri, 21 May 2021 15:50:20 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Menglong Dong <menglong8.dong@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        hare@suse.de, gregkh@linuxfoundation.org, tj@kernel.org,
        Menglong Dong <dong.menglong@zte.com.cn>, song@kernel.org,
        neilb@suse.de, Andrew Morton <akpm@linux-foundation.org>,
        wangkefeng.wang@huawei.com, f.fainelli@gmail.com, arnd@arndb.de,
        Barret Rhoden <brho@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        mhiramat@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>, vbabka@suse.cz,
        Alexander Potapenko <glider@google.com>, pmladek@suse.com,
        Chris Down <chris@chrisdown.name>, ebiederm@xmission.com,
        jojing64@gmail.com, LKML <linux-kernel@vger.kernel.org>,
        palmerdabbelt@google.com, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH RESEND] init/initramfs.c: make initramfs support
 pivot_root
Message-ID: <20210521155020.GW4332@42.do-not-panic.com>
References: <20210520154244.20209-1-dong.menglong@zte.com.cn>
 <20210520214111.GV4332@42.do-not-panic.com>
 <CADxym3axowrQWz3OgimK4iGqP-RbO8U=HPODEhJRrcXUAsWXew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADxym3axowrQWz3OgimK4iGqP-RbO8U=HPODEhJRrcXUAsWXew@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 21, 2021 at 08:41:55AM +0800, Menglong Dong wrote:
> Hello!
> 
> Thanks for your reply!
> 
> On Fri, May 21, 2021 at 5:41 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > Can't docker instead allow to create containers prior to creating
> > your local docker network namespace? Not that its a great solution,
> > but just worth noting.
> >
> 
> That's a solution, but I don't think it is feasible. Users may create many
> containers, and you can't make docker create all the containers first
> and create network namespace later, as you don't know if there are any
> containers to create later.

It doesn't seem impossible, but worth noting why inside the commit log
this was not a preferred option.

> > >  struct file_system_type rootfs_fs_type = {
> > >       .name           = "rootfs",
> > > -     .init_fs_context = rootfs_init_fs_context,
> > > +     .init_fs_context = ramfs_init_fs_context,
> >
> > Why is this always static now? Why is that its correct
> > now for init_mount_tree() always to use the ramfs context?
> 
> Because the root mount in init_mount_tree() is not used as rootfs any more.

We still have:

start_kernel() --> vfs_caches_init() --> mnt_init() --> 

mnt_init()
{
	...
	shmem_init();                                                           
	init_rootfs();                                                          
	init_mount_tree(); 
}

You've now modified init_rootfs() to essentially just set the new user_root,
and that's it. But we stil call init_mount_tree() even if we did set the
rootfs to use tmpfs.

> In do_populate_ro
> tmpfs, and that's the real rootfs for initramfs. And I call this root
> as 'user_root',
> because it is created for user space.
> 
> int __init mount_user_root(void)
> {
>        return do_mount_root(user_root->dev_name,
>                             user_root->fs_name,
>                             root_mountflags,
>                             root_mount_data);
>  }
> 
> In other words, I moved the realization of 'rootfs_fs_type' here to
> do_populate_rootfs(), and fixed this 'rootfs_fs_type' with
> ramfs_init_fs_context, as it is a fake root now.

do_populate_rootfs() is called from populate_rootfs() and that in turn
is a:

rootfs_initcall(populate_rootfs);

In fact the latest changes have made this to schedule asynchronously as
well. And so indeed, init_mount_tree() always kicks off first. So its
still unclear to me why the first mount now always has a fs context of
ramfs_init_fs_context, even if we did not care for a ramdisk.

Are you suggesting it can be arbitrary now?

> Now, the rootfs that user space used is separated with the init_task,
> and that's exactly what a block root file system does.

The secondary effort is a bit clearer, its the earlier part that is not
so clear yet to me at least.

Regardless, to help make the changes easier to review, I wonder if it
makes sense to split up your work into a few patches. First do what you
have done for init_rootfs() and the structure you added to replace the
is_tmpfs bool, and let initialization use it and the context. And then
as a second patch introduce the second mount effort.

  Luis
