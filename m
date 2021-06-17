Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B38893AB625
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jun 2021 16:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbhFQOkz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Jun 2021 10:40:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:37810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230299AbhFQOky (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Jun 2021 10:40:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C7E3C61369;
        Thu, 17 Jun 2021 14:38:37 +0000 (UTC)
Date:   Thu, 17 Jun 2021 16:38:34 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Menglong Dong <menglong8.dong@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>, johan@kernel.org,
        ojeda@kernel.org, jeyu@kernel.org, masahiroy@kernel.org,
        joe@perches.com, Jan Kara <jack@suse.cz>, hare@suse.de,
        Jens Axboe <axboe@kernel.dk>, tj@kernel.org,
        gregkh@linuxfoundation.org, song@kernel.org,
        NeilBrown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Barret Rhoden <brho@google.com>, f.fainelli@gmail.com,
        palmerdabbelt@google.com, wangkefeng.wang@huawei.com,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, vbabka@suse.cz,
        Alexander Potapenko <glider@google.com>, pmladek@suse.com,
        johannes.berg@intel.com,
        "Eric W. Biederman" <ebiederm@xmission.com>, jojing64@gmail.com,
        terrelln@fb.com, geert@linux-m68k.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>, arnd@arndb.de,
        Chris Down <chris@chrisdown.name>, mingo@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH v6 2/2] init/do_mounts.c: create second mount for
 initramfs
Message-ID: <20210617143834.ybxk6cxhpavlf4gg@wittgenstein>
References: <20210605034447.92917-1-dong.menglong@zte.com.cn>
 <20210605034447.92917-3-dong.menglong@zte.com.cn>
 <20210605115019.umjumoasiwrclcks@wittgenstein>
 <CADxym3bs1r_+aPk9Z_5Y7QBBV_RzUbW9PUqSLB7akbss_dJi_g@mail.gmail.com>
 <20210607103147.yhniqeulw4pmvjdr@wittgenstein>
 <20210607121524.GB3896@www>
 <20210617035756.GA228302@www>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210617035756.GA228302@www>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 16, 2021 at 08:57:56PM -0700, Menglong Dong wrote:
> Hello,
> 
> On Mon, Jun 07, 2021 at 05:15:24AM -0700, menglong8.dong@gmail.com wrote:
> > On Mon, Jun 07, 2021 at 12:31:47PM +0200, Christian Brauner wrote:
> > > On Sat, Jun 05, 2021 at 10:47:07PM +0800, Menglong Dong wrote:
> > [...]
> > > > 
> > > > I think it's necessary, as I explained in the third patch. When the rootfs
> > > > is a block device, ramfs is used in init_mount_tree() unconditionally,
> > > > which can be seen from the enable of is_tmpfs.
> > > > 
> > > > That makes sense, because rootfs will not become the root if a block
> > > > device is specified by 'root' in boot cmd, so it makes no sense to use
> > > > tmpfs, because ramfs is more simple.
> > > > 
> > > > Here, I make rootfs as ramfs for the same reason: the first mount is not
> > > > used as the root, so make it ramfs which is more simple.
> > > 
> > > Ok. If you don't mind I'd like to pull and test this before moving
> > > further. (Btw, I talked about this at Plumbers before btw.)
> > > What did you use for testing this? Any way you can share it?
> > 
> 
> I notice that it have been ten days, and is it ok to move a little
> further? (knock-knock :/)

Hey Menglong,

Since we're very close to the next kernel release it's unlikely that
anything will happen before the merge window has closed.
Otherwise I think we're close. I haven't had the time to test yet but if
nothing major comes up I'll pick it up and route it through my tree.
We need to be sure there's no regressions for anyone using this.

Thanks!
Christian

> 
> Thanks!
> Menglong Dong
> 
> > Ok, no problem definitely. I tested this function in 3 way mainly:
> > 
> > 1. I debug the kernel with qemu and gdb, and trace the the whole
> >    process, to ensure that there is no abnormal situation.
> > 2. I tested pivot_root() in initramfs and ensured that it can be
> >    used normally. What's more, I also tested docker and ensured
> >    container can run normally without 'DOCKER_RAMDISK=yes' set in
> >    initramfs.
> > 3. I tried to enable and disable CONFIG_INITRAMFS_MOUNT, and
> >    ensured that the system can boot successfully from initramfs, initrd
> >    and sda.
> > 
> > What's more, our team is going to test it comprehensively, such as
> > ltp, etc.
> > 
> > Thanks!
> > Menglong Dong                                                                                                                                                         
> > 
