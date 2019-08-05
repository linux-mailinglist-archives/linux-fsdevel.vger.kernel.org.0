Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBC982767
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2019 00:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730707AbfHEWMo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Aug 2019 18:12:44 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:15630 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727928AbfHEWMo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Aug 2019 18:12:44 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d48a9e50000>; Mon, 05 Aug 2019 15:12:53 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 05 Aug 2019 15:12:43 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 05 Aug 2019 15:12:43 -0700
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 5 Aug
 2019 22:12:42 +0000
Subject: Re: [PATCH] fs/io_uring.c: convert put_page() to put_user_page*()
To:     Ira Weiny <ira.weiny@intel.com>, <john.hubbard@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerome Glisse <jglisse@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>
References: <20190805023206.8831-1-jhubbard@nvidia.com>
 <20190805220441.GA23416@iweiny-DESK2.sc.intel.com>
 <20190805220547.GB23416@iweiny-DESK2.sc.intel.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <dddaaf48-ce33-bdf4-86cb-47101d15eb6c@nvidia.com>
Date:   Mon, 5 Aug 2019 15:12:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190805220547.GB23416@iweiny-DESK2.sc.intel.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565043173; bh=LkAiUo1s42CQYX53EPRAoniYSqypvtE8JhgF1ACTWJI=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=bnxLQDCyTODHWtH8f0QtXRcjnq5ZXER2WiGKW2qcCasfwe2n/ifRFjrKGHdyPOppn
         UvjQryp87QwL1sEmtQkKSxJDk/DZbvhqo+mDHQVATQ9bBcoKnLRVQZiK9wAKkQ0DdD
         Vs8tjYGY4h6UomzREoaPHuLbgC1/FrH1JcqhpCHDAF0gBBzIrmrClfnBUsOwA0/j9u
         PsvNWbbA7QRj75rUXOs05jEZLR3w7rJ4pZ8TDwjzAXpDSY7XDp7GNz9t5A3GCeDz0C
         mK1bTIxkCObFVZpc/YzRFWLAFY8D44N5xtlkq8ihB9nG04UOs+yqRWzkLpjzL4j7XF
         R+Vw9vNjJ4jPw==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/5/19 3:05 PM, Ira Weiny wrote:
> On Mon, Aug 05, 2019 at 03:04:42PM -0700, 'Ira Weiny' wrote:
>> On Sun, Aug 04, 2019 at 07:32:06PM -0700, john.hubbard@gmail.com wrote:
>>> From: John Hubbard <jhubbard@nvidia.com>
>>>
>>> For pages that were retained via get_user_pages*(), release those pages
>>> via the new put_user_page*() routines, instead of via put_page() or
>>> release_pages().
>>>
>>> This is part a tree-wide conversion, as described in commit fc1d8e7cca2d
>>> ("mm: introduce put_user_page*(), placeholder versions").
>>>
>>> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
>>> Cc: Jens Axboe <axboe@kernel.dk>
>>> Cc: linux-fsdevel@vger.kernel.org
>>> Cc: linux-block@vger.kernel.org
>>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
>>
>> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> <sigh>
> 
> I meant to say I wrote the same patch ...  For this one...
> 
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> 

Hi Ira,

Say, in case you or anyone else is up for it: there are still about 
two thirds of the 34 patches that could use a reviewed-by, in this series:

   https://lore.kernel.org/r/20190804224915.28669-1-jhubbard@nvidia.com

...and even reviewing one or two quick ones would help--no need to look at
all of them, especially if several people each look at a few.

Also note that I'm keeping the gup_dma_core branch tracking the latest
linux.git, and it seems to be working pretty well, aside from one warning
that I haven't yet figured out (as per the latest commit):

    git@github.com:johnhubbard/linux.git
   

thanks,
-- 
John Hubbard
NVIDIA

