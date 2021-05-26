Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBB4390E0B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 May 2021 03:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbhEZBxK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 21:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbhEZBxJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 21:53:09 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6266DC061756;
        Tue, 25 May 2021 18:51:37 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id i22so30670lfl.10;
        Tue, 25 May 2021 18:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UAxjsIBVH89CD1bUGFbnmD6O+wclffTpv+v2E/nicMs=;
        b=gA1FwHT0jeTJ0wJ4xQ5M/P0uoCjTonGA1/xGpROefOUJRc/Js/yQvprSfFeuNfZSbq
         PVt/rFt/tna1GV6/6LdMCkBEWTJEPuTOKZN8qTK2n4RuQdipL5r+qbZsB6cuc/SViiid
         Fw83Qf6QE/wxUEmGcu4FPgRYrE95cqtmNzNQIYq+VCB4FQgXe31E7FZqxxWLp/JQ5f3C
         xd7tric3D7RrCzwC3HCtx5oQzSHtPEdZdfXwRRATsTWolGgZIUafUfGBAnaI7WGfEkbE
         gm3Nub50jQ4BuM+vaAKsukyUGu1L899NhSQD2lwIE9TYJihsdgU4v8GUsQgT/5cipFwJ
         It9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UAxjsIBVH89CD1bUGFbnmD6O+wclffTpv+v2E/nicMs=;
        b=Q1S1OcYLi4uYdAnYb23Uh/8lISUjcpMjSXQz2/nAuAjxIhQJ8TV28cEyvaln+G/qKr
         K4T5W76jIeAN+yRJocVYoSO30GG0u/IXRz6iv9HGZzoVRwRhMQq9QlAzkHr7QMrrbcxQ
         NjTUOTmuUe/O/qF5i7t4+/7/SuDeEoWJDjG+XX9ZbDDjxt+xATkbzJ2q1Wz9hzSVDpjM
         RQuNAYvOPHZTd6GIqolevOe3B7mHWRp8sOa1KKhXpjl6YZ8f+Jlm70YZDkH7dOFzeRg+
         i8RupvI5SxypsjSDNI3Z/2o0pNLBwkSyTkp5w37iSletV5zDTHWzWDKKV91r93vxwJTz
         rMwg==
X-Gm-Message-State: AOAM531OEIunkQKOkPpvJTsnOlQ9g6cC/wT91u72GH5By5LSODu9EBJz
        Of3J+T5bpTltN7uB3JO7atGR4uF+gS+ez638vB4=
X-Google-Smtp-Source: ABdhPJyQ2r4SVsJPAjCygqWsXRxSUaK4vlOx/Ev/SVtU74fAIZZ6bMY+hz7hd5YAA9TqHpvOn6PPrsPr/jkb8aTX/Fw=
X-Received: by 2002:ac2:48ba:: with SMTP id u26mr403087lfg.108.1621993894963;
 Tue, 25 May 2021 18:51:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210525141524.3995-1-dong.menglong@zte.com.cn>
 <20210525141524.3995-3-dong.menglong@zte.com.cn> <m18s42odgz.fsf@fess.ebiederm.org>
In-Reply-To: <m18s42odgz.fsf@fess.ebiederm.org>
From:   Menglong Dong <menglong8.dong@gmail.com>
Date:   Wed, 26 May 2021 09:51:22 +0800
Message-ID: <CADxym3a5nsuw2hiDF=ZS51Wpjs-i_VW+OGd-sgGDVrKYw2AiHQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] init/do_cmounts.c: introduce 'user_root' for initramfs
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>, ojeda@kernel.org,
        johan@kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        masahiroy@kernel.org, Menglong Dong <dong.menglong@zte.com.cn>,
        joe@perches.com, Jens Axboe <axboe@kernel.dk>, hare@suse.de,
        Jan Kara <jack@suse.cz>, tj@kernel.org,
        gregkh@linuxfoundation.org, song@kernel.org,
        NeilBrown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        f.fainelli@gmail.com, arnd@arndb.de,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        wangkefeng.wang@huawei.com, Barret Rhoden <brho@google.com>,
        mhiramat@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        vbabka@suse.cz, Alexander Potapenko <glider@google.com>,
        pmladek@suse.com, Chris Down <chris@chrisdown.name>,
        jojing64@gmail.com, terrelln@fb.com, geert@linux-m68k.org,
        mingo@kernel.org, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, jeyu@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 26, 2021 at 2:50 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
......
>
> What is the flow where docker uses an initramfs?
>
> Just thinking about this I am not being able to connect the dots.
>
> The way I imagine the world is that an initramfs will be used either
> when a linux system boots for the first time, or an initramfs would
> come from the distribution you are running inside a container.  In
> neither case do I see docker being in a position to add functionality
> to the initramfs as docker is not responsible for it.
>
> Is docker doing something creating like running a container in a VM,
> and running some directly out of the initramfs, and wanting that code
> to exactly match the non-VM case?
>
> If that is the case I think the easy solution would be to actually use
> an actual ramdisk where pivot_root works.

In fact, nowadays, initramfs is widely used by embedded devices in the
production environment, which makes the whole system run in ram.

That make sense. First, running in ram will speed up the system. The size
of the system won't be too large for embedded devices, which makes this
idea work. Second, this will reduce the I/O of disk devices, which can
extend the life of the disk. Third, RAM is getting cheaper.

So in this scene, Docker runs directly in initramfs.

>
> I really don't see why it makes sense for docker to be a special
> snowflake and require kernel features that no other distribution does.
>
> It might make sense to create a completely empty filesystem underneath
> an initramfs, and use that new rootfs as the unchanging root of the
> mount tree, if it can be done with a trivial amount of code, and
> generally make everything cleaner.
>
> As this change sits it looks like a lot of code to handle a problem
> in the implementation of docker.   Which quite frankly will be a pain
> to have to maintain if this is not a clean general feature that
> other people can also use.
>

I don't think that it's all for docker, pivot_root may be used by other
users in the above scene. It may work to create an empty filesystem, as you
mentioned above. But I don't think it's a good idea to make all users,
who want to use pivot_root, do that. After all, it's not friendly to
users.

As for the code, it may look a lot, but it's not complex. Maybe a clean
up for the code I add can make it better?

Thanks!
Menglong Dong
