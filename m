Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0198A397F39
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jun 2021 04:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhFBC6s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Jun 2021 22:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbhFBC6r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Jun 2021 22:58:47 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07FDC061574;
        Tue,  1 Jun 2021 19:57:04 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id 131so686400ljj.3;
        Tue, 01 Jun 2021 19:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f6Is0i1WWuAiX9FLSlbAA0Ntx7WXKcqgVfD6AgfT9IU=;
        b=KKjnQAMB0qNMMPK9CDN9GlvfCIuN8uZUvRQnswCeBUsiVBQowriJO11353kMp2B+KT
         EJys52/kfFTHv8GTw34we2BHbkMZEbWgI8kOEL+vdDSYcQXZe7NzE+0cQblDUxX4i7WL
         igVFD5ZQI+PhFV3BaTTiyKXukujfpY3UmdoFbCZuaVGFBZ7tPZIMcH2MmjYk76IeEuoO
         kj8gn3Xsv5W2Min9HKcUcZkEoJ1pYpCpIlqoWKkO01/w9E6A2i77ssQ1RzvoLa+Ecrra
         W4KRXc8pT0osXPW2PzDtwa9IWq2cDNIdWcnozDFo6Ey/BtC57gorKYqhgMqljfn4ToOb
         Qa1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f6Is0i1WWuAiX9FLSlbAA0Ntx7WXKcqgVfD6AgfT9IU=;
        b=pMTZILh1t7NCnpBZJKK9Tv6lVYH4l6WXhK0EG/9rp6hL0kh/HyiOgRSF3qHhq/Epe0
         3PXHvIzQLTbnUvb668YUQfIiJWqb0S34EGHGqnp6XIaGUyLWbCLFmN2YEQvYid2ORst1
         MqUK3pWm+wb20TVZ40KNuerqxC5bZOuduqsIe5bh/4yM8cwglDCXgXvB0bJ1ocpJ9oLs
         jCCIHKqPTyFVdJc5x1PGplATI90Yom3lPgtSPjWnjB6g5mhPQyz2P/MIGUWaXLAh0f2U
         Z612eN3zzu5PKzhlqYS7MUNk0rc15R6ANqeRWTOUjewqf8bxpDC9llQfTQBxSyVKoSj7
         Q72g==
X-Gm-Message-State: AOAM530jifQ6UzLAal5ghUgqlWB9sRIlpfoBVO5oWPIncUpE5cdVGJch
        iz5qLxuHdu2fxZRGSmT8TEGdEf+zsFNutMEkDxDb0By5Fp+kZw==
X-Google-Smtp-Source: ABdhPJxQoNCcsX7iV/vEDWx6JWxLRtExRM6x7xW1mF4c9BhJXaV9luKD+SiPOrS6FyNRjLB1bMHVTlxyPaxopmxJ/P8=
X-Received: by 2002:a2e:9a14:: with SMTP id o20mr23799376lji.309.1622602623137;
 Tue, 01 Jun 2021 19:57:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210528143802.78635-1-dong.menglong@zte.com.cn>
 <20210528143802.78635-3-dong.menglong@zte.com.cn> <20210601143928.b2t2xwxnqma5h6li@wittgenstein>
In-Reply-To: <20210601143928.b2t2xwxnqma5h6li@wittgenstein>
From:   Menglong Dong <menglong8.dong@gmail.com>
Date:   Wed, 2 Jun 2021 10:56:50 +0800
Message-ID: <CADxym3YJETHbqg44VXN9bjhfD4ARTZBq74OEpXqs7UE6_vpPZg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] init/do_cmounts.c: introduce 'user_root' for initramfs
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>, ojeda@kernel.org,
        johan@kernel.org, jeyu@kernel.org, masahiroy@kernel.org,
        Menglong Dong <dong.menglong@zte.com.cn>, joe@perches.com,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        hare@suse.de, tj@kernel.org, gregkh@linuxfoundation.org,
        song@kernel.org, NeilBrown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        f.fainelli@gmail.com, wangkefeng.wang@huawei.com, arnd@arndb.de,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Barret Rhoden <brho@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, vbabka@suse.cz,
        pmladek@suse.com, Alexander Potapenko <glider@google.com>,
        Chris Down <chris@chrisdown.name>, jojing64@gmail.com,
        "Eric W. Biederman" <ebiederm@xmission.com>, mingo@kernel.org,
        terrelln@fb.com, geert@linux-m68k.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 1, 2021 at 10:39 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
[...]
>
> This code is duplicated below in this file
>
> void __init init_rootfs(void)
> {
>         if (IS_ENABLED(CONFIG_TMPFS) && !saved_root_name[0] &&
>                 (!root_fs_names || strstr(root_fs_names, "tmpfs")))
>                 is_tmpfs = true;
> }
>
> so you should add a tiny inline helper that can be called in both
> places. Will also allow you to get rid of one ifdef and makes the patch
> smaller.

Seems the code here is indeed duplicated, I'll replace it with an inline
function.

[...]
> > +
> > +/*
> > + * The syscall 'pivot_root' is used to change root and it is able to
> > + * clean the old mounts, which make it preferred by container platforms
> > + * such as Docker. However, initramfs is not supported by pivot_root,
> > + * and 'chroot()' has to be used, which is unable to clean the mounts
> > + * that propagate from HOST. These useless mounts make the release of
> > + * removable device or network namespace a big problem.
> > + *
> > + * To make initramfs supported by pivot_root, the mount of the root
> > + * filesystem should have a parent, which will make it unmountable. In
> > + * this function, the second mount, which is called 'user root', is
> > + * created and mounted on '/root', and it will be made the root filesystem
> > + * in end_mount_user_root() by init_chroot().
> > + *
> > + * The 'user root' has a parent mount, which makes it unmountable and
> > + * pivot_root work.
> > + *
> > + * What's more, root_mountflags and root_mount_data are used here, which
> > + * makes the 'rootflags' in boot cmd work for 'user root'.
>
> I appreciate the detail but most of that should go in the commit
> message it also repeats some info a couple of times. :) Here sm like the
> following should suffice, I think:
>
> /*
>  * Give systems running from the initramfs and making use of pivot_root a
>  * proper mount so it can be umounted during pivot_root.
>  */

I added the comments here to make the folks understand what these changes
are for, as LuisChamberlain suggested. Do you think that it is
unnecessary and the commit message is enough for users to understand this
function?

[...]
> > +
> >  static ssize_t __init xwrite(struct file *file, const char *p, size_t count,
> >               loff_t *pos)
> >  {
> > @@ -682,15 +684,23 @@ static void __init do_populate_rootfs(void *unused, async_cookie_t cookie)
> >       else
> >               printk(KERN_INFO "Unpacking initramfs...\n");
> >
> > +     init_user_rootfs();
> > +
> > +     if (mount_user_root())
>
> I would call this sm like
>
> prepare_mount_rootfs()
> finish_mount_rootfs()

Yeah, this name seems better! I'll change it.

>
> > +             panic("Failed to create user root");
>
> I don't think you need to call init_user_rootfs() separately? You could
> just move it into the prepare_mount_rootfs()/mount_user_root() call.

After rename 'mount_user_root()' to 'prepare_mount_rootfs()', it seems
reasonable to call 'init_user_rootfs()' in 'prepare_mount_rootfs()'.

>
> > +
> >       err = unpack_to_rootfs((char *)initrd_start, initrd_end - initrd_start);
> >       if (err) {
> > +             end_mount_user_root(false);
>
> This boolean argument to end_mount_user_root() is a bit strange. Just
> call init_umount() directly here?

I don't think it is suitable to call init_umount() directly here. Before
umount, 'init_chdir("/")' should be called too, and it seems a little
weird to do these stuff in do_populate_rootfs().

According to the result, finish_mount_rootfs() will change root to the new
mount or fall back and do the clean work, it seems fine.

>
> >  #ifdef CONFIG_BLK_DEV_RAM
> >               populate_initrd_image(err);
> >  #else
> >               printk(KERN_EMERG "Initramfs unpacking failed: %s\n", err);
> >  #endif
> > +             goto done;
> >       }
> >
> > +     end_mount_user_root(true);
> >  done:
> >       /*
> >        * If the initrd region is overlapped with crashkernel reserved region,
> > diff --git a/usr/Kconfig b/usr/Kconfig
> > index 8bbcf699fe3b..f9c96de539c3 100644
> > --- a/usr/Kconfig
> > +++ b/usr/Kconfig
> > @@ -52,6 +52,16 @@ config INITRAMFS_ROOT_GID
> >
> >         If you are not sure, leave it set to "0".
> >
> > +config INITRAMFS_USER_ROOT
>
> I think the naming isn't great. Just call it INITRAMFS_MOUNT. The "user"
> part in all the function and variabe names seems confusing to me at
> least it doesn't convey a lot of useful info. So I'd just drop it and
> try to stick with plain rootfs/initramfs terminology.

Yeah, it now appears that 'user' seems indeed weird here. I thought that
this mount is created for user space, seems kernel is using it too. I'll
clean these 'user'.

I appreciate your detail comments, thank you!



Thanks!
Menglong Dong
