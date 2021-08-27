Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 677273F9405
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Aug 2021 07:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244177AbhH0F1g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Aug 2021 01:27:36 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:7098 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229645AbhH0F1g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Aug 2021 01:27:36 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AytThfqsqpwTceRZEfg/WGsuq7skDStV00zEX?=
 =?us-ascii?q?/kB9WHVpm62j5qSTdZEguCMc5wx+ZJheo7q90cW7IE80lqQFhLX5X43SPzUO0V?=
 =?us-ascii?q?HARO5fBODZsl/d8kPFltJ15ONJdqhSLJnKB0FmsMCS2mKFOudl7N6Z0K3Av4vj?=
 =?us-ascii?q?80s=3D?=
X-IronPort-AV: E=Sophos;i="5.84,355,1620662400"; 
   d="scan'208";a="113551348"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 27 Aug 2021 13:26:46 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id D933F4D0D9CF;
        Fri, 27 Aug 2021 13:26:42 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 27 Aug 2021 13:26:43 +0800
Received: from [192.168.22.65] (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 27 Aug 2021 13:26:41 +0800
Subject: Re: [PATCH v7 3/8] fsdax: Replace mmap entry in case of CoW
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        david <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>
References: <20210816060359.1442450-1-ruansy.fnst@fujitsu.com>
 <20210816060359.1442450-4-ruansy.fnst@fujitsu.com>
 <CAPcyv4iOSxoy-qGfAd3i4uzwfDX0t1xTmyM0pNd+-euVMDUwrQ@mail.gmail.com>
 <20210823125715.GA15536@lst.de>
 <d4f07aef-ad9f-7de9-c112-a40e2022b399@fujitsu.com>
 <CAPcyv4j832cg0_=h31nTdjFoqgvWsCWqqcY_K_fMRg93JsWU-Q@mail.gmail.com>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
Message-ID: <6e86fe6e-fcbb-908c-11a4-4c322199bc5e@fujitsu.com>
Date:   Fri, 27 Aug 2021 13:26:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4j832cg0_=h31nTdjFoqgvWsCWqqcY_K_fMRg93JsWU-Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-yoursite-MailScanner-ID: D933F4D0D9CF.A1623
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2021/8/27 13:00, Dan Williams wrote:
> On Thu, Aug 26, 2021 at 8:22 PM Shiyang Ruan <ruansy.fnst@fujitsu.com> wrote:
>>
>>
>>
>> On 2021/8/23 20:57, Christoph Hellwig wrote:
>>> On Thu, Aug 19, 2021 at 03:54:01PM -0700, Dan Williams wrote:
>>>>
>>>> static void *dax_insert_entry(struct xa_state *xas, struct vm_fault *vmf,
>>>>                                 const struct iomap_iter *iter, void
>>>> *entry, pfn_t pfn,
>>>>                                 unsigned long flags)
>>>>
>>>>
>>>>>    {
>>>>> +       struct address_space *mapping = vmf->vma->vm_file->f_mapping;
>>>>>           void *new_entry = dax_make_entry(pfn, flags);
>>>>> +       bool dirty = insert_flags & DAX_IF_DIRTY;
>>>>> +       bool cow = insert_flags & DAX_IF_COW;
>>>>
>>>> ...and then calculate these flags from the source data. I'm just
>>>> reacting to "yet more flags".
>>>
>>> Except for the overly long line above that seems like a good idea.
>>> The iomap_iter didn't exist for most of the time this patch has been
>>> around.
>>>
>>
>> So should I reuse the iter->flags to pass the insert_flags? (left shift
>> it to higher bits)
> 
> No, the advice is to just pass the @iter to dax_insert_entry directly
> and calculate @dirty and @cow internally.
> 

I see.  Yes, they can be calculated inside the dax_insert_entry() 
because it already has enough arguments.


--
Thanks,
Ruan.


