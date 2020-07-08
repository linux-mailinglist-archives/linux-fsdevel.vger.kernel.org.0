Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2FC2186BC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 14:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbgGHMDe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 08:03:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:57570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729265AbgGHMDd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 08:03:33 -0400
Received: from gaia (unknown [95.146.230.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0567820772;
        Wed,  8 Jul 2020 12:03:30 +0000 (UTC)
Date:   Wed, 8 Jul 2020 13:03:28 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Jan Kara <jack@suse.cz>
Cc:     syzbot <syzbot+dec34b033b3479b9ef13@syzkaller.appspotmail.com>,
        amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: memory leak in inotify_update_watch
Message-ID: <20200708120327.GB6308@gaia>
References: <000000000000a47ace05a9c7b825@google.com>
 <20200707152411.GD25069@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707152411.GD25069@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 07, 2020 at 05:24:11PM +0200, Jan Kara wrote:
> On Mon 06-07-20 08:42:24, syzbot wrote:
> > syzbot found the following crash on:
> > 
> > HEAD commit:    7cc2a8ea Merge tag 'block-5.8-2020-07-01' of git://git.ker..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=17644c05100000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=5ee23b9caef4e07a
> > dashboard link: https://syzkaller.appspot.com/bug?extid=dec34b033b3479b9ef13
> > compiler:       gcc (GCC) 10.1.0-syz 20200507
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1478a67b100000
> > 
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+dec34b033b3479b9ef13@syzkaller.appspotmail.com
> > 
> > BUG: memory leak
> > unreferenced object 0xffff888115db8480 (size 576):
> >   comm "systemd-udevd", pid 11037, jiffies 4295104591 (age 56.960s)
> >   hex dump (first 32 bytes):
> >     00 04 00 00 00 00 00 00 80 fd e8 15 81 88 ff ff  ................
> >     a0 02 dd 20 81 88 ff ff b0 81 d0 09 81 88 ff ff  ... ............
> >   backtrace:
> >     [<00000000288c0066>] radix_tree_node_alloc.constprop.0+0xc1/0x140 lib/radix-tree.c:252
> >     [<00000000f80ba6a7>] idr_get_free+0x231/0x3b0 lib/radix-tree.c:1505
> >     [<00000000ec9ab938>] idr_alloc_u32+0x91/0x120 lib/idr.c:46
> >     [<00000000aea98d29>] idr_alloc_cyclic+0x84/0x110 lib/idr.c:125
> >     [<00000000dbad44a4>] inotify_add_to_idr fs/notify/inotify/inotify_user.c:365 [inline]
> >     [<00000000dbad44a4>] inotify_new_watch fs/notify/inotify/inotify_user.c:578 [inline]
> >     [<00000000dbad44a4>] inotify_update_watch+0x1af/0x2d0 fs/notify/inotify/inotify_user.c:617
> >     [<00000000e141890d>] __do_sys_inotify_add_watch fs/notify/inotify/inotify_user.c:755 [inline]
> >     [<00000000e141890d>] __se_sys_inotify_add_watch fs/notify/inotify/inotify_user.c:698 [inline]
> >     [<00000000e141890d>] __x64_sys_inotify_add_watch+0x12f/0x180 fs/notify/inotify/inotify_user.c:698
> >     [<00000000d872d7cc>] do_syscall_64+0x4c/0xe0 arch/x86/entry/common.c:359
> >     [<000000005c62d8da>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> I've been looking into this for a while and I don't think this is related
> to inotify at all. Firstly the reproducer looks totally benign:
> 
> prlimit64(0x0, 0xe, &(0x7f0000000280)={0x9, 0x8d}, 0x0)
> sched_setattr(0x0, &(0x7f00000000c0)={0x38, 0x2, 0x0, 0x0, 0x9}, 0x0)
> vmsplice(0xffffffffffffffff, 0x0, 0x0, 0x0)
> perf_event_open(0x0, 0x0, 0xffffffffffffffff, 0xffffffffffffffff, 0x0)
> clone(0x20000103, 0x0, 0xfffffffffffffffe, 0x0, 0xffffffffffffffff)
> syz_mount_image$vfat(0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0)
> 
> So we seem to set SCHED_RR class and prio 9 to itself, the rest of syscalls
> seem to be invalid and should fail. Secondly, the kernel log shows that we
> hit OOM killer frequently and after one of these kills, many leaked objects
> (among them this radix tree node from inotify idr) are reported. I'm not
> sure if it could be the leak detector getting confused (e.g. because it got
> ENOMEM at some point) or something else... Catalin, any idea?

Just wondering, if this leak is reproducible, could we have some
condition where inotify_remove_from_idr() is not called in case of a
forced exit triggered by the OOM kill? Also, can the leak be reproduced
without the OOM?

-- 
Catalin
