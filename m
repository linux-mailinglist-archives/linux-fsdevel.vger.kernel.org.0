Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB46419FEE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Sep 2021 22:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236953AbhI0UQM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Sep 2021 16:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236950AbhI0UQM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Sep 2021 16:16:12 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2240CC061575;
        Mon, 27 Sep 2021 13:14:34 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 41FCB7032; Mon, 27 Sep 2021 16:14:33 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 41FCB7032
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1632773673;
        bh=wsQyqetgyPQ16p8Kx4srhVJh5maTmgwfFOWyGq6jxBY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=deCiDdlLAWzn8z5DXIQpQ//0TfGPTDw/nKtkgA7h6SS6ayCRClusSEiE6Vc8qiSwf
         J6Gxeme7lKyQMSO8UmX1A6JnvLqUabfoLPE8aCx7QpCCl1no/9a8SFboD7WOS2xx+2
         7mnIL0wsw4oSo1wfx0v1QIOpM6QwzoU3G/TgeMAw=
Date:   Mon, 27 Sep 2021 16:14:33 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v4 0/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Message-ID: <20210927201433.GA1704@fieldses.org>
References: <20210924205252.82502-1-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210924205252.82502-1-dai.ngo@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The file_rwsem is used for /proc/locks; only the code that produces the
/proc/locks output calls down_write, the rest only calls down_read.

I assumed that it was OK to nest read acquisitions of a rwsem, but I
think that's wrong.

I think it should be no big deal to move the lm_expire_lock(.,0) call
outside of the file_rwsem?

--b.

[  959.807364] ============================================
[  959.807803] WARNING: possible recursive locking detected
[  959.808228] 5.15.0-rc2-00009-g4e5af4d2635a #533 Not tainted
[  959.808675] --------------------------------------------
[  959.809189] nfsd/5675 is trying to acquire lock:
[  959.809664] ffffffff8519e470 (file_rwsem){.+.+}-{0:0}, at: locks_remove_posix+0x37f/0x4e0
[  959.810647] 
               but task is already holding lock:
[  959.811097] ffffffff8519e470 (file_rwsem){.+.+}-{0:0}, at: nfsd4_lock+0xcb9/0x3850 [nfsd]
[  959.812147] 
               other info that might help us debug this:
[  959.812698]  Possible unsafe locking scenario:

[  959.813189]        CPU0
[  959.813362]        ----
[  959.813544]   lock(file_rwsem);
[  959.813812]   lock(file_rwsem);
[  959.814078] 
                *** DEADLOCK ***

[  959.814386]  May be due to missing lock nesting notation

[  959.814968] 3 locks held by nfsd/5675:
[  959.815315]  #0: ffff888007d42bc8 (&rp->rp_mutex){+.+.}-{3:3}, at: nfs4_preprocess_seqid_op+0x395/0x730 [nfsd]
[  959.816546]  #1: ffff88800f378b70 (&stp->st_mutex#2){+.+.}-{3:3}, at: nfsd4_lock+0x1f91/0x3850 [nfsd]
[  959.817697]  #2: ffffffff8519e470 (file_rwsem){.+.+}-{0:0}, at: nfsd4_lock+0xcb9/0x3850 [nfsd]
[  959.818755] 
               stack backtrace:
[  959.819010] CPU: 2 PID: 5675 Comm: nfsd Not tainted 5.15.0-rc2-00009-g4e5af4d2635a #533
[  959.819847] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-3.fc34 04/01/2014
[  959.820637] Call Trace:
[  959.820759]  dump_stack_lvl+0x45/0x59
[  959.821016]  __lock_acquire.cold+0x175/0x3a5
[  959.821316]  ? lockdep_hardirqs_on_prepare+0x400/0x400
[  959.821741]  lock_acquire+0x1a6/0x4b0
[  959.821976]  ? locks_remove_posix+0x37f/0x4e0
[  959.822316]  ? lock_release+0x6d0/0x6d0
[  959.822591]  ? find_held_lock+0x2c/0x110
[  959.822852]  ? lock_is_held_type+0xd5/0x130
[  959.823139]  posix_lock_inode+0x143/0x1ab0
[  959.823414]  ? locks_remove_posix+0x37f/0x4e0
[  959.823739]  ? do_raw_spin_unlock+0x54/0x220
[  959.824031]  ? lockdep_init_map_type+0x2c3/0x7a0
[  959.824355]  ? locks_remove_flock+0x2e0/0x2e0
[  959.824681]  locks_remove_posix+0x37f/0x4e0
[  959.824984]  ? do_lock_file_wait+0x2a0/0x2a0
[  959.825287]  ? lock_downgrade+0x6a0/0x6a0
[  959.825584]  ? nfsd_file_put+0x170/0x170 [nfsd]
[  959.825941]  filp_close+0xed/0x130
[  959.826191]  nfs4_free_lock_stateid+0xcc/0x190 [nfsd]
[  959.826625]  free_ol_stateid_reaplist+0x128/0x1f0 [nfsd]
[  959.827037]  release_openowner+0xee/0x150 [nfsd]
[  959.827382]  ? release_last_closed_stateid+0x460/0x460 [nfsd]
[  959.827837]  ? rwlock_bug.part.0+0x90/0x90
[  959.828115]  __destroy_client+0x39f/0x6f0 [nfsd]
[  959.828460]  ? nfsd4_cb_recall_release+0x20/0x20 [nfsd]
[  959.828868]  nfsd4_fl_expire_lock+0x2bc/0x460 [nfsd]
[  959.829273]  posix_lock_inode+0xa46/0x1ab0
[  959.829579]  ? lockdep_init_map_type+0x2c3/0x7a0
[  959.829913]  ? locks_remove_flock+0x2e0/0x2e0
[  959.830250]  ? __init_waitqueue_head+0x70/0xd0
[  959.830568]  nfsd4_lock+0xcb9/0x3850 [nfsd]
[  959.830878]  ? nfsd4_delegreturn+0x3b0/0x3b0 [nfsd]
[  959.831248]  ? percpu_counter_add_batch+0x77/0x130
[  959.831594]  nfsd4_proc_compound+0xcee/0x21d0 [nfsd]
[  959.831973]  ? nfsd4_release_compoundargs+0x140/0x140 [nfsd]
[  959.832414]  nfsd_dispatch+0x4df/0xc50 [nfsd]
[  959.832737]  ? nfsd_svc+0xca0/0xca0 [nfsd]
[  959.833051]  svc_process_common+0xdeb/0x2480 [sunrpc]
[  959.833462]  ? svc_create+0x20/0x20 [sunrpc]
[  959.833830]  ? nfsd_svc+0xca0/0xca0 [nfsd]
[  959.834144]  ? svc_sock_secure_port+0x36/0x40 [sunrpc]
[  959.834578]  ? svc_recv+0xd9c/0x2490 [sunrpc]
[  959.834915]  svc_process+0x32e/0x4a0 [sunrpc]
[  959.835249]  nfsd+0x306/0x530 [nfsd]
[  959.835499]  ? nfsd_shutdown_threads+0x300/0x300 [nfsd]
[  959.835899]  kthread+0x391/0x470
[  959.836094]  ? _raw_spin_unlock_irq+0x24/0x50
[  959.836394]  ? set_kthread_struct+0x100/0x100
[  959.836698]  ret_from_fork+0x22/0x30
[  960.750222] nfsd: last server has exited, flushing export cache
[  960.880355] NFSD: Using nfsdcld client tracking operations.
[  960.880956] NFSD: starting 15-second grace period (net f0000098)
[ 1403.405511] nfsd: last server has exited, flushing export cache
[ 1403.656335] NFSD: Using nfsdcld client tracking operations.
[ 1403.657585] NFSD: starting 15-second grace period (net f0000098)
[ 1445.741596] nfsd: last server has exited, flushing export cache
[ 1445.981980] NFSD: Using nfsdcld client tracking operations.
[ 1445.983143] NFSD: starting 15-second grace period (net f0000098)
[ 1450.025112] NFSD: all clients done reclaiming, ending NFSv4 grace period (net f0000098)
[ 1472.325551] nfsd: last server has exited, flushing export cache
[ 1472.583073] NFSD: Using nfsdcld client tracking operations.
[ 1472.583998] NFSD: starting 15-second grace period (net f0000098)
[ 1473.175582] NFSD: all clients done reclaiming, ending NFSv4 grace period (net f0000098)
[ 1494.637499] nfsd: last server has exited, flushing export cache
[ 1494.885795] NFSD: Using nfsdcld client tracking operations.
[ 1494.886484] NFSD: starting 15-second grace period (net f0000098)
[ 1495.393667] NFSD: all clients done reclaiming, ending NFSv4 grace period (net f0000098)
[ 1516.781474] nfsd: last server has exited, flushing export cache
[ 1516.902903] NFSD: Using nfsdcld client tracking operations.
[ 1516.903460] NFSD: starting 15-second grace period (net f0000098)
[ 1538.045156] NFSD: all clients done reclaiming, ending NFSv4 grace period (net f0000098)
[ 1559.125362] nfsd: last server has exited, flushing export cache
[ 1559.362856] NFSD: Using nfsdcld client tracking operations.
[ 1559.363658] NFSD: starting 15-second grace period (net f0000098)
[ 1559.480531] NFSD: all clients done reclaiming, ending NFSv4 grace period (net f0000098)
[ 1583.745353] nfsd: last server has exited, flushing export cache
[ 1583.876877] NFSD: Using nfsdcld client tracking operations.
[ 1583.877573] NFSD: starting 15-second grace period (net f0000098)
[ 1586.401321] nfsd: last server has exited, flushing export cache
[ 1586.525629] NFSD: Using nfsdcld client tracking operations.
[ 1586.526388] NFSD: starting 15-second grace period (net f0000098)
[ 1625.993218] nfsd: last server has exited, flushing export cache
[ 1626.442627] NFSD: Using nfsdcld client tracking operations.
[ 1626.444397] NFSD: starting 15-second grace period (net f0000098)
[ 1627.117214] nfsd: last server has exited, flushing export cache
[ 1627.351487] NFSD: Using nfsdcld client tracking operations.
[ 1627.352663] NFSD: starting 15-second grace period (net f0000098)
[ 1627.854410] NFSD: all clients done reclaiming, ending NFSv4 grace period (net f0000098)
[ 3285.818905] clocksource: timekeeping watchdog on CPU3: acpi_pm retried 2 times before success
