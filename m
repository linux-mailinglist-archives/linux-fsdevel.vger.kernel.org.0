Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB0211DDCB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 06:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732048AbfLMFeo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Dec 2019 00:34:44 -0500
Received: from mga03.intel.com ([134.134.136.65]:27930 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbfLMFeo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Dec 2019 00:34:44 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 21:34:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,308,1571727600"; 
   d="scan'208";a="415533446"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga006.fm.intel.com with ESMTP; 12 Dec 2019 21:34:42 -0800
Date:   Thu, 12 Dec 2019 21:34:43 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: list_del corruption when running ndctl with linux next
Message-ID: <20191213053442.GB31115@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Running this on linux-next from 11 Dec on qemu:

$ ndctl create-namespace -e namespace0.0 -f --mode=fsdax

I got the splat.

localhost login: [   71.481606] ------------[ cut here ]------------
[   71.483365] list_del corruption. prev->next should be ffff88800f3ca250, but was ffff88802f5f9dd0
[   71.485096] WARNING: CPU: 1 PID: 1106 at lib/list_debug.c:51 __list_del_entry_valid+0xb3/0xd0
[   71.486533] Modules linked in: rfkill bochs_drm drm_vram_helper drm_ttm_helper ttm drm_kms_helper syscopyarea sysfillrect sysie
[   71.494002] CPU: 1 PID: 1106 Comm: ndctl Not tainted 5.5.0-rc1-next-20191211+ #80
[   71.495241] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-2.fc30 04/01/2014
[   71.496674] RIP: 0010:__list_del_entry_valid+0xb3/0xd0
[   71.497544] Code: 4c 89 e2 48 89 ee 48 c7 c7 40 45 bf 82 e8 cf 62 7f ff 0f 0b 31 c0 eb c6 4c 89 e2 48 89 ee 48 c7 c7 a0 45 bf f
[   71.500579] RSP: 0018:ffff88801b8f7aa8 EFLAGS: 00010286
[   71.501448] RAX: 0000000000000000 RBX: ffff8881bf4018c0 RCX: 0000000000000000
[   71.502595] RDX: 1ffff11076c17471 RSI: 0000000000000008 RDI: ffffed100371ef47
[   71.503756] RBP: ffff88800f3ca250 R08: 0000000000000001 R09: ffffed1076c18701
[   71.504925] R10: ffffed1076c18700 R11: ffff8883b60c3807 R12: ffff88802f5f9dd0
[   71.506088] R13: ffff88802f5f9dd0 R14: ffff88800f3ca220 R15: ffff88800f3ca1b8
[   71.507258] FS:  00007fa540afd600(0000) GS:ffff8883b6080000(0000) knlGS:0000000000000000
[   71.508572] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   71.509540] CR2: 00007fa540f4a160 CR3: 000000001bf5e000 CR4: 00000000000006e0
[   71.510694] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   71.511846] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   71.513001] Call Trace:
[   71.513474]  __dentry_kill+0xe3/0x250
[   71.514109]  ? dput+0x26/0x5c0
[   71.514664]  dput+0x331/0x5c0
[   71.515208]  debugfs_remove+0x40/0x60
[   71.515863]  bdi_unregister+0x263/0x310
[   71.516529]  ? bdi_get_by_id+0xa0/0xa0
[   71.517204]  del_gendisk+0x4bd/0x4d0
[   71.517823]  ? disk_events_poll_msecs_store+0x140/0x140
[   71.518705]  ? rwlock_bug.part.0+0x60/0x60
[   71.519442]  ? iput+0x6b/0x3e0
[   71.520001]  pmem_release_disk+0x54/0x70 [nd_pmem]
[   71.520828]  release_nodes+0x3eb/0x460
[   71.521488]  ? devres_remove_group+0x1a0/0x1a0
[   71.522250]  ? _raw_spin_lock_irqsave+0x45/0x50
[   71.523022]  device_release_driver_internal+0x146/0x260
[   71.523909]  unbind_store+0x12d/0x150
[   71.524553]  ? sysfs_file_ops+0xa0/0xa0
[   71.525207]  kernfs_fop_write+0x141/0x240
[   71.525901]  vfs_write+0xf2/0x250
[   71.526489]  ksys_write+0xc3/0x160
[   71.529996]  ? __ia32_sys_read+0x50/0x50
[   71.533420]  ? mark_held_locks+0x24/0x90
[   71.536826]  do_syscall_64+0x74/0xd0
[   71.540176]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[   71.543697] RIP: 0033:0x7fa540e2f008
[   71.546937] Code: 89 02 48 c7 c0 ff ff ff ff eb b3 0f 1f 80 00 00 00 00 f3 0f 1e fa 48 8d 05 15 66 0d 00 8b 00 85 c0 75 17 b8 5
[   71.555195] RSP: 002b:00007ffef2c6cd98 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[   71.559052] RAX: ffffffffffffffda RBX: 000055e71d44a670 RCX: 00007fa540e2f008
[   71.562794] RDX: 000000000000000d RSI: 000055e71d44a670 RDI: 0000000000000004
[   71.566466] RBP: 000000000000000d R08: 000055e71d44a630 R09: 00007fa540ebfe80
[   71.570077] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
[   71.573667] R13: 00007fa540afd528 R14: 0000000000000000 R15: 0000000000000000
[   71.577238] irq event stamp: 15416
[   71.580156] hardirqs last  enabled at (15415): [<ffffffff811aa4ed>] console_unlock+0x54d/0x6f0
[   71.583434] hardirqs last disabled at (15416): [<ffffffff810044c9>] trace_hardirqs_off_thunk+0x1a/0x1c
[   71.586723] softirqs last  enabled at (15412): [<ffffffff8240048e>] __do_softirq+0x48e/0x55c
[   71.589926] softirqs last disabled at (15357): [<ffffffff810f08fd>] irq_exit+0x15d/0x170
[   71.593007] ---[ end trace 509de64125a53950 ]---


I ran against 5.5rc2 and this did not happen...

Bisecting from 5.5 rc2 (good)

    ae4b064e2a61 Merge tag 'afs-fixes-20191211' of git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs

to linux next (bad)

    938f49c85b36 Add linux-next specific files for 20191211

Landed on:

17:05:30 > git bisect bad
653f0d05be0948e7610bb786e6570bb6c48a4e75 is the first bad commit
commit 653f0d05be0948e7610bb786e6570bb6c48a4e75
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Mon Nov 18 09:43:10 2019 -0500

    simple_recursive_removal(): kernel-side rm -rf for ramfs-style filesystems

    two requirements: no file creations in IS_DEADDIR and no cross-directory
    renames whatsoever.

    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

:040000 040000 6935d6016c3dd2baf3577078c5c1ab1ced013818 55b19d33965e4fa3a5ce8efd404631032e8963df M      fs
:040000 040000 09a8639751b250997ad4e6e92d28555db2680b06 95d538eaebf7296bc15d5d599313de64a2011347 M      include
:040000 040000 223319a4e2c3404e7bacae1e1eaab5ca205c1e80 0456294ec4aa4653e77968a9f975c21f3f6549dc M      kernel

After a quick look through the change I'm at a loss as to what the issue may be
or how this relates to the ndctl command I'm running.

Hopefully someone can help.

Ira

