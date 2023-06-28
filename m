Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89F8741C20
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 01:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbjF1XEQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 19:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjF1XEP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 19:04:15 -0400
Received: from out-60.mta0.migadu.com (out-60.mta0.migadu.com [IPv6:2001:41d0:1004:224b::3c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BE61FF7
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 16:04:11 -0700 (PDT)
Date:   Wed, 28 Jun 2023 19:04:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687993449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n1NBF5nCxeGMfm3yFL1KqEorwLvtBumKTQnSQsLCInE=;
        b=BKyaUNu/ROG5ru0ShHylysNpN3BAUZDhPBxqmW56p702urijDqdIKmGrgB2mUfhj6L1apt
        Ot/mlc8W5NahLVLfwDtfHoJ2gCceAWv5jAZ8V2MVsKn/Xh63Hgj6XJ6LcWIKY80+tlSisQ
        69wNZ0z/M1EqTxKdvQMa0h7ZOkxrM2k=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20230628230407.nvi7us7eeya4yl2s@moria.home.lan>
References: <20230627020525.2vqnt2pxhtgiddyv@moria.home.lan>
 <b92ea170-d531-00f3-ca7a-613c05dcbf5f@kernel.dk>
 <23922545-917a-06bd-ec92-ff6aa66118e2@kernel.dk>
 <20230627201524.ool73bps2lre2tsz@moria.home.lan>
 <c06a9e0b-8f3e-4e47-53d0-b4854a98cc44@kernel.dk>
 <20230628040114.oz46icbsjpa4egpp@moria.home.lan>
 <b02657af-5bbb-b46b-cea0-ee89f385f3c1@kernel.dk>
 <20230628175421.funhhfbx5kdvhclx@moria.home.lan>
 <4d3efe17-e114-96c1-dca8-a100cc6f7fc6@kernel.dk>
 <131fdf9b-bd31-fc0d-8fe9-8f68592306e5@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <131fdf9b-bd31-fc0d-8fe9-8f68592306e5@kernel.dk>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 28, 2023 at 04:14:44PM -0600, Jens Axboe wrote:
> Got a whole bunch more running that aio reproducer I sent earlier. I'm
> sure a lot of these are dupes, sending them here for completeness.

Are you running 'echo scan > /sys/kernel/debug/kmemleak' while the test
is running? I see a lot of spurious leaks when I do that that go away if
I scan after everything's shut down.

> 
> [  677.739815] kmemleak: 2 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
> [ 1283.963249] kmemleak: 37 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
> 
> unreferenced object 0xffff0000e35de000 (size 8192):
>   comm "mount", pid 3049, jiffies 4294924385 (age 3938.092s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     1d 00 1d 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<00000000bcb1cd8d>] slab_post_alloc_hook.isra.0+0xb4/0xbc
>     [<0000000027d98280>] __kmem_cache_alloc_node+0xd0/0x178
>     [<000000005602d414>] __kmalloc_node_track_caller+0xa8/0xd0
>     [<0000000078a13296>] krealloc+0x7c/0xc4
>     [<00000000f1fea4ad>] bch2_sb_realloc+0x12c/0x150
>     [<00000000f03d5ce6>] __copy_super+0x104/0x17c
>     [<000000005567521f>] bch2_sb_to_fs+0x3c/0x80
>     [<0000000062d4e9f6>] bch2_fs_alloc+0x410/0xbcc
>     [<00000000223e06bf>] bch2_fs_open+0x19c/0x430
>     [<00000000e72d508e>] bch2_mount+0x194/0x45c
>     [<00000000b040daa5>] legacy_get_tree+0x2c/0x54
>     [<00000000ba80f9a0>] vfs_get_tree+0x28/0xd4
>     [<00000000527b4561>] path_mount+0x5d0/0x6c8
>     [<00000000dc643d96>] do_mount+0x80/0xa4
>     [<00000000f493e836>] __arm64_sys_mount+0x150/0x168
>     [<00000000595788f9>] invoke_syscall.constprop.0+0x70/0xb8
> unreferenced object 0xffff00020a209900 (size 128):
>   comm "mount", pid 3049, jiffies 4294924385 (age 3938.092s)
>   hex dump (first 32 bytes):
>     03 01 01 00 02 01 01 00 04 01 01 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<00000000bcb1cd8d>] slab_post_alloc_hook.isra.0+0xb4/0xbc
>     [<0000000027d98280>] __kmem_cache_alloc_node+0xd0/0x178
>     [<00000000cd9515c0>] __kmalloc+0xac/0xd4
>     [<00000000fcf82258>] kmalloc_array.constprop.0+0x18/0x20
>     [<00000000182c3be4>] __bch2_sb_replicas_v0_to_cpu_replicas+0x50/0x118
>     [<0000000012583a94>] bch2_sb_replicas_to_cpu_replicas+0xb0/0xc0
>     [<00000000fcd0b373>] bch2_sb_to_fs+0x4c/0x80
>     [<0000000062d4e9f6>] bch2_fs_alloc+0x410/0xbcc
>     [<00000000223e06bf>] bch2_fs_open+0x19c/0x430
>     [<00000000e72d508e>] bch2_mount+0x194/0x45c
>     [<00000000b040daa5>] legacy_get_tree+0x2c/0x54
>     [<00000000ba80f9a0>] vfs_get_tree+0x28/0xd4
>     [<00000000527b4561>] path_mount+0x5d0/0x6c8
>     [<00000000dc643d96>] do_mount+0x80/0xa4
>     [<00000000f493e836>] __arm64_sys_mount+0x150/0x168
>     [<00000000595788f9>] invoke_syscall.constprop.0+0x70/0xb8
> unreferenced object 0xffff000206785400 (size 128):
>   comm "mount", pid 3049, jiffies 4294924391 (age 3938.068s)
>   hex dump (first 32 bytes):
>     00 00 d9 20 02 00 ff ff 01 00 00 00 01 04 00 00  ... ............
>     01 04 00 00 01 04 00 00 01 04 00 00 01 04 00 00  ................
>   backtrace:
>     [<00000000bcb1cd8d>] slab_post_alloc_hook.isra.0+0xb4/0xbc
>     [<0000000027d98280>] __kmem_cache_alloc_node+0xd0/0x178
>     [<000000007b360995>] __kmalloc_node+0xac/0xd4
>     [<0000000050ae8904>] mempool_init_node+0x64/0xd8
>     [<00000000e714c59a>] mempool_init+0x14/0x1c
>     [<00000000bb95f8a0>] bch2_fs_alloc+0x690/0xbcc
>     [<00000000223e06bf>] bch2_fs_open+0x19c/0x430
>     [<00000000e72d508e>] bch2_mount+0x194/0x45c
>     [<00000000b040daa5>] legacy_get_tree+0x2c/0x54
>     [<00000000ba80f9a0>] vfs_get_tree+0x28/0xd4
>     [<00000000527b4561>] path_mount+0x5d0/0x6c8
>     [<00000000dc643d96>] do_mount+0x80/0xa4
>     [<00000000f493e836>] __arm64_sys_mount+0x150/0x168
>     [<00000000595788f9>] invoke_syscall.constprop.0+0x70/0xb8
>     [<00000000e707b03d>] do_el0_svc+0xbc/0xf0
>     [<00000000b4ee996a>] el0_svc+0x74/0x9c
> unreferenced object 0xffff000206785700 (size 128):
>   comm "mount", pid 3049, jiffies 4294924391 (age 3938.076s)
>   hex dump (first 32 bytes):
>     00 00 96 2d 02 00 ff ff 01 00 00 00 01 04 00 00  ...-............
>     01 04 00 00 01 04 00 00 01 04 00 00 01 04 00 00  ................
>   backtrace:
>     [<00000000bcb1cd8d>] slab_post_alloc_hook.isra.0+0xb4/0xbc
>     [<0000000027d98280>] __kmem_cache_alloc_node+0xd0/0x178
>     [<000000007b360995>] __kmalloc_node+0xac/0xd4
>     [<0000000050ae8904>] mempool_init_node+0x64/0xd8
>     [<00000000e714c59a>] mempool_init+0x14/0x1c
>     [<0000000089ab54c3>] bch2_fs_replicas_init+0x64/0xac
>     [<0000000056c4a5fe>] bch2_fs_alloc+0x79c/0xbcc
>     [<00000000223e06bf>] bch2_fs_open+0x19c/0x430
>     [<00000000e72d508e>] bch2_mount+0x194/0x45c
>     [<00000000b040daa5>] legacy_get_tree+0x2c/0x54
>     [<00000000ba80f9a0>] vfs_get_tree+0x28/0xd4
>     [<00000000527b4561>] path_mount+0x5d0/0x6c8
>     [<00000000dc643d96>] do_mount+0x80/0xa4
>     [<00000000f493e836>] __arm64_sys_mount+0x150/0x168
>     [<00000000595788f9>] invoke_syscall.constprop.0+0x70/0xb8
>     [<00000000e707b03d>] do_el0_svc+0xbc/0xf0
> unreferenced object 0xffff000206785600 (size 128):
>   comm "mount", pid 3049, jiffies 4294924391 (age 3938.076s)
>   hex dump (first 32 bytes):
>     00 1a 05 00 00 00 00 00 00 0c 02 00 00 00 00 00  ................
>     42 9c ba 00 00 00 00 00 00 00 00 00 00 00 00 00  B...............
>   backtrace:
>     [<00000000bcb1cd8d>] slab_post_alloc_hook.isra.0+0xb4/0xbc
>     [<0000000027d98280>] __kmem_cache_alloc_node+0xd0/0x178
>     [<00000000cd9515c0>] __kmalloc+0xac/0xd4
>     [<00000000f949dcc7>] replicas_table_update+0x84/0x214
>     [<000000002debc89d>] bch2_fs_replicas_init+0x74/0xac
>     [<0000000056c4a5fe>] bch2_fs_alloc+0x79c/0xbcc
>     [<00000000223e06bf>] bch2_fs_open+0x19c/0x430
>     [<00000000e72d508e>] bch2_mount+0x194/0x45c
>     [<00000000b040daa5>] legacy_get_tree+0x2c/0x54
>     [<00000000ba80f9a0>] vfs_get_tree+0x28/0xd4
>     [<00000000527b4561>] path_mount+0x5d0/0x6c8
>     [<00000000dc643d96>] do_mount+0x80/0xa4
>     [<00000000f493e836>] __arm64_sys_mount+0x150/0x168
>     [<00000000595788f9>] invoke_syscall.constprop.0+0x70/0xb8
>     [<00000000e707b03d>] do_el0_svc+0xbc/0xf0
>     [<00000000b4ee996a>] el0_svc+0x74/0x9c
> unreferenced object 0xffff000206785580 (size 128):
>   comm "mount", pid 3049, jiffies 4294924391 (age 3938.076s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 01 00 00 00 01 04 00 00  ................
>     01 04 00 00 01 04 00 00 01 04 00 00 01 04 00 00  ................
>   backtrace:
>     [<00000000bcb1cd8d>] slab_post_alloc_hook.isra.0+0xb4/0xbc
>     [<0000000027d98280>] __kmem_cache_alloc_node+0xd0/0x178
>     [<00000000cd9515c0>] __kmalloc+0xac/0xd4
>     [<00000000639b7f33>] replicas_table_update+0x98/0x214
>     [<000000002debc89d>] bch2_fs_replicas_init+0x74/0xac
>     [<0000000056c4a5fe>] bch2_fs_alloc+0x79c/0xbcc
>     [<00000000223e06bf>] bch2_fs_open+0x19c/0x430
>     [<00000000e72d508e>] bch2_mount+0x194/0x45c
>     [<00000000b040daa5>] legacy_get_tree+0x2c/0x54
>     [<00000000ba80f9a0>] vfs_get_tree+0x28/0xd4
>     [<00000000527b4561>] path_mount+0x5d0/0x6c8
>     [<00000000dc643d96>] do_mount+0x80/0xa4
>     [<00000000f493e836>] __arm64_sys_mount+0x150/0x168
>     [<00000000595788f9>] invoke_syscall.constprop.0+0x70/0xb8
>     [<00000000e707b03d>] do_el0_svc+0xbc/0xf0
>     [<00000000b4ee996a>] el0_svc+0x74/0x9c
> unreferenced object 0xffff000206785080 (size 128):
>   comm "mount", pid 3049, jiffies 4294924391 (age 3938.088s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<00000000bcb1cd8d>] slab_post_alloc_hook.isra.0+0xb4/0xbc
>     [<0000000027d98280>] __kmem_cache_alloc_node+0xd0/0x178
>     [<00000000cd9515c0>] __kmalloc+0xac/0xd4
>     [<000000001335974a>] __prealloc_shrinker+0x3c/0x60
>     [<0000000017b0bc26>] register_shrinker+0x14/0x34
>     [<00000000c07d01d7>] bch2_fs_btree_cache_init+0xf8/0x150
>     [<000000004b948640>] bch2_fs_alloc+0x7ac/0xbcc
>     [<00000000223e06bf>] bch2_fs_open+0x19c/0x430
>     [<00000000e72d508e>] bch2_mount+0x194/0x45c
>     [<00000000b040daa5>] legacy_get_tree+0x2c/0x54
>     [<00000000ba80f9a0>] vfs_get_tree+0x28/0xd4
>     [<00000000527b4561>] path_mount+0x5d0/0x6c8
>     [<00000000dc643d96>] do_mount+0x80/0xa4
>     [<00000000f493e836>] __arm64_sys_mount+0x150/0x168
>     [<00000000595788f9>] invoke_syscall.constprop.0+0x70/0xb8
>     [<00000000e707b03d>] do_el0_svc+0xbc/0xf0
> unreferenced object 0xffff000200f2ec00 (size 1024):
>   comm "mount", pid 3049, jiffies 4294924391 (age 3938.088s)
>   hex dump (first 32 bytes):
>     40 00 00 00 00 00 00 00 a8 66 18 09 00 00 00 00  @........f......
>     10 ec f2 00 02 00 ff ff 10 ec f2 00 02 00 ff ff  ................
>   backtrace:
>     [<00000000bcb1cd8d>] slab_post_alloc_hook.isra.0+0xb4/0xbc
>     [<0000000027d98280>] __kmem_cache_alloc_node+0xd0/0x178
>     [<000000007b360995>] __kmalloc_node+0xac/0xd4
>     [<0000000066405974>] kvmalloc_node+0x54/0xe4
>     [<00000000a51f16c9>] bucket_table_alloc.isra.0+0x44/0x120
>     [<0000000000df2e94>] rhashtable_init+0x148/0x1ac
>     [<0000000080f397f7>] bch2_fs_btree_key_cache_init+0x48/0x90
>     [<0000000089e6783c>] bch2_fs_alloc+0x7c0/0xbcc
>     [<00000000223e06bf>] bch2_fs_open+0x19c/0x430
>     [<00000000e72d508e>] bch2_mount+0x194/0x45c
>     [<00000000b040daa5>] legacy_get_tree+0x2c/0x54
>     [<00000000ba80f9a0>] vfs_get_tree+0x28/0xd4
>     [<00000000527b4561>] path_mount+0x5d0/0x6c8
>     [<00000000dc643d96>] do_mount+0x80/0xa4
>     [<00000000f493e836>] __arm64_sys_mount+0x150/0x168
>     [<00000000595788f9>] invoke_syscall.constprop.0+0x70/0xb8
> unreferenced object 0xffff000206785b80 (size 128):
>   comm "mount", pid 3049, jiffies 4294924391 (age 3938.088s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<00000000bcb1cd8d>] slab_post_alloc_hook.isra.0+0xb4/0xbc
>     [<0000000027d98280>] __kmem_cache_alloc_node+0xd0/0x178
>     [<00000000cd9515c0>] __kmalloc+0xac/0xd4
>     [<000000001335974a>] __prealloc_shrinker+0x3c/0x60
>     [<0000000017b0bc26>] register_shrinker+0x14/0x34
>     [<00000000228dd43a>] bch2_fs_btree_key_cache_init+0x88/0x90
>     [<0000000089e6783c>] bch2_fs_alloc+0x7c0/0xbcc
>     [<00000000223e06bf>] bch2_fs_open+0x19c/0x430
>     [<00000000e72d508e>] bch2_mount+0x194/0x45c
>     [<00000000b040daa5>] legacy_get_tree+0x2c/0x54
>     [<00000000ba80f9a0>] vfs_get_tree+0x28/0xd4
>     [<00000000527b4561>] path_mount+0x5d0/0x6c8
>     [<00000000dc643d96>] do_mount+0x80/0xa4
>     [<00000000f493e836>] __arm64_sys_mount+0x150/0x168
>     [<00000000595788f9>] invoke_syscall.constprop.0+0x70/0xb8
>     [<00000000e707b03d>] do_el0_svc+0xbc/0xf0
> unreferenced object 0xffff000206785500 (size 128):
>   comm "mount", pid 3049, jiffies 4294924391 (age 3938.096s)
>   hex dump (first 32 bytes):
>     00 00 20 2b 02 00 ff ff 01 00 00 00 01 04 00 00  .. +............
>     01 04 00 00 01 04 00 00 01 04 00 00 01 04 00 00  ................
>   backtrace:
>     [<00000000bcb1cd8d>] slab_post_alloc_hook.isra.0+0xb4/0xbc
>     [<0000000027d98280>] __kmem_cache_alloc_node+0xd0/0x178
>     [<000000007b360995>] __kmalloc_node+0xac/0xd4
>     [<0000000050ae8904>] mempool_init_node+0x64/0xd8
>     [<00000000e714c59a>] mempool_init+0x14/0x1c
>     [<00000000fc134979>] bch2_fs_btree_iter_init+0x98/0x130
>     [<00000000addf57f5>] bch2_fs_alloc+0x7d0/0xbcc
>     [<00000000223e06bf>] bch2_fs_open+0x19c/0x430
>     [<00000000e72d508e>] bch2_mount+0x194/0x45c
>     [<00000000b040daa5>] legacy_get_tree+0x2c/0x54
>     [<00000000ba80f9a0>] vfs_get_tree+0x28/0xd4
>     [<00000000527b4561>] path_mount+0x5d0/0x6c8
>     [<00000000dc643d96>] do_mount+0x80/0xa4
>     [<00000000f493e836>] __arm64_sys_mount+0x150/0x168
>     [<00000000595788f9>] invoke_syscall.constprop.0+0x70/0xb8
>     [<00000000e707b03d>] do_el0_svc+0xbc/0xf0
> unreferenced object 0xffff000206785480 (size 128):
>   comm "mount", pid 3049, jiffies 4294924391 (age 3938.096s)
>   hex dump (first 32 bytes):
>     00 00 97 05 02 00 ff ff 01 00 00 00 01 04 00 00  ................
>     01 04 00 00 01 04 00 00 01 04 00 00 01 04 00 00  ................
>   backtrace:
>     [<00000000bcb1cd8d>] slab_post_alloc_hook.isra.0+0xb4/0xbc
>     [<0000000027d98280>] __kmem_cache_alloc_node+0xd0/0x178
>     [<000000007b360995>] __kmalloc_node+0xac/0xd4
>     [<0000000050ae8904>] mempool_init_node+0x64/0xd8
>     [<00000000e714c59a>] mempool_init+0x14/0x1c
>     [<000000004d03e2b7>] bch2_fs_btree_iter_init+0xb8/0x130
>     [<00000000addf57f5>] bch2_fs_alloc+0x7d0/0xbcc
>     [<00000000223e06bf>] bch2_fs_open+0x19c/0x430
>     [<00000000e72d508e>] bch2_mount+0x194/0x45c
>     [<00000000b040daa5>] legacy_get_tree+0x2c/0x54
>     [<00000000ba80f9a0>] vfs_get_tree+0x28/0xd4
>     [<00000000527b4561>] path_mount+0x5d0/0x6c8
>     [<00000000dc643d96>] do_mount+0x80/0xa4
>     [<00000000f493e836>] __arm64_sys_mount+0x150/0x168
>     [<00000000595788f9>] invoke_syscall.constprop.0+0x70/0xb8
>     [<00000000e707b03d>] do_el0_svc+0xbc/0xf0
> unreferenced object 0xffff000230a31a00 (size 512):
>   comm "mount", pid 3049, jiffies 4294924391 (age 3938.096s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<00000000bcb1cd8d>] slab_post_alloc_hook.isra.0+0xb4/0xbc
>     [<0000000027d98280>] __kmem_cache_alloc_node+0xd0/0x178
>     [<000000009502ae7b>] kmalloc_trace+0x38/0x78
>     [<0000000060cbc45a>] init_srcu_struct_fields+0x38/0x284
>     [<00000000643a7c95>] init_srcu_struct+0x10/0x18
>     [<00000000c46c2041>] bch2_fs_btree_iter_init+0xc8/0x130
>     [<00000000addf57f5>] bch2_fs_alloc+0x7d0/0xbcc
>     [<00000000223e06bf>] bch2_fs_open+0x19c/0x430
>     [<00000000e72d508e>] bch2_mount+0x194/0x45c
>     [<00000000b040daa5>] legacy_get_tree+0x2c/0x54
>     [<00000000ba80f9a0>] vfs_get_tree+0x28/0xd4
>     [<00000000527b4561>] path_mount+0x5d0/0x6c8
>     [<00000000dc643d96>] do_mount+0x80/0xa4
>     [<00000000f493e836>] __arm64_sys_mount+0x150/0x168
>     [<00000000595788f9>] invoke_syscall.constprop.0+0x70/0xb8
>     [<00000000e707b03d>] do_el0_svc+0xbc/0xf0
> unreferenced object 0xffff000222f14f00 (size 256):
>   comm "mount", pid 3049, jiffies 4294924391 (age 3938.100s)
>   hex dump (first 32 bytes):
>     03 00 00 00 01 00 ff ff 1a cf e0 f2 17 b2 a8 24  ...............$
>     cf 4a ba c3 fb 05 19 cd f6 4d f5 45 e7 e8 29 eb  .J.......M.E..).
>   backtrace:
>     [<00000000bcb1cd8d>] slab_post_alloc_hook.isra.0+0xb4/0xbc
>     [<0000000027d98280>] __kmem_cache_alloc_node+0xd0/0x178
>     [<000000007b360995>] __kmalloc_node+0xac/0xd4
>     [<0000000066405974>] kvmalloc_node+0x54/0xe4
>     [<00000000c83b22ef>] bch2_fs_buckets_waiting_for_journal_init+0x44/0x6c
>     [<0000000026230712>] bch2_fs_alloc+0x7f0/0xbcc
>     [<00000000223e06bf>] bch2_fs_open+0x19c/0x430
>     [<00000000e72d508e>] bch2_mount+0x194/0x45c
>     [<00000000b040daa5>] legacy_get_tree+0x2c/0x54
>     [<00000000ba80f9a0>] vfs_get_tree+0x28/0xd4
>     [<00000000527b4561>] path_mount+0x5d0/0x6c8
>     [<00000000dc643d96>] do_mount+0x80/0xa4
>     [<00000000f493e836>] __arm64_sys_mount+0x150/0x168
>     [<00000000595788f9>] invoke_syscall.constprop.0+0x70/0xb8
>     [<00000000e707b03d>] do_el0_svc+0xbc/0xf0
>     [<00000000b4ee996a>] el0_svc+0x74/0x9c
> unreferenced object 0xffff000230e00000 (size 720896):
>   comm "mount", pid 3049, jiffies 4294924391 (age 3938.100s)
>   hex dump (first 32 bytes):
>     40 71 26 38 00 00 00 00 00 00 00 00 00 00 00 00  @q&8............
>     d2 17 f9 2f 75 7e 51 2a 01 01 00 00 14 00 00 00  .../u~Q*........
>   backtrace:
>     [<00000000c6d9e620>] __kmalloc_large_node+0x134/0x164
>     [<000000009024f86b>] __kmalloc_node+0x34/0xd4
>     [<0000000066405974>] kvmalloc_node+0x54/0xe4
>     [<00000000729eb36b>] bch2_fs_btree_write_buffer_init+0x58/0xb4
>     [<000000003e35ba10>] bch2_fs_alloc+0x800/0xbcc
>     [<00000000223e06bf>] bch2_fs_open+0x19c/0x430
>     [<00000000e72d508e>] bch2_mount+0x194/0x45c
>     [<00000000b040daa5>] legacy_get_tree+0x2c/0x54
>     [<00000000ba80f9a0>] vfs_get_tree+0x28/0xd4
>     [<00000000527b4561>] path_mount+0x5d0/0x6c8
>     [<00000000dc643d96>] do_mount+0x80/0xa4
>     [<00000000f493e836>] __arm64_sys_mount+0x150/0x168
>     [<00000000595788f9>] invoke_syscall.constprop.0+0x70/0xb8
>     [<00000000e707b03d>] do_el0_svc+0xbc/0xf0
>     [<00000000b4ee996a>] el0_svc+0x74/0x9c
>     [<00000000a22b66b5>] el0t_64_sync_handler+0xa8/0x134
> unreferenced object 0xffff000230900000 (size 720896):
>   comm "mount", pid 3049, jiffies 4294924391 (age 3938.100s)
>   hex dump (first 32 bytes):
>     88 96 28 f7 00 00 00 00 00 00 00 00 00 00 00 00  ..(.............
>     d2 17 f9 2f 75 7e 51 2a 01 01 00 00 13 00 00 00  .../u~Q*........
>   backtrace:
>     [<00000000c6d9e620>] __kmalloc_large_node+0x134/0x164
>     [<000000009024f86b>] __kmalloc_node+0x34/0xd4
>     [<0000000066405974>] kvmalloc_node+0x54/0xe4
>     [<00000000f27707f5>] bch2_fs_btree_write_buffer_init+0x7c/0xb4
>     [<000000003e35ba10>] bch2_fs_alloc+0x800/0xbcc
>     [<00000000223e06bf>] bch2_fs_open+0x19c/0x430
>     [<00000000e72d508e>] bch2_mount+0x194/0x45c
>     [<00000000b040daa5>] legacy_get_tree+0x2c/0x54
>     [<00000000ba80f9a0>] vfs_get_tree+0x28/0xd4
>     [<00000000527b4561>] path_mount+0x5d0/0x6c8
>     [<00000000dc643d96>] do_mount+0x80/0xa4
>     [<00000000f493e836>] __arm64_sys_mount+0x150/0x168
>     [<00000000595788f9>] invoke_syscall.constprop.0+0x70/0xb8
>     [<00000000e707b03d>] do_el0_svc+0xbc/0xf0
>     [<00000000b4ee996a>] el0_svc+0x74/0x9c
>     [<00000000a22b66b5>] el0t_64_sync_handler+0xa8/0x134
> unreferenced object 0xffff0000c8d1e300 (size 128):
>   comm "mount", pid 3049, jiffies 4294924391 (age 3938.108s)
>   hex dump (first 32 bytes):
>     00 c0 0a 02 02 00 ff ff 00 80 5a 20 00 80 ff ff  ..........Z ....
>     00 50 00 00 00 00 00 00 02 00 00 00 00 00 00 00  .P..............
>   backtrace:
>     [<00000000bcb1cd8d>] slab_post_alloc_hook.isra.0+0xb4/0xbc
>     [<0000000027d98280>] __kmem_cache_alloc_node+0xd0/0x178
>     [<000000007b360995>] __kmalloc_node+0xac/0xd4
>     [<0000000050ae8904>] mempool_init_node+0x64/0xd8
>     [<00000000e714c59a>] mempool_init+0x14/0x1c
>     [<000000001719fe70>] bioset_init+0x188/0x22c
>     [<000000004a1ea042>] bch2_fs_io_init+0x2c/0x124
>     [<000000005ef642fb>] bch2_fs_alloc+0x820/0xbcc
>     [<00000000223e06bf>] bch2_fs_open+0x19c/0x430
>     [<00000000e72d508e>] bch2_mount+0x194/0x45c
>     [<00000000b040daa5>] legacy_get_tree+0x2c/0x54
>     [<00000000ba80f9a0>] vfs_get_tree+0x28/0xd4
>     [<00000000527b4561>] path_mount+0x5d0/0x6c8
>     [<00000000dc643d96>] do_mount+0x80/0xa4
>     [<00000000f493e836>] __arm64_sys_mount+0x150/0x168
>     [<00000000595788f9>] invoke_syscall.constprop.0+0x70/0xb8
> unreferenced object 0xffff0002020ac000 (size 448):
>   comm "mount", pid 3049, jiffies 4294924391 (age 3938.108s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 c8 02 00 02 02 00 ff ff  ................
>   backtrace:
>     [<00000000bcb1cd8d>] slab_post_alloc_hook.isra.0+0xb4/0xbc
>     [<0000000047719e9d>] kmem_cache_alloc+0xd0/0x17c
>     [<00000000af89e1a3>] mempool_alloc_slab+0x24/0x2c
>     [<000000002d6118f3>] mempool_init_node+0x94/0xd8
>     [<00000000e714c59a>] mempool_init+0x14/0x1c
>     [<000000001719fe70>] bioset_init+0x188/0x22c
>     [<000000004a1ea042>] bch2_fs_io_init+0x2c/0x124
>     [<000000005ef642fb>] bch2_fs_alloc+0x820/0xbcc
>     [<00000000223e06bf>] bch2_fs_open+0x19c/0x430
>     [<00000000e72d508e>] bch2_mount+0x194/0x45c
>     [<00000000b040daa5>] legacy_get_tree+0x2c/0x54
>     [<00000000ba80f9a0>] vfs_get_tree+0x28/0xd4
>     [<00000000527b4561>] path_mount+0x5d0/0x6c8
>     [<00000000dc643d96>] do_mount+0x80/0xa4
>     [<00000000f493e836>] __arm64_sys_mount+0x150/0x168
>     [<00000000595788f9>] invoke_syscall.constprop.0+0x70/0xb8
> unreferenced object 0xffff0000c8d1e500 (size 128):
>   comm "mount", pid 3049, jiffies 4294924391 (age 3938.108s)
>   hex dump (first 32 bytes):
>     00 40 e4 c9 00 00 ff ff c0 d9 9a 03 00 fc ff ff  .@..............
>     80 d9 9a 03 00 fc ff ff 40 d9 9a 03 00 fc ff ff  ........@.......
>   backtrace:
>     [<00000000bcb1cd8d>] slab_post_alloc_hook.isra.0+0xb4/0xbc
>     [<0000000027d98280>] __kmem_cache_alloc_node+0xd0/0x178
>     [<000000007b360995>] __kmalloc_node+0xac/0xd4
>     [<0000000050ae8904>] mempool_init_node+0x64/0xd8
>     [<00000000e714c59a>] mempool_init+0x14/0x1c
>     [<000000002f5588b4>] biovec_init_pool+0x24/0x2c
>     [<00000000a2b87494>] bioset_init+0x208/0x22c
>     [<000000004a1ea042>] bch2_fs_io_init+0x2c/0x124
>     [<000000005ef642fb>] bch2_fs_alloc+0x820/0xbcc
>     [<00000000223e06bf>] bch2_fs_open+0x19c/0x430
>     [<00000000e72d508e>] bch2_mount+0x194/0x45c
>     [<00000000b040daa5>] legacy_get_tree+0x2c/0x54
>     [<00000000ba80f9a0>] vfs_get_tree+0x28/0xd4
>     [<00000000527b4561>] path_mount+0x5d0/0x6c8
>     [<00000000dc643d96>] do_mount+0x80/0xa4
>     [<00000000f493e836>] __arm64_sys_mount+0x150/0x168
> unreferenced object 0xffff0000c8d1e900 (size 128):
>   comm "mount", pid 3049, jiffies 4294924391 (age 3938.116s)
>   hex dump (first 32 bytes):
>     00 c2 0a 02 02 00 ff ff 00 00 58 20 00 80 ff ff  ..........X ....
>     00 50 00 00 00 00 00 00 02 00 00 00 00 00 00 00  .P..............
>   backtrace:
>     [<00000000bcb1cd8d>] slab_post_alloc_hook.isra.0+0xb4/0xbc
>     [<0000000027d98280>] __kmem_cache_alloc_node+0xd0/0x178
>     [<000000007b360995>] __kmalloc_node+0xac/0xd4
>     [<0000000050ae8904>] mempool_init_node+0x64/0xd8
>     [<00000000e714c59a>] mempool_init+0x14/0x1c
>     [<000000001719fe70>] bioset_init+0x188/0x22c
>     [<000000007af2eb34>] bch2_fs_io_init+0x48/0x124
>     [<000000005ef642fb>] bch2_fs_alloc+0x820/0xbcc
>     [<00000000223e06bf>] bch2_fs_open+0x19c/0x430
>     [<00000000e72d508e>] bch2_mount+0x194/0x45c
>     [<00000000b040daa5>] legacy_get_tree+0x2c/0x54
>     [<00000000ba80f9a0>] vfs_get_tree+0x28/0xd4
>     [<00000000527b4561>] path_mount+0x5d0/0x6c8
>     [<00000000dc643d96>] do_mount+0x80/0xa4
>     [<00000000f493e836>] __arm64_sys_mount+0x150/0x168
>     [<00000000595788f9>] invoke_syscall.constprop.0+0x70/0xb8
> unreferenced object 0xffff0002020ac200 (size 448):
>   comm "mount", pid 3049, jiffies 4294924391 (age 3938.116s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 0d 69 37 bf  .............i7.
>     00 00 00 00 00 00 00 00 c8 c2 0a 02 02 00 ff ff  ................
>   backtrace:
>     [<00000000bcb1cd8d>] slab_post_alloc_hook.isra.0+0xb4/0xbc
>     [<0000000047719e9d>] kmem_cache_alloc+0xd0/0x17c
>     [<00000000af89e1a3>] mempool_alloc_slab+0x24/0x2c
>     [<000000002d6118f3>] mempool_init_node+0x94/0xd8
>     [<00000000e714c59a>] mempool_init+0x14/0x1c
>     [<000000001719fe70>] bioset_init+0x188/0x22c
>     [<000000007af2eb34>] bch2_fs_io_init+0x48/0x124
>     [<000000005ef642fb>] bch2_fs_alloc+0x820/0xbcc
>     [<00000000223e06bf>] bch2_fs_open+0x19c/0x430
>     [<00000000e72d508e>] bch2_mount+0x194/0x45c
>     [<00000000b040daa5>] legacy_get_tree+0x2c/0x54
>     [<00000000ba80f9a0>] vfs_get_tree+0x28/0xd4
>     [<00000000527b4561>] path_mount+0x5d0/0x6c8
>     [<00000000dc643d96>] do_mount+0x80/0xa4
>     [<00000000f493e836>] __arm64_sys_mount+0x150/0x168
>     [<00000000595788f9>] invoke_syscall.constprop.0+0x70/0xb8
> unreferenced object 0xffff0000c8d1e980 (size 128):
>   comm "mount", pid 3049, jiffies 4294924391 (age 3938.116s)
>   hex dump (first 32 bytes):
>     00 50 e4 c9 00 00 ff ff c0 dc 9a 03 00 fc ff ff  .P..............
>     80 dc 9a 03 00 fc ff ff 40 44 23 03 00 fc ff ff  ........@D#.....
>   backtrace:
>     [<00000000bcb1cd8d>] slab_post_alloc_hook.isra.0+0xb4/0xbc
>     [<0000000027d98280>] __kmem_cache_alloc_node+0xd0/0x178
>     [<000000007b360995>] __kmalloc_node+0xac/0xd4
>     [<0000000050ae8904>] mempool_init_node+0x64/0xd8
>     [<00000000e714c59a>] mempool_init+0x14/0x1c
>     [<000000002f5588b4>] biovec_init_pool+0x24/0x2c
>     [<00000000a2b87494>] bioset_init+0x208/0x22c
>     [<000000007af2eb34>] bch2_fs_io_init+0x48/0x124
>     [<000000005ef642fb>] bch2_fs_alloc+0x820/0xbcc
>     [<00000000223e06bf>] bch2_fs_open+0x19c/0x430
>     [<00000000e72d508e>] bch2_mount+0x194/0x45c
>     [<00000000b040daa5>] legacy_get_tree+0x2c/0x54
>     [<00000000ba80f9a0>] vfs_get_tree+0x28/0xd4
>     [<00000000527b4561>] path_mount+0x5d0/0x6c8
>     [<00000000dc643d96>] do_mount+0x80/0xa4
>     [<00000000f493e836>] __arm64_sys_mount+0x150/0x168
> unreferenced object 0xffff000230a31e00 (size 512):
>   comm "mount", pid 3049, jiffies 4294924391 (age 3938.120s)
>   hex dump (first 32 bytes):
>     00 9f 39 08 00 fc ff ff 40 f9 99 08 00 fc ff ff  ..9.....@.......
>     40 c0 8b 08 00 fc ff ff 00 d8 14 08 00 fc ff ff  @...............
>   backtrace:
>     [<00000000bcb1cd8d>] slab_post_alloc_hook.isra.0+0xb4/0xbc
>     [<0000000027d98280>] __kmem_cache_alloc_node+0xd0/0x178
>     [<000000007b360995>] __kmalloc_node+0xac/0xd4
>     [<0000000050ae8904>] mempool_init_node+0x64/0xd8
>     [<00000000e714c59a>] mempool_init+0x14/0x1c
>     [<000000009f58f780>] bch2_fs_io_init+0x9c/0x124
>     [<000000005ef642fb>] bch2_fs_alloc+0x820/0xbcc
>     [<00000000223e06bf>] bch2_fs_open+0x19c/0x430
>     [<00000000e72d508e>] bch2_mount+0x194/0x45c
>     [<00000000b040daa5>] legacy_get_tree+0x2c/0x54
>     [<00000000ba80f9a0>] vfs_get_tree+0x28/0xd4
>     [<00000000527b4561>] path_mount+0x5d0/0x6c8
>     [<00000000dc643d96>] do_mount+0x80/0xa4
>     [<00000000f493e836>] __arm64_sys_mount+0x150/0x168
>     [<00000000595788f9>] invoke_syscall.constprop.0+0x70/0xb8
>     [<00000000e707b03d>] do_el0_svc+0xbc/0xf0
> unreferenced object 0xffff000200f2e800 (size 1024):
>   comm "mount", pid 3049, jiffies 4294924391 (age 3938.120s)
>   hex dump (first 32 bytes):
>     40 00 00 00 00 00 00 00 89 16 1e cd 00 00 00 00  @...............
>     10 e8 f2 00 02 00 ff ff 10 e8 f2 00 02 00 ff ff  ................
>   backtrace:
>     [<00000000bcb1cd8d>] slab_post_alloc_hook.isra.0+0xb4/0xbc
>     [<0000000027d98280>] __kmem_cache_alloc_node+0xd0/0x178
>     [<000000007b360995>] __kmalloc_node+0xac/0xd4
>     [<0000000066405974>] kvmalloc_node+0x54/0xe4
>     [<00000000a51f16c9>] bucket_table_alloc.isra.0+0x44/0x120
>     [<0000000000df2e94>] rhashtable_init+0x148/0x1ac
>     [<00000000347789c6>] bch2_fs_io_init+0xb8/0x124
>     [<000000005ef642fb>] bch2_fs_alloc+0x820/0xbcc
>     [<00000000223e06bf>] bch2_fs_open+0x19c/0x430
>     [<00000000e72d508e>] bch2_mount+0x194/0x45c
>     [<00000000b040daa5>] legacy_get_tree+0x2c/0x54
>     [<00000000ba80f9a0>] vfs_get_tree+0x28/0xd4
>     [<00000000527b4561>] path_mount+0x5d0/0x6c8
>     [<00000000dc643d96>] do_mount+0x80/0xa4
>     [<00000000f493e836>] __arm64_sys_mount+0x150/0x168
>     [<00000000595788f9>] invoke_syscall.constprop.0+0x70/0xb8
> unreferenced object 0xffff000222f14700 (size 256):
>   comm "mount", pid 3049, jiffies 4294924391 (age 3938.120s)
>   hex dump (first 32 bytes):
>     68 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  h...............
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<00000000bcb1cd8d>] slab_post_alloc_hook.isra.0+0xb4/0xbc
>     [<0000000027d98280>] __kmem_cache_alloc_node+0xd0/0x178
>     [<000000007b360995>] __kmalloc_node+0xac/0xd4
>     [<000000003a6af69a>] crypto_alloc_tfmmem+0x3c/0x70
>     [<000000006c0841c0>] crypto_create_tfm_node+0x20/0xa0
>     [<00000000b0aa6a0f>] crypto_alloc_tfm_node+0x94/0xac
>     [<00000000a2421d04>] crypto_alloc_shash+0x20/0x28
>     [<00000000aeafee8e>] bch2_fs_encryption_init+0x64/0x150
>     [<0000000002e060b3>] bch2_fs_alloc+0x840/0xbcc
>     [<00000000223e06bf>] bch2_fs_open+0x19c/0x430
>     [<00000000e72d508e>] bch2_mount+0x194/0x45c
>     [<00000000b040daa5>] legacy_get_tree+0x2c/0x54
>     [<00000000ba80f9a0>] vfs_get_tree+0x28/0xd4
>     [<00000000527b4561>] path_mount+0x5d0/0x6c8
>     [<00000000dc643d96>] do_mount+0x80/0xa4
>     [<00000000f493e836>] __arm64_sys_mount+0x150/0x168
> unreferenced object 0xffff00020e544100 (size 128):
>   comm "mount", pid 3049, jiffies 4294924391 (age 3938.128s)
>   hex dump (first 32 bytes):
>     00 00 f0 20 02 00 ff ff 80 04 f0 20 02 00 ff ff  ... ....... ....
>     00 09 f0 20 02 00 ff ff 80 0d f0 20 02 00 ff ff  ... ....... ....
>   backtrace:
>     [<00000000bcb1cd8d>] slab_post_alloc_hook.isra.0+0xb4/0xbc
>     [<0000000027d98280>] __kmem_cache_alloc_node+0xd0/0x178
>     [<000000007b360995>] __kmalloc_node+0xac/0xd4
>     [<0000000050ae8904>] mempool_init_node+0x64/0xd8
>     [<00000000e714c59a>] mempool_init+0x14/0x1c
>     [<000000001719fe70>] bioset_init+0x188/0x22c
>     [<00000000ad63d07f>] bch2_fs_fsio_init+0x8c/0x130
>     [<00000000048cf3b9>] bch2_fs_alloc+0x870/0xbcc
>     [<00000000223e06bf>] bch2_fs_open+0x19c/0x430
>     [<00000000e72d508e>] bch2_mount+0x194/0x45c
>     [<00000000b040daa5>] legacy_get_tree+0x2c/0x54
>     [<00000000ba80f9a0>] vfs_get_tree+0x28/0xd4
>     [<00000000527b4561>] path_mount+0x5d0/0x6c8
>     [<00000000dc643d96>] do_mount+0x80/0xa4
>     [<00000000f493e836>] __arm64_sys_mount+0x150/0x168
>     [<00000000595788f9>] invoke_syscall.constprop.0+0x70/0xb8
> unreferenced object 0xffff000220f00000 (size 1104):
>   comm "mount", pid 3049, jiffies 4294924391 (age 3938.128s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 98 e7 87 30 02 00 ff ff  ...........0....
>     22 01 00 00 00 00 ad de 18 00 f0 20 02 00 ff ff  ".......... ....
>   backtrace:
>     [<00000000bcb1cd8d>] slab_post_alloc_hook.isra.0+0xb4/0xbc
>     [<0000000047719e9d>] kmem_cache_alloc+0xd0/0x17c
>     [<00000000af89e1a3>] mempool_alloc_slab+0x24/0x2c
>     [<000000002d6118f3>] mempool_init_node+0x94/0xd8
>     [<00000000e714c59a>] mempool_init+0x14/0x1c
>     [<000000001719fe70>] bioset_init+0x188/0x22c
>     [<00000000ad63d07f>] bch2_fs_fsio_init+0x8c/0x130
>     [<00000000048cf3b9>] bch2_fs_alloc+0x870/0xbcc
>     [<00000000223e06bf>] bch2_fs_open+0x19c/0x430
>     [<00000000e72d508e>] bch2_mount+0x194/0x45c
>     [<00000000b040daa5>] legacy_get_tree+0x2c/0x54
>     [<00000000ba80f9a0>] vfs_get_tree+0x28/0xd4
>     [<00000000527b4561>] path_mount+0x5d0/0x6c8
>     [<00000000dc643d96>] do_mount+0x80/0xa4
>     [<00000000f493e836>] __arm64_sys_mount+0x150/0x168
>     [<00000000595788f9>] invoke_syscall.constprop.0+0x70/0xb8
> unreferenced object 0xffff000220f00480 (size 1104):
>   comm "mount", pid 3049, jiffies 4294924391 (age 3938.128s)
>   hex dump (first 32 bytes):
>     80 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     01 00 00 00 00 00 00 00 00 00 00 00 9d a2 98 2c  ...............,
>   backtrace:
>     [<00000000bcb1cd8d>] slab_post_alloc_hook.isra.0+0xb4/0xbc
>     [<0000000047719e9d>] kmem_cache_alloc+0xd0/0x17c
>     [<00000000af89e1a3>] mempool_alloc_slab+0x24/0x2c
>     [<000000002d6118f3>] mempool_init_node+0x94/0xd8
>     [<00000000e714c59a>] mempool_init+0x14/0x1c
>     [<000000001719fe70>] bioset_init+0x188/0x22c
>     [<00000000ad63d07f>] bch2_fs_fsio_init+0x8c/0x130
>     [<00000000048cf3b9>] bch2_fs_alloc+0x870/0xbcc
>     [<00000000223e06bf>] bch2_fs_open+0x19c/0x430
>     [<00000000e72d508e>] bch2_mount+0x194/0x45c
>     [<00000000b040daa5>] legacy_get_tree+0x2c/0x54
>     [<00000000ba80f9a0>] vfs_get_tree+0x28/0xd4
>     [<00000000527b4561>] path_mount+0x5d0/0x6c8
>     [<00000000dc643d96>] do_mount+0x80/0xa4
>     [<00000000f493e836>] __arm64_sys_mount+0x150/0x168
>     [<00000000595788f9>] invoke_syscall.constprop.0+0x70/0xb8
> unreferenced object 0xffff000220f00900 (size 1104):
>   comm "mount", pid 3049, jiffies 4294924391 (age 3938.132s)
>   hex dump (first 32 bytes):
>     22 01 00 00 00 00 ad de 08 09 f0 20 02 00 ff ff  ".......... ....
>     08 09 f0 20 02 00 ff ff b9 17 f0 20 02 00 ff ff  ... ....... ....
>   backtrace:
>     [<00000000bcb1cd8d>] slab_post_alloc_hook.isra.0+0xb4/0xbc
>     [<0000000047719e9d>] kmem_cache_alloc+0xd0/0x17c
>     [<00000000af89e1a3>] mempool_alloc_slab+0x24/0x2c
>     [<000000002d6118f3>] mempool_init_node+0x94/0xd8
>     [<00000000e714c59a>] mempool_init+0x14/0x1c
>     [<000000001719fe70>] bioset_init+0x188/0x22c
>     [<00000000ad63d07f>] bch2_fs_fsio_init+0x8c/0x130
>     [<00000000048cf3b9>] bch2_fs_alloc+0x870/0xbcc
>     [<00000000223e06bf>] bch2_fs_open+0x19c/0x430
>     [<00000000e72d508e>] bch2_mount+0x194/0x45c
>     [<00000000b040daa5>] legacy_get_tree+0x2c/0x54
>     [<00000000ba80f9a0>] vfs_get_tree+0x28/0xd4
>     [<00000000527b4561>] path_mount+0x5d0/0x6c8
>     [<00000000dc643d96>] do_mount+0x80/0xa4
>     [<00000000f493e836>] __arm64_sys_mount+0x150/0x168
>     [<00000000595788f9>] invoke_syscall.constprop.0+0x70/0xb8
> unreferenced object 0xffff000220f00d80 (size 1104):
>   comm "mount", pid 3049, jiffies 4294924391 (age 3938.132s)
>   hex dump (first 32 bytes):
>     01 00 00 00 00 00 00 00 00 00 00 00 34 43 3f b1  ............4C?.
>     00 00 00 00 00 00 00 00 24 00 bb 04 02 28 1e 3b  ........$....(.;
>   backtrace:
>     [<00000000bcb1cd8d>] slab_post_alloc_hook.isra.0+0xb4/0xbc
>     [<0000000047719e9d>] kmem_cache_alloc+0xd0/0x17c
>     [<00000000af89e1a3>] mempool_alloc_slab+0x24/0x2c
>     [<000000002d6118f3>] mempool_init_node+0x94/0xd8
>     [<00000000e714c59a>] mempool_init+0x14/0x1c
>     [<000000001719fe70>] bioset_init+0x188/0x22c
>     [<00000000ad63d07f>] bch2_fs_fsio_init+0x8c/0x130
>     [<00000000048cf3b9>] bch2_fs_alloc+0x870/0xbcc
>     [<00000000223e06bf>] bch2_fs_open+0x19c/0x430
>     [<00000000e72d508e>] bch2_mount+0x194/0x45c
>     [<00000000b040daa5>] legacy_get_tree+0x2c/0x54
>     [<00000000ba80f9a0>] vfs_get_tree+0x28/0xd4
>     [<00000000527b4561>] path_mount+0x5d0/0x6c8
>     [<00000000dc643d96>] do_mount+0x80/0xa4
>     [<00000000f493e836>] __arm64_sys_mount+0x150/0x168
>     [<00000000595788f9>] invoke_syscall.constprop.0+0x70/0xb8
> unreferenced object 0xffff00020e544000 (size 128):
>   comm "mount", pid 3049, jiffies 4294924391 (age 3938.132s)
>   hex dump (first 32 bytes):
>     00 00 b5 05 02 00 ff ff 00 50 b5 05 02 00 ff ff  .........P......
>     00 10 b5 05 02 00 ff ff 00 b0 18 09 02 00 ff ff  ................
>   backtrace:
>     [<00000000bcb1cd8d>] slab_post_alloc_hook.isra.0+0xb4/0xbc
>     [<0000000027d98280>] __kmem_cache_alloc_node+0xd0/0x178
>     [<000000007b360995>] __kmalloc_node+0xac/0xd4
>     [<0000000050ae8904>] mempool_init_node+0x64/0xd8
>     [<00000000e714c59a>] mempool_init+0x14/0x1c
>     [<000000002f5588b4>] biovec_init_pool+0x24/0x2c
>     [<00000000a2b87494>] bioset_init+0x208/0x22c
>     [<00000000ad63d07f>] bch2_fs_fsio_init+0x8c/0x130
>     [<00000000048cf3b9>] bch2_fs_alloc+0x870/0xbcc
>     [<00000000223e06bf>] bch2_fs_open+0x19c/0x430
>     [<00000000e72d508e>] bch2_mount+0x194/0x45c
>     [<00000000b040daa5>] legacy_get_tree+0x2c/0x54
>     [<00000000ba80f9a0>] vfs_get_tree+0x28/0xd4
>     [<00000000527b4561>] path_mount+0x5d0/0x6c8
>     [<00000000dc643d96>] do_mount+0x80/0xa4
>     [<00000000f493e836>] __arm64_sys_mount+0x150/0x168
> unreferenced object 0xffff00020918b000 (size 4096):
>   comm "mount", pid 3049, jiffies 4294924391 (age 3938.140s)
>   hex dump (first 32 bytes):
>     c0 5b 26 03 00 fc ff ff 00 10 00 00 00 00 00 00  .[&.............
>     22 01 00 00 00 00 ad de 18 b0 18 09 02 00 ff ff  "...............
>   backtrace:
>     [<00000000bcb1cd8d>] slab_post_alloc_hook.isra.0+0xb4/0xbc
>     [<0000000047719e9d>] kmem_cache_alloc+0xd0/0x17c
>     [<00000000af89e1a3>] mempool_alloc_slab+0x24/0x2c
>     [<000000002d6118f3>] mempool_init_node+0x94/0xd8
>     [<00000000e714c59a>] mempool_init+0x14/0x1c
>     [<000000002f5588b4>] biovec_init_pool+0x24/0x2c
>     [<00000000a2b87494>] bioset_init+0x208/0x22c
>     [<00000000ad63d07f>] bch2_fs_fsio_init+0x8c/0x130
>     [<00000000048cf3b9>] bch2_fs_alloc+0x870/0xbcc
>     [<00000000223e06bf>] bch2_fs_open+0x19c/0x430
>     [<00000000e72d508e>] bch2_mount+0x194/0x45c
>     [<00000000b040daa5>] legacy_get_tree+0x2c/0x54
>     [<00000000ba80f9a0>] vfs_get_tree+0x28/0xd4
>     [<00000000527b4561>] path_mount+0x5d0/0x6c8
>     [<00000000dc643d96>] do_mount+0x80/0xa4
>     [<00000000f493e836>] __arm64_sys_mount+0x150/0x168
> unreferenced object 0xffff000200f2f400 (size 1024):
>   comm "mount", pid 3049, jiffies 4294924391 (age 3938.140s)
>   hex dump (first 32 bytes):
>     19 00 00 00 00 00 00 00 9d 19 00 00 00 00 00 00  ................
>     a6 19 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<00000000bcb1cd8d>] slab_post_alloc_hook.isra.0+0xb4/0xbc
>     [<0000000027d98280>] __kmem_cache_alloc_node+0xd0/0x178
>     [<00000000cd9515c0>] __kmalloc+0xac/0xd4
>     [<0000000097d0e280>] bch2_blacklist_table_initialize+0x48/0xc4
>     [<000000007af2f7c0>] bch2_fs_recovery+0x220/0x140c
>     [<00000000835fe5c8>] bch2_fs_start+0x104/0x2ac
>     [<00000000f2c8e79f>] bch2_fs_open+0x2cc/0x430
>     [<00000000e72d508e>] bch2_mount+0x194/0x45c
>     [<00000000b040daa5>] legacy_get_tree+0x2c/0x54
>     [<00000000ba80f9a0>] vfs_get_tree+0x28/0xd4
>     [<00000000527b4561>] path_mount+0x5d0/0x6c8
>     [<00000000dc643d96>] do_mount+0x80/0xa4
>     [<00000000f493e836>] __arm64_sys_mount+0x150/0x168
>     [<00000000595788f9>] invoke_syscall.constprop.0+0x70/0xb8
>     [<00000000e707b03d>] do_el0_svc+0xbc/0xf0
>     [<00000000b4ee996a>] el0_svc+0x74/0x9c
> unreferenced object 0xffff00020e544800 (size 128):
>   comm "mount", pid 3049, jiffies 4294924391 (age 3938.140s)
>   hex dump (first 32 bytes):
>     07 00 00 01 09 00 00 00 73 74 61 72 74 69 6e 67  ........starting
>     20 6a 6f 75 72 6e 61 6c 20 61 74 20 65 6e 74 72   journal at entr
>   backtrace:
>     [<00000000bcb1cd8d>] slab_post_alloc_hook.isra.0+0xb4/0xbc
>     [<0000000027d98280>] __kmem_cache_alloc_node+0xd0/0x178
>     [<000000005602d414>] __kmalloc_node_track_caller+0xa8/0xd0
>     [<0000000078a13296>] krealloc+0x7c/0xc4
>     [<00000000224f82f4>] __darray_make_room.constprop.0+0x5c/0x7c
>     [<00000000caa2f6f2>] __bch2_trans_log_msg+0x80/0x12c
>     [<0000000034a8dfea>] __bch2_fs_log_msg+0x68/0x158
>     [<00000000cc0719ad>] bch2_journal_log_msg+0x60/0x98
>     [<00000000a0b3d87b>] bch2_fs_recovery+0x8f0/0x140c
>     [<00000000835fe5c8>] bch2_fs_start+0x104/0x2ac
>     [<00000000f2c8e79f>] bch2_fs_open+0x2cc/0x430
>     [<00000000e72d508e>] bch2_mount+0x194/0x45c
>     [<00000000b040daa5>] legacy_get_tree+0x2c/0x54
>     [<00000000ba80f9a0>] vfs_get_tree+0x28/0xd4
>     [<00000000527b4561>] path_mount+0x5d0/0x6c8
>     [<00000000dc643d96>] do_mount+0x80/0xa4
> unreferenced object 0xffff00020f2d8398 (size 184):
>   comm "mount", pid 3049, jiffies 4294924395 (age 3938.128s)
>   hex dump (first 32 bytes):
>     00 00 00 00 02 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<00000000bcb1cd8d>] slab_post_alloc_hook.isra.0+0xb4/0xbc
>     [<0000000047719e9d>] kmem_cache_alloc+0xd0/0x17c
>     [<0000000059ea6346>] bch2_btree_path_traverse_cached_slowpath+0x240/0x9d0
>     [<00000000b340fce9>] bch2_btree_path_traverse_cached+0x7c/0x184
>     [<000000006b501914>] bch2_btree_path_traverse_one+0xbc/0x4f0
>     [<0000000046611bb8>] bch2_btree_path_traverse+0x20/0x30
>     [<00000000cb7378ca>] bch2_btree_iter_peek_slot+0xe4/0x3b0
>     [<000000005b36d96f>] __bch2_bkey_get_iter.constprop.0+0x40/0x74
>     [<00000000db6c00c7>] bch2_inode_peek+0x80/0xfc
>     [<00000000d48fafeb>] bch2_inode_find_by_inum_trans+0x34/0x74
>     [<00000000d94a8ca3>] bch2_vfs_inode_get+0xdc/0x1a0
>     [<00000000b7cffdf2>] bch2_mount+0x3bc/0x45c
>     [<00000000b040daa5>] legacy_get_tree+0x2c/0x54
>     [<00000000ba80f9a0>] vfs_get_tree+0x28/0xd4
>     [<00000000527b4561>] path_mount+0x5d0/0x6c8
>     [<00000000dc643d96>] do_mount+0x80/0xa4
> unreferenced object 0xffff000222f15e00 (size 256):
>   comm "mount", pid 3049, jiffies 4294924395 (age 3938.128s)
>   hex dump (first 32 bytes):
>     12 81 1d 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 ff ff ff ff 00 10 00 00 00 00 00 00  ................
>   backtrace:
>     [<00000000bcb1cd8d>] slab_post_alloc_hook.isra.0+0xb4/0xbc
>     [<0000000027d98280>] __kmem_cache_alloc_node+0xd0/0x178
>     [<00000000cd9515c0>] __kmalloc+0xac/0xd4
>     [<0000000080dcf5d4>] btree_key_cache_fill+0x190/0x338
>     [<00000000142a161b>] bch2_btree_path_traverse_cached_slowpath+0x8d8/0x9d0
>     [<00000000b340fce9>] bch2_btree_path_traverse_cached+0x7c/0x184
>     [<000000006b501914>] bch2_btree_path_traverse_one+0xbc/0x4f0
>     [<0000000046611bb8>] bch2_btree_path_traverse+0x20/0x30
>     [<00000000cb7378ca>] bch2_btree_iter_peek_slot+0xe4/0x3b0
>     [<000000005b36d96f>] __bch2_bkey_get_iter.constprop.0+0x40/0x74
>     [<00000000db6c00c7>] bch2_inode_peek+0x80/0xfc
>     [<00000000d48fafeb>] bch2_inode_find_by_inum_trans+0x34/0x74
>     [<00000000d94a8ca3>] bch2_vfs_inode_get+0xdc/0x1a0
>     [<00000000b7cffdf2>] bch2_mount+0x3bc/0x45c
>     [<00000000b040daa5>] legacy_get_tree+0x2c/0x54
>     [<00000000ba80f9a0>] vfs_get_tree+0x28/0xd4
> unreferenced object 0xffff00020ab0da80 (size 128):
>   comm "fio", pid 3068, jiffies 4294924399 (age 3938.112s)
>   hex dump (first 32 bytes):
>     70 61 74 68 3a 20 69 64 78 20 20 30 20 72 65 66  path: idx  0 ref
>     20 30 3a 30 20 50 20 53 20 62 74 72 65 65 3d 73   0:0 P S btree=s
>   backtrace:
>     [<00000000bcb1cd8d>] slab_post_alloc_hook.isra.0+0xb4/0xbc
>     [<0000000027d98280>] __kmem_cache_alloc_node+0xd0/0x178
>     [<000000005602d414>] __kmalloc_node_track_caller+0xa8/0xd0
>     [<0000000078a13296>] krealloc+0x7c/0xc4
>     [<00000000ac6de278>] bch2_printbuf_make_room+0x6c/0x9c
>     [<00000000e73dab89>] bch2_prt_printf+0xac/0x104
>     [<00000000ef2c8dc5>] bch2_btree_path_to_text+0x6c/0xb8
>     [<00000000eab3e43c>] __bch2_trans_paths_to_text+0x60/0x64
>     [<00000000d843d03a>] bch2_trans_paths_to_text+0x10/0x18
>     [<00000000fbe77c9c>] bch2_trans_update_max_paths+0x6c/0x104
>     [<00000000715f184d>] btree_path_alloc+0x44/0x140
>     [<0000000028aac82e>] bch2_path_get+0x190/0x210
>     [<000000001fbd1416>] bch2_trans_iter_init_outlined+0xd4/0x100
>     [<00000000b7c2c8e8>] bch2_trans_iter_init.constprop.0+0x28/0x30
>     [<000000005ee45b0d>] __bch2_dirent_lookup_trans+0xc4/0x20c
>     [<00000000bf9849b2>] bch2_dirent_lookup+0x9c/0x10c
> unreferenced object 0xffff00020f2d8450 (size 184):
>   comm "fio", pid 3068, jiffies 4294924400 (age 3938.112s)
>   hex dump (first 32 bytes):
>     00 00 00 00 02 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<00000000bcb1cd8d>] slab_post_alloc_hook.isra.0+0xb4/0xbc
>     [<0000000047719e9d>] kmem_cache_alloc+0xd0/0x17c
>     [<0000000059ea6346>] bch2_btree_path_traverse_cached_slowpath+0x240/0x9d0
>     [<00000000b340fce9>] bch2_btree_path_traverse_cached+0x7c/0x184
>     [<000000006b501914>] bch2_btree_path_traverse_one+0xbc/0x4f0
>     [<0000000046611bb8>] bch2_btree_path_traverse+0x20/0x30
>     [<00000000cb7378ca>] bch2_btree_iter_peek_slot+0xe4/0x3b0
>     [<000000005b36d96f>] __bch2_bkey_get_iter.constprop.0+0x40/0x74
>     [<00000000db6c00c7>] bch2_inode_peek+0x80/0xfc
>     [<00000000d48fafeb>] bch2_inode_find_by_inum_trans+0x34/0x74
>     [<00000000d94a8ca3>] bch2_vfs_inode_get+0xdc/0x1a0
>     [<00000000225a6085>] bch2_lookup+0x7c/0xb8
>     [<0000000059304a98>] __lookup_slow+0xd4/0x114
>     [<000000001225c82d>] walk_component+0x98/0xd4
>     [<0000000095114e46>] path_lookupat+0x84/0x114
>     [<000000002ee74fa2>] filename_lookup+0x54/0xc4
> unreferenced object 0xffff000222f15a00 (size 256):
>   comm "fio", pid 3068, jiffies 4294924400 (age 3938.112s)
>   hex dump (first 32 bytes):
>     13 81 1d 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 ff ff ff ff f3 15 00 30 00 00 00 00  ...........0....
>   backtrace:
>     [<00000000bcb1cd8d>] slab_post_alloc_hook.isra.0+0xb4/0xbc
>     [<0000000027d98280>] __kmem_cache_alloc_node+0xd0/0x178
>     [<00000000cd9515c0>] __kmalloc+0xac/0xd4
>     [<0000000080dcf5d4>] btree_key_cache_fill+0x190/0x338
>     [<00000000142a161b>] bch2_btree_path_traverse_cached_slowpath+0x8d8/0x9d0
>     [<00000000b340fce9>] bch2_btree_path_traverse_cached+0x7c/0x184
>     [<000000006b501914>] bch2_btree_path_traverse_one+0xbc/0x4f0
>     [<0000000046611bb8>] bch2_btree_path_traverse+0x20/0x30
>     [<00000000cb7378ca>] bch2_btree_iter_peek_slot+0xe4/0x3b0
>     [<000000005b36d96f>] __bch2_bkey_get_iter.constprop.0+0x40/0x74
>     [<00000000db6c00c7>] bch2_inode_peek+0x80/0xfc
>     [<00000000d48fafeb>] bch2_inode_find_by_inum_trans+0x34/0x74
>     [<00000000d94a8ca3>] bch2_vfs_inode_get+0xdc/0x1a0
>     [<00000000225a6085>] bch2_lookup+0x7c/0xb8
>     [<0000000059304a98>] __lookup_slow+0xd4/0x114
>     [<000000001225c82d>] walk_component+0x98/0xd4
> unreferenced object 0xffff0002058e0e00 (size 256):
>   comm "fio", pid 3081, jiffies 4294924461 (age 3937.868s)
>   hex dump (first 32 bytes):
>     70 61 74 68 3a 20 69 64 78 20 20 31 20 72 65 66  path: idx  1 ref
>     20 30 3a 30 20 50 20 20 20 62 74 72 65 65 3d 65   0:0 P   btree=e
>   backtrace:
>     [<00000000bcb1cd8d>] slab_post_alloc_hook.isra.0+0xb4/0xbc
>     [<0000000027d98280>] __kmem_cache_alloc_node+0xd0/0x178
>     [<000000005602d414>] __kmalloc_node_track_caller+0xa8/0xd0
>     [<0000000078a13296>] krealloc+0x7c/0xc4
>     [<00000000ac6de278>] bch2_printbuf_make_room+0x6c/0x9c
>     [<00000000e73dab89>] bch2_prt_printf+0xac/0x104
>     [<00000000ef2c8dc5>] bch2_btree_path_to_text+0x6c/0xb8
>     [<00000000eab3e43c>] __bch2_trans_paths_to_text+0x60/0x64
>     [<00000000d843d03a>] bch2_trans_paths_to_text+0x10/0x18
>     [<00000000fbe77c9c>] bch2_trans_update_max_paths+0x6c/0x104
>     [<00000000af279ad9>] __bch2_btree_path_make_mut+0x64/0x1d0
>     [<00000000b6ea382b>] __bch2_btree_path_set_pos+0x5c/0x1f4
>     [<000000001f2292b9>] bch2_btree_path_set_pos+0x68/0x78
>     [<0000000046402275>] bch2_btree_iter_peek_slot+0xd0/0x3b0
>     [<00000000a578d851>] bchfs_read.isra.0+0x128/0x77c
>     [<00000000d544d588>] bch2_readahead+0x1a0/0x264
> 
> -- 
> Jens Axboe
> 
