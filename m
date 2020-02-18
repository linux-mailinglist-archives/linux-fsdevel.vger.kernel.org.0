Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 793E1161FF7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 05:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgBRE4j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 23:56:39 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:38673 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726261AbgBRE4j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 23:56:39 -0500
Received: from dread.disaster.area (pa49-179-138-28.pa.nsw.optusnet.com.au [49.179.138.28])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id A528E3A263E;
        Tue, 18 Feb 2020 15:56:35 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1j3uvy-0005p2-0S; Tue, 18 Feb 2020 15:56:34 +1100
Date:   Tue, 18 Feb 2020 15:56:33 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v6 00/19] Change readahead API
Message-ID: <20200218045633.GH10776@dread.disaster.area>
References: <20200217184613.19668-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200217184613.19668-1-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=zAxSp4fFY/GQY8/esVNjqw==:117 a=zAxSp4fFY/GQY8/esVNjqw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=l697ptgUJYAA:10
        a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8 a=7-415B0cAAAA:8
        a=XVPaj5jkfHni625HrT0A:9 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22
        a=AjGcO6oz07-iQ99wixmX:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 17, 2020 at 10:45:41AM -0800, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> This series adds a readahead address_space operation to eventually
> replace the readpages operation.  The key difference is that
> pages are added to the page cache as they are allocated (and
> then looked up by the filesystem) instead of passing them on a
> list to the readpages operation and having the filesystem add
> them to the page cache.  It's a net reduction in code for each
> implementation, more efficient than walking a list, and solves
> the direct-write vs buffered-read problem reported by yu kuai at
> https://lore.kernel.org/linux-fsdevel/20200116063601.39201-1-yukuai3@huawei.com/
> 
> The only unconverted filesystems are those which use fscache.
> Their conversion is pending Dave Howells' rewrite which will make the
> conversion substantially easier.

Latest version in your git tree:

$ ▶ glo -n 5 willy/readahead
4be497096c04 mm: Use memalloc_nofs_save in readahead path
ff63497fcb98 iomap: Convert from readpages to readahead
26aee60e89b5 iomap: Restructure iomap_readpages_actor
8115bcca7312 fuse: Convert from readpages to readahead
3db3d10d9ea1 f2fs: Convert from readpages to readahead
$

merged into a 5.6-rc2 tree fails at boot on my test vm:

[    2.423116] ------------[ cut here ]------------
[    2.424957] list_add double add: new=ffffea000efff4c8, prev=ffff8883bfffee60, next=ffffea000efff4c8.
[    2.428259] WARNING: CPU: 4 PID: 1 at lib/list_debug.c:29 __list_add_valid+0x67/0x70
[    2.430617] CPU: 4 PID: 1 Comm: sh Not tainted 5.6.0-rc2-dgc+ #1800
[    2.432405] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[    2.434744] RIP: 0010:__list_add_valid+0x67/0x70
[    2.436107] Code: c6 4c 89 ca 48 c7 c7 10 41 58 82 e8 55 29 89 ff 0f 0b 31 c0 c3 48 89 f2 4c 89 c1 48 89 fe 48 c7 c7 60 41 58 82 e8 3b 29 89 ff <0f> 0b 31 c7
[    2.441161] RSP: 0000:ffffc900018a3bb0 EFLAGS: 00010082
[    2.442548] RAX: 0000000000000000 RBX: ffffea000efff4c0 RCX: 0000000000000256
[    2.444432] RDX: 0000000000000001 RSI: 0000000000000086 RDI: ffffffff8288a8b0
[    2.446315] RBP: ffffea000efff4c8 R08: ffffc900018a3a65 R09: 0000000000000256
[    2.448199] R10: 0000000000000008 R11: ffffc900018a3a65 R12: ffffea000efff4c8
[    2.450072] R13: ffff8883bfffee60 R14: 0000000000000010 R15: 0000000000000001
[    2.451959] FS:  0000000000000000(0000) GS:ffff8883b9c00000(0000) knlGS:0000000000000000
[    2.454083] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.455604] CR2: 00000000ffffffff CR3: 00000003b9a37002 CR4: 0000000000060ee0
[    2.457484] Call Trace:
[    2.458171]  __pagevec_lru_add_fn+0x15f/0x2c0
[    2.459376]  pagevec_lru_move_fn+0x87/0xd0
[    2.460500]  ? pagevec_move_tail_fn+0x2d0/0x2d0
[    2.461712]  lru_add_drain_cpu+0x8d/0x160
[    2.462787]  lru_add_drain+0x18/0x20
[    2.463757]  shift_arg_pages+0xb8/0x180
[    2.464789]  ? vprintk_emit+0x101/0x1c0
[    2.465813]  ? printk+0x58/0x6f
[    2.466659]  setup_arg_pages+0x205/0x240
[    2.467716]  load_elf_binary+0x34a/0x1560
[    2.468789]  ? get_user_pages_remote+0x159/0x280
[    2.470024]  ? selinux_inode_permission+0x10d/0x1e0
[    2.471323]  ? _raw_read_unlock+0xa/0x20
[    2.472375]  ? load_misc_binary+0x2b2/0x410
[    2.473492]  search_binary_handler+0x60/0xe0
[    2.474634]  __do_execve_file.isra.0+0x512/0x850
[    2.475888]  ? rest_init+0xc6/0xc6
[    2.476801]  do_execve+0x21/0x30
[    2.477671]  try_to_run_init_process+0x10/0x34
[    2.478855]  kernel_init+0xe2/0xfa
[    2.479776]  ret_from_fork+0x1f/0x30
[    2.480737] ---[ end trace e77079de9b22dc6a ]---

I just dropped the ext4 conversion from my local tree so I can boot
the machine and test XFS. Might have some more info when that
crashes and burns...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
