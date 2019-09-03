Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D373A6007
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 06:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbfICEVl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 00:21:41 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44985 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfICEVl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 00:21:41 -0400
Received: by mail-qk1-f193.google.com with SMTP id i78so12984604qke.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Sep 2019 21:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=ZVg+P2zV7pg7m061PnmoqGZhuqG0GJFjK6EdbQLpX8Y=;
        b=JqOamm02TGCfqcygJSwS8hMYAFLwa8k5UObevoPH7mVdz7XziBeOvge+f84WBM9HO1
         DGw2N+pytQGhsbCV4eONkY7yNYeSUicjVWsTK5rdD6CT6HQ9fIraW7yc4IbyIoLIImrU
         h4KlBAucFXGDQL9uDpjnncDs9tdlEi1/5Gpq9rXhdSYG8i9M2MBmR5N0qYZM0dmZXPVc
         myxuTtqQFOqJWAUn79Fflbrsj8vJfBLFvdfRu9LQFQDZToxym6sZUWDiUM4XHLbeXUTo
         F2fEYyM6KyNmCawcZKfKr+Ii3FY5xo3Udy69Lx5TDuL87KejkbC6FRug7LD5l5oKD+q5
         qTFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=ZVg+P2zV7pg7m061PnmoqGZhuqG0GJFjK6EdbQLpX8Y=;
        b=HdftkxaZlrHTG+Ibnl/FWFJaRoBf634l3ZTwC6OAEqCS/Z8CGABiFLPhi3N/lstJw7
         PT6lYI8kglelsUUOCxLuCjeOQZ+Gc4qRDzPeKE6MOWczMFumYk/d4NSg0p2T2WoiD60w
         WeH9Kp1jCX4UwZuy2vv5PXKEKhvYyMbeNU5NGFgMNs/ixcF5Pw7RhmyAiM5Qn2dPx5F4
         0xEHUY0ToFj5gghLXFNxKHM39HjF7SPzGo4koiO5rvcBPxFuoWQP6x/k86cGA8Lnn/PL
         njv/KiiiyZnffIUD7acylnH3unw6RjzJRA9uLZcSS+Go7vHMd1x29mQTc04nBgM1S2KT
         3M3Q==
X-Gm-Message-State: APjAAAX/1FFELayK7wOep5ufO8bqQRZgiNKQlL+fgVRUgfAa9m83L2tO
        OR2ETo3fZSKip+gMRBQnotGYHvI4X1cvYA==
X-Google-Smtp-Source: APXvYqxcu34OQUlz/HzwxebcynCuxFPIllj0cUupXGZppugP/5RS+LGUfkUofOBXIf5nlX4AsQHIEg==
X-Received: by 2002:a05:620a:1661:: with SMTP id d1mr18224280qko.189.1567484498807;
        Mon, 02 Sep 2019 21:21:38 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id g19sm6712238qtb.2.2019.09.02.21.21.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Sep 2019 21:21:38 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: "fs/namei.c: keep track of nd->root refcount status" causes boot
 panic
Message-Id: <7C6CCE98-1E22-433C-BF70-A3CBCDED4635@lca.pw>
Date:   Tue, 3 Sep 2019 00:21:36 -0400
Cc:     linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The linux-next commit "fs/namei.c: keep track of nd->root refcount =
status=E2=80=9D [1] causes boot panic on all
architectures here on today=E2=80=99s linux-next (0902). Reverted it =
will fix the issue.

[1] =
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit=
/?id=3De013ec23b8231cf7f95605cbb0e47aa0e3d047a4

All config are here: https://github.com/cailca/linux-mm

[  104.088693][    T1] Run /init as init process
[  104.155068][    T1] =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  104.163000][    T1] BUG: KASAN: invalid-access in dput+0x94/0x8d0
[  104.169095][    T1] Read of size 4 at addr aaaaaaaaaaaaaaaa by task =
systemd/1
[  104.176227][    T1]=20
[  104.178416][    T1] CPU: 166 PID: 1 Comm: systemd Not tainted =
5.3.0-rc6-next-20190902 #2
[  104.186504][    T1] Hardware name: HPE Apollo 70             =
/C01_APACHE_MB         , BIOS L50_5.13_1.11 06/18/2019
[  104.196935][    T1] Call trace:
[  104.200091][    T1]  dump_backtrace+0x0/0x264
[  104.204447][    T1]  show_stack+0x20/0x2c
[  104.208460][    T1]  dump_stack+0xb0/0x104
[  104.212558][    T1]  __kasan_report+0x1fc/0x294
[  104.217088][    T1]  kasan_report+0x10/0x18
[  104.221271][    T1]  __hwasan_load4_noabort+0x84/0x8c
[  104.226320][    T1]  dput+0x94/0x8d0
[  104.229902][    T1]  path_put+0x24/0x40
[  104.233739][    T1]  terminate_walk+0x98/0x124
[  104.238182][    T1]  path_lookupat+0x1a8/0x3f8
[  104.242624][    T1]  filename_lookup+0x84/0x128
[  104.247154][    T1]  user_path_at_empty+0x54/0x68
[  104.251869][    T1]  __arm64_sys_name_to_handle_at+0xd4/0x63c
[  104.257625][    T1]  el0_svc_handler+0x16c/0x234
[  104.262240][    T1]  el0_svc+0x8/0xc
[  104.265814][    T1] =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  104.273726][    T1] Disabling lock debugging due to kernel taint
[  104.279758][    T1] Unable to handle kernel paging request at virtual =
address aaaaaaaaaaaaaaaa
[  104.288378][    T1] Mem abort info:
[  104.291861][    T1]   ESR =3D 0x96000004
[  104.295619][    T1]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[  104.301619][    T1]   SET =3D 0, FnV =3D 0
[  104.305375][    T1]   EA =3D 0, S1PTW =3D 0
[  104.309203][    T1] Data abort info:
[  104.312773][    T1]   ISV =3D 0, ISS =3D 0x00000004
[  104.317310][    T1]   CM =3D 0, WnR =3D 0
[  104.320968][    T1] [aaaaaaaaaaaaaaaa] address between user and =
kernel address ranges
[  104.328806][    T1] Internal error: Oops: 96000004 [#1] SMP
[  104.334375][    T1] Modules linked in:
[  104.338127][    T1] CPU: 166 PID: 1 Comm: systemd Tainted: G    B     =
        5.3.0-rc6-next-20190902 #2
[  104.347601][    T1] Hardware name: HPE Apollo 70             =
/C01_APACHE_MB         , BIOS L50_5.13_1.11 06/18/2019
[  104.358033][    T1] pstate: 60400009 (nZCv daif +PAN -UAO)
[  104.363514][    T1] pc : dput+0x94/0x8d0
[  104.367433][    T1] lr : dput+0x94/0x8d0
[  104.371349][    T1] sp : 29ff008b8054fb40
[  104.375353][    T1] x29: 29ff008b8054fba0 x28: faff008b8052a0c0=20
[  104.381357][    T1] x27: 0000000000080040 x26: 0000000000080060=20
[  104.387361][    T1] x25: 0000000000000001 x24: faff008b8052a0c0=20
[  104.393365][    T1] x23: 0000000000000001 x22: ffff9000129e5cb8=20
[  104.399368][    T1] x21: ffff900010f4cb4a x20: faff008b8052a0d8=20
[  104.405371][    T1] x19: aaaaaaaaaaaaaaaa x18: 0000000000000000=20
[  104.411374][    T1] x17: 0000000000000000 x16: 0000000000000000=20
[  104.417377][    T1] x15: 0000000000000000 x14: 4c20534f4942202c=20
[  104.423380][    T1] x13: 2020202020202020 x12: ffffffffffffffff=20
[  104.429383][    T1] x11: 00000000000000fa x10: ffff8008b8052a0e=20
[  104.435387][    T1] x9 : 828cac3cb2455600 x8 : 828cac3cb2455600=20
[  104.441389][    T1] x7 : 0000000000000000 x6 : ffff9000101dcf08=20
[  104.447392][    T1] x5 : 0000000000000000 x4 : 0000000000000080=20
[  104.453395][    T1] x3 : ffff9000101d0e8c x2 : 0000000000000001=20
[  104.459398][    T1] x1 : 0000000000000001 x0 : faff008b8052a0d8=20
[  104.465402][    T1] Call trace:
[  104.468541][    T1]  dput+0x94/0x8d0
[  104.472112][    T1]  path_put+0x24/0x40
[  104.475945][    T1]  terminate_walk+0x98/0x124
[  104.480385][    T1]  path_lookupat+0x1a8/0x3f8
[  104.484826][    T1]  filename_lookup+0x84/0x128
[  104.489353][    T1]  user_path_at_empty+0x54/0x68
[  104.494055][    T1]  __arm64_sys_name_to_handle_at+0xd4/0x63c
[  104.499798][    T1]  el0_svc_handler+0x16c/0x234
[  104.504411][    T1]  el0_svc+0x8/0xc
[  104.507989][    T1] Code: aa1603e0 9400202a aa1303e0 97fdfb5c =
(39400268)=20
[  104.515005][    T1] ---[ end trace 8f0e764e24e4db67 ]---
[  104.520314][    T1] Kernel panic - not syncing: Fatal exception
[  104.526386][    T1] SMP: stopping secondary CPUs
[  104.531154][    T1] Kernel Offset: disabled
[  104.535334][    T1] CPU features: 0x0002,20000c18
[  104.540032][    T1] Memory Limit: none
[  104.543936][    T1] ---[ end Kernel panic - not syncing: Fatal =
exception ]=E2=80=94



[   18.850684][    T1] Run /init as init process
[   18.865679][    T1] Kernel attempted to access user page =
(7ffffb9da7e8) - exploit attempt? (uid: 0)
[   18.865702][    T1] BUG: Unable to handle kernel data access at =
0x7ffffb9da7e8
[   18.865714][    T1] Faulting instruction address: 0xc000000000472f98
[   18.865734][    T1] Oops: Kernel access of bad area, sig: 11 [#1]
[   18.865744][    T1] LE PAGE_SIZE=3D64K MMU=3DRadix MMU=3DHash SMP =
NR_CPUS=3D256 DEBUG_PAGEALLOC NUMA PowerNV
[   18.865766][    T1] Modules linked in:
[   18.865786][    T1] CPU: 12 PID: 1 Comm: systemd Not tainted =
5.3.0-rc6-next-20190902 #1
[   18.865808][    T1] NIP:  c000000000472f98 LR: c000000000472f94 CTR: =
0000000000000000
[   18.865828][    T1] REGS: c000200009d4f8c0 TRAP: 0300   Not tainted  =
(5.3.0-rc6-next-20190902)
[   18.865848][    T1] MSR:  9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE>  =
CR: 24044842  XER: 00000000
[   18.865874][    T1] CFAR: c00000000019c340 DAR: 00007ffffb9da7e8 =
DSISR: 08000000 IRQMASK: 0=20
[   18.865874][    T1] GPR00: c000000000472f94 c000200009d4fb50 =
c000000001055f00 0000000000000000=20
[   18.865874][    T1] GPR04: c000000001388ad8 0000000000000000 =
00000000b1fde0fa ffffffff000002ca=20
[   18.865874][    T1] GPR08: 00000000b201b1b9 0000000000000000 =
0000000000000000 c00000002c128480=20
[   18.865874][    T1] GPR12: 0000000000004000 c000001fffff5a00 =
0000000000000000 0000000000000fb1=20
[   18.865874][    T1] GPR16: 00007ffffb9dffb1 000000012fbf8718 =
000000012fbf8728 000000012fbf8758=20
[   18.865874][    T1] GPR20: 000000012fbf8768 00007ffffb9da7e8 =
00007ffffb9da7d8 00007ffffb9da440=20
[   18.865874][    T1] GPR24: 0000000000080040 0000000000000001 =
c000000000472f4c c0000000009f5820=20
[   18.865874][    T1] GPR28: c000000000f2bbe8 0000000000080060 =
00007ffffb9da868 00007ffffb9da7e8=20
[   18.866054][    T1] NIP [c000000000472f98] dput.part.6+0xc8/0x4f0
[   18.866082][    T1] LR [c000000000472f94] dput.part.6+0xc4/0x4f0
[   18.866100][    T1] Call Trace:
[   18.866118][    T1] [c000200009d4fb50] [c000000000472f94] =
dput.part.6+0xc4/0x4f0 (unreliable)
[   18.866140][    T1] [c000200009d4fbc0] [c00000000045b17c] =
terminate_walk+0x17c/0x1c0
[   18.866152][    T1] [c000200009d4fc00] [c000000000462178] =
path_lookupat+0xf8/0x2a0
[   18.866163][    T1] [c000200009d4fc70] [c000000000464950] =
filename_lookup.part.12+0xa0/0x170
[   18.866185][    T1] [c000200009d4fda0] [c000000000509074] =
sys_name_to_handle_at+0xd4/0x300
[   18.866208][    T1] [c000200009d4fe20] [c00000000000b278] =
system_call+0x5c/0x68
[   18.866237][    T1] Instruction dump:
[   18.866253][    T1] 39290001 912a0000 39000000 7f49d378 7f83e378 =
38e00000 38c00002 38a00000=20
[   18.866276][    T1] 38800000 3bdf0080 4bd29249 60000000 <813f0000> =
7fc3f378 71290008 4082013c=20
[   18.866300][    T1] ---[ end trace de9d3874b1f53267 ]---
[   18.958525][    T1]=20
[   19.958606][    T1] Kernel panic - not syncing: Fatal exception



[   39.686666][    T1] UBSAN: Undefined behaviour in =
kernel/locking/lockdep_internals.h:224:2
[   39.725420][    T1] index 841678955 is out of range for type 'long =
unsigned int [8192]'
[   39.763094][    T1] CPU: 4 PID: 1 Comm: systemd Not tainted =
5.3.0-rc6-next-20190902 #1
[   39.800145][    T1] Hardware name: HP ProLiant XL420 Gen9/ProLiant =
XL420 Gen9, BIOS U19 12/27/2015
[   39.842199][    T1] Call Trace:
[   39.856929][    T1]  dump_stack+0x62/0x9a
[   39.875739][    T1]  ubsan_epilogue+0xd/0x3a
[   39.895416][    T1]  __ubsan_handle_out_of_bounds+0x70/0x80
[   39.921688][    T1]  __lock_acquire.isra.13+0x808/0x830
[   39.945869][    T1]  ? __lock_acquire.isra.13+0x430/0x830
[   39.971711][    T1]  lock_acquire+0x107/0x220
[   39.994163][    T1]  ? dput.part.7+0x1c5/0x500
[   40.016158][    T1]  ? dput.part.7+0x30/0x500
[   40.036582][    T1]  _raw_spin_lock+0x2f/0x40
[   40.057076][    T1]  ? dput.part.7+0x1c5/0x500
[   40.077507][    T1]  dput.part.7+0x1c5/0x500
[   40.097771][    T1]  ? path_get+0x35/0x40
[   40.116577][    T1]  dput+0xe/0x10
[   40.132493][    T1]  terminate_walk+0x1a4/0x1d0
[   40.153485][    T1]  path_lookupat+0x156/0x420
[   40.174134][    T1]  ? link_path_walk.part.6+0x870/0x870
[   40.199229][    T1]  ? create_object+0x4a2/0x540
[   40.220672][    T1]  ? lock_downgrade+0x390/0x390
[   40.242538][    T1]  ? do_raw_write_lock+0x118/0x1d0
[   40.265756][    T1]  ? do_raw_read_unlock+0x60/0x60
[   40.288700][    T1]  ? create_object+0x22a/0x540
[   40.310276][    T1]  filename_lookup.part.10+0x11b/0x1f0
[   40.335487][    T1]  ? do_renameat2+0x7e0/0x7e0
[   40.356858][    T1]  ? __virt_addr_valid+0xdd/0x170
[   40.379861][    T1]  ? __phys_addr_symbol+0x27/0x42
[   40.402344][    T1]  ? strncpy_from_user+0x100/0x280
[   40.425720][    T1]  ? getname_flags+0xa7/0x220
[   40.447134][    T1]  user_path_at_empty+0x3e/0x50
[   40.469048][    T1]  __x64_sys_name_to_handle_at+0x113/0x340
[   40.496646][    T1]  ? kmem_cache_free+0x128/0x430
[   40.520509][    T1]  ? vfs_dentry_acceptable+0x10/0x10
[   40.547313][    T1]  ? putname+0x6b/0x80
[   40.565905][    T1]  ? do_sys_open+0x172/0x2c0
[   40.586647][    T1]  ? _raw_spin_unlock_irq+0x27/0x40
[   40.610151][    T1]  ? task_work_run+0xa1/0x100
[   40.631407][    T1]  do_syscall_64+0xc7/0x646
[   40.651745][    T1]  ? syscall_return_slowpath+0x140/0x140
[   40.676512][    T1]  ? __do_page_fault+0x49f/0x630
[   40.698994][    T1]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   40.725719][    T1] RIP: 0033:0x7f681e45cf3e
[   40.745799][    T1] Code: 48 8b 0d 4d ff 2b 00 f7 d8 64 89 01 48 83 =
c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 2f 01 =
00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 1a ff 2b 00 f7 d8 64 =
89 01 48
[   40.837197][    T1] RSP: 002b:00007ffdc2968038 EFLAGS: 00000202 =
ORIG_RAX: 000000000000012f
[   40.875888][    T1] RAX: ffffffffffffffda RBX: 0000000000000080 RCX: =
00007f681e45cf3e
[   40.912761][    T1] RDX: 000055bdc6e995b0 RSI: 00007f681fc203d6 RDI: =
0000000000000004
[   40.949212][    T1] RBP: 000055bdc6e995b0 R08: 0000000000001000 R09: =
0000000000000003
[   40.985257][    T1] R10: 00007ffdc2968064 R11: 0000000000000202 R12: =
000055bdc6e994e1
[   41.024224][    T1] R13: 00007f681fc203d6 R14: 0000000000000004 R15: =
00007ffdc29680c8
[   41.063027][    T1] =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
[   41.105463][    T1] BUG: unable to handle page fault for address: =
ffff8885e379f7a0
[   41.143820][    T1] #PF: supervisor write access in kernel mode
[   41.171406][    T1] #PF: error_code(0x0002) - not-present page
[   41.199505][    T1] PGD 656801067 P4D 656801067 PUD 87dd34067 PMD =
87dc18067 PTE 800ffffa1c860060
[   41.240827][    T1] Oops: 0002 [#1] SMP DEBUG_PAGEALLOC KASAN PTI
[   41.270580][    T1] CPU: 4 PID: 1 Comm: systemd Not tainted =
5.3.0-rc6-next-20190902 #1
[   41.307810][    T1] Hardware name: HP ProLiant XL420 Gen9/ProLiant =
XL420 Gen9, BIOS U19 12/27/2015
[   41.350005][    T1] RIP: 0010:__lock_acquire.isra.13+0x94/0x830
[   41.377694][    T1] Code: 00 49 81 ec a0 b3 0b 88 48 b8 a3 8b 2e ba =
e8 a2 8b 2e 49 c1 fc 04 4c 0f af e0 4d 63 f4 49 81 fe ff 1f 00 00 0f 87 =
65 07 00 00 <65> 4a ff 04 f5 48 f4 01 00 49 8d 85 68 07 00 00 48 89 c7 =
48 89 45
[   41.469635][    T1] RSP: 0018:ffff8882059bf8c8 EFLAGS: 00010082
[   41.496954][    T1] RAX: ffff888486576040 RBX: 0000000000000000 RCX: =
ffffffff86758ea8
[   41.534066][    T1] RDX: 1ffffffff0f872d0 RSI: dffffc0000000000 RDI: =
ffffffff87c39680
[   41.572462][    T1] RBP: ffff8882059bf938 R08: fffffbfff0f872d1 R09: =
fffffbfff0f872d1
[   41.610885][    T1] R10: fffffbfff0f872d0 R11: ffffffff87c39683 R12: =
ffffff52322b006b
[   41.646423][    T1] R13: ffff888486576040 R14: 00000000322b006b R15: =
0000000000000000
[   41.683212][    T1] FS:  00007f682011f580(0000) =
GS:ffff888452200000(0000) knlGS:0000000000000000
[   41.724248][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   41.754393][    T1] CR2: ffff8885e379f7a0 CR3: 000000031d4f8002 CR4: =
00000000001606a0
[   41.791003][    T1] Call Trace:
[   41.805757][    T1]  ? __lock_acquire.isra.13+0x430/0x830
[   41.830925][    T1]  lock_acquire+0x107/0x220
[   41.851379][    T1]  ? dput.part.7+0x1c5/0x500
[   41.872014][    T1]  ? dput.part.7+0x30/0x500
[   41.893373][    T1]  _raw_spin_lock+0x2f/0x40
[   41.914209][    T1]  ? dput.part.7+0x1c5/0x500
[   41.935211][    T1]  dput.part.7+0x1c5/0x500
[   41.955220][    T1]  ? path_get+0x35/0x40
[   41.973805][    T1]  dput+0xe/0x10
[   41.989687][    T1]  terminate_walk+0x1a4/0x1d0
[   42.010467][    T1]  path_lookupat+0x156/0x420
[   42.031327][    T1]  ? link_path_walk.part.6+0x870/0x870
[   42.057145][    T1]  ? create_object+0x4a2/0x540
[   42.081409][    T1]  ? lock_downgrade+0x390/0x390
[   42.105227][    T1]  ? do_raw_write_lock+0x118/0x1d0
[   42.128399][    T1]  ? do_raw_read_unlock+0x60/0x60
[   42.151389][    T1]  ? create_object+0x22a/0x540
[   42.172907][    T1]  filename_lookup.part.10+0x11b/0x1f0
[   42.197856][    T1]  ? do_renameat2+0x7e0/0x7e0
[   42.218965][    T1]  ? __virt_addr_valid+0xdd/0x170
[   42.241783][    T1]  ? __phys_addr_symbol+0x27/0x42
[   42.264601][    T1]  ? strncpy_from_user+0x100/0x280
[   42.287801][    T1]  ? getname_flags+0xa7/0x220
[   42.309515][    T1]  user_path_at_empty+0x3e/0x50
[   42.331635][    T1]  __x64_sys_name_to_handle_at+0x113/0x340
[   42.358043][    T1]  ? kmem_cache_free+0x128/0x430
[   42.380461][    T1]  ? vfs_dentry_acceptable+0x10/0x10
[   42.404055][    T1]  ? putname+0x6b/0x80
[   42.421534][    T1]  ? do_sys_open+0x172/0x2c0
[   42.442060][    T1]  ? _raw_spin_unlock_irq+0x27/0x40
[   42.465673][    T1]  ? task_work_run+0xa1/0x100
[   42.486841][    T1]  do_syscall_64+0xc7/0x646
[   42.507390][    T1]  ? syscall_return_slowpath+0x140/0x140
[   42.533265][    T1]  ? __do_page_fault+0x49f/0x630
[   42.556144][    T1]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   42.584451][    T1] RIP: 0033:0x7f681e45cf3e
[   42.605521][    T1] Code: 48 8b 0d 4d ff 2b 00 f7 d8 64 89 01 48 83 =
c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 2f 01 =
00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 1a ff 2b 00 f7 d8 64 =
89 01 48
[   42.698743][    T1] RSP: 002b:00007ffdc2968038 EFLAGS: 00000202 =
ORIG_RAX: 000000000000012f
[   42.737341][    T1] RAX: ffffffffffffffda RBX: 0000000000000080 RCX: =
00007f681e45cf3e
[   42.774197][    T1] RDX: 000055bdc6e995b0 RSI: 00007f681fc203d6 RDI: =
0000000000000004
[   42.809605][    T1] RBP: 000055bdc6e995b0 R08: 0000000000001000 R09: =
0000000000000003
[   42.845762][    T1] R10: 00007ffdc2968064 R11: 0000000000000202 R12: =
000055bdc6e994e1
[   42.882437][    T1] R13: 00007f681fc203d6 R14: 0000000000000004 R15: =
00007ffdc29680c8
[   42.918931][    T1] Modules linked in:
[   42.935805][    T1] CR2: ffff8885e379f7a0
[   42.954388][    T1] ---[ end trace cb4b0fb03ef6dea9 ]---
[   42.979305][    T1] RIP: 0010:__lock_acquire.isra.13+0x94/0x830
[   43.006969][    T1] Code: 00 49 81 ec a0 b3 0b 88 48 b8 a3 8b 2e ba =
e8 a2 8b 2e 49 c1 fc 04 4c 0f af e0 4d 63 f4 49 81 fe ff 1f 00 00 0f 87 =
65 07 00 00 <65> 4a ff 04 f5 48 f4 01 00 49 8d 85 68 07 00 00 48 89 c7 =
48 89 45
[   43.100565][    T1] RSP: 0018:ffff8882059bf8c8 EFLAGS: 00010082
[   43.130310][    T1] RAX: ffff888486576040 RBX: 0000000000000000 RCX: =
ffffffff86758ea8
[   43.166789][    T1] RDX: 1ffffffff0f872d0 RSI: dffffc0000000000 RDI: =
ffffffff87c39680
[   43.203516][    T1] RBP: ffff8882059bf938 R08: fffffbfff0f872d1 R09: =
fffffbfff0f872d1
[   43.240056][    T1] R10: fffffbfff0f872d0 R11: ffffffff87c39683 R12: =
ffffff52322b006b
[   43.276539][    T1] R13: ffff888486576040 R14: 00000000322b006b R15: =
0000000000000000
[   43.313154][    T1] FS:  00007f682011f580(0000) =
GS:ffff888452200000(0000) knlGS:0000000000000000
[   43.353925][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   43.383756][    T1] CR2: ffff8885e379f7a0 CR3: 000000031d4f8002 CR4: =
00000000001606a0
[   43.420258][    T1] Kernel panic - not syncing: Fatal exception
[   43.448058][    T1] Kernel Offset: 0x5600000 from 0xffffffff81000000 =
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[   43.501291][    T1] ---[ end Kernel panic - not syncing: Fatal =
exception ]---

