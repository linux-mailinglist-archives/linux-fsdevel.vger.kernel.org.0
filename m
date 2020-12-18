Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F87A2DDCB0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Dec 2020 02:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731635AbgLRBvQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Dec 2020 20:51:16 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:65507 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727138AbgLRBvQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Dec 2020 20:51:16 -0500
X-IronPort-AV: E=Sophos;i="5.78,428,1599494400"; 
   d="scan'208";a="102687225"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 18 Dec 2020 09:50:28 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id D0B364CE6014;
        Fri, 18 Dec 2020 09:50:25 +0800 (CST)
Received: from irides.mr (10.167.225.141) by G08CNEXMBPEKD05.g08.fujitsu.local
 (10.167.33.204) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 18 Dec
 2020 09:50:25 +0800
Subject: Re: [RFC PATCH v3 4/9] mm, fsdax: Refactor memory-failure handler for
 dax mapping
To:     Dave Chinner <david@fromorbit.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-raid@vger.kernel.org>,
        <darrick.wong@oracle.com>, <dan.j.williams@intel.com>,
        <hch@lst.de>, <song@kernel.org>, <rgoldwyn@suse.de>,
        <qi.fuli@fujitsu.com>, <y-goto@fujitsu.com>
References: <20201215121414.253660-1-ruansy.fnst@cn.fujitsu.com>
 <20201215121414.253660-5-ruansy.fnst@cn.fujitsu.com>
 <20201216212648.GN632069@dread.disaster.area>
From:   Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>
Message-ID: <513e7602-80d7-8d8c-ed5d-06b8113823bf@cn.fujitsu.com>
Date:   Fri, 18 Dec 2020 09:48:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201216212648.GN632069@dread.disaster.area>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204)
X-yoursite-MailScanner-ID: D0B364CE6014.AB9CB
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2020/12/17 上午5:26, Dave Chinner wrote:
> On Tue, Dec 15, 2020 at 08:14:09PM +0800, Shiyang Ruan wrote:
>> The current memory_failure_dev_pagemap() can only handle single-mapped
>> dax page for fsdax mode.  The dax page could be mapped by multiple files
>> and offsets if we let reflink feature & fsdax mode work together.  So,
>> we refactor current implementation to support handle memory failure on
>> each file and offset.
>>
>> Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
>> ---
> .....
>>   static const char *action_name[] = {
>> @@ -1147,6 +1148,60 @@ static int try_to_split_thp_page(struct page *page, const char *msg)
>>   	return 0;
>>   }
>>   
>> +int mf_dax_mapping_kill_procs(struct address_space *mapping, pgoff_t index, int flags)
>> +{
>> +	const bool unmap_success = true;
>> +	unsigned long pfn, size = 0;
>> +	struct to_kill *tk;
>> +	LIST_HEAD(to_kill);
>> +	int rc = -EBUSY;
>> +	loff_t start;
>> +	dax_entry_t cookie;
>> +
>> +	/*
>> +	 * Prevent the inode from being freed while we are interrogating
>> +	 * the address_space, typically this would be handled by
>> +	 * lock_page(), but dax pages do not use the page lock. This
>> +	 * also prevents changes to the mapping of this pfn until
>> +	 * poison signaling is complete.
>> +	 */
>> +	cookie = dax_lock(mapping, index, &pfn);
>> +	if (!cookie)
>> +		goto unlock;
> 
> Why do we need to prevent the inode from going away here? This
> function gets called by XFS after doing an xfs_iget() call to grab
> the inode that owns the block. Hence the the inode (and the mapping)
> are guaranteed to be referenced and can't go away. Hence for the
> filesystem based callers, this whole "dax_lock()" thing can go away >
> So, AFAICT, the dax_lock() stuff is only necessary when the
> filesystem can't be used to resolve the owner of physical page that
> went bad....

Yes, you are right.  I made a mistake in the calling sequence here. 
Thanks for pointing out.


--
Thanks,
Ruan Shiyang.

> 
> Cheers,
> 
> Dave.
> 


