Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5478F56289C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jul 2022 03:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232623AbiGABzh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 21:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiGABzf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 21:55:35 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C040A3191C;
        Thu, 30 Jun 2022 18:55:34 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LYysb1zs4zkWdf;
        Fri,  1 Jul 2022 09:53:39 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 1 Jul 2022 09:55:33 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 1 Jul 2022 09:55:32 +0800
Subject: Re: Major btrfs fiemap slowdown on file with many extents once in
 cache (RCU stalls?) (Was: [PATCH 1/3] filemap: Correct the conditions for
 marking a folio as accessed)
To:     Dominique MARTINET <dominique.martinet@atmark-techno.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        <linux-btrfs@vger.kernel.org>
CC:     <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Kent Overstreet <kent.overstreet@gmail.com>
References: <20220619151143.1054746-1-willy@infradead.org>
 <20220619151143.1054746-2-willy@infradead.org>
 <Yr1QwVW+sHWlAqKj@atmark-techno.com>
From:   Yu Kuai <yukuai3@huawei.com>
Message-ID: <8cffd985-ba62-c4be-f9af-bb8314df8a67@huawei.com>
Date:   Fri, 1 Jul 2022 09:55:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Yr1QwVW+sHWlAqKj@atmark-techno.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

在 2022/06/30 15:29, Dominique MARTINET 写道:
> Hi Willy, linux-btrfs@vger,
> 
> Matthew Wilcox (Oracle) wrote on Sun, Jun 19, 2022 at 04:11:41PM +0100:
>> We had an off-by-one error which meant that we never marked the first page
>> in a read as accessed.  This was visible as a slowdown when re-reading
>> a file as pages were being evicted from cache too soon.  In reviewing
>> this code, we noticed a second bug where a multi-page folio would be
>> marked as accessed multiple times when doing reads that were less than
>> the size of the folio.
> 
> when debugging an unrelated issue (short reads on btrfs with io_uring
> and O_DIRECT[1]), I noticed that my horrible big file copy speeds fell
> down from ~2GB/s (there's compression and lots of zeroes) to ~100MB/s
> the second time I was copying it with cp.
> 

Hi,

With this patch ctive_page() will be called the second time that page is
mark accessed, which has some extra overhead, however, 2GB/s -> 100MB/s
is insane, I'm not sure how this is possible, but it seems like it has
something to do with this change.(Noted that it's problematic that page
will not mark accessed before this patch).

BTW, during my test, the speed of buffer read in ext4 only fell down a
little.

Thanks,
Kuai
> I've taken a moment to bisect this and came down to this patch.
> 
> [1] https://lore.kernel.org/all/YrrFGO4A1jS0GI0G@atmark-techno.com/T/#u
> 
> 
> 
> Dropping caches (echo 3 > /proc/sys/vm/drop_caches) restore the speed,
> so there appears to be some bad effect to having the file in cache for
> fiemap?
> To be fair that file is pretty horrible:
> ---
> # compsize bigfile
> Processed 1 file, 194955 regular extents (199583 refs), 0 inline.
> Type       Perc     Disk Usage   Uncompressed Referenced
> TOTAL       15%      3.7G          23G          23G
> none       100%      477M         477M         514M
> zstd        14%      3.2G          23G          23G
> ---
> 
> Here's what perf has to say about it on top of this patch when running
> `cp bigfile /dev/null` the first time:
> 
> 98.97%     0.00%  cp       [kernel.kallsyms]    [k]
> entry_SYSCALL_64_after_hwframe
>   entry_SYSCALL_64_after_hwframe
>   do_syscall_64
>    - 93.40% ksys_read
>       - 93.36% vfs_read
>          - 93.25% new_sync_read
>             - 93.20% filemap_read
>                - 83.38% filemap_get_pages
>                   - 82.76% page_cache_ra_unbounded
>                      + 59.72% folio_alloc
>                      + 13.43% read_pages
>                      + 8.75% filemap_add_folio
>                        0.64% xa_load
>                     0.52% filemap_get_read_batch
>                + 8.75% copy_page_to_iter
>    - 4.73% __x64_sys_ioctl
>       - 4.72% do_vfs_ioctl
>          - btrfs_fiemap
>             - 4.70% extent_fiemap
>                + 3.95% btrfs_check_shared
>                + 0.70% get_extent_skip_holes
> 
> and second time:
> 99.90%     0.00%  cp       [kernel.kallsyms]    [k]
> entry_SYSCALL_64_after_hwfram
>   entry_SYSCALL_64_after_hwframe
>   do_syscall_64
>    - 94.62% __x64_sys_ioctl
>         do_vfs_ioctl
>         btrfs_fiemap
>       - extent_fiemap
>          - 50.01% get_extent_skip_holes
>             - 50.00% btrfs_get_extent_fiemap
>                - 49.97% count_range_bits
>                     rb_next
>          + 28.72% lock_extent_bits
>          + 15.55% __clear_extent_bit
>    - 5.21% ksys_read
>       + 5.21% vfs_read
> 
> (if this isn't readable, 95% of the time is spent on fiemap the second
> time around)
> 
> 
> 
> 
> I've also been observing RCU stalls on my laptop with the same workload
> (cp to /dev/null), but unfortunately I could not reproduce in qemu so I
> could not take traces to confirm they are caused by the same commit but
> given the workload I'd say that is it?
> I can rebuild a kernel for my laptop and confirm if you think it should
> be something else.
> 
> 
> I didn't look at the patch itself (yet) so have no suggestion at this
> point - it's plausible the patch fixed something and just exposed slow
> code that had been there all along so it might be better to look at the
> btrfs side first, I don't know.
> If you don't manage to reproduce I'll be happy to test anything thrown
> at me at the very least.
> 
> 
> Thanks,
> 
