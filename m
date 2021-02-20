Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33B9332066D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Feb 2021 18:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbhBTRaG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Feb 2021 12:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhBTRaC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Feb 2021 12:30:02 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437DDC061574;
        Sat, 20 Feb 2021 09:29:22 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id s12so3549378qvq.4;
        Sat, 20 Feb 2021 09:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=oUvkJIwipf07eTB/cGa7wgcvxPluMo6ja0M9ibBZ2nY=;
        b=sWzSDqefXSBv2PKh69W7QPe4IMQs/kjvMxqE1LHHp8TyPf8UQ01Dz+njQq81+7UAwb
         fnpFVYJBeI4O/NeIQvHHiCR3pDLq+cFzOdXxxI6CnxGWeAE3uvk5zwsYaucil1XCdrQg
         G8hhB+SHHIT4/2VQCKW9KQ/4n1g9KM9Bg1dHvCLJnsftjRUbjJkRqiQr6yoWkB0W5mRC
         84xSv1xloPn/Xs+2kGO4oHvTZqGvfWwIdRKHTItSlxDOjrk8FNzM3g+tI801kZyiygf0
         TUZ3QimvBAE+1hC7C6vRF1EkKTBgsBXdJoQcO3BD16b1PNGJgd03dKtoRTKk4R/GCLMY
         gIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=oUvkJIwipf07eTB/cGa7wgcvxPluMo6ja0M9ibBZ2nY=;
        b=aleW/3VJY7UW/F2wztZGBsrIMlO6Q2ked7U2N7LdB70bfEryUCDJHcMNU2VZCJrBxz
         FfnpXwjt1cOpu5SXTrbbwocgVKx2AnOU2iP4IyCwzyx1kAufJk5dhyiCHiuDmh04CiN2
         9PeXLc3UB7hoLWswSUaCQ9Aa17JtQa/Ru265EgQ0PRPmpGmF9vpFlwHRbmKdEqzETGaG
         ofFVv5BhZSLoyYJi0fkD7wzDfPP6CqB+4yO4RCbVRRvQKOaH6UlhvGN3y3sWEVP9GsZb
         YztYdjBAo9f1MgleZHjKpzB7kWZaBHjrPwfOGY8pCiu6MiXyb4YwMlybC6WzyzNnqFra
         AZfw==
X-Gm-Message-State: AOAM533ad8bqh/QAgKMGYP8qx7ED2oOKK1gaf/GZEWFLR8dxfgMKQE5/
        xYC8FNkZA9Px5yXlEDjSPqg6QSi8C6DaUw==
X-Google-Smtp-Source: ABdhPJykg9+X7rltvGmgsb8yLOp0mIptBkYPH1A6ee4j2KpEV+k6nH8J6URfxYztSxrGNO2T+THQbw==
X-Received: by 2002:a0c:b912:: with SMTP id u18mr14411420qvf.2.1613842160781;
        Sat, 20 Feb 2021 09:29:20 -0800 (PST)
Received: from ?IPv6:2601:153:900:7730:b0d5:ad61:dfc0:1d2b? ([2601:153:900:7730:b0d5:ad61:dfc0:1d2b])
        by smtp.gmail.com with ESMTPSA id t19sm8655083qke.109.2021.02.20.09.29.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Feb 2021 09:29:20 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
Subject: [BUG] page allocation failure reading procfs ipv6 configuration files
 with cgroups
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Message-ID: <d2d3e617-17bf-8d43-f4a2-e4a7a2d421bd@gmail.com>
Date:   Sat, 20 Feb 2021 12:29:18 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Good Afternoon,

I have been tracking down a regular bug that triggers when running OpenWRT in a lxd container.
Every ten minutes I was greeted with the following splat in the kernel log:

[2122311.383389] warn_alloc: 3 callbacks suppressed
[2122311.383403] cat: page allocation failure: order:5, mode:0x40dc0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO), nodemask=(null),cpuset=lxc.payload.openwrt,mems_allowed=0
[2122311.383439] CPU: 0 PID: 2034240 Comm: cat Tainted: G         C        5.10.2 #80
[2122311.383444] Hardware name: pine64 rockpro64_rk3399/rockpro64_rk3399, BIOS 2020.07-rc2-00124-g515f613253-dirty 05/19/2020
[2122311.383449] Call trace:
[2122311.383464]  dump_backtrace+0x0/0x200
[2122311.383469]  show_stack+0x20/0x68
[2122311.383479]  dump_stack+0xd0/0x12c
[2122311.383488]  warn_alloc+0x100/0x170
[2122311.383494]  __alloc_pages_slowpath.constprop.0+0xb14/0xb38
[2122311.383499]  __alloc_pages_nodemask+0x2b4/0x320
[2122311.383505]  alloc_pages_current+0x90/0x108
[2122311.383511]  kmalloc_order+0x38/0xb0
[2122311.383516]  kmalloc_order_trace+0x34/0x120
[2122311.383524]  __kmalloc+0x29c/0x2f0
[2122311.383531]  proc_sys_call_handler+0xc4/0x250
[2122311.383536]  proc_sys_read+0x1c/0x28
[2122311.383542]  generic_file_splice_read+0xd8/0x190
[2122311.383547]  do_splice_to+0x7c/0xd8
[2122311.383551]  splice_direct_to_actor+0xdc/0x260
[2122311.383556]  do_splice_direct+0x94/0xf8
[2122311.383563]  do_sendfile+0x1a4/0x400
[2122311.383568]  __arm64_sys_sendfile64+0x28c/0x350
[2122311.383576]  el0_svc_common.constprop.0+0x88/0x228
[2122311.383581]  do_el0_svc+0x2c/0x98
[2122311.383588]  el0_svc+0x28/0x68
[2122311.383593]  el0_sync_handler+0xb0/0xb8
[2122311.383598]  el0_sync+0x178/0x180
[2122311.383602] Mem-Info:
[2122311.383618] active_anon:262759 inactive_anon:143768 isolated_anon:0
                   active_file:156164 inactive_file:137753 isolated_file:0
                   unevictable:486 dirty:2 writeback:0
                   slab_reclaimable:30820 slab_unreclaimable:58730
                   mapped:41684 shmem:9443 pagetables:6742 bounce:0
                   free:34573 free_pcp:0 free_cma:194
[2122311.383630] Node 0 active_anon:1051036kB inactive_anon:575072kB active_file:624656kB inactive_file:551012kB unevictable:1944kB isolated(anon):0kB isolated(file):0kB mapped:166736kB dirty:8kB writeback:0kB shmem:37772kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:15024kB all_unreclaimable? no
[2122311.383634] Node 0 DMA free:78096kB min:16520kB low:20648kB high:24776kB reserved_highatomic:0KB active_anon:77640kB inactive_anon:133256kB active_file:189636kB inactive_file:214892kB unevictable:0kB writepending:8kB present:1046528kB managed:980856kB mlocked:0kB pagetables:11656kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[2122311.383647] lowmem_reserve[]: 0 2807 2807 2807 2807
[2122311.383661] Node 0 DMA32 free:60196kB min:49012kB low:61264kB high:73516kB reserved_highatomic:2048KB active_anon:973908kB inactive_anon:441424kB active_file:435020kB inactive_file:336944kB unevictable:1944kB writepending:0kB present:3014656kB managed:2909548kB mlocked:1944kB pagetables:15312kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:776kB
[2122311.383674] lowmem_reserve[]: 0 0 0 0 0
[2122311.383686] Node 0 DMA: 11101*4kB (UME) 2018*8kB (UME) 870*16kB (UME) 164*32kB (UME) 1*64kB (M) 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 79780kB
[2122311.383727] Node 0 DMA32: 4154*4kB (UMEHC) 2362*8kB (UMEHC) 960*16kB (UMEH) 270*32kB (UMEHC) 31*64kB (UMEH) 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 61496kB
[2122311.383768] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
[2122311.383773] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=32768kB
[2122311.383778] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
[2122311.383782] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=64kB
[2122311.383785] 403727 total pagecache pages
[2122311.383798] 102940 pages in swap cache
[2122311.383802] Swap cache stats: add 5089297, delete 4986508, find 5716104/7056293
[2122311.383805] Free swap  = 1700864kB
[2122311.383808] Total swap = 3145720kB
[2122311.383812] 1015296 pages RAM
[2122311.383814] 0 pages HighMem/MovableOnly
[2122311.383817] 42695 pages reserved
[2122311.383820] 8192 pages cma reserved
[2122311.383823] 0 pages hwpoisoned

I traced all occurrences of 'cat' and found it occurs occasionally when the dhcpv6.script attempts to read the hop limit from /proc/sys/net/ipv6/conf/$device/hop_limit
It does not occur every time, but I managed to recreate it in the host as well:
root@rockpro64:/proc/sys/net/ipv6/conf# ll
total 0
dr-xr-xr-x 1 root root 0 Feb 20 17:06 ./
dr-xr-xr-x 1 root root 0 Feb 20 17:03 ../
dr-xr-xr-x 1 root root 0 Feb 20 17:06 all/
dr-xr-xr-x 1 root root 0 Feb 20 17:06 br0/
dr-xr-xr-x 1 root root 0 Feb 20 17:06 br0.2/
dr-xr-xr-x 1 root root 0 Feb 20 17:06 default/
dr-xr-xr-x 1 root root 0 Feb 20 17:06 docker0/
dr-xr-xr-x 1 root root 0 Feb 20 17:06 enp1s0f0/
dr-xr-xr-x 1 root root 0 Feb 20 17:06 eth0/
dr-xr-xr-x 1 root root 0 Feb 20 17:06 hassio/
dr-xr-xr-x 1 root root 0 Feb 20 17:06 lo/
dr-xr-xr-x 1 root root 0 Feb 20 17:06 veth7c4bb33/
dr-xr-xr-x 1 root root 0 Feb 20 17:06 veth94a6886/
dr-xr-xr-x 1 root root 0 Feb 20 17:06 vethab10823/
dr-xr-xr-x 1 root root 0 Feb 20 17:06 vethaba55d8/
dr-xr-xr-x 1 root root 0 Feb 20 17:06 vethbcf740c/
dr-xr-xr-x 1 root root 0 Feb 20 17:06 vethc3d714d2/
dr-xr-xr-x 1 root root 0 Feb 20 17:06 vethdc02ce8/
dr-xr-xr-x 1 root root 0 Feb 20 17:06 virbr0/
dr-xr-xr-x 1 root root 0 Feb 20 17:06 virbr0-nic/
root@rockpro64:/proc/sys/net/ipv6/conf# cat */hop_limit
cat: all/hop_limit: Cannot allocate memory
cat: br0.2/hop_limit: Cannot allocate memory
cat: br0/hop_limit: Cannot allocate memory
cat: default/hop_limit: Cannot allocate memory
64
64
64
64
64
64
64
64
64
64
64
64
64
64

[2121803.239645] cat: page allocation failure: order:6, mode:0x40dc0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO), nodemask=(null),cpuset=/,mems_allowed=0
[2121803.239679] CPU: 2 PID: 2029652 Comm: cat Tainted: G         C        5.10.2 #80
[2121803.239683] Hardware name: pine64 rockpro64_rk3399/rockpro64_rk3399, BIOS 2020.07-rc2-00124-g515f613253-dirty 05/19/2020
[2121803.239688] Call trace:
[2121803.239700]  dump_backtrace+0x0/0x200
[2121803.239706]  show_stack+0x20/0x68
[2121803.239714]  dump_stack+0xd0/0x12c
[2121803.239721]  warn_alloc+0x100/0x170
[2121803.239727]  __alloc_pages_slowpath.constprop.0+0xb14/0xb38
[2121803.239732]  __alloc_pages_nodemask+0x2b4/0x320
[2121803.239737]  alloc_pages_current+0x90/0x108
[2121803.239744]  kmalloc_order+0x38/0xb0
[2121803.239748]  kmalloc_order_trace+0x34/0x120
[2121803.239755]  __kmalloc+0x29c/0x2f0
[2121803.239762]  proc_sys_call_handler+0xc4/0x250
[2121803.239766]  proc_sys_read+0x1c/0x28
[2121803.239773]  new_sync_read+0xf0/0x190
[2121803.239778]  vfs_read+0x150/0x1e0
[2121803.239783]  ksys_read+0x74/0x108
[2121803.239787]  __arm64_sys_read+0x24/0x30
[2121803.239796]  el0_svc_common.constprop.0+0x88/0x228
[2121803.239801]  do_el0_svc+0x2c/0x98
[2121803.239806]  el0_svc+0x28/0x68
[2121803.239811]  el0_sync_handler+0xb0/0xb8
[2121803.239816]  el0_sync+0x178/0x180
[2121803.239820] Mem-Info:
[2121803.239834] active_anon:258800 inactive_anon:150696 isolated_anon:0
                   active_file:72460 inactive_file:191342 isolated_file:0
                   unevictable:486 dirty:3322 writeback:4
                   slab_reclaimable:31877 slab_unreclaimable:58719
                   mapped:46108 shmem:9445 pagetables:6697 bounce:0
                   free:60679 free_pcp:0 free_cma:1040
[2121803.239844] Node 0 active_anon:1035200kB inactive_anon:602784kB active_file:289840kB inactive_file:765368kB unevictable:1944kB isolated(anon):0kB isolated(file):0kB mapped:184432kB dirty:13288kB writeback:16kB shmem:37780kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:14944kB all_unreclaimable? no
[2121803.239848] Node 0 DMA free:171552kB min:16520kB low:20648kB high:24776kB reserved_highatomic:0KB active_anon:64636kB inactive_anon:145048kB active_file:108092kB inactive_file:202096kB unevictable:0kB writepending:12196kB present:1046528kB managed:980856kB mlocked:0kB pagetables:11384kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[2121803.239861] lowmem_reserve[]: 0 2807 2807 2807 2807
[2121803.239874] Node 0 DMA32 free:71164kB min:49012kB low:61264kB high:73516kB reserved_highatomic:2048KB active_anon:970820kB inactive_anon:457440kB active_file:181748kB inactive_file:564228kB unevictable:1944kB writepending:1036kB present:3014656kB managed:2909548kB mlocked:1944kB pagetables:15404kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:4160kB
[2121803.239886] lowmem_reserve[]: 0 0 0 0 0
[2121803.239898] Node 0 DMA: 9581*4kB (UME) 8921*8kB (UME) 2756*16kB (UME) 374*32kB (UME) 107*64kB (UM) 1*128kB (M) 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 172732kB
[2121803.239940] Node 0 DMA32: 2838*4kB (UMEHC) 2719*8kB (UMEHC) 1386*16kB (UMEHC) 419*32kB (UMEHC) 42*64kB (UMEH) 6*128kB (UM) 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 72144kB
[2121803.239984] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
[2121803.239988] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=32768kB
[2121803.239993] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
[2121803.239998] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=64kB
[2121803.240000] 373270 total pagecache pages
[2121803.240011] 104518 pages in swap cache
[2121803.240015] Swap cache stats: add 5085793, delete 4981426, find 5714036/7053753
[2121803.240018] Free swap  = 1705192kB
[2121803.240021] Total swap = 3145720kB
[2121803.240024] 1015296 pages RAM
[2121803.240027] 0 pages HighMem/MovableOnly
[2121803.240030] 42695 pages reserved
[2121803.240032] 8192 pages cma reserved
[2121803.240035] 0 pages hwpoisoned

Thank you for your time.
Very Respectfully,
Peter Geis
