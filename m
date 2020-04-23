Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4A911B6540
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Apr 2020 22:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgDWULy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 16:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbgDWULx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 16:11:53 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CE0C09B043
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2020 13:11:53 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id j4so7834373qkc.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2020 13:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1sK+qxFujv0g2dAZROgh5iflimWMdXMefs+uVpP7wAM=;
        b=Ko1EZ7ws9tlfndp6mpyl/oj748jPWAY/NQzd6W+6dxgYp/Ki5lmwKbGwYUH4iAlLVK
         cL3RvLsT+EiM7j17tIEkn61VdBnLSBKVERljX/eaCGZ/xf4AUyaD/UH90CKsEQtly2Y4
         klPh7TPH0B+7PaJ6QGMy9MSAbSR4lJSOcjs0XQ9mh+yBQTtKMmdXZFAemcbH9Po7avwY
         k2H22ALkOxqHdphtwgYx1aaP2POayE6rcSVdkXpotGxNo3duWvoIRT+Nq2SbqqBbmcih
         pKz5H1zVBfl5mP8xp9rGMEsqwcFYlc5bXpnXK6yxOocqh62pdLVctMLq/C4orprHs4SM
         R7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1sK+qxFujv0g2dAZROgh5iflimWMdXMefs+uVpP7wAM=;
        b=PKtCNKMJJKletxQAN47cG+PlVeseglO2jrCjxYXOfBgiF2/yj8eUr7h8+UoB60xLC8
         HPAd6JI/Mn7/Tk5B7GsJYCSORnxsyhv+FLpV1bMueMHlb7J9QHfaumH7v1u4wRrYJ21Z
         6YKY4QSULgG8uN4ZOxhXAd/UCz9Zv7C9TccH+76GdsOBkG+KrrvcsHmuchYtqjhl31Fs
         Vs1l/ESUqV1XkGWjOEG5ff8jGe0PdnB6FiCOZ/oOYjRJQA9VSCHFkwJ83ATOPk+u2TJN
         3OFLczX1e72ZKTq/uBxkzF7rmHikhDQ3554KSN4KLaiAtxTghtVCYZ1wA6VCCSuT8I3Q
         2qVA==
X-Gm-Message-State: AGi0PubbuogHKZ6vipcXX5rUwPbXqdznm4Iq1hvFLyVxNf/xf8u6xSFQ
        EkmWYnFtzhmx4M0DIzdCdhXPJQ==
X-Google-Smtp-Source: APiQypJhTD2S0Ig0IKBSFmcOP+FRmyno0FVL2YSsNqRAW1vBjxVb5I07vinySNMOFmV88vqJunbtqg==
X-Received: by 2002:a37:617:: with SMTP id 23mr5708120qkg.11.1587672710582;
        Thu, 23 Apr 2020 13:11:50 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id k43sm2502387qtk.67.2020.04.23.13.11.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Apr 2020 13:11:49 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: out-of-bounds in pid_nr_ns() due to "proc: modernize proc to
 support multiple private instances"
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <06B50A1C-406F-4057-BFA8-3A7729EA7469@lca.pw>
Date:   Thu, 23 Apr 2020 16:11:48 -0400
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        linux-fsdevel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B818B796-3A09-46B9-B6CE-4EB047567755@lca.pw>
References: <06B50A1C-406F-4057-BFA8-3A7729EA7469@lca.pw>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Eric, Stephen, can you pull out this series while Alexey is getting to =
the bottom of this slab-out-of-bounds?

> On Apr 22, 2020, at 3:35 PM, Qian Cai <cai@lca.pw> wrote:
>=20
> Reverted the whole series from linux-next,
>=20
> 20d3928579da proc: use named enums for better readability
> e9fc842e1fb6 proc: use human-readable values for hidepid
> 3ef9b8afc054 docs: proc: add documentation for "hidepid=3D4" and =
"subset=3Dpid" options and new mount behavior
> f1031df957fa proc: add option to mount only a pids subset
> 9153c0921a1e proc: instantiate only pids that we can ptrace on =
'hidepid=3D4' mount option
> 1ef97cee07dd proc: allow to mount many instances of proc in one pid =
namespace
> 39f8e6256b4b proc: rename struct proc_fs_info to proc_fs_opts=20
>=20
> fixed out-of-bounds in pid_nr_ns() while reading proc files.
>=20
> =3D=3D=3D arm64 =3D=3D=3D
> [12140.366814] LTP: starting proc01 (proc01 -m 128)
> [12149.580943] =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [12149.589521] BUG: KASAN: out-of-bounds in pid_nr_ns+0x2c/0x90
> pid_nr_ns at kernel/pid.c:456
> [12149.595939] Read of size 4 at addr 1bff000bfa8c0388 by task =
proc01/50298
> [12149.603392] Pointer tag: [1b], memory tag: [fe]
>=20
> [12149.610906] CPU: 69 PID: 50298 Comm: proc01 Tainted: G             =
L    5.7.0-rc2-next-20200422 #6
> [12149.620585] Hardware name: HPE Apollo 70             /C01_APACHE_MB =
        , BIOS L50_5.13_1.11 06/18/2019
> [12149.631074] Call trace:
> [12149.634304]  dump_backtrace+0x0/0x22c
> [12149.638745]  show_stack+0x28/0x34
> [12149.642839]  dump_stack+0x104/0x194
> [12149.647110]  print_address_description+0x70/0x3a4
> [12149.652576]  __kasan_report+0x188/0x238
> [12149.657169]  kasan_report+0x3c/0x58
> [12149.661430]  check_memory_region+0x98/0xa0
> [12149.666303]  __hwasan_load4_noabort+0x18/0x20
> [12149.671431]  pid_nr_ns+0x2c/0x90
> [12149.675446]  locks_translate_pid+0xf4/0x1a0
> [12149.680382]  locks_show+0x68/0x110
> [12149.684536]  seq_read+0x380/0x930
> [12149.688604]  pde_read+0x5c/0x78
> [12149.692498]  proc_reg_read+0x74/0xc0
> [12149.696813]  __vfs_read+0x84/0x1d0
> [12149.700939]  vfs_read+0xec/0x124
> [12149.704889]  ksys_read+0xb0/0x120
> [12149.708927]  __arm64_sys_read+0x54/0x88
> [12149.713485]  do_el0_svc+0x128/0x1dc
> [12149.717697]  el0_sync_handler+0x150/0x250
> [12149.722428]  el0_sync+0x164/0x180
>=20
> [12149.728672] Allocated by task 1:
> [12149.732624]  __kasan_kmalloc+0x124/0x188
> [12149.737269]  kasan_kmalloc+0x10/0x18
> [12149.741568]  kmem_cache_alloc_trace+0x2e4/0x3d4
> [12149.746820]  proc_fill_super+0x48/0x1fc
> [12149.751377]  vfs_get_super+0xcc/0x170
> [12149.755760]  get_tree_nodev+0x28/0x34
> [12149.760143]  proc_get_tree+0x24/0x30
> [12149.764439]  vfs_get_tree+0x54/0x158
> [12149.768736]  do_mount+0x80c/0xaf0
> [12149.772774]  __arm64_sys_mount+0xe0/0x18c
> [12149.777504]  do_el0_svc+0x128/0x1dc
> [12149.781715]  el0_sync_handler+0x150/0x250
> [12149.786445]  el0_sync+0x164/0x180
>=20
> [12149.792687] Freed by task 0:
> [12149.796285] (stack is not available)
>=20
> [12149.802792] The buggy address belongs to the object at =
ffff000bfa8c0300
>                which belongs to the cache kmalloc-128 of size 128
> [12149.816727] The buggy address is located 8 bytes to the right of
>                128-byte region [ffff000bfa8c0300, ffff000bfa8c0380)
> [12149.830223] The buggy address belongs to the page:
> [12149.835740] page:ffffffe002dea300 refcount:1 mapcount:0 =
mapping:0000000037c9e9b5 index:0x31ff000bfa8c9e00
> [12149.846027] flags: 0x5ffffffe000200(slab)
> [12149.850765] raw: 005ffffffe000200 ffffffe022175788 ffffffe02215b788 =
17ff0087a0020480
> [12149.859232] raw: 31ff000bfa8c9e00 0000000000660065 00000001ffffffff =
0000000000000000
> [12149.867693] page dumped because: kasan: bad access detected
> [12149.873984] page_owner tracks the page as allocated
> [12149.879585] page last allocated via order 0, migratetype Unmovable, =
gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY)
> [12149.891438]  post_alloc_hook+0x94/0xd4
> [12149.895908]  prep_new_page+0x34/0xcc
> [12149.900206]  get_page_from_freelist+0x4c4/0x60c
> [12149.905458]  __alloc_pages_nodemask+0x1c0/0x2e8
> [12149.910712]  alloc_page_interleave+0x38/0x18c
> [12149.915791]  alloc_pages_current+0x80/0xe0
> [12149.920610]  alloc_slab_page+0x154/0x3b4
> [12149.925254]  new_slab+0xc8/0x5f4
> [12149.929203]  ___slab_alloc+0x248/0x440
> [12149.933675]  kmem_cache_alloc_trace+0x368/0x3d4
> [12149.938928]  ftrace_free_mem+0x258/0x7ac
> [12149.943575]  ftrace_free_init_mem+0x20/0x28
> [12149.948482]  kernel_init+0x1c/0x204
> [12149.952692]  ret_from_fork+0x10/0x18
> [12149.956986] page_owner free stack trace missing
>=20
> [12149.964443] Memory state around the buggy address:
> [12149.969956]  ffff000bfa8c0100: fe fe fe fe fe fe fe fe fe fe fe fe =
fe fe fe fe
> [12149.977899]  ffff000bfa8c0200: fe fe fe fe fe fe fe fe fe fe fe fe =
fe fe fe fe
> [12149.985841] >ffff000bfa8c0300: 1b 1b 1b fe fe fe fe fe fe fe fe fe =
fe fe fe fe
> [12149.993781]                                            ^
> [12149.999814]  ffff000bfa8c0400: fe fe fe fe fe fe fe fe fe fe fe fe =
fe fe fe fe
> [12150.007757]  ffff000bfa8c0500: fe fe fe fe fe fe fe fe 6c 6c 6c 6c =
6c 6c 6c 6c
> [12150.015697] =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [12150.023638] Disabling lock debugging due to kernel taint
>=20
> =3D=3D=3D s390 =3D=3D=3D
> [14452.527006] LTP: starting proc01 (proc01 -m 128)
> [14455.663026] =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [14455.664078] BUG: KASAN: slab-out-of-bounds in pid_nr_ns+0x34/0xa8
> [14455.664120] Read of size 4 at addr 000000000dabacc8 by task =
proc01/41628
>=20
> [14455.664205] CPU: 1 PID: 41628 Comm: proc01 Not tainted =
5.7.0-rc2-next-20200422 #2
> [14455.664248] Hardware name: IBM 2964 N96 400 (z/VM 6.4.0)
> [14455.664288] Call Trace:
> [14455.664335]  [<00000000084be28a>] show_stack+0x11a/0x1c8=20
> [14455.664382]  [<0000000008b147f4>] dump_stack+0x134/0x180=20
> [14455.664434]  [<00000000088b56c4>] =
print_address_description.isra.9+0x5c/0x3e8=20
> [14455.664480]  [<00000000088b5cac>] __kasan_report+0x114/0x140=20
> [14455.664523]  [<00000000088b4bf4>] kasan_report+0x4c/0x58=20
> [14455.666150]  [<0000000008532a24>] pid_nr_ns+0x34/0xa8=20
> [14455.666203]  [<00000000089ee806>] locks_translate_pid+0xee/0x1c8=20
> [14455.666246]  [<00000000089eeea4>] locks_show+0x84/0x130=20
> [14455.666295]  [<0000000008958c3e>] seq_read+0x25e/0x7f0=20
> [14455.666343]  [<0000000008a14e70>] proc_reg_read+0x100/0x168=20
> [14455.666389]  [<000000000890fa22>] vfs_read+0x92/0x150=20
> [14455.666432]  [<000000000890feda>] ksys_read+0xe2/0x188=20
> [14455.666483]  [<0000000008e671d0>] system_call+0xd8/0x2b4=20
> [14455.666525] 5 locks held by proc01/41628:
> [14455.666562]  #0: 000000003e0e0c10 (&p->lock){+.+.}-{3:3}, at: =
seq_read+0x5e/0x7f0
> [14455.666630]  #1: 00000000095deff0 (file_rwsem){++++}-{0:0}, at: =
locks_start+0x66/0x98
> [14455.666695]  #2: 00000000095deed8 (blocked_lock_lock){+.+.}-{2:2}, =
at: locks_start+0x72/0x98
> [14455.673879]  #3: 0000000009393b60 (rcu_read_lock){....}-{1:2}, at: =
locks_translate_pid+0x5e/0x1c8
> [14455.673967]  #4: 00000000095367d0 (report_lock){....}-{2:2}, at: =
__kasan_report+0x6e/0x140
>=20
> [14455.674077] Allocated by task 1:
> [14455.674128]  stack_trace_save+0xba/0xd0
> [14455.674169]  save_stack+0x30/0x58
> [14455.674211]  __kasan_kmalloc.isra.19+0xd4/0xe8
> [14455.674253]  kmem_cache_alloc_trace+0x246/0x390
> [14455.674296]  proc_fill_super+0x60/0x2e0
> [14455.674339]  vfs_get_super+0x10a/0x1a8
> [14455.674379]  vfs_get_tree+0x5e/0x158
> [14455.674424]  do_mount+0xbd2/0xe28
> [14455.674465]  __s390x_sys_mount+0xe2/0xf8
> [14455.674509]  system_call+0xd8/0x2b4
>=20
> [14455.674582] Freed by task 1:
> [14455.674622]  stack_trace_save+0xba/0xd0
> [14455.674663]  save_stack+0x30/0x58
> [14455.674704]  __kasan_slab_free+0x130/0x198
> [14455.674745]  slab_free_freelist_hook+0x7a/0x240
> [14455.674786]  kfree+0x10a/0x508
> [14455.674831]  __kthread_create_on_node+0x206/0x2f0
> [14455.674873]  kthread_create_on_node+0xa0/0xb8
> [14455.674915]  init_rescuer.part.13+0x66/0xf8
> [14455.674966]  workqueue_init+0x40e/0x658
> [14455.675010]  kernel_init_freeable+0x21e/0x590
> [14455.675056]  kernel_init+0x22/0x180
> [14455.675096]  ret_from_fork+0x30/0x34
>=20
> [14455.675296] The buggy address belongs to the object at =
000000000dabac40
>                which belongs to the cache kmalloc-64 of size 64
> [14455.675345] The buggy address is located 72 bytes to the right of
>                64-byte region [000000000dabac40, 000000000dabac80)
> [14455.675391] The buggy address belongs to the page:
> [14455.675441] page:000003d08036ae80 refcount:1 mapcount:0 =
mapping:00000000c06a91d7 index:0xdabae40
> [14455.675489] flags: 0x1fffe00000000200(slab)
> [14455.675536] raw: 1fffe00000000200 000003d0817ad788 000003d080c04908 =
000000000ff8c600
> [14455.675582] raw: 000000000dabae40 0006001000000000 ffffffff00000001 =
0000000000000000
> [14455.675624] page dumped because: kasan: bad access detected
> [14455.675666] page_owner tracks the page as allocated
> [14455.675707] page last allocated via order 0, migratetype Unmovable, =
gfp_mask 0x0()
> [14455.675753]  stack_trace_save+0xba/0xd0
> [14455.675797]  register_early_stack+0x8c/0xb8
> [14455.675840]  init_page_owner+0x60/0x510
> [14455.675881]  kernel_init_freeable+0x278/0x590
> [14455.675919] page_owner free stack trace missing
>=20
> [14455.675993] Memory state around the buggy address:
> [14455.676034]  000000000dabab80: fc fc fc fc fc fc fc fc fc fc fc fc =
fc fc fc fc
> [14455.676078]  000000000dabac00: fc fc fc fc fc fc fc fc 00 00 00 00 =
00 fc fc fc
> [14455.676122] >000000000dabac80: fc fc fc fc fc fc fc fc fc fc fc fc =
fc fc fc fc
> [14455.676171]                                               ^
> [14455.676213]  000000000dabad00: fc fc fc fc fc fc fc fc fc fc fc fc =
fc fc fc fc
> [14455.676257]  000000000dabad80: fc fc fc fc fc fc fc fc fc fc fc fc =
fc fc fc fc
> [14455.676299] =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [14455.676339] Disabling lock debugging due to kernel taint
>=20
>=20

