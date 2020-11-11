Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 423172AF2FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Nov 2020 15:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbgKKODm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Nov 2020 09:03:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:39526 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726904AbgKKODH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Nov 2020 09:03:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9B2FAABD1;
        Wed, 11 Nov 2020 14:03:03 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BA3EDDA6E1; Wed, 11 Nov 2020 15:01:21 +0100 (CET)
Date:   Wed, 11 Nov 2020 15:01:21 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Filipe Manana <fdmanana@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>, Jan Kara <jack@suse.cz>,
        David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC] fs: Avoid to use lockdep information if it's turned off
Message-ID: <20201111140121.GN6756@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Filipe Manana <fdmanana@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>, Jan Kara <jack@suse.cz>,
        David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ingo Molnar <mingo@kernel.org>
References: <20201110013739.686731-1-boqun.feng@gmail.com>
 <20201110153327.GL6756@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110153327.GL6756@suse.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 10, 2020 at 04:33:27PM +0100, David Sterba wrote:
> On Tue, Nov 10, 2020 at 09:37:37AM +0800, Boqun Feng wrote:
> 
> I'll run another test on top of the development branch in case there are
> unrelated lockdep warning bugs that have been fixed meanwhile.

Similar reports but earlier test and probably completely valid due to
"BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!"

btrfs/057		[16:01:29][ 1580.146087] run fstests btrfs/057 at 2020-11-10 16:01:29
[ 1580.787867] BTRFS info (device vda): disk space caching is enabled
[ 1580.789366] BTRFS info (device vda): has skinny extents
[ 1581.052542] BTRFS: device fsid 84018822-2e45-4341-80be-da6d2b4e033a devid 1 transid 5 /dev/vdb scanned by mkfs.btrfs (18739)
[ 1581.105177] BTRFS info (device vdb): turning on sync discard
[ 1581.106834] BTRFS info (device vdb): disk space caching is enabled
[ 1581.108423] BTRFS info (device vdb): has skinny extents
[ 1581.109799] BTRFS info (device vdb): flagging fs with big metadata feature
[ 1581.120343] BTRFS info (device vdb): checking UUID tree
[ 1586.942699] BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
[ 1586.945725] turning off the locking correctness validator.
[ 1586.948823] Please attach the output of /proc/lock_stat to the bug report
[ 1586.952153] CPU: 0 PID: 18771 Comm: fsstress Not tainted 5.10.0-rc3-default+ #1355
[ 1586.954919] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
[ 1586.958630] Call Trace:
[ 1586.959214]  dump_stack+0x77/0x97
[ 1586.960030]  add_chain_cache.cold+0x29/0x30
[ 1586.961028]  validate_chain+0x278/0x780
[ 1586.961979]  __lock_acquire+0x3fb/0x730
[ 1586.962880]  lock_acquire.part.0+0xac/0x1a0
[ 1586.963895]  ? try_to_wake_up+0x59/0x450
[ 1586.965153]  ? rcu_read_lock_sched_held+0x3f/0x70
[ 1586.966569]  ? lock_acquire+0xc4/0x150
[ 1586.967699]  ? try_to_wake_up+0x59/0x450
[ 1586.968882]  _raw_spin_lock_irqsave+0x43/0x90
[ 1586.970207]  ? try_to_wake_up+0x59/0x450
[ 1586.971404]  try_to_wake_up+0x59/0x450
[ 1586.973149]  wake_up_q+0x60/0xb0
[ 1586.974620]  __up_write+0x117/0x1d0
[ 1586.975080] ------------[ cut here ]------------
[ 1586.976039]  btrfs_release_path+0xc8/0x180 [btrfs]
[ 1586.977718] WARNING: CPU: 2 PID: 18772 at fs/super.c:1676 __sb_start_write+0x113/0x2a0
[ 1586.979478]  __btrfs_update_delayed_inode+0x1c1/0x2c0 [btrfs]
[ 1586.979506]  btrfs_commit_inode_delayed_inode+0x115/0x120 [btrfs]
[ 1586.982484] Modules linked in:
[ 1586.984080]  btrfs_evict_inode+0x1e2/0x370 [btrfs]
[ 1586.985557]  dm_flakey
[ 1586.986419]  ? evict+0xc3/0x220
[ 1586.986421]  evict+0xd5/0x220
[ 1586.986423]  vfs_rmdir.part.0+0x10c/0x180
[ 1586.986426]  do_rmdir+0x14b/0x1b0
[ 1586.987504]  dm_mod
[ 1586.988244]  do_syscall_64+0x2d/0x70
[ 1586.988947]  xxhash_generic btrfs
[ 1586.989779]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 1586.990906]  blake2b_generic
[ 1586.991808] RIP: 0033:0x7f0ad919b5d7
[ 1586.992451]  libcrc32c
[ 1586.993427] Code: 73 01 c3 48 8b 0d 99 f8 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 54 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 69 f8 0c 00 f7 d8 64 89 01 48
[ 1586.994380]  crc32c_intel
[ 1586.995546] RSP: 002b:00007ffc152bf368 EFLAGS: 00000202 ORIG_RAX: 0000000000000054
[ 1586.996034]  xor
[ 1586.996613] RAX: ffffffffffffffda RBX: 00000000000001f4 RCX: 00007f0ad919b5d7
[ 1586.996615] RDX: 0000000000316264 RSI: 0000000000000000 RDI: 000000000045eff0
[ 1586.997033]  zstd_decompress
[ 1587.001060] RBP: 00007ffc152bf4b0 R08: 000000000045eff0 R09: 00007ffc152bf4a4
[ 1587.001061] R10: 00000000000000b1 R11: 0000000000000202 R12: 000000000000030e
[ 1587.001062] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[ 1587.013639]  zstd_compress xxhash lzo_compress lzo_decompress raid6_pq loop
[ 1587.015763] CPU: 2 PID: 18772 Comm: fsstress Not tainted 5.10.0-rc3-default+ #1355
[ 1587.017719] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
[ 1587.020878] RIP: 0010:__sb_start_write+0x113/0x2a0
[ 1587.022233] Code: f3 f8 da 58 85 c0 0f 84 95 01 00 00 40 84 ed 0f 85 4c 01 00 00 45 84 e4 0f 85 75 01 00 00 5b 44 89 e8 5d 41 5c 41 5d 41 5e c3 <0f> 0b 48 89 e8 31 d2 be 31 00 00 00 48 c7 c7 ca 98 e4 a7 48 c1 e0
[ 1587.027309] RSP: 0018:ffffafbac3c2fdd0 EFLAGS: 00010246
[ 1587.028998] RAX: 0000000000000001 RBX: ffffa320cc6b4478 RCX: 0000000000000000
[ 1587.031038] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffffa320cc6b4478
[ 1587.032905] RBP: 0000000000000003 R08: 00000000000001b8 R09: ffffa320dbfa9b88
[ 1587.035782] R10: 0000000000000001 R11: ffffffffff9bcd99 R12: 0000000000000001
[ 1587.037974] R13: ffffa320cc6b4398 R14: ffffa320cc6b4698 R15: ffffa320e06f4000
[ 1587.040473] FS:  00007f0ad90a7b80(0000) GS:ffffa3213da00000(0000) knlGS:0000000000000000
[ 1587.043694] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1587.045577] CR2: 00000000007b5ce8 CR3: 0000000004be6006 CR4: 0000000000170ea0
[ 1587.047744] Call Trace:
[ 1587.048689]  start_transaction+0x406/0x510 [btrfs]
[ 1587.050009]  btrfs_unlink+0x31/0xf0 [btrfs]
[ 1587.051313]  vfs_unlink+0xee/0x1d0
[ 1587.052435]  do_unlinkat+0x1a1/0x2e0
[ 1587.053676]  do_syscall_64+0x2d/0x70
[ 1587.054883]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 1587.056428] RIP: 0033:0x7f0ad919b577
[ 1587.057583] Code: f0 ff ff 73 01 c3 48 8b 0d f6 f8 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 b8 57 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c9 f8 0c 00 f7 d8 64 89 01 48
[ 1587.061252] RSP: 002b:00007ffc152bf358 EFLAGS: 00000206 ORIG_RAX: 0000000000000057
[ 1587.063942] RAX: ffffffffffffffda RBX: 00000000000001f4 RCX: 00007f0ad919b577
[ 1587.065661] RDX: 0000000000643266 RSI: 0000000000000000 RDI: 0000000000418070
[ 1587.067478] RBP: 00007ffc152bf4b0 R08: 0000000000418070 R09: 00007ffc152bf49c
[ 1587.069024] R10: 000000000000002d R11: 0000000000000206 R12: 000000000000033e
[ 1587.071631] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[ 1587.074260] CPU: 2 PID: 18772 Comm: fsstress Not tainted 5.10.0-rc3-default+ #1355
[ 1587.076198] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
[ 1587.078659] Call Trace:
[ 1587.079296]  dump_stack+0x77/0x97
[ 1587.080076]  ? __sb_start_write+0x113/0x2a0
[ 1587.081008]  __warn.cold+0x24/0x83
[ 1587.082506]  ? __sb_start_write+0x113/0x2a0
[ 1587.084716]  report_bug+0x9a/0xc0
[ 1587.086153]  handle_bug+0x3c/0x60
[ 1587.087103]  exc_invalid_op+0x14/0x70
[ 1587.087923]  asm_exc_invalid_op+0x12/0x20
[ 1587.088813] RIP: 0010:__sb_start_write+0x113/0x2a0
[ 1587.089962] Code: f3 f8 da 58 85 c0 0f 84 95 01 00 00 40 84 ed 0f 85 4c 01 00 00 45 84 e4 0f 85 75 01 00 00 5b 44 89 e8 5d 41 5c 41 5d 41 5e c3 <0f> 0b 48 89 e8 31 d2 be 31 00 00 00 48 c7 c7 ca 98 e4 a7 48 c1 e0
[ 1587.096163] RSP: 0018:ffffafbac3c2fdd0 EFLAGS: 00010246
[ 1587.098068] RAX: 0000000000000001 RBX: ffffa320cc6b4478 RCX: 0000000000000000
[ 1587.100489] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffffa320cc6b4478
[ 1587.102454] RBP: 0000000000000003 R08: 00000000000001b8 R09: ffffa320dbfa9b88
[ 1587.103974] R10: 0000000000000001 R11: ffffffffff9bcd99 R12: 0000000000000001
[ 1587.105366] R13: ffffa320cc6b4398 R14: ffffa320cc6b4698 R15: ffffa320e06f4000
[ 1587.106873]  start_transaction+0x406/0x510 [btrfs]
[ 1587.107859]  btrfs_unlink+0x31/0xf0 [btrfs]
[ 1587.108735]  vfs_unlink+0xee/0x1d0
[ 1587.109451]  do_unlinkat+0x1a1/0x2e0
[ 1587.110387]  do_syscall_64+0x2d/0x70
[ 1587.111318]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 1587.112588] RIP: 0033:0x7f0ad919b577
[ 1587.113543] Code: f0 ff ff 73 01 c3 48 8b 0d f6 f8 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 b8 57 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c9 f8 0c 00 f7 d8 64 89 01 48
[ 1587.117977] RSP: 002b:00007ffc152bf358 EFLAGS: 00000206 ORIG_RAX: 0000000000000057
[ 1587.119801] RAX: ffffffffffffffda RBX: 00000000000001f4 RCX: 00007f0ad919b577
[ 1587.121488] RDX: 0000000000643266 RSI: 0000000000000000 RDI: 0000000000418070
[ 1587.123213] RBP: 00007ffc152bf4b0 R08: 0000000000418070 R09: 00007ffc152bf49c
[ 1587.124927] R10: 000000000000002d R11: 0000000000000206 R12: 000000000000033e
[ 1587.126121] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[ 1587.127122] irq event stamp: 1024932
[ 1587.128395] hardirqs last  enabled at (1024931): [<ffffffffa77fba04>] _raw_spin_unlock_irq+0x24/0x50
[ 1587.131643] hardirqs last disabled at (1024932): [<ffffffffa77f4188>] __schedule+0x3d8/0x8a0
[ 1587.135136] softirqs last  enabled at (1024750): [<ffffffffa7a00333>] __do_softirq+0x333/0x5c2
[ 1587.138237] softirqs last disabled at (1024741): [<ffffffffa7800dbf>] asm_call_irq_on_stack+0xf/0x20
[ 1587.140456] ---[ end trace 6b74e3ebe67d602c ]---
[ 1596.516828] BTRFS warning (device vdb): qgroup rescan is already in progress
[ 1596.788296] BTRFS info (device vdb): qgroup scan completed (inconsistency flag cleared)
[ 1597.641295] BTRFS info (device vdb): turning on sync discard
[ 1597.644117] BTRFS info (device vdb): disk space caching is enabled
[ 1597.646713] BTRFS info (device vdb): has skinny extents
_check_dmesg: something found in dmesg (see /tmp/fstests/results//btrfs/057.dmesg)
 [16:01:46]
btrfs/058		[16:01:46][ 1597.762062] run fstests btrfs/058 at 2020-11-10 16:01:46
[ 1598.091148] BTRFS info (device vda): disk space caching is enabled
[ 1598.093031] BTRFS info (device vda): has skinny extents
[ 1598.168010] ------------[ cut here ]------------
[ 1598.170209] WARNING: CPU: 1 PID: 19058 at fs/super.c:1676 __sb_start_write+0x113/0x2a0
[ 1598.173471] Modules linked in: dm_flakey dm_mod xxhash_generic btrfs blake2b_generic libcrc32c crc32c_intel xor zstd_decompress zstd_compress xxhash lzo_compress lzo_decompress raid6_pq loop
[ 1598.179110] CPU: 1 PID: 19058 Comm: xfs_io Tainted: G        W         5.10.0-rc3-default+ #1355
[ 1598.181745] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
[ 1598.185018] RIP: 0010:__sb_start_write+0x113/0x2a0
[ 1598.186490] Code: f3 f8 da 58 85 c0 0f 84 95 01 00 00 40 84 ed 0f 85 4c 01 00 00 45 84 e4 0f 85 75 01 00 00 5b 44 89 e8 5d 41 5c 41 5d 41 5e c3 <0f> 0b 48 89 e8 31 d2 be 31 00 00 00 48 c7 c7 ca 98 e4 a7 48 c1 e0
[ 1598.191880] RSP: 0018:ffffafbac3ee7c38 EFLAGS: 00010246
[ 1598.193397] RAX: 0000000000000001 RBX: ffffa320cfcdc478 RCX: 0000000000000000
[ 1598.195124] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffffa320cfcdc478
[ 1598.197034] RBP: 0000000000000003 R08: 00000000000001b8 R09: ffffa320dbfa8378
[ 1598.198974] R10: 0000000000000001 R11: 4548530074736574 R12: 0000000000000001
[ 1598.200876] R13: ffffa320cfcdc398 R14: ffffa320cfcdc698 R15: ffffa320dade8000
[ 1598.202775] FS:  00007fb5ad735e80(0000) GS:ffffa3213d800000(0000) knlGS:0000000000000000
[ 1598.205041] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1598.206551] CR2: 00007fb5ad84d520 CR3: 000000000fc4c004 CR4: 0000000000170ea0
[ 1598.208075] Call Trace:
[ 1598.208707]  start_transaction+0x406/0x510 [btrfs]
[ 1598.209821]  btrfs_tmpfile+0x49/0x1e0 [btrfs]
[ 1598.210881]  ? _raw_spin_unlock+0x29/0x40
[ 1598.211841]  vfs_tmpfile+0x63/0xe0
[ 1598.212617]  do_tmpfile+0x58/0xf0
[ 1598.213355]  path_openat+0x115/0x1b0
[ 1598.214205]  ? getname_flags+0x29/0x180
[ 1598.215050]  do_filp_open+0x88/0x130
[ 1598.215883]  ? lock_release+0xb0/0x160
[ 1598.216793]  ? do_raw_spin_unlock+0x4b/0xa0
[ 1598.217741]  ? _raw_spin_unlock+0x29/0x40
[ 1598.218660]  ? __alloc_fd+0xfc/0x1e0
[ 1598.219478]  do_sys_openat2+0x97/0x150
[ 1598.220342]  __x64_sys_openat+0x54/0x90
[ 1598.221240]  do_syscall_64+0x2d/0x70
[ 1598.222027]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 1598.223057] RIP: 0033:0x7fb5ad980047
[ 1598.223913] Code: 25 00 00 41 00 3d 00 00 41 00 74 47 64 8b 04 25 18 00 00 00 85 c0 75 6b 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 95 00 00 00 48 8b 4c 24 28 64 48 2b 0c 25
[ 1598.228002] RSP: 002b:00007ffd74683120 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
[ 1598.230150] RAX: ffffffffffffffda RBX: 0000000000410002 RCX: 00007fb5ad980047
[ 1598.232082] RDX: 0000000000410002 RSI: 00007ffd74684138 RDI: 00000000ffffff9c
[ 1598.234054] RBP: 00007ffd74684138 R08: 0000000000000001 R09: 0000000000000000
[ 1598.236003] R10: 0000000000000180 R11: 0000000000000246 R12: 0000000000410002
[ 1598.237974] R13: 00007ffd74683510 R14: 0000000000000180 R15: 0000000000000200
[ 1598.239945] CPU: 1 PID: 19058 Comm: xfs_io Tainted: G        W         5.10.0-rc3-default+ #1355
[ 1598.242186] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
[ 1598.244585] Call Trace:
[ 1598.245162]  dump_stack+0x77/0x97
[ 1598.245952]  ? __sb_start_write+0x113/0x2a0
[ 1598.246869]  __warn.cold+0x24/0x83
[ 1598.247614]  ? __sb_start_write+0x113/0x2a0
[ 1598.248561]  report_bug+0x9a/0xc0
[ 1598.249340]  handle_bug+0x3c/0x60
[ 1598.250112]  exc_invalid_op+0x14/0x70
[ 1598.250949]  asm_exc_invalid_op+0x12/0x20
[ 1598.251844] RIP: 0010:__sb_start_write+0x113/0x2a0
[ 1598.252862] Code: f3 f8 da 58 85 c0 0f 84 95 01 00 00 40 84 ed 0f 85 4c 01 00 00 45 84 e4 0f 85 75 01 00 00 5b 44 89 e8 5d 41 5c 41 5d 41 5e c3 <0f> 0b 48 89 e8 31 d2 be 31 00 00 00 48 c7 c7 ca 98 e4 a7 48 c1 e0
[ 1598.256674] RSP: 0018:ffffafbac3ee7c38 EFLAGS: 00010246
[ 1598.257786] RAX: 0000000000000001 RBX: ffffa320cfcdc478 RCX: 0000000000000000
[ 1598.259554] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffffa320cfcdc478
[ 1598.261376] RBP: 0000000000000003 R08: 00000000000001b8 R09: ffffa320dbfa8378
[ 1598.263173] R10: 0000000000000001 R11: 4548530074736574 R12: 0000000000000001
[ 1598.264966] R13: ffffa320cfcdc398 R14: ffffa320cfcdc698 R15: ffffa320dade8000
[ 1598.266774]  ? __sb_start_write+0x68/0x2a0
[ 1598.267888]  start_transaction+0x406/0x510 [btrfs]
[ 1598.269165]  btrfs_tmpfile+0x49/0x1e0 [btrfs]
[ 1598.270350]  ? _raw_spin_unlock+0x29/0x40
[ 1598.271421]  vfs_tmpfile+0x63/0xe0
[ 1598.272361]  do_tmpfile+0x58/0xf0
[ 1598.273281]  path_openat+0x115/0x1b0
[ 1598.274230]  ? getname_flags+0x29/0x180
[ 1598.275082]  do_filp_open+0x88/0x130
[ 1598.275879]  ? lock_release+0xb0/0x160
[ 1598.276706]  ? do_raw_spin_unlock+0x4b/0xa0
[ 1598.277923]  ? _raw_spin_unlock+0x29/0x40
[ 1598.279328]  ? __alloc_fd+0xfc/0x1e0
[ 1598.280596]  do_sys_openat2+0x97/0x150
[ 1598.281922]  __x64_sys_openat+0x54/0x90
[ 1598.283179]  do_syscall_64+0x2d/0x70
[ 1598.284373]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 1598.285973] RIP: 0033:0x7fb5ad980047
[ 1598.287187] Code: 25 00 00 41 00 3d 00 00 41 00 74 47 64 8b 04 25 18 00 00 00 85 c0 75 6b 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 95 00 00 00 48 8b 4c 24 28 64 48 2b 0c 25
[ 1598.292907] RSP: 002b:00007ffd74683120 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
[ 1598.294685] RAX: ffffffffffffffda RBX: 0000000000410002 RCX: 00007fb5ad980047
[ 1598.296442] RDX: 0000000000410002 RSI: 00007ffd74684138 RDI: 00000000ffffff9c
[ 1598.298284] RBP: 00007ffd74684138 R08: 0000000000000001 R09: 0000000000000000
[ 1598.300103] R10: 0000000000000180 R11: 0000000000000246 R12: 0000000000410002
[ 1598.301922] R13: 00007ffd74683510 R14: 0000000000000180 R15: 0000000000000200
[ 1598.303754] irq event stamp: 0
[ 1598.304612] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[ 1598.306302] hardirqs last disabled at (0): [<ffffffffa707134b>] copy_process+0x3db/0x1440
[ 1598.308468] softirqs last  enabled at (0): [<ffffffffa707134b>] copy_process+0x3db/0x1440
[ 1598.310645] softirqs last disabled at (0): [<0000000000000000>] 0x0
[ 1598.312198] ---[ end trace 6b74e3ebe67d602d ]---
[ 1598.432274] BTRFS: device fsid 7c33f125-75b7-43f5-92a4-0fdbf15d7bef devid 1 transid 5 /dev/vdb scanned by mkfs.btrfs (19079)
[ 1598.459998] BTRFS info (device vdb): turning on sync discard
[ 1598.461401] BTRFS info (device vdb): disk space caching is enabled
[ 1598.462886] BTRFS info (device vdb): has skinny extents
[ 1598.464116] BTRFS info (device vdb): flagging fs with big metadata feature
[ 1598.470328] BTRFS info (device vdb): checking UUID tree
[ 1601.577163] BTRFS info (device vdb): turning on sync discard
[ 1601.579595] BTRFS info (device vdb): disk space caching is enabled
[ 1601.581907] BTRFS info (device vdb): has skinny extents
_check_dmesg: something found in dmesg (see /tmp/fstests/results//btrfs/058.dmesg)
 [16:01:50]
