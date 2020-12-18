Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1A812DDD06
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Dec 2020 03:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731635AbgLRCrK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Dec 2020 21:47:10 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:50902 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727134AbgLRCrK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Dec 2020 21:47:10 -0500
X-IronPort-AV: E=Sophos;i="5.78,428,1599494400"; 
   d="scan'208";a="102694924"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 18 Dec 2020 10:46:21 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 7787D48990D2;
        Fri, 18 Dec 2020 10:46:18 +0800 (CST)
Received: from irides.mr (10.167.225.141) by G08CNEXMBPEKD05.g08.fujitsu.local
 (10.167.33.204) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 18 Dec
 2020 10:46:17 +0800
Subject: Re: [RFC PATCH v3 0/9] fsdax: introduce fs query to support reflink
To:     Jane Chu <jane.chu@oracle.com>, <linux-kernel@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>, <linux-nvdimm@lists.01.org>,
        <linux-mm@kvack.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-raid@vger.kernel.org>,
        <darrick.wong@oracle.com>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@lst.de>, <song@kernel.org>,
        <rgoldwyn@suse.de>, <qi.fuli@fujitsu.com>, <y-goto@fujitsu.com>
References: <20201215121414.253660-1-ruansy.fnst@cn.fujitsu.com>
 <7fc7ba7c-f138-4944-dcc7-ce4b3f097528@oracle.com>
From:   Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>
Message-ID: <a57c44dd-127a-3bd2-fcb3-f1373572de27@cn.fujitsu.com>
Date:   Fri, 18 Dec 2020 10:44:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <7fc7ba7c-f138-4944-dcc7-ce4b3f097528@oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204)
X-yoursite-MailScanner-ID: 7787D48990D2.AC7A4
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2020/12/17 上午4:55, Jane Chu wrote:
> Hi, Shiyang,
> 
> On 12/15/2020 4:14 AM, Shiyang Ruan wrote:
>> The call trace is like this:
>> memory_failure()
>>   pgmap->ops->memory_failure()      => pmem_pgmap_memory_failure()
>>    gendisk->fops->corrupted_range() => - pmem_corrupted_range()
>>                                        - md_blk_corrupted_range()
>>     sb->s_ops->currupted_range()    => xfs_fs_corrupted_range()
>>      xfs_rmap_query_range()
>>       xfs_currupt_helper()
>>        * corrupted on metadata
>>            try to recover data, call xfs_force_shutdown()
>>        * corrupted on file data
>>            try to recover data, call mf_dax_mapping_kill_procs()
>>
>> The fsdax & reflink support for XFS is not contained in this patchset.
>>
>> (Rebased on v5.10)
> 
> So I tried the patchset with pmem error injection, the SIGBUS payload
> does not look right -
> 
> ** SIGBUS(7): **
> ** si_addr(0x(nil)), si_lsb(0xC), si_code(0x4, BUS_MCEERR_AR) **
> 
> I expect the payload looks like
> 
> ** si_addr(0x7f3672e00000), si_lsb(0x15), si_code(0x4, BUS_MCEERR_AR) **

Thanks for testing.  I test the SIGBUS by writing a program which calls 
madvise(... ,MADV_HWPOISON) to inject memory-failure.  It just shows 
that the program is killed by SIGBUS.  I cannot get any detail from it. 
  So, could you please show me the right way(test tools) to test it?


--
Thanks,
Ruan Shiyang.

> 
> thanks,
> -jane
> 
> 
> 
> 
> 
> 


