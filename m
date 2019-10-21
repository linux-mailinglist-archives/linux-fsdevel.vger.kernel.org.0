Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E61A5DED98
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2019 15:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbfJUNbg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Oct 2019 09:31:36 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:43418 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727322AbfJUNbg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:31:36 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x9LDVCwO001153
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Oct 2019 09:31:13 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 172CC420458; Mon, 21 Oct 2019 09:31:12 -0400 (EDT)
Date:   Mon, 21 Oct 2019 09:31:12 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>
Cc:     jack@suse.cz, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, hch@infradead.org,
        david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v5 00/12] ext4: port direct I/O to iomap infrastructure
Message-ID: <20191021133111.GA4675@mit.edu>
References: <cover.1571647178.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571647178.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Matthew, thanks for your work on this patch series!

I applied it against 4c3, and ran a quick test run on it, and found
the following locking problem.  To reproduce:

kvm-xfstests -c nojournal generic/113

generic/113		[09:27:19][    5.841937] run fstests generic/113 at 2019-10-21 09:27:19
[    7.959477] 
[    7.959798] ============================================
[    7.960518] WARNING: possible recursive locking detected
[    7.961225] 5.4.0-rc3-xfstests-00012-g7fe6ea084e48 #1238 Not tainted
[    7.961991] --------------------------------------------
[    7.962569] aio-stress/1516 is trying to acquire lock:
[    7.963129] ffff9fd4791148c8 (&sb->s_type->i_mutex_key#12){++++}, at: __generic_file_fsync+0x3e/0xb0
[    7.964109] 
[    7.964109] but task is already holding lock:
[    7.964740] ffff9fd4791148c8 (&sb->s_type->i_mutex_key#12){++++}, at: ext4_dio_write_iter+0x15b/0x430
[    7.965763] 
[    7.965763] other info that might help us debug this:
[    7.966630]  Possible unsafe locking scenario:
[    7.966630] 
[    7.967424]        CPU0
[    7.967760]        ----
[    7.968097]   lock(&sb->s_type->i_mutex_key#12);
[    7.968827]   lock(&sb->s_type->i_mutex_key#12);
[    7.969558] 
[    7.969558]  *** DEADLOCK ***
[    7.969558] 
[    7.970518]  May be due to missing lock nesting notation
[    7.970518] 
[    7.971592] 1 lock held by aio-stress/1516:
[    7.972267]  #0: ffff9fd4791148c8 (&sb->s_type->i_mutex_key#12){++++}, at: ext4_dio_write_iter+0x15b/0x430
[    7.973807] 
[    7.973807] stack backtrace:
[    7.974510] CPU: 0 PID: 1516 Comm: aio-stress Not tainted 5.4.0-rc3-xfstests-00012-g7fe6ea084e48 #1238
[    7.976053] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[    7.977327] Call Trace:
[    7.977700]  dump_stack+0x67/0x90
[    7.978198]  __lock_acquire.cold+0x130/0x1f7
[    7.978829]  ? __switch_to_asm+0x40/0x70
[    7.979659]  lock_acquire+0x9a/0x160
[    7.980320]  ? __generic_file_fsync+0x3e/0xb0
[    7.981014]  down_write+0x40/0x110
[    7.981717]  ? __generic_file_fsync+0x3e/0xb0
[    7.982676]  __generic_file_fsync+0x3e/0xb0
[    7.983454]  ext4_sync_file+0x277/0x4e0
[    7.984188]  iomap_dio_complete+0x112/0x130
[    7.984971]  ? iomap_dio_rw+0x3a0/0x4b0
[    7.985647]  iomap_dio_rw+0x419/0x4b0
[    7.986317]  ? ext4_dio_write_iter+0x296/0x430
[    7.987039]  ext4_dio_write_iter+0x296/0x430
[    7.987786]  aio_write+0xef/0x1c0
[    7.988284]  ? kvm_sched_clock_read+0x14/0x30
[    7.988822]  ? sched_clock+0x5/0x10
[    7.989234]  ? sched_clock_cpu+0xc/0xc0
[    7.989719]  __io_submit_one.constprop.0+0x399/0x5f0
[    7.990315]  ? kvm_sched_clock_read+0x14/0x30
[    7.990917]  ? sched_clock+0x5/0x10
[    7.991473]  ? sched_clock_cpu+0xc/0xc0
[    7.992097]  ? io_submit_one+0x141/0x5a0
[    7.992741]  io_submit_one+0x141/0x5a0
[    7.993354]  __x64_sys_io_submit+0x9a/0x290
[    7.993853]  ? do_syscall_64+0x50/0x1b0
[    7.994250]  ? __ia32_sys_io_destroy+0x10/0x10
[    7.994748]  do_syscall_64+0x50/0x1b0
[    7.995175]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[    7.995761] RIP: 0033:0x55d1268c2d17
[    7.996270] Code: 00 75 08 8b 47 0c 39 47 08 74 08 e9 b3 ff ff ff 0f 1f 00 31 c0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 b8 d1 00 00 00 0f 05 <c3> 0f 1f 84 00 00 00 00 00 48 63 ff b8 ce 00 00 00 0f 05 c3 0f 1f
[    7.999131] RSP: 002b:00007f090fb0bd88 EFLAGS: 00000202 ORIG_RAX: 00000000000000d1
[    7.999994] RAX: ffffffffffffffda RBX: 000055d128135010 RCX: 000055d1268c2d17
[    8.000881] RDX: 000055d128135010 RSI: 0000000000000008 RDI: 00007f0907263000
[    8.001765] RBP: 000055d128129560 R08: 00007fff421ae080 R09: 00007f090fb0bd68
[    8.002824] R10: 00007f090fb0bd60 R11: 0000000000000202 R12: 0000000000000008
[    8.004016] R13: 00007f090fb0bdb0 R14: 00007f090fb0bda0 R15: 000055d128129560

I'm other test configurations are still running, and I haven't had a
chance to do a detailed review on it, but I'll try to get to it this
week.

Thanks,

						- Ted
