Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A933549C2E1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 06:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiAZFEc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 00:04:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiAZFEb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 00:04:31 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41469C06161C;
        Tue, 25 Jan 2022 21:04:30 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id jx6so36129563ejb.0;
        Tue, 25 Jan 2022 21:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jXtY+SCNhOHWvdjxA1G1TqTFhrzCv8W9jwNpM1NgoY0=;
        b=n46McUcf06SVRtg558CyMqcE7tvF6P7X8pcdh1e6jaUXGheK1oQFJ2NDle0BC6S0Bf
         8SgUlwAT1P9V8hlTtuN8O6O+E0fA7m0H+Abjwe0gcnwOMx6lEPXPXs1lgknT7k91F/V6
         vvkaT2vB8CV5C99C5JKJFYQMEkuFfvr9g2qs/swq3VyXf5t5M+hNngrE1jGU/+AFx/Tc
         A+UO7+rbJQVp77mVgb7WKc//f/2m3VoAkCKPxa5lFfjTd8HPxkW4dxVcW1+XIdSUydp8
         Jp7/+DQtCaY74CLsbqBkkDnJwR4yUALC2HtKx9KJTAYb69gnbVj+W4PIyda5y5k4G3ZV
         PMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jXtY+SCNhOHWvdjxA1G1TqTFhrzCv8W9jwNpM1NgoY0=;
        b=bnCX4xnW87wm9aQ9aQRD7oiDtrKg5/eVGdskHuShI86j7oO0FjEXrCGgQGPTaW81tb
         7TMnLowFEVfRGWgWmXtyCQkCx15xUKybx0UnHq7/4+uWV1phIcgcKQHavKY4ub1K95f7
         F6J+ez8nJK4scIZaqjEMxQfQ8DQ7EEibmVSeZNa8m7aLGtnP0t9/5IV+ucMWv1qoioDp
         kMmac1RPK/vayvOf+GoqA3USSRPGBURialxQ4Z7Az945qLoxvqrnxA8zZ272JRo4QMe1
         2IqQlZxH2ucSKCodqAlmPCNQ7M8o7TVArY9vOmg21XkJCVVXIthrh9H/Lpke+W2PpF+p
         x25g==
X-Gm-Message-State: AOAM530gtGDMxmMDF5N6/LwoCOx+1/Phf9skKeppV9jaug1wuX7oDM13
        1Du3oBenOtASaSsp1ay46JPUXJZmC+f72p9KC9k=
X-Google-Smtp-Source: ABdhPJznTS3owLApkoPAwgQvsOSqtBJu4DPnYhfBfRPMmd6mmAR0hMYBQSXEgGFovzd+1JsqHpowPEmZVtcufXgrQ/4=
X-Received: by 2002:a17:907:2d25:: with SMTP id gs37mr9330656ejc.693.1643173468977;
 Tue, 25 Jan 2022 21:04:28 -0800 (PST)
MIME-Version: 1.0
References: <20220124003342.1457437-1-ztong0001@gmail.com> <202201241937.i9KSsyAj-lkp@intel.com>
 <20220124151611.30db4381d910c853fc0c9728@linux-foundation.org>
In-Reply-To: <20220124151611.30db4381d910c853fc0c9728@linux-foundation.org>
From:   Murphy Zhou <jencce.kernel@gmail.com>
Date:   Wed, 26 Jan 2022 13:04:17 +0800
Message-ID: <CADJHv_vh03bhn1FX2-jc6JoH3Hm6cRiWs+iXFO-coGy_yUY1Mw@mail.gmail.com>
Subject: Re: [PATCH v1] binfmt_misc: fix crash when load/unload module
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel test robot <lkp@intel.com>,
        Tong Zhang <ztong0001@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 25, 2022 at 4:53 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Mon, 24 Jan 2022 19:40:53 +0800 kernel test robot <lkp@intel.com> wrote:
>
> > Hi Tong,
> >
> >
> > >> fs/binfmt_misc.c:828:21: error: incompatible pointer types assigning to 'struct ctl_table_header *' from 'struct sysctl_header *' [-Werror,-Wincompatible-pointer-types]
> >            binfmt_misc_header = register_sysctl_mount_point("fs/binfmt_misc");
> >                               ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >    1 error generated.
> >
> >
> > vim +828 fs/binfmt_misc.c
> >
> >    821
> >    822        static int __init init_misc_binfmt(void)
> >    823        {
> >    824                int err = register_filesystem(&bm_fs_type);
> >    825                if (!err)
> >    826                        insert_binfmt(&misc_format);
> >    827
> >  > 828                binfmt_misc_header = register_sysctl_mount_point("fs/binfmt_misc");
> >    829                if (!binfmt_misc_header) {
> >    830                        pr_warn("Failed to create fs/binfmt_misc sysctl mount point");
> >    831                        return -ENOMEM;
> >    832                }
> >    833                return 0;
> >    834        }
> >    835
>
> This is actually a blooper in Luis's "sysctl: add helper to register a
> sysctl mount point".
>
> Please test, review, ridicule, etc:
>
> From: Andrew Morton <akpm@linux-foundation.org>
> Subject: include/linux/sysctl.h: fix register_sysctl_mount_point() return type
>
> The CONFIG_SYSCTL=n stub returns the wrong type.
>
> Fixes: ee9efac48a082 ("sysctl: add helper to register a sysctl mount point")
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Tong Zhang <ztong0001@gmail.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>
>  include/linux/sysctl.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- a/include/linux/sysctl.h~a
> +++ a/include/linux/sysctl.h
> @@ -265,7 +265,7 @@ static inline struct ctl_table_header *r
>         return NULL;
>  }
>
> -static inline struct sysctl_header *register_sysctl_mount_point(const char *path)
> +static inline struct ctl_table_header *register_sysctl_mount_point(const char *path)
>  {
>         return NULL;
>  }
> _

Still panic with this patch on Linux-next tree:

[ 1128.275515] LTP: starting binfmt_misc02 (binfmt_misc02.sh)
[ 1128.303975] CPU: 1 PID: 107182 Comm: modprobe Kdump: loaded
Tainted: G        W         5.17.0-rc1-next-20220125+ #1
[ 1128.305264] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
[ 1128.305992] Call Trace:
[ 1128.306376]  <TASK>
[ 1128.306682]  dump_stack_lvl+0x34/0x44
[ 1128.307211]  __register_sysctl_table+0x2c7/0x4a0
[ 1128.307846]  ? load_module+0xb37/0xbb0
[ 1128.308339]  ? 0xffffffffc01b6000
[ 1128.308762]  init_misc_binfmt+0x32/0x1000 [binfmt_misc]
[ 1128.309402]  do_one_initcall+0x44/0x200
[ 1128.309937]  ? kmem_cache_alloc_trace+0x163/0x2c0
[ 1128.310535]  do_init_module+0x5c/0x260
[ 1128.311045]  __do_sys_finit_module+0xb4/0x120
[ 1128.311603]  do_syscall_64+0x3b/0x90
[ 1128.312088]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 1128.312755] RIP: 0033:0x7f929ab85fbd
[ 1128.313204] Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e
fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 3b ee 0e 00 f7 d8 64 89
01 48
[ 1128.315402] RSP: 002b:00007ffe5d30ef48 EFLAGS: 00000246 ORIG_RAX:
0000000000000139
[ 1128.316312] RAX: ffffffffffffffda RBX: 00007f929bd2fc60 RCX: 00007f929ab85fbd
[ 1128.317170] RDX: 0000000000000000 RSI: 00007f929b264962 RDI: 0000000000000003
[ 1128.318032] RBP: 0000000000040000 R08: 0000000000000000 R09: 00007ffe5d30f080
[ 1128.318895] R10: 0000000000000003 R11: 0000000000000246 R12: 00007f929b264962
[ 1128.319768] R13: 00007f929bd2fd70 R14: 00007f929bd2fc60 R15: 00007f929bd2ff30
[ 1128.320642]  </TASK>
[ 1128.320948] binfmt_misc: Failed to create fs/binfmt_misc sysctl mount point
[ 1128.338732] BUG: unable to handle page fault for address: ffffffffc089d010
[ 1128.340439] #PF: supervisor read access in kernel mode
[ 1128.341072] #PF: error_code(0x0000) - not-present page
[ 1128.341702] PGD ea15067 P4D ea15067 PUD ea17067 PMD 1021e4067 PTE 0
[ 1128.342481] Oops: 0000 [#1] PREEMPT SMP PTI
[ 1128.343003] CPU: 1 PID: 107183 Comm: binfmt_misc02.s Kdump: loaded
Tainted: G        W         5.17.0-rc1-next-20220125+ #1
[ 1128.344326] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
[ 1128.345033] RIP: 0010:search_binary_handler+0xb0/0x250
[ 1128.345678] Code: 85 c0 0f 85 62 01 00 00 48 c7 c7 48 35 ef 87 41
bc fe ff ff ff e8 a0 d8 77 00 48 8b 1d 79 fa 6d 01 48 81 fb 00 06 47
87 74 5d <48> 8b 7b 10 e8 77 11 e1 ff 84 c0 74 44 48 c7 c7 48 35 ef 87
e8 a7
[ 1128.347879] RSP: 0018:ffffb72900813e48 EFLAGS: 00010206
[ 1128.348575] RAX: 0000000000000000 RBX: ffffffffc089d000 RCX: 0000000000000000
[ 1128.349468] RDX: 0000000000000000 RSI: ffff8f67921d9cc0 RDI: ffffffff87ef3548
[ 1128.350334] RBP: ffff8f678d18ec00 R08: 0000000000000000 R09: 0000000000000001
[ 1128.351201] R10: 0000000000000000 R11: ffff8f6792129f10 R12: 00000000fffffffe
[ 1128.352064] R13: 000000000001a2af R14: 0000000000000001 R15: ffff8f67919f8000
[ 1128.352927] FS:  00007f7f21d4a740(0000) GS:ffff8f67bbd00000(0000)
knlGS:0000000000000000
[ 1128.353903] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1128.354608] CR2: ffffffffc089d010 CR3: 000000010df8a004 CR4: 00000000007706e0
[ 1128.355469] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1128.356335] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1128.357196] PKRU: 55555554
[ 1128.357542] Call Trace:
[ 1128.357900]  <TASK>
[ 1128.358182]  exec_binprm+0x51/0x1a0
[ 1128.358626]  bprm_execve.part.0+0x16c/0x210
[ 1128.359142]  do_execveat_common.isra.0+0x156/0x1c0
[ 1128.359736]  __x64_sys_execve+0x33/0x40
[ 1128.360213]  do_syscall_64+0x3b/0x90
[ 1128.360668]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 1128.361287] RIP: 0033:0x7f7f21e2aabb
[ 1128.361739] Code: fb fe ff ff 48 8d 3d 24 4b 12 00 e8 3f cd fa ff
e9 ea fe ff ff 66 2e 0f 1f 84 00 00 00 00 00 f3 0f 1e fa b8 3b 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 3d c3 11 00 f7 d8 64 89
01 48
[ 1128.363940] RSP: 002b:00007ffec98f2f18 EFLAGS: 00000246 ORIG_RAX:
000000000000003b
[ 1128.364853] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f7f21e2aabb
[ 1128.365713] RDX: 00007f7f2347faa0 RSI: 00007f7f233e9940 RDI: 00007f7f2347f110
[ 1128.366576] RBP: 00007f7f2347f110 R08: 00007f7f23445420 R09: 0000000000000000
[ 1128.367433] R10: 0000000000000008 R11: 0000000000000246 R12: 00000000ffffffff
[ 1128.368296] R13: 00007f7f233e9940 R14: 00007f7f2347faa0 R15: 00007f7f2347f360
[ 1128.369160]  </TASK>
[ 1128.369462] Modules linked in: brd overlay exfat vfat fat ext2 loop
rfkill intel_rapl_msr intel_rapl_common isst_if_common nfit joydev
virtio_balloon sunrpc i2c_piix4 pcspkr ext4 mbcache jbd2 drm fuse xfs
libcrc32c ata_generic crct10dif_pclmul ata_piix crc32_pclmul
crc32c_intel virtio_net libata net_failover serio_raw
ghash_clmulni_intel virtio_blk failover [last unloaded: binfmt_misc]
[ 1128.373485] CR2: ffffffffc089d010



Testing patch on Linus tree.
