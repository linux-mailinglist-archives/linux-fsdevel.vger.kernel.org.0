Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 346072CB596
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 08:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbgLBHO5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 02:14:57 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:13741 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728105AbgLBHO5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 02:14:57 -0500
X-IronPort-AV: E=Sophos;i="5.78,385,1599494400"; 
   d="scan'208";a="101976775"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 02 Dec 2020 15:14:10 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 11B374CE5CF5;
        Wed,  2 Dec 2020 15:14:06 +0800 (CST)
Received: from irides.mr (10.167.225.141) by G08CNEXMBPEKD05.g08.fujitsu.local
 (10.167.33.204) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 2 Dec
 2020 15:14:05 +0800
Subject: Re: [RFC PATCH v2 0/6] fsdax: introduce fs query to support reflink
To:     Dave Chinner <david@fromorbit.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-raid@vger.kernel.org>,
        <darrick.wong@oracle.com>, <dan.j.williams@intel.com>,
        <hch@lst.de>, <song@kernel.org>, <rgoldwyn@suse.de>,
        <qi.fuli@fujitsu.com>, <y-goto@fujitsu.com>
References: <20201123004116.2453-1-ruansy.fnst@cn.fujitsu.com>
 <20201129224723.GG2842436@dread.disaster.area>
From:   Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>
Message-ID: <e0aa187f-e124-1ddc-0f5a-6a8c41a3dc66@cn.fujitsu.com>
Date:   Wed, 2 Dec 2020 15:12:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201129224723.GG2842436@dread.disaster.area>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204)
X-yoursite-MailScanner-ID: 11B374CE5CF5.A2628
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Dave,

On 2020/11/30 上午6:47, Dave Chinner wrote:
> On Mon, Nov 23, 2020 at 08:41:10AM +0800, Shiyang Ruan wrote:
>> 
>> The call trace is like this:
>>   memory_failure()
>>     pgmap->ops->memory_failure()   => pmem_pgmap_memory_failure()
>>      gendisk->fops->block_lost()   => pmem_block_lost() or
>>                                           md_blk_block_lost()
>>       sb->s_ops->storage_lost()    => xfs_fs_storage_lost()
>>        xfs_rmap_query_range()
>>         xfs_storage_lost_helper()
>>          mf_recover_controller->recover_fn => \
>>                              memory_failure_dev_pagemap_kill_procs()
>>
>> The collect_procs() and kill_procs() are moved into a callback which
>> is passed from memory_failure() to xfs_storage_lost_helper().  So we
>> can call it when a file assocaited is found, instead of creating a
>> file list and iterate it.
>>
>> The fsdax & reflink support for XFS is not contained in this patchset.
> 
> This looks promising - the overall architecture is a lot more
> generic and less dependent on knowing about memory, dax or memory
> failures. A few comments that I think would further improve
> understanding the patchset and the implementation:

Thanks for your kindly comment.  It gives me confidence.

> 
> - the order of the patches is inverted. It should start with a
>    single patch introducing the mf_recover_controller structure for
>    callbacks, then introduce pgmap->ops->memory_failure, then
>    ->block_lost, then the pmem and md implementations of ->block
>    list, then ->storage_lost and the XFS implementations of
>    ->storage_lost.

Yes, it will be easier to understand the patchset in this order.

But I have something unsure: for example, I introduce ->memory_failure() 
firstly, but the implementation of ->memory_failure() needs to call 
->block_lost() which is supposed to be introduced in the next patch. So, 
I am not sure the code is supposed to be what in the implementation of 
->memory_failure() in pmem?  To avoid this situation, I committed the 
patches in the inverted order: lowest level first, then its caller, and 
then caller's caller.

I am trying to sort out the order.  How about this:
  Patch i.
    Introduce ->memory_failure()
       - just introduce interface, without implementation
  Patch i++.
    Introduce ->block_lost()
       - introduce interface and implement ->memory_failure()
          in pmem, so that it can call ->block_lost()
  Patch i++.
    (similar with above, skip...)

> 
> - I think the names "block_lost" and "storage_lost" are misleading.
>    It's more like a "media failure" or a general "data corruption"
>    event at a specific physical location. The data may not be "lost"
>    but only damaged, so we might be able to recover from it without
>    "losing" anything. Hence I think they could be better named,
>    perhaps just "->corrupt_range"

'corrupt' sounds better.  (I'm not good at naming functions...)

> 
> - need to pass a {offset,len} pair through the chain, not just a
>    single offset. This will allow other types of devices to report
>    different ranges of failures, from a single sector to an entire
>    device.

Yes, it's better to add the length.  I restrictively thought that 
memory-failure on pmem should affect one single page at one time.

> 
> - I'm not sure that passing the mf_recover_controller structure
>    through the corruption event chain is the right thing to do here.
>    A block device could generate this storage failure callback if it
>    detects an unrecoverable error (e.g. during a MD media scrub or
>    rebuild/resilver failure) and in that case we don't have PFNs or
>    memory device failure functions to perform.
> 
>    IOWs, I think the action that is taken needs to be independent of
>    the source that generated the error. Even for a pmem device, we
>    can be using the page cache, so it may be possible to recover the
>    pmem error by writing the cached page (if it exists) back over the
>    pmem.
> 
>    Hence I think that the recover function probably needs to be moved
>    to the address space ops, because what we do to recover from the
>    error is going to be dependent on type of mapping the filesystem
>    is using. If it's a DAX mapping, we call back into a generic DAX
>    function that does the vma walk and process kill functions. If it
>    is a page cache mapping, then if the page is cached then we can
>    try to re-write it to disk to fix the bad data, otherwise we treat
>    it like a writeback error and report it on the next
>    write/fsync/close operation done on that file.
> 
>    This gets rid of the mf_recover_controller altogether and allows
>    the interface to be used by any sort of block device for any sort
>    of bottom-up reporting of media/device failures.

Moving the recover function to the address_space ops looks a better 
idea. But I think that the error handler for page cache mapping is 
finished well in memory-failure.  The memory-failure is also reused to 
handles anonymous page.  If we move the recover function to 
address_space ops, I think we also need to refactor the existing handler 
for page cache mapping, which may affect anonymous page handling.  This 
makes me confused...


I rewrote the call trace:
memory_failure()
  * dax mapping case
  pgmap->ops->memory_failure()          =>
                                    pmem_pgmap_memory_failure()
   gendisk->fops->block_corrupt_range() =>
                                    - pmem_block_corrupt_range()
                                    - md_blk_block_corrupt_range()
    sb->s_ops->storage_currupt_range()  =>
                                    xfs_fs_storage_corrupt_range()
     xfs_rmap_query_range()
      xfs_storage_lost_helper()
       mapping->a_ops->corrupt_range()  =>
                                    xfs_dax_aops.xfs_dax_corrupt_range
        memory_failure_dev_pagemap_kill_procs()

  * page cache mapping case
  mapping->a_ops->corrupt_range()       =>
                                    xfs_address_space_operations.xfs_xxx
   memory_failure_generic_kill_procs()

It's rough and not completed yet.  Hope for your comment.

-- 
Thanks,
Ruan Shiyang.

> 
> Cheers,
> 
> Dave.
> 


