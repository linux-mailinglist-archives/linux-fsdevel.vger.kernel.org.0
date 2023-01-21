Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F53676324
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jan 2023 03:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjAUClS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Jan 2023 21:41:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjAUClR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Jan 2023 21:41:17 -0500
Received: from lgeamrelo11.lge.com (lgeamrelo11.lge.com [156.147.23.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D29187B2F1
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jan 2023 18:41:13 -0800 (PST)
Received: from unknown (HELO lgeamrelo01.lge.com) (156.147.1.125)
        by 156.147.23.51 with ESMTP; 21 Jan 2023 11:41:11 +0900
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO localhost.localdomain) (10.177.244.38)
        by 156.147.1.125 with ESMTP; 21 Jan 2023 11:41:11 +0900
X-Original-SENDERIP: 10.177.244.38
X-Original-MAILFROM: byungchul.park@lge.com
From:   Byungchul Park <byungchul.park@lge.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, damien.lemoal@opensource.wdc.com,
        linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
        will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
        joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
        duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org,
        tytso@mit.edu, willy@infradead.org, david@fromorbit.com,
        amir73il@gmail.com, gregkh@linuxfoundation.org,
        kernel-team@lge.com, linux-mm@kvack.org, akpm@linux-foundation.org,
        mhocko@kernel.org, minchan@kernel.org, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, sj@kernel.org, jglisse@redhat.com,
        dennis@kernel.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, vbabka@suse.cz, ngupta@vflare.org,
        linux-block@vger.kernel.org, paolo.valente@linaro.org,
        josef@toxicpanda.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, jlayton@kernel.org,
        dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com,
        42.hyeyoo@gmail.com, chris.p.wilson@intel.com,
        gwan-gyeong.mun@intel.com, max.byungchul.park@gmail.com,
        boqun.feng@gmail.com, longman@redhat.com
Subject: Re: [PATCH RFC v7 00/23] DEPT(Dependency Tracker)
Date:   Sat, 21 Jan 2023 11:40:56 +0900
Message-Id: <1674268856-31807-1-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1674089907-31690-1-git-send-email-byungchul.park@lge.com>
References: <1674089907-31690-1-git-send-email-byungchul.park@lge.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Byungchul wrote:
> Torvalds wrote:
> > On Sun, Jan 8, 2023 at 7:33 PM Byungchul Park <byungchul.park@lge.com> wrote:
> > >
> > > I've been developing a tool for detecting deadlock possibilities by
> > > tracking wait/event rather than lock(?) acquisition order to try to
> > > cover all synchonization machanisms. It's done on v6.2-rc2.
> > 
> > Ugh. I hate how this adds random patterns like
> 
> I undertand what you mean.. But all the synchronization primitives
> should let DEPT know the beginning and the end of each. However, I will
> remove the 'if' statement that looks ugly from the next spin, and place
> the pattern to a better place if possible.
> 
> >	if (timeout == MAX_SCHEDULE_TIMEOUT)
> >		sdt_might_sleep_strong(NULL);
> >	else
> >		sdt_might_sleep_strong_timeout(NULL);
> >	...
> >	sdt_might_sleep_finish();
> > 
> > to various places, it seems so very odd and unmaintainable.
> > 
> > I also recall this giving a fair amount of false positives, are they all fixed?
> 
> Yes. Of course I removed all the false positives we found.
> 
> > Anyway, I'd really like the lockdep people to comment and be involved.
> > We did have a fairly recent case of "lockdep doesn't track page lock
> > dependencies because it fundamentally cannot" issue, so DEPT might fix
> > those kinds of missing dependency analysis. See
> 
> Sure. That's exactly what DEPT works for e.g. PG_locked.
> 
> >	https://lore.kernel.org/lkml/00000000000060d41f05f139aa44@google.com/
> 
> I will reproduce it and share the result.

Hi Torvalds and folks,

I reproduced the issue with DEPT on (after making DEPT work a lil more
aggressively for PG_locked), and obtain a DEPT report. I wish this is
the true positive, explaining the issue correctly!

Let me remind you guys again, "DEPT is designed exactly for that kind of
deadlock issue by e.g. PG_locked, PG_writeback and any wait APIs".

I attach the report and add how to interpret it at the end.

---

[  227.854322] ===================================================
[  227.854880] DEPT: Circular dependency has been detected.
[  227.855341] 6.2.0-rc1-00025-gb0c20ebf51ac-dirty #28 Not tainted
[  227.855864] ---------------------------------------------------
[  227.856367] summary
[  227.856601] ---------------------------------------------------
[  227.857107] *** DEADLOCK ***

[  227.857551] context A
[  227.857803]     [S] lock(&ni->ni_lock:0)
[  227.858175]     [W] folio_wait_bit_common(PG_locked_map:0)
[  227.858658]     [E] unlock(&ni->ni_lock:0)

[  227.859233] context B
[  227.859484]     [S] (unknown)(PG_locked_map:0)
[  227.859906]     [W] lock(&ni->ni_lock:0)
[  227.860277]     [E] folio_unlock(PG_locked_map:0)

[  227.860883] [S]: start of the event context
[  227.861263] [W]: the wait blocked
[  227.861581] [E]: the event not reachable
[  227.861941] ---------------------------------------------------
[  227.862436] context A's detail
[  227.862738] ---------------------------------------------------
[  227.863242] context A
[  227.863490]     [S] lock(&ni->ni_lock:0)
[  227.863865]     [W] folio_wait_bit_common(PG_locked_map:0)
[  227.864356]     [E] unlock(&ni->ni_lock:0)

[  227.864929] [S] lock(&ni->ni_lock:0):
[  227.865279] [<ffffffff82b396fb>] ntfs3_setattr+0x54b/0xd40
[  227.865803] stacktrace:
[  227.866064]       ntfs3_setattr+0x54b/0xd40
[  227.866469]       notify_change+0xcb3/0x1430
[  227.866875]       do_truncate+0x149/0x210
[  227.867277]       path_openat+0x21a3/0x2a90
[  227.867692]       do_filp_open+0x1ba/0x410
[  227.868110]       do_sys_openat2+0x16d/0x4e0
[  227.868520]       __x64_sys_creat+0xcd/0x120
[  227.868925]       do_syscall_64+0x41/0xc0
[  227.869322]       entry_SYSCALL_64_after_hwframe+0x63/0xcd

[  227.870019] [W] folio_wait_bit_common(PG_locked_map:0):
[  227.870491] [<ffffffff81b228b0>] truncate_inode_pages_range+0x9b0/0xf20
[  227.871074] stacktrace:
[  227.871335]       folio_wait_bit_common+0x5e0/0xaf0
[  227.871796]       truncate_inode_pages_range+0x9b0/0xf20
[  227.872287]       truncate_pagecache+0x67/0x90
[  227.872730]       ntfs3_setattr+0x55a/0xd40
[  227.873152]       notify_change+0xcb3/0x1430
[  227.873578]       do_truncate+0x149/0x210
[  227.873981]       path_openat+0x21a3/0x2a90
[  227.874395]       do_filp_open+0x1ba/0x410
[  227.874803]       do_sys_openat2+0x16d/0x4e0
[  227.875215]       __x64_sys_creat+0xcd/0x120
[  227.875623]       do_syscall_64+0x41/0xc0
[  227.876035]       entry_SYSCALL_64_after_hwframe+0x63/0xcd

[  227.876738] [E] unlock(&ni->ni_lock:0):
[  227.877105] (N/A)
[  227.877331] ---------------------------------------------------
[  227.877850] context B's detail
[  227.878169] ---------------------------------------------------
[  227.878699] context B
[  227.878956]     [S] (unknown)(PG_locked_map:0)
[  227.879381]     [W] lock(&ni->ni_lock:0)
[  227.879774]     [E] folio_unlock(PG_locked_map:0)

[  227.880429] [S] (unknown)(PG_locked_map:0):
[  227.880825] (N/A)

[  227.881249] [W] lock(&ni->ni_lock:0):
[  227.881607] [<ffffffff82b009ec>] attr_data_get_block+0x32c/0x19f0
[  227.882151] stacktrace:
[  227.882421]       attr_data_get_block+0x32c/0x19f0
[  227.882877]       ntfs_get_block_vbo+0x264/0x1330
[  227.883316]       __block_write_begin_int+0x3bd/0x14b0
[  227.883809]       block_write_begin+0xb9/0x4d0
[  227.884231]       ntfs_write_begin+0x27e/0x480
[  227.884650]       generic_perform_write+0x256/0x570
[  227.885155]       __generic_file_write_iter+0x2ae/0x500
[  227.885658]       ntfs_file_write_iter+0x66d/0x1d70
[  227.886136]       do_iter_readv_writev+0x20b/0x3c0
[  227.886596]       do_iter_write+0x188/0x710
[  227.887015]       vfs_iter_write+0x74/0xa0
[  227.887425]       iter_file_splice_write+0x745/0xc90
[  227.887913]       direct_splice_actor+0x114/0x180
[  227.888364]       splice_direct_to_actor+0x33b/0x8b0
[  227.888831]       do_splice_direct+0x1b7/0x280
[  227.889256]       do_sendfile+0xb49/0x1310

[  227.889854] [E] folio_unlock(PG_locked_map:0):
[  227.890265] [<ffffffff81f10222>] generic_write_end+0xf2/0x440
[  227.890788] stacktrace:
[  227.891056]       generic_write_end+0xf2/0x440
[  227.891484]       ntfs_write_end+0x42e/0x980
[  227.891920]       generic_perform_write+0x316/0x570
[  227.892393]       __generic_file_write_iter+0x2ae/0x500
[  227.892899]       ntfs_file_write_iter+0x66d/0x1d70
[  227.893378]       do_iter_readv_writev+0x20b/0x3c0
[  227.893838]       do_iter_write+0x188/0x710
[  227.894253]       vfs_iter_write+0x74/0xa0
[  227.894660]       iter_file_splice_write+0x745/0xc90
[  227.895133]       direct_splice_actor+0x114/0x180
[  227.895585]       splice_direct_to_actor+0x33b/0x8b0
[  227.896082]       do_splice_direct+0x1b7/0x280
[  227.896521]       do_sendfile+0xb49/0x1310
[  227.896926]       __x64_sys_sendfile64+0x1d0/0x210
[  227.897389]       do_syscall_64+0x41/0xc0
[  227.897804]       entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  227.898332] ---------------------------------------------------
[  227.898858] information that might be helpful
[  227.899278] ---------------------------------------------------
[  227.899817] CPU: 1 PID: 8060 Comm: a.out Not tainted 6.2.0-rc1-00025-gb0c20ebf51ac-dirty #28
[  227.900547] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
[  227.901249] Call Trace:
[  227.901527]  <TASK>
[  227.901778]  dump_stack_lvl+0xf2/0x169
[  227.902167]  print_circle.cold+0xca4/0xd28
[  227.902593]  ? lookup_dep+0x240/0x240
[  227.902989]  ? extend_queue+0x223/0x300
[  227.903392]  cb_check_dl+0x1e7/0x260
[  227.903783]  bfs+0x27b/0x610
[  227.904102]  ? print_circle+0x240/0x240
[  227.904493]  ? llist_add_batch+0x180/0x180
[  227.904901]  ? extend_queue_rev+0x300/0x300
[  227.905317]  ? __add_dep+0x60f/0x810
[  227.905689]  add_dep+0x221/0x5b0
[  227.906041]  ? __add_idep+0x310/0x310
[  227.906432]  ? add_iecxt+0x1bc/0xa60
[  227.906821]  ? add_iecxt+0x1bc/0xa60
[  227.907210]  ? add_iecxt+0x1bc/0xa60
[  227.907599]  ? add_iecxt+0x1bc/0xa60
[  227.907997]  __dept_wait+0x600/0x1490
[  227.908392]  ? add_iecxt+0x1bc/0xa60
[  227.908778]  ? truncate_inode_pages_range+0x9b0/0xf20
[  227.909274]  ? check_new_class+0x790/0x790
[  227.909700]  ? dept_enirq_transition+0x519/0x9c0
[  227.910162]  dept_wait+0x159/0x3b0
[  227.910535]  ? truncate_inode_pages_range+0x9b0/0xf20
[  227.911032]  folio_wait_bit_common+0x5e0/0xaf0
[  227.911482]  ? filemap_get_folios_contig+0xa30/0xa30
[  227.911975]  ? dept_enirq_transition+0x519/0x9c0
[  227.912440]  ? lock_is_held_type+0x10e/0x160
[  227.912868]  ? lock_is_held_type+0x11e/0x160
[  227.913300]  truncate_inode_pages_range+0x9b0/0xf20
[  227.913782]  ? truncate_inode_partial_folio+0xba0/0xba0
[  227.914304]  ? setattr_prepare+0x142/0xc40
[  227.914718]  truncate_pagecache+0x67/0x90
[  227.915135]  ntfs3_setattr+0x55a/0xd40
[  227.915535]  ? ktime_get_coarse_real_ts64+0x1e5/0x2f0
[  227.916031]  ? ntfs_extend+0x5c0/0x5c0
[  227.916431]  ? mode_strip_sgid+0x210/0x210
[  227.916861]  ? ntfs_extend+0x5c0/0x5c0
[  227.917262]  notify_change+0xcb3/0x1430
[  227.917661]  ? do_truncate+0x149/0x210
[  227.918061]  do_truncate+0x149/0x210
[  227.918449]  ? file_open_root+0x430/0x430
[  227.918871]  ? process_measurement+0x18c0/0x18c0
[  227.919337]  ? ntfs_file_release+0x230/0x230
[  227.919784]  path_openat+0x21a3/0x2a90
[  227.920185]  ? path_lookupat+0x840/0x840
[  227.920595]  ? dept_enirq_transition+0x519/0x9c0
[  227.921047]  ? lock_is_held_type+0x10e/0x160
[  227.921460]  do_filp_open+0x1ba/0x410
[  227.921839]  ? may_open_dev+0xf0/0xf0
[  227.922214]  ? find_held_lock+0x2d/0x110
[  227.922612]  ? lock_release+0x43c/0x830
[  227.922992]  ? dept_ecxt_exit+0x31a/0x590
[  227.923395]  ? _raw_spin_unlock+0x3b/0x50
[  227.923793]  ? alloc_fd+0x2de/0x6e0
[  227.924148]  do_sys_openat2+0x16d/0x4e0
[  227.924529]  ? __ia32_sys_get_robust_list+0x3b0/0x3b0
[  227.925013]  ? build_open_flags+0x6f0/0x6f0
[  227.925414]  ? dept_enirq_transition+0x519/0x9c0
[  227.925870]  ? dept_enirq_transition+0x519/0x9c0
[  227.926331]  ? lock_is_held_type+0x4e/0x160
[  227.926751]  ? lock_is_held_type+0x4e/0x160
[  227.927168]  __x64_sys_creat+0xcd/0x120
[  227.927561]  ? __x64_compat_sys_openat+0x1f0/0x1f0
[  227.928031]  do_syscall_64+0x41/0xc0
[  227.928416]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  227.928912] RIP: 0033:0x7f8b9e4e4469
[  227.929285] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ff 49 2b 00 f7 d8 64 89 01 48
[  227.930793] RSP: 002b:00007f8b9eea4ef8 EFLAGS: 00000202 ORIG_RAX: 0000000000000055
[  227.931456] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f8b9e4e4469
[  227.932062] RDX: 0000000000737562 RSI: 0000000000000000 RDI: 0000000020000000
[  227.932661] RBP: 00007f8b9eea4f20 R08: 0000000000000000 R09: 0000000000000000
[  227.933252] R10: 0000000000000000 R11: 0000000000000202 R12: 00007fffa75511ee
[  227.933845] R13: 00007fffa75511ef R14: 00007f8b9ee85000 R15: 0000000000000003
[  227.934443]  </TASK>

---

This part is the most important.

[  227.857551] context A
[  227.857803]     [S] lock(&ni->ni_lock:0)
[  227.858175]     [W] folio_wait_bit_common(PG_locked_map:0)
[  227.858658]     [E] unlock(&ni->ni_lock:0)

[  227.859233] context B
[  227.859484]     [S] (unknown)(PG_locked_map:0)
[  227.859906]     [W] lock(&ni->ni_lock:0)
[  227.860277]     [E] folio_unlock(PG_locked_map:0)

[  227.860883] [S]: start of the event context
[  227.861263] [W]: the wait blocked
[  227.861581] [E]: the event not reachable

Dependency 1. A's unlock(&ni_lock:0) cannot happen if A's
              folio_wait_bit_common(PG_locked_map:0) is stuck waiting on
	      folio_ulock(PG_locked_map:0) that will wake up A.

Dependency 2. B's folio_unlock(PG_locked_map:0) cannot happend if B's
              lock(&ni->ni_lock:0) is stuck waiting on
	      unlock(&ni->ni_lock:0) that will release &ni->ni_lock.

So if these two contexts run at the same time, a deadlock is gonna
happen. DEPT reports it based on the two dependencies above. You can
check the stacktrace of each [W] and [E] in context's detail section.

It'd be appreciated if you share your opinion. I will work on it and
post the next spin, after getting back to work in 4 days.

	Byungchul
