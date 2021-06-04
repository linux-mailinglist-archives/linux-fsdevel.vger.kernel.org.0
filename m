Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C4E39B64F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jun 2021 11:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbhFDKBA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Jun 2021 06:01:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:48470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229690AbhFDKBA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Jun 2021 06:01:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 85F4E61415;
        Fri,  4 Jun 2021 09:59:04 +0000 (UTC)
Date:   Fri, 4 Jun 2021 11:59:01 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Menglong Dong <menglong8.dong@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>, johan@kernel.org,
        ojeda@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Menglong Dong <dong.menglong@zte.com.cn>, masahiroy@kernel.org,
        joe@perches.com, hare@suse.de, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>, tj@kernel.org,
        gregkh@linuxfoundation.org, song@kernel.org,
        NeilBrown <neilb@suse.de>, Barret Rhoden <brho@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>, palmerdabbelt@google.com,
        arnd@arndb.de, f.fainelli@gmail.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        wangkefeng.wang@huawei.com, Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, vbabka@suse.cz,
        pmladek@suse.com, Alexander Potapenko <glider@google.com>,
        Chris Down <chris@chrisdown.name>,
        "Eric W. Biederman" <ebiederm@xmission.com>, jojing64@gmail.com,
        mingo@kernel.org, terrelln@fb.com, geert@linux-m68k.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        jeyu@kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH v4 2/3] init/do_mounts.c: create second mount for
 initramfs
Message-ID: <20210604095901.zqh7saubd6eivpbe@wittgenstein>
References: <20210602144630.161982-1-dong.menglong@zte.com.cn>
 <20210602144630.161982-3-dong.menglong@zte.com.cn>
 <20210603133015.gvr5wpbotkyhhtqx@wittgenstein>
 <CADxym3YWUBf6W4pgeSPuYKFXPXeGse0t=DW8fAm-3WvgjWkRnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADxym3YWUBf6W4pgeSPuYKFXPXeGse0t=DW8fAm-3WvgjWkRnA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 03, 2021 at 11:05:08PM +0800, Menglong Dong wrote:
> On Thu, Jun 3, 2021 at 9:30 PM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> >
> [...]
> >
> > In fact you seem to be only using this struct you're introducing in this
> > single place which makes me think that it's not needed at all. So what's
> > preventing us from doing:
> >
> > > +
> > > +     return do_mount_root(root->dev_name,
> > > +                          root->fs_name,
> > > +                          root_mountflags & ~MS_RDONLY,
> > > +                          root_mount_data);
> > > +}
> >
> > int __init prepare_mount_rootfs(void)
> > {
> >         if (is_tmpfs_enabled())
> >                 return do_mount_root("tmpfs", "tmpfs",
> >                                      root_mountflags & ~MS_RDONLY,
> >                                      root_mount_data);
> >
> >         return do_mount_root("ramfs", "ramfs",
> >                              root_mountflags & ~MS_RDONLY,
> >                              root_mount_data);
> > }
> 
> It seems to make sense, but I just feel that it is a little hardcode.
> What if a new file system
> of rootfs arises? Am I too sensitive?

It'sn understandable but premature worry and I don't think it should
justify all that extra code.

Christian
