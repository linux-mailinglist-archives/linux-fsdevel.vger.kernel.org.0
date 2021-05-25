Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D954338F7A4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 May 2021 03:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbhEYBog (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 May 2021 21:44:36 -0400
Received: from mail-pf1-f170.google.com ([209.85.210.170]:45987 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbhEYBog (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 May 2021 21:44:36 -0400
Received: by mail-pf1-f170.google.com with SMTP id d16so22318290pfn.12;
        Mon, 24 May 2021 18:43:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0oqSXpZzradp5Zo/ArJgl1DR73porgfQSQ9emcPhZCI=;
        b=U0iPb8uuqegZKN4c2f2NlNJFDZ+1ZbRpvjPEmiXG36Y6MOgfSieAxp25R572sBIlk4
         MfL4j4CCM+/K3ms07lrYN0wf0GCoh8vx///N1iZE1l96NCf7Wvh4A63gOuTHnczYO33o
         Pdn9K6kQ24rslqKDvZ+eg+CYvYia1bFlihiH2Icx6W/sguK6VKk5OygNKoXrsi3Trs1B
         nxq7iervLKfjfayw1HXJiQIalftn8fwohEzHI2Da2FlesCpX+o9AESqLEFCg3FaE3uHz
         B9XABG6NC3XPT7tDk4CtdUAVU+QMV7yv4l+2MkSYY0eLQVaBxGGqrAkC6+isfQw2W5Bc
         YuNw==
X-Gm-Message-State: AOAM530FG5Jh4kR1Y3EelzlGCj/ymWfHn8BgWk5fl4HHmGLY7ksQX0n0
        SmUqxTQBkpBtqOTVZ8BiG3Q=
X-Google-Smtp-Source: ABdhPJzJ58M4UJCtps9mLIJEzmfJMs1MGhvR1rBmd0Yt1mCHBRdWfKECHL8mOFrrSHSnXtaHjszqrQ==
X-Received: by 2002:a05:6a00:bc2:b029:2df:93cc:371a with SMTP id x2-20020a056a000bc2b02902df93cc371amr27408187pfu.12.1621906986056;
        Mon, 24 May 2021 18:43:06 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id y190sm12784817pgd.24.2021.05.24.18.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 18:43:05 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 413464025E; Tue, 25 May 2021 01:43:04 +0000 (UTC)
Date:   Tue, 25 May 2021 01:43:04 +0000
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
Message-ID: <20210525014304.GH4332@42.do-not-panic.com>
References: <20210520154244.20209-1-dong.menglong@zte.com.cn>
 <20210520214111.GV4332@42.do-not-panic.com>
 <CADxym3axowrQWz3OgimK4iGqP-RbO8U=HPODEhJRrcXUAsWXew@mail.gmail.com>
 <20210521155020.GW4332@42.do-not-panic.com>
 <CADxym3Z7bdEJECEejPqg-15ycghgX3ZEmOGWYwxZ1_HPWLU1NA@mail.gmail.com>
 <20210524225827.GA4332@42.do-not-panic.com>
 <CADxym3akKEurTTGiBxYZiXKVWUbOg=a8UeuRsJ07tT+DixA8mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADxym3akKEurTTGiBxYZiXKVWUbOg=a8UeuRsJ07tT+DixA8mw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 25, 2021 at 08:55:48AM +0800, Menglong Dong wrote:
> On Tue, May 25, 2021 at 6:58 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > However, if you introduce it as a kconfig option so that users
> > who want to use this new feature can enable it, and then use it,
> > the its sold as a new feature.
> >
> > Should this always be enabled, or done this way? Should we never have
> > the option to revert back to the old behaviour? If not, why not?
> >
> 
> This change seems transparent to users, which don't change the behavior
> of initramfs. 

Are we sure there nothing in the kernel that can regress with this
change? Are you sure? How sure?

> However, it seems more reasonable to make it a kconfig option.
> I'll do it in the v2 of the three patches I sended.

I'm actually quite convinced now this is a desirable default *other*
than the concern if this could regress. I recently saw some piece of
code fetching for the top most mount, I think it was on the
copy_user_ns() path or something like that, which made me just
consider possible regressions for heuristics we might have forgotten
about.

I however have't yet had time to review the path I was concerned for
yet.

> > What do you mean? init_mount_tree() is always called, and it has
> > statically:
> >
> > static void __init init_mount_tree(void)
> > {
> >         struct vfsmount *mnt;
> >         ...
> >         mnt = vfs_kern_mount(&rootfs_fs_type, 0, "rootfs", NULL);
> >         ...
> > }
> >
> > And as I noted, this is *always* called earlier than
> > do_populate_rootfs(). Your changes did not remove the init_mount_tree()
> > or modify it, and so why would the context of the above call always
> > be OK to be used now with a ramfs context now?
> >
> > > So it makes no sense to make the file system of the first mount selectable.
> >
> > Why? I don't see why, nor is it explained, we're always caling
> > vfs_kern_mount(&rootfs_fs_type, ...) and you have not changed that
> > either.
> >
> > > To simplify the code here, I make it ramfs_init_fs_context directly. In fact,
> > > it's fine to make it shmen_init_fs_context here too.
> >
> > So indeed you're suggesting its arbitrary now.... I don't see why.
> >
> 
> So the biggest problem now seems to be the first mount I changed, maybe I didn't
> make it clear before.
> 
> Let's call the first mount which is created in init_mount_tree() the
> 'init_mount'.
> If the 'root' is a block fs, initrd or nfs, the 'init_mount' will be a
> ramfs, that seems
> clear, it can be seen from the enable of tmpfs:
> 
> void __init init_rootfs(void)
> {
>     if (IS_ENABLED(CONFIG_TMPFS) && !saved_root_name[0] &&
>        (!root_fs_names || strstr(root_fs_names, "tmpfs")))
>        is_tmpfs = true;
> }

Ah yes, I see now... Thanks!
 
  Luis
