Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADEB3145E0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 02:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbhBIByG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Feb 2021 20:54:06 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:35967 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229763AbhBIByC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Feb 2021 20:54:02 -0500
X-IronPort-AV: E=Sophos;i="5.81,163,1610380800"; 
   d="scan'208";a="104350575"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 09 Feb 2021 09:53:15 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 9EFD34CE6F82;
        Tue,  9 Feb 2021 09:53:10 +0800 (CST)
Received: from irides.mr (10.167.225.141) by G08CNEXMBPEKD05.g08.fujitsu.local
 (10.167.33.204) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 9 Feb
 2021 09:53:08 +0800
Subject: Re: [PATCH 3/7] fsdax: Copy data before write
To:     Christoph Hellwig <hch@lst.de>
CC:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>, <linux-fsdevel@vger.kernel.org>,
        <darrick.wong@oracle.com>, <dan.j.williams@intel.com>,
        <willy@infradead.org>, <jack@suse.cz>, <viro@zeniv.linux.org.uk>,
        <linux-btrfs@vger.kernel.org>, <ocfs2-devel@oss.oracle.com>,
        <david@fromorbit.com>, <rgoldwyn@suse.de>
References: <20210207170924.2933035-1-ruansy.fnst@cn.fujitsu.com>
 <20210207170924.2933035-4-ruansy.fnst@cn.fujitsu.com>
 <20210208151419.GC12872@lst.de>
From:   Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>
Message-ID: <3f2826a8-df98-e7b0-6ab8-0f410488bc55@cn.fujitsu.com>
Date:   Tue, 9 Feb 2021 09:53:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210208151419.GC12872@lst.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) To
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204)
X-yoursite-MailScanner-ID: 9EFD34CE6F82.AF079
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2021/2/8 下午11:14, Christoph Hellwig wrote:
>>   	switch (iomap.type) {
>>   	case IOMAP_MAPPED:
>> +cow:
>>   		if (iomap.flags & IOMAP_F_NEW) {
>>   			count_vm_event(PGMAJFAULT);
>>   			count_memcg_event_mm(vma->vm_mm, PGMAJFAULT);
>>   			major = VM_FAULT_MAJOR;
>>   		}
>>   		error = dax_iomap_direct_access(&iomap, pos, PAGE_SIZE,
>> -						NULL, &pfn);
>> +						&kaddr, &pfn);
> 
> Any chance you could look into factoring out this code into a helper
> to avoid the goto magic, which is a little too convoluted?
> 
>>   	switch (iomap.type) {
>>   	case IOMAP_MAPPED:
>> +cow:
>>   		error = dax_iomap_direct_access(&iomap, pos, PMD_SIZE,
>> -						NULL, &pfn);
>> +						&kaddr, &pfn);
>>   		if (error < 0)
>>   			goto finish_iomap;
>>   
>>   		entry = dax_insert_entry(&xas, mapping, vmf, entry, pfn,
>>   						DAX_PMD, write && !sync);
>>   
>> +		if (srcmap.type != IOMAP_HOLE) {
> 
> Same here.

Thanks for suggestion.  I'll try it.


--
Thanks,
Ruan Shiyang.
> 
> 


