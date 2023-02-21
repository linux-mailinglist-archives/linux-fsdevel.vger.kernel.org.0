Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E82A69E1F3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Feb 2023 15:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbjBUOFy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Feb 2023 09:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjBUOFv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Feb 2023 09:05:51 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DED2A9A3;
        Tue, 21 Feb 2023 06:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676988328; x=1708524328;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=w/lPNPMmhrxGiYsvw/VKArmIUNzOzT93srjkhKhOjeo=;
  b=KGxSWQe/Qm7e+3w8EZN1YMh1A7tyIqUCvaH52ox/wAFqPqmoyyZriBV5
   NUFxcVgDR70PSBV1MKt5hOr2lIG9LFOrbW8z+77Ov+yW6Lx9Czjm10c04
   8o7YnA7QEU0AS0OVb2aDIBrQlp554TQVCf99834KV44hZHQnj3wf24rxn
   wHVk0cAfROUza6FpXvhjjgwI3zlJAAJ0y1lhR0aJVphcangWm5X/qpVj4
   bqcV/D37ZIWXILchJ62YQoi0Hhbp+rzU9Lor78kOWKEUTLByciWMGrbQC
   AwmEkNdzQ/UX3imjzWuxr1WmzqLqOjqLOEEqgZbDYcZGsYXixFkLoSCJr
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="360108791"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="360108791"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 06:05:13 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="845686491"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="845686491"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 06:05:08 -0800
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
        <874jrg7kke.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <2ab4b33e-f570-a6ff-6315-7d5a4614a7bd@google.com>
Date:   Tue, 21 Feb 2023 22:04:03 +0800
In-Reply-To: <2ab4b33e-f570-a6ff-6315-7d5a4614a7bd@google.com> (Hugh Dickins's
        message of "Mon, 20 Feb 2023 18:48:38 -0800 (PST)")
Message-ID: <871qmjdsj0.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hugh Dickins <hughd@google.com> writes:

> On Mon, 20 Feb 2023, Huang, Ying wrote:
>
>> Hi, Hugh,
>> 
>> Hugh Dickins <hughd@google.com> writes:
>> 
>> > On Mon, 13 Feb 2023, Huang Ying wrote:
>> >
>> >> From: "Huang, Ying" <ying.huang@intel.com>
>> >> 
>> >> Now, migrate_pages() migrate folios one by one, like the fake code as
>> >> follows,
>> >> 
>> >>   for each folio
>> >>     unmap
>> >>     flush TLB
>> >>     copy
>> >>     restore map
>> >> 
>> >> If multiple folios are passed to migrate_pages(), there are
>> >> opportunities to batch the TLB flushing and copying.  That is, we can
>> >> change the code to something as follows,
>> >> 
>> >>   for each folio
>> >>     unmap
>> >>   for each folio
>> >>     flush TLB
>> >>   for each folio
>> >>     copy
>> >>   for each folio
>> >>     restore map
>> >> 
>> >> The total number of TLB flushing IPI can be reduced considerably.  And
>> >> we may use some hardware accelerator such as DSA to accelerate the
>> >> folio copying.
>> >> 
>> >> So in this patch, we refactor the migrate_pages() implementation and
>> >> implement the TLB flushing batching.  Base on this, hardware
>> >> accelerated folio copying can be implemented.
>> >> 
>> >> If too many folios are passed to migrate_pages(), in the naive batched
>> >> implementation, we may unmap too many folios at the same time.  The
>> >> possibility for a task to wait for the migrated folios to be mapped
>> >> again increases.  So the latency may be hurt.  To deal with this
>> >> issue, the max number of folios be unmapped in batch is restricted to
>> >> no more than HPAGE_PMD_NR in the unit of page.  That is, the influence
>> >> is at the same level of THP migration.
>> >> 
>> >> We use the following test to measure the performance impact of the
>> >> patchset,
>> >> 
>> >> On a 2-socket Intel server,
>> >> 
>> >>  - Run pmbench memory accessing benchmark
>> >> 
>> >>  - Run `migratepages` to migrate pages of pmbench between node 0 and
>> >>    node 1 back and forth.
>> >> 
>> >> With the patch, the TLB flushing IPI reduces 99.1% during the test and
>> >> the number of pages migrated successfully per second increases 291.7%.
>> >> 
>> >> Xin Hao helped to test the patchset on an ARM64 server with 128 cores,
>> >> 2 NUMA nodes.  Test results show that the page migration performance
>> >> increases up to 78%.
>> >> 
>> >> This patchset is based on mm-unstable 2023-02-10.
>> >
>> > And back in linux-next this week: I tried next-20230217 overnight.
>> >
>> > There is a deadlock in this patchset (and in previous versions: sorry
>> > it's taken me so long to report), but I think one that's easily solved.
>> >
>> > I've not bisected to precisely which patch (load can take several hours
>> > to hit the deadlock), but it doesn't really matter, and I expect that
>> > you can guess.
>> >
>> > My root and home filesystems are ext4 (4kB blocks with 4kB PAGE_SIZE),
>> > and so is the filesystem I'm testing, ext4 on /dev/loop0 on tmpfs.
>> > So, plenty of ext4 page cache and buffer_heads.
>> >
>> > Again and again, the deadlock is seen with buffer_migrate_folio_norefs(),
>> > either in kcompactd0 or in khugepaged trying to compact, or in both:
>> > it ends up calling __lock_buffer(), and that schedules away, waiting
>> > forever to get BH_lock.  I have not identified who is holding BH_lock,
>> > but I imagine a jbd2 journalling thread, and presume that it wants one
>> > of the folio locks which migrate_pages_batch() is already holding; or
>> > maybe it's all more convoluted than that.  Other tasks then back up
>> > waiting on those folio locks held in the batch.
>> >
>> > Never a problem with buffer_migrate_folio(), always with the "more
>> > careful" buffer_migrate_folio_norefs().  And the patch below fixes
>> > it for me: I've had enough hours with it now, on enough occasions,
>> > to be confident of that.
>> >
>> > Cc'ing Jan Kara, who knows buffer_migrate_folio_norefs() and jbd2
>> > very well, and I hope can assure us that there is an understandable
>> > deadlock here, from holding several random folio locks, then trying
>> > to lock buffers.  Cc'ing fsdevel, because there's a risk that mm
>> > folk think something is safe, when it's not sufficient to cope with
>> > the diversity of filesystems.  I hope nothing more than the below is
>> > needed (and I've had no other problems with the patchset: good job),
>> > but cannot be sure.
>> >
>> > [PATCH next] migrate_pages: fix deadlock on buffer heads
>> >
>> > When __buffer_migrate_folio() is called from buffer_migrate_folio_norefs(),
>> > force MIGRATE_ASYNC mode so that buffer_migrate_lock_buffers() will only
>> > trylock_buffer(), failing with -EAGAIN as usual if that does not succeed.
>> >
>> > Signed-off-by: Hugh Dickins <hughd@google.com>
>> >
>> > --- next-20230217/mm/migrate.c
>> > +++ fixed/mm/migrate.c
>> > @@ -748,7 +748,8 @@ static int __buffer_migrate_folio(struct
>> >  	if (folio_ref_count(src) != expected_count)
>> >  		return -EAGAIN;
>> >  
>> > -	if (!buffer_migrate_lock_buffers(head, mode))
>> > +	if (!buffer_migrate_lock_buffers(head,
>> > +			check_refs ? MIGRATE_ASYNC : mode))
>> >  		return -EAGAIN;
>> >  
>> >  	if (check_refs) {
>> 
>> Thank you very much for pointing this out and the fix patch.  Today, my
>> colleague Pengfei reported a deadlock bug to me.  It seems that we
>> cannot wait the writeback to complete when we have locked some folios.
>> Below patch can fix that deadlock.  I don't know whether this is related
>> to the deadlock you run into.  It appears that we should avoid to
>> lock/wait synchronously if we have locked more than one folios.
>
> Thanks, I've checked now, on next-20230217 without my patch but
> with your patch below: it took a few hours, but still deadlocks
> as I described above, so it's not the same issue.
>
> Yes, that's a good principle, that we should avoid to lock/wait
> synchronously once we have locked one folio (hmm, above you say
> "more than one": I think we mean the same thing, we're just
> stating it differently, given how the code runs at present).
>
> I'm not a great fan of migrate_folio_unmap()'s arguments,
> "force" followed by "oh, but don't force" (but applaud the recent
> "avoid_force_lock" as much better than the original "force_lock").
> I haven't tried, but I wonder if you can avoid both those arguments,
> and both of these patches, by passing down an adjusted mode (perhaps
> MIGRATE_ASYNC, or perhaps a new mode) to all callees, once the first
> folio of a batch has been acquired (then restore to the original mode
> when starting a new batch).
>
> (My patch is weak in that it trylocks for buffer_head even on the
> first folio of a MIGRATE_SYNC norefs batch, although that has never
> given a problem historically: adjusting the mode after acquiring
> the first folio would correct that weakness.)

On second thought, I think that it may be better to provide a fix as
simple as possible firstly.  Then we can work on a more complex fix as
we discussed above.  The simple fix is easy to review now.  And, we will
have more time to test and review the complex fix.

In the following fix, I disabled the migration batching except for the
MIGRATE_ASYNC mode, or the split folios of a THP folio.  After that, I
will work on the complex fix to enable migration batching for all modes.

What do you think about that?

Best Regards,
Huang, Ying

-------------------------------8<---------------------------------
From 8e475812eacd9f2eeac76776c2b1a17af3e59b89 Mon Sep 17 00:00:00 2001
From: Huang Ying <ying.huang@intel.com>
Date: Tue, 21 Feb 2023 16:37:50 +0800
Subject: [PATCH] migrate_pages: fix deadlock in batched migration

Two deadlock bugs were reported for the migrate_pages() batching
series.  Thanks Hugh and Pengfei!  For example, in the following
deadlock trace snippet,

 INFO: task kworker/u4:0:9 blocked for more than 147 seconds.
       Not tainted 6.2.0-rc4-kvm+ #1314
 "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
 task:kworker/u4:0    state:D stack:0     pid:9     ppid:2      flags:0x00004000
 Workqueue: loop4 loop_rootcg_workfn
 Call Trace:
  <TASK>
  __schedule+0x43b/0xd00
  schedule+0x6a/0xf0
  io_schedule+0x4a/0x80
  folio_wait_bit_common+0x1b5/0x4e0
  ? __pfx_wake_page_function+0x10/0x10
  __filemap_get_folio+0x73d/0x770
  shmem_get_folio_gfp+0x1fd/0xc80
  shmem_write_begin+0x91/0x220
  generic_perform_write+0x10e/0x2e0
  __generic_file_write_iter+0x17e/0x290
  ? generic_write_checks+0x12b/0x1a0
  generic_file_write_iter+0x97/0x180
  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
  do_iter_readv_writev+0x13c/0x210
  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
  do_iter_write+0xf6/0x330
  vfs_iter_write+0x46/0x70
  loop_process_work+0x723/0xfe0
  loop_rootcg_workfn+0x28/0x40
  process_one_work+0x3cc/0x8d0
  worker_thread+0x66/0x630
  ? __pfx_worker_thread+0x10/0x10
  kthread+0x153/0x190
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x29/0x50
  </TASK>

 INFO: task repro:1023 blocked for more than 147 seconds.
       Not tainted 6.2.0-rc4-kvm+ #1314
 "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
 task:repro           state:D stack:0     pid:1023  ppid:360    flags:0x00004004
 Call Trace:
  <TASK>
  __schedule+0x43b/0xd00
  schedule+0x6a/0xf0
  io_schedule+0x4a/0x80
  folio_wait_bit_common+0x1b5/0x4e0
  ? compaction_alloc+0x77/0x1150
  ? __pfx_wake_page_function+0x10/0x10
  folio_wait_bit+0x30/0x40
  folio_wait_writeback+0x2e/0x1e0
  migrate_pages_batch+0x555/0x1ac0
  ? __pfx_compaction_alloc+0x10/0x10
  ? __pfx_compaction_free+0x10/0x10
  ? __this_cpu_preempt_check+0x17/0x20
  ? lock_is_held_type+0xe6/0x140
  migrate_pages+0x100e/0x1180
  ? __pfx_compaction_free+0x10/0x10
  ? __pfx_compaction_alloc+0x10/0x10
  compact_zone+0xe10/0x1b50
  ? lock_is_held_type+0xe6/0x140
  ? check_preemption_disabled+0x80/0xf0
  compact_node+0xa3/0x100
  ? __sanitizer_cov_trace_const_cmp8+0x1c/0x30
  ? _find_first_bit+0x7b/0x90
  sysctl_compaction_handler+0x5d/0xb0
  proc_sys_call_handler+0x29d/0x420
  proc_sys_write+0x2b/0x40
  vfs_write+0x3a3/0x780
  ksys_write+0xb7/0x180
  __x64_sys_write+0x26/0x30
  do_syscall_64+0x3b/0x90
  entry_SYSCALL_64_after_hwframe+0x72/0xdc
 RIP: 0033:0x7f3a2471f59d
 RSP: 002b:00007ffe567f7288 EFLAGS: 00000217 ORIG_RAX: 0000000000000001
 RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f3a2471f59d
 RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
 RBP: 00007ffe567f72a0 R08: 0000000000000010 R09: 0000000000000010
 R10: 0000000000000010 R11: 0000000000000217 R12: 00000000004012e0
 R13: 00007ffe567f73e0 R14: 0000000000000000 R15: 0000000000000000
  </TASK>

The page migration task has held the lock of the shmem folio A, and is
waiting the writeback of the folio B of the file system on the loop
block device to complete.  While the loop worker task which writes
back the folio B is waiting to lock the shmem folio A, because the
folio A backs the folio B in the loop device.  Thus deadlock is
triggered.

In general, if we have locked some other folios except the one we are
migrating, it's not safe to wait synchronously, for example, to wait
the writeback to complete or wait to lock the buffer head.

To fix the deadlock, in this patch, we avoid to batch the page
migration except for MIGRATE_ASYNC mode or the split folios of a THP
folio.  In MIGRATE_ASYNC mode, synchronous waiting is avoided.  And
there isn't any dependency relationship among the split folios of a
THP folio.

The fix can be improved via converting migration mode from synchronous
to asynchronous if we have locked some other folios except the one we
are migrating.  We will do that in the near future.

Link: https://lore.kernel.org/linux-mm/87a6c8c-c5c1-67dc-1e32-eb30831d6e3d@google.com/
Link: https://lore.kernel.org/linux-mm/874jrg7kke.fsf@yhuang6-desk2.ccr.corp.intel.com/
Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Reported-by: Hugh Dickins <hughd@google.com>
Reported-by: "Xu, Pengfei" <pengfei.xu@intel.com>
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
 mm/migrate.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index ef68a1aff35c..bc04c34543f3 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1937,7 +1937,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 		enum migrate_mode mode, int reason, unsigned int *ret_succeeded)
 {
 	int rc, rc_gather;
-	int nr_pages;
+	int nr_pages, batch;
 	struct folio *folio, *folio2;
 	LIST_HEAD(folios);
 	LIST_HEAD(ret_folios);
@@ -1951,6 +1951,11 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 				     mode, reason, &stats, &ret_folios);
 	if (rc_gather < 0)
 		goto out;
+
+	if (mode == MIGRATE_ASYNC)
+		batch = NR_MAX_BATCHED_MIGRATION;
+	else
+		batch = 1;
 again:
 	nr_pages = 0;
 	list_for_each_entry_safe(folio, folio2, from, lru) {
@@ -1961,11 +1966,11 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 		}
 
 		nr_pages += folio_nr_pages(folio);
-		if (nr_pages > NR_MAX_BATCHED_MIGRATION)
+		if (nr_pages >= batch)
 			break;
 	}
-	if (nr_pages > NR_MAX_BATCHED_MIGRATION)
-		list_cut_before(&folios, from, &folio->lru);
+	if (nr_pages >= batch)
+		list_cut_before(&folios, from, &folio2->lru);
 	else
 		list_splice_init(from, &folios);
 	rc = migrate_pages_batch(&folios, get_new_page, put_new_page, private,
-- 
2.39.1

