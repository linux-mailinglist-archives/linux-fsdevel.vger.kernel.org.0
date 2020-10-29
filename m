Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E2B29EF09
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 16:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbgJ2PCj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 11:02:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22591 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727808AbgJ2PCj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 11:02:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603983722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/9e6OJ104EyuiP4vqnHLBjXHNefHOCJGK8lzKsbwE9I=;
        b=DuxplTHqKgvgW/V449Kmi9EZ4ky8HTiX2eVbU/9GKLfNwbJ6mbFfeYYShHNvBUClYbGOca
        sy4icmw6agTRG8z60m9m6xVT3sukrSCXSmKDwK8V/oou/LJI7LWGYDjZQZNav7e/DO1Baq
        DcwE4mR1ZrxtJwSSDUMfc/xSWibLfNE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-y-vbxRTOMIS5_Yccc_aLYA-1; Thu, 29 Oct 2020 11:01:58 -0400
X-MC-Unique: y-vbxRTOMIS5_Yccc_aLYA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D685804B60;
        Thu, 29 Oct 2020 15:01:53 +0000 (UTC)
Received: from ovpn-66-212.rdu2.redhat.com (ovpn-66-212.rdu2.redhat.com [10.10.66.212])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 48B7670C24;
        Thu, 29 Oct 2020 15:01:23 +0000 (UTC)
Message-ID: <89f0dbf6713ebd44ec519425e3a947e71f7aed55.camel@redhat.com>
Subject: Re: WARN_ON(fuse_insert_writeback(root, wpa)) in tree_insert()
From:   Qian Cai <cai@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com
Date:   Thu, 29 Oct 2020 11:01:22 -0400
In-Reply-To: <c4cb4b41655bc890b9dbf40bd2c133cbcbef734d.camel@redhat.com>
References: <c4cb4b41655bc890b9dbf40bd2c133cbcbef734d.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2020-10-07 at 16:08 -0400, Qian Cai wrote:
> Running some fuzzing by a unprivileged user on virtiofs could trigger the
> warning below. The warning was introduced not long ago by the commit
> c146024ec44c ("fuse: fix warning in tree_insert() and clean up writepage
> insertion").
> 
> From the logs, the last piece of the fuzzing code is:
> 
> fgetxattr(fd=426, name=0x7f39a69af000, value=0x7f39a8abf000, size=1)

I can still reproduce it on today's linux-next. Any idea on how to debug it
further?

The last syscall to trigger this time is:

ftruncate(fd=410, length=4)

[main]  testfile fd:410 filename:trinity-testfile1 flags:2 fopened:1 fcntl_flags:42400 global:1
[main]   start: 0x7fadab1eb000 size:4KB  name: trinity-testfile1 global:1

[ 3353.774694][T124459] WARNING: CPU: 45 PID: 124459 at fs/fuse/file.c:1742 tree_insert.part.39+0x0/0x10 [fuse]
[ 3353.777295][T124459] Modules linked in: isofs kvm_intel kvm irqbypass nls_ascii nls_cp437 vfat fat ip_tables x_tables virtiofs fuse sr_mod sd_mod cdrom ata_piix virtio_pci virtio_ring e1000 libata virtio dm_d
[ 3353.783690][T124459] CPU: 45 PID: 124459 Comm: trinity-c45 Not tainted 5.10.0-rc1-next-20201029+ #3
[ 3353.786200][T124459] Hardware name: Red Hat KVM, BIOS 1.14.0-1.module+el8.3.0+7638+07cf13d2 04/01/2014
[ 3353.788746][T124459] RIP: 0010:tree_insert.part.39+0x0/0x10 [fuse]
[ 3353.790847][T124459] Code: fd b7 d7 48 8b 0c 24 e9 ec fb ff ff 0f 1f 40 00 66 2e 0f 1f 84 00 00 00 00 00 0f 0b c3 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00 <0f> 0b c3 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00 48 b0
[ 3353.796025][T124459] RSP: 0018:ffffc90008b4f828 EFLAGS: 00010286
[ 3353.797628][T124459] RAX: ffff88818875cd00 RBX: ffff888261d9a100 RCX: ffff8882051023d0
[ 3353.799752][T124459] RDX: 0000000000000000 RSI: ffff888261d9a100 RDI: ffff88818875cdb0
[ 3353.803681][T124459] RBP: ffffea000a835300 R08: ffff888261d9a1f8 R09: fffff52001169ef8
[ 3353.807019][T124459] R10: 0000000000000003 R11: fffff52001169ef8 R12: ffff888205101f40
[ 3353.810694][T124459] R13: ffffea0007d812c0 R14: ffff8881b48b1000 R15: ffff888205102470
[ 3353.813877][T124459] FS:  00007fadae016740(0000) GS:ffff888bcd140000(0000) knlGS:0000000000000000
[ 3353.817613][T124459] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3353.819366][T124459] CR2: 00000000000000e6 CR3: 0000000125140004 CR4: 0000000000170ee0
[ 3353.822295][T124459] Call Trace:
[ 3353.823242][T124459]  fuse_writepage_locked+0xa43/0xd40 [fuse]
[ 3353.824930][T124459]  fuse_launder_page+0x5b/0xc0 [fuse]
[ 3353.826466][T124459]  invalidate_inode_pages2_range+0x709/0xa90
[ 3353.828231][T124459]  ? unmap_mapping_pages+0x91/0x230
[ 3353.829703][T124459]  ? truncate_exceptional_pvec_entries.part.18+0x460/0x460
[ 3353.832203][T124459]  ? unmap_mapping_pages+0xbd/0x230
[ 3353.833657][T124459]  ? virtio_fs_wake_pending_and_unlock+0x1eb/0x610 [virtiofs]
[ 3353.835757][T124459]  ? lock_downgrade+0x700/0x700
[ 3353.837184][T124459]  ? down_write+0xdb/0x150
[ 3353.838484][T124459]  ? unmap_mapping_pages+0xbd/0x230
[ 3353.840278][T124459]  ? do_wp_page+0xc50/0xc50
[ 3353.841603][T124459]  fuse_do_setattr+0xd9c/0x13f0 [fuse]
[ 3353.843155][T124459]  ? print_usage_bug+0x1a0/0x1a0
[ 3353.844527][T124459]  ? fuse_flush_times+0x3d0/0x3d0 [fuse]
[ 3353.846129][T124459]  ? mark_held_locks+0xb0/0x110
[ 3353.847471][T124459]  fuse_setattr+0x1ff/0x4b0 [fuse]
[ 3353.848901][T124459]  notify_change+0x6ca/0xc30
[ 3353.850663][T124459]  ? down_write_killable_nested+0x170/0x170
[ 3353.852334][T124459]  ? do_truncate+0xdd/0x180
[ 3353.853651][T124459]  do_truncate+0xdd/0x180
[ 3353.854912][T124459]  ? do_sys_openat2+0x5b0/0x5b0
[ 3353.856339][T124459]  ? rcu_read_lock_any_held+0xcd/0xf0
[ 3353.857898][T124459]  ? __sb_start_write+0x229/0x2d0
[ 3353.859314][T124459]  do_sys_ftruncate+0x1f5/0x2c0
[ 3353.861148][T124459]  ? trace_hardirqs_on+0x1c/0x150
[ 3353.862529][T124459]  do_syscall_64+0x33/0x40
[ 3353.863801][T124459]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 3353.865413][T124459] RIP: 0033:0x7fadad92978d
[ 3353.866612][T124459] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d cb 56 2c 00 f7 d8
[ 3353.872380][T124459] RSP: 002b:00007fffabe83818 EFLAGS: 00000246 ORIG_RAX: 000000000000004d
[ 3353.874667][T124459] RAX: ffffffffffffffda RBX: 000000000000004d RCX: 00007fadad92978d
[ 3353.876842][T124459] RDX: fffffffffffffffd RSI: 0000000000000004 RDI: 000000000000019a
[ 3353.879053][T124459] RBP: 000000000000004d R08: 207124800010c410 R09: 00009a60a1048000
[ 3353.881679][T124459] R10: 00000000ffff0000 R11: 0000000000000246 R12: 0000000000000002
[ 3353.883872][T124459] R13: 00007fadaded4058 R14: 00007fadae0166c0 R15: 00007fadaded4000
[ 3353.886136][T124459] CPU: 45 PID: 124459 Comm: trinity-c45 Not tainted 5.10.0-rc1-next-20201029+ #3
[ 3353.888602][T124459] Hardware name: Red Hat KVM, BIOS 1.14.0-1.module+el8.3.0+7638+07cf13d2 04/01/2014
[ 3353.891506][T124459] Call Trace:
[ 3353.891653][T124459]  dump_stack+0x99/0xcb
[ 3353.891653][T124459]  __warn.cold.13+0xe/0x55
[ 3353.891653][T124459]  ? fuse_write_file_get.isra.34.part.35+0x10/0x10 [fuse]
[ 3353.891653][T124459]  report_bug+0x1af/0x260
[ 3353.891653][T124459]  handle_bug+0x44/0x80
[ 3353.891653][T124459]  exc_invalid_op+0x13/0x40
[ 3353.891653][T124459]  asm_exc_invalid_op+0x12/0x20
[ 3353.891653][T124459] RIP: 0010:tree_insert.part.39+0x0/0x10 [fuse]
[ 3353.891653][T124459] Code: fd b7 d7 48 8b 0c 24 e9 ec fb ff ff 0f 1f 40 00 66 2e 0f 1f 84 00 00 00 00 00 0f 0b c3 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00 <0f> 0b c3 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00 48 b0
[ 3353.891653][T124459] RSP: 0018:ffffc90008b4f828 EFLAGS: 00010286
[ 3353.891653][T124459] RAX: ffff88818875cd00 RBX: ffff888261d9a100 RCX: ffff8882051023d0
[ 3353.891653][T124459] RDX: 0000000000000000 RSI: ffff888261d9a100 RDI: ffff88818875cdb0
[ 3353.891653][T124459] RBP: ffffea000a835300 R08: ffff888261d9a1f8 R09: fffff52001169ef8
[ 3353.891653][T124459] R10: 0000000000000003 R11: fffff52001169ef8 R12: ffff888205101f40
[ 3353.891653][T124459] R13: ffffea0007d812c0 R14: ffff8881b48b1000 R15: ffff888205102470
[ 3353.891653][T124459]  fuse_writepage_locked+0xa43/0xd40 [fuse]
[ 3353.891653][T124459]  fuse_launder_page+0x5b/0xc0 [fuse]
[ 3353.891653][T124459]  invalidate_inode_pages2_range+0x709/0xa90
[ 3353.891653][T124459]  ? unmap_mapping_pages+0x91/0x230
[ 3353.891653][T124459]  ? truncate_exceptional_pvec_entries.part.18+0x460/0x460
[ 3353.891653][T124459]  ? unmap_mapping_pages+0xbd/0x230
[ 3353.891653][T124459]  ? virtio_fs_wake_pending_and_unlock+0x1eb/0x610 [virtiofs]
[ 3353.891653][T124459]  ? lock_downgrade+0x700/0x700
[ 3353.891653][T124459]  ? down_write+0xdb/0x150
[ 3353.891653][T124459]  ? unmap_mapping_pages+0xbd/0x230
[ 3353.891653][T124459]  ? do_wp_page+0xc50/0xc50
[ 3353.891653][T124459]  fuse_do_setattr+0xd9c/0x13f0 [fuse]
[ 3353.891653][T124459]  ? print_usage_bug+0x1a0/0x1a0
[ 3353.891653][T124459]  ? fuse_flush_times+0x3d0/0x3d0 [fuse]
[ 3353.891653][T124459]  ? mark_held_locks+0xb0/0x110
[ 3353.891653][T124459]  fuse_setattr+0x1ff/0x4b0 [fuse]
[ 3353.891653][T124459]  notify_change+0x6ca/0xc30
[ 3353.891653][T124459]  ? down_write_killable_nested+0x170/0x170
[ 3353.891653][T124459]  ? do_truncate+0xdd/0x180
[ 3353.891653][T124459]  do_truncate+0xdd/0x180
[ 3353.891653][T124459]  ? do_sys_openat2+0x5b0/0x5b0
[ 3353.891653][T124459]  ? rcu_read_lock_any_held+0xcd/0xf0
[ 3353.891653][T124459]  ? __sb_start_write+0x229/0x2d0
[ 3353.891653][T124459]  do_sys_ftruncate+0x1f5/0x2c0
[ 3353.891653][T124459]  ? trace_hardirqs_on+0x1c/0x150
[ 3353.891653][T124459]  do_syscall_64+0x33/0x40
[ 3353.891653][T124459]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 3353.891653][T124459] RIP: 0033:0x7fadad92978d
[ 3353.891653][T124459] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d cb 56 2c 00 f7 d8
[ 3353.891653][T124459] RSP: 002b:00007fffabe83818 EFLAGS: 00000246 ORIG_RAX: 000000000000004d
[ 3353.891653][T124459] RAX: ffffffffffffffda RBX: 000000000000004d RCX: 00007fadad92978d
[ 3353.891653][T124459] RDX: fffffffffffffffd RSI: 0000000000000004 RDI: 000000000000019a
[ 3353.891653][T124459] RBP: 000000000000004d R08: 207124800010c410 R09: 00009a60a1048000
[ 3353.891653][T124459] R10: 00000000ffff0000 R11: 0000000000000246 R12: 0000000000000002
[ 3353.891653][T124459] R13: 00007fadaded4058 R14: 00007fadae0166c0 R15: 00007fadaded4000
[ 3353.982969][T124459] irq event stamp: 192225
[ 3353.984184][T124459] hardirqs last  enabled at (192233): [<ffffffff97c2cf2f>] console_unlock+0x81f/0xa20
[ 3353.986913][T124459] hardirqs last disabled at (192240): [<ffffffff97c2ce3b>] console_unlock+0x72b/0xa20
[ 3353.989561][T124459] softirqs last  enabled at (191878): [<ffffffff9900061b>] __do_softirq+0x61b/0x95d
[ 3353.992558][T124459] softirqs last disabled at (191873): [<ffffffff98e00ec2>] asm_call_irq_on_stack+0x12/0x20
[ 3353.995337][T124459] ---[ end trace c2dc55cf6d30e0a3 ]---

