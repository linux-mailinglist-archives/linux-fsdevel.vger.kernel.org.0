Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB0F92DE052
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Dec 2020 10:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733127AbgLRJQJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Dec 2020 04:16:09 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:26550 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730833AbgLRJQI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Dec 2020 04:16:08 -0500
X-IronPort-AV: E=Sophos;i="5.78,430,1599494400"; 
   d="scan'208";a="102711642"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 18 Dec 2020 17:15:17 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 61E5048990D2;
        Fri, 18 Dec 2020 17:15:15 +0800 (CST)
Received: from irides.mr (10.167.225.141) by G08CNEXMBPEKD05.g08.fujitsu.local
 (10.167.33.204) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 18 Dec
 2020 17:15:15 +0800
Subject: Re: [RFC PATCH v3 0/9] fsdax: introduce fs query to support reflink
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
CC:     Jane Chu <jane.chu@oracle.com>, <linux-kernel@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>, <linux-nvdimm@lists.01.org>,
        <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-raid@vger.kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@lst.de>, <song@kernel.org>,
        <rgoldwyn@suse.de>, <qi.fuli@fujitsu.com>, <y-goto@fujitsu.com>
References: <20201215121414.253660-1-ruansy.fnst@cn.fujitsu.com>
 <7fc7ba7c-f138-4944-dcc7-ce4b3f097528@oracle.com>
 <a57c44dd-127a-3bd2-fcb3-f1373572de27@cn.fujitsu.com>
 <20201218034907.GG6918@magnolia>
From:   Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>
Message-ID: <16ac8000-2892-7491-26a0-84de4301f168@cn.fujitsu.com>
Date:   Fri, 18 Dec 2020 17:13:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201218034907.GG6918@magnolia>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204)
X-yoursite-MailScanner-ID: 61E5048990D2.AA872
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2020/12/18 上午11:49, Darrick J. Wong wrote:
> On Fri, Dec 18, 2020 at 10:44:26AM +0800, Ruan Shiyang wrote:
>>
>>
>> On 2020/12/17 上午4:55, Jane Chu wrote:
>>> Hi, Shiyang,
>>>
>>> On 12/15/2020 4:14 AM, Shiyang Ruan wrote:
>>>> The call trace is like this:
>>>> memory_failure()
>>>>    pgmap->ops->memory_failure()      => pmem_pgmap_memory_failure()
>>>>     gendisk->fops->corrupted_range() => - pmem_corrupted_range()
>>>>                                         - md_blk_corrupted_range()
>>>>      sb->s_ops->currupted_range()    => xfs_fs_corrupted_range()
>>>>       xfs_rmap_query_range()
>>>>        xfs_currupt_helper()
>>>>         * corrupted on metadata
>>>>             try to recover data, call xfs_force_shutdown()
>>>>         * corrupted on file data
>>>>             try to recover data, call mf_dax_mapping_kill_procs()
>>>>
>>>> The fsdax & reflink support for XFS is not contained in this patchset.
>>>>
>>>> (Rebased on v5.10)
>>>
>>> So I tried the patchset with pmem error injection, the SIGBUS payload
>>> does not look right -
>>>
>>> ** SIGBUS(7): **
>>> ** si_addr(0x(nil)), si_lsb(0xC), si_code(0x4, BUS_MCEERR_AR) **
>>>
>>> I expect the payload looks like
>>>
>>> ** si_addr(0x7f3672e00000), si_lsb(0x15), si_code(0x4, BUS_MCEERR_AR) **
>>
>> Thanks for testing.  I test the SIGBUS by writing a program which calls
>> madvise(... ,MADV_HWPOISON) to inject memory-failure.  It just shows that
>> the program is killed by SIGBUS.  I cannot get any detail from it.  So,
>> could you please show me the right way(test tools) to test it?
> 
> I'm assuming that Jane is using a program that calls sigaction to
> install a SIGBUS handler, and dumps the entire siginfo_t structure
> whenever it receives one...

OK.  Let me try it and figure out what's wrong in it.


--
Thanks,
Ruan Shiyang.

> 
> --D
> 
>>
>> --
>> Thanks,
>> Ruan Shiyang.
>>
>>>
>>> thanks,
>>> -jane
>>>
>>>
>>>
>>>
>>>
>>>
>>
>>
> 
> 


