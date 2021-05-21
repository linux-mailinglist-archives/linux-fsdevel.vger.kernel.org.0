Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53FAB38BAE4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 May 2021 02:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235243AbhEUAnb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 May 2021 20:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbhEUAnb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 May 2021 20:43:31 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0398C061574;
        Thu, 20 May 2021 17:42:08 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id m11so27186518lfg.3;
        Thu, 20 May 2021 17:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+liHBLYLKvUnhVp+88fCYfRk1ncEY6YQF1v7EXNmXqo=;
        b=ixwDR/GoDwCYkEoMD2jfBGCkYT7BHfCLbapBdjCEDg6hAiCQXkc0EnRCNfd2QXnmsr
         GhuCbSzZNwld8wMdAtmcCf5hpyko1VgBYWUfjw2M/8dJaAZUuvg8DPxcwm1Q79SRT1x9
         rR2f2I39hEIz0UfCKDSItxXol0+yq4mcVquwi5mXWBPEHGxU+XoikOsr6wqozotj4tC+
         wkFzDp+ezM1n7WDKXIXNNeKgjcUtz1BZx+zLCA8dn/VlPU+/975VQ0GHeVMMSfDPSP/1
         dv2cxxDkqUSVy/fZF2XajbDLSNyM7DsrVFuG13Un4r/y07hvDvkQvkSBqWVOSvRWXpn5
         Ie3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+liHBLYLKvUnhVp+88fCYfRk1ncEY6YQF1v7EXNmXqo=;
        b=LwOmZS0X4vT3sTeZUwvSstSxh6KVVOTbVLmQA9z0/33dhVBNz2vgRQIyizwIZYqV3A
         cum0RHWnLkrbL3VsGCVc0PBdtRoDdM8FSuSt2sljuzt3VsiTfAzri5JXvomVUBbuFzcN
         Q78POs9Rs6+zPLaQwsSBOVlqKNQ7qk9kZhOKydtjfB+4y1/6xzH1Emqmdbiels7TsDJx
         CigDzXemMq6nf/HtK8Zbt/9TlgiDGYVu76NNS68pE98S8lpttM55t8fIzK5AzlYz8ghV
         Kht6bDoort/TrXdZo1daFLWoj8hzaJWJlNdYJ6H2/enaRosGkYVFw6U2SyGECauLm/+b
         DwzQ==
X-Gm-Message-State: AOAM533nRco6enu9KjVbrM4J0vPZLqMHglklek5wukZQ8ODOL+yRa1lF
        NJ82xmqN4IlYrbqEbTXnMsH25Ljos/iXIvM3674=
X-Google-Smtp-Source: ABdhPJx3CEuqBNDrhcpRpG4nooZL3zEDmot3v0keGCw+Ow9EjG7BUy0KkXppKTtjln+F6/GWEb+A6NDiaj36ITFtVBA=
X-Received: by 2002:a05:6512:3772:: with SMTP id z18mr120135lft.423.1621557726764;
 Thu, 20 May 2021 17:42:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210520154244.20209-1-dong.menglong@zte.com.cn> <20210520214111.GV4332@42.do-not-panic.com>
In-Reply-To: <20210520214111.GV4332@42.do-not-panic.com>
From:   Menglong Dong <menglong8.dong@gmail.com>
Date:   Fri, 21 May 2021 08:41:55 +0800
Message-ID: <CADxym3axowrQWz3OgimK4iGqP-RbO8U=HPODEhJRrcXUAsWXew@mail.gmail.com>
Subject: Re: [PATCH RESEND] init/initramfs.c: make initramfs support pivot_root
To:     Luis Chamberlain <mcgrof@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello!

Thanks for your reply!

On Fri, May 21, 2021 at 5:41 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> Can't docker instead allow to create containers prior to creating
> your local docker network namespace? Not that its a great solution,
> but just worth noting.
>

That's a solution, but I don't think it is feasible. Users may create many
containers, and you can't make docker create all the containers first
and create network namespace later, as you don't know if there are any
containers to create later.

> >
> >  struct file_system_type rootfs_fs_type = {
> >       .name           = "rootfs",
> > -     .init_fs_context = rootfs_init_fs_context,
> > +     .init_fs_context = ramfs_init_fs_context,
>
> Why is this always static now? Why is that its correct
> now for init_mount_tree() always to use the ramfs context?

Because the root mount in init_mount_tree() is not used as rootfs any more.
In do_populate_rootfs(), I mounted a second rootfs, which can be ramfs or
tmpfs, and that's the real rootfs for initramfs. And I call this root
as 'user_root',
because it is created for user space.

int __init mount_user_root(void)
{
       return do_mount_root(user_root->dev_name,
                            user_root->fs_name,
                            root_mountflags,
                            root_mount_data);
 }

In other words, I moved the realization of 'rootfs_fs_type' here to
do_populate_rootfs(), and fixed this 'rootfs_fs_type' with
ramfs_init_fs_context, as it is a fake root now.

Now, the rootfs that user space used is separated with the init_task,
and that's exactly what a block root file system does.

Thanks!
Menglong Dong
