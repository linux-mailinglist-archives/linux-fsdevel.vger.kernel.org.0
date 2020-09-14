Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D668268922
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Sep 2020 12:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgINKUG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Sep 2020 06:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgINKUA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Sep 2020 06:20:00 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D974EC06178A
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Sep 2020 03:19:59 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id y190so635520vsy.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Sep 2020 03:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=epXAGb4/UGv/CupliJWTGj9nje4eCgFNPuzBEEwgtfk=;
        b=uJf8LporzeYxnvA9xcvjFTqd5FnsgSNShWvMIUH1cW5bZYk37iq86d1hEfLpdSUWCK
         WIRTxjXePFgLH45HoKBR0S/bFUrmFIBglyS1HxyZDEobgO4c9VMw+9oL6QrUPw85RYBN
         jSoMQZKugBz5XWaZg1bhfU+ChB6DbUo3Yi7jaK1dSoDUihlGH6kemX9kdXZGWIERLd1H
         4Smwj1j5LrKzyDmKcwo6yraK/bofLuuUyfcECDwwOByv0G43VUCvI7V34RhfDmSyaRfE
         tLPg83IDb1evIPgyrBbqE8ApGgNVYdvM6AAfbCgtl4A8xSHSzMu2Xc3n7pyvULk4ZVSX
         qAaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=epXAGb4/UGv/CupliJWTGj9nje4eCgFNPuzBEEwgtfk=;
        b=fNeLwlsh18zIgkYcVrO45drT+i66S12Wyuh0gKzJhv3oYzhrY7q1L5Ok8HGAZu3dvE
         lDUjFpKW+xZtilT4lmfk0BaDAQ4h16hCnnE0t7JZwIFamzIaWnSj6uzfmop1VIENgZOK
         tMOj+ziFtxWM19Cvsbw8H1u75MWlJJj22iHnhL63/PYDw2oek0K8y9EidvYqafblQflx
         cK3jovEKiK42NPuu6SfU/fdO1QwCmd3eATzi0dRy/2uCQnOhNZcN/Utx06qUo3N839/H
         l384plqUVpx040N6FHPY+mFQvOxwFsZeg68aRsLYepnHmsTNEJadAnazk0J41KCjewk4
         qWvA==
X-Gm-Message-State: AOAM53253PmCgsvzVoJCXfhu3h6h2eLxWKrDJ6OcQrqs+JEx96gD2iFV
        8bJIMKvCcJRKOIv3mAZ6QGR87s+Fm+Cm5OXPyfrPzg==
X-Google-Smtp-Source: ABdhPJzRfcNnb7kmo8/tEi+a07g2CQPjogkf8IULcn8DXwwb3m0EFKozSCPSCWny1bvHESmS2RLbZpcWweCvB0dqMik=
X-Received: by 2002:a05:6102:10c2:: with SMTP id t2mr6594784vsr.10.1600078794822;
 Mon, 14 Sep 2020 03:19:54 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 14 Sep 2020 15:49:43 +0530
Message-ID: <CA+G9fYvmut-pJT-HsFRCxiEzOnkOjC8UcksX4v8jUvyLYeXTkQ@mail.gmail.com>
Subject: BUG: kernel NULL pointer dereference, address: RIP: 0010:shmem_getpage_gfp.isra.0+0x470/0x750
To:     open list <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc:     lkft-triage@lists.linaro.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        gandalf@winds.org, Qian Cai <cai@lca.pw>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>, Yang Shi <shy828301@gmail.com>,
        Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

While running LTP fs on qemu x86 and qemu_i386 these kernel BUGs noticed.

metadata:
  git branch: master
  git repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git commit: f965d3ec86fa89285db0fbb983da76ba9c398efa
  git describe: next-20200914
  make_kernelversion: 5.9.0-rc5
  kernel-config:
https://builds.tuxbuild.com/g15vEMQfzQXPX_7pG6QPpQ/kernel.config

Steps to reproduce:
   # boot qemu x86_64 with linux next 20200914 tag kernel
   # cd /opt/ltp
   # ./runltp -f fs

kernel BUG on x86_64,

[  528.439815] BUG: kernel NULL pointer dereference, address: 0000000000000020
[  528.440734] #PF: supervisor read access in kernel mode
[  528.440775] #PF: error_code(0x0000) - not-present page
[  528.440775] PGD 138d1a067 P4D 138d1a067 PUD 139eff067 PMD 0
[  528.440775] Oops: 0000 [#1] SMP NOPTI
[  528.440775] CPU: 3 PID: 723 Comm: growfiles Not tainted
5.9.0-rc5-next-20200914 #1
[  528.440775] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.12.0-1 04/01/2014
[  528.440775] RIP: 0010:shmem_getpage_gfp.isra.0+0x470/0x750
[  528.440775] Code: f6 0f 85 e6 fd ff ff e8 2e f3 fd ff 48 8b 7d c8
48 8b 47 08 48 8d 50 ff a8 01 48 0f 45 fa f0 ff 4f 34 0f 84 ff 01 00
00 31 ff <4c> 2b 67 20 48 8b 85 70 ff ff ff 45 31 c0 49 c1 e4 06 4c 01
e7 48
[  528.440775] RSP: 0018:ffffafb301097b70 EFLAGS: 00010246
[  528.440775] RAX: 0000000000000000 RBX: ffff934df9e5ce30 RCX: 0000000000000000
[  528.440775] RDX: 0000000000000039 RSI: ffff934de5c09240 RDI: 0000000000000000
[  528.440775] RBP: ffffafb301097c10 R08: 0000000000100cca R09: 0000000000000000
[  528.440775] R10: 0000000000000002 R11: 0000000000000001 R12: 0000000000000039
[  528.440775] R13: ffffafb301097c70 R14: 0000000000000000 R15: ffff934df9e5cfa8
[  528.440775] FS:  00007fe4cb7b8740(0000) GS:ffff934dfbd80000(0000)
knlGS:0000000000000000
[  528.440775] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  528.440775] CR2: 0000000000000020 CR3: 000000013363c000 CR4: 00000000003506e0
[  528.440775] Call Trace:
[  528.440775]  ? release_pages+0x2e6/0x350
[  528.440775]  shmem_undo_range+0x39b/0x7c0
[  528.440775]  shmem_truncate_range+0x14/0x40
[  528.440775]  shmem_setattr+0x265/0x2b0
[  528.440775]  notify_change+0x348/0x4c0
[  528.440775]  do_truncate+0x78/0xd0
[  528.440775]  ? do_truncate+0x78/0xd0
[  528.440775]  do_sys_ftruncate+0xf0/0x1a0
[  528.440775]  __x64_sys_ftruncate+0x1b/0x20
[  528.440775]  do_syscall_64+0x38/0x50
[  528.440775]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  528.440775] RIP: 0033:0x7fe4caeb0a17
[  528.440775] Code: 77 01 c3 48 8b 15 81 14 2c 00 f7 d8 64 89 02 b8
ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 b8 4d 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 51 14 2c 00 f7 d8 64 89
02 b8
[  528.440775] RSP: 002b:00007fff37fb9578 EFLAGS: 00000202 ORIG_RAX:
000000000000004d
[  528.440775] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fe4caeb0a17
[  528.440775] RDX: 00000000000397ad RSI: 00000000000399ad RDI: 0000000000000006
[  528.440775] RBP: 0000000000000006 R08: 00000005deece66d R09: 00007fe4caef6930
[  528.440775] R10: 6d20736574796220 R11: 0000000000000202 R12: 0000000000001000
[  528.440775] R13: 000000000004bcb7 R14: 00000000000399ad R15: 0000000000000042
[  528.440775] Modules linked in:
[  528.440775] CR2: 0000000000000020
[  528.440775] ---[ end trace a5ebcc25e2e2a58e ]---
[  528.440775] RIP: 0010:shmem_getpage_gfp.isra.0+0x470/0x750
[  528.440775] Code: f6 0f 85 e6 fd ff ff e8 2e f3 fd ff 48 8b 7d c8
48 8b 47 08 48 8d 50 ff a8 01 48 0f 45 fa f0 ff 4f 34 0f 84 ff 01 00
00 31 ff <4c> 2b 67 20 48 8b 85 70 ff ff ff 45 31 c0 49 c1 e4 06 4c 01
e7 48
[  528.440775] RSP: 0018:ffffafb301097b70 EFLAGS: 00010246
[  528.440775] RAX: 0000000000000000 RBX: ffff934df9e5ce30 RCX: 0000000000000000
[  528.440775] RDX: 0000000000000039 RSI: ffff934de5c09240 RDI: 0000000000000000
[  528.440775] RBP: ffffafb301097c10 R08: 0000000000100cca R09: 0000000000000000
[  528.440775] R10: 0000000000000002 R11: 0000000000000001 R12: 0000000000000039
[  528.440775] R13: ffffafb301097c70 R14: 0000000000000000 R15: ffff934df9e5cfa8
[  528.440775] FS:  00007fe4cb7b8740(0000) GS:ffff934dfbd80000(0000)
knlGS:0000000000000000
[  528.440775] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  528.440775] CR2: 0000000000000020 CR3: 000000013363c000 CR4: 00000000003506e0
gf21        1  TPASS  :  Test passed
gf22        1  TPASS  :  Test passed
[  528.520376] BUG: kernel NULL pointer dereference, address: 0000000000000020
[  528.520793] #PF: supervisor read access in kernel mode
[  528.520793] #PF: error_code(0x0000) - not-present page
[  528.520793] PGD 13365c067 P4D 13365c067 PUD 139768067 PMD 0
[  528.520793] Oops: 0000 [#2] SMP NOPTI
[  528.520793] CPU: 1 PID: 726 Comm: growfiles Tainted: G      D
    5.9.0-rc5-next-20200914 #1
[  528.520793] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.12.0-1 04/01/2014
[  528.520793] RIP: 0010:shmem_getpage_gfp.isra.0+0x470/0x750
[  528.520793] Code: f6 0f 85 e6 fd ff ff e8 2e f3 fd ff 48 8b 7d c8
48 8b 47 08 48 8d 50 ff a8 01 48 0f 45 fa f0 ff 4f 34 0f 84 ff 01 00
00 31 ff <4c> 2b 67 20 48 8b 85 70 ff ff ff 45 31 c0 49 c1 e4 06 4c 01
e7 48
[  528.520793] RSP: 0018:ffffafb30109fb70 EFLAGS: 00010246
[  528.520793] RAX: 0000000000000000 RBX: ffff934df8f453b0 RCX: 0000000000000000
[  528.520793] RDX: 0000000000000000 RSI: 0000000000000051 RDI: 0000000000000000
[  528.520793] RBP: ffffafb30109fc10 R08: 0000000000100cca R09: 0000000000000000
[  528.520793] R10: 0000000000000002 R11: 0000000000000001 R12: 0000000000000051
[  528.520793] R13: ffffafb30109fc70 R14: 0000000000000000 R15: ffff934df8f45528
[  528.520793] FS:  00007fb165faf740(0000) GS:ffff934dfbc80000(0000)
knlGS:0000000000000000
[  528.520793] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  528.520793] CR2: 0000000000000020 CR3: 000000013363c000 CR4: 00000000003506e0
[  528.520793] Call Trace:
[  528.520793]  ? release_pages+0x2e6/0x350
[  528.520793]  shmem_undo_range+0x39b/0x7c0
[  528.520793]  ? _cond_resched+0x19/0x30
[  528.520793]  ? find_lock_entry+0x30/0xa0
[  528.520793]  ? avc_has_perm+0xca/0x1f0
[  528.520793]  ? _cond_resched+0x19/0x30
[  528.520793]  ? down_write+0x13/0x50
[  528.520793]  ? unmap_mapping_pages+0x60/0x130
[  528.520793]  shmem_truncate_range+0x14/0x40
[  528.520793]  shmem_setattr+0x265/0x2b0
[  528.520793]  notify_change+0x348/0x4c0
[  528.520793]  do_truncate+0x78/0xd0
[  528.520793]  ? do_truncate+0x78/0xd0
[  528.520793]  do_sys_ftruncate+0xf0/0x1a0
[  528.520793]  __x64_sys_ftruncate+0x1b/0x20
[  528.520793]  do_syscall_64+0x38/0x50
[  528.520793]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  528.520793] RIP: 0033:0x7fb1656a7a17
[  528.520793] Code: 77 01 c3 48 8b 15 81 14 2c 00 f7 d8 64 89 02 b8
ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 b8 4d 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 51 14 2c 00 f7 d8 64 89
02 b8
[  528.520793] RSP: 002b:00007fff5da67b18 EFLAGS: 00000206 ORIG_RAX:
000000000000004d
[  528.520793] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fb1656a7a17
[  528.520793] RDX: 0000000000051745 RSI: 0000000000051746 RDI: 0000000000000006
[  528.520793] RBP: 0000000000000006 R08: 00000005deece66d R09: 00007fb1656ed930
[  528.520793] R10: 00000000000000bb R11: 0000000000000206 R12: 0000000000001000
[  528.520793] R13: 00000000000615d4 R14: 0000000000051746 R15: 0000000000000042
[  528.520793] Modules linked in:
[  528.520793] CR2: 0000000000000020
[  528.520793] ---[ end trace a5ebcc25e2e2a58f ]---
[  528.520793] RIP: 0010:shmem_getpage_gfp.isra.0+0x470/0x750
[  528.520793] Code: f6 0f 85 e6 fd ff ff e8 2e f3 fd ff 48 8b 7d c8
48 8b 47 08 48 8d 50 ff a8 01 48 0f 45 fa f0 ff 4f 34 0f 84 ff 01 00
00 31 ff <4c> 2b 67 20 48 8b 85 70 ff ff ff 45 31 c0 49 c1 e4 06 4c 01
e7 48
[  528.520793] RSP: 0018:ffffafb301097b70 EFLAGS: 00010246
[  528.520793] RAX: 0000000000000000 RBX: ffff934df9e5ce30 RCX: 0000000000000000
[  528.520793] RDX: 0000000000000039 RSI: ffff934de5c09240 RDI: 0000000000000000
[  528.520793] RBP: ffffafb301097c10 R08: 0000000000100cca R09: 0000000000000000
[  528.520793] R10: 0000000000000002 R11: 0000000000000001 R12: 0000000000000039
[  528.520793] R13: ffffafb301097c70 R14: 0000000000000000 R15: ffff934df9e5cfa8
[  528.520793] FS:  00007fb165faf740(0000) GS:ffff934dfbc80000(0000)
knlGS:0000000000000000
[  528.520793] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  528.520793] CR2: 0000000000000020 CR3: 000000013363c000 CR4: 00000000003506e0
gf24        1  TPASS  :  Test passed
[  528.625925] BUG: kernel NULL pointer dereference, address: 0000000000000020
[  528.626774] #PF: supervisor read access in kernel mode
[  528.626774] #PF: error_code(0x0000) - not-present page
[  528.626774] PGD 138d7b067 P4D 138d7b067 PUD 133421067 PMD 0
[  528.626774] Oops: 0000 [#3] SMP NOPTI
[  528.626774] CPU: 0 PID: 728 Comm: growfiles Tainted: G      D
    5.9.0-rc5-next-20200914 #1
[  528.626774] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.12.0-1 04/01/2014
[  528.626774] RIP: 0010:shmem_getpage_gfp.isra.0+0x470/0x750
[  528.626774] Code: f6 0f 85 e6 fd ff ff e8 2e f3 fd ff 48 8b 7d c8
48 8b 47 08 48 8d 50 ff a8 01 48 0f 45 fa f0 ff 4f 34 0f 84 ff 01 00
00 31 ff <4c> 2b 67 20 48 8b 85 70 ff ff ff 45 31 c0 49 c1 e4 06 4c 01
e7 48
[  528.626774] RSP: 0018:ffffafb3010afb70 EFLAGS: 00010246
[  528.626774] RAX: 0000000000000000 RBX: ffff934df3fc3770 RCX: 0000000000000000
[  528.626774] RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000000000
[  528.626774] RBP: ffffafb3010afc10 R08: 0000000000100cca R09: 0000000000000000
[  528.626774] R10: 0000000000000002 R11: 0000000000000001 R12: 0000000000000006
[  528.626774] R13: ffffafb3010afc70 R14: 0000000000000000 R15: ffff934df3fc38e8
[  528.626774] FS:  00007f32510fa740(0000) GS:ffff934dfbc00000(0000)
knlGS:0000000000000000
[  528.626774] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  528.626774] CR2: 0000000000000020 CR3: 000000013363c000 CR4: 00000000003506f0
[  528.626774] Call Trace:
[  528.626774]  ? release_pages+0x2e6/0x350
[  528.626774]  shmem_undo_range+0x39b/0x7c0
[  528.626774]  ? memcg_check_events+0xb0/0x1c0
[  528.626774]  shmem_truncate_range+0x14/0x40
[  528.626774]  shmem_setattr+0x265/0x2b0
[  528.626774]  notify_change+0x348/0x4c0
[  528.626774]  do_truncate+0x78/0xd0
[  528.626774]  ? do_truncate+0x78/0xd0
[  528.626774]  do_sys_ftruncate+0xf0/0x1a0
[  528.626774]  __x64_sys_ftruncate+0x1b/0x20
[  528.626774]  do_syscall_64+0x38/0x50
[  528.626774]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  528.626774] RIP: 0033:0x7f32507f2a17
[  528.626774] Code: 77 01 c3 48 8b 15 81 14 2c 00 f7 d8 64 89 02 b8
ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 b8 4d 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 51 14 2c 00 f7 d8 64 89
02 b8
[  528.626774] RSP: 002b:00007ffc9eb08088 EFLAGS: 00000206 ORIG_RAX:
000000000000004d
[  528.626774] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f32507f2a17
[  528.626774] RDX: 00000000000054f8 RSI: 00000000000064f7 RDI: 0000000000000006
[  528.626774] RBP: 0000000000000006 R08: 00000005deece66d R09: 00007f3250838930
[  528.626774] R10: 00000000000000bb R11: 0000000000000206 R12: 0000000000001000
[  528.626774] R13: 000000000030a253 R14: 00000000000064f7 R15: 0000000000000042
[  528.626774] Modules linked in:
[  528.626774] CR2: 0000000000000020
[  528.626774] ---[ end trace a5ebcc25e2e2a590 ]---
[  528.626774] RIP: 0010:shmem_getpage_gfp.isra.0+0x470/0x750
[  528.626774] Code: f6 0f 85 e6 fd ff ff e8 2e f3 fd ff 48 8b 7d c8
48 8b 47 08 48 8d 50 ff a8 01 48 0f 45 fa f0 ff 4f 34 0f 84 ff 01 00
00 31 ff <4c> 2b 67 20 48 8b 85 70 ff ff ff 45 31 c0 49 c1 e4 06 4c 01
e7 48
[  528.626774] RSP: 0018:ffffafb301097b70 EFLAGS: 00010246
[  528.626774] RAX: 0000000000000000 RBX: ffff934df9e5ce30 RCX: 0000000000000000
[  528.626774] RDX: 0000000000000039 RSI: ffff934de5c09240 RDI: 0000000000000000
[  528.626774] RBP: ffffafb301097c10 R08: 0000000000100cca R09: 0000000000000000
[  528.626774] R10: 0000000000000002 R11: 0000000000000001 R12: 0000000000000039
[  528.626774] R13: ffffafb301097c70 R14: 0000000000000000 R15: ffff934df9e5cfa8
[  528.626774] FS:  00007f32510fa740(0000) GS:ffff934dfbc00000(0000)
knlGS:0000000000000000
[  528.626774] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  528.626774] CR2: 0000000000000020 CR3: 000000013363c000 CR4: 00000000003506f0
[  528.672531] BUG: kernel NULL pointer dereference, address: 0000000000000020
[  528.672783] #PF: supervisor read access in kernel mode
[  528.672783] #PF: error_code(0x0000) - not-present page
[  528.672783] PGD 133c9a067 P4D 133c9a067 PUD 1334b1067 PMD 0
[  528.672783] Oops: 0000 [#4] SMP NOPTI
[  528.672783] CPU: 0 PID: 729 Comm: growfiles Tainted: G      D
    5.9.0-rc5-next-20200914 #1
[  528.672783] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.12.0-1 04/01/2014
[  528.672783] RIP: 0010:shmem_getpage_gfp.isra.0+0x470/0x750
[  528.672783] Code: f6 0f 85 e6 fd ff ff e8 2e f3 fd ff 48 8b 7d c8
48 8b 47 08 48 8d 50 ff a8 01 48 0f 45 fa f0 ff 4f 34 0f 84 ff 01 00
00 31 ff <4c> 2b 67 20 48 8b 85 70 ff ff ff 45 31 c0 49 c1 e4 06 4c 01
e7 48
[  528.672783] RSP: 0018:ffffafb3010b7b70 EFLAGS: 00010246
[  528.672783] RAX: 0000000000000000 RBX: ffff934df3fc29b0 RCX: 0000000000000000
[  528.672783] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
[  528.672783] RBP: ffffafb3010b7c10 R08: 0000000000100cca R09: 0000000000000000
[  528.672783] R10: 0000000000000002 R11: 0000000000000001 R12: 0000000000000001
[  528.672783] R13: ffffafb3010b7c70 R14: 0000000000000000 R15: ffff934df3fc2b28
[  528.672783] FS:  00007f525e976740(0000) GS:ffff934dfbc00000(0000)
knlGS:0000000000000000
[  528.672783] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  528.672783] CR2: 0000000000000020 CR3: 0000000139e94000 CR4: 00000000003506f0
[  528.672783] Call Trace:
[  528.672783]  ? release_pages+0x2e6/0x350
[  528.672783]  shmem_undo_range+0x39b/0x7c0
[  528.672783]  shmem_truncate_range+0x14/0x40
[  528.672783]  shmem_setattr+0x265/0x2b0
[  528.672783]  notify_change+0x348/0x4c0
[  528.672783]  do_truncate+0x78/0xd0
[  528.672783]  ? do_truncate+0x78/0xd0
[  528.672783]  do_sys_ftruncate+0xf0/0x1a0
[  528.672783]  __x64_sys_ftruncate+0x1b/0x20
[  528.672783]  do_syscall_64+0x38/0x50
[  528.672783]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  528.672783] RIP: 0033:0x7f525e06ea17
[  528.672783] Code: 77 01 c3 48 8b 15 81 14 2c 00 f7 d8 64 89 02 b8
ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 b8 4d 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 51 14 2c 00 f7 d8 64 89
02 b8
[  528.672783] RSP: 002b:00007ffd407309c8 EFLAGS: 00000206 ORIG_RAX:
000000000000004d
[  528.672783] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f525e06ea17
[  528.672783] RDX: 0000000000000f99 RSI: 0000000000001199 RDI: 0000000000000006
[  528.672783] RBP: 0000000000000006 R08: 00000005deece66d R09: 00007f525e0b4930
[  528.672783] R10: 6d20736574796220 R11: 0000000000000206 R12: 0000000000001000
[  528.672783] R13: 0000000000013371 R14: 0000000000001199 R15: 0000000000000042
[  528.672783] Modules linked in:
[  528.672783] CR2: 0000000000000020
[  528.672783] ---[ end trace a5ebcc25e2e2a591 ]---
[  528.672783] RIP: 0010:shmem_getpage_gfp.isra.0+0x470/0x750
[  528.672783] Code: f6 0f 85 e6 fd ff ff e8 2e f3 fd ff 48 8b 7d c8
48 8b 47 08 48 8d 50 ff a8 01 48 0f 45 fa f0 ff 4f 34 0f 84 ff 01 00
00 31 ff <4c> 2b 67 20 48 8b 85 70 ff ff ff 45 31 c0 49 c1 e4 06 4c 01
e7 48
[  528.672783] RSP: 0018:ffffafb301097b70 EFLAGS: 00010246
[  528.672783] RAX: 0000000000000000 RBX: ffff934df9e5ce30 RCX: 0000000000000000
[  528.672783] RDX: 0000000000000039 RSI: ffff934de5c09240 RDI: 0000000000000000
[  528.672783] RBP: ffffafb301097c10 R08: 0000000000100cca R09: 0000000000000000
[  528.672783] R10: 0000000000000002 R11: 0000000000000001 R12: 0000000000000039
[  528.672783] R13: ffffafb301097c70 R14: 0000000000000000 R15: ffff934df9e5cfa8
[  528.672783] FS:  00007f525e976740(0000) GS:ffff934dfbc00000(0000)
knlGS:0000000000000000
[  528.672783] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  528.672783] CR2: 0000000000000020 CR3: 0000000139e94000 CR4: 00000000003506f0
[  528.722527] BUG: kernel NULL pointer dereference, address: 0000000000000020
[  528.722791] #PF: supervisor read access in kernel mode
[  528.722791] #PF: error_code(0x0000) - not-present page
[  528.722791] PGD 133c61067 P4D 133c61067 PUD 13aa06067 PMD 0
[  528.722791] Oops: 0000 [#5] SMP NOPTI
[  528.722791] CPU: 0 PID: 730 Comm: growfiles Tainted: G      D
    5.9.0-rc5-next-20200914 #1
[  528.722791] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.12.0-1 04/01/2014
[  528.722791] RIP: 0010:shmem_getpage_gfp.isra.0+0x470/0x750
[  528.722791] Code: f6 0f 85 e6 fd ff ff e8 2e f3 fd ff 48 8b 7d c8
48 8b 47 08 48 8d 50 ff a8 01 48 0f 45 fa f0 ff 4f 34 0f 84 ff 01 00
00 31 ff <4c> 2b 67 20 48 8b 85 70 ff ff ff 45 31 c0 49 c1 e4 06 4c 01
e7 48
[  528.722791] RSP: 0018:ffffafb3010bfce8 EFLAGS: 00010246
[  528.722791] RAX: 0000000000000000 RBX: ffff934df3fc34b0 RCX: 0000000000000000
[  528.722791] RDX: 0000000000000000 RSI: ffff934df7bf9918 RDI: 0000000000000000
[  528.722791] RBP: ffffafb3010bfd88 R08: 0000000000100cca R09: 0000000000000000
[  528.722791] R10: ffffafb3010bfe68 R11: 0000000000000000 R12: 0000000000000000
[  528.722791] R13: ffff934df3fc34b0 R14: 0000000000000000 R15: ffff934df3fc3628
[  528.722791] FS:  00007f5769397740(0000) GS:ffff934dfbc00000(0000)
knlGS:0000000000000000
[  528.722791] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  528.722791] CR2: 0000000000000020 CR3: 000000013363c000 CR4: 00000000003506f0
[  528.722791] Call Trace:
[  528.722791]  ? avc_has_perm+0xca/0x1f0
[  528.722791]  shmem_file_read_iter+0xf7/0x380
[  528.722791]  new_sync_read+0x110/0x1a0
[  528.722791]  vfs_read+0x154/0x1b0
[  528.722791]  ksys_read+0x67/0xe0
[  528.722791]  __x64_sys_read+0x1a/0x20
[  528.722791]  do_syscall_64+0x38/0x50
[  528.722791]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  528.722791] RIP: 0033:0x7f5768d6756e
[  528.722791] Code: 8a 20 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff c3
66 2e 0f 1f 84 00 00 00 00 00 66 90 8b 05 7a ce 20 00 85 c0 75 16 31
c0 0f 05 <48> 3d 00 f0 ff ff 77 5a c3 66 0f 1f 84 00 00 00 00 00 41 54
49 89
[  528.722791] RSP: 002b:00007ffdd45b2328 EFLAGS: 00000246 ORIG_RAX:
0000000000000000
[  528.722791] RAX: ffffffffffffffda RBX: 0000000000008000 RCX: 00007f5768d6756e
[  528.722791] RDX: 0000000000008000 RSI: 0000000002320270 RDI: 0000000000000006
[  528.722791] RBP: 0000000000000006 R08: 0000000000000005 R09: 00007ffdd45b20d3
[  528.722791] R10: 000000000000006f R11: 0000000000000246 R12: 0000000002320270
[  528.722791] R13: 0000000000008000 R14: 0000000000000000 R15: 0000000000000000
[  528.722791] Modules linked in:
[  528.722791] CR2: 0000000000000020
[  528.722791] ---[ end trace a5ebcc25e2e2a592 ]---
[  528.722791] RIP: 0010:shmem_getpage_gfp.isra.0+0x470/0x750
[  528.722791] Code: f6 0f 85 e6 fd ff ff e8 2e f3 fd ff 48 8b 7d c8
48 8b 47 08 48 8d 50 ff a8 01 48 0f 45 fa f0 ff 4f 34 0f 84 ff 01 00
00 31 ff <4c> 2b 67 20 48 8b 85 70 ff ff ff 45 31 c0 49 c1 e4 06 4c 01
e7 48
[  528.722791] RSP: 0018:ffffafb301097b70 EFLAGS: 00010246
[  528.722791] RAX: 0000000000000000 RBX: ffff934df9e5ce30 RCX: 0000000000000000
[  528.722791] RDX: 0000000000000039 RSI: ffff934de5c09240 RDI: 0000000000000000
[  528.722791] RBP: ffffafb301097c10 R08: 0000000000100cca R09: 0000000000000000
[  528.722791] R10: 0000000000000002 R11: 0000000000000001 R12: 0000000000000039
[  528.722791] R13: ffffafb301097c70 R14: 0000000000000000 R15: ffff934df9e5cfa8
[  528.722791] FS:  00007f5769397740(0000) GS:ffff934dfbc00000(0000)
knlGS:0000000000000000
[  528.722791] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  528.722791] CR2: 0000000000000020 CR3: 000000013363c000 CR4: 00000000003506f0
[  528.776714] BUG: kernel NULL pointer dereference, address: 0000000000000020
[  528.776789] #PF: supervisor read access in kernel mode
[  528.776789] #PF: error_code(0x0000) - not-present page
[  528.776789] PGD 133dc8067 P4D 133dc8067 PUD 138f87067 PMD 0
[  528.776789] Oops: 0000 [#6] SMP NOPTI
[  528.776789] CPU: 0 PID: 731 Comm: growfiles Tainted: G      D
    5.9.0-rc5-next-20200914 #1
[  528.776789] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.12.0-1 04/01/2014
[  528.776789] RIP: 0010:shmem_getpage_gfp.isra.0+0x470/0x750
[  528.776789] Code: f6 0f 85 e6 fd ff ff e8 2e f3 fd ff 48 8b 7d c8
48 8b 47 08 48 8d 50 ff a8 01 48 0f 45 fa f0 ff 4f 34 0f 84 ff 01 00
00 31 ff <4c> 2b 67 20 48 8b 85 70 ff ff ff 45 31 c0 49 c1 e4 06 4c 01
e7 48
[  528.776789] RSP: 0018:ffffafb3010c7ce8 EFLAGS: 00010246
[  528.776789] RAX: 0000000000000000 RBX: ffff934df3fc3cf0 RCX: 0000000000000000
[  528.776789] RDX: 0000000000000000 RSI: ffff934df7bf9ff0 RDI: 0000000000000000
[  528.776789] RBP: ffffafb3010c7d88 R08: 0000000000100cca R09: 0000000000000000
[  528.776789] R10: ffffafb3010c7e68 R11: 0000000000000000 R12: 0000000000000000
[  528.776789] R13: ffff934df3fc3cf0 R14: 0000000000000000 R15: ffff934df3fc3e68
[  528.776789] FS:  00007fd47a493740(0000) GS:ffff934dfbc00000(0000)
knlGS:0000000000000000
[  528.776789] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  528.776789] CR2: 0000000000000020 CR3: 0000000139f5e000 CR4: 00000000003506f0
[  528.776789] Call Trace:
[  528.776789]  ? avc_has_perm+0xca/0x1f0
[  528.776789]  shmem_file_read_iter+0xf7/0x380
[  528.776789]  new_sync_read+0x110/0x1a0
[  528.776789]  vfs_read+0x154/0x1b0
[  528.776789]  ksys_read+0x67/0xe0
[  528.776789]  __x64_sys_read+0x1a/0x20
[  528.776789]  do_syscall_64+0x38/0x50
[  528.776789]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  528.776789] RIP: 0033:0x7fd479e6356e
[  528.776789] Code: 8a 20 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff c3
66 2e 0f 1f 84 00 00 00 00 00 66 90 8b 05 7a ce 20 00 85 c0 75 16 31
c0 0f 05 <48> 3d 00 f0 ff ff 77 5a c3 66 0f 1f 84 00 00 00 00 00 41 54
49 89
[  528.776789] RSP: 002b:00007ffd1c581e58 EFLAGS: 00000246 ORIG_RAX:
0000000000000000
[  528.776789] RAX: ffffffffffffffda RBX: 0000000000010000 RCX: 00007fd479e6356e
[  528.776789] RDX: 0000000000010000 RSI: 0000000001931270 RDI: 0000000000000006
[  528.776789] RBP: 0000000000000006 R08: 0000000000000005 R09: 00007ffd1c581c03
[  528.776789] R10: 000000000000006f R11: 0000000000000246 R12: 0000000001931270
[  528.776789] R13: 0000000000010000 R14: 0000000000000000 R15: 0000000000000000
[  528.776789] Modules linked in:
[  528.776789] CR2: 0000000000000020
[  528.776789] ---[ end trace a5ebcc25e2e2a593 ]---

i386 log:
------------
[   75.900706] BUG: kernel NULL pointer dereference, address: 00000010
[   75.900969] #PF: supervisor read access in kernel mode
[   75.900969] #PF: error_code(0x0000) - not-present page
[   75.900969] *pde = 00000000
[   75.900969] Oops: 0000 [#1] SMP
[   75.900969] CPU: 0 PID: 10104 Comm: fsx-linux Not tainted
5.9.0-rc5-next-20200914 #1
[   75.900969] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.12.0-1 04/01/2014
[   75.900969] EIP: shmem_getpage_gfp.isra.0+0x39e/0x7c0
[   75.900969] Code: d2 0f 85 b4 00 00 00 e8 90 23 fe ff 8b 45 ec 8b
50 04 8d 4a ff 83 e2 01 0f 45 c1 f0 ff 48 1c 0f 84 7f 03 00 00 31 c0
8b 55 e4 <2b> 50 10 31 db 8b 7d b0 8d 14 92 8d 04 d0 89 07 e9 ed 01 00
00 8d
[   75.900969] EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 0000000c
[   75.900969] ESI: f3868c78 EDI: f2c57180 EBP: f2e61e90 ESP: f2e61e38
[   75.900969] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010246
[   75.900969] CR0: 80050033 CR2: 00000010 CR3: 33994000 CR4: 003506d0
[   75.900969] Call Trace:
[   75.900969]  shmem_file_read_iter+0xd8/0x2d0
[   75.900969]  vfs_read+0x1be/0x320
[   75.900969]  ksys_read+0x58/0xd0
[   75.900969]  __ia32_sys_read+0x15/0x20
[   75.900969]  __do_fast_syscall_32+0x45/0x80
[   75.900969]  do_fast_syscall_32+0x29/0x60
[   75.900969]  do_SYSENTER_32+0x15/0x20
[   75.900969]  entry_SYSENTER_32+0x9f/0xf2
[   75.900969] EIP: 0xb7f6f549
[   75.900969] Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01
10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f
34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90
8d 76
[   75.900969] EAX: ffffffda EBX: 00000006 ECX: 085df2d0 EDX: 0000f0c4
[   75.900969] ESI: 0000f0c4 EDI: bfa07aa8 EBP: 085df160 ESP: bfa07a50
[   75.900969] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000246
[   75.900969] Modules linked in:
[   75.900969] CR2: 0000000000000010
[   75.900969] ---[ end trace 3b0d162207b86ec2 ]---
[   75.900969] EIP: shmem_getpage_gfp.isra.0+0x39e/0x7c0
[   75.900969] Code: d2 0f 85 b4 00 00 00 e8 90 23 fe ff 8b 45 ec 8b
50 04 8d 4a ff 83 e2 01 0f 45 c1 f0 ff 48 1c 0f 84 7f 03 00 00 31 c0
8b 55 e4 <2b> 50 10 31 db 8b 7d b0 8d 14 92 8d 04 d0 89 07 e9 ed 01 00
00 8d
[   75.900969] EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 0000000c
[   75.900969] ESI: f3868c78 EDI: f2c57180 EBP: f2e61e90 ESP: f2e61e38
[   75.900969] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010246
[   75.900969] CR0: 80050033 CR2: 00000010 CR3: 33994000 CR4: 003506d0


x86_64 full test log,
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20200914/testrun/3195428/suite/linux-log-parser/test/check-kernel-oops-1764160/log

i386 full test log,
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20200914/testrun/3195415/suite/linux-log-parser/test/check-kernel-oops-1764183/log

-- 
Linaro LKFT
https://lkft.linaro.org
