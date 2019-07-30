Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26B997A171
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2019 08:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbfG3Gte (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jul 2019 02:49:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39830 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729169AbfG3Gtd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jul 2019 02:49:33 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 36B2D81F18;
        Tue, 30 Jul 2019 06:49:33 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C05B60BF7;
        Tue, 30 Jul 2019 06:49:33 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 1E83041F40;
        Tue, 30 Jul 2019 06:49:33 +0000 (UTC)
Date:   Tue, 30 Jul 2019 02:49:33 -0400 (EDT)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     Murphy Zhou <jencce.kernel@gmail.com>
Cc:     linux-nvdimm@lists.01.org, snitzer@redhat.com,
        dan j williams <dan.j.williams@intel.com>,
        linux-fsdevel@vger.kernel.org
Message-ID: <2011806368.5335560.1564469373050.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190730061626.zwfottkdmab7vj3n@XZHOUW.usersys.redhat.com>
References: <20190730061626.zwfottkdmab7vj3n@XZHOUW.usersys.redhat.com>
Subject: Re: [regression] panic at __dax_synchronous after synchronous dax
 enabled
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.116.177, 10.4.195.8]
Thread-Topic: panic at __dax_synchronous after synchronous dax enabled
Thread-Index: TTUQugcB2bzCc8K4LyySy0OhvFU+jg==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 30 Jul 2019 06:49:33 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hi Murphy Zhou,

Thanks for the report.

> Hi,
> 
> Hit this panic when running xfstests generic/108 on pmem ramdisk.
> 
> This test is simulating partial disk error when calling fsync():
>   create a lvm vg which consists of 2 disks:
>     one scsi_debug disk; one other disk I specified, pmem ramdisk in this
>     case.
>   create lv in this vg and write to it, make sure writing across 2 disks;
>   offline scsi_debug disk;
>   write again to allocated area;
>   expect fsync: IO error.
> 
> If one of the disks is pmem ramdisk, it reproduces every time on my setup,
> on v5.3-rc2+.
> 
> The mount -o dax option is not required to reproduce this panic.

o.k I am looking into this. At first glance it looks like NULL de-reference
for non-DAX case. Will reproduce and post a fix.

Thanks,
Pankaj

> 
> Bisect points to this:
> 
> 	commit 2e9ee0955d3c2d3db56aa02ba6f948ba35d5e9c1
> 	Author: Pankaj Gupta <pagupta@redhat.com>
> 	Date:   Fri Jul 5 19:33:25 2019 +0530
> 	
> 	    dm: enable synchronous dax
> 
> Reverting this commit "fixes" this panic. I can send a revert patch if
> needed..
> 
> Thanks,
> M
> 
> FSTYP         -- xfs (debug)
> PLATFORM      -- Linux/x86_64 7u 5.3.0-rc2-master-2a11c76+ #155 SMP Tue Jul
> 30 11:29:05 CST 2019
> MKFS_OPTIONS  -- -f -f -b size=4096 /dev/pmem1
> MOUNT_OPTIONS -- -o dax -o context=system_u:object_r:root_t:s0 /dev/pmem1
> /test1
> 
> generic/108 5s ...      [00:17:34]
> 
> [ 1984.878208] BUG: kernel NULL pointer dereference, address:
> 00000000000002d0
> [ 1984.882546] #PF: supervisor read access in kernel mode
> [ 1984.885664] #PF: error_code(0x0000) - not-present page
> [ 1984.888626] PGD 0 P4D 0
> [ 1984.890140] Oops: 0000 [#1] SMP PTI
> [ 1984.892345] CPU: 17 PID: 3321 Comm: lvm Not tainted
> 5.3.0-rc2-master-2a11c76+ #155
> [ 1984.896864] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
> [ 1984.900460] RIP: 0010:__dax_synchronous+0x5/0x20
> [ 1984.903161] Code: ff ff ff c3 90 66 66 66 66 90 48 8b 87 d0 02 00 00 48 d1
> e8 83 e0 01 c3 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00 66 66 66 66 90 <48> 8b
> 87 d0 02 00 00 48 c1 e8 02 83 e0 01 c3 66 90 66 2e 0f 1f 84
> [ 1984.912987] RSP: 0018:ffffad06503a7b38 EFLAGS: 00010246
> [ 1984.915722] RAX: ffff9a248c7c2200 RBX: 0000000000000000 RCX:
> 0000000000046000
> [ 1984.919417] RDX: 0000000000000800 RSI: ffff9a2493486d18 RDI:
> 0000000000000000
> [ 1984.923182] RBP: ffff9a248c7c2200 R08: 0000000000000000 R09:
> 0000000000000000
> [ 1984.926644] R10: 0000000000000003 R11: ffffad06503a7a28 R12:
> ffffad0640109040
> [ 1984.930214] R13: 0000000000000000 R14: ffffffffc03d3ed0 R15:
> 0000000000000000
> [ 1984.933648] FS:  00007f4dbf87d880(0000) GS:ffff9a2498640000(0000)
> knlGS:0000000000000000
> [ 1984.937494] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1984.940273] CR2: 00000000000002d0 CR3: 000000046be80000 CR4:
> 00000000000006e0
> [ 1984.943682] Call Trace:
> [ 1984.945007]  device_synchronous+0xe/0x20 [dm_mod]
> [ 1984.947328]  stripe_iterate_devices+0x48/0x60 [dm_mod]
> [ 1984.949947]  ? dm_set_device_limits+0x130/0x130 [dm_mod]
> [ 1984.952516]  dm_table_supports_dax+0x39/0x90 [dm_mod]
> [ 1984.954989]  dm_table_set_restrictions+0x248/0x5d0 [dm_mod]
> [ 1984.957685]  dm_setup_md_queue+0x66/0x110 [dm_mod]
> [ 1984.960280]  table_load+0x1e3/0x390 [dm_mod]
> [ 1984.962491]  ? retrieve_status+0x1c0/0x1c0 [dm_mod]
> [ 1984.964910]  ctl_ioctl+0x1d3/0x550 [dm_mod]
> [ 1984.967006]  ? path_lookupat+0xf4/0x200
> [ 1984.968890]  dm_ctl_ioctl+0xa/0x10 [dm_mod]
> [ 1984.970920]  do_vfs_ioctl+0xa9/0x630
> [ 1984.972701]  ksys_ioctl+0x60/0x90
> [ 1984.974335]  __x64_sys_ioctl+0x16/0x20
> [ 1984.976221]  do_syscall_64+0x5b/0x1d0
> [ 1984.978091]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [ 1984.980552] RIP: 0033:0x7f4dbe49f2f7
> [ 1984.982304] Code: 44 00 00 48 8b 05 79 1b 2d 00 64 c7 00 26 00 00 00 48 c7
> c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 8b 0d 49 1b 2d 00 f7 d8 64 89 01 48
> [ 1984.991519] RSP: 002b:00007ffd2b70d578 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000010
> [ 1984.995203] RAX: ffffffffffffffda RBX: 00005612727d5680 RCX:
> 00007f4dbe49f2f7
> [ 1984.998685] RDX: 000056127483c860 RSI: 00000000c138fd09 RDI:
> 0000000000000004
> [ 1985.002145] RBP: 00007f4dbec07503 R08: 00007f4dbec08040 R09:
> 00007ffd2b70d4a0
> [ 1985.005667] R10: 0000000000000003 R11: 0000000000000246 R12:
> 000056127483c860
> [ 1985.009147] R13: 00007f4dbec07503 R14: 000056127481a700 R15:
> 00007f4dbec07503
> [ 1985.012670] Modules linked in: scsi_debug sunrpc snd_hda_codec_generic
> ledtrig_audio snd_hda_intel snd_hda_codec snd_hda_core snd_hwdep
> crct10dif_pclmul crc32_pclmul snd_seq ghash_clmulni_intel snd_seq_device
> snd_pcm snd_timer aesni_intel snd dax_pmem_compat crypto_simd device_dax
> cryptd soundcore sg glue_helper dax_pmem_core pcspkr virtio_balloon joydev
> i2c_piix4 ip_tables xfs libcrc32c qxl drm_kms_helper syscopyarea sysfillrect
> sysimgblt sd_mod fb_sys_fops ttm ata_generic pata_acpi drm virtio_console
> ata_piix 8139too libata virtio_pci crc32c_intel 8139cp nd_pmem serio_raw
> virtio_ring virtio floppy mii dm_mirror dm_region_hash dm_log dm_mod
> [ 1985.040136] CR2: 00000000000002d0
> [ 1985.042038] ---[ end trace db9a39c3773bb6fd ]---
> [ 1985.044378] RIP: 0010:__dax_synchronous+0x5/0x20
> [ 1985.046697] Code: ff ff ff c3 90 66 66 66 66 90 48 8b 87 d0 02 00 00 48 d1
> e8 83 e0 01 c3 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00 66 66 66 66 90 <48> 8b
> 87 d0 02 00 00 48 c1 e8 02 83 e0 01 c3 66 90 66 2e 0f 1f 84
> [ 1985.055931] RSP: 0018:ffffad06503a7b38 EFLAGS: 00010246
> [ 1985.058525] RAX: ffff9a248c7c2200 RBX: 0000000000000000 RCX:
> 0000000000046000
> [ 1985.062065] RDX: 0000000000000800 RSI: ffff9a2493486d18 RDI:
> 0000000000000000
> [ 1985.065441] RBP: ffff9a248c7c2200 R08: 0000000000000000 R09:
> 0000000000000000
> [ 1985.068699] R10: 0000000000000003 R11: ffffad06503a7a28 R12:
> ffffad0640109040
> [ 1985.071930] R13: 0000000000000000 R14: ffffffffc03d3ed0 R15:
> 0000000000000000
> [ 1985.075169] FS:  00007f4dbf87d880(0000) GS:ffff9a2498640000(0000)
> knlGS:0000000000000000
> [ 1985.078966] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1985.081619] CR2: 00000000000002d0 CR3: 000000046be80000 CR4:
> 00000000000006e0
> [ 1985.084802] Kernel panic - not syncing: Fatal exception
> [ 1985.156962] Kernel Offset: 0x3c00000 from 0xffffffff81000000 (relocation
> range: 0xffffffff80000000-0xffffffffbfffffff)
> [ 1985.161249] ---[ end Kernel panic - not syncing: Fatal exception ]---
> 
> 
> bisect log:
> 
> git bisect start
> # bad: [f8c3500cd137867927bc080f4a6e02e0222dd1b8] Merge tag
> 'libnvdimm-for-5.3' of
> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
> git bisect bad f8c3500cd137867927bc080f4a6e02e0222dd1b8
> # good: [2ae048e16636afd7521270acacb08d9c42fd23f0] Merge tag
> 'sound-fix-5.3-rc1' of
> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
> git bisect good 2ae048e16636afd7521270acacb08d9c42fd23f0
> # good: [913b187d12962fe8d9fa93c959f2f71ac16597ec] watchdog:
> stmp3xxx_rtc_wdt: drop warning after registering device
> git bisect good 913b187d12962fe8d9fa93c959f2f71ac16597ec
> # good: [4d1c6a0ec2d98e51f950127bf9299531caac53e1] watchdog: introduce
> watchdog.open_timeout commandline parameter
> git bisect good 4d1c6a0ec2d98e51f950127bf9299531caac53e1
> # good: [7fb832ae72949c883da52d6316ff08f03c75d300] watchdog: digicolor_wdt:
> Remove unused variable in dc_wdt_probe
> git bisect good 7fb832ae72949c883da52d6316ff08f03c75d300
> # bad: [2e9ee0955d3c2d3db56aa02ba6f948ba35d5e9c1] dm: enable synchronous dax
> git bisect bad 2e9ee0955d3c2d3db56aa02ba6f948ba35d5e9c1
> # good: [c5d4355d10d414a96ca870b731756b89d068d57a] libnvdimm: nd_region flush
> callback support
> git bisect good c5d4355d10d414a96ca870b731756b89d068d57a
> # good: [fefc1d97fa4b5e016bbe15447dc3edcd9e1bcb9f] libnvdimm: add dax_dev
> sync flag
> git bisect good fefc1d97fa4b5e016bbe15447dc3edcd9e1bcb9f
> # first bad commit: [2e9ee0955d3c2d3db56aa02ba6f948ba35d5e9c1] dm: enable
> synchronous dax
> 
