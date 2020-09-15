Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB9D626A06F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 10:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbgIOILv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 04:11:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:55544 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbgIOIKz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 04:10:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B55EAACB8;
        Tue, 15 Sep 2020 08:10:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EAD0ADA7C7; Tue, 15 Sep 2020 10:09:27 +0200 (CEST)
Date:   Tue, 15 Sep 2020 10:09:27 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v7 00/39] btrfs: zoned block device support
Message-ID: <20200915080927.GF1791@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org
References: <20200911123259.3782926-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911123259.3782926-1-naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 11, 2020 at 09:32:20PM +0900, Naohiro Aota wrote:
> Changelog
> v6:
>  - Use bitmap helpers (Johannes)
>  - Code cleanup (Johannes)
>  - Rebased on kdave/for-5.5
>  - Enable the tree-log feature.
>  - Treat conventional zones as sequential zones, so we can now allow
>    mixed allocation of conventional zone and sequential write required
>    zone to construct a block group.
>  - Implement log-structured superblock
>    - No need for one conventional zone at the beginning of a device.
>  - Fix deadlock of direct IO writing
>  - Fix building with !CONFIG_BLK_DEV_ZONED (Johannes)
>  - Fix leak of zone_info (Johannes)

I did a quick check to see if the patchset passes the default VM tests
and there's use after free short after the fstests start. No zoned
devices or such. I had to fix some conflicts when rebasing on misc-next
but I tried to base it on the last iomap-dio patch ("btrfs: switch to
iomap for direct IO"), same result so it's something in the zoned
patches.

The reported pointer 0x6b6b6b6b6d1918eb contains the use-after-free
poison (0x6b) (CONFIG_PAGE_POISONING=y).

MKFS_OPTIONS  -- -f -K --csum xxhash /dev/vdb
MOUNT_OPTIONS -- -o discard /dev/vdb /tmp/scratch

[   19.928844] BTRFS: device fsid 663b9b17-ab02-4021-92bf-dc24c3e4351a devid 1 transid 5 /dev/vdb scanned by mkfs.btrfs (398)
[   19.974176] BTRFS info (device vdb): turning on sync discard
[   19.977035] BTRFS info (device vdb): disk space caching is enabled
[   19.979965] BTRFS info (device vdb): has skinny extents
[   19.982586] BTRFS info (device vdb): flagging fs with big metadata feature
[   19.991757] BTRFS info (device vdb): checking UUID tree
[   20.002740] general protection fault, probably for non-canonical address 0x6b6b6b6b6d1918eb: 0000 [#1] SMP
[   20.006949] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.9.0-rc5-default+ #1260
[   20.009746] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
[   20.013566] RIP: 0010:end_bio_extent_writepage+0x51/0x180 [btrfs]
[   20.015873] Code: 8b 54 24 2c 41 8b 74 24 30 41 89 c5 48 c1 e2 04 49 03 54 24 60 03 72 0c 89 f0 81 e6 ff 0f 00 00 c1 e8 0c 48 c1 e0 06 48 03 02 <48> 8b 50 20 48 8b 40 18 48 c1 e2 0c 48 8b 38 48 01 d6 4c 89 e2 e8
[   20.022029] RSP: 0018:ffff93fc800b8e20 EFLAGS: 00010206
[   20.023615] RAX: 6b6b6b6b6d1918eb RBX: ffff8eceaf630378 RCX: 0000000000000020
[   20.025565] RDX: ffff8eceb297da00 RSI: 0000000000000b6b RDI: 0000000000000000
[   20.027289] RBP: ffff93fc800b8e80 R08: 00000004a84169d3 R09: 0000000000000000
[   20.028634] R10: 0000000000000000 R11: 0000000000000246 R12: ffff8eceaf630378
[   20.030569] R13: 0000000000000000 R14: 0000000000010000 R15: ffff8ecebaf62280
[   20.032607] FS:  0000000000000000(0000) GS:ffff8ecebd800000(0000) knlGS:0000000000000000
[   20.035314] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   20.036641] CR2: 00007f9bc3b5a990 CR3: 000000005fa3a005 CR4: 0000000000170ea0
[   20.038523] Call Trace:
[   20.039527]  <IRQ>
[   20.040378]  ? sched_clock_cpu+0x15/0x130
[   20.041619]  ? bio_endio+0x120/0x2c0
[   20.042880]  btrfs_end_bio+0x83/0x130 [btrfs]
[   20.044172]  blk_update_request+0x230/0x710
[   20.045368]  blk_mq_end_request+0x1c/0x130
[   20.046594]  blk_done_softirq+0x9f/0xd0
[   20.047754]  __do_softirq+0x1eb/0x56c
[   20.048917]  asm_call_on_stack+0xf/0x20
[   20.050185]  </IRQ>
[   20.051035]  do_softirq_own_stack+0x52/0x60
[   20.052368]  irq_exit_rcu+0x98/0xb0
[   20.053533]  sysvec_call_function_single+0x43/0xa0
[   20.054887]  asm_sysvec_call_function_single+0x12/0x20
[   20.056545] RIP: 0010:default_idle+0x1d/0x20
[   20.057961] Code: cc cc cc cc cc cc cc cc cc cc cc cc cc 0f 1f 44 00 00 e8 26 4d 9e ff 8b 05 f0 0e 03 01 85 c0 7e 07 0f 00 2d 67 1d 46 00 fb f4 <c3> 66 90 0f 1f 44 00 00 65 48 8b 04 25 00 8e 01 00 f0 80 48 02 20
[   20.063377] RSP: 0018:ffff93fc80073ed0 EFLAGS: 00000246
[   20.064915] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[   20.066743] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff9b7a5c6a
[   20.068656] RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000001
[   20.070530] R10: 0000000000000000 R11: 0000000000000046 R12: ffff8ecebd330040
[   20.072439] R13: ffff8ecebd330040 R14: 0000000000000000 R15: 0000000000000000
[   20.074408]  ? default_idle+0xa/0x20
[   20.075564]  default_idle_call+0x52/0x230
[   20.076849]  do_idle+0x201/0x210
[   20.077993]  cpu_startup_entry+0x19/0x1b
[   20.079301]  secondary_startup_64+0xa4/0xb0
[   20.080685] Modules linked in: xxhash_generic btrfs blake2b_generic libcrc32c crc32c_intel xor zstd_decompress zstd_compress xxhash lzo_compress lzo_decompress raid6_pq loop
[   20.085376] ---[ end trace fb99f1646d553ef6 ]---
[   20.087627] RIP: 0010:end_bio_extent_writepage+0x51/0x180 [btrfs]
[   20.090290] Code: 8b 54 24 2c 41 8b 74 24 30 41 89 c5 48 c1 e2 04 49 03 54 24 60 03 72 0c 89 f0 81 e6 ff 0f 00 00 c1 e8 0c 48 c1 e0 06 48 03 02 <48> 8b 50 20 48 8b 40 18 48 c1 e2 0c 48 8b 38 48 01 d6 4c 89 e2 e8
[   20.096561] RSP: 0018:ffff93fc800b8e20 EFLAGS: 00010206
[   20.098468] RAX: 6b6b6b6b6d1918eb RBX: ffff8eceaf630378 RCX: 0000000000000020
[   20.100883] RDX: ffff8eceb297da00 RSI: 0000000000000b6b RDI: 0000000000000000
[   20.103124] RBP: ffff93fc800b8e80 R08: 00000004a84169d3 R09: 0000000000000000
[   20.105312] R10: 0000000000000000 R11: 0000000000000246 R12: ffff8eceaf630378
[   20.107553] R13: 0000000000000000 R14: 0000000000010000 R15: ffff8ecebaf62280
[   20.109464] FS:  0000000000000000(0000) GS:ffff8ecebd800000(0000) knlGS:0000000000000000
[   20.112286] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   20.114048] CR2: 00007f9bc3b5a990 CR3: 000000005fa3a005 CR4: 0000000000170ea0
[   20.115946] Kernel panic - not syncing: Fatal exception in interrupt
[   20.117851] Kernel Offset: 0x1a000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[   20.120788] Rebooting in 90 seconds..
