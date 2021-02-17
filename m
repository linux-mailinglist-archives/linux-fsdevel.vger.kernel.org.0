Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDCC631D41B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 03:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbhBQC5E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 21:57:04 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:9771 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229544AbhBQC5B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 21:57:01 -0500
X-IronPort-AV: E=Sophos;i="5.81,184,1610380800"; 
   d="scan'208";a="104561557"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 17 Feb 2021 10:56:13 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 374484CE72EC;
        Wed, 17 Feb 2021 10:56:13 +0800 (CST)
Received: from irides.mr (10.167.225.141) by G08CNEXMBPEKD05.g08.fujitsu.local
 (10.167.33.204) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 17 Feb
 2021 10:56:11 +0800
Subject: Re: [PATCH v3 05/11] mm, fsdax: Refactor memory-failure handler for
 dax mapping
To:     Christoph Hellwig <hch@lst.de>
CC:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <dm-devel@redhat.com>,
        <darrick.wong@oracle.com>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <agk@redhat.com>, <snitzer@redhat.com>,
        <rgoldwyn@suse.de>, <qi.fuli@fujitsu.com>, <y-goto@fujitsu.com>
References: <20210208105530.3072869-1-ruansy.fnst@cn.fujitsu.com>
 <20210208105530.3072869-6-ruansy.fnst@cn.fujitsu.com>
 <20210210133347.GD30109@lst.de>
From:   Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>
Message-ID: <45a20d88-63ee-d678-ad86-6ccd8cdf7453@cn.fujitsu.com>
Date:   Wed, 17 Feb 2021 10:56:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210210133347.GD30109@lst.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) To
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204)
X-yoursite-MailScanner-ID: 374484CE72EC.AB75D
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2021/2/10 下午9:33, Christoph Hellwig wrote:
>> +extern int mf_dax_mapping_kill_procs(struct address_space *mapping, pgoff_t index, int flags);
> 
> No nee for the extern, please avoid the overly long line.

OK.

I'd like to confirm one thing...  I have checked all of this patchset by 
checkpatch.pl and it did not report the overly long line warning.  So, I 
should still obey the rule of 80 chars one line?

> 
>> @@ -120,6 +121,13 @@ static int hwpoison_filter_dev(struct page *p)
>>   	if (PageSlab(p))
>>   		return -EINVAL;
>>   
>> +	if (pfn_valid(page_to_pfn(p))) {
>> +		if (is_device_fsdax_page(p))
>> +			return 0;
>> +		else
>> +			return -EINVAL;
>> +	}
>> +
> 
> This looks odd.  For one there is no need for an else after a return.
> But more importantly page_mapping() as called below pretty much assumes
> a valid PFN, so something is fishy in this function.

Yes, a mistake here.  I'll fix it.

> 
>> +	if (is_zone_device_page(p)) {
>> +		if (is_device_fsdax_page(p))
>> +			tk->addr = vma->vm_start +
>> +					((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
> 
> The arithmetics here scream for a common helper, I suspect there might
> be other places that could use the same helper.
> 
>> +int mf_dax_mapping_kill_procs(struct address_space *mapping, pgoff_t index, int flags)
> 
> Overly long line.  Also the naming scheme with the mf_ seems rather
> unusual. Maybe dax_kill_mapping_procs?  Also please add a kerneldoc
> comment describing the function given that it exported.
> 

OK.  Thanks for your guidance.


--
Thanks,
Ruan Shiyang.

> 


