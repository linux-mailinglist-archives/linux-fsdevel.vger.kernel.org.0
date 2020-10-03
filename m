Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C70228209A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Oct 2020 04:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbgJCCow (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Oct 2020 22:44:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38393 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725562AbgJCCow (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Oct 2020 22:44:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601693089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pmt/NFGOMfjXSvFg2hSwkpIXiVUYu79NUjIlXkSBJKs=;
        b=F8X7yPgs/P0X+rqNgPj+Y1j7FXECcdt5sDCeWth2j2giZuhp49FicsZpZBSDyGzsRHCPi8
        HT4hsFPtn5f+BG7gRFbr7ERLBzVqZBvIR78WMuhfvgVIa09FVWGTuSnIqVrV1JzEPYm9HQ
        GRrRuXUQxb5ZMZiqAqwdraMIrgkk6yE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-dTrPfswyODeXxZHNSwD3PA-1; Fri, 02 Oct 2020 22:44:47 -0400
X-MC-Unique: dTrPfswyODeXxZHNSwD3PA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6090C801AC9;
        Sat,  3 Oct 2020 02:44:46 +0000 (UTC)
Received: from ovpn-113-213.rdu2.redhat.com (ovpn-113-213.rdu2.redhat.com [10.10.113.213])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9DB475C1DA;
        Sat,  3 Oct 2020 02:44:37 +0000 (UTC)
Message-ID: <a2810c3a656115fab85fc173186f3e2c02a98182.camel@redhat.com>
Subject: Re: virtiofs: WARN_ON(out_sgs + in_sgs != total_sgs)
From:   Qian Cai <cai@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com
Date:   Fri, 02 Oct 2020 22:44:37 -0400
In-Reply-To: <5ea77e9f6cb8c2db43b09fbd4158ab2d8c066a0a.camel@redhat.com>
References: <5ea77e9f6cb8c2db43b09fbd4158ab2d8c066a0a.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2020-10-02 at 12:28 -0400, Qian Cai wrote:
> Running some fuzzing on virtiofs from a non-privileged user could trigger a
> warning in virtio_fs_enqueue_req():
> 
> WARN_ON(out_sgs + in_sgs != total_sgs);

Okay, I can reproduce this after running for a few hours:

out_sgs = 3, in_sgs = 2, total_sgs = 6

and this time from flush_bg_queue() instead of fuse_simple_request().

From the log, the last piece of code is:

ftruncate(fd=186, length=4)

which is a test file on virtiofs:

[main]  testfile fd:186 filename:trinity-testfile3 flags:2 fopened:1 fcntl_flags:2000 global:1
[main]   start: 0x7f47c1199000 size:4KB  name: trinity-testfile3 global:1


[ 9863.468502] WARNING: CPU: 16 PID: 286083 at fs/fuse/virtio_fs.c:1152 virtio_fs_enqueue_req+0xd36/0xde0 [virtiofs]
[ 9863.474442] Modules linked in: dlci 8021q garp mrp bridge stp llc ieee802154_socket ieee802154 vsock_loopback vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vsock mpls_router vmw_vmci ip_tunnel as
[ 9863.474555]  ata_piix fuse serio_raw libata e1000 sunrpc dm_mirror dm_region_hash dm_log dm_mod
[ 9863.535805] CPU: 16 PID: 286083 Comm: trinity-c5 Kdump: loaded Not tainted 5.9.0-rc7-next-20201002+ #2
[ 9863.544368] Hardware name: Red Hat KVM, BIOS 1.14.0-1.module+el8.3.0+7638+07cf13d2 04/01/2014
[ 9863.550129] RIP: 0010:virtio_fs_enqueue_req+0xd36/0xde0 [virtiofs]
[ 9863.552998] Code: 60 09 23 d9 e9 44 fa ff ff e8 56 09 23 d9 e9 70 fa ff ff 48 89 cf 48 89 4c 24 08 e8 44 09 23 d9 48 8b 4c 24 08 e9 7c fa ff ff <0f> 0b 48 c7 c7 c0 85 60 c0 44 89 e1 44 89 fa 44 89 ee e8 e3 b7
[ 9863.561720] RSP: 0018:ffff888a696ef6f8 EFLAGS: 00010202
[ 9863.565420] RAX: 0000000000000000 RBX: ffff88892e030008 RCX: 0000000000000000
[ 9863.568735] RDX: 0000000000000005 RSI: 0000000000000000 RDI: ffff888a696ef8ac
[ 9863.572037] RBP: ffff888a49d03d30 R08: ffffed114d2ddf18 R09: ffff888a696ef8a0
[ 9863.575383] R10: ffff888a696ef8bf R11: ffffed114d2ddf17 R12: 0000000000000006
[ 9863.578668] R13: 0000000000000003 R14: 0000000000000002 R15: 0000000000000002
[ 9863.581971] FS:  00007f47c12f5740(0000) GS:ffff888a7f800000(0000) knlGS:0000000000000000
[ 9863.585752] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 9863.590232] CR2: 0000000000000000 CR3: 0000000a63570005 CR4: 0000000000770ee0
[ 9863.594698] DR0: 00007f6642e43000 DR1: 0000000000000000 DR2: 0000000000000000
[ 9863.598521] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
[ 9863.601861] PKRU: 55555540
[ 9863.603173] Call Trace:
[ 9863.604382]  ? virtio_fs_probe+0x13e0/0x13e0 [virtiofs]
[ 9863.606838]  ? is_bpf_text_address+0x21/0x30
[ 9863.608869]  ? kernel_text_address+0x125/0x140
[ 9863.610962]  ? __kernel_text_address+0xe/0x30
[ 9863.613117]  ? unwind_get_return_address+0x5f/0xa0
[ 9863.615427]  ? create_prof_cpu_mask+0x20/0x20
[ 9863.617435]  ? _raw_write_lock_irqsave+0xe0/0xe0
[ 9863.619627]  virtio_fs_wake_pending_and_unlock+0x1ea/0x610 [virtiofs]
[ 9863.622638]  ? queue_request_and_unlock+0x115/0x280 [fuse]
[ 9863.625224]  flush_bg_queue+0x24c/0x3e0 [fuse]
[ 9863.627325]  fuse_simple_background+0x3d7/0x6c0 [fuse]
[ 9863.629735]  fuse_send_writepage+0x173/0x420 [fuse]
[ 9863.632031]  fuse_flush_writepages+0x1fe/0x330 [fuse]
[ 9863.634463]  ? make_kgid+0x13/0x20
[ 9863.636064]  ? fuse_change_attributes_common+0x2de/0x940 [fuse]
[ 9863.638850]  fuse_do_setattr+0xe84/0x13c0 [fuse]
[ 9863.641024]  ? migrate_swap_stop+0x8d1/0x920
[ 9863.643041]  ? fuse_flush_times+0x390/0x390 [fuse]
[ 9863.645347]  ? avc_has_perm_noaudit+0x390/0x390
[ 9863.647465]  fuse_setattr+0x197/0x400 [fuse]
[ 9863.649466]  notify_change+0x744/0xda0
[ 9863.651247]  ? __down_timeout+0x2a0/0x2a0
[ 9863.653125]  ? do_truncate+0xe2/0x180
[ 9863.654854]  do_truncate+0xe2/0x180
[ 9863.656509]  ? __x64_sys_openat2+0x1c0/0x1c0
[ 9863.658512]  ? alarm_setitimer+0xa0/0x110
[ 9863.660418]  do_sys_ftruncate+0x1ee/0x2c0
[ 9863.662311]  do_syscall_64+0x33/0x40
[ 9863.663980]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 9863.666384] RIP: 0033:0x7f47c0c0878d
[ 9863.668061] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d cb 56 2c 00 f7 d8 64 89 08
[ 9863.676717] RSP: 002b:00007fff515c2598 EFLAGS: 00000246 ORIG_RAX: 000000000000004d
[ 9863.680226] RAX: ffffffffffffffda RBX: 000000000000004d RCX: 00007f47c0c0878d
[ 9863.688055] RDX: 0000000000800000 RSI: 0000000000000004 RDI: 00000000000000ba
[ 9863.693672] RBP: 000000000000004d R08: 000000000000003a R09: 0000000000000001
[ 9863.699423] R10: 0000000000000005 R11: 0000000000000246 R12: 0000000000000002
[ 9863.708897] R13: 00007f47c12cb058 R14: 00007f47c12f56c0 R15: 00007f47c12cb000
[ 9863.713106] CPU: 16 PID: 286083 Comm: trinity-c5 Kdump: loaded Not tainted 5.9.0-rc7-next-20201002+ #2
[ 9863.717465] Hardware name: Red Hat KVM, BIOS 1.14.0-1.module+el8.3.0+7638+07cf13d2 04/01/2014
[ 9863.721389] Call Trace:
[ 9863.722547]  dump_stack+0x7c/0xa2
[ 9863.724110]  __warn.cold.13+0xe/0x47
[ 9863.725804]  ? virtio_fs_enqueue_req+0xd36/0xde0 [virtiofs]
[ 9863.728427]  report_bug+0x1af/0x260
[ 9863.730054]  handle_bug+0x44/0x80
[ 9863.731652]  exc_invalid_op+0x13/0x40
[ 9863.734911]  asm_exc_invalid_op+0x12/0x20
[ 9863.736940] RIP: 0010:virtio_fs_enqueue_req+0xd36/0xde0 [virtiofs]
[ 9863.739833] Code: 60 09 23 d9 e9 44 fa ff ff e8 56 09 23 d9 e9 70 fa ff ff 48 89 cf 48 89 4c 24 08 e8 44 09 23 d9 48 8b 4c 24 08 e9 7c fa ff ff <0f> 0b 48 c7 c7 c0 85 60 c0 44 89 e1 44 89 fa 44 89 ee e8 e3 b7
[ 9863.748519] RSP: 0018:ffff888a696ef6f8 EFLAGS: 00010202
[ 9863.750935] RAX: 0000000000000000 RBX: ffff88892e030008 RCX: 0000000000000000
[ 9863.754247] RDX: 0000000000000005 RSI: 0000000000000000 RDI: ffff888a696ef8ac
[ 9863.760885] RBP: ffff888a49d03d30 R08: ffffed114d2ddf18 R09: ffff888a696ef8a0
[ 9863.764814] R10: ffff888a696ef8bf R11: ffffed114d2ddf17 R12: 0000000000000006
[ 9863.768148] R13: 0000000000000003 R14: 0000000000000002 R15: 0000000000000002
[ 9863.771492]  ? virtio_fs_probe+0x13e0/0x13e0 [virtiofs]
[ 9863.773950]  ? is_bpf_text_address+0x21/0x30
[ 9863.775979]  ? kernel_text_address+0x125/0x140
[ 9863.778061]  ? __kernel_text_address+0xe/0x30
[ 9863.780124]  ? unwind_get_return_address+0x5f/0xa0
[ 9863.782395]  ? create_prof_cpu_mask+0x20/0x20
[ 9863.784451]  ? _raw_write_lock_irqsave+0xe0/0xe0
[ 9863.786602]  virtio_fs_wake_pending_and_unlock+0x1ea/0x610 [virtiofs]
[ 9863.789614]  ? queue_request_and_unlock+0x115/0x280 [fuse]
[ 9863.792178]  flush_bg_queue+0x24c/0x3e0 [fuse]
[ 9863.796678]  fuse_simple_background+0x3d7/0x6c0 [fuse]
[ 9863.802329]  fuse_send_writepage+0x173/0x420 [fuse]
[ 9863.808342]  fuse_flush_writepages+0x1fe/0x330 [fuse]
[ 9863.812086]  ? make_kgid+0x13/0x20
[ 9863.813681]  ? fuse_change_attributes_common+0x2de/0x940 [fuse]
[ 9863.816465]  fuse_do_setattr+0xe84/0x13c0 [fuse]
[ 9863.819633]  ? migrate_swap_stop+0x8d1/0x920
[ 9863.824285]  ? fuse_flush_times+0x390/0x390 [fuse]
[ 9863.827331]  ? avc_has_perm_noaudit+0x390/0x390
[ 9863.875278]  fuse_setattr+0x197/0x400 [fuse]
[ 9863.878496]  notify_change+0x744/0xda0
[ 9863.880640]  ? __down_timeout+0x2a0/0x2a0
[ 9863.882960]  ? do_truncate+0xe2/0x180
[ 9863.886311]  do_truncate+0xe2/0x180
[ 9863.888392]  ? __x64_sys_openat2+0x1c0/0x1c0
[ 9863.890418]  ? alarm_setitimer+0xa0/0x110
[ 9863.894430]  do_sys_ftruncate+0x1ee/0x2c0
[ 9863.896468]  do_syscall_64+0x33/0x40
[ 9863.898167]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 9863.901089] RIP: 0033:0x7f47c0c0878d
[ 9863.903447] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d cb 56 2c 00 f7 d8 64 89 08
[ 9863.914356] RSP: 002b:00007fff515c2598 EFLAGS: 00000246 ORIG_RAX: 000000000000004d
[ 9863.917998] RAX: ffffffffffffffda RBX: 000000000000004d RCX: 00007f47c0c0878d
[ 9863.921364] RDX: 0000000000800000 RSI: 0000000000000004 RDI: 00000000000000ba
[ 9863.928285] RBP: 000000000000004d R08: 000000000000003a R09: 0000000000000001
[ 9863.932523] R10: 0000000000000005 R11: 0000000000000246 R12: 0000000000000002
[ 9863.935835] R13: 00007f47c12cb058 R14: 00007f47c12f56c0 R15: 00007f47c12cb000
[ 9863.939183] ---[ end trace f6f5d958c186bcee ]---

