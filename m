Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989F0508DD9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Apr 2022 18:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380755AbiDTRA4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Apr 2022 13:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237032AbiDTRAz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Apr 2022 13:00:55 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E41DE094;
        Wed, 20 Apr 2022 09:58:09 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id a10so1756014qvm.8;
        Wed, 20 Apr 2022 09:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pZBuBHi6OOSrgUQMBZeG5iado8rbWsfW7qnCy49pZ1w=;
        b=FvaIenlAWA7mhJHE22sGdCpIyIpCoYfrdVyAOA1Sv08k/7k9oxYjaDS/AoBFDdCIKF
         /JPWJgw2gmEBjGjBS6Mku1Ta4EfxTiWWBaCUQV6YAM2eROUVO8hST2yAvxnkVzhXdmbM
         FQ2xqlgShcO6DYRgzuXF8guPMqIpCW7mcucEGLp4VfPGTYlXy2HLLiYzPeBv6NOxlIzl
         sidAVF1inVM1syffdnyMxFcO9WdhJ9tMQ/7FnuhGupT6Dc4S92HQvQbkRUlJunb2IQS5
         +kuYy0TdVoDocreDtmRCwVoBv7MgB+vKKIGRUhkr62DTp9lo3y3ggBXdgQOsjGSf4WYP
         2FOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pZBuBHi6OOSrgUQMBZeG5iado8rbWsfW7qnCy49pZ1w=;
        b=Vqib+zYSvfydT5Er/y1ioOa79P2XcnRFdGQQhvXc1+cSQ47kswmlI7ZVMnj4lIXkpP
         xo7fk5kNuNh4zYL04DzEaGHGFGn60UMmDoyGlgRZSPf/e9pLVzyHuRqudD/HcY5ZL2/y
         8MWqRErnpNyo7t2U8zB5oJKliQJ16PeSDPO919mGnKKsJ0/Ha7unxqQS9sFZf07bWlnb
         h7mVToYIDb6XeAoi447W7NtyE2gjKwj+Q5QykWNtuk6R34Gq5V9CViMC7QEIDV/RNxMz
         DpzQCcGCaRX0ksuJ2GXfTkdCO+xAJ4rH/09VqFzT+gFA0JnuXIBDQmSXGcqGDTfBI/V6
         r2LA==
X-Gm-Message-State: AOAM530X/eu5HpqMvoStXxtMju/az0giCjX9YRXk3VI6D8xYxPAq62sW
        RIWGoJIdib02qD/WPiCFkIIvjPE4T69e
X-Google-Smtp-Source: ABdhPJz9/EjUt0z5KznYYRewmPdVfg/0rG4RITqK6hX/lMlZLXFRiCRzQBOO5BwXfN41Ll1t1xWPMQ==
X-Received: by 2002:a05:6214:d85:b0:449:96f7:6194 with SMTP id e5-20020a0562140d8500b0044996f76194mr4018459qve.48.1650473888314;
        Wed, 20 Apr 2022 09:58:08 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id v65-20020a376144000000b0069e7842f2f5sm1684260qkb.52.2022.04.20.09.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 09:58:07 -0700 (PDT)
Date:   Wed, 20 Apr 2022 12:58:05 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, roman.gushchin@linux.dev,
        hannes@cmpxchg.org
Subject: Re: [PATCH 3/4] mm: Centralize & improve oom reporting in show_mem.c
Message-ID: <20220420165805.lg4k2iipnpyt4nuu@moria.home.lan>
References: <20220419203202.2670193-1-kent.overstreet@gmail.com>
 <20220419203202.2670193-4-kent.overstreet@gmail.com>
 <Yl+vHJ3lSLn5ZkWN@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yl+vHJ3lSLn5ZkWN@dhcp22.suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 20, 2022 at 08:58:36AM +0200, Michal Hocko wrote:
> On Tue 19-04-22 16:32:01, Kent Overstreet wrote:
> > This patch:
> >  - Moves lib/show_mem.c to mm/show_mem.c
> 
> Sure, why not. Should be a separate patch.
> 
> >  - Changes show_mem() to always report on slab usage
> >  - Instead of reporting on all slabs, we only report on top 10 slabs,
> >    and in sorted order
> >  - Also reports on shrinkers, with the new shrinkers_to_text().
> 
> Why do we need/want this? It would be also great to provide an example
> of why the new output is better (in which cases) than the existing one.

Did you read the cover letter to the patch series?

But sure, I can give you an example of the new output:

00177 018: page allocation failure: order:5, mode:0x40dc0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO), nodemask=(null)
00177 CPU: 0 PID: 32171 Comm: 018 Not tainted 5.17.0-01346-g09b56740d418-dirty #154
00177 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1 04/01/2014
00177 Call Trace:
00177  <TASK>
00177  dump_stack_lvl+0x38/0x49
00177  dump_stack+0x10/0x12
00177  warn_alloc+0x128/0x150
00177  ? __alloc_pages_direct_compact+0x171/0x1f0
00177  __alloc_pages_slowpath.constprop.0+0xac6/0xc30
00177  ? make_kgid+0x17/0x20
00177  ? p9pdu_readf+0x28c/0xb00
00177  __alloc_pages+0x215/0x230
00177  kmalloc_order+0x30/0x80
00177  kmalloc_order_trace+0x1d/0x80
00177  __kmalloc+0x1a2/0x1d0
00177  v9fs_alloc_rdir_buf.isra.0+0x28/0x40
00177  v9fs_dir_readdir_dotl+0x55/0x160
00177  ? __alloc_pages+0x151/0x230
00177  ? lru_cache_add+0x1c/0x20
00177  ? lru_cache_add_inactive_or_unevictable+0x27/0x80
00177  ? __handle_mm_fault+0x666/0xae0
00177  iterate_dir+0x151/0x1b0
00177  __x64_sys_getdents64+0x80/0x120
00177  ? compat_fillonedir+0x160/0x160
00177  do_syscall_64+0x35/0x80
00177  entry_SYSCALL_64_after_hwframe+0x44/0xae
00177 RIP: 0033:0x7f0b15e2f9c7
00177 Code: 00 00 0f 05 eb b3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 81 fa ff ff ff 7f b8 ff ff ff 7f 48 0f 47 d0 b8 d9 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 79 b4 10 00 f7 d8 64 89 02 48
00177 RSP: 002b:00007ffcf9445b88 EFLAGS: 00000293 ORIG_RAX: 00000000000000d9
00177 RAX: ffffffffffffffda RBX: 000056137dd23ba0 RCX: 00007f0b15e2f9c7
00177 RDX: 000000000001f000 RSI: 000056137dd23bd0 RDI: 0000000000000003
00177 RBP: 000056137dd23bd0 R08: 0000000000000030 R09: 00007f0b15f3bc00
00177 R10: fffffffffffff776 R11: 0000000000000293 R12: ffffffffffffff88
00177 R13: 000056137dd23ba4 R14: 0000000000000000 R15: 000056137dd23ba0
00177  </TASK>
00177 Mem-Info:
00177 active_anon:13706 inactive_anon:32266 isolated_anon:16
00177  active_file:1653 inactive_file:1822 isolated_file:0
00177  unevictable:0 dirty:0 writeback:0
00177  slab_reclaimable:6242 slab_unreclaimable:11168
00177  mapped:3824 shmem:3 pagetables:1266 bounce:0
00177  kernel_misc_reclaimable:0
00177  free:4362 free_pcp:35 free_cma:0
00177 Node 0 active_anon:54824kB inactive_anon:129064kB active_file:6612kB inactive_file:7288kB unevictable:0kB isolated(anon):64kB isolated(file):0kB mapped:15296kB dirty:0kB writeback:0kB shmem:12kB writeback_tmp:0kB kernel_stack:3392kB pagetables:5064kB all_unreclaimable? no
00177 DMA free:2232kB boost:0kB min:88kB low:108kB high:128kB reserved_highatomic:0KB active_anon:2924kB inactive_anon:6596kB active_file:428kB inactive_file:384kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
00177 lowmem_reserve[]: 0 426 426 426
00177 DMA32 free:15092kB boost:5836kB min:8432kB low:9080kB high:9728kB reserved_highatomic:0KB active_anon:52196kB inactive_anon:122392kB active_file:6176kB inactive_file:7068kB unevictable:0kB writepending:0kB present:507760kB managed:441816kB mlocked:0kB bounce:0kB free_pcp:72kB local_pcp:0kB free_cma:0kB
00177 lowmem_reserve[]: 0 0 0 0
00177 DMA: 284*4kB (UM) 53*8kB (UM) 21*16kB (U) 11*32kB (U) 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 2248kB
00177 DMA32: 2765*4kB (UME) 375*8kB (UME) 57*16kB (UM) 5*32kB (U) 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 15132kB
00177 4656 total pagecache pages
00177 1031 pages in swap cache
00177 Swap cache stats: add 6572399, delete 6572173, find 488603/3286476
00177 Free swap  = 509112kB
00177 Total swap = 2097148kB
00177 130938 pages RAM
00177 0 pages HighMem/MovableOnly
00177 16644 pages reserved
00177 Unreclaimable slab info:
00177 9p-fcall-cache    total: 8.25 MiB active: 8.25 MiB
00177 kernfs_node_cache total: 2.15 MiB active: 2.15 MiB
00177 kmalloc-64        total: 2.08 MiB active: 2.07 MiB
00177 task_struct       total: 1.95 MiB active: 1.95 MiB
00177 kmalloc-4k        total: 1.50 MiB active: 1.50 MiB
00177 signal_cache      total: 1.34 MiB active: 1.34 MiB
00177 kmalloc-2k        total: 1.16 MiB active: 1.16 MiB
00177 bch_inode_info    total: 1.02 MiB active: 922 KiB
00177 perf_event        total: 1.02 MiB active: 1.02 MiB
00177 biovec-max        total: 992 KiB active: 960 KiB
00177 Shrinkers:
00177 super_cache_scan: objects: 127
00177 super_cache_scan: objects: 106
00177 jbd2_journal_shrink_scan: objects: 32
00177 ext4_es_scan: objects: 32
00177 bch2_btree_cache_scan: objects: 8
00177   nr nodes:          24
00177   nr dirty:          0
00177   cannibalize lock:  0000000000000000
00177 
00177 super_cache_scan: objects: 8
00177 super_cache_scan: objects: 1
