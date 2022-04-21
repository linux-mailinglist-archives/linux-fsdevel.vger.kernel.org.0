Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44DD7509A4D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Apr 2022 10:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiDUIPf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 04:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357117AbiDUIPc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 04:15:32 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BBE1F62D;
        Thu, 21 Apr 2022 01:12:43 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KkVdW5c14zhXYn;
        Thu, 21 Apr 2022 16:12:31 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Apr 2022 16:12:40 +0800
Subject: Re: [PATCH v13 2/7] mm: factor helpers for memory_failure_dev_pagemap
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Shiyang Ruan <ruansy.fnst@fujitsu.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "jane.chu@oracle.com" <jane.chu@oracle.com>,
        Christoph Hellwig <hch@lst.de>
References: <20220419045045.1664996-1-ruansy.fnst@fujitsu.com>
 <20220419045045.1664996-3-ruansy.fnst@fujitsu.com>
 <20220421061344.GA3607858@hori.linux.bs1.fc.nec.co.jp>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <564100f4-fb8f-e2cf-db69-495294090ba4@huawei.com>
Date:   Thu, 21 Apr 2022 16:12:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220421061344.GA3607858@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022/4/21 14:13, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Tue, Apr 19, 2022 at 12:50:40PM +0800, Shiyang Ruan wrote:
>> memory_failure_dev_pagemap code is a bit complex before introduce RMAP
>> feature for fsdax.  So it is needed to factor some helper functions to
>> simplify these code.
>>
>> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
>> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> 
> Thanks for the refactoring.  As I commented to 0/7, the conflict with
> "mm/hwpoison: fix race between hugetlb free/demotion and memory_failure_hugetlb()"
> can be trivially resolved.
> 
> Another few comment below ...
> 
>> ---
>>  mm/memory-failure.c | 157 ++++++++++++++++++++++++--------------------
>>  1 file changed, 87 insertions(+), 70 deletions(-)
>>
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index e3fbff5bd467..7c8c047bfdc8 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -1498,6 +1498,90 @@ static int try_to_split_thp_page(struct page *page, const char *msg)
>>  	return 0;
>>  }
>>
>> +static void unmap_and_kill(struct list_head *to_kill, unsigned long pfn,
>> +		struct address_space *mapping, pgoff_t index, int flags)
>> +{
>> +	struct to_kill *tk;
>> +	unsigned long size = 0;
>> +
>> +	list_for_each_entry(tk, to_kill, nd)
>> +		if (tk->size_shift)
>> +			size = max(size, 1UL << tk->size_shift);
>> +
>> +	if (size) {
>> +		/*
>> +		 * Unmap the largest mapping to avoid breaking up device-dax
>> +		 * mappings which are constant size. The actual size of the
>> +		 * mapping being torn down is communicated in siginfo, see
>> +		 * kill_proc()
>> +		 */
>> +		loff_t start = (index << PAGE_SHIFT) & ~(size - 1);
>> +
>> +		unmap_mapping_range(mapping, start, size, 0);
>> +	}
>> +
>> +	kill_procs(to_kill, flags & MF_MUST_KILL, false, pfn, flags);
>> +}
>> +
>> +static int mf_generic_kill_procs(unsigned long long pfn, int flags,
>> +		struct dev_pagemap *pgmap)
>> +{
>> +	struct page *page = pfn_to_page(pfn);
>> +	LIST_HEAD(to_kill);
>> +	dax_entry_t cookie;
>> +	int rc = 0;
>> +
>> +	/*
>> +	 * Pages instantiated by device-dax (not filesystem-dax)
>> +	 * may be compound pages.
>> +	 */
>> +	page = compound_head(page);
>> +
>> +	/*
>> +	 * Prevent the inode from being freed while we are interrogating
>> +	 * the address_space, typically this would be handled by
>> +	 * lock_page(), but dax pages do not use the page lock. This
>> +	 * also prevents changes to the mapping of this pfn until
>> +	 * poison signaling is complete.
>> +	 */
>> +	cookie = dax_lock_page(page);
>> +	if (!cookie)
>> +		return -EBUSY;
>> +
>> +	if (hwpoison_filter(page)) {
>> +		rc = -EOPNOTSUPP;
>> +		goto unlock;
>> +	}
>> +
>> +	if (pgmap->type == MEMORY_DEVICE_PRIVATE) {
>> +		/*
>> +		 * TODO: Handle HMM pages which may need coordination
>> +		 * with device-side memory.
>> +		 */
>> +		return -EBUSY;
> 
> Don't we need to go to dax_unlock_page() as the origincal code do?

I think dax_unlock_page is needed too and please remember set rc to -EBUSY before out.

> 
>> +	}
>> +
>> +	/*
>> +	 * Use this flag as an indication that the dax page has been
>> +	 * remapped UC to prevent speculative consumption of poison.
>> +	 */
>> +	SetPageHWPoison(page);
>> +
>> +	/*
>> +	 * Unlike System-RAM there is no possibility to swap in a
>> +	 * different physical page at a given virtual address, so all
>> +	 * userspace consumption of ZONE_DEVICE memory necessitates
>> +	 * SIGBUS (i.e. MF_MUST_KILL)
>> +	 */
>> +	flags |= MF_ACTION_REQUIRED | MF_MUST_KILL;
>> +	collect_procs(page, &to_kill, true);
>> +
>> +	unmap_and_kill(&to_kill, pfn, page->mapping, page->index, flags);
>> +unlock:
>> +	dax_unlock_page(page, cookie);
>> +	return rc;
>> +}
>> +
>>  /*
>>   * Called from hugetlb code with hugetlb_lock held.
>>   *
>> @@ -1644,12 +1728,8 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
>>  		struct dev_pagemap *pgmap)
>>  {
>>  	struct page *page = pfn_to_page(pfn);
>> -	unsigned long size = 0;
>> -	struct to_kill *tk;
>>  	LIST_HEAD(tokill);
> 
> Is this variable unused in this function?

There has a to_kill in mf_generic_kill_procs. So this one is unneeded. We should remove it.

> 
> Thanks,
> Naoya Horiguchi
> 

Except for the above nit, the patch looks good to me. Thanks!

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

