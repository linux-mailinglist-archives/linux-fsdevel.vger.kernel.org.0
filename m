Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA054191BAB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Mar 2020 22:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbgCXVGH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Mar 2020 17:06:07 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:37046 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbgCXVGH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Mar 2020 17:06:07 -0400
Received: by mail-qv1-f67.google.com with SMTP id n1so10020134qvz.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2020 14:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=/c9GjjF0zmvvlKt4LOew29tm2vrwk6MoN3MTdLLWPZ8=;
        b=RzxRNCBh69i/Dqig1pTAe1oq5O5LmcqMOrytP6afFqTRMAqvCOukOIX3/S6zgalvTu
         hSKTv5mbcWIPK0UEoopsmhraFPQAXLuUJ626YcEZZkl0hMbztudYSjESqCU7mAjNHkQb
         CWBmDydrNz+mqR5Mnt8Yma9WgVR3ezcfsLzPbtCKIT1FQOHz8FXPVATjdWOUjg0tH1f5
         5H4wqqiCMYOKSJGzYdhQooNQ5F4u6XKxhQkJzZwC6ruuLkcEFzrK9u8CE3FHjpfAgg9B
         w0xnXMp+FcZeIrJcR8kQ33nqA8IaaXUaZVvPYGcoXTRa6EClhtl7PxgcNdmqGK+YFf4P
         ewDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=/c9GjjF0zmvvlKt4LOew29tm2vrwk6MoN3MTdLLWPZ8=;
        b=kc7Bqg1OJZps1YB1lnQTvuRALZ31UcyjuB2C9Ko4zQVyR/1Cc8T5NE4SUgHS4VbtNU
         Xq6jDndmkbPsUjQG82MRh58QHDgEebTEfYlBQ4umzYDpcIo25deQ8iQuDh2BJ079XbrU
         DoBqUAc/RYCEYyQjWGi075WD9Nwh8SspOqHqsvX5+VOJvPeb6CAN7hqB6mBEdHKIU5wS
         4C7JnSMuphBvLWMetP2ms43wHhwtYn/F0uxNgNfKVXmqtG4UeRYJozJ8D0oSKUAheBxp
         uX20l7ACx2h0Sjj4oY8Vq+wvy3GtX3zv0luzLt3kSLEIinwoD8BZU7ZQgcVnyzRF5AI4
         3EBw==
X-Gm-Message-State: ANhLgQ10WBOw90CqHlHYr+jUe4Ve44N7svu5aUuxQIcG87nQxBl2DdO2
        bbrkYW8nB3/8DDsuOJ/fbSGmJg==
X-Google-Smtp-Source: ADFU+vs6MgcV9gapHtmN+14DTmztgRPYVnOgWLx2wREQ79zEfejCl9F1Ehvtbyh5o401Ux7HnOYK6g==
X-Received: by 2002:a0c:9104:: with SMTP id q4mr84293qvq.61.1585083964773;
        Tue, 24 Mar 2020 14:06:04 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id f19sm10744721qtq.78.2020.03.24.14.06.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Mar 2020 14:06:04 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Null-ptr-deref due to "sanitized pathwalk machinery (v4)"
Message-Id: <4CBDE0F3-FB73-43F3-8535-6C75BA004233@lca.pw>
Date:   Tue, 24 Mar 2020 17:06:03 -0400
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To:     Al Viro <viro@ZenIV.linux.org.uk>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Reverted the series on the top of today's linux-next fixed boot crashes.

# git revert 609c56723133..e0e25e9bbed5 --no-edit [1]

[   53.027443][ T3519] BUG: Kernel NULL pointer dereference on read at =
0x00000000
[   53.027480][ T3519] Faulting instruction address: 0xc0000000004dbfa4
[   53.027498][ T3519] Oops: Kernel access of bad area, sig: 11 [#1]
[   53.027521][ T3519] LE PAGE_SIZE=3D64K MMU=3DRadix SMP NR_CPUS=3D256 =
DEBUG_PAGEALLOC NUMA PowerNV
[   53.027538][ T3519] Modules linked in: kvm_hv kvm ip_tables x_tables =
xfs sd_mod bnx2x ahci libahci mdio libata tg3 libphy firmware_class =
dm_mirror dm_region_hash dm_log dm_mod
[   53.027594][ T3519] CPU: 36 PID: 3519 Comm: polkitd Not tainted =
5.6.0-rc7-next-20200324 #1
[   53.027618][ T3519] NIP:  c0000000004dbfa4 LR: c0000000004dc040 CTR: =
0000000000000000
[   53.027634][ T3519] REGS: c0002013879af810 TRAP: 0300   Not tainted  =
(5.6.0-rc7-next-20200324)
[   53.027668][ T3519] MSR:  9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE>  =
CR: 24004422  XER: 20040000
[   53.027708][ T3519] CFAR: c0000000004dc044 DAR: 0000000000000000 =
DSISR: 40000000 IRQMASK: 0=20
[   53.027708][ T3519] GPR00: c0000000004dc040 c0002013879afaa0 =
c00000000165a500 0000000000000000=20
[   53.027708][ T3519] GPR04: c000000001511408 0000000000000000 =
c0002013879af834 0000000000000002=20
[   53.027708][ T3519] GPR08: 0000000000000001 0000000000000000 =
0000000000000000 0000000000000001=20
[   53.027708][ T3519] GPR12: 0000000000004000 c000001ffffe1e00 =
0000000000000000 0000000000000000=20
[   53.027708][ T3519] GPR16: 0000000000000000 0000000000000001 =
0000000000000000 0000000000000000=20
[   53.027708][ T3519] GPR20: c000200ea1eacf38 c000201c8102f043 =
2f2f2f2f2f2f2f2f 0000000000000003=20
[   53.027708][ T3519] GPR24: 0000000000000000 c0002013879afbc8 =
fffffffffffff000 0000000000200000=20
[   53.027708][ T3519] GPR28: ffffffffffffffff 61c8864680b583eb =
0000000000000000 0000000000002e2e=20
[   53.027931][ T3519] NIP [c0000000004dbfa4] link_path_walk+0x284/0x4c0
__d_entry_type at include/linux/dcache.h:389
(inlined by) d_can_lookup at include/linux/dcache.h:404
(inlined by) link_path_walk at fs/namei.c:2178
[   53.027963][ T3519] LR [c0000000004dc040] link_path_walk+0x320/0x4c0
[   53.027993][ T3519] Call Trace:
[   53.028013][ T3519] [c0002013879afaa0] [c0000000004dc040] =
link_path_walk+0x320/0x4c0 (unreliable)
[   53.028050][ T3519] [c0002013879afb60] [c0000000004dc334] =
path_lookupat+0x94/0x1b0
[   53.028084][ T3519] [c0002013879afba0] [c0000000004ddf80] =
filename_lookup.part.55+0xa0/0x170
[   53.028101][ T3519] [c0002013879afce0] [c0000000004ca748] =
vfs_statx+0xa8/0x190
[   53.028117][ T3519] [c0002013879afd60] [c0000000004cacc0] =
__do_sys_newstat+0x40/0x90
[   53.028145][ T3519] [c0002013879afe20] [c00000000000b378] =
system_call+0x5c/0x68
[   53.028178][ T3519] Instruction dump:
[   53.028197][ T3519] 3bdeffff e9390058 38800000 7f23cb78 7fde07b4 =
1d5e0030 7d295214 eaa90020=20
[   53.028245][ T3519] 4bfffac5 2fa30000 409e00ac e9390008 <81290000> =
55290256 7f89d800 409e0160=20
[   53.028284][ T3519] ---[ end trace 0effae07d5cccfa0 ]=E2=80=94

[  705.047353][ T4874] BUG: KASAN: invalid-access in =
link_path_walk+0x374/0x53c
__d_entry_type at include/linux/dcache.h:389
(inlined by) d_can_lookup at include/linux/dcache.h:404
(inlined by) link_path_walk at fs/namei.c:2178
[  705.054422][ T4874] Read of size 4 at addr 0000000000000000 by task =
plymouthd/4874
[  705.062003][ T4874]=20
[  705.064213][ T4874] CPU: 16 PID: 4874 Comm: plymouthd Tainted: G      =
       L    5.6.0-rc7-next-20200324 #1
[  705.074055][ T4874] Hardware name: HPE Apollo 70             =
/C01_APACHE_MB         , BIOS L50_5.13_1.11 06/18/2019
[  705.084502][ T4874] Call trace:
[  705.087663][ T4874]  dump_backtrace+0x0/0x224
[  705.092036][ T4874]  show_stack+0x20/0x2c
[  705.096063][ T4874]  dump_stack+0xfc/0x184
[  705.100178][ T4874]  __kasan_report+0x178/0x238
[  705.104725][ T4874]  kasan_report+0x3c/0x58
[  705.108925][ T4874]  check_memory_region+0x98/0xa0
[  705.113734][ T4874]  __hwasan_load4_noabort+0x18/0x20
[  705.118801][ T4874]  link_path_walk+0x374/0x53c
[  705.123350][ T4874]  path_lookupat+0x78/0x1d4
[  705.127723][ T4874]  filename_lookup+0x80/0x124
[  705.132270][ T4874]  user_path_at_empty+0x54/0x68
[  705.136990][ T4874]  vfs_statx+0xcc/0x1b8
[  705.141016][ T4874]  __arm64_sys_newfstatat+0x94/0x120
[  705.146169][ T4874]  do_el0_svc+0x128/0x1dc
[  705.150369][ T4874]  el0_sync_handler+0xd0/0x268
[  705.155003][ T4874]  el0_sync+0x164/0x180
[  705.159028][ T4874] =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  705.166957][ T4874] Disabling lock debugging due to kernel taint
[  705.173067][ T4874] Unable to handle kernel NULL pointer dereference =
at virtual address 0000000000000000
[  705.182599][ T4874] Mem abort info:
[  705.186104][ T4874]   ESR =3D 0x96000005
[  705.189906][ T4874]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[  705.195928][ T4874]   SET =3D 0, FnV =3D 0
[  705.199727][ T4874]   EA =3D 0, S1PTW =3D 0
[  705.203578][ T4874] Data abort info:
[  705.207168][ T4874]   ISV =3D 0, ISS =3D 0x00000005
[  705.211749][ T4874]   CM =3D 0, WnR =3D 0
[  705.215431][ T4874] user pgtable: 64k pages, 48-bit VAs, =
pgdp=3D0000009659f42000
[  705.222702][ T4874] [0000000000000000] pgd=3D0000000000000000, =
pud=3D0000000000000000
[  705.230250][ T4874] Internal error: Oops: 96000005 [#1] SMP
[  705.235824][ T4874] Modules linked in: thunderx2_pmu processor =
efivarfs ip_tables xfs libcrc32c sd_mod ahci libahci mlx5_core libata =
dm_mirror dm_region_hash dm_log dm_mod
[  705.251173][ T4874] CPU: 16 PID: 4874 Comm: plymouthd Tainted: G    B =
       L    5.6.0-rc7-next-20200324 #1
[  705.260999][ T4874] Hardware name: HPE Apollo 70             =
/C01_APACHE_MB         , BIOS L50_5.13_1.11 06/18/2019
[  705.271438][ T4874] pstate: 60400009 (nZCv daif +PAN -UAO BTYPE=3D--)
[  705.277708][ T4874] pc : link_path_walk+0x374/0x53c
[  705.282587][ T4874] lr : link_path_walk+0x374/0x53c
[  705.287463][ T4874] sp : b1ff00916cdefa90
[  705.291473][ T4874] x29: b1ff00916cdefb30 x28: 9cff00098d5eb703=20
[  705.297485][ T4874] x27: 0000000000000000 x26: fefefefefefefeff=20
[  705.303496][ T4874] x25: 0000000236266748 x24: 2f2f2f2f2f2f2f2f=20
[  705.309507][ T4874] x23: b1ff00916cdefba0 x22: b1ff00916cdefbc8=20
[  705.315518][ T4874] x21: b1ff00916cdefbe0 x20: b1ff00916cdefbd0=20
[  705.321529][ T4874] x19: b1ff00916cdefb98 x18: 0000000000000000=20
[  705.327540][ T4874] x17: 0000000000000000 x16: 0000000000000000=20
[  705.333550][ T4874] x15: 0000000000000000 x14: 2020202020202020=20
[  705.339561][ T4874] x13: 20424d5f45484341 x12: 50415f3130432f20=20
[  705.345571][ T4874] x11: 0000000000000003 x10: ffff8008bb246a3e=20
[  705.351582][ T4874] x9 : 68bdf6118cf10200 x8 : 0000000000000000=20
[  705.357592][ T4874] x7 : aaaaaaaaaaaaaaaa x6 : 0000000000000000=20
[  705.363602][ T4874] x5 : 0000000000000080 x4 : 0000000000000000=20
[  705.369612][ T4874] x3 : ffff900010a5a394 x2 : 0000000000000001=20
[  705.375622][ T4874] x1 : 0000000000000004 x0 : 0000000000000000=20
[  705.381631][ T4874] Call trace:
[  705.384777][ T4874]  link_path_walk+0x374/0x53c
[  705.389311][ T4874]  path_lookupat+0x78/0x1d4
[  705.393670][ T4874]  filename_lookup+0x80/0x124
[  705.398204][ T4874]  user_path_at_empty+0x54/0x68
[  705.402909][ T4874]  vfs_statx+0xcc/0x1b8
[  705.406921][ T4874]  __arm64_sys_newfstatat+0x94/0x120
[  705.412060][ T4874]  do_el0_svc+0x128/0x1dc
[  705.416247][ T4874]  el0_sync_handler+0xd0/0x268
[  705.420865][ T4874]  el0_sync+0x164/0x180
[  705.424883][ T4874] Code: 97fe39bd f94002fb aa1b03e0 97fe39aa =
(b9400368)=20
[  705.432066][ T4874] ---[ end trace 71f0365c08ac491a ]---
[  705.437381][ T4874] Kernel panic - not syncing: Fatal exception
[  705.443608][ T4874] SMP: stopping secondary CPUs
[  705.448297][ T4874] Kernel Offset: disabled
[  705.452483][ T4874] CPU features: 0x006002,61000c38
[  705.457359][ T4874] Memory Limit: none
[  705.461411][ T4874] ---[ end Kernel panic - not syncing: Fatal =
exception ]=E2=80=94

[1]
e0e25e9bbed5 lookup_open(): don't bother with fallbacks to lookup+create
b686da54700f atomic_open(): no need to pass struct open_flags anymore
60e1d0b8512f open_last_lookups(): move complete_walk() into do_open()
4d7ed93ff9db open_last_lookups(): lift O_EXCL|O_CREAT handling into =
do_open()
57e9b028e9e7 open_last_lookups(): don't abuse complete_walk() when all =
we want is unlazy
c01d40b1c03c open_last_lookups(): consolidate fsnotify_create() calls
c8291f6b0037 take post-lookup part of do_last() out of loop
881386f7e46a link_path_walk(): sample parent's i_uid and i_mode for the =
last component
0e47dacb7f29 __nd_alloc_stack(): make it return bool
794dc2d56401 reserve_stack(): switch to __nd_alloc_stack()
59089811438c pick_link(): take reserving space on stack into a new =
helper
8c60edbc56a2 pick_link(): more straightforward handling of allocation =
failures
4efc770ddf45 fold path_to_nameidata() into its only remaining caller
dcc11116def1 pick_link(): pass it struct path already with normal =
refcounting rules
0058fcb4c3b5 fs/namei.c: kill follow_mount()
ffa2db4ac3e7 non-RCU analogue of the previous commit
8255cecd93ba helper for mount rootwards traversal
573f88cea0e2 follow_dotdot(): be lazy about changing nd->path
ea63a0dc31fd follow_dotdot_rcu(): be lazy about changing nd->path
5c19a79cd9d3 follow_dotdot{,_rcu}(): massage loops
5e3c3570ec97 lift all calls of step_into() out of =
follow_dotdot/follow_dotdot_rcu
6dfd9fe54dfd follow_dotdot{,_rcu}(): switch to use of step_into()
7521f22b3ce2 handle_dots(), follow_dotdot{,_rcu}(): preparation to =
switch to step_into()
957dd41d8842 move handle_dots(), follow_dotdot() and follow_dotdot_rcu() =
past step_into()
c9a0f75d81e3 follow_dotdot{,_rcu}(): lift LOOKUP_BENEATH checks out of =
loop
abc2c632e0ce follow_dotdot{,_rcu}(): lift switching nd->path to parent =
out of loop
a6a7eb7628cf expand path_parent_directory() in its callers
63b27720a476 path_parent_directory(): leave changing path->dentry to =
callers
6b03f7edf43e path_connected(): pass mount and dentry separately
c981a4828125 split the lookup-related parts of do_last() into a separate =
helper
973d4b73fbaf do_last(): rejoin the common path even earlier in =
FMODE_{OPENED,CREATED} case
8795e7d48288 do_last(): simplify the liveness analysis past =
finish_open_created
5a2d3edd8dad do_last(): rejoing the common path earlier in =
FMODE_{OPENED,CREATED} case
59e96e65833e do_last(): don't bother with keeping got_write in =
FMODE_OPENED case
3ad5615a071f do_last(): merge the may_open() calls
7be219b4dcd9 atomic_open(): lift the call of may_open() into do_last()
6fb968cdf9d0 atomic_open(): return the right dentry in FMODE_OPENED case
9deed3ebca24 new helper: traverse_mounts()
ea936aeb3ead massage __follow_mount_rcu() a bit
c108837e06b6 namei: have link_path_walk() maintain LOOKUP_PARENT
d8d4611a4f2d link_path_walk(): simplify stack handling
b1a819724074 pick_link(): check for WALK_TRAILING, not LOOKUP_PARENT
8c4efe22e7c4 namei: invert the meaning of WALK_FOLLOW
b4c0353693d2 sanitize handling of nd->last_type, kill LAST_BIND
ad6cc4c338f4 finally fold get_link() into pick_link()
06708adb99e8 merging pick_link() with get_link(), part 6
b0417d2c7298 merging pick_link() with get_link(), part 5
92d270165cff merging pick_link() with get_link(), part 4
40fcf5a931af merging pick_link() with get_link(), part 3
1ccac622f9da merging pick_link() with get_link(), part 2
43679723d27f merging pick_link() with get_link(), part 1
a9dc1494a782 expand the only remaining call of path_lookup_conditional()
161aff1d93ab LOOKUP_MOUNTPOINT: fold path_mountpointat() into =
path_lookupat()
cbae4d12eeee fold handle_mounts() into step_into()
aca2903eefd0 new step_into() flag: WALK_NOFOLLOW
56676ec39019 step_into() callers: dismiss the symlink earlier
20e343571cef lookup_fast(): take mount traversal into callers
c153007b7b7a teach handle_mounts() to handle RCU mode
b023e1728bec lookup_fast(): consolidate the RCU success case
db3c9ade50b1 handle_mounts(): pass dentry in, turn path into a pure out =
argument
e73cabff5917 do_last(): collapse the call of path_to_nameidata()
da5ebf5aa676 lookup_open(): saner calling conventions (return dentry on =
success)=
