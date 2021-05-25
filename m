Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81BC138F727
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 May 2021 02:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbhEYA5c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 May 2021 20:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbhEYA5b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 May 2021 20:57:31 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A498CC061574;
        Mon, 24 May 2021 17:56:01 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id i22so43066236lfl.10;
        Mon, 24 May 2021 17:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iwPgpExyDKZsgLXrT4xIG6WED1NAUKao1HDPOwvP1cM=;
        b=I1dY/wyMxX4eKYhkdHv7dnOoRD5siW3zw8oU2dD18c8FFVaYnN3EPlmBbBPm5Vk50R
         9B/ApMJ9SkbptDmiGMMweGikbFwfIZDRrGa6ezRaT2Y3Iz1I7N6A5qq3JxwNMdHmKg22
         PGV0idXe0lm7O0Tgfaj9NrH+GtY5TqqQ5ELhCjIeeNXxFNi4NzxoOfy0614pyCWzodGl
         aJfaQMLwv84CagcRByOdafWQ6Oy1CyxVqFNFJFqJicUwSnuYUySAjAK7B+SYqzIwnc4u
         HFjy1E1W0gOzfCies0gYHXzEvq3WIQtJK09N+G3pbbkGayg7y4sukYeZRjoyN4EMRv+s
         4Kkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iwPgpExyDKZsgLXrT4xIG6WED1NAUKao1HDPOwvP1cM=;
        b=NNHQNHksOBARK4gxPfi8ZEQShrBhw3TMuknHIm/p2SLVmyyWbkxpfmTH6PDiFgU5ZC
         oieaxXTgzksVb1IBwoJI7fE9nTJ7FGfgF3IDFd5bni5gBTvfhyEKPVsi5bNS24Ltv1sO
         vm20p95/GzCPT6LZ+WtmZdkClLG588ScmbHM/vSnxrdr0Aa3GsfpxaYvN/rel4NjwVY3
         jdsuiMDwtyiP5lZNR+FgzXO9jb1DnE19iagLegBN6dkf612yIYIYyvJcwWzsTI+7Amlm
         QrgKputl4XSvH5SSCHXy1e0LFnpho4b7OaojyAGKsknDcFXl5GKqg+Z6JDURb4ZAT6KK
         4YNw==
X-Gm-Message-State: AOAM533QJJI8YsjYN72hUfifo4LLLzQiwkA+5oxD1iLsdgIOi90omwx/
        Lggw3rvU1tZ5JnDXSRSjW4fNnGTTRQ9LyPapt4g=
X-Google-Smtp-Source: ABdhPJwqz1V0kNtVJYrT5k+vYGEw0XBEvP6bEb8KOKHaFpWmqaZK47CwEG+K8Pd6ZjFtdWm5l92u/AxdihUWHL50cRk=
X-Received: by 2002:a19:ad44:: with SMTP id s4mr12232011lfd.563.1621904160020;
 Mon, 24 May 2021 17:56:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210520154244.20209-1-dong.menglong@zte.com.cn>
 <20210520214111.GV4332@42.do-not-panic.com> <CADxym3axowrQWz3OgimK4iGqP-RbO8U=HPODEhJRrcXUAsWXew@mail.gmail.com>
 <20210521155020.GW4332@42.do-not-panic.com> <CADxym3Z7bdEJECEejPqg-15ycghgX3ZEmOGWYwxZ1_HPWLU1NA@mail.gmail.com>
 <20210524225827.GA4332@42.do-not-panic.com>
In-Reply-To: <20210524225827.GA4332@42.do-not-panic.com>
From:   Menglong Dong <menglong8.dong@gmail.com>
Date:   Tue, 25 May 2021 08:55:48 +0800
Message-ID: <CADxym3akKEurTTGiBxYZiXKVWUbOg=a8UeuRsJ07tT+DixA8mw@mail.gmail.com>
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

Hello!

On Tue, May 25, 2021 at 6:58 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> > In fact, the network namespace is just a case for the problem that the
> > 'mount leak' caused. And this kind modification is not friendly to
> > current docker users, it makes great changes to the usage of docker.
>
> You mean an upgrade of docker? If so... that does not seem like a
> definitive reason to do something new in the kernel *always*.

No, I means that in this solution, users have to create all the
containers first,
and create the network namespace for them later.

>
> However, if you introduce it as a kconfig option so that users
> who want to use this new feature can enable it, and then use it,
> the its sold as a new feature.
>
> Should this always be enabled, or done this way? Should we never have
> the option to revert back to the old behaviour? If not, why not?
>

This change seems transparent to users, which don't change the behavior
of initramfs. However, it seems more reasonable to make it a kconfig option.
I'll do it in the v2 of the three patches I sended.

>
> I don't see you using any context directly, where are you specifying the
> context directly?
>
> > so it is not needed any more
> > and I just removed it in init_rootfs().
> >
> > The initialization of 'user_root' in init_rootfs() is used in:
> > do_populate_rootfs -> mount_user_root, which set the file system(
> > ramfs or tmpfs) of the second mount.
> >
> > Seems it's not suitable to place it in init_rootfs()......
>
> OK I think I just need to understand how you added the context of the
> first mount explicitly now and where, as I don't see it.
>

......

>
> What do you mean? init_mount_tree() is always called, and it has
> statically:
>
> static void __init init_mount_tree(void)
> {
>         struct vfsmount *mnt;
>         ...
>         mnt = vfs_kern_mount(&rootfs_fs_type, 0, "rootfs", NULL);
>         ...
> }
>
> And as I noted, this is *always* called earlier than
> do_populate_rootfs(). Your changes did not remove the init_mount_tree()
> or modify it, and so why would the context of the above call always
> be OK to be used now with a ramfs context now?
>
> > So it makes no sense to make the file system of the first mount selectable.
>
> Why? I don't see why, nor is it explained, we're always caling
> vfs_kern_mount(&rootfs_fs_type, ...) and you have not changed that
> either.
>
> > To simplify the code here, I make it ramfs_init_fs_context directly. In fact,
> > it's fine to make it shmen_init_fs_context here too.
>
> So indeed you're suggesting its arbitrary now.... I don't see why.
>

So the biggest problem now seems to be the first mount I changed, maybe I didn't
make it clear before.

Let's call the first mount which is created in init_mount_tree() the
'init_mount'.
If the 'root' is a block fs, initrd or nfs, the 'init_mount' will be a
ramfs, that seems
clear, it can be seen from the enable of tmpfs:

void __init init_rootfs(void)
{
    if (IS_ENABLED(CONFIG_TMPFS) && !saved_root_name[0] &&
       (!root_fs_names || strstr(root_fs_names, "tmpfs")))
       is_tmpfs = true;
}

That makes sense, because the 'init_mount' will not be the root file
system, as the
block fs or initrd or nfs that mounted later on '/root' will become
the root by a call of
init_chroot().

If the 'root' is initramfs, cpio will be unpacked init 'init_mount'.
In this scene, the
'init_mount' can be ramfs or tmpfs, and it is the root file system.

In my patch, I create a second mount which is mounted on the
'init_mount', let's call
it 'user_mount'.

cpio is unpacked into 'user_mount', and the 'user_mount' is made the
root by 'init_chroot()'
later. The 'user_mount' can be ramfs or tmpfs. So 'init_mount' is not
the root any more,
and it makes no sense to make it tmpfs, just like why it should be
ramfs when 'root'
is a block fs or initrd.

'init_mount' is created from 'rootfs_fs_type' in init_mount_tree():

static void __init init_mount_tree(void)
{
        struct vfsmount *mnt;
        ...
        mnt = vfs_kern_mount(&rootfs_fs_type, 0, "rootfs", NULL);
        ...
}

I make the 'init_mount' to be ramfs by making
'rootfs_fs_type->init_fs_context' with
'ramfs_init_fs_context':

struct file_system_type rootfs_fs_type = {
.name = "rootfs",
.init_fs_context = ramfs_init_fs_context,
.kill_sb = kill_litter_super,
};

I think the third patch that I sended has made it clear what I do to
the 'init_mount'.

Thanks!
Menglong Dong
