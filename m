Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 091BC3BB59B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jul 2021 05:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbhGEDhs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Jul 2021 23:37:48 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:10252 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbhGEDhr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Jul 2021 23:37:47 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GJB542Ccsz1CFNh;
        Mon,  5 Jul 2021 11:29:44 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 5 Jul 2021 11:35:09 +0800
Received: from [127.0.0.1] (10.174.179.0) by dggpemm500006.china.huawei.com
 (7.185.36.236) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 5 Jul 2021
 11:35:09 +0800
Subject: Re: [PATCH -next 1/1] iomap: Fix a false positive of UBSAN in
 iomap_seek_data()
To:     Matthew Wilcox <willy@infradead.org>
CC:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210702092109.2601-1-thunder.leizhen@huawei.com>
 <YN9vZfo+84gizjtf@casper.infradead.org>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <492c7a7b-6f2e-de45-c733-51c80422305e@huawei.com>
Date:   Mon, 5 Jul 2021 11:35:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <YN9vZfo+84gizjtf@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.0]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2021/7/3 3:56, Matthew Wilcox wrote:
> On Fri, Jul 02, 2021 at 05:21:09PM +0800, Zhen Lei wrote:
>> Move the evaluation expression "size - offset" after the "if (offset < 0)"
>> judgment statement to eliminate a false positive produced by the UBSAN.
>>
>> No functional changes.
>>
>> ==========================================================================
>> UBSAN: Undefined behaviour in fs/iomap.c:1435:9
>> signed integer overflow:
>> 0 - -9223372036854775808 cannot be represented in type 'long long int'
> 
> I don't understand.  I thought we defined the behaviour of signed
> integer overflow in the kernel with whatever-the-gcc-flag-is?

-9223372036854775808 ==> 0x8000000000000000 ==> -0

I don't fully understand what you mean. This is triggered by explicit error
injection '-0' at runtime, which should not be detected by compilation options.

lseek(r1, 0x8000000000000000, 0x3)

> 
> 
> .
> 

