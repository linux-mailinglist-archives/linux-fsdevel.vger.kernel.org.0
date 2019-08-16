Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03322907EA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2019 20:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbfHPSvi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Aug 2019 14:51:38 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:10460 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727286AbfHPSvh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Aug 2019 14:51:37 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d56fb3c0000>; Fri, 16 Aug 2019 11:51:40 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 16 Aug 2019 11:51:37 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 16 Aug 2019 11:51:37 -0700
Received: from [10.2.171.178] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 16 Aug
 2019 18:51:36 +0000
Subject: Re: [RFC PATCH 2/2] mm/gup: introduce vaddr_pin_pages_remote()
To:     Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-rdma@vger.kernel.org>
References: <90e5cd11-fb34-6913-351b-a5cc6e24d85d@nvidia.com>
 <20190814234959.GA463@iweiny-DESK2.sc.intel.com>
 <2cbdf599-2226-99ae-b4d5-8909a0a1eadf@nvidia.com>
 <ac834ac6-39bd-6df9-fca4-70b9520b6c34@nvidia.com>
 <20190815132622.GG14313@quack2.suse.cz>
 <20190815133510.GA21302@quack2.suse.cz>
 <20190815173237.GA30924@iweiny-DESK2.sc.intel.com>
 <b378a363-f523-518d-9864-e2f8e5bd0c34@nvidia.com>
 <58b75fa9-1272-b683-cb9f-722cc316bf8f@nvidia.com>
 <20190816154108.GE3041@quack2.suse.cz>
 <20190816183337.GA371@iweiny-DESK2.sc.intel.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <a584cfbd-b458-dce9-4144-3b542bcf163d@nvidia.com>
Date:   Fri, 16 Aug 2019 11:50:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190816183337.GA371@iweiny-DESK2.sc.intel.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565981500; bh=3Hg5/ZeHBftX8+hbP6rJ0hfukt9NR6qjkNcikQi7Ozw=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=jq5v1LLP4LrsgrnXHguyYLEEwRB9DO0Uwlo2quP/NJ3nWYU6dJogbHkO4H8tdS3k5
         pJS5BslK93hrs6dj2Vm7ijW3wgXois/H3mx2oHH87CC7k8uNVEWwN1YHxOMzujAJIo
         Ig6EBAdvRSRdDbzRwwLj3p4KfQlDfgZpHoiNroEUVE9UnB0tiO3Q5CYOeHq/F/Hb2h
         7qEcuiU0rpL1lDeHMDq2SkLv4c4xgGdIVJFXuQUat8urtf23PqemBevoXObeoVTGnb
         I4VMTElpqHNSvsELZs51LzjhjOaMiUiTzW70bFRot2N85Wralr9sg3HPyapZODmIwX
         Y8VlkTwHO8HQQ==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/16/19 11:33 AM, Ira Weiny wrote:
> On Fri, Aug 16, 2019 at 05:41:08PM +0200, Jan Kara wrote:
>> On Thu 15-08-19 19:14:08, John Hubbard wrote:
>>> On 8/15/19 10:41 AM, John Hubbard wrote:
>>>> On 8/15/19 10:32 AM, Ira Weiny wrote:
>>>>> On Thu, Aug 15, 2019 at 03:35:10PM +0200, Jan Kara wrote:
>>>>>> On Thu 15-08-19 15:26:22, Jan Kara wrote:
>>>>>>> On Wed 14-08-19 20:01:07, John Hubbard wrote:
>>>>>>>> On 8/14/19 5:02 PM, John Hubbard wrote:
>>> ...
>>>
>>> OK, there was only process_vm_access.c, plus (sort of) Bharath's sgi-gru
>>> patch, maybe eventually [1].  But looking at process_vm_access.c, I think
>>> it is one of the patches that is no longer applicable, and I can just
>>> drop it entirely...I'd welcome a second opinion on that...
>>
>> I don't think you can drop the patch. process_vm_rw_pages() clearly touches
>> page contents and does not synchronize with page_mkclean(). So it is case
>> 1) and needs FOLL_PIN semantics.
> 
> John could you send a formal patch using vaddr_pin* and I'll add it to the
> tree?
> 

Yes...hints about which struct file to use here are very welcome, btw. This part
of mm is fairly new to me.

thanks,
-- 
John Hubbard
NVIDIA
