Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADB242D462
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 06:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725840AbfE2ECr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 00:02:47 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:55516 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725773AbfE2ECr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 00:02:47 -0400
X-IronPort-AV: E=Sophos;i="5.60,525,1549900800"; 
   d="scan'208";a="65026033"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 29 May 2019 12:02:44 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 276F94CDC834;
        Wed, 29 May 2019 12:02:43 +0800 (CST)
Received: from [10.167.225.140] (10.167.225.140) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Wed, 29 May 2019 12:02:52 +0800
Subject: Re: [PATCH 04/18] dax: Introduce IOMAP_DAX_COW to CoW edges during
 writes
To:     Dave Chinner <david@fromorbit.com>
CC:     Jan Kara <jack@suse.cz>, Goldwyn Rodrigues <rgoldwyn@suse.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        <linux-btrfs@vger.kernel.org>, <kilobyte@angband.pl>,
        <linux-fsdevel@vger.kernel.org>, <willy@infradead.org>,
        <hch@lst.de>, <dsterba@suse.cz>, <nborisov@suse.com>,
        <linux-nvdimm@lists.01.org>
References: <20190429172649.8288-1-rgoldwyn@suse.de>
 <20190429172649.8288-5-rgoldwyn@suse.de> <20190521165158.GB5125@magnolia>
 <1e9951c1-d320-e480-3130-dc1f4b81ef2c@cn.fujitsu.com>
 <20190523115109.2o4txdjq2ft7fzzc@fiona>
 <1620c513-4ce2-84b0-33dc-2675246183ea@cn.fujitsu.com>
 <20190528091729.GD9607@quack2.suse.cz>
 <a3a919e6-ecad-bdf6-423c-fc01f9cfa661@cn.fujitsu.com>
 <20190529024749.GC16786@dread.disaster.area>
From:   Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
Message-ID: <376256fd-dee4-5561-eb4e-546e227303cd@cn.fujitsu.com>
Date:   Wed, 29 May 2019 12:02:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190529024749.GC16786@dread.disaster.area>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.225.140]
X-yoursite-MailScanner-ID: 276F94CDC834.AA7BD
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 5/29/19 10:47 AM, Dave Chinner wrote:
> On Wed, May 29, 2019 at 10:01:58AM +0800, Shiyang Ruan wrote:
>>
>> On 5/28/19 5:17 PM, Jan Kara wrote:
>>> On Mon 27-05-19 16:25:41, Shiyang Ruan wrote:
>>>> On 5/23/19 7:51 PM, Goldwyn Rodrigues wrote:
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> I'm working on reflink & dax in XFS, here are some thoughts on this:
>>>>>>
>>>>>> As mentioned above: the second iomap's offset and length must match the
>>>>>> first.  I thought so at the beginning, but later found that the only
>>>>>> difference between these two iomaps is @addr.  So, what about adding a
>>>>>> @saddr, which means the source address of COW extent, into the struct iomap.
>>>>>> The ->iomap_begin() fills @saddr if the extent is COW, and 0 if not.  Then
>>>>>> handle this @saddr in each ->actor().  No more modifications in other
>>>>>> functions.
>>>>>
>>>>> Yes, I started of with the exact idea before being recommended this by Dave.
>>>>> I used two fields instead of one namely cow_pos and cow_addr which defined
>>>>> the source details. I had put it as a iomap flag as opposed to a type
>>>>> which of course did not appeal well.
>>>>>
>>>>> We may want to use iomaps for cases where two inodes are involved.
>>>>> An example of the other scenario where offset may be different is file
>>>>> comparison for dedup: vfs_dedup_file_range_compare(). However, it would
>>>>> need two inodes in iomap as well.
>>>>>
>>>> Yes, it is reasonable.  Thanks for your explanation.
>>>>
>>>> One more thing RFC:
>>>> I'd like to add an end-io callback argument in ->dax_iomap_actor() to update
>>>> the metadata after one whole COW operation is completed.  The end-io can
>>>> also be called in ->iomap_end().  But one COW operation may call
>>>> ->iomap_apply() many times, and so does the end-io.  Thus, I think it would
>>>> be nice to move it to the bottom of ->dax_iomap_actor(), called just once in
>>>> each COW operation.
>>>
>>> I'm sorry but I don't follow what you suggest. One COW operation is a call
>>> to dax_iomap_rw(), isn't it? That may call iomap_apply() several times,
>>> each invocation calls ->iomap_begin(), ->actor() (dax_iomap_actor()),
>>> ->iomap_end() once. So I don't see a difference between doing something in
>>> ->actor() and ->iomap_end() (besides the passed arguments but that does not
>>> seem to be your concern). So what do you exactly want to do?
>>
>> Hi Jan,
>>
>> Thanks for pointing out, and I'm sorry for my mistake.  It's
>> ->dax_iomap_rw(), not ->dax_iomap_actor().
>>
>> I want to call the callback function at the end of ->dax_iomap_rw().
>>
>> Like this:
>> dax_iomap_rw(..., callback) {
>>
>>      ...
>>      while (...) {
>>          iomap_apply(...);
>>      }
>>
>>      if (callback != null) {
>>          callback();
>>      }
>>      return ...;
>> }
> 
> Why does this need to be in dax_iomap_rw()?
> 
> We already do post-dax_iomap_rw() "io-end callbacks" directly in
> xfs_file_dax_write() to update the file size....

Yes, but we also need to call ->xfs_reflink_end_cow() after a COW 
operation.  And an is-cow flag(from iomap) is also needed to determine 
if we call it.  I think it would be better to put this into 
->dax_iomap_rw() as a callback function.

So sorry for my poor expression.

> 
> Cheers,
> 
> Dave.
> 

-- 
Thanks,
Shiyang Ruan.


