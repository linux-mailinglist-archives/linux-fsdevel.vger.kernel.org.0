Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8277069C7AD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Feb 2023 10:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjBTJ3G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Feb 2023 04:29:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjBTJ3F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Feb 2023 04:29:05 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAFA3593;
        Mon, 20 Feb 2023 01:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676885343; x=1708421343;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=9wPNJ48Qumla8ndHi/nTvMSjLoAmPM9moJMT4fr1BC8=;
  b=iS0SnK0yFmRxHSVCQ9yKQ9oDP/KnAV0ovRxjgqrBxeC1/abus4MJ6CTp
   iZ4B6eTU8crZBDY3DG098R7eW5yFcKH8g/ZHH7aqsJ0MVoVS4fZHTgpwV
   9Sw7Gz32cgrLmSwE86g0/aGyy4Mwn6llhP8fXq6Ag6XWKk+6OZlFX7DXC
   0ChndgQDUDv6a2ZP1khkAyDFBV4cpkRQaLdOJ5QW6QBycGgerrxtSunSf
   9cW5xnjqmz3lKPvituRJkTUZY8JyNeONaUlNP0Sjzr3FqrfjwCcs83BBE
   PuENCv2I73JrXngIKVDg3kNCmNWsmhLHHRDBRtzY18bwdR/zf3nkdACLs
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10626"; a="397045233"
X-IronPort-AV: E=Sophos;i="5.97,312,1669104000"; 
   d="scan'208";a="397045233"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2023 01:29:02 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10626"; a="795119525"
X-IronPort-AV: E=Sophos;i="5.97,312,1669104000"; 
   d="scan'208";a="795119525"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2023 01:28:57 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Bharata B Rao <bharata@amd.com>,
        Alistair Popple <apopple@nvidia.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        Minchan Kim <minchan@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "Xu, Pengfei" <pengfei.xu@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Stefan Roesch <shr@devkernel.io>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH -v5 0/9] migrate_pages(): batch TLB flushing
References: <20230213123444.155149-1-ying.huang@intel.com>
        <87a6c8c-c5c1-67dc-1e32-eb30831d6e3d@google.com>
Date:   Mon, 20 Feb 2023 17:28:01 +0800
In-Reply-To: <87a6c8c-c5c1-67dc-1e32-eb30831d6e3d@google.com> (Hugh Dickins's
        message of "Fri, 17 Feb 2023 13:47:48 -0800 (PST)")
Message-ID: <874jrg7kke.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, Hugh,

Hugh Dickins <hughd@google.com> writes:

> On Mon, 13 Feb 2023, Huang Ying wrote:
>
>> From: "Huang, Ying" <ying.huang@intel.com>
>> 
>> Now, migrate_pages() migrate folios one by one, like the fake code as
>> follows,
>> 
>>   for each folio
>>     unmap
>>     flush TLB
>>     copy
>>     restore map
>> 
>> If multiple folios are passed to migrate_pages(), there are
>> opportunities to batch the TLB flushing and copying.  That is, we can
>> change the code to something as follows,
>> 
>>   for each folio
>>     unmap
>>   for each folio
>>     flush TLB
>>   for each folio
>>     copy
>>   for each folio
>>     restore map
>> 
>> The total number of TLB flushing IPI can be reduced considerably.  And
>> we may use some hardware accelerator such as DSA to accelerate the
>> folio copying.
>> 
>> So in this patch, we refactor the migrate_pages() implementation and
>> implement the TLB flushing batching.  Base on this, hardware
>> accelerated folio copying can be implemented.
>> 
>> If too many folios are passed to migrate_pages(), in the naive batched
>> implementation, we may unmap too many folios at the same time.  The
>> possibility for a task to wait for the migrated folios to be mapped
>> again increases.  So the latency may be hurt.  To deal with this
>> issue, the max number of folios be unmapped in batch is restricted to
>> no more than HPAGE_PMD_NR in the unit of page.  That is, the influence
>> is at the same level of THP migration.
>> 
>> We use the following test to measure the performance impact of the
>> patchset,
>> 
>> On a 2-socket Intel server,
>> 
>>  - Run pmbench memory accessing benchmark
>> 
>>  - Run `migratepages` to migrate pages of pmbench between node 0 and
>>    node 1 back and forth.
>> 
>> With the patch, the TLB flushing IPI reduces 99.1% during the test and
>> the number of pages migrated successfully per second increases 291.7%.
>> 
>> Xin Hao helped to test the patchset on an ARM64 server with 128 cores,
>> 2 NUMA nodes.  Test results show that the page migration performance
>> increases up to 78%.
>> 
>> This patchset is based on mm-unstable 2023-02-10.
>
> And back in linux-next this week: I tried next-20230217 overnight.
>
> There is a deadlock in this patchset (and in previous versions: sorry
> it's taken me so long to report), but I think one that's easily solved.
>
> I've not bisected to precisely which patch (load can take several hours
> to hit the deadlock), but it doesn't really matter, and I expect that
> you can guess.
>
> My root and home filesystems are ext4 (4kB blocks with 4kB PAGE_SIZE),
> and so is the filesystem I'm testing, ext4 on /dev/loop0 on tmpfs.
> So, plenty of ext4 page cache and buffer_heads.
>
> Again and again, the deadlock is seen with buffer_migrate_folio_norefs(),
> either in kcompactd0 or in khugepaged trying to compact, or in both:
> it ends up calling __lock_buffer(), and that schedules away, waiting
> forever to get BH_lock.  I have not identified who is holding BH_lock,
> but I imagine a jbd2 journalling thread, and presume that it wants one
> of the folio locks which migrate_pages_batch() is already holding; or
> maybe it's all more convoluted than that.  Other tasks then back up
> waiting on those folio locks held in the batch.
>
> Never a problem with buffer_migrate_folio(), always with the "more
> careful" buffer_migrate_folio_norefs().  And the patch below fixes
> it for me: I've had enough hours with it now, on enough occasions,
> to be confident of that.
>
> Cc'ing Jan Kara, who knows buffer_migrate_folio_norefs() and jbd2
> very well, and I hope can assure us that there is an understandable
> deadlock here, from holding several random folio locks, then trying
> to lock buffers.  Cc'ing fsdevel, because there's a risk that mm
> folk think something is safe, when it's not sufficient to cope with
> the diversity of filesystems.  I hope nothing more than the below is
> needed (and I've had no other problems with the patchset: good job),
> but cannot be sure.
>
> [PATCH next] migrate_pages: fix deadlock on buffer heads
>
> When __buffer_migrate_folio() is called from buffer_migrate_folio_norefs(),
> force MIGRATE_ASYNC mode so that buffer_migrate_lock_buffers() will only
> trylock_buffer(), failing with -EAGAIN as usual if that does not succeed.
>
> Signed-off-by: Hugh Dickins <hughd@google.com>
>
> --- next-20230217/mm/migrate.c
> +++ fixed/mm/migrate.c
> @@ -748,7 +748,8 @@ static int __buffer_migrate_folio(struct
>  	if (folio_ref_count(src) != expected_count)
>  		return -EAGAIN;
>  
> -	if (!buffer_migrate_lock_buffers(head, mode))
> +	if (!buffer_migrate_lock_buffers(head,
> +			check_refs ? MIGRATE_ASYNC : mode))
>  		return -EAGAIN;
>  
>  	if (check_refs) {

Thank you very much for pointing this out and the fix patch.  Today, my
colleague Pengfei reported a deadlock bug to me.  It seems that we
cannot wait the writeback to complete when we have locked some folios.
Below patch can fix that deadlock.  I don't know whether this is related
to the deadlock you run into.  It appears that we should avoid to
lock/wait synchronously if we have locked more than one folios.

Best Regards,
Huang, Ying

------------------------------------8<------------------------------------
From 0699fa2f80a67e863107d49a25909c92b900a9be Mon Sep 17 00:00:00 2001
From: Huang Ying <ying.huang@intel.com>
Date: Mon, 20 Feb 2023 14:56:34 +0800
Subject: [PATCH] migrate_pages: fix deadlock on waiting writeback

Pengfei reported a system soft lockup issue with Syzkaller.  The stack
traces are as follows,

...
[  300.124933] INFO: task kworker/u4:3:73 blocked for more than 147 seconds.
[  300.125214]       Not tainted 6.2.0-rc4-kvm+ #1314
[  300.125408] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  300.125736] task:kworker/u4:3    state:D stack:0     pid:73    ppid:2      flags:0x00004000
[  300.126059] Workqueue: writeback wb_workfn (flush-7:3)
[  300.126282] Call Trace:
[  300.126378]  <TASK>
[  300.126464]  __schedule+0x43b/0xd00
[  300.126601]  ? __blk_flush_plug+0x142/0x180
[  300.126765]  schedule+0x6a/0xf0
[  300.126912]  io_schedule+0x4a/0x80
[  300.127051]  folio_wait_bit_common+0x1b5/0x4e0
[  300.127227]  ? __pfx_wake_page_function+0x10/0x10
[  300.127403]  __folio_lock+0x27/0x40
[  300.127541]  write_cache_pages+0x350/0x870
[  300.127699]  ? __pfx_iomap_do_writepage+0x10/0x10
[  300.127889]  iomap_writepages+0x3f/0x80
[  300.128037]  xfs_vm_writepages+0x94/0xd0
[  300.128192]  ? __pfx_xfs_vm_writepages+0x10/0x10
[  300.128370]  do_writepages+0x10a/0x240
[  300.128514]  ? lock_is_held_type+0xe6/0x140
[  300.128675]  __writeback_single_inode+0x9f/0xa90
[  300.128854]  writeback_sb_inodes+0x2fb/0x8d0
[  300.129030]  __writeback_inodes_wb+0x68/0x150
[  300.129212]  wb_writeback+0x49c/0x770
[  300.129357]  wb_workfn+0x6fb/0x9d0
[  300.129500]  process_one_work+0x3cc/0x8d0
[  300.129669]  worker_thread+0x66/0x630
[  300.129824]  ? __pfx_worker_thread+0x10/0x10
[  300.129989]  kthread+0x153/0x190
[  300.130116]  ? __pfx_kthread+0x10/0x10
[  300.130264]  ret_from_fork+0x29/0x50
[  300.130409]  </TASK>
[  300.179347] INFO: task repro:1023 blocked for more than 147 seconds.
[  300.179905]       Not tainted 6.2.0-rc4-kvm+ #1314
[  300.180317] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  300.180955] task:repro           state:D stack:0     pid:1023  ppid:360    flags:0x00004004
[  300.181660] Call Trace:
[  300.181879]  <TASK>
[  300.182085]  __schedule+0x43b/0xd00
[  300.182407]  schedule+0x6a/0xf0
[  300.182694]  io_schedule+0x4a/0x80
[  300.183020]  folio_wait_bit_common+0x1b5/0x4e0
[  300.183506]  ? compaction_alloc+0x77/0x1150
[  300.183892]  ? __pfx_wake_page_function+0x10/0x10
[  300.184304]  folio_wait_bit+0x30/0x40
[  300.184640]  folio_wait_writeback+0x2e/0x1e0
[  300.185034]  migrate_pages_batch+0x555/0x1ac0
[  300.185462]  ? __pfx_compaction_alloc+0x10/0x10
[  300.185808]  ? __pfx_compaction_free+0x10/0x10
[  300.186022]  ? __this_cpu_preempt_check+0x17/0x20
[  300.186234]  ? lock_is_held_type+0xe6/0x140
[  300.186423]  migrate_pages+0x100e/0x1180
[  300.186603]  ? __pfx_compaction_free+0x10/0x10
[  300.186800]  ? __pfx_compaction_alloc+0x10/0x10
[  300.187011]  compact_zone+0xe10/0x1b50
[  300.187182]  ? lock_is_held_type+0xe6/0x140
[  300.187374]  ? check_preemption_disabled+0x80/0xf0
[  300.187588]  compact_node+0xa3/0x100
[  300.187755]  ? __sanitizer_cov_trace_const_cmp8+0x1c/0x30
[  300.187993]  ? _find_first_bit+0x7b/0x90
[  300.188171]  sysctl_compaction_handler+0x5d/0xb0
[  300.188376]  proc_sys_call_handler+0x29d/0x420
[  300.188583]  proc_sys_write+0x2b/0x40
[  300.188749]  vfs_write+0x3a3/0x780
[  300.188912]  ksys_write+0xb7/0x180
[  300.189070]  __x64_sys_write+0x26/0x30
[  300.189260]  do_syscall_64+0x3b/0x90
[  300.189424]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[  300.189654] RIP: 0033:0x7f3a2471f59d
[  300.189815] RSP: 002b:00007ffe567f7288 EFLAGS: 00000217 ORIG_RAX: 0000000000000001
[  300.190137] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f3a2471f59d
[  300.190397] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
[  300.190653] RBP: 00007ffe567f72a0 R08: 0000000000000010 R09: 0000000000000010
[  300.190910] R10: 0000000000000010 R11: 0000000000000217 R12: 00000000004012e0
[  300.191172] R13: 00007ffe567f73e0 R14: 0000000000000000 R15: 0000000000000000
[  300.191440]  </TASK>
...

To migrate a folio, we may wait the writeback of a folio to complete
when we already have held the lock of some folios.  But the writeback
code may wait to lock some folio we held lock.  This causes the
deadlock.  To fix the issue, we will avoid to wait the writeback to
complete if we have locked some folios.  After moving the locked
folios and unlocked, we will retry.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Reported-by: "Xu, Pengfei" <pengfei.xu@intel.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Stefan Roesch <shr@devkernel.io>
Cc: Tejun Heo <tj@kernel.org>
Cc: Xin Hao <xhao@linux.alibaba.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/migrate.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/mm/migrate.c b/mm/migrate.c
index 28b435cdeac8..bc9a8050f1b0 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1205,6 +1205,18 @@ static int migrate_folio_unmap(new_page_t get_new_page, free_page_t put_new_page
 		}
 		if (!force)
 			goto out;
+		/*
+		 * We have locked some folios and are going to wait the
+		 * writeback of this folio to complete.  But it's possible for
+		 * the writeback to wait to lock the folios we have locked.  To
+		 * avoid a potential deadlock, let's bail out and not do that.
+		 * The locked folios will be moved and unlocked, then we
+		 * can wait the writeback of this folio.
+		 */
+		if (avoid_force_lock) {
+			rc = -EDEADLOCK;
+			goto out;
+		}
 		folio_wait_writeback(src);
 	}
 
-- 
2.39.1

