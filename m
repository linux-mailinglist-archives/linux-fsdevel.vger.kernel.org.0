Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B5769D94B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Feb 2023 04:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbjBUDfl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Feb 2023 22:35:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbjBUDfk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Feb 2023 22:35:40 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DF122010;
        Mon, 20 Feb 2023 19:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676950538; x=1708486538;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=sHyz9JBEMfr4zWFfJP79P+ll8Tc7eSLrV9qHgSEnsTg=;
  b=b2wud2jm34df5PiTEi7wmCajeRkU8xs/HGnszKUTO+6g9nbamYzfpo6v
   9BTuc/AVLU3+VnRMoiS2zeKTXeEtMVGAHyKS19+IQWWdJxgf1QnJuj6Wf
   Hr8NHfOBB7vM/1H9ztrY2epxCBl0JeUc7OALDVc+2xZ75rj/JGEwhDdW5
   GMIS8oBX7+zUV6A0/2fURbo0OSWyynToqn4sm5Z47Q11cq0t/3GG2SSvC
   tArUjQrV+bCaSFIb4XgsG9ROIAzzEd20s20CNQbsbCumAlQmn3qH0XzGr
   V+EbZ48CFeKF3zGbNJ1Kh8jVe74k3ugyHUkBhWL3zm5PiqUoGBMiIpGi5
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="397216691"
X-IronPort-AV: E=Sophos;i="5.97,314,1669104000"; 
   d="scan'208";a="397216691"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2023 19:35:37 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="664821026"
X-IronPort-AV: E=Sophos;i="5.97,314,1669104000"; 
   d="scan'208";a="664821026"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2023 19:35:32 -0800
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
Date:   Tue, 21 Feb 2023 11:34:27 +0800
In-Reply-To: <2ab4b33e-f570-a6ff-6315-7d5a4614a7bd@google.com> (Hugh Dickins's
        message of "Mon, 20 Feb 2023 18:48:38 -0800 (PST)")
Message-ID: <87a617eloc.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

Thanks for suggestion!  I think it's a good idea, but it will take me
some time to think how to implement.

> (My patch is weak in that it trylocks for buffer_head even on the
> first folio of a MIGRATE_SYNC norefs batch, although that has never
> given a problem historically: adjusting the mode after acquiring
> the first folio would correct that weakness.)

Further digging shows that this is related to loop device.  That can be
shown in the following trace,

[  300.109786] INFO: task kworker/u4:0:9 blocked for more than 147 seconds.
[  300.110616]       Not tainted 6.2.0-rc4-kvm+ #1314
[  300.111143] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  300.111985] task:kworker/u4:0    state:D stack:0     pid:9     ppid:2      flags:0x00004000
[  300.112964] Workqueue: loop4 loop_rootcg_workfn
[  300.113658] Call Trace:
[  300.113996]  <TASK>
[  300.114315]  __schedule+0x43b/0xd00
[  300.114848]  schedule+0x6a/0xf0
[  300.115319]  io_schedule+0x4a/0x80
[  300.115860]  folio_wait_bit_common+0x1b5/0x4e0
[  300.116430]  ? __pfx_wake_page_function+0x10/0x10
[  300.116615]  __filemap_get_folio+0x73d/0x770
[  300.116790]  shmem_get_folio_gfp+0x1fd/0xc80
[  300.116963]  shmem_write_begin+0x91/0x220
[  300.117121]  generic_perform_write+0x10e/0x2e0
[  300.117312]  __generic_file_write_iter+0x17e/0x290
[  300.117498]  ? generic_write_checks+0x12b/0x1a0
[  300.117693]  generic_file_write_iter+0x97/0x180
[  300.117881]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[  300.118087]  do_iter_readv_writev+0x13c/0x210
[  300.118256]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[  300.118463]  do_iter_write+0xf6/0x330
[  300.118608]  vfs_iter_write+0x46/0x70
[  300.118754]  loop_process_work+0x723/0xfe0
[  300.118922]  loop_rootcg_workfn+0x28/0x40
[  300.119078]  process_one_work+0x3cc/0x8d0
[  300.119240]  worker_thread+0x66/0x630
[  300.119384]  ? __pfx_worker_thread+0x10/0x10
[  300.119551]  kthread+0x153/0x190
[  300.119681]  ? __pfx_kthread+0x10/0x10
[  300.119833]  ret_from_fork+0x29/0x50
[  300.119984]  </TASK>

When a folio of the loop device is written back, the underlying shmem
needs to be written back.  Which will acquire the lock of the folio of
shmem.  While that folio may be locked by migrate_pages_batch() already.

Your testing involves the loop device too.  So is it related to loop?
For example, after the buffer head was locked, is it possible to acquire
lock for folios of the underlying file system?

Best Regards,
Huang, Ying
