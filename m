Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D55EC4342AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 02:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhJTA6s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 20:58:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28092 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229610AbhJTA6q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 20:58:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634691392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F/8NB/KlmzgErA78hUhvea6Ha8iJthZz02p2pBYJn58=;
        b=VawXUrdY8cfI63kRfGSrRrBZrzeCp0GIkZOCRmmgflzme08YYAktOe9ZRXi4T3nF1B2xhO
        N6W9oUSR1wo5w9WEEpfeVu4NrxQvV4/xk52Xz+whcqPUVDxnBbU3NqxCxjAeXsN91aL6SV
        Zff7cEVlCzYJPgYgXD7SqFbJX3S9Njs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-RbGhYxBcNnC6Iyh11qfsnA-1; Tue, 19 Oct 2021 20:56:27 -0400
X-MC-Unique: RbGhYxBcNnC6Iyh11qfsnA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C2F91006AA2;
        Wed, 20 Oct 2021 00:56:24 +0000 (UTC)
Received: from T590 (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5FD185F4E0;
        Wed, 20 Oct 2021 00:56:01 +0000 (UTC)
Date:   Wed, 20 Oct 2021 08:55:57 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, tj@kernel.org,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        minchan@kernel.org, jeyu@kernel.org, shuah@kernel.org,
        bvanassche@acm.org, dan.j.williams@intel.com, joe@perches.com,
        tglx@linutronix.de, keescook@chromium.org, rostedt@goodmis.org,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com
Subject: Re: [PATCH v8 11/12] zram: fix crashes with cpu hotplug multistate
Message-ID: <YW9pHcJiWYLjI04/@T590>
References: <YWjCpLUNPF3s4P2U@T590>
 <YWjJ0O7K+31Iz3ox@bombadil.infradead.org>
 <YWk9e957Hb+I7HvR@T590>
 <YWm68xUnAofop3PZ@bombadil.infradead.org>
 <YWq3Z++uoJ/kcp+3@T590>
 <YW3LuzaPhW96jSBK@bombadil.infradead.org>
 <YW4uwep3BCe9Vxq8@T590>
 <YW7pQKi8AlV+ZemU@bombadil.infradead.org>
 <YW70uklcBWrmJIn8@T590>
 <YW8ewvAac/T2vxz2@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YW8ewvAac/T2vxz2@bombadil.infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 19, 2021 at 12:38:42PM -0700, Luis Chamberlain wrote:
> On Wed, Oct 20, 2021 at 12:39:22AM +0800, Ming Lei wrote:
> > On Tue, Oct 19, 2021 at 08:50:24AM -0700, Luis Chamberlain wrote:
> > > So do you want to take the position:
> > > 
> > > Hey driver authors: you cannot use any shared lock on module removal and
> > > on sysfs ops?
> > 
> > IMO, yes, in your patch of 'zram: fix crashes with cpu hotplug multistate',
> > when you added mutex_lock(zram_index_mutex) to disksize_store() and
> > other attribute show() or store() method. You have added new deadlock
> > between hot_remove_store() and disksize_store() & others, which can't be
> > addressed by your approach of holding module refcnt.
> > 
> > So far not see ltp tests covers hot add/remove interface yet.
> 
> Care to show what commands to use to cause this deadlock with my patches?

Build a kernel with your patch 4,7,8,9,11 and 12(all others are test module or
document change), with lockdep enabled, run the following command, then you
will see the warning, and it is one real deadlock, not false warning.

BTW, your patch 9 can't be applied cleanly against both linus and next
tree, so I edited it manually, but that can't make difference wrt. this issue.


[root@ktest-09 ~]# lsblk | grep zram
zram0   253:0    0    0B  0 disk 
cat /sys/class/zram-control/hot_add
[root@ktest-09 ~]# lsblk | grep zram
zram0   253:0    0    0B  0 disk 
zram1   253:1    0    0B  0 disk 
[root@ktest-09 ~]# echo 256M > /sys/block/zram1/disksize 
[root@ktest-09 ~]# echo 1 >  /sys/class/zram-control/hot_remove 
[root@ktest-09 ~]# dmesg
...
[   75.599882] ======================================================
[   75.601355] WARNING: possible circular locking dependency detected
[   75.602818] 5.15.0-rc3_zram_fix_luis+ #24 Not tainted
[   75.604038] ------------------------------------------------------
[   75.605512] bash/1154 is trying to acquire lock:
[   75.606634] ffff91ce026cd428 (kn->active#237){++++}-{0:0}, at: __kernfs_remove+0x1ab/0x1e0
[   75.608570]
               but task is already holding lock:
[   75.609955] ffffffff839e3ef0 (zram_index_mutex){+.+.}-{3:3}, at: hot_remove_store+0x52/0xf0
[   75.611910]
               which lock already depends on the new lock.

[   75.613896]
               the existing dependency chain (in reverse order) is:
[   75.615830]
               -> #1 (zram_index_mutex){+.+.}-{3:3}:
[   75.617483]        __lock_acquire+0x4d2/0x930
[   75.618650]        lock_acquire+0xbb/0x2d0
[   75.619748]        __mutex_lock+0x8e/0x8a0
[   75.620854]        disksize_store+0x38/0x180
[   75.621996]        kernfs_fop_write_iter+0x134/0x1d0
[   75.623287]        new_sync_write+0x122/0x1b0
[   75.624442]        vfs_write+0x23e/0x350
[   75.625506]        ksys_write+0x68/0xe0
[   75.626550]        do_syscall_64+0x3b/0x90
[   75.627649]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[   75.629070]
               -> #0 (kn->active#237){++++}-{0:0}:
[   75.630677]        check_prev_add+0x91/0xc10
[   75.631816]        validate_chain+0x474/0x500
[   75.632972]        __lock_acquire+0x4d2/0x930
[   75.634131]        lock_acquire+0xbb/0x2d0
[   75.635234]        kernfs_drain+0x139/0x190
[   75.636355]        __kernfs_remove+0x1ab/0x1e0
[   75.637532]        kernfs_remove_by_name_ns+0x3f/0x80
[   75.638843]        remove_files+0x2b/0x60
[   75.639926]        sysfs_remove_group+0x38/0x80
[   75.641120]        sysfs_remove_groups+0x29/0x40
[   75.642334]        device_remove_attrs+0x5b/0x90
[   75.643552]        device_del+0x184/0x400
[   75.644635]        zram_remove+0xac/0xc0
[   75.645700]        hot_remove_store+0xa3/0xf0
[   75.646856]        kernfs_fop_write_iter+0x134/0x1d0
[   75.648147]        new_sync_write+0x122/0x1b0
[   75.649311]        vfs_write+0x23e/0x350
[   75.650372]        ksys_write+0x68/0xe0
[   75.651412]        do_syscall_64+0x3b/0x90
[   75.652512]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[   75.653929]
               other info that might help us debug this:

[   75.656054]  Possible unsafe locking scenario:

[   75.657637]        CPU0                    CPU1
[   75.658833]        ----                    ----
[   75.660020]   lock(zram_index_mutex);
[   75.661024]                                lock(kn->active#237);
[   75.662549]                                lock(zram_index_mutex);
[   75.664103]   lock(kn->active#237);
[   75.665072]
                *** DEADLOCK ***

[   75.666736] 4 locks held by bash/1154:
[   75.667767]  #0: ffff91ce06983470 (sb_writers#4){.+.+}-{0:0}, at: ksys_write+0x68/0xe0
[   75.669802]  #1: ffff91ce4123d290 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x100/0x1d0
[   75.672050]  #2: ffff91ce05a7ac40 (kn->active#238){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x108/0x1d0
[   75.674383]  #3: ffffffff839e3ef0 (zram_index_mutex){+.+.}-{3:3}, at: hot_remove_store+0x52/0xf0
[   75.676595]
               stack backtrace:
[   75.677835] CPU: 2 PID: 1154 Comm: bash Not tainted 5.15.0-rc3_zram_fix_luis+ #24
[   75.679768] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-1.fc33 04/01/2014
[   75.681927] Call Trace:
[   75.682674]  dump_stack_lvl+0x57/0x7d
[   75.683680]  check_noncircular+0xff/0x110
[   75.684758]  ? stack_trace_save+0x4b/0x70
[   75.685843]  check_prev_add+0x91/0xc10
[   75.686867]  ? add_chain_cache+0x112/0x2d0
[   75.687965]  validate_chain+0x474/0x500
[   75.689005]  __lock_acquire+0x4d2/0x930
[   75.690054]  lock_acquire+0xbb/0x2d0
[   75.691038]  ? __kernfs_remove+0x1ab/0x1e0
[   75.692131]  ? __lock_release+0x179/0x2c0
[   75.693212]  ? kernfs_drain+0x5b/0x190
[   75.694239]  kernfs_drain+0x139/0x190
[   75.695240]  ? __kernfs_remove+0x1ab/0x1e0
[   75.696341]  __kernfs_remove+0x1ab/0x1e0
[   75.697408]  kernfs_remove_by_name_ns+0x3f/0x80
[   75.698607]  remove_files+0x2b/0x60
[   75.699576]  sysfs_remove_group+0x38/0x80
[   75.700661]  sysfs_remove_groups+0x29/0x40
[   75.701770]  device_remove_attrs+0x5b/0x90
[   75.702870]  device_del+0x184/0x400
[   75.703835]  zram_remove+0xac/0xc0
[   75.704785]  hot_remove_store+0xa3/0xf0
[   75.705831]  kernfs_fop_write_iter+0x134/0x1d0
[   75.707004]  new_sync_write+0x122/0x1b0
[   75.708048]  ? __do_fast_syscall_32+0xe0/0xf0
[   75.709214]  vfs_write+0x23e/0x350
[   75.710161]  ksys_write+0x68/0xe0
[   75.711088]  do_syscall_64+0x3b/0x90
[   75.712078]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   75.713389] RIP: 0033:0x7fcc1893f927
[   75.714381] Code: 0f 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
[   75.718879] RSP: 002b:00007ffcd56d91a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[   75.720832] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fcc1893f927
[   75.722592] RDX: 0000000000000002 RSI: 000055d7d33f78c0 RDI: 0000000000000001
[   75.724352] RBP: 000055d7d33f78c0 R08: 0000000000000000 R09: 00007fcc189f44e0
[   75.726123] R10: 00007fcc189f43e0 R11: 0000000000000246 R12: 0000000000000002
[   75.727884] R13: 00007fcc18a395a0 R14: 0000000000000002 R15: 00007fcc18a397a0



Thanks, 
Ming

