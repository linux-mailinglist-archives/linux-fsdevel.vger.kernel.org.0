Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEFA78C553
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2019 02:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfHNA4c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Aug 2019 20:56:32 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:8097 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbfHNA4c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Aug 2019 20:56:32 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d535c420000>; Tue, 13 Aug 2019 17:56:34 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 13 Aug 2019 17:56:31 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 13 Aug 2019 17:56:31 -0700
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 14 Aug
 2019 00:56:31 +0000
Subject: Re: [RFC PATCH 2/2] mm/gup: introduce vaddr_pin_pages_remote()
From:   John Hubbard <jhubbard@nvidia.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-rdma@vger.kernel.org>
References: <20190812015044.26176-1-jhubbard@nvidia.com>
 <20190812015044.26176-3-jhubbard@nvidia.com>
 <20190812234950.GA6455@iweiny-DESK2.sc.intel.com>
 <38d2ff2f-4a69-e8bd-8f7c-41f1dbd80fae@nvidia.com>
 <20190813210857.GB12695@iweiny-DESK2.sc.intel.com>
 <a1044a0d-059c-f347-bd68-38be8478bf20@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <90e5cd11-fb34-6913-351b-a5cc6e24d85d@nvidia.com>
Date:   Tue, 13 Aug 2019 17:56:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a1044a0d-059c-f347-bd68-38be8478bf20@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565744194; bh=B3YJYqlMW/Nxmi5w427DPkTLK+35GlKeQUmyIqwgbAQ=;
        h=X-PGP-Universal:Subject:From:To:CC:References:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=pb3lAkxG2jaq8faEuI4gHuG/y2mFdtVCVx2wmdFURM6MMK0LE9ZIfzarYhLjFCV9x
         I4qkXlCYNapn9xvrWYGT8UIP0jz4syBdNwjPk1H39QXcnI0Gcujrna5uWL444p2Td7
         QgJ6MrmnfOwUGp8cxQb8YdzplLtomAmCwn9/a7C5dtEhAXO5qAkMN6EYWf1zUC0wVL
         BgjN6i4WEPA9KZhfpLPxwNp4vV9YMKUyONd1+nLDTmQ8Bl9vSy857RVNGNwatbrXGb
         MjqfA4UxaXhWLS5vVCExkS7Q53ivS9Pe0EBVBMhQjgJlmcG7M+rGIMqAJWMHluoAg3
         niFswF6dhE7Og==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/13/19 5:51 PM, John Hubbard wrote:
> On 8/13/19 2:08 PM, Ira Weiny wrote:
>> On Mon, Aug 12, 2019 at 05:07:32PM -0700, John Hubbard wrote:
>>> On 8/12/19 4:49 PM, Ira Weiny wrote:
>>>> On Sun, Aug 11, 2019 at 06:50:44PM -0700, john.hubbard@gmail.com wrote:
>>>>> From: John Hubbard <jhubbard@nvidia.com>
>>> ...
>> Finally, I struggle with converting everyone to a new call.  It is more
>> overhead to use vaddr_pin in the call above because now the GUP code is going
>> to associate a file pin object with that file when in ODP we don't need that
>> because the pages can move around.
> 
> What if the pages in ODP are file-backed? 
> 

oops, strike that, you're right: in that case, even the file system case is covered.
Don't mind me. :)

>>
>> This overhead may be fine, not sure in this case, but I don't see everyone
>> wanting it.

So now I see why you said that, but I will note that ODP hardware is rare,
and will likely remain rare: replayable page faults require really special 
hardware, and after all this time, we still only have CPUs, GPUs, and the
Mellanox cards that do it.

That leaves a lot of other hardware to take care of.

thanks,
-- 
John Hubbard
NVIDIA

