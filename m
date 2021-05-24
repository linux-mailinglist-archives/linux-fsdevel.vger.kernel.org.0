Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2748638F5F6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 May 2021 00:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbhEXW77 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 May 2021 18:59:59 -0400
Received: from mail-pg1-f170.google.com ([209.85.215.170]:41956 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbhEXW77 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 May 2021 18:59:59 -0400
Received: by mail-pg1-f170.google.com with SMTP id r1so6353126pgk.8;
        Mon, 24 May 2021 15:58:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x+Vw1vTu0QmIaUSfKZb4qqGrLso9ZIGt1u68HUOBSRM=;
        b=hNjxnk1OnFaWZVhVH7Bkf5g2e8oaLEYanux0eV81X/DZw2VSU/1F9u3R56mW/EQfpu
         rn93H/8Viedyh340nCtoDhgmjMtSi8kVrxGLe7l+p4t4eMPXfBWAn3H6PlVELpp8SEb2
         ciwH73ZKCbe3cCAKVLzQf/+tk9dh7stLhBol1vuU6krspF/unGaX4BilQcBzbLqG7iJs
         VL8Ez1J+PiVudzuYxA2l3ZYav4BS64BQjDBxclhGn+XtwV2mhPc/40gPRb6LSLeKeaWp
         XvzMC+igmODms58IQUt+DsuUT+r+9RHfuf+NknU0xQ7KaqYn7jsOZqd0XMnJBFN7dGoF
         7x8Q==
X-Gm-Message-State: AOAM533UHe5arjAbL29m2yGjIeS0Djca6GgPVp9w2jOkeoob7wWnYGa8
        6KChBGwIIf+rlqIQ/wbkl/o=
X-Google-Smtp-Source: ABdhPJwpw5NG3yxJWXj1a0idruoNsJtWN1fiESIpnB9mYWXAknw5yuI6w4SaM8m78mE2kIFHTVWrkw==
X-Received: by 2002:a63:8449:: with SMTP id k70mr15947936pgd.392.1621897109144;
        Mon, 24 May 2021 15:58:29 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id r10sm7075716pga.48.2021.05.24.15.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 15:58:28 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 30AEC401AD; Mon, 24 May 2021 22:58:27 +0000 (UTC)
Date:   Mon, 24 May 2021 22:58:27 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Menglong Dong <menglong8.dong@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        hare@suse.de, gregkh@linuxfoundation.org, tj@kernel.org,
        Menglong Dong <dong.menglong@zte.com.cn>, song@kernel.org,
        NeilBrown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <20210524225827.GA4332@42.do-not-panic.com>
References: <20210520154244.20209-1-dong.menglong@zte.com.cn>
 <20210520214111.GV4332@42.do-not-panic.com>
 <CADxym3axowrQWz3OgimK4iGqP-RbO8U=HPODEhJRrcXUAsWXew@mail.gmail.com>
 <20210521155020.GW4332@42.do-not-panic.com>
 <CADxym3Z7bdEJECEejPqg-15ycghgX3ZEmOGWYwxZ1_HPWLU1NA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADxym3Z7bdEJECEejPqg-15ycghgX3ZEmOGWYwxZ1_HPWLU1NA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 22, 2021 at 12:09:30PM +0800, Menglong Dong wrote:
> On Fri, May 21, 2021 at 11:50 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > > That's a solution, but I don't think it is feasible. Users may create many
> > > containers, and you can't make docker create all the containers first
> > > and create network namespace later, as you don't know if there are any
> > > containers to create later.
> >
> > It doesn't seem impossible, but worth noting why inside the commit log
> > this was not a preferred option.
> >
> 
> In fact, the network namespace is just a case for the problem that the
> 'mount leak' caused. And this kind modification is not friendly to
> current docker users, it makes great changes to the usage of docker.

You mean an upgrade of docker? If so... that does not seem like a
definitive reason to do something new in the kernel *always*.

However, if you introduce it as a kconfig option so that users
who want to use this new feature can enable it, and then use it,
the its sold as a new feature.

Should this always be enabled, or done this way? Should we never have
the option to revert back to the old behaviour? If not, why not?

> > We still have:
> >
> > start_kernel() --> vfs_caches_init() --> mnt_init() -->
> >
> > mnt_init()
> > {
> >         ...
> >         shmem_init();
> >         init_rootfs();
> >         init_mount_tree();
> > }
> >
> > You've now modified init_rootfs() to essentially just set the new user_root,
> > and that's it. But we stil call init_mount_tree() even if we did set the
> > rootfs to use tmpfs.
> 
> The variate of 'is_tmpfs' is only used in 'rootfs_init_fs_context'. I used
> ramfs_init_fs_context directly for rootfs,

I don't see you using any context directly, where are you specifying the
context directly?

> so it is not needed any more
> and I just removed it in init_rootfs().
>
> The initialization of 'user_root' in init_rootfs() is used in:
> do_populate_rootfs -> mount_user_root, which set the file system(
> ramfs or tmpfs) of the second mount.
> 
> Seems it's not suitable to place it in init_rootfs()......

OK I think I just need to understand how you added the context of the
first mount explicitly now and where, as I don't see it.

> > > In do_populate_ro
> > > tmpfs, and that's the real rootfs for initramfs. And I call this root
> > > as 'user_root',
> > > because it is created for user space.
> > >
> > > int __init mount_user_root(void)
> > > {
> > >        return do_mount_root(user_root->dev_name,
> > >                             user_root->fs_name,
> > >                             root_mountflags,
> > >                             root_mount_data);
> > >  }
> > >
> > > In other words, I moved the realization of 'rootfs_fs_type' here to
> > > do_populate_rootfs(), and fixed this 'rootfs_fs_type' with
> > > ramfs_init_fs_context, as it is a fake root now.
> >
> > do_populate_rootfs() is called from populate_rootfs() and that in turn
> > is a:
> >
> > rootfs_initcall(populate_rootfs);
> >
> > In fact the latest changes have made this to schedule asynchronously as
> > well. And so indeed, init_mount_tree() always kicks off first. So its
> > still unclear to me why the first mount now always has a fs context of
> > ramfs_init_fs_context, even if we did not care for a ramdisk.
> >
> > Are you suggesting it can be arbitrary now?
> 
> With the existence of the new user_root, the first mount is not directly used
> any more, so the filesystem type of it doesn't  matter.

What do you mean? init_mount_tree() is always called, and it has
statically:

static void __init init_mount_tree(void)                                        
{                                                                               
	struct vfsmount *mnt;
	...
	mnt = vfs_kern_mount(&rootfs_fs_type, 0, "rootfs", NULL);
	...
}

And as I noted, this is *always* called earlier than
do_populate_rootfs(). Your changes did not remove the init_mount_tree()
or modify it, and so why would the context of the above call always
be OK to be used now with a ramfs context now?

> So it makes no sense to make the file system of the first mount selectable.

Why? I don't see why, nor is it explained, we're always caling
vfs_kern_mount(&rootfs_fs_type, ...) and you have not changed that
either.

> To simplify the code here, I make it ramfs_init_fs_context directly. In fact,
> it's fine to make it shmen_init_fs_context here too.

So indeed you're suggesting its arbitrary now.... I don't see why.

  Luis
