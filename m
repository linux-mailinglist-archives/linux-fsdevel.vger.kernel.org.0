Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3495938FC67
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 May 2021 10:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbhEYIPT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 04:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbhEYIPI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 04:15:08 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195E4C061574;
        Tue, 25 May 2021 01:04:50 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id w7so23576635lji.6;
        Tue, 25 May 2021 01:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZbxWFPATpyH8KlB2XfCYNbm150My8VFNA+BbTsSBPxg=;
        b=RgpWwD4WRc3ueLXmlv9OOs3YLGs03roiOPTTskReUUYgTiCBZDAhQHSPfklCjllp6z
         +Eu4a12VeWdJtyIBbBVlwee5Mqn6/Jkve32DTYea5TaBDUHh0flAqAXjmggdJPlbQrCt
         HKRFLJhHZYrxf7yL3IBHA7PR7eK2bQgCrCbE/v2LXJ6ihC5bZvvnBL3cGbMTotJf7DDI
         sByiKHAUdueaGOc20tQKlGTieOrPjTQMMTbEyT6sepCsNhPtjXRKVw7udJ7WKUo1Nd23
         Uekf50wSXiAHv19scLEp0rwM8yl4kHo9p4xddziC+f5sHPGtmP1ZUnANn7kNXkXzzV8v
         H4lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZbxWFPATpyH8KlB2XfCYNbm150My8VFNA+BbTsSBPxg=;
        b=UxuPv9QGA0iryXXp7yNnkUTMae27Pm/Knm1bbgq0NDeabx4HOqJ1ipL6ZG4QbL5c3m
         QAYZQriquw9q93wCB6tm2GNcOomIBYLERA71bqbJDpfBjrMu+P6ttlbchguZVxbO4bIg
         dQZbDcJdTnrXUCyZGPGPPHDKCpa0sC/B0bX9R1LY3pHkNPDDHzN0Mvi5hiCkhr7FNRk9
         9kOxGSeR2e0f/j+RIi959GpK9inBHPBFtpGZgHG3j4pKb8a6VCkmKK+F6zUJOyF5mXv+
         aCDKAlolJZgfzXzf+Z/W4h2GnCAv//tRAYz5qkV/ZpXUE8uQbaX6e/fG/Fnid+Z8gAO6
         /beA==
X-Gm-Message-State: AOAM532YyK7e/iowHMRkplCjxcomikbmNfr4sI2d45mneYzqgH2uTVjj
        Ook0XRQA9qwK1jtEXlrwvu8ljIKlgqzv23m0vLE=
X-Google-Smtp-Source: ABdhPJyDMICdFeOt+b39OBnMer8Q9QXklHhJJ/77fP6ltOKwSZwSeZSsI07PzZ73h75AN/ANslMGSjSsrvswM/YfWs4=
X-Received: by 2002:a2e:a374:: with SMTP id i20mr13769655ljn.149.1621929888405;
 Tue, 25 May 2021 01:04:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210522113155.244796-1-dong.menglong@zte.com.cn>
 <20210522113155.244796-2-dong.menglong@zte.com.cn> <YKxMjPOrHfb1uaA+@localhost>
 <CADxym3asj97wATjGthOyMzosg=dHY-bfk5pqLPYLSCa2Sub73Q@mail.gmail.com>
In-Reply-To: <CADxym3asj97wATjGthOyMzosg=dHY-bfk5pqLPYLSCa2Sub73Q@mail.gmail.com>
From:   Menglong Dong <menglong8.dong@gmail.com>
Date:   Tue, 25 May 2021 16:04:36 +0800
Message-ID: <CADxym3b8qTO-Fr9poZneZZsy5n3V1S3Fw6PqZ1YHb5=Ee28bUg@mail.gmail.com>
Subject: Re: [PATCH 1/3] init/main.c: introduce function ramdisk_exec_exist()
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
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
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 25, 2021 at 11:43 AM Menglong Dong <menglong8.dong@gmail.com> wrote:
>
> On Tue, May 25, 2021 at 9:02 AM Josh Triplett <josh@joshtriplett.org> wrote:
> >
> ......
> >
> > As far as I can tell, this will break if the user wants to use
> > ".mybinary" or ".mydir/mybinary" as the name of their init program.
> >
> > For that matter, it would break "...prog" or "...somedir/prog", which
> > would be strange but not something the kernel should prevent.
> >
>
> Wow, seems I didn't give enough thought to it.
>
> > I don't think this code should be attempting to recreate
> > relative-to-absolute filename resolution.
>
> Trust me, I don't want to do it either. However, I need to check if
> ramdisk_execute_command exist before chroot while the cpio is unpacked
> to '/root'.
>
> Maybe I can check it after chroot, but I need to chroot back if it not
> exist. Can I chroot back in a nice way?
>
> I tried to move the mount on '/root' to '/' before I do this check in
> absolute path, but seems '/' is special, the lookup of '/init' never
> follow the mount on '/' and it can't be found. However, if I lookup
> '/../init', it can be found!
>

I have figured it out. While path lookup, '/' won't follow the mount.
However, with the set of LOOKUP_DOWN, it will be followed.

So I will move the mount on '/root' to '/' and check the exist of
ramdisk_execute_command with LOOKUP_DOWN setted.

Seems there is still a long way to go on kernel......

Thanks!
Menglong Dong
