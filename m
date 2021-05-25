Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A117238F8C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 May 2021 05:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbhEYDaF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 May 2021 23:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhEYDaE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 May 2021 23:30:04 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55558C061574;
        Mon, 24 May 2021 20:28:33 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id w7so22910500lji.6;
        Mon, 24 May 2021 20:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=65k4WCFOtHqMEgupbM4UcMJU/owSoQbR1hZEEycmMGw=;
        b=JqNwzyU97zIIY46O4vksPHzJXx3fnvuuztr06AwLqhGRvUlxBVnNY7awl+r0fLSV7y
         V3WXXVfNyydNOmuJbVklEbbt7WNGqRefHb/RQK4xCdiA7yaNCCkdHsQZY2/uG697MfYl
         h0nggBJw9xhwpYDzuIZDSXiVbsoRfDbVsv76GHXt8+c2/c06VK7ZVB3B97J3RlBMuStU
         1qKczwxu8AogIFL1QGuDbla/DaNJE6+trs//LypL3CuDKpPap3Fc2s/qeTw8ImpX9kyO
         ulwzX8Sfw05ZDLOCYkIGsJrg9b1jstkSCJ0azkkuM7arTnZ5cAcfSPlM6FhXjb78eBRq
         a2TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=65k4WCFOtHqMEgupbM4UcMJU/owSoQbR1hZEEycmMGw=;
        b=LpaE41+y1bxFYEA8KSVMvT4LxYr+1ZJLzXbFL4QAKYfNX7kD/ThRkkcH6V0xQFt9xn
         OJQDqtvW7jt5hYO7/Lx6u9gsx/eck0b7cqVKJUHy90sOtVBtEy2pFnHuL1Kda+ANARx3
         imLXNgRhm9EEVLktlH7Xr1MYYhiMw+yoG6yJsvyYLdbzPilBkIWM/G3/1dDJtanvqpnZ
         R24ytf+gfUaAedk8+gjIngWqubLaV/Oi3s65kO1oACYOdKEZr/sVom2L3+JdWpIATPNN
         u/otBLvRs/P5ETTZcu3Pe3BCQBe0UrybJja7z6AeEYAJLoao30EDXR1Isk7V+NuC17vs
         sGrQ==
X-Gm-Message-State: AOAM532GQZWNuzxHX0GYo/XL81Ae8yNpKY+fXSmhTaK3YAr2k263Nc+x
        iUHsCA3zIm+53VHkchHRgQNGwICJU10kVw3984E=
X-Google-Smtp-Source: ABdhPJzkrQ7/XdXfoYOOApgeA+xn5jqgg/BEE79LeXSGanqSD9Vl0LyNOwY9epH8hbO3n1VOcGYf7V5Soa8FH7/2PLY=
X-Received: by 2002:a2e:5347:: with SMTP id t7mr19166683ljd.464.1621913311671;
 Mon, 24 May 2021 20:28:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210522113155.244796-1-dong.menglong@zte.com.cn>
 <20210522113155.244796-3-dong.menglong@zte.com.cn> <20210525004422.GB4332@42.do-not-panic.com>
In-Reply-To: <20210525004422.GB4332@42.do-not-panic.com>
From:   Menglong Dong <menglong8.dong@gmail.com>
Date:   Tue, 25 May 2021 11:28:19 +0800
Message-ID: <CADxym3bg=-swV_PbVhwTHwED=5WHzq6779xLQFnaagRai0gJCA@mail.gmail.com>
Subject: Re: [PATCH 2/3] init/do_cmounts.c: introduce 'user_root' for initramfs
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>, johan@kernel.org,
        ojeda@kernel.org, jeyu@kernel.org, joe@perches.com,
        Menglong Dong <dong.menglong@zte.com.cn>, masahiroy@kernel.org,
        Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        hare@suse.de, gregkh@linuxfoundation.org, tj@kernel.org,
        song@kernel.org, NeilBrown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Barret Rhoden <brho@google.com>, f.fainelli@gmail.com,
        wangkefeng.wang@huawei.com, arnd@arndb.de,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        mhiramat@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        vbabka@suse.cz, Alexander Potapenko <glider@google.com>,
        pmladek@suse.com, ebiederm@xmission.com, jojing64@gmail.com,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 25, 2021 at 8:44 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> Cc'ing Josh as I think he might be interested in this.
>
......
>
> I think you can clarify this a bit more with:
>
>   If using container platforms such as Docker, upon initialization it
>   wants to use pivot_root() so that currently mounted devices do not
>   propagate to containers. An example of value in this is that
>   a USB device connected prior to the creation of a containers on the
>   host gets disconnected after a container is created; if the
>   USB device was mounted on containers, but already removed and
>   umounted on the host, the mount point will not go away untill all
>   containers unmount the USB device.

Thanks! It's really difficult for me to organize these words.

>
> So remind me.. so it would seem that if the rootfs uses a ramfs (initrd)
> that pivot_root works just fine. Why is that? Did someone add support
> for that? Has that always been the case that it works? If not, was it a
> consequence of how ramfs (initrd) works?
>
> And finally, why can't we share the same mechanism used for ramfs
> (initrd) for initramfs (tmpfs)?

In fact, initrd is totally different from initramfs. Initrd is not using
ramfs, it actually is a block fs, which is mounted on the first mount.
And initramfs can use ramfs or tmpfs.

During pivot_root, the mount of the root will be unmounted from its parent
mount. Initrd or block device fs has a parent mount, which is the first mount.
However, initramfs doesn't has a parent mount, because the first mount is
actually the root, which cpio is unpacked to.

The first mount is used by init_task, and I think it can't be unmounted,
because it is used by the kernel.

So the primary cause that pivot_root doesn't support is that it use
the first mount as its root.

>
> > What's more, after this patch, 'rootflags' in boot cmd is supported
> > by initramfs. Therefore, users can set the size of tmpfs with
> > 'rootflags=size=1024M'.
>
> Why is that exactly?

During the mount of user_mount, I passed root_mountflags and root_mount_data
to do_mount_root(), which make 'rootflags' works for 'user root'.

> > +
> > +struct fs_user_root {
> > +    bool (*enabled)(void);
> > +    char *dev_name;
>
> What's the point of dev_name if its never set?

Seems it's better to make it be set, I'll do it.


>
> Might be a good place to document that we do this so folks can
> pivot_root on rootfs, and why that is desirable (mentioned above on the
> commit log edits I suggested). Otherwise I don't think its easy for a
> reader of the code to understand why we are doing all this work.
>

Ok, sounds nice!

>
> Is anything extra needed on shutdown / reboot?
>

I'm not sure, seems no. The way I create 'user root' is exactly the same
as a block root fs does.

Thanks!
Menglong Dong
