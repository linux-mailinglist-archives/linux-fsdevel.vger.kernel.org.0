Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8BC5BF4E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Sep 2022 05:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiIUDoQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Sep 2022 23:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiIUDoP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Sep 2022 23:44:15 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C2D4DB48
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Sep 2022 20:44:12 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MXPNn35tgzHpgj;
        Wed, 21 Sep 2022 11:42:01 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 11:44:10 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 11:44:10 +0800
Message-ID: <66bf580b-c7ce-007f-b6b3-2c0b97fc36e4@huawei.com>
Date:   Wed, 21 Sep 2022 11:44:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [BUG] mm/hugetlb: UAF after handle_userfault
Content-Language: en-US
To:     Liu Zixian <liuzixian4@huawei.com>, <mike.kravetz@oracle.com>,
        <songmuchun@bytedance.com>, <viro@zeniv.linux.org.uk>,
        <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>
CC:     <liushixin2@huawei.com>, <liuyuntao10@huawei.com>
References: <20220921014457.1668-1-liuzixian4@huawei.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20220921014457.1668-1-liuzixian4@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 2022/9/21 9:44, Liu Zixian wrote:
> In hugetlb_handle_userfault, we call i_mmap_unlock_read before handle_userfault,
> and call i_mmap_lock_read after it to make calling code simpler.
> But the mapping variable can be invalid as vma may be changed
> after mmap lock is dropped during handle_userfault.

Actually, we don't need to call mutex_lock() and hugetlb_vma_lock_read() 
after handle_userfault(),

because there will be released immediately in hugetlb_no_page(), will 
post a patch soon.

> This bug is found by syzkaller with the following operations:
>
> mmap$IORING_OFF_SQ_RING(&(0x7f0000400000/0xc00000)=nil, 0xc00000, 0x0, 0x44832, 0xffffffffffffffff, 0x0)
> r0 = userfaultfd(0x0)
> r1 = openat(0xffffffffffffff9c, &(0x7f00000000c0)='./file2\x00', 0x59042, 0x0)
> ftruncate(r1, 0x8)
> r2 = mmap$IORING_OFF_SQ_RING(&(0x7f0000400000/0xc00000)=nil, 0xc00000, 0x2000002, 0x44832, r1, 0x0)
> syz_memcpy_off$IO_URING_METADATA_FLAGS(r2, 0x0, &(0x7f0000000080), 0x0, 0x4)
> syz_memcpy_off$IO_URING_METADATA_FLAGS(r2, 0x118, &(0x7f0000000280)=0x1, 0x0, 0x4)
> ioctl$UFFDIO_API(r0, 0xc018aa3f, &(0x7f0000000180))
> mprotect(&(0x7f0000ffb000/0x2000)=nil, 0x2000, 0x0)
> ioctl$UFFDIO_REGISTER(r0, 0xc020aa00, &(0x7f0000000080)={{&(0x7f0000800000/0x800000)=nil, 0x800000}, 0x1})
> mprotect(&(0x7f0000971000/0x3000)=nil, 0x3000, 0x0)
> ioctl$UFFDIO_ZEROPAGE(r0, 0xc020aa04, &(0x7f0000000000)={{&(0x7f0000b35000/0x1000)=nil, 0x1000}})
> r3 = fsmount(0xffffffffffffffff, 0x1, 0x0)
> syz_kvm_setup_cpu$arm64(0xffffffffffffffff, r3, &(0x7f0000dbc000/0x18000)=nil, &(0x7f00000000c0)=[{0x0, &(0x7f0000000040)="17eb9261c249c6672ae95a46cbb140cbc2b0a3b8778ee972d27c7edcf4af5d7071ceebe27cda5f06301fa270d201883b9244", 0x32}], 0x1, 0x0, &(0x7f0000000100), 0x1)
> r4 = openat(0xffffffffffffff9c, &(0x7f00000000c0)='./file2\x00', 0x59042, 0x0)
> ftruncate(r4, 0x8)
> mmap$IORING_OFF_SQ_RING(&(0x7f0000400000/0xc00000)=nil, 0xc00000, 0x2000002, 0x44832, r4, 0x0)
>
> KASAN report is here:
>
> [  476.621494] ==================================================================
> [  476.622067] BUG: KASAN: use-after-free in down_read+0x80/0x1d0
> [  476.622530] Write of size 8 at addr ffff0000cce177e0 by task syz-executor/15650
>
> [  476.623305] CPU: 3 PID: 15650 Comm: syz-executor Kdump: loaded Not tainted 6.0.0-rc5+ #4
> [  476.624130] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
> [  476.624834] Call trace:
> [  476.625135]  dump_backtrace+0xe4/0x124
> [  476.625586]  show_stack+0x20/0x5c
> [  476.625983]  dump_stack_lvl+0x68/0x84
> [  476.626415]  print_address_description.constprop.0+0x78/0x360
> [  476.627046]  print_report+0x108/0x130
> [  476.627473]  kasan_report+0x84/0x120
> [  476.627892]  kasan_check_range+0xe4/0x190
> [  476.628351]  __kasan_check_write+0x28/0x3c
> [  476.628818]  down_read+0x80/0x1d0
> [  476.629210]  hugetlb_handle_userfault+0x120/0x1a0
> [  476.629748]  hugetlb_no_page+0x618/0x6a0
> [  476.630202]  hugetlb_fault+0x1d4/0x5f4
> [  476.630642]  handle_mm_fault+0x23c/0x2d0
> [  476.631102]  do_page_fault+0x1c0/0x5b0
> [  476.631542]  do_translation_fault+0x8c/0xc0
> [  476.632022]  do_mem_abort+0x68/0xfc
> [  476.632444]  el0_da+0x40/0xd0
> [  476.632810]  el0t_64_sync_handler+0x68/0xc0
> [  476.633292]  el0t_64_sync+0x180/0x184
>
> [  476.633953] Allocated by task 15650:
> [  476.634368]  kasan_save_stack+0x2c/0x54
> [  476.634819]  __kasan_slab_alloc+0x6c/0x90
> [  476.635285]  kmem_cache_alloc_lru+0x100/0x290
> [  476.635784]  hugetlbfs_alloc_inode+0xac/0x2a0
> [  476.636287]  alloc_inode+0x44/0x124
> [  476.636706]  new_inode+0x7c/0x170
> [  476.637105]  hugetlbfs_get_inode+0x158/0x2a0
> [  476.637601]  hugetlb_file_setup+0xcc/0x49c
> [  476.638073]  ksys_mmap_pgoff+0xe8/0x270
> [  476.638521]  __arm64_sys_mmap+0x8c/0xb0
> [  476.638970]  invoke_syscall+0x68/0x1a0
> [  476.639412]  el0_svc_common.constprop.0+0x1e4/0x220
> [  476.639962]  do_el0_svc+0x3c/0x50
> [  476.640358]  el0_svc+0x28/0xd0
> [  476.640731]  el0t_64_sync_handler+0xb8/0xc0
> [  476.641214]  el0t_64_sync+0x180/0x184
>
> [  476.641868] Freed by task 0:
> [  476.642222]  kasan_save_stack+0x2c/0x54
> [  476.642673]  kasan_set_track+0x2c/0x40
> [  476.643114]  kasan_set_free_info+0x28/0x50
> [  476.643586]  ____kasan_slab_free+0x140/0x1d0
> [  476.644076]  __kasan_slab_free+0x18/0x2c
> [  476.644533]  kmem_cache_free+0x178/0x3f0
> [  476.644990]  hugetlbfs_free_inode+0x24/0x30
> [  476.645472]  i_callback+0x34/0x64
> [  476.645874]  rcu_do_batch+0x240/0x660
> [  476.646307]  rcu_core+0x1ec/0x270
> [  476.646708]  rcu_core_si+0x18/0x24
> [  476.647115]  __do_softirq+0x19c/0x540
>
> [  476.647765] Last potentially related work creation:
> [  476.648313]  kasan_save_stack+0x2c/0x54
> [  476.648759]  __kasan_record_aux_stack+0xa0/0xd0
> [  476.649276]  kasan_record_aux_stack_noalloc+0x14/0x20
> [  476.649858]  call_rcu+0xbc/0x370
> [  476.650249]  destroy_inode+0x9c/0xc4
> [  476.650674]  evict+0x2cc/0x3a0
> [  476.651048]  iput_final+0x144/0x314
> [  476.651463]  iput.part.0+0x114/0x130
> [  476.651887]  iput+0x38/0x50
> [  476.652235]  dentry_unlink_inode+0x150/0x210
> [  476.652729]  __dentry_kill+0x1f8/0x3a0
> [  476.653168]  dentry_kill+0x390/0x500
> [  476.653601]  dput+0x304/0x354
> [  476.653967]  __fput+0x138/0x360
> [  476.654352]  ____fput+0x18/0x24
> [  476.654736]  task_work_run+0x17c/0x340
> [  476.655181]  ptrace_notify+0x1d0/0x1e0
> [  476.655625]  syscall_trace_exit+0x1e4/0x320
> [  476.656107]  el0_svc_common.constprop.0+0xc8/0x220
> [  476.656649]  do_el0_svc+0x3c/0x50
> [  476.657047]  el0_svc+0x28/0xd0
> [  476.657423]  el0t_64_sync_handler+0xb8/0xc0
> [  476.657918]  el0t_64_sync+0x180/0x184
>
> [  476.658567] Second to last potentially related work creation:
> [  476.659196]  kasan_save_stack+0x2c/0x54
> [  476.659644]  __kasan_record_aux_stack+0xa0/0xd0
> [  476.660162]  kasan_record_aux_stack_noalloc+0x14/0x20
> [  476.660728]  call_rcu+0xbc/0x370
> [  476.661117]  destroy_inode+0x9c/0xc4
> [  476.661544]  evict+0x2cc/0x3a0
> [  476.661917]  iput_final+0x144/0x314
> [  476.662334]  iput.part.0+0x114/0x130
> [  476.662759]  iput+0x38/0x50
> [  476.663107]  dentry_unlink_inode+0x150/0x210
> [  476.663599]  __dentry_kill+0x1f8/0x3a0
> [  476.664039]  dentry_kill+0x390/0x500
> [  476.664463]  dput+0x304/0x354
> [  476.664828]  __fput+0x138/0x360
> [  476.665211]  ____fput+0x18/0x24
> [  476.665600]  task_work_run+0x17c/0x340
> [  476.666041]  do_notify_resume+0x230/0x320
> [  476.666509]  el0_svc+0x8c/0xd0
> [  476.666883]  el0t_64_sync_handler+0xb8/0xc0
> [  476.667367]  el0t_64_sync+0x180/0x184
>
> [  476.668016] The buggy address belongs to the object at ffff0000cce17600
>                  which belongs to the cache hugetlbfs_inode_cache of size 640
> [  476.669451] The buggy address is located 480 bytes inside of
>                  640-byte region [ffff0000cce17600, ffff0000cce17880)
>
> [  476.670958] The buggy address belongs to the physical page:
> [  476.671575] page:0000000032d18387 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff0000cce14600 pfn:0x10ce14
> [  476.672686] head:0000000032d18387 order:2 compound_mapcount:0 compound_pincount:0
> [  476.673486] memcg:ffff0000c500ec01
> [  476.673893] flags: 0x17ffff800010200(slab|head|node=0|zone=2|lastcpupid=0xfffff)
> [  476.674692] raw: 017ffff800010200 fffffc00005f1300 dead000000000002 ffff0000c15b5680
> [  476.675517] raw: ffff0000cce14600 000000008015000f 00000001ffffffff ffff0000c500ec01
> [  476.676339] page dumped because: kasan: bad access detected
>
> [  476.677170] Memory state around the buggy address:
> [  476.677715]  ffff0000cce17680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [  476.678489]  ffff0000cce17700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [  476.679265] >ffff0000cce17780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [  476.680034]                                                        ^
> [  476.680725]  ffff0000cce17800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [  476.681498]  ffff0000cce17880: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [  476.682271] ==================================================================
> .
