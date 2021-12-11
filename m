Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC2147110B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Dec 2021 04:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbhLKDEM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Dec 2021 22:04:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbhLKDEH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Dec 2021 22:04:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5417EC061714;
        Fri, 10 Dec 2021 19:00:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0529B829DD;
        Sat, 11 Dec 2021 03:00:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E50FC00446;
        Sat, 11 Dec 2021 03:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639191628;
        bh=pWXntdccIFluqVJKf5ZtOIzPxiOFA/P82RXms39PYJ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NvQ6v+wSNJL2AtJl8KJmQYDkX7xVgqTQoLpZR1UI/yiCVMP2h4NQYsbgc8k4+Rb2a
         1NMHaH7dAZUsrMU5OkwvFJ1Udcpkk0YiMqgZungAYdaB7x1jIL97rycTDYVliKf3cN
         MMg27xBqJZivrd6Ayhi36eVwkxcfKg85rIFeLdlRxNh7/SHLUBJ2GEHhdJCidDoIE9
         5aL0dKClX6soJJI05zGZOiASc2LBUzETO5KPdDcfwzkLm7ZZBQKP4HaPWyylES2ej8
         u4aAj1EKlnRMo8Kd4pUVPXNqSWForPJWQFrwHM2IxAed9/F6WKJciFAAbc68VqgMHl
         rNs4nYTRU4EsQ==
Date:   Fri, 10 Dec 2021 19:00:26 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>, Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+cdb5dd11c97cc532efad@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [syzbot] KASAN: use-after-free Read in remove_wait_queue (3)
Message-ID: <YbQUSlq76Iv5L4cC@sol.localdomain>
References: <000000000000e8f8f505d0e479a5@google.com>
 <20211211015620.1793-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211211015620.1793-1-hdanton@sina.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Dec 11, 2021 at 09:56:20AM +0800, Hillf Danton wrote:
> On Fri, 10 Dec 2021 14:42:22 -0800
> > syzbot has found a reproducer for the following issue on:
> > 
> > HEAD commit:    e5d75fc20b92 sh_eth: Use dev_err_probe() helper
> > git tree:       net-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1540cdceb00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=24fd48984584829b
> > dashboard link: https://syzkaller.appspot.com/bug?extid=cdb5dd11c97cc532efad
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15de00bab00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15ad646db00000
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+cdb5dd11c97cc532efad@syzkaller.appspotmail.com
> > 
> > ==================================================================
> > BUG: KASAN: use-after-free in __lock_acquire+0x3d86/0x54a0 kernel/locking/lockdep.c:4897
> > Read of size 8 at addr ffff888015be3740 by task syz-executor161/3598
> > 
> > CPU: 1 PID: 3598 Comm: syz-executor161 Not tainted 5.16.0-rc4-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:88 [inline]
> >  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
> >  print_address_description.constprop.0.cold+0x8d/0x320 mm/kasan/report.c:247
> >  __kasan_report mm/kasan/report.c:433 [inline]
> >  kasan_report.cold+0x83/0xdf mm/kasan/report.c:450
> >  __lock_acquire+0x3d86/0x54a0 kernel/locking/lockdep.c:4897
> >  lock_acquire kernel/locking/lockdep.c:5637 [inline]
> >  lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
> >  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
> >  _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
> >  remove_wait_queue+0x1d/0x180 kernel/sched/wait.c:55
> >  ep_remove_wait_queue+0x88/0x1a0 fs/eventpoll.c:545
> >  ep_unregister_pollwait fs/eventpoll.c:561 [inline]
> >  ep_remove+0x106/0x9c0 fs/eventpoll.c:690
> >  eventpoll_release_file+0xe1/0x130 fs/eventpoll.c:923
> >  eventpoll_release include/linux/eventpoll.h:53 [inline]
> >  __fput+0x87b/0x9f0 fs/file_table.c:271
> >  task_work_run+0xdd/0x1a0 kernel/task_work.c:164
> >  tracehook_notify_resume include/linux/tracehook.h:189 [inline]
> >  exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
> >  exit_to_user_mode_prepare+0x27e/0x290 kernel/entry/common.c:207
> >  __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
> >  syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:300
> >  do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
> >  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > RIP: 0033:0x7f3167c0def3
> > Code: c7 c2 c0 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb ba 0f 1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 45 c3 0f 1f 40 00 48 83 ec 18 89 7c 24 0c e8
> > RSP: 002b:00007ffddef2e488 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
> > RAX: 0000000000000000 RBX: 0000000000000005 RCX: 00007f3167c0def3
> > RDX: 000000000000002f RSI: 0000000020001340 RDI: 0000000000000004
> > RBP: 0000000000000000 R08: 0000000000000014 R09: 00007ffddef2e4b0
> > R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffddef2e4ac
> > R13: 00007ffddef2e4c0 R14: 00007ffddef2e500 R15: 0000000000000000
> >  </TASK>
> > 
> > Allocated by task 3598:
> >  kasan_save_stack+0x1e/0x50 mm/kasan/common.c:38
> >  kasan_set_track mm/kasan/common.c:46 [inline]
> >  set_alloc_info mm/kasan/common.c:434 [inline]
> >  ____kasan_kmalloc mm/kasan/common.c:513 [inline]
> >  ____kasan_kmalloc mm/kasan/common.c:472 [inline]
> >  __kasan_kmalloc+0xa9/0xd0 mm/kasan/common.c:522
> >  kmalloc include/linux/slab.h:590 [inline]
> >  psi_trigger_create.part.0+0x15e/0x7f0 kernel/sched/psi.c:1141
> >  cgroup_pressure_write+0x15d/0x6b0 kernel/cgroup/cgroup.c:3645
> >  cgroup_file_write+0x1ec/0x780 kernel/cgroup/cgroup.c:3852
> >  kernfs_fop_write_iter+0x342/0x500 fs/kernfs/file.c:296
> >  call_write_iter include/linux/fs.h:2162 [inline]
> >  new_sync_write+0x429/0x660 fs/read_write.c:503
> >  vfs_write+0x7cd/0xae0 fs/read_write.c:590
> >  ksys_write+0x12d/0x250 fs/read_write.c:643
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > 
> > Freed by task 3598:
> >  kasan_save_stack+0x1e/0x50 mm/kasan/common.c:38
> >  kasan_set_track+0x21/0x30 mm/kasan/common.c:46
> >  kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
> >  ____kasan_slab_free mm/kasan/common.c:366 [inline]
> >  ____kasan_slab_free mm/kasan/common.c:328 [inline]
> >  __kasan_slab_free+0xff/0x130 mm/kasan/common.c:374
> >  kasan_slab_free include/linux/kasan.h:235 [inline]
> >  slab_free_hook mm/slub.c:1723 [inline]
> >  slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1749
> >  slab_free mm/slub.c:3513 [inline]
> >  kfree+0xf6/0x560 mm/slub.c:4561
> >  cgroup_pressure_write+0x18d/0x6b0 kernel/cgroup/cgroup.c:3651
> >  cgroup_file_write+0x1ec/0x780 kernel/cgroup/cgroup.c:3852
> >  kernfs_fop_write_iter+0x342/0x500 fs/kernfs/file.c:296
> >  call_write_iter include/linux/fs.h:2162 [inline]
> >  new_sync_write+0x429/0x660 fs/read_write.c:503
> >  vfs_write+0x7cd/0xae0 fs/read_write.c:590
> >  ksys_write+0x12d/0x250 fs/read_write.c:643
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > 
> > The buggy address belongs to the object at ffff888015be3700
> >  which belongs to the cache kmalloc-192 of size 192
> > The buggy address is located 64 bytes inside of
> >  192-byte region [ffff888015be3700, ffff888015be37c0)
> > The buggy address belongs to the page:
> > page:ffffea000056f8c0 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x15be3
> > flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
> > raw: 00fff00000000200 0000000000000000 dead000000000001 ffff888010c41a00
> > raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
> > page dumped because: kasan: bad access detected
> > page_owner tracks the page as allocated
> > page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 1, ts 1983850449, free_ts 0
> >  prep_new_page mm/page_alloc.c:2418 [inline]
> >  get_page_from_freelist+0xa72/0x2f50 mm/page_alloc.c:4149
> >  __alloc_pages+0x1b2/0x500 mm/page_alloc.c:5369
> >  alloc_page_interleave+0x1e/0x200 mm/mempolicy.c:2036
> >  alloc_pages+0x29f/0x300 mm/mempolicy.c:2186
> >  alloc_slab_page mm/slub.c:1793 [inline]
> >  allocate_slab mm/slub.c:1930 [inline]
> >  new_slab+0x32d/0x4a0 mm/slub.c:1993
> >  ___slab_alloc+0x918/0xfe0 mm/slub.c:3022
> >  __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3109
> >  slab_alloc_node mm/slub.c:3200 [inline]
> >  slab_alloc mm/slub.c:3242 [inline]
> >  kmem_cache_alloc_trace+0x289/0x2c0 mm/slub.c:3259
> >  kmalloc include/linux/slab.h:590 [inline]
> >  kzalloc include/linux/slab.h:724 [inline]
> >  call_usermodehelper_setup+0x97/0x340 kernel/umh.c:365
> >  kobject_uevent_env+0xf73/0x1650 lib/kobject_uevent.c:614
> >  version_sysfs_builtin kernel/params.c:878 [inline]
> >  param_sysfs_init+0x146/0x43b kernel/params.c:969
> >  do_one_initcall+0x103/0x650 init/main.c:1297
> >  do_initcall_level init/main.c:1370 [inline]
> >  do_initcalls init/main.c:1386 [inline]
> >  do_basic_setup init/main.c:1405 [inline]
> >  kernel_init_freeable+0x6b1/0x73a init/main.c:1610
> >  kernel_init+0x1a/0x1d0 init/main.c:1499
> >  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
> > page_owner free stack trace missing
> > 
> > Memory state around the buggy address:
> >  ffff888015be3600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >  ffff888015be3680: 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc
> > >ffff888015be3700: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >                                            ^
> >  ffff888015be3780: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> >  ffff888015be3800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > ==================================================================
> 
> Hey Eric
> 
> Let us know if this uaf adds another call site for what you added [1].
> 
> Hillf
> 
> [1] https://lore.kernel.org/lkml/20211209010455.42744-2-ebiggers@kernel.org/
> 
> +++ x/kernel/sched/psi.c
> @@ -1193,7 +1193,7 @@ static void psi_trigger_destroy(struct k
>  	 * Wakeup waiters to stop polling. Can happen if cgroup is deleted
>  	 * from under a polling process.
>  	 */
> -	wake_up_interruptible(&t->event_wait);
> +	wake_up_pollfree(&t->event_wait);
>  
>  	mutex_lock(&group->trigger_lock);

[added linux-mm and all maintainers for kernel/sched/psi.c]

Well, it is the same sort of issue, but POLLFREE is *not* enough here.  POLLFREE
only works if the lifetime of waitqueue is tied to the polling task, as blocking
polls don't handle it -- only non-blocking polls do.

The kernel/sched/psi.c use case is just totally broken, since the lifetime of
its waitqueue is totally arbitrary; the open file descriptor can be written to
at any time by any process, which causes the waitqueue to be freed.  So it will
cause a use-after-free even for regular blocking poll().

To fix this, I think the psi trigger stuff will need to be refactored to have
just one waitqueue per open file.  We need to be removing uses of POLLFREE, not
adding new ones.  (See Linus' comments on POLLFREE here:
https://lore.kernel.org/lkml/CAHk-=wgvt7PH+AU_29H95tJQZ9FnhS8vVmymbhpZ6NZ7yaAigw@mail.gmail.com/)

Here are some repros:

#include <fcntl.h>
#include <sys/epoll.h>
#include <unistd.h>
int main()
{
        int fd = open("/proc/pressure/cpu", O_RDWR);
        int epfd = epoll_create(1);
        const char trigger[] = "some 100000 1000000";
        struct epoll_event event = { .events = EPOLLIN };

        write(fd, trigger, sizeof(trigger));
        epoll_ctl(epfd, EPOLL_CTL_ADD, fd, &event);
        write(fd, trigger, sizeof(trigger));
}


#include <fcntl.h>
#include <sys/poll.h>
#include <unistd.h>
int main()
{
        int fd = open("/proc/pressure/cpu", O_RDWR);
        const char trigger[] = "some 100000 1000000";

        if (fork()) {
                struct pollfd pfd = { .fd = fd, .events = POLLIN };

                for (;;)
                        poll(&pfd, 1, -1);
        } else {
                for (;;)
                        write(fd, trigger, sizeof(trigger));
        }
}
