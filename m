Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5462069EA1E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Feb 2023 23:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjBUWZt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Feb 2023 17:25:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjBUWZs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Feb 2023 17:25:48 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0496311CA
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Feb 2023 14:25:46 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id oj14so6664989qvb.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Feb 2023 14:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mhaTjoGH7VJWCphvDW2ykyIb5PsyF67iAGu6nul2kos=;
        b=dPP8UQcEI5q2OYNRVNdJP8ptvACzfJyDI+4yjspMT1jpRA7dnlmvpAqNvsxPX6O6Wd
         8jQjohV4yhFsq2meMG29HhdjMr7zyVEKwknIWBlT63soaeJbSRm7t4Q9DFr1dwAgHV1m
         EXOqW42nm65qklNlnRJGN1jXDayfVdLNHCTf4MTwFgMxbtbZsrNRufk5QooOnOhCUkwN
         Xxxr5edTQVJ85SY94Ke9DaZToAJCXFD1drhdfxohfoISMpt/JuwGmXitS86ryrKakBH/
         IXXjDDwUPtrlPRap14/V/2jaPYMW/tOGpcCYtuhXEjCcBjC8QHPIr3NOZr+5tn71RGSI
         OTyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mhaTjoGH7VJWCphvDW2ykyIb5PsyF67iAGu6nul2kos=;
        b=qt1boZk1RRLU4/tvMAs1JgC9j69oJ1WdvIqzCkvJ2ZwomKhVRTE4b6mBlyM8iO2R2Y
         zNsgV0ZXsUE8JzQMkMWWwTpuidCs6jZ10iDyYG+vu1jERI6ZR2BWAjEQstjkbycoqsZ4
         6xadVTsOuPDDF5mx3/En+492xmWn8lXheG6DE5u7eJp3PefjbdKCEpRDB/8Yfg/zIALb
         0dMZR6hITmGI1ogol//p8BF4YT8ojIg+h0/4dURDAe/mtAqo2Z0xEakmmvtrPvT1p+p1
         nc5wf+6hA2WwSwJWFl4Rg9vjj1Sy7z447Mie1BitgKxKGQwqidptFZ1DAqKBxAw3i/yT
         luYA==
X-Gm-Message-State: AO0yUKWyr8UEZAuFcOxuuZCrQs2vFH406oE7n28ts/6xMuxCZJUabtDg
        ne6spkxCwkiK3BVA941kJSciMnQfXoIHahcH8i0=
X-Google-Smtp-Source: AK7set+28Brx2HsGPuSWzITqEU9LSJkbpjZkfY54aqATfrj5w5ricvR7PbJ7RESQwo81uBQBlt0zEA==
X-Received: by 2002:a05:6214:2a8d:b0:56c:15c9:b5f0 with SMTP id jr13-20020a0562142a8d00b0056c15c9b5f0mr9907081qvb.17.1677018345809;
        Tue, 21 Feb 2023 14:25:45 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d65-20020a37b444000000b0073b3316bbd0sm2706995qkf.29.2023.02.21.14.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 14:25:43 -0800 (PST)
Date:   Tue, 21 Feb 2023 14:25:41 -0800 (PST)
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
In-Reply-To: <871qmjdsj0.fsf@yhuang6-desk2.ccr.corp.intel.com>
Message-ID: <20f1628e-96a7-3a5d-fef5-dae31f8eb196@google.com>
References: <20230213123444.155149-1-ying.huang@intel.com> <87a6c8c-c5c1-67dc-1e32-eb30831d6e3d@google.com> <874jrg7kke.fsf@yhuang6-desk2.ccr.corp.intel.com> <2ab4b33e-f570-a6ff-6315-7d5a4614a7bd@google.com>
 <871qmjdsj0.fsf@yhuang6-desk2.ccr.corp.intel.com>
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
> 
> On second thought, I think that it may be better to provide a fix as
> simple as possible firstly.  Then we can work on a more complex fix as
> we discussed above.  The simple fix is easy to review now.  And, we will
> have more time to test and review the complex fix.
> 
> In the following fix, I disabled the migration batching except for the
> MIGRATE_ASYNC mode, or the split folios of a THP folio.  After that, I
> will work on the complex fix to enable migration batching for all modes.
> 
> What do you think about that?

I don't think there's a need to rush in the wrong fix so quickly.
Your series was in (though sometimes out of) linux-next for some
while, without causing any widespread problems.  Andrew did send
it to Linus yesterday, I expect he'll be pushing it out later today
or tomorrow, but I don't think it's going to cause big problems.
Aiming for a fix in -rc2 would be good.  Why would it be complex?

Hugh

> 
> Best Regards,
> Huang, Ying
> 
> -------------------------------8<---------------------------------
> From 8e475812eacd9f2eeac76776c2b1a17af3e59b89 Mon Sep 17 00:00:00 2001
> From: Huang Ying <ying.huang@intel.com>
> Date: Tue, 21 Feb 2023 16:37:50 +0800
> Subject: [PATCH] migrate_pages: fix deadlock in batched migration
> 
> Two deadlock bugs were reported for the migrate_pages() batching
> series.  Thanks Hugh and Pengfei!  For example, in the following
> deadlock trace snippet,
> 
>  INFO: task kworker/u4:0:9 blocked for more than 147 seconds.
>        Not tainted 6.2.0-rc4-kvm+ #1314
>  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>  task:kworker/u4:0    state:D stack:0     pid:9     ppid:2      flags:0x00004000
>  Workqueue: loop4 loop_rootcg_workfn
>  Call Trace:
>   <TASK>
>   __schedule+0x43b/0xd00
>   schedule+0x6a/0xf0
>   io_schedule+0x4a/0x80
>   folio_wait_bit_common+0x1b5/0x4e0
>   ? __pfx_wake_page_function+0x10/0x10
>   __filemap_get_folio+0x73d/0x770
>   shmem_get_folio_gfp+0x1fd/0xc80
>   shmem_write_begin+0x91/0x220
>   generic_perform_write+0x10e/0x2e0
>   __generic_file_write_iter+0x17e/0x290
>   ? generic_write_checks+0x12b/0x1a0
>   generic_file_write_iter+0x97/0x180
>   ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
>   do_iter_readv_writev+0x13c/0x210
>   ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
>   do_iter_write+0xf6/0x330
>   vfs_iter_write+0x46/0x70
>   loop_process_work+0x723/0xfe0
>   loop_rootcg_workfn+0x28/0x40
>   process_one_work+0x3cc/0x8d0
>   worker_thread+0x66/0x630
>   ? __pfx_worker_thread+0x10/0x10
>   kthread+0x153/0x190
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork+0x29/0x50
>   </TASK>
> 
>  INFO: task repro:1023 blocked for more than 147 seconds.
>        Not tainted 6.2.0-rc4-kvm+ #1314
>  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>  task:repro           state:D stack:0     pid:1023  ppid:360    flags:0x00004004
>  Call Trace:
>   <TASK>
>   __schedule+0x43b/0xd00
>   schedule+0x6a/0xf0
>   io_schedule+0x4a/0x80
>   folio_wait_bit_common+0x1b5/0x4e0
>   ? compaction_alloc+0x77/0x1150
>   ? __pfx_wake_page_function+0x10/0x10
>   folio_wait_bit+0x30/0x40
>   folio_wait_writeback+0x2e/0x1e0
>   migrate_pages_batch+0x555/0x1ac0
>   ? __pfx_compaction_alloc+0x10/0x10
>   ? __pfx_compaction_free+0x10/0x10
>   ? __this_cpu_preempt_check+0x17/0x20
>   ? lock_is_held_type+0xe6/0x140
>   migrate_pages+0x100e/0x1180
>   ? __pfx_compaction_free+0x10/0x10
>   ? __pfx_compaction_alloc+0x10/0x10
>   compact_zone+0xe10/0x1b50
>   ? lock_is_held_type+0xe6/0x140
>   ? check_preemption_disabled+0x80/0xf0
>   compact_node+0xa3/0x100
>   ? __sanitizer_cov_trace_const_cmp8+0x1c/0x30
>   ? _find_first_bit+0x7b/0x90
>   sysctl_compaction_handler+0x5d/0xb0
>   proc_sys_call_handler+0x29d/0x420
>   proc_sys_write+0x2b/0x40
>   vfs_write+0x3a3/0x780
>   ksys_write+0xb7/0x180
>   __x64_sys_write+0x26/0x30
>   do_syscall_64+0x3b/0x90
>   entry_SYSCALL_64_after_hwframe+0x72/0xdc
>  RIP: 0033:0x7f3a2471f59d
>  RSP: 002b:00007ffe567f7288 EFLAGS: 00000217 ORIG_RAX: 0000000000000001
>  RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f3a2471f59d
>  RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
>  RBP: 00007ffe567f72a0 R08: 0000000000000010 R09: 0000000000000010
>  R10: 0000000000000010 R11: 0000000000000217 R12: 00000000004012e0
>  R13: 00007ffe567f73e0 R14: 0000000000000000 R15: 0000000000000000
>   </TASK>
> 
> The page migration task has held the lock of the shmem folio A, and is
> waiting the writeback of the folio B of the file system on the loop
> block device to complete.  While the loop worker task which writes
> back the folio B is waiting to lock the shmem folio A, because the
> folio A backs the folio B in the loop device.  Thus deadlock is
> triggered.
> 
> In general, if we have locked some other folios except the one we are
> migrating, it's not safe to wait synchronously, for example, to wait
> the writeback to complete or wait to lock the buffer head.
> 
> To fix the deadlock, in this patch, we avoid to batch the page
> migration except for MIGRATE_ASYNC mode or the split folios of a THP
> folio.  In MIGRATE_ASYNC mode, synchronous waiting is avoided.  And
> there isn't any dependency relationship among the split folios of a
> THP folio.
> 
> The fix can be improved via converting migration mode from synchronous
> to asynchronous if we have locked some other folios except the one we
> are migrating.  We will do that in the near future.
> 
> Link: https://lore.kernel.org/linux-mm/87a6c8c-c5c1-67dc-1e32-eb30831d6e3d@google.com/
> Link: https://lore.kernel.org/linux-mm/874jrg7kke.fsf@yhuang6-desk2.ccr.corp.intel.com/
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Reported-by: Hugh Dickins <hughd@google.com>
> Reported-by: "Xu, Pengfei" <pengfei.xu@intel.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Stefan Roesch <shr@devkernel.io>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Xin Hao <xhao@linux.alibaba.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  mm/migrate.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index ef68a1aff35c..bc04c34543f3 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1937,7 +1937,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  		enum migrate_mode mode, int reason, unsigned int *ret_succeeded)
>  {
>  	int rc, rc_gather;
> -	int nr_pages;
> +	int nr_pages, batch;
>  	struct folio *folio, *folio2;
>  	LIST_HEAD(folios);
>  	LIST_HEAD(ret_folios);
> @@ -1951,6 +1951,11 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  				     mode, reason, &stats, &ret_folios);
>  	if (rc_gather < 0)
>  		goto out;
> +
> +	if (mode == MIGRATE_ASYNC)
> +		batch = NR_MAX_BATCHED_MIGRATION;
> +	else
> +		batch = 1;
>  again:
>  	nr_pages = 0;
>  	list_for_each_entry_safe(folio, folio2, from, lru) {
> @@ -1961,11 +1966,11 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  		}
>  
>  		nr_pages += folio_nr_pages(folio);
> -		if (nr_pages > NR_MAX_BATCHED_MIGRATION)
> +		if (nr_pages >= batch)
>  			break;
>  	}
> -	if (nr_pages > NR_MAX_BATCHED_MIGRATION)
> -		list_cut_before(&folios, from, &folio->lru);
> +	if (nr_pages >= batch)
> +		list_cut_before(&folios, from, &folio2->lru);
>  	else
>  		list_splice_init(from, &folios);
>  	rc = migrate_pages_batch(&folios, get_new_page, put_new_page, private,
> -- 
> 2.39.1
