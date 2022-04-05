Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE3D4F3F45
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Apr 2022 22:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383117AbiDENey (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Apr 2022 09:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352148AbiDENGx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Apr 2022 09:06:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F9961207C7
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 Apr 2022 05:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649160477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2NKiehv/Co5bt419nNf0mcIFukM3Fg2JF0N41MODlOQ=;
        b=heNoR/Qdt4U7xxAbbbDyOI9LecvMYYvnGdx5xvpfuG2ladD7/4atCr8j4FMzhw19vy8ice
        Z219AgPiurwbDxG5YF7h8D4x2lHf9F++zYgFQQvvto8DVJwGm36UbEbYotDXtmBMlY9AF6
        /q54PnC1pTqY8z7ec6i7yAkYgBWlJbQ=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-323-kzNiuqITNAaYHPr65sNsig-1; Tue, 05 Apr 2022 08:07:56 -0400
X-MC-Unique: kzNiuqITNAaYHPr65sNsig-1
Received: by mail-lf1-f72.google.com with SMTP id n2-20020a0565120ac200b0044a2c76f7e1so4958338lfu.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Apr 2022 05:07:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2NKiehv/Co5bt419nNf0mcIFukM3Fg2JF0N41MODlOQ=;
        b=M0ZM0AeSpHJtb4a2N3pBZw6xfJfJkUSC5KgnIFTpv7dzkPY7LeJIu9flS+GWvALwit
         5/bp0nerayrqgDijgLNo5QcIadGv6zTaNKZF7aU/qV2nt6hFD8ZUMXHBqZ2WXrCR+a5y
         5VXfRwx9WumZP3EMrx04rFpVrcYCdG+0LffcZLQF2/g/qIyx/LgOkUfsTYprcHCqMP1C
         7B9uA0cVDlqSjPyLVJkEqkLzbVTViBwsA9y9zEkBD9CfRzJ32aSCKFmYOvfcI6hAT/To
         x/0CQwq0J40wmtVu0WtOIbpG+KiDLIgNJgNNlqYBCDLH0/aVXGR7lDwhqofNo72NLs9D
         9q9A==
X-Gm-Message-State: AOAM530Sn899QpNdUAtk/FPQOUAUro1tJuGTukyc7UgtGNj3apUjlTiB
        sAy8YuONBWYEfeDMKNkqlkVwz6FGKzelrXMvoLe8tZt+1wBUaMbmPdIOPs9aeFELt4UNUoHrfGg
        thk1wHcj1NApShgWhWAMlk/bAr+eCJFEQzl9tGx+niA==
X-Received: by 2002:a05:6512:158d:b0:44a:6522:f98f with SMTP id bp13-20020a056512158d00b0044a6522f98fmr2402316lfb.608.1649160474343;
        Tue, 05 Apr 2022 05:07:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwjoLcTXSL8ErcAg3XnAs/0Fc7ciUNkXGA1aH9WxteZuDXAnYflDglF08bPAFLnIch1Wmmc8kz+g64pQocdrQY=
X-Received: by 2002:a05:6512:158d:b0:44a:6522:f98f with SMTP id
 bp13-20020a056512158d00b0044a6522f98fmr2402307lfb.608.1649160474077; Tue, 05
 Apr 2022 05:07:54 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000007564ac05db72ff58@google.com>
In-Reply-To: <0000000000007564ac05db72ff58@google.com>
From:   Bruno Goncalves <bgoncalv@redhat.com>
Date:   Tue, 5 Apr 2022 14:07:43 +0200
Message-ID: <CA+QYu4oxrDPAA-BJgJzZ=fAHNEfBGB_80jt2Pwj21B3D2H8AFQ@mail.gmail.com>
Subject: Re: [syzbot] BUG: scheduling while atomic in simple_recursive_removal
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-fsdevel@vger.kernel.org,
        syzbot <syzbot+2778a29e60b4982065a0@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        CKI Project <cki-project@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 30, 2022 at 7:39 PM syzbot
<syzbot+2778a29e60b4982065a0@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    d888c83fcec7 fs: fix fd table size alignment properly
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=103e7b53700000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=cadd7063134e07bc
> dashboard link: https://syzkaller.appspot.com/bug?extid=2778a29e60b4982065a0
> compiler:       aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: arm64
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+2778a29e60b4982065a0@syzkaller.appspotmail.com
>
> BUG: scheduling while atomic: syz-executor.0/2197/0x00000101
> Modules linked in:
> CPU: 0 PID: 2197 Comm: syz-executor.0 Not tainted 5.17.0-syzkaller-13034-gd888c83fcec7 #0
> Hardware name: linux,dummy-virt (DT)
> Call trace:
>  dump_backtrace.part.0+0xcc/0xe0 arch/arm64/kernel/stacktrace.c:184
>  dump_backtrace arch/arm64/kernel/stacktrace.c:190 [inline]
>  show_stack+0x18/0x6c arch/arm64/kernel/stacktrace.c:191
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x68/0x84 lib/dump_stack.c:106
>  dump_stack+0x18/0x34 lib/dump_stack.c:113
>  __schedule_bug+0x60/0x80 kernel/sched/core.c:5617
>  schedule_debug kernel/sched/core.c:5644 [inline]
>  __schedule+0x74c/0x7f0 kernel/sched/core.c:6273
>  schedule+0x54/0xd0 kernel/sched/core.c:6454
>  rwsem_down_write_slowpath+0x29c/0x5a0 kernel/locking/rwsem.c:1142
>  __down_write_common kernel/locking/rwsem.c:1259 [inline]
>  __down_write_common kernel/locking/rwsem.c:1256 [inline]
>  __down_write kernel/locking/rwsem.c:1268 [inline]
>  down_write+0x58/0x64 kernel/locking/rwsem.c:1515
>  inode_lock include/linux/fs.h:777 [inline]
>  simple_recursive_removal+0x124/0x270 fs/libfs.c:288
>  debugfs_remove fs/debugfs/inode.c:742 [inline]
>  debugfs_remove+0x5c/0x80 fs/debugfs/inode.c:736
>  blk_release_queue+0x7c/0xf0 block/blk-sysfs.c:784
>  kobject_cleanup lib/kobject.c:705 [inline]
>  kobject_release lib/kobject.c:736 [inline]
>  kref_put include/linux/kref.h:65 [inline]
>  kobject_put+0x98/0x114 lib/kobject.c:753
>  blk_put_queue+0x14/0x20 block/blk-core.c:270
>  blkg_free.part.0+0x54/0x80 block/blk-cgroup.c:86
>  blkg_free block/blk-cgroup.c:78 [inline]
>  __blkg_release+0x44/0x70 block/blk-cgroup.c:102
>  rcu_do_batch kernel/rcu/tree.c:2535 [inline]
>  rcu_core+0x324/0x590 kernel/rcu/tree.c:2786
>  rcu_core_si+0x10/0x20 kernel/rcu/tree.c:2803
>  _stext+0x124/0x2a0
>  do_softirq_own_stack include/asm-generic/softirq_stack.h:10 [inline]
>  invoke_softirq kernel/softirq.c:439 [inline]
>  __irq_exit_rcu+0xe4/0x100 kernel/softirq.c:637
>  irq_exit_rcu+0x10/0x1c kernel/softirq.c:649
>  __el1_irq arch/arm64/kernel/entry-common.c:459 [inline]
>  el1_interrupt+0x38/0x64 arch/arm64/kernel/entry-common.c:473
>  el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:478
>  el1h_64_irq+0x64/0x68 arch/arm64/kernel/entry.S:577
>  walk_stackframe arch/arm64/kernel/stacktrace.c:153 [inline]
>  arch_stack_walk+0x68/0x280 arch/arm64/kernel/stacktrace.c:211
>  stack_trace_save+0x50/0x80 kernel/stacktrace.c:122
>  kasan_save_stack+0x2c/0x5c mm/kasan/common.c:38
>  kasan_set_track mm/kasan/common.c:45 [inline]
>  set_alloc_info mm/kasan/common.c:436 [inline]
>  ____kasan_kmalloc mm/kasan/common.c:515 [inline]
>  ____kasan_kmalloc mm/kasan/common.c:474 [inline]
>  __kasan_kmalloc+0xb0/0xd0 mm/kasan/common.c:524
>  kasan_kmalloc include/linux/kasan.h:234 [inline]
>  kmem_cache_alloc_node_trace include/linux/slab.h:488 [inline]
>  kmalloc_node include/linux/slab.h:599 [inline]
>  kzalloc_node include/linux/slab.h:725 [inline]
>  __get_vm_area_node.constprop.0+0xf8/0x224 mm/vmalloc.c:2459
>  __vmalloc_node_range+0xa4/0x5c0 mm/vmalloc.c:3132
>  __vmalloc_node mm/vmalloc.c:3237 [inline]
>  vzalloc+0x74/0x90 mm/vmalloc.c:3307
>  do_ip6t_get_ctl+0x290/0x4d0 net/ipv6/netfilter/ip6_tables.c:817
>  nf_getsockopt+0x60/0x8c net/netfilter/nf_sockopt.c:116
>  ipv6_getsockopt+0x140/0x1c4 net/ipv6/ipv6_sockglue.c:1504
>  tcp_getsockopt+0x20/0x50 net/ipv4/tcp.c:4295
>  sock_common_getsockopt+0x1c/0x30 net/core/sock.c:3478
>  __sys_getsockopt+0xa4/0x214 net/socket.c:2224
>  __do_sys_getsockopt net/socket.c:2239 [inline]
>  __se_sys_getsockopt net/socket.c:2236 [inline]
>  __arm64_sys_getsockopt+0x28/0x3c net/socket.c:2236
>  __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
>  invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
>  el0_svc_common.constprop.0+0x44/0xec arch/arm64/kernel/syscall.c:142
>  do_el0_svc+0x6c/0x84 arch/arm64/kernel/syscall.c:181
>  el0_svc+0x44/0xb0 arch/arm64/kernel/entry-common.c:616
>  el0t_64_sync_handler+0x1a4/0x1b0 arch/arm64/kernel/entry-common.c:634
>  el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:581
>

We also seem to hit the same issue. We've hit this during stress-ng
with os stressor:

[ 8221.964778] loop27622: detected capacity change from 0 to 4096
[ 8221.974106] loop66401: detected capacity change from 4096 to 8192
[ 8221.979364] BUG: scheduling while atomic: swapper/18/0/0x00000100
[ 8222.006062] restraintd[2388]: [ 8223.957654] Modules linked in:
binfmt_misc dm_cache_smq dm_cache raid1 dm_raid raid456
async_raid6_recov async_memcpy async_pq async_xor async_tx
dm_thin_pool dm_persistent_data dm_bio_prison nf_conntrack_netlink
xt_addrtype xt_nat xt_mark xt_comment nft_chain_nat xt_MASQUERADE
nf_nat veth bridge stp llc wp512 streebog_generic rmd160
nhpoly1305_neon nhpoly1305 libpoly1305 michael_mic md4 crc32_generic
twofish_generic twofish_common serpent_generic fcrypt des_generic
libdes cast6_generic cast5_generic cast_common camellia_generic
blowfish_generic blowfish_common aegis128 vsock_loopback
vmw_vsock_virtio_transport_common vsock loop tun af_key crypto_user
scsi_transport_iscsi xt_multiport ip_gre ip_tunnel gre overlay
xt_CONNSECMARK xt_SECMARK xt_conntrack nft_compat ah6 ah4 nft_objref
nft_ct nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables nfnetlink
ip_tables jfs sctp ip6_udp_tunnel udp_tunnel ipmi_watchdog
ipmi_poweroff mlx5_ib ib_uverbs ib_core rfkill sunrpc i2c_smbus joydev
mlx5_core
*** Current Time: Fri Apr 01 19:[ 8223.957775]  psample mlxfw tls
acpi_ipmi ipmi_ssif ipmi_devintf ipmi_msghandler thunderx2_pmu vfat
fat fuse zram xfs nouveau drm_dp_helper ast cec drm_vram_helper
crct10dif_ce drm_kms_helper ghash_ce uas sysimgblt syscopyarea
sysfillrect fb_sys_fops drm_ttm_helper ttm drm usb_storage
i2c_algo_bit gpio_xlp i2c_xlp9xx [last unloaded: dm_persistent_data]
38:37 2022  Localwatchdog at: Fr[ 8224.081739] CPU: 18 PID: 0 Comm:
swapper/18 Tainted: G           OE     5.17.0 #1
i Apr 01 20:28:36 2022
[ 8224.091972] Hardware name: HPE Apollo 70             /C01_APACHE_MB
        , BIOS L50_5.13_1.11 06/18/2019
[ 8224.103779] Call trace:
[ 8224.106213]  dump_backtrace+0xfc/0x14c
[ 8224.109956]  show_stack+0x24/0x68
[ 8224.113259]  dump_stack_lvl+0x64/0x7c
[ 8224.116911]  dump_stack+0x18/0x38
[ 8224.120213]  __schedule_bug+0x68/0x84
[ 8224.123867]  schedule_debug+0x9c/0x134
[ 8224.127606]  __schedule+0x58/0x66c
[ 8224.130998]  schedule+0x70/0xa8
[ 8224.134128]  rwsem_down_write_slowpath+0x2ac/0x744
[ 8224.138908]  down_write+0x50/0x80
[ 8224.142212]  simple_recursive_removal+0xe4/0x1cc
[ 8224.146821]  debugfs_remove+0x64/0x84
[ 8224.150473]  blk_release_queue+0x90/0xf0
[ 8224.154388]  kobject_cleanup+0x74/0x1cc
[ 8224.158215]  kobject_put+0x5c/0x98
[ 8224.161604]  blk_put_queue+0x20/0x2c
[ 8224.165169]  blkg_free+0xc0/0xe8
[ 8224.168386]  __blkg_release+0x98/0x140
[ 8224.172123]  rcu_do_batch+0x1d4/0x4a4
[ 8224.175776]  rcu_core+0x100/0x2fc
[ 8224.179080]  rcu_core_si+0x1c/0x28
[ 8224.182470]  __do_softirq+0xe8/0x344
[ 8224.186034]  irq_exit_rcu+0xa4/0x144
[ 8224.189600]  el1_interrupt+0x94/0xb0
[ 8224.193163]  el1h_64_irq_handler+0x18/0x24
[ 8224.197247]  el1h_64_irq+0x68/0x6c
[ 8224.200637]  arch_local_irq_enable+0xc/0x18
[ 8224.204809]  default_idle_call+0x44/0x100
[ 8224.208807]  do_idle+0xfc/0x278
[ 8224.211938]  cpu_startup_entry+0x30/0x34
[ 8224.215849]  secondary_start_kernel+0x19c/0x1d0
[ 8224.220369]  __secondary_switched+0xa0/0xa4
[ 8224.224586] softirq: huh, entered softirq 9 RCU 00000000a642db6f
with preempt_count 00000100, exited with 00000000?

test logs: https://datawarehouse.cki-project.org/kcidb/tests/3036710
CKI issue tracker: https://datawarehouse.cki-project.org/issue/1096

Thanks,
Bruno Goncalves

>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>

