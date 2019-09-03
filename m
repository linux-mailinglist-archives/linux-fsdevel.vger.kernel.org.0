Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B29FA639C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 10:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfICINY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 04:13:24 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45305 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbfICINY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 04:13:24 -0400
Received: by mail-lf1-f66.google.com with SMTP id r134so11248537lff.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Sep 2019 01:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tolH3D55wRJVvoVj7G+TtEu5ivH6DhNUR4UBADzwzKg=;
        b=o6oUECDeFmzOs8qtAv7INu7XZ4/K9fjKDS6TECghoijZHBSPwtgjdn8F8f6LfpLT6x
         d/d1CN79oDHPMSpvo7aawL3qEhwVTDhBz5lSv6vbpt/1+VssyUFVZ2JFhWTE8WhXZNlI
         mZbS0Meiro/kd8ISCE9vcexmMM3es5hsFky5+V1DnyeT8dozwj+AelxHYUBIF2/4BMGR
         cruUJI8Ze7tLGSx5zB2njBxetNwswlXi/CnXjXEs7UW+Mgb8rsx4IP0GaW9X6rkb5YCa
         +/EQoygrK/qpIyzsnn3I9YxSWTQzc8uRQtSXaYHLlC9iaxCx3sywwCngOYcCY2auWWPs
         MKhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tolH3D55wRJVvoVj7G+TtEu5ivH6DhNUR4UBADzwzKg=;
        b=a5IxfQXL2ffjzv/KKjPGsMX/E29n/XHCvWVdVf93Ay3pmyqTbOeB440hNRzVPBYz+s
         yQ26nHmn6GuQxewAgvdRI4rnMVKaY9Lxwtika9VeAmBgU3zbG7D0zS+CmTk+w3yKbjkO
         C9OERb5t0EfHpSIPscC2eoomQboq32wfDFLvsms+wb1ZcOwgWkhXqNb+IU48cj4bpEkj
         mEmrsaIsbrzUDaM4ylzHVH2x9DZlwLUKQohG2urVE9MoVRROpptrewzrRvqrsOAAQyU6
         tpowukuLIJjzeeGN0i1lYHdKyN53FiWPPbkpmvUQ/EzgprMErES6vbgA7uuIcHDv6og+
         4ByA==
X-Gm-Message-State: APjAAAVBIhR7ZF4H0I1JSBWyzDgmjKPh1nQ0LsBNq2R1+88KtoxNHoZ8
        vAK7ZVdhQC4yd17rzVZ5IVhvanFdnWKwcTmlShfGpQ==
X-Google-Smtp-Source: APXvYqyQRgeTjLJvsiQUasNopOTOQbGwBZmdzgUXGWyN41mBKTiKI7Dxp6Hj9Do78HMmSnOo1lF5Q5phzs2eezTyDB8=
X-Received: by 2002:a19:8017:: with SMTP id b23mr19036406lfd.132.1567498400885;
 Tue, 03 Sep 2019 01:13:20 -0700 (PDT)
MIME-Version: 1.0
References: <7C6CCE98-1E22-433C-BF70-A3CBCDED4635@lca.pw>
In-Reply-To: <7C6CCE98-1E22-433C-BF70-A3CBCDED4635@lca.pw>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 3 Sep 2019 13:43:09 +0530
Message-ID: <CA+G9fYvOUch79HoBiJbuod2bTGS5h8se5EB5LRJAwTCfPQr2ow@mail.gmail.com>
Subject: Re: "fs/namei.c: keep track of nd->root refcount status" causes boot panic
To:     Qian Cai <cai@lca.pw>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 3 Sep 2019 at 09:51, Qian Cai <cai@lca.pw> wrote:
>
> The linux-next commit "fs/namei.c: keep track of nd->root refcount status=
=E2=80=9D [1] causes boot panic on all
> architectures here on today=E2=80=99s linux-next (0902). Reverted it will=
 fix the issue.

I have same problem and reverting this patch fixed the kernel crash.

>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/c=
ommit/?id=3De013ec23b8231cf7f95605cbb0e47aa0e3d047a4
>

FYI,
on x86_64 device I have noticed kernel bug [1].

[   12.941007] Run /sbin/init as init process
[   12.946381] random: fast init done
[   13.023482] BUG: kernel NULL pointer dereference, address: 0000000000000=
235
[   13.030444] #PF: supervisor read access in kernel mode
[   13.035576] #PF: error_code(0x0000) - not-present page
[   13.040725] PGD 0 P4D 0
[   13.043263] Oops: 0000 [#1] SMP PTI
[   13.046755] CPU: 2 PID: 1 Comm: systemd Not tainted
5.3.0-rc6-next-20190902 #1
[   13.053966] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.0b 07/27/2017
[   13.061438] RIP: 0010:dput+0x72/0x4a0
[   13.065101] Code: 68 0d 5f 41 56 31 d2 45 31 c9 45 31 c0 31 f6 b9
02 00 00 00 48 c7 c7 e0 dd 66 a2 e8 48 6c e1 ff e8 e3 9f e3 ff 85 c0
5a 75 76 <f6> 03 08 4c 8d a3 80 00 00 00 4c 89 e7 0f 85 7b 01 00 00 e8
16 66
[   13.083838] RSP: 0018:ffffb16100027c00 EFLAGS: 00010202
[   13.089055] RAX: 0000000000000001 RBX: 0000000000000235 RCX: 00000000fff=
78e19
[   13.096180] RDX: ffffffffa0f3f630 RSI: 00000000ffffffff RDI: 00000000000=
00000
[   13.103301] RBP: ffffb16100027c30 R08: 0000000000000000 R09: 00000000000=
00000
[   13.110425] R10: 0000000000000000 R11: 0000000000000000 R12: ffffb161000=
27e30
[   13.117550] R13: ffffffffa23a557f R14: ffffffffa0f3f630 R15: ffffb161000=
27e30
[   13.124685] FS:  00007f2541dc4840(0000) GS:ffff9983dfb00000(0000)
knlGS:0000000000000000
[   13.132767] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   13.138506] CR2: 0000000000000235 CR3: 000000045a2fe003 CR4: 00000000003=
606e0
[   13.145630] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[   13.152752] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[   13.159875] Call Trace:
[   13.162323]  terminate_walk+0x104/0x160
[   13.166162]  path_lookupat+0xa4/0x210
[   13.169828]  filename_lookup+0xb6/0x180
[   13.173682]  ? fs_reclaim_release.part.107+0x5/0x30
[   13.178581]  ? getname_flags+0x4b/0x1e0
[   13.182419]  ? rcu_read_lock_sched_held+0x4f/0x80
[   13.187116]  ? kmem_cache_alloc+0x290/0x2c0
[   13.191293]  ? __might_fault+0x85/0x90
[   13.195037]  user_path_at_empty+0x36/0x40
[   13.199041]  ? user_path_at_empty+0x36/0x40
[   13.203217]  vfs_statx+0x76/0xe0
[   13.206442]  __do_sys_newfstatat+0x35/0x70
[   13.210535]  ? entry_SYSCALL_64_after_hwframe+0x3e/0xbe
[   13.215758]  ? trace_hardirqs_off_caller+0x22/0xf0
[   13.220542]  ? do_syscall_64+0x17/0x1c0
[   13.224374]  ? lockdep_hardirqs_on+0xf6/0x190
[   13.228730]  ? do_syscall_64+0x17/0x1c0
[   13.232564]  ? trace_hardirqs_on+0x4c/0x100
[   13.236747]  __x64_sys_newfstatat+0x1e/0x20
[   13.240925]  do_syscall_64+0x55/0x1c0
[   13.244582]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[   13.249625] RIP: 0033:0x7f25405bba09
[   13.253196] Code: 64 c7 00 16 00 00 00 b8 ff ff ff ff c3 0f 1f 40
00 89 f0 48 89 d6 83 ff 01 77 36 89 c7 45 89 c2 48 89 ca b8 06 01 00
00 0f 05 <48> 3d 00 f0 ff ff 77 07 c3 66 0f 1f 44 00 00 48 8b 15 59 94
2c 00
[   13.271934] RSP: 002b:00007ffd6722dfc8 EFLAGS: 00000246 ORIG_RAX:
0000000000000106
[   13.279490] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f25405=
bba09
[   13.286614] RDX: 00007ffd6722e090 RSI: 00007f25418c06d6 RDI: 00000000000=
00004
[   13.293738] RBP: 0000000000000004 R08: 0000000000001000 R09: 00000000000=
00001
[   13.300860] R10: 0000000000001000 R11: 0000000000000246 R12: 000055bd9f6=
67281
[   13.307984] R13: 0000000000000400 R14: 00007ffd6722e518 R15: 00000000000=
00001
[   13.315111] Modules linked in:
[   13.318170] CR2: 0000000000000235
[   13.321489] ---[ end trace 2f1042f3cbf26726 ]---
[   13.326107] RIP: 0010:dput+0x72/0x4a0
[   13.329763] Code: 68 0d 5f 41 56 31 d2 45 31 c9 45 31 c0 31 f6 b9
02 00 00 00 48 c7 c7 e0 dd 66 a2 e8 48 6c e1 ff e8 e3 9f e3 ff 85 c0
5a 75 76 <f6> 03 08 4c 8d a3 80 00 00 00 4c 89 e7 0f 85 7b 01 00 00 e8
16 66
[   13.348499] RSP: 0018:ffffb16100027c00 EFLAGS: 00010202
[   13.353740] RAX: 0000000000000001 RBX: 0000000000000235 RCX: 00000000fff=
78e19
[   13.360865] RDX: ffffffffa0f3f630 RSI: 00000000ffffffff RDI: 00000000000=
00000
[   13.367990] RBP: ffffb16100027c30 R08: 0000000000000000 R09: 00000000000=
00000
[   13.375115] R10: 0000000000000000 R11: 0000000000000000 R12: ffffb161000=
27e30
[   13.382238] R13: ffffffffa23a557f R14: ffffffffa0f3f630 R15: ffffb161000=
27e30
[   13.389361] FS:  00007f2541dc4840(0000) GS:ffff9983dfb00000(0000)
knlGS:0000000000000000
[   13.397439] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   13.403176] CR2: 0000000000000235 CR3: 000000045a2fe003 CR4: 00000000003=
606e0
[   13.410301] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[   13.417422] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[   13.424549] BUG: sleeping function called from invalid context at
/usr/src/kernel/include/linux/percpu-rwsem.h:38
[   13.434793] in_atomic(): 1, irqs_disabled(): 1, pid: 1, name: systemd
[   13.441222] INFO: lockdep is turned off.
[   13.445138] irq event stamp: 1373108
[   13.448740] hardirqs last  enabled at (1373107):
[<ffffffffa0f3216b>] path_init+0x21b/0x520
[   13.457083] hardirqs last disabled at (1373108):
[<ffffffffa0c01c9a>] trace_hardirqs_off_thunk+0x1a/0x20
[   13.466555] softirqs last  enabled at (1373040):
[<ffffffffa16ea835>] release_sock+0x85/0xb0
[   13.474985] softirqs last disabled at (1373038):
[<ffffffffa16ea7ce>] release_sock+0x1e/0xb0
[   13.483409] CPU: 2 PID: 1 Comm: systemd Tainted: G      D
5.3.0-rc6-next-20190902 #1
[   13.492007] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.0b 07/27/2017
[   13.499478] Call Trace:
[   13.501923]  dump_stack+0x70/0xa5
[   13.505243]  ___might_sleep+0x152/0x240
[   13.509080]  __might_sleep+0x4a/0x80
[   13.512679]  exit_signals+0x33/0x2e0
[   13.516273]  do_exit+0xb1/0xce0
[   13.519410]  ? do_syscall_64+0x17/0x1c0
[   13.523240]  ? trace_hardirqs_on+0x4c/0x100
[   13.527419]  rewind_stack_do_exit+0x17/0x20
[   13.531595] RIP: 0033:0x7f25405bba09
[   13.535166] Code: 64 c7 00 16 00 00 00 b8 ff ff ff ff c3 0f 1f 40
00 89 f0 48 89 d6 83 ff 01 77 36 89 c7 45 89 c2 48 89 ca b8 06 01 00
00 0f 05 <48> 3d 00 f0 ff ff 77 07 c3 66 0f 1f 44 00 00 48 8b 15 59 94
2c 00
[   13.553900] RSP: 002b:00007ffd6722dfc8 EFLAGS: 00000246 ORIG_RAX:
0000000000000106
[   13.561459] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f25405=
bba09
[   13.568581] RDX: 00007ffd6722e090 RSI: 00007f25418c06d6 RDI: 00000000000=
00004
[   13.575735] RBP: 0000000000000004 R08: 0000000000001000 R09: 00000000000=
00001
[   13.582865] R10: 0000000000001000 R11: 0000000000000246 R12: 000055bd9f6=
67281
[   13.589990] R13: 0000000000000400 R14: 00007ffd6722e518 R15: 00000000000=
00001
[   13.597146] note: systemd[1] exited with preempt_count 1
[   13.602674] Kernel panic - not syncing: Attempted to kill init!
exitcode=3D0x00000009
[   13.610402] Kernel Offset: 0x1fc00000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)


Full test log,
[1] https://lkft.validation.linaro.org/scheduler/job/896370#L970


Best regards
Naresh Kamboju
