Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDB8F10B2B5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2019 16:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfK0PvN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Nov 2019 10:51:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:50434 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726634AbfK0PvN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Nov 2019 10:51:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A5FCCBD7C;
        Wed, 27 Nov 2019 15:51:10 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 92150DA733; Wed, 27 Nov 2019 16:51:08 +0100 (CET)
Date:   Wed, 27 Nov 2019 16:51:08 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, darrick.wong@oracle.com, fdmanana@kernel.org
Subject: Re: [PATCH 0/5 v2] btrfs direct-io using iomap
Message-ID: <20191127155108.GT2734@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, darrick.wong@oracle.com, fdmanana@kernel.org
References: <20191126031456.12150-1-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191126031456.12150-1-rgoldwyn@suse.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 25, 2019 at 09:14:51PM -0600, Goldwyn Rodrigues wrote:
> This is an effort to use iomap for direct I/O in btrfs. This would
> change the call from __blockdev_direct_io() to iomap_dio_rw().
> 
> The main objective is to lose the buffer head and use bio defined by
> iomap code, and hopefully to use more of generic-FS codebase.
> 
> These patches are based on xfs/iomap-for-next, though I tested it
> against the patches on xfs/iomap-for-next on top of v5.4 (there are no
> changes to existing iomap patches).
> 
> I have tested it against xfstests/btrfs.
> 
> Changes since v1
> - Incorporated back the efficiency change for inode locking
> - Review comments about coding style and git comments
> - Merge related patches into one
> - Direct read to go through btrfs_direct_IO()
> - Removal of no longer used function dio_end_io()

I see a lockdep assertion during test btrfs/004

iomap_dio_rw()
...
	lockdep_assert_held(&inode->i_rwsem);

btrfs/004               [15:46:30][   69.749908] run fstests btrfs/004 at 2019-11-27 15:46:30
[   70.180401] BTRFS info (device vda): disk space caching is enabled
[   70.183496] BTRFS info (device vda): has skinny extents
[   70.378865] BTRFS: device fsid a10200b4-f17d-49a0-8c82-b06b69871613 devid 1 transid 5 /dev/vdb scanned by mkfs.btrfs (21271)
[   70.405858] BTRFS info (device vdb): turning on discard
[   70.408279] BTRFS info (device vdb): disk space caching is enabled
[   70.410630] BTRFS info (device vdb): has skinny extents
[   70.412358] BTRFS info (device vdb): flagging fs with big metadata feature
[   70.420386] BTRFS info (device vdb): checking UUID tree
[   70.427675] ------------[ cut here ]------------
[   70.429375] WARNING: CPU: 2 PID: 21300 at fs/iomap/direct-io.c:413 iomap_dio_rw+0x255/0x560
[   70.432208] Modules linked in: xxhash_generic btrfs blake2b_generic libcrc32c crc32c_intel xor zstd_decompress zstd_compress xxhash lzo_compress lzo_decompress raid6_pq loop
[   70.437096] CPU: 2 PID: 21300 Comm: fsstress Not tainted 5.4.0-default+ #881
[   70.439135] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58-rebuilt.opensuse.org 04/01/2014
[   70.442462] RIP: 0010:iomap_dio_rw+0x255/0x560
[   70.449092] RSP: 0018:ffffa36dc5b37c80 EFLAGS: 00010246
[   70.450701] RAX: 0000000000000000 RBX: ffffa36dc5b37e78 RCX: 0000000000000001
[   70.453062] RDX: ffff88d5b3f75500 RSI: ffff88d5a0c29018 RDI: ffff88d5b3f75d10
[   70.455308] RBP: ffffa36dc5b37d20 R08: 0000000000000001 R09: ffffffffaef84850
[   70.457479] R10: ffffa36dc5b37d40 R11: 0000000000007000 R12: ffffa36dc5b37e50
[   70.459479] R13: 0000000000049000 R14: ffff88d5a0c28ec0 R15: 0000000000049000
[   70.461790] FS:  00007fab1f5cdb80(0000) GS:ffff88d5bda00000(0000) knlGS:0000000000000000
[   70.464601] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   70.466503] CR2: 000000000041e000 CR3: 0000000061097006 CR4: 0000000000160ee0
[   70.468475] Call Trace:
[   70.469477]  ? btrfs_direct_IO+0x215/0x360 [btrfs]
[   70.471201]  ? __lock_acquired+0x1f0/0x320
[   70.472837]  ? btrfs_direct_IO+0xda/0x360 [btrfs]
[   70.474453]  btrfs_direct_IO+0xda/0x360 [btrfs]
[   70.476101]  ? lockdep_hardirqs_on+0x103/0x190
[   70.477732]  btrfs_file_write_iter+0x20b/0x5f0 [btrfs]
[   70.479450]  ? _copy_to_user+0x76/0x90
[   70.480943]  new_sync_write+0x118/0x1b0
[   70.482446]  vfs_write+0xde/0x1d0
[   70.483789]  ksys_write+0x68/0xe0
[   70.485136]  do_syscall_64+0x50/0x210
[   70.486578]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[   70.488390] RIP: 0033:0x7fab1f7a8f93
[   70.495054] RSP: 002b:00007ffea7b21208 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[   70.497693] RAX: ffffffffffffffda RBX: 0000000000007000 RCX: 00007fab1f7a8f93
[   70.499708] RDX: 0000000000007000 RSI: 0000000000416000 RDI: 0000000000000003
[   70.501754] RBP: 0000000000000003 R08: 0000000000416000 R09: 0000000000000231
[   70.503682] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000009
[   70.505622] R13: 0000000000049000 R14: 0000000000416000 R15: 0000000000000000
[   70.507683] irq event stamp: 1532
[   70.508931] hardirqs last  enabled at (1531): [<ffffffffc01d7bfb>] get_alloc_profile+0x1ab/0x2b0 [btrfs]
[   70.512256] hardirqs last disabled at (1532): [<ffffffffad002a8b>] trace_hardirqs_off_thunk+0x1a/0x1c
[   70.515039] softirqs last  enabled at (0): [<ffffffffad07efd0>] copy_process+0x680/0x1b70
[   70.517193] softirqs last disabled at (0): [<0000000000000000>] 0x0
[   70.519153] ---[ end trace 7fa25c75a89dbc97 ]---

The branch is xfs/iomap-for-next + this patchset.
