Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5573738D356
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 May 2021 06:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbhEVELI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 May 2021 00:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbhEVELH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 May 2021 00:11:07 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A11EC061574;
        Fri, 21 May 2021 21:09:43 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id c15so26309905ljr.7;
        Fri, 21 May 2021 21:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aLOuqGqh0D2QtMz4/yH626A1Y6TwhCHhHfCW13F0hpY=;
        b=TdVjW03GGajLvDnC3aJxo6/yw9VbX/SuOin8GrejPw2HoVj3iH+paAbEbwdVCMFqqB
         cujb/ikBSjxz3JzvZRI9qi0lDgHZJtAhW5mUS6xdMhChRPPTf77I3m17K+bC7DV0UeTd
         CM6abmEVFptwqtthv/o/ZySiQdvRbDegxV6QbdmIggtPk719raQYoJT7os2Py3PJZomd
         nvlCoeJSDnPL4utI1B0zXxGPJiWyYkDfytrG1l3ZaJe8VKqAXxijdOeI482es20Egl0j
         cNa8ii/51PKMtdNsyRBk+sg+Keiyqyi+m/ZaQpbv8ubDl6LeFAX8oIkZu3sI1OInCar5
         abRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aLOuqGqh0D2QtMz4/yH626A1Y6TwhCHhHfCW13F0hpY=;
        b=jNRvJi6ZCxVpOk2tY8siSqBAqWDnHK0wrD7oz2T1DpGDzkiybrvEIdS4DjpKusyfC6
         LM9whuHwcxwkJ2T4pKkxsrFAeKCrQNHVf+oNIwxDGvuhNNJ1n+t2sJ75V0tvCvbWsaye
         ZrR4IGQVGlJkxIElZuADBUS3qvEUAYAtvsNHLqT2e79BUnN7obr0ePXcKgJazvELZU50
         qb/xdSSzwQh6Ku43JS5YnEyyVOIL05gvvMY02ZJEv7y0Q/lKmtozOpMNqbGZ93V2OQG4
         emMfXVrNyFTw1XJj6RSiymOZvD451dyhU8Ws5aKWnktAsenqQdChqg9VXB9v+/uCR1Ms
         TILg==
X-Gm-Message-State: AOAM5331NOzQEZJaOCYAGH4pPFBGPQEAQ7ZSuX1lvnFRoQekMmINc3fQ
        +E6lR+AQY+B+Ky5du1iP82cMswtH2x+0BvO5Ps0=
X-Google-Smtp-Source: ABdhPJwNewxybtjOUqNzOwEzaxNU038wpkYdjyTNx8VWYnj/FzACTLtUd2ZFMPCSzBw1uW9MGltRTcyZDTJpquPkvAA=
X-Received: by 2002:a2e:99cd:: with SMTP id l13mr9070096ljj.89.1621656581890;
 Fri, 21 May 2021 21:09:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210520154244.20209-1-dong.menglong@zte.com.cn>
 <20210520214111.GV4332@42.do-not-panic.com> <CADxym3axowrQWz3OgimK4iGqP-RbO8U=HPODEhJRrcXUAsWXew@mail.gmail.com>
 <20210521155020.GW4332@42.do-not-panic.com>
In-Reply-To: <20210521155020.GW4332@42.do-not-panic.com>
From:   Menglong Dong <menglong8.dong@gmail.com>
Date:   Sat, 22 May 2021 12:09:30 +0800
Message-ID: <CADxym3Z7bdEJECEejPqg-15ycghgX3ZEmOGWYwxZ1_HPWLU1NA@mail.gmail.com>
Subject: Re: [PATCH RESEND] init/initramfs.c: make initramfs support pivot_root
To:     Luis Chamberlain <mcgrof@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 21, 2021 at 11:50 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> > That's a solution, but I don't think it is feasible. Users may create many
> > containers, and you can't make docker create all the containers first
> > and create network namespace later, as you don't know if there are any
> > containers to create later.
>
> It doesn't seem impossible, but worth noting why inside the commit log
> this was not a preferred option.
>

In fact, the network namespace is just a case for the problem that the
'mount leak' caused. And this kind modification is not friendly to
current docker users, it makes great changes to the usage of docker.

>
> We still have:
>
> start_kernel() --> vfs_caches_init() --> mnt_init() -->
>
> mnt_init()
> {
>         ...
>         shmem_init();
>         init_rootfs();
>         init_mount_tree();
> }
>
> You've now modified init_rootfs() to essentially just set the new user_root,
> and that's it. But we stil call init_mount_tree() even if we did set the
> rootfs to use tmpfs.

The variate of 'is_tmpfs' is only used in 'rootfs_init_fs_context'. I used
ramfs_init_fs_context directly for rootfs, so it is not needed any more
and I just removed it in init_rootfs().

The initialization of 'user_root' in init_rootfs() is used in:
do_populate_rootfs -> mount_user_root, which set the file system(
ramfs or tmpfs) of the second mount.

Seems it's not suitable to place it in init_rootfs()......


> > In do_populate_ro
> > tmpfs, and that's the real rootfs for initramfs. And I call this root
> > as 'user_root',
> > because it is created for user space.
> >
> > int __init mount_user_root(void)
> > {
> >        return do_mount_root(user_root->dev_name,
> >                             user_root->fs_name,
> >                             root_mountflags,
> >                             root_mount_data);
> >  }
> >
> > In other words, I moved the realization of 'rootfs_fs_type' here to
> > do_populate_rootfs(), and fixed this 'rootfs_fs_type' with
> > ramfs_init_fs_context, as it is a fake root now.
>
> do_populate_rootfs() is called from populate_rootfs() and that in turn
> is a:
>
> rootfs_initcall(populate_rootfs);
>
> In fact the latest changes have made this to schedule asynchronously as
> well. And so indeed, init_mount_tree() always kicks off first. So its
> still unclear to me why the first mount now always has a fs context of
> ramfs_init_fs_context, even if we did not care for a ramdisk.
>
> Are you suggesting it can be arbitrary now?

With the existence of the new user_root, the first mount is not directly used
any more, so the filesystem type of it doesn't  matter.

So it makes no sense to make the file system of the first mount selectable.
To simplify the code here, I make it ramfs_init_fs_context directly. In fact,
it's fine to make it shmen_init_fs_context here too.

> > Now, the rootfs that user space used is separated with the init_task,
> > and that's exactly what a block root file system does.
>
> The secondary effort is a bit clearer, its the earlier part that is not
> so clear yet to me at least.
>
> Regardless, to help make the changes easier to review, I wonder if it
> makes sense to split up your work into a few patches. First do what you
> have done for init_rootfs() and the structure you added to replace the
> is_tmpfs bool, and let initialization use it and the context. And then
> as a second patch introduce the second mount effort.

I thinks it is a good idea. I will reorganize the code and split it into several
patches.

Thanks!
Menglong Dong
