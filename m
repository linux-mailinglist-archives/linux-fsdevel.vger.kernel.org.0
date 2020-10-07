Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9B832866A0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Oct 2020 20:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgJGSMm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Oct 2020 14:12:42 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:6009 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbgJGSMm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Oct 2020 14:12:42 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7e04e20002>; Wed, 07 Oct 2020 11:11:46 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 7 Oct
 2020 18:12:40 +0000
Subject: Re: [PATCH] ext4/xfs: add page refcount helper
To:     Jan Kara <jack@suse.cz>
CC:     <linux-mm@kvack.org>, <linux-xfs@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-nvdimm@lists.01.org>,
        <linux-kernel@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Alexander Viro" <viro@zeniv.linux.org.uk>,
        Theodore Ts'o <tytso@mit.edu>,
        "Christoph Hellwig" <hch@lst.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20201006230930.3908-1-rcampbell@nvidia.com>
 <20201007082517.GC6984@quack2.suse.cz>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <f8aff11f-3913-a0ac-b8cd-5380738a8e3c@nvidia.com>
Date:   Wed, 7 Oct 2020 11:12:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20201007082517.GC6984@quack2.suse.cz>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1602094306; bh=lUvgpT2dTAjc7L2GQJN23iB+8LFxnscOP+RQUFKZzSU=;
        h=Subject:To:CC:References:X-Nvconfidentiality:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=o+FdvXOp7EzIyvwJEGGRsWIIvAKdYxiUjP4FaudBCF5tqtRlUM5mSnvldVEx36PfR
         1aWjXJX3cbuJ7Atpubl/0AHI642RUHyderrltQL3vMBrDg8gwiwV7U9TzPMU/ZJHwL
         Q8ZSz2uk/NvYwAsL3dgNttmxAQlPr1SM/DIUjacJVlS/BWCCGPh0LfkAt0rILq8Ydx
         9WXnyAZ3kmgVCXUpIpyKRfB7115WfJo9GwBDm0wtRxubW5SSlC6khrlAyfPqtAwipT
         xKAu+/xSyEM++gga5LHl6KFTQoOC1yVE4sPLYQHQ8enCOgH/tllJl9uOy2ayx+RLbP
         5Q+o0MZ9gWpQA==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 10/7/20 1:25 AM, Jan Kara wrote:
> On Tue 06-10-20 16:09:30, Ralph Campbell wrote:
>> There are several places where ZONE_DEVICE struct pages assume a reference
>> count == 1 means the page is idle and free. Instead of open coding this,
>> add a helper function to hide this detail.
>>
>> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Looks as sane direction but if we are going to abstract checks when
> ZONE_DEVICE page is idle, we should also update e.g.
> mm/swap.c:put_devmap_managed_page() or
> mm/gup.c:__unpin_devmap_managed_user_page() (there may be more places like
> this but I found at least these two...). Maybe Dan has more thoughts about
> this.
> 
> 								Honza

I think this is a good point but I would like to make that a follow on
patch rather than add to this one.
