Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1851153E7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2019 16:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfLFPJM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Dec 2019 10:09:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:53830 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726222AbfLFPJM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Dec 2019 10:09:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 14F36AC82;
        Fri,  6 Dec 2019 15:09:10 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 446EBDA783; Fri,  6 Dec 2019 16:09:04 +0100 (CET)
Date:   Fri, 6 Dec 2019 16:09:03 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, darrick.wong@oracle.com, fdmanana@kernel.org,
        nborisov@suse.com, dsterba@suse.cz, jthumshirn@suse.de
Subject: Re: [PATCH 0/8 v3] btrfs direct-io using iomap
Message-ID: <20191206150903.GC2734@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, darrick.wong@oracle.com, fdmanana@kernel.org,
        nborisov@suse.com, jthumshirn@suse.de
References: <20191205155630.28817-1-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205155630.28817-1-rgoldwyn@suse.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 05, 2019 at 09:56:22AM -0600, Goldwyn Rodrigues wrote:
> This is an effort to use iomap for direct I/O in btrfs. This would
> change the call from __blockdev_direct_io() to iomap_dio_rw().
> 
> The main objective is to lose the buffer head and use bio defined by
> iomap code, and hopefully to use more of generic-FS codebase.
> 
> These patches are based on xfs/iomap-for-next, though I tested it
> against the patches on xfs/iomap-for-next on top of v5.4.1 (there are no
> changes to existing patches). The tree is available at
> https://github.com/goldwynr/linux/tree/btrfs-iomap-dio

The iomap-for-next seems to be all merged to master, so I'd like to add
the btrfs part to for-next early so we can have the full dev cycle to
test.

Fstests got stuck at generic/095, in llseek on the inode mutex. In version
5.4.1 it's inode_lock while in master it's inode_lock_shared and only used for
SEEK_DATA/HOLE.

I've also tested the rebased patchset on current master but due to the hangs
caused by pipe changes when send is done it only gets to test btrfs/016 (way
before the generic/095 starts).

generic/095             [21:12:03][ 9153.094902] run fstests generic/095 at 2019-12-05 21:12:03
[ 9153.355112] BTRFS info (device vda): using free space tree
[ 9153.357522] BTRFS info (device vda): has skinny extents
[ 9155.598524] BTRFS: device fsid 8f274c73-27d6-4a7c-96ad-4ae41fcd6916 devid 1 transid 5 /dev/vdb
[ 9155.626220] BTRFS info (device vdb): enabling free space tree
[ 9155.628257] BTRFS info (device vdb): using free space tree
[ 9155.630290] BTRFS info (device vdb): has skinny extents
[ 9155.632191] BTRFS info (device vdb): flagging fs with big metadata feature
[ 9155.640732] BTRFS info (device vdb): creating free space tree
[ 9155.643781] BTRFS info (device vdb): setting compat-ro feature flag for FREE_SPACE_TREE (0x1)
[ 9155.648664] BTRFS info (device vdb): setting compat-ro feature flag for FREE_SPACE_TREE_VALID (0x2)
[ 9155.652542] BTRFS info (device vdb): checking UUID tree
[ 9819.465520] INFO: task fio:19671 blocked for more than 491 seconds.
[ 9819.470928]       Tainted: G             L    5.4.1-default+ #889
[ 9819.475441] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 9819.480987] fio             D14632 19671  19669 0x00004000
[ 9819.483182] Call Trace:
[ 9819.484360]  ? __schedule+0x2d4/0x8f0
[ 9819.485779]  schedule+0x49/0xd0
[ 9819.487050]  rwsem_down_write_slowpath+0x3f6/0x7d0
[ 9819.488777]  ? down_write+0xa9/0x130
[ 9819.490203]  down_write+0xa9/0x130
[ 9819.491571]  btrfs_file_llseek+0x45/0x2b0 [btrfs]
[ 9819.493074]  ksys_lseek+0x63/0xb0
[ 9819.494153]  do_syscall_64+0x50/0x1f0
[ 9819.495122]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[ 9819.496328] RIP: 0033:0x7f6bce8c0627
[ 9819.503273] RSP: 002b:00007fffa3fdaab8 EFLAGS: 00000206 ORIG_RAX: 0000000000000008
[ 9819.505802] RAX: ffffffffffffffda RBX: 00007f6ba393f000 RCX: 00007f6bce8c0627
[ 9819.508045] RDX: 0000000000000000 RSI: 0000000000007800 RDI: 0000000000000003
[ 9819.510048] RBP: 00007f6ba393f000 R08: 0000000000000400 R09: 0000000000000000
[ 9819.512061] R10: fffffffffffffa85 R11: 0000000000000206 R12: 0000000000000000
[ 9819.514211] R13: 0000000000000400 R14: 00007f6ba393f000 R15: 000055fc96807b40
[ 9819.516181] INFO: task fio:19672 blocked for more than 491 seconds.
[ 9819.517970]       Tainted: G             L    5.4.1-default+ #889
[ 9819.519650] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 9819.522142] fio             D14712 19672  19669 0x00000000
[ 9819.523696] Call Trace:
[ 9819.524651]  ? __schedule+0x2d4/0x8f0
[ 9819.525871]  schedule+0x49/0xd0
[ 9819.527003]  rwsem_down_write_slowpath+0x3f6/0x7d0
[ 9819.528480]  ? down_write+0xa9/0x130
[ 9819.529705]  down_write+0xa9/0x130
[ 9819.530889]  btrfs_file_llseek+0x45/0x2b0 [btrfs]
[ 9819.532304]  ksys_lseek+0x63/0xb0
[ 9819.533482]  do_syscall_64+0x50/0x1f0
[ 9819.534721]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[ 9819.536567] RIP: 0033:0x7f6bce8c0627
[ 9819.544424] RSP: 002b:00007fffa3fdaab8 EFLAGS: 00000206 ORIG_RAX: 0000000000000008
[ 9819.547483] RAX: ffffffffffffffda RBX: 00007f6ba3958080 RCX: 00007f6bce8c0627
[ 9819.549937] RDX: 0000000000000000 RSI: 0000000000020800 RDI: 0000000000000003
[ 9819.552152] RBP: 00007f6ba3958080 R08: 0000000000000400 R09: 0000000000000000
[ 9819.554479] R10: fffffffffffffa85 R11: 0000000000000206 R12: 0000000000000000
[ 9819.556515] R13: 0000000000000400 R14: 00007f6ba3958080 R15: 000055fc96807b40
[ 9819.558536] INFO: task fio:19673 blocked for more than 491 seconds.
[ 9819.560332]       Tainted: G             L    5.4.1-default+ #889
[ 9819.562062] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 9819.564494] fio             D13480 19673  19669 0x00000000
[ 9819.566075] Call Trace:
[ 9819.567037]  ? __schedule+0x2d4/0x8f0
[ 9819.568325]  schedule+0x49/0xd0
[ 9819.569438]  rwsem_down_write_slowpath+0x3f6/0x7d0
[ 9819.570906]  ? down_write+0xa9/0x130
[ 9819.572072]  down_write+0xa9/0x130
[ 9819.573255]  btrfs_file_llseek+0x45/0x2b0 [btrfs]
[ 9819.574685]  ? vfs_read+0x14e/0x180
[ 9819.575871]  ksys_lseek+0x63/0xb0
[ 9819.577066]  do_syscall_64+0x50/0x1f0
[ 9819.578286]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[ 9819.579758] RIP: 0033:0x7f6bce8c0627

