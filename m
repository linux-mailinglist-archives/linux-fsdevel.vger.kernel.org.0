Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 078C455DC5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2019 03:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfFZBgv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jun 2019 21:36:51 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:1461 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726068AbfFZBgv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jun 2019 21:36:51 -0400
X-IronPort-AV: E=Sophos;i="5.63,417,1557158400"; 
   d="scan'208";a="69353919"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 26 Jun 2019 09:36:48 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 3E1004CDDD35;
        Wed, 26 Jun 2019 09:36:43 +0800 (CST)
Received: from [10.167.225.140] (10.167.225.140) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Wed, 26 Jun 2019 09:36:56 +0800
Subject: Re: [PATCH 1/6] iomap: Use a IOMAP_COW/srcmap for a read-modify-write
 I/O
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Christoph Hellwig <hch@lst.de>
CC:     <linux-btrfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <darrick.wong@oracle.com>, <david@fromorbit.com>
References: <20190621192828.28900-1-rgoldwyn@suse.de>
 <20190621192828.28900-2-rgoldwyn@suse.de> <20190624070734.GB3675@lst.de>
 <20190625191442.m27cwx5o6jtu2qch@fiona>
From:   Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
Message-ID: <6511ad2e-04a2-4226-f5ec-e2462527276f@cn.fujitsu.com>
Date:   Wed, 26 Jun 2019 09:36:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190625191442.m27cwx5o6jtu2qch@fiona>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.225.140]
X-yoursite-MailScanner-ID: 3E1004CDDD35.A9B8C
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 6/26/19 3:14 AM, Goldwyn Rodrigues wrote:
> On  9:07 24/06, Christoph Hellwig wrote:
>> xfs will need to be updated to fill in the additional iomap for the
>> COW case.  Has this series been tested on xfs?
>>
> 
> No, I have not tested this, or make xfs set IOMAP_COW. I will try to do
> it in the next iteration.

Hi Goldwyn,

I'm willing to help you with this test on XFS.  If you need any help, 
please feel free to tell me. :)


-- 
Thanks,
Shiyang Ruan.
> 
>> I can't say I'm a huge fan of this two iomaps in one method call
>> approach.  I always though two separate iomap iterations would be nicer,
>> but compared to that even the older hack with just the additional
>> src_addr seems a little better.
> 
> I am just expanding on your idea of using multiple iterations for the Cow case
> in the hope we can come out of a good design:
> 
> 1. iomap_file_buffered_write calls iomap_apply with IOMAP_WRITE flag.
>     which calls iomap_begin() for the respective filesystem.
> 2. btrfs_iomap_begin() sets up iomap->type as IOMAP_COW and fills iomap
>     struct with read addr information.
> 3. iomap_apply() conditionally for IOMAP_COW calls do_cow(new function)
>     and calls ops->iomap_begin() with flag IOMAP_COW_READ_DONE(new flag).
> 4. btrfs_iomap_begin() fills up iomap structure with write information.
> 
> Step 3 seems out of place because iomap_apply should be iomap.type agnostic.
> Right?
> Should we be adding another flag IOMAP_COW_DONE, just to figure out that
> this is the "real" write for iomap_begin to fill iomap?
> 
> If this is not how you imagined, could you elaborate on the dual iteration
> sequence?
> 
> 


