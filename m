Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21FF720E314
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jun 2020 00:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390541AbgF2VLR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jun 2020 17:11:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41633 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390385AbgF2VLQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jun 2020 17:11:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593465074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PQg9mnTPE3OOeRf345nAa+7X/PgZO8hEs5kvdWZYq50=;
        b=LsuiZsWrvI23s77FV1YO3LelqyyxQQmPk2eL3RjskggWzrHDlf11MKJ+2x95HvR+Dn/pqP
        Kn/NC/Fp0pCnYXn2q1ssSHdTQ+X+I2Q6Dd+qQhbE3QV0d2b83ggKylzpRck7WIln5sFsVl
        BSkz7+Z93h4v2ZVox/BdALTQN4oogw8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-X-Ye_i55MHmq0La0Lu7dAg-1; Mon, 29 Jun 2020 17:11:10 -0400
X-MC-Unique: X-Ye_i55MHmq0La0Lu7dAg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A6CAF107ACCA;
        Mon, 29 Jun 2020 21:11:08 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-176.rdu2.redhat.com [10.10.115.176])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A06A45C1B2;
        Mon, 29 Jun 2020 21:11:07 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 233D8220C58; Mon, 29 Jun 2020 17:11:07 -0400 (EDT)
Date:   Mon, 29 Jun 2020 17:11:07 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
        Maxim Patlasov <maximvp@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fuse_writepages_fill() optimization to avoid WARN_ON in
 tree_insert
Message-ID: <20200629211107.GB269627@redhat.com>
References: <2733b41a-b4c6-be94-0118-a1a8d6f26eec@virtuozzo.com>
 <d6e8ef46-c311-b993-909c-4ae2823e2237@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6e8ef46-c311-b993-909c-4ae2823e2237@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 25, 2020 at 12:02:53PM +0300, Vasily Averin wrote:
> In current implementation fuse_writepages_fill() tries to share the code:
> for new wpa it calls tree_insert() with num_pages = 0
> then switches to common code used non-modified num_pages
> and increments it at the very end.
> 
> Though it triggers WARN_ON(!wpa->ia.ap.num_pages) in tree_insert()
>  WARNING: CPU: 1 PID: 17211 at fs/fuse/file.c:1728 tree_insert+0xab/0xc0 [fuse]
>  RIP: 0010:tree_insert+0xab/0xc0 [fuse]
>  Call Trace:
>   fuse_writepages_fill+0x5da/0x6a0 [fuse]
>   write_cache_pages+0x171/0x470
>   fuse_writepages+0x8a/0x100 [fuse]
>   do_writepages+0x43/0xe0
> 
> This patch re-works fuse_writepages_fill() to call tree_insert()
> with num_pages = 1 and avoids its subsequent increment and
> an extra spin_lock(&fi->lock) for newly added wpa.
> 
> Fixes: 6b2fb79963fb ("fuse: optimize writepages search")
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>

I think I am facing this issue with virtiofs. I am running podman which
mounts overlayfs over virtiofs (virtiofs uses fuse). While running podman
I am seeing tons of following warnings no console. So this needs to
be fixed in 5.8-rc.

[24908.795483] ------------[ cut here ]------------
[24908.795484] WARNING: CPU: 6 PID: 11376 at fs/fuse/file.c:1684 tree_insert+0xaf/0xc0
[24908.795484] Modules linked in: ip6table_nat ip6_tables xt_conntrack xt_MASQUERADE xt_comment iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 veth overlay dax_pmem_compat virtio_net device_dax dax_pmem_core net_failover joydev failover br_netfilter bridge drm stp llc virtiofs virtio_blk serio_raw nd_pmem nd_btt qemu_fw_cfg
[24908.795495] CPU: 6 PID: 11376 Comm: dnf Tainted: G        W         5.8.0-rc2+ #18
[24908.795496] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
[24908.795496] RIP: 0010:tree_insert+0xaf/0xc0
[24908.795497] Code: 80 c8 00 00 00 49 c7 80 d0 00 00 00 00 00 00 00 49 c7 80 d8 00 00 00 00 00 00 00 48 89 39 e9 a8 9a 1b 00 0f 0b eb a5 0f 0b c3 <0f> 0b e9 71 ff ff ff 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00
[24908.795497] RSP: 0018:ffffb17840717bc0 EFLAGS: 00010246
[24908.795498] RAX: 0000000000000000 RBX: ffffb17840717d20 RCX: 8c6318c6318c6319
[24908.795499] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff9f6cc1a72ee0
[24908.795499] RBP: ffffe0dedfd6e640 R08: ffff9f6d1261c800 R09: ffffffffffffffff
[24908.795500] R10: ffff9f6cc1a72ee0 R11: 0000000000000000 R12: ffffe0dee05725c0
[24908.795500] R13: ffff9f6cc1a72a00 R14: ffff9f6cc1a72f90 R15: ffff9f6d1261c800
[24908.795501] FS:  00007f377b267740(0000) GS:ffff9f6d1fa00000(0000) knlGS:0000000000000000
[24908.795501] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[24908.795502] CR2: 00007f37777588e8 CR3: 0000000828a0e000 CR4: 00000000000006e0
[24908.795502] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[24908.795503] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[24908.795503] Call Trace:
[24908.795504]  fuse_writepages_fill+0x5b0/0x670
[24908.795504]  write_cache_pages+0x1c2/0x4b0
[24908.795504]  ? fuse_writepages+0x110/0x110
[24908.795505]  fuse_writepages+0x8d/0x110
[24908.795505]  do_writepages+0x34/0xc0
[24908.795506]  __filemap_fdatawrite_range+0xc5/0x100
[24908.795506]  filemap_write_and_wait_range+0x40/0xa0
[24908.795507]  remove_vma+0x31/0x70
[24908.795507]  __do_munmap+0x2d9/0x4a0
[24908.795507]  __vm_munmap+0x6a/0xc0
[24908.795508]  __x64_sys_munmap+0x28/0x30
[24908.795508]  do_syscall_64+0x52/0xb0
[24908.795509]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[24908.795509] RIP: 0033:0x7f377b81067b
[24908.795510] Code: Bad RIP value.
[24908.795510] RSP: 002b:00007ffd88f96fd8 EFLAGS: 00000246 ORIG_RAX: 000000000000000b
[24908.795511] RAX: ffffffffffffffda RBX: 0000559c662c79d0 RCX: 00007f377b81067b
[24908.795511] RDX: 0000559c66349720 RSI: 0000000000104000 RDI: 00007f37778da000
[24908.795512] RBP: 00007f37778da1e0 R08: 00007f3777894308 R09: 0000000000000001
[24908.795512] R10: 00000000000001a4 R11: 0000000000000246 R12: 0000000000000000
[24908.795513] R13: 0000559c65d843a0 R14: 00007f37778da000 R15: 0000000000000017
[24908.795515] irq event stamp: 3775373
[24908.795515] hardirqs last  enabled at (3775373): [<ffffffffa72f6a21>] page_outside_zone_boundaries+0xd1/0x100
[24908.795516] hardirqs last disabled at (3775372): [<ffffffffa72f698e>] page_outside_zone_boundaries+0x3e/0x100
[24908.795517] softirqs last  enabled at (3775348): [<ffffffffa7e0035d>] __do_softirq+0x35d/0x400
[24908.795517] softirqs last disabled at (3775341): [<ffffffffa7c01052>] asm_call_on_stack+0x12/0x20
[24908.795518] ---[ end trace f23c513c015212d2 ]---

