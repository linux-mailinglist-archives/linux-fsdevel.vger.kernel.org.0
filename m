Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A2B69E9EE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Feb 2023 23:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjBUWPu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Feb 2023 17:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBUWPt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Feb 2023 17:15:49 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D8D30B22
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Feb 2023 14:15:47 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id l12so5896155qtr.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Feb 2023 14:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lNLvNQaTgrkORnFNXM8YEI2NcwNcW8Au7p1vPa8WB6E=;
        b=lIhneBlLmXwvnGxMh+jiKqoxkLkxAUgW1hje3OSv8bPScevVLnefuGDxJd323hVuoD
         HeIcwrsH+AO9kEvn0qjDfUEjvszXdz8FhiTGdk4py+Mr43P7nND4Vx0y2xDEItGErJ6O
         dxdtRXFnrNwyukfIAOZq/LqLWh7TqVOpV2YBIDMtmbomAPem5gtzXDtrSuAT4t+7cjfG
         Sgi6NKkpyHDoSZEW7NEwiim8uzLUIbBHZNO1mfhiVzP8d9e1LC2Fw3qIq8ZoLIlzB2D4
         XypjONyD99lwreFdAclC6QZQMlk4y1/fh3AgSzRdGf6RwbK+/hTxA/hTY5H3uHInksUo
         m7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lNLvNQaTgrkORnFNXM8YEI2NcwNcW8Au7p1vPa8WB6E=;
        b=pvn+05GCNB9WV6tKurlx+aSHDbxhFLX8YuvJTyMVXa0tt8QNM7SSbeXS0QCYRSE4SZ
         7S7NChKv4jkbJZN+4gvqoFRZnxWO1aD7vTGMoNBtzkpSYRHKcwobi0vWX1U9hCCyHy1Q
         n60wajhFmwILlMgBgGtLalQnNKedH6wh/9o5k/9l6o5JUPu2G2/ID8g3hB8Ornc1hpir
         B9mWhiS2zUvAQxwgOnwhemntdI8i422IyR2IgHpWErx5ERMx2y7eK6LWx5zzOZlOXGJz
         DI/8iPh8z6eG/ZVI8p4x0FXv2+l+osL5pdwdznQTldwHi3+mUpHLqKqsuHvo78JM6mwj
         dmsQ==
X-Gm-Message-State: AO0yUKWP0cRvXCTtw9Y0XmqgSCIYgS+MTT9ekJs5vQxAPFaj22QwlWMj
        rAoV51toRII4Gme1t7ott9FmZQ==
X-Google-Smtp-Source: AK7set/21kKG9fza2q9rp0qzA8ORlS68fee/dgonLGBFNwAFp6xNp4KIdz+SPe4eIfjYsysMAbPrig==
X-Received: by 2002:ac8:5f13:0:b0:3b9:abfb:61cd with SMTP id x19-20020ac85f13000000b003b9abfb61cdmr10668284qta.26.1677017746802;
        Tue, 21 Feb 2023 14:15:46 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id bt11-20020ac8690b000000b003b635a5d56csm1153289qtb.30.2023.02.21.14.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 14:15:44 -0800 (PST)
Date:   Tue, 21 Feb 2023 14:15:33 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     "Huang, Ying" <ying.huang@intel.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>,
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
In-Reply-To: <87a617eloc.fsf@yhuang6-desk2.ccr.corp.intel.com>
Message-ID: <7de52ab4-ce76-12b-e6a6-c170f5d875d2@google.com>
References: <20230213123444.155149-1-ying.huang@intel.com> <87a6c8c-c5c1-67dc-1e32-eb30831d6e3d@google.com> <874jrg7kke.fsf@yhuang6-desk2.ccr.corp.intel.com> <2ab4b33e-f570-a6ff-6315-7d5a4614a7bd@google.com>
 <87a617eloc.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 21 Feb 2023, Huang, Ying wrote:
> Hugh Dickins <hughd@google.com> writes:
> > On Mon, 20 Feb 2023, Huang, Ying wrote:
> >
> >> Hi, Hugh,
> >> 
> >> Hugh Dickins <hughd@google.com> writes:
> >> 
> >> > On Mon, 13 Feb 2023, Huang Ying wrote:
> >> >
> >> >> From: "Huang, Ying" <ying.huang@intel.com>
> >> >> 
> >> >> Now, migrate_pages() migrate folios one by one, like the fake code as
> >> >> follows,
> >> >> 
> >> >>   for each folio
> >> >>     unmap
> >> >>     flush TLB
> >> >>     copy
> >> >>     restore map
> >> >> 
> >> >> If multiple folios are passed to migrate_pages(), there are
> >> >> opportunities to batch the TLB flushing and copying.  That is, we can
> >> >> change the code to something as follows,
> >> >> 
> >> >>   for each folio
> >> >>     unmap
> >> >>   for each folio
> >> >>     flush TLB
> >> >>   for each folio
> >> >>     copy
> >> >>   for each folio
> >> >>     restore map
> >> >> 
> >> >> The total number of TLB flushing IPI can be reduced considerably.  And
> >> >> we may use some hardware accelerator such as DSA to accelerate the
> >> >> folio copying.
> >> >> 
> >> >> So in this patch, we refactor the migrate_pages() implementation and
> >> >> implement the TLB flushing batching.  Base on this, hardware
> >> >> accelerated folio copying can be implemented.
> >> >> 
> >> >> If too many folios are passed to migrate_pages(), in the naive batched
> >> >> implementation, we may unmap too many folios at the same time.  The
> >> >> possibility for a task to wait for the migrated folios to be mapped
> >> >> again increases.  So the latency may be hurt.  To deal with this
> >> >> issue, the max number of folios be unmapped in batch is restricted to
> >> >> no more than HPAGE_PMD_NR in the unit of page.  That is, the influence
> >> >> is at the same level of THP migration.
> >> >> 
> >> >> We use the following test to measure the performance impact of the
> >> >> patchset,
> >> >> 
> >> >> On a 2-socket Intel server,
> >> >> 
> >> >>  - Run pmbench memory accessing benchmark
> >> >> 
> >> >>  - Run `migratepages` to migrate pages of pmbench between node 0 and
> >> >>    node 1 back and forth.
> >> >> 
> >> >> With the patch, the TLB flushing IPI reduces 99.1% during the test and
> >> >> the number of pages migrated successfully per second increases 291.7%.
> >> >> 
> >> >> Xin Hao helped to test the patchset on an ARM64 server with 128 cores,
> >> >> 2 NUMA nodes.  Test results show that the page migration performance
> >> >> increases up to 78%.
> >> >> 
> >> >> This patchset is based on mm-unstable 2023-02-10.
> >> >
> >> > And back in linux-next this week: I tried next-20230217 overnight.
> >> >
> >> > There is a deadlock in this patchset (and in previous versions: sorry
> >> > it's taken me so long to report), but I think one that's easily solved.
> >> >
> >> > I've not bisected to precisely which patch (load can take several hours
> >> > to hit the deadlock), but it doesn't really matter, and I expect that
> >> > you can guess.
> >> >
> >> > My root and home filesystems are ext4 (4kB blocks with 4kB PAGE_SIZE),
> >> > and so is the filesystem I'm testing, ext4 on /dev/loop0 on tmpfs.
> >> > So, plenty of ext4 page cache and buffer_heads.
> >> >
> >> > Again and again, the deadlock is seen with buffer_migrate_folio_norefs(),
> >> > either in kcompactd0 or in khugepaged trying to compact, or in both:
> >> > it ends up calling __lock_buffer(), and that schedules away, waiting
> >> > forever to get BH_lock.  I have not identified who is holding BH_lock,
> >> > but I imagine a jbd2 journalling thread, and presume that it wants one
> >> > of the folio locks which migrate_pages_batch() is already holding; or
> >> > maybe it's all more convoluted than that.  Other tasks then back up
> >> > waiting on those folio locks held in the batch.
> >> >
> >> > Never a problem with buffer_migrate_folio(), always with the "more
> >> > careful" buffer_migrate_folio_norefs().  And the patch below fixes
> >> > it for me: I've had enough hours with it now, on enough occasions,
> >> > to be confident of that.
> >> >
> >> > Cc'ing Jan Kara, who knows buffer_migrate_folio_norefs() and jbd2
> >> > very well, and I hope can assure us that there is an understandable
> >> > deadlock here, from holding several random folio locks, then trying
> >> > to lock buffers.  Cc'ing fsdevel, because there's a risk that mm
> >> > folk think something is safe, when it's not sufficient to cope with
> >> > the diversity of filesystems.  I hope nothing more than the below is
> >> > needed (and I've had no other problems with the patchset: good job),
> >> > but cannot be sure.
> >> >
> >> > [PATCH next] migrate_pages: fix deadlock on buffer heads
> >> >
> >> > When __buffer_migrate_folio() is called from buffer_migrate_folio_norefs(),
> >> > force MIGRATE_ASYNC mode so that buffer_migrate_lock_buffers() will only
> >> > trylock_buffer(), failing with -EAGAIN as usual if that does not succeed.
> >> >
> >> > Signed-off-by: Hugh Dickins <hughd@google.com>
> >> >
> >> > --- next-20230217/mm/migrate.c
> >> > +++ fixed/mm/migrate.c
> >> > @@ -748,7 +748,8 @@ static int __buffer_migrate_folio(struct
> >> >  	if (folio_ref_count(src) != expected_count)
> >> >  		return -EAGAIN;
> >> >  
> >> > -	if (!buffer_migrate_lock_buffers(head, mode))
> >> > +	if (!buffer_migrate_lock_buffers(head,
> >> > +			check_refs ? MIGRATE_ASYNC : mode))
> >> >  		return -EAGAIN;
> >> >  
> >> >  	if (check_refs) {
> >> 
> >> Thank you very much for pointing this out and the fix patch.  Today, my
> >> colleague Pengfei reported a deadlock bug to me.  It seems that we
> >> cannot wait the writeback to complete when we have locked some folios.
> >> Below patch can fix that deadlock.  I don't know whether this is related
> >> to the deadlock you run into.  It appears that we should avoid to
> >> lock/wait synchronously if we have locked more than one folios.
> >
> > Thanks, I've checked now, on next-20230217 without my patch but
> > with your patch below: it took a few hours, but still deadlocks
> > as I described above, so it's not the same issue.
> >
> > Yes, that's a good principle, that we should avoid to lock/wait
> > synchronously once we have locked one folio (hmm, above you say
> > "more than one": I think we mean the same thing, we're just
> > stating it differently, given how the code runs at present).
> >
> > I'm not a great fan of migrate_folio_unmap()'s arguments,
> > "force" followed by "oh, but don't force" (but applaud the recent
> > "avoid_force_lock" as much better than the original "force_lock").
> > I haven't tried, but I wonder if you can avoid both those arguments,
> > and both of these patches, by passing down an adjusted mode (perhaps
> > MIGRATE_ASYNC, or perhaps a new mode) to all callees, once the first
> > folio of a batch has been acquired (then restore to the original mode
> > when starting a new batch).
> 
> Thanks for suggestion!  I think it's a good idea, but it will take me
> some time to think how to implement.
> 
> > (My patch is weak in that it trylocks for buffer_head even on the
> > first folio of a MIGRATE_SYNC norefs batch, although that has never
> > given a problem historically: adjusting the mode after acquiring
> > the first folio would correct that weakness.)
> 
> Further digging shows that this is related to loop device.  That can be
> shown in the following trace,
> 
> [  300.109786] INFO: task kworker/u4:0:9 blocked for more than 147 seconds.
> [  300.110616]       Not tainted 6.2.0-rc4-kvm+ #1314
> [  300.111143] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  300.111985] task:kworker/u4:0    state:D stack:0     pid:9     ppid:2      flags:0x00004000
> [  300.112964] Workqueue: loop4 loop_rootcg_workfn
> [  300.113658] Call Trace:
> [  300.113996]  <TASK>
> [  300.114315]  __schedule+0x43b/0xd00
> [  300.114848]  schedule+0x6a/0xf0
> [  300.115319]  io_schedule+0x4a/0x80
> [  300.115860]  folio_wait_bit_common+0x1b5/0x4e0
> [  300.116430]  ? __pfx_wake_page_function+0x10/0x10
> [  300.116615]  __filemap_get_folio+0x73d/0x770
> [  300.116790]  shmem_get_folio_gfp+0x1fd/0xc80
> [  300.116963]  shmem_write_begin+0x91/0x220
> [  300.117121]  generic_perform_write+0x10e/0x2e0
> [  300.117312]  __generic_file_write_iter+0x17e/0x290
> [  300.117498]  ? generic_write_checks+0x12b/0x1a0
> [  300.117693]  generic_file_write_iter+0x97/0x180
> [  300.117881]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
> [  300.118087]  do_iter_readv_writev+0x13c/0x210
> [  300.118256]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
> [  300.118463]  do_iter_write+0xf6/0x330
> [  300.118608]  vfs_iter_write+0x46/0x70
> [  300.118754]  loop_process_work+0x723/0xfe0
> [  300.118922]  loop_rootcg_workfn+0x28/0x40
> [  300.119078]  process_one_work+0x3cc/0x8d0
> [  300.119240]  worker_thread+0x66/0x630
> [  300.119384]  ? __pfx_worker_thread+0x10/0x10
> [  300.119551]  kthread+0x153/0x190
> [  300.119681]  ? __pfx_kthread+0x10/0x10
> [  300.119833]  ret_from_fork+0x29/0x50
> [  300.119984]  </TASK>
> 
> When a folio of the loop device is written back, the underlying shmem
> needs to be written back.  Which will acquire the lock of the folio of
> shmem.  While that folio may be locked by migrate_pages_batch() already.
> 
> Your testing involves the loop device too.  So is it related to loop?
> For example, after the buffer head was locked, is it possible to acquire
> lock for folios of the underlying file system?

To lock (other than trylock) a folio while holding a buffer head lock
would violate lock ordering: they are both bit spin locks, so lockdep
would not notice, but I'm sure any such violation would have been
caught long ago (unless on some very unlikely path).

There was nothing in the stack traces I looked at to implicate loop,
though admittedly I paid much more attention to the kcompactd0 and
khugepaged pattern which was emerging - the few times I looked at the
loop0 thread, IIRC it was either idle or waiting on the lower level.

If it had a stack trace like you show above, I would just have ignored
that as of little interest, as probably waiting on one of the migrate
batch's locked folios, which were themselves waiting on a buffer_head
lock somewhere.  (And shmem itself doesn't use buffer_heads.)

But it's still an interesting idea that these deadlocks might be
related to loop: loop by its nature certainly has a propensity for
deadlocks, though I think those have all been ironed out years ago.

I've run my load overnight using a small ext4 partition instead of
ext4 on loop on tmpfs, and that has not deadlocked.  I hesitate to
say that confirms your idea that loop is somehow causing the deadlock
- the timings will have changed, so I've no idea how long such a
modified load needs to run to give confidence; but it does suggest
that you're right.

Though I still think your principle, that we should avoid to lock/wait
synchronously once the batch holds one folio, is the safe principle to
follow anyway, whether or not the deadlocks can be pinned on loop.

Hugh
