Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89383393BC5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 May 2021 04:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236273AbhE1C75 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 May 2021 22:59:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37480 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236270AbhE1C75 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 May 2021 22:59:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622170703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PDfo64ot3MfXTHWM7lsjrQfamO1epBDIMTrTHrz5+EA=;
        b=C2u0PmRRt8rjbpxFvaeyRBDa+rI3+JIcI7yxJowf+n9IvySwX2bkg2BTykx8AU0xoGGWs1
        70VXswwRG5ikriDbUG7h297CIsr/frd7hw5r1GNGS3HRD/i76L8SHne5yCtgA9POU9wJgh
        /P93KGZ0X0a6ohUo/7XmoO/DiTTBrpM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-544-qcKtirEwOdGYA8lAqqPSyA-1; Thu, 27 May 2021 22:58:19 -0400
X-MC-Unique: qcKtirEwOdGYA8lAqqPSyA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59B4A1005D50;
        Fri, 28 May 2021 02:58:18 +0000 (UTC)
Received: from T590 (ovpn-12-72.pek2.redhat.com [10.72.12.72])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 34B1310016FF;
        Fri, 28 May 2021 02:58:09 +0000 (UTC)
Date:   Fri, 28 May 2021 10:58:04 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Dennis Zhou <dennis@kernel.org>,
        Dave Chinner <dchinner@redhat.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH v5 2/2] writeback, cgroup: release dying cgwbs by
 switching attached inodes
Message-ID: <YLBcPCHJOYH4YGl6@T590>
References: <20210526222557.3118114-1-guro@fb.com>
 <20210526222557.3118114-3-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526222557.3118114-3-guro@fb.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 26, 2021 at 03:25:57PM -0700, Roman Gushchin wrote:
> Asynchronously try to release dying cgwbs by switching clean attached
> inodes to the bdi's wb. It helps to get rid of per-cgroup writeback
> structures themselves and of pinned memory and block cgroups, which
> are way larger structures (mostly due to large per-cpu statistics
> data). It helps to prevent memory waste and different scalability
> problems caused by large piles of dying cgroups.
> 
> A cgwb cleanup operation can fail due to different reasons (e.g. the
> cgwb has in-glight/pending io, an attached inode is locked or isn't
> clean, etc). In this case the next scheduled cleanup will make a new
> attempt. An attempt is made each time a new cgwb is offlined (in other
> words a memcg and/or a blkcg is deleted by a user). In the future an
> additional attempt scheduled by a timer can be implemented.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> ---
>  fs/fs-writeback.c                | 35 ++++++++++++++++++
>  include/linux/backing-dev-defs.h |  1 +
>  include/linux/writeback.h        |  1 +
>  mm/backing-dev.c                 | 61 ++++++++++++++++++++++++++++++--
>  4 files changed, 96 insertions(+), 2 deletions(-)
> 

Hello Roman,

The following kernel panic is triggered by this patch:

[root@ktest-01 xfstests-dev]# ./check generic/563
[   47.186811] SGI XFS with ACLs, security attributes, realtime, verbose warnings, quota, no debug enabled
[   47.190152] XFS (sdb): Mounting V5 Filesystem
[   47.201551] XFS (sdb): Ending clean mount
[   47.205501] xfs filesystem being mounted at /mnt/test supports timestamps until 2038 (0x7fffffff)
FSTYP         -- xfs (non-debug)
PLATFORM      -- Linux/x86_64 ktest-01 5.13.0-rc3+ #294 SMP Fri May 28 10:51:02 CST 2021
MKFS_OPTIONS  -- -f -bsize=4096 /dev/sda
MOUNT_OPTIONS -- /dev/sda /mnt/scratch

[   47.431775] XFS (sda): Mounting V5 Filesystem
[   47.441731] XFS (sda): Ending clean mount
[   47.445080] xfs filesystem being mounted at /mnt/scratch supports timestamps until 2038 (0x7fffffff)
[   47.449189] XFS (sda): Unmounting Filesystem
[   47.473863] XFS (sdb): Unmounting Filesystem
[   47.614561] XFS (sdb): Mounting V5 Filesystem
[   47.628670] XFS (sdb): Ending clean mount
[   47.631904] xfs filesystem being mounted at /mnt/test supports timestamps until 2038 (0x7fffffff)
generic/563 1s ... [   47.661393] run fstests generic/563 at 2021-05-28 02:54:59
[   47.947414] loop0: detected capacity change from 0 to 16777216
[   48.034564] XFS (loop0): Mounting V5 Filesystem
[   48.069959] XFS (loop0): Ending clean mount
[   48.070726] xfs filesystem being mounted at /mnt/scratch supports timestamps until 2038 (0x7fffffff)
[   48.132314] XFS (loop0): Unmounting Filesystem
[   48.204548] XFS (loop0): Mounting V5 Filesystem
[   48.215500] XFS (loop0): Ending clean mount
[   48.219223] xfs filesystem being mounted at /mnt/scratch supports timestamps until 2038 (0x7fffffff)
[   48.534420] XFS (loop0): Unmounting Filesystem
[   48.535142] ------------[ cut here ]------------
[   48.535921] WARNING: CPU: 3 PID: 114 at mm/backing-dev.c:402 cgwb_release_workfn+0xa4/0xd8
[   48.537461] Modules linked in: xfs libcrc32c iTCO_wdt i2c_i801 iTCO_vendor_support nvme i2c_smbus lpc_ich usb_storage i2c_s
[   48.540613] CPU: 3 PID: 114 Comm: kworker/3:1 Not tainted 5.13.0-rc3+ #294
[   48.541927] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-1.fc33 04/01/2014
[   48.543439] Workqueue: cgwb_release cgwb_release_workfn
[   48.544365] RIP: 0010:cgwb_release_workfn+0xa4/0xd8
[   48.545185] Code: 00 00 00 48 85 db 75 d5 48 8d 7d 80 e8 98 71 20 00 48 8d bd 70 ff ff ff e8 36 7b 1d 00 48 8b 55 f0 48 8d4
[   48.548935] RSP: 0018:ffffc90001f47e88 EFLAGS: 00010202
[   48.549844] RAX: ffff88810321d280 RBX: ffffffff82f69ac0 RCX: 0000000080400011
[   48.552645] RDX: ffffffff82669f00 RSI: 0000000000210d00 RDI: ffff888100042500
[   48.553935] RBP: ffff88810321d290 R08: 0000000000000001 R09: ffffffff811c8754
[   48.555054] R10: 000000000000005e R11: 0000000000000046 R12: ffff88810321d000
[   48.556183] R13: ffff88815c4f2300 R14: 0000000000000000 R15: 0000000000000000
[   48.557116] FS:  0000000000000000(0000) GS:ffff88815c4c0000(0000) knlGS:0000000000000000
[   48.558131] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   48.558818] CR2: 00007f3aba17f9c0 CR3: 0000000108e86004 CR4: 0000000000370ee0
[   48.559950] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   48.561057] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   48.562075] Call Trace:
[   48.562421]  elfcorehdr_read+0xf/0xf
[   48.562920]  ? worker_thread+0x117/0x1b9
[   48.563443]  ? rescuer_thread+0x291/0x291
[   48.564001]  ? kthread+0xec/0xf4
[   48.564411]  ? kthread_create_worker_on_cpu+0x65/0x65
[   48.565086]  ? ret_from_fork+0x1f/0x30
[   48.565594] ---[ end trace bdeef00aa75cca5c ]---
[   48.601694] XFS (loop0): Mounting V5 Filesystem
[   48.605863] XFS (loop0): Ending clean mount
[   48.607129] xfs filesystem being mounted at /mnt/scratch supports timestamps until 2038 (0x7fffffff)
[   48.830734] general protection fault, probably for non-canonical address 0xffff11033f71f000: 0000 [#1] SMP NOPTI
[   48.832720] CPU: 10 PID: 234 Comm: kworker/10:1 Tainted: G        W         5.13.0-rc3+ #294
[   48.833932] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-1.fc33 04/01/2014
[   48.835146] Workqueue: events cleanup_offline_cgwbs_workfn
[   48.835952] RIP: 0010:percpu_ref_tryget_many.constprop.0+0x12/0x43
[   48.836849] Code: 48 8b 47 08 48 8b 40 08 ff d0 0f 1f 00 eb 04 65 48 ff 08 e9 25 fd ff ff 41 54 48 8b 07 a8 03 74 09 48 8b4
[   48.839494] RSP: 0018:ffffc90001383e58 EFLAGS: 00010046
[   48.840246] RAX: ffff88810321f000 RBX: ffff88810321d280 RCX: ffff8881016f9770
[   48.841165] RDX: ffffffff82669f00 RSI: 0000000000000280 RDI: ffff88810321d200
[   48.842050] RBP: ffffc90001383e68 R08: ffff88810006c8b0 R09: 000073746e657665
[   48.843224] R10: 8080808080808080 R11: fefefefefefefeff R12: ffff88810321d200
[   48.844133] R13: ffff88810321d000 R14: 0000000000000000 R15: 0000000000000000
[   48.845022] FS:  0000000000000000(0000) GS:ffff88823c500000(0000) knlGS:0000000000000000
[   48.845903] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   48.846495] CR2: 00007fb630166198 CR3: 0000000179a1e006 CR4: 0000000000370ee0
[   48.847414] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   48.848405] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   48.849126] Call Trace:
[   48.849388]  cleanup_offline_cgwbs_workfn+0x8a/0x14c
[   48.849906]  process_one_work+0x15c/0x234
[   48.850346]  worker_thread+0x117/0x1b9
[   48.850706]  ? rescuer_thread+0x291/0x291
[   48.851065]  kthread+0xec/0xf4
[   48.851346]  ? kthread_create_worker_on_cpu+0x65/0x65
[   48.851815]  ret_from_fork+0x1f/0x30
[   48.852151] Modules linked in: xfs libcrc32c iTCO_wdt i2c_i801 iTCO_vendor_support nvme i2c_smbus lpc_ich usb_storage i2c_s
[   48.854166] Dumping ftrace buffer:
[   48.854546]    (ftrace buffer empty)
[   48.854909] ---[ end trace bdeef00aa75cca5d ]---



Thanks, 
Ming

