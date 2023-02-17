Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D04A69B50F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Feb 2023 22:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjBQVsD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Feb 2023 16:48:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjBQVsC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Feb 2023 16:48:02 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77C314EB9
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Feb 2023 13:48:00 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id d10so2157151qtr.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Feb 2023 13:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=enluXHsm7DkEc3hL0ajHrApyhPOHqK5EyqrxYkxs80U=;
        b=pBdWthIls+n16dmQx+0uCIxs88coY3ueOgBTPDqIo2ZjUKm5rXzl00XbA1LHggch4+
         ayNT9pjqN2zGamMiXfsmYn8z9L10SLkOCrgRny0a8xPqIoiBYBQqrGproEXVqOE1d9RV
         ho+OSX9aonEFUfurMbwRw0J/ZfFgVXSlvyF71o7ns9lcX+ik9UwUGtr5IKlIZsEEnUTm
         QfjHZ67OaoNgPkhWnl6YBDrpY7norkpNkC5xGIpTQZbbL5sOG2VY58eUAau8CPXizi6O
         1QjV34ZZkHhhTxRks41EDe3dJZ0oLoq8uJBgSZIcJERPN+NMKWKeCc6dYkXnKHtw8jus
         bSCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=enluXHsm7DkEc3hL0ajHrApyhPOHqK5EyqrxYkxs80U=;
        b=XkZkxWBGn3ay++8DiUx6X6+W4eVwPyqovzUYfnZHfZUrPWxdlSt2K9NuhndEVmyaZC
         zxRc1K2YHZULU/RYxBZK5j+nkTzgCZjdcT0a/Q0SgFd51Vn2O1cAV1XS4G8GHFD0Hyfz
         PWhKPFpUoGg8fGwfnMwBH1Wlq79jNoX8OE4zqs1PqrH52/QcSZdAdnglofXn8yAFc7f5
         4WbrwtQGDIcbh5wQzHrOZMxODbGYM03+JL6hzvXD6cIU3nvkwPglPrCmLdw+cpNMY2zh
         OruZh9bJVQyC54/oNKlZ1RS4f801NVHL/M5O0S4sF6H5y/B+wTr268sPzl90ezihAYnE
         bGDw==
X-Gm-Message-State: AO0yUKUa6wdwwkr3f0/He92cTTbJSH4ZjTb6KWqh/r5ageXWCRgXZe6f
        /MMBjMZ/4hwBdYAmUVS8pU9zoQ==
X-Google-Smtp-Source: AK7set9s13MPA7KIevE05yTqu6MkLcqJ1s2/ei6hCs9yDNe/IGqHKwYXxV+NibSXi7jOLMm0ZposlQ==
X-Received: by 2002:a05:622a:389:b0:3ba:138f:7b46 with SMTP id j9-20020a05622a038900b003ba138f7b46mr3732914qtx.42.1676670479446;
        Fri, 17 Feb 2023 13:47:59 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id r9-20020ac85c89000000b003b869f71eedsm4013713qta.66.2023.02.17.13.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 13:47:58 -0800 (PST)
Date:   Fri, 17 Feb 2023 13:47:48 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Huang Ying <ying.huang@intel.com>
cc:     Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>,
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
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: Re: [PATCH -v5 0/9] migrate_pages(): batch TLB flushing
In-Reply-To: <20230213123444.155149-1-ying.huang@intel.com>
Message-ID: <87a6c8c-c5c1-67dc-1e32-eb30831d6e3d@google.com>
References: <20230213123444.155149-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 13 Feb 2023, Huang Ying wrote:

> From: "Huang, Ying" <ying.huang@intel.com>
> 
> Now, migrate_pages() migrate folios one by one, like the fake code as
> follows,
> 
>   for each folio
>     unmap
>     flush TLB
>     copy
>     restore map
> 
> If multiple folios are passed to migrate_pages(), there are
> opportunities to batch the TLB flushing and copying.  That is, we can
> change the code to something as follows,
> 
>   for each folio
>     unmap
>   for each folio
>     flush TLB
>   for each folio
>     copy
>   for each folio
>     restore map
> 
> The total number of TLB flushing IPI can be reduced considerably.  And
> we may use some hardware accelerator such as DSA to accelerate the
> folio copying.
> 
> So in this patch, we refactor the migrate_pages() implementation and
> implement the TLB flushing batching.  Base on this, hardware
> accelerated folio copying can be implemented.
> 
> If too many folios are passed to migrate_pages(), in the naive batched
> implementation, we may unmap too many folios at the same time.  The
> possibility for a task to wait for the migrated folios to be mapped
> again increases.  So the latency may be hurt.  To deal with this
> issue, the max number of folios be unmapped in batch is restricted to
> no more than HPAGE_PMD_NR in the unit of page.  That is, the influence
> is at the same level of THP migration.
> 
> We use the following test to measure the performance impact of the
> patchset,
> 
> On a 2-socket Intel server,
> 
>  - Run pmbench memory accessing benchmark
> 
>  - Run `migratepages` to migrate pages of pmbench between node 0 and
>    node 1 back and forth.
> 
> With the patch, the TLB flushing IPI reduces 99.1% during the test and
> the number of pages migrated successfully per second increases 291.7%.
> 
> Xin Hao helped to test the patchset on an ARM64 server with 128 cores,
> 2 NUMA nodes.  Test results show that the page migration performance
> increases up to 78%.
> 
> This patchset is based on mm-unstable 2023-02-10.

And back in linux-next this week: I tried next-20230217 overnight.

There is a deadlock in this patchset (and in previous versions: sorry
it's taken me so long to report), but I think one that's easily solved.

I've not bisected to precisely which patch (load can take several hours
to hit the deadlock), but it doesn't really matter, and I expect that
you can guess.

My root and home filesystems are ext4 (4kB blocks with 4kB PAGE_SIZE),
and so is the filesystem I'm testing, ext4 on /dev/loop0 on tmpfs.
So, plenty of ext4 page cache and buffer_heads.

Again and again, the deadlock is seen with buffer_migrate_folio_norefs(),
either in kcompactd0 or in khugepaged trying to compact, or in both:
it ends up calling __lock_buffer(), and that schedules away, waiting
forever to get BH_lock.  I have not identified who is holding BH_lock,
but I imagine a jbd2 journalling thread, and presume that it wants one
of the folio locks which migrate_pages_batch() is already holding; or
maybe it's all more convoluted than that.  Other tasks then back up
waiting on those folio locks held in the batch.

Never a problem with buffer_migrate_folio(), always with the "more
careful" buffer_migrate_folio_norefs().  And the patch below fixes
it for me: I've had enough hours with it now, on enough occasions,
to be confident of that.

Cc'ing Jan Kara, who knows buffer_migrate_folio_norefs() and jbd2
very well, and I hope can assure us that there is an understandable
deadlock here, from holding several random folio locks, then trying
to lock buffers.  Cc'ing fsdevel, because there's a risk that mm
folk think something is safe, when it's not sufficient to cope with
the diversity of filesystems.  I hope nothing more than the below is
needed (and I've had no other problems with the patchset: good job),
but cannot be sure.

[PATCH next] migrate_pages: fix deadlock on buffer heads

When __buffer_migrate_folio() is called from buffer_migrate_folio_norefs(),
force MIGRATE_ASYNC mode so that buffer_migrate_lock_buffers() will only
trylock_buffer(), failing with -EAGAIN as usual if that does not succeed.

Signed-off-by: Hugh Dickins <hughd@google.com>

--- next-20230217/mm/migrate.c
+++ fixed/mm/migrate.c
@@ -748,7 +748,8 @@ static int __buffer_migrate_folio(struct
 	if (folio_ref_count(src) != expected_count)
 		return -EAGAIN;
 
-	if (!buffer_migrate_lock_buffers(head, mode))
+	if (!buffer_migrate_lock_buffers(head,
+			check_refs ? MIGRATE_ASYNC : mode))
 		return -EAGAIN;
 
 	if (check_refs) {
