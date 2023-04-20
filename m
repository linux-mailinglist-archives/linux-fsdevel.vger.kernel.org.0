Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A186E9776
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Apr 2023 16:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbjDTOpB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Apr 2023 10:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232955AbjDTOo4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Apr 2023 10:44:56 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CED420C;
        Thu, 20 Apr 2023 07:44:52 -0700 (PDT)
Received: from [192.168.2.142] (p4fdf4348.dip0.t-ipconnect.de [79.223.67.72])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: buczek)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 34C7461CC40F9;
        Thu, 20 Apr 2023 16:44:49 +0200 (CEST)
Message-ID: <3b589d44-3fbd-1f4f-8efb-9b334c26a20f@molgen.mpg.de>
Date:   Thu, 20 Apr 2023 16:44:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 03/11] documentation: Block Devices Snapshots Module
Content-Language: en-US
From:   Donald Buczek <buczek@molgen.mpg.de>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>, axboe@kernel.dk,
        hch@infradead.org, corbet@lwn.net, snitzer@kernel.org
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, willy@infradead.org,
        kch@nvidia.com, martin.petersen@oracle.com, vkoul@kernel.org,
        ming.lei@redhat.com, gregkh@linuxfoundation.org,
        linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20230404140835.25166-1-sergei.shtepa@veeam.com>
 <20230404140835.25166-4-sergei.shtepa@veeam.com>
 <cb0cc2f1-48cb-8b15-35af-33a31ccc922c@molgen.mpg.de>
 <86068780-bab3-2fc2-3f6f-1868be119b38@veeam.com>
 <a1854604-cec1-abd5-1d49-6cf6a19ee7a1@veeam.com>
 <1dc227d0-9528-9b77-63ff-b49b0579caa1@molgen.mpg.de>
 <c05fd3e7-5610-4f63-9012-df1b808d9536@veeam.com>
 <955ede49-bb69-2ab2-d256-a329fe1b728c@molgen.mpg.de>
In-Reply-To: <955ede49-bb69-2ab2-d256-a329fe1b728c@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/19/23 21:42, Donald Buczek wrote:
> Dear Sergei,
> 
> On 4/19/23 15:05, Sergei Shtepa wrote:
>> [...]
>>
>> Patches in attach and https://github.com/SergeiShtepa/linux/tree/blksnap-master
> 
> Thanks. I can confirm that this fixes the reported problem and I no longer can trigger the UAF. :-)
> 
> Tested-Bny: Donald Buczek <buczek@molgen.mpg.de>
> 
> Maybe you can add me to the cc list for v4 as I'm not subscribed to the lists.


Sorry, found another one. Reproducer:

=====
#! /bin/bash
set -xe
modprobe blksnap
test -e /scratch/local/test.dat || fallocate -l 1G /scratch/local/test.dat
s=$(blksnap snapshot_create -d /dev/vdb)
blksnap snapshot_appendstorage -i $s -f /scratch/local/test.dat
blksnap snapshot_take -i $s
s2=$(blksnap snapshot_create -d /dev/vdb)
blksnap snapshot_destroy -i $s2
blksnap snapshot_destroy -i $s
=====


[20382.402921] blksnap-snapshot: Snapshot ff1c54f1-3e8c-4c99-bb26-35e82dc1c9fa was created
[20382.535933] blksnap-image: Create snapshot image device for original device [253:16]
[20382.542405] blksnap-snapshot: Snapshot ff1c54f1-3e8c-4c99-bb26-35e82dc1c9fa was taken successfully
[20382.572564] blksnap-snapshot: Snapshot 4b2d571d-9a24-419d-96c2-8d64a07c4966 was created
[20382.600521] blksnap-snapshot: Destroy snapshot 4b2d571d-9a24-419d-96c2-8d64a07c4966
[20382.602373] blksnap-snapshot: Release snapshot 4b2d571d-9a24-419d-96c2-8d64a07c4966
[20382.722137] blksnap-snapshot: Destroy snapshot ff1c54f1-3e8c-4c99-bb26-35e82dc1c9fa
[20382.724033] blksnap-snapshot: Release snapshot ff1c54f1-3e8c-4c99-bb26-35e82dc1c9fa
[20382.725850] ==================================================================
[20382.727641] BUG: KASAN: wild-memory-access in snapshot_free+0x73/0x170 [blksnap]
[20382.729326] Write of size 8 at addr dead000000000108 by task blksnap/8297

[20382.731212] CPU: 4 PID: 8297 Comm: blksnap Not tainted 6.3.0-rc5.mx64.428-00094-g21dc08a94f59-dirty #41
[20382.733293] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.1-0-g3208b098f51a-prebuilt.qemu.org 04/01/2014
[20382.735807] Call Trace:
[20382.736395]  <TASK>
[20382.736900]  dump_stack_lvl+0x37/0x50
[20382.737767]  ? snapshot_free+0x73/0x170 [blksnap]
[20382.738873]  kasan_report+0xb2/0xe0
[20382.739690]  ? snapshot_free+0x73/0x170 [blksnap]
[20382.740799]  snapshot_free+0x73/0x170 [blksnap]
[20382.741868]  snapshot_destroy+0x119/0x170 [blksnap]
[20382.743009]  ioctl_snapshot_destroy+0x7a/0xc0 [blksnap]
[20382.744241]  ? __pfx_ioctl_snapshot_destroy+0x10/0x10 [blksnap]
[20382.745606]  ? __fget_light+0x1ca/0x200
[20382.746493]  ctrl_unlocked_ioctl+0x3a/0x60 [blksnap]
[20382.747654]  __x64_sys_ioctl+0xc6/0xe0
[20382.748528]  do_syscall_64+0x47/0xa0
[20382.749369]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[20382.750524] RIP: 0033:0x7f27fbf7f4db
[20382.751351] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <41> 89 c0 3d 00 f0 ff ff 77 1b 48 8b 44 24 18 64 48 2b 04 25 28 00
[20382.760773] RSP: 002b:00007ffcf157de50 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[20382.767031] RAX: ffffffffffffffda RBX: 00007ffcf157df00 RCX: 00007f27fbf7f4db
[20382.772597] RDX: 00007ffcf157dec0 RSI: 0000000080105602 RDI: 0000000000000003
[20382.777677] RBP: 00007ffcf157df60 R08: 00007ffcf157df30 R09: 0000000000000000
[20382.782318] R10: 00007f27fc18d8f0 R11: 0000000000000246 R12: 00007ffcf157e2f8
[20382.786617] R13: 00000000004079f6 R14: 00000000005653f8 R15: 00007f27fc19e040
[20382.790634]  </TASK>
[20382.794012] ==================================================================
[20382.797799] Disabling lock debugging due to kernel taint
[20382.801245] general protection fault, probably for non-canonical address 0xdead000000000108: 0000 [#1] PREEMPT SMP KASAN PTI
[20382.805060] CPU: 4 PID: 8297 Comm: blksnap Tainted: G    B              6.3.0-rc5.mx64.428-00094-g21dc08a94f59-dirty #41
[20382.808757] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.1-0-g3208b098f51a-prebuilt.qemu.org 04/01/2014
[20382.812441] RIP: 0010:snapshot_free+0x73/0x170 [blksnap]
[20382.815569] Code: 4d 8b 74 24 50 4c 89 f7 49 8d 6e f8 e8 56 a7 f3 e0 49 8b 1e 49 8d 7e 08 e8 4a a7 f3 e0 4d 8b 7e 08 48 8d 7b 08 e8 ed a7 f3 e0 <4c> 89 7b 08 4c 89 ff e8 e1 a7 f3 e0 49 89 1f 48 89 ef 48 b8 00 01
[20382.822394] RSP: 0018:ffff888120fafe18 EFLAGS: 00010292
[20382.825587] RAX: 0000000000000001 RBX: dead000000000100 RCX: ffffffff810cb82a
[20382.828866] RDX: fffffbfff0850d49 RSI: 0000000000000008 RDI: ffffffff84286a40
[20382.832142] RBP: ffff888105a4f400 R08: 0000000000000001 R09: ffffffff84286a47
[20382.835366] R10: fffffbfff0850d48 R11: 0000000000000001 R12: ffff888124ac9b10
[20382.838557] R13: ffff888124ac9b60 R14: ffff888105a4f408 R15: dead000000000122
[20382.841759] FS:  00007f27fbe7c780(0000) GS:ffff888261800000(0000) knlGS:0000000000000000
[20382.845049] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[20382.848186] CR2: 00007f27fbed0d00 CR3: 0000000104608004 CR4: 0000000000170ee0
[20382.851439] Call Trace:
[20382.854366]  <TASK>
[20382.857219]  snapshot_destroy+0x119/0x170 [blksnap]
[20382.860286]  ioctl_snapshot_destroy+0x7a/0xc0 [blksnap]
[20382.863356]  ? __pfx_ioctl_snapshot_destroy+0x10/0x10 [blksnap]
[20382.866471]  ? __fget_light+0x1ca/0x200
[20382.869377]  ctrl_unlocked_ioctl+0x3a/0x60 [blksnap]
[20382.872322]  __x64_sys_ioctl+0xc6/0xe0
[20382.875124]  do_syscall_64+0x47/0xa0
[20382.877921]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[20382.880831] RIP: 0033:0x7f27fbf7f4db
[20382.883628] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <41> 89 c0 3d 00 f0 ff ff 77 1b 48 8b 44 24 18 64 48 2b 04 25 28 00
[20382.890371] RSP: 002b:00007ffcf157de50 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[20382.893694] RAX: ffffffffffffffda RBX: 00007ffcf157df00 RCX: 00007f27fbf7f4db
[20382.897004] RDX: 00007ffcf157dec0 RSI: 0000000080105602 RDI: 0000000000000003
[20382.900301] RBP: 00007ffcf157df60 R08: 00007ffcf157df30 R09: 0000000000000000
[20382.903572] R10: 00007f27fc18d8f0 R11: 0000000000000246 R12: 00007ffcf157e2f8
[20382.906879] R13: 00000000004079f6 R14: 00000000005653f8 R15: 00007f27fc19e040
[20382.910171]  </TASK>
[20382.913069] Modules linked in: blksnap rpcsec_gss_krb5 nfsv4 nfs 8021q garp stp mrp llc kvm_intel bochs drm_vram_helper drm_ttm_helper virtio_net kvm ttm net_failover drm_kms_helper input_leds led_class irqbypass drm failover crc32c_intel syscopyarea sysfillrect i2c_piix4 intel_agp sysimgblt intel_gtt floppy nfsd auth_rpcgss oid_registry nfs_acl lockd grace sunrpc ip_tables x_tables unix ipv6 autofs4 [last unloaded: blksnap]
[20382.924858] ---[ end trace 0000000000000000 ]---
[20382.928229] RIP: 0010:snapshot_free+0x73/0x170 [blksnap]
[20382.931564] Code: 4d 8b 74 24 50 4c 89 f7 49 8d 6e f8 e8 56 a7 f3 e0 49 8b 1e 49 8d 7e 08 e8 4a a7 f3 e0 4d 8b 7e 08 48 8d 7b 08 e8 ed a7 f3 e0 <4c> 89 7b 08 4c 89 ff e8 e1 a7 f3 e0 49 89 1f 48 89 ef 48 b8 00 01
[20382.939104] RSP: 0018:ffff888120fafe18 EFLAGS: 00010292
[20382.942536] RAX: 0000000000000001 RBX: dead000000000100 RCX: ffffffff810cb82a
[20382.946224] RDX: fffffbfff0850d49 RSI: 0000000000000008 RDI: ffffffff84286a40
[20382.949927] RBP: ffff888105a4f400 R08: 0000000000000001 R09: ffffffff84286a47
[20382.953591] R10: fffffbfff0850d48 R11: 0000000000000001 R12: ffff888124ac9b10
[20382.957253] R13: ffff888124ac9b60 R14: ffff888105a4f408 R15: dead000000000122
[20382.960914] FS:  00007f27fbe7c780(0000) GS:ffff888261800000(0000) knlGS:0000000000000000
[20382.964666] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[20382.968148] CR2: 00007f27fbed0d00 CR3: 0000000104608004 CR4: 0000000000170ee0


Best
   Donald

-- 
Donald Buczek
buczek@molgen.mpg.de
Tel: +49 30 8413 1433
