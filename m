Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 952BC45B429
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 07:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbhKXGIg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Nov 2021 01:08:36 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:28100 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbhKXGIf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Nov 2021 01:08:35 -0500
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HzVmD34FPz1DJYx;
        Wed, 24 Nov 2021 14:02:52 +0800 (CST)
Received: from kwepemm600019.china.huawei.com (7.193.23.64) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 24 Nov 2021 14:05:24 +0800
Received: from [10.174.177.210] (10.174.177.210) by
 kwepemm600019.china.huawei.com (7.193.23.64) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 24 Nov 2021 14:05:23 +0800
Subject: Re: [PATCH] hugetlbfs: avoid overflow in hugetlbfs_fallocate
To:     Matthew Wilcox <willy@infradead.org>
CC:     <mike.kravetz@oracle.com>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <yukuai3@huawei.com>
References: <20211124040818.2219374-1-yangerkun@huawei.com>
 <YZ2+ecB1dDOdY+gp@casper.infradead.org>
From:   yangerkun <yangerkun@huawei.com>
Message-ID: <3ad388a4-503d-6cbf-a02c-118594d36d33@huawei.com>
Date:   Wed, 24 Nov 2021 14:05:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <YZ2+ecB1dDOdY+gp@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.210]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600019.china.huawei.com (7.193.23.64)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2021/11/24 12:24, Matthew Wilcox wrote:
> On Wed, Nov 24, 2021 at 12:08:18PM +0800, yangerkun wrote:
>>   	start = offset >> hpage_shift;
>> -	end = (offset + len + hpage_size - 1) >> hpage_shift;
>> +	end = ((unsigned long long)offset + len + hpage_size - 1)
>> +		>> hpage_shift;
> 
> +	end = DIV_ROUND_UP_ULL(offset + len, hpage_size);

Thanks, will do it in v2!

> .
> 
