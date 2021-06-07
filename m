Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B58339D8B7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jun 2021 11:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbhFGJ2u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Jun 2021 05:28:50 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:4378 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbhFGJ2t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Jun 2021 05:28:49 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Fz7Fl0stnz6tsw;
        Mon,  7 Jun 2021 17:23:07 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 7 Jun 2021 17:26:56 +0800
Received: from [127.0.0.1] (10.69.38.196) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 7 Jun
 2021 17:26:56 +0800
Subject: Re: [PATCH v3] libfs: fix error cast of negative value in
 simple_attr_write()
To:     "Luck, Tony" <tony.luck@intel.com>
CC:     <viro@zeniv.linux.org.uk>, <akpm@linux-foundation.org>,
        <David.Laight@aculab.com>, <linux-fsdevel@vger.kernel.org>,
        <akinobu.mita@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <prime.zeng@huawei.com>
References: <1605341356-11872-1-git-send-email-yangyicong@hisilicon.com>
 <20210603160904.GA983893@agluck-desk2.amr.corp.intel.com>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <dfa18dc9-84fd-d21c-b21d-f58bf2c446eb@hisilicon.com>
Date:   Mon, 7 Jun 2021 17:26:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20210603160904.GA983893@agluck-desk2.amr.corp.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.38.196]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/6/4 0:09, Luck, Tony wrote:
> On Sat, Nov 14, 2020 at 04:09:16PM +0800, Yicong Yang wrote:
>> The attr->set() receive a value of u64, but simple_strtoll() is used
>> for doing the conversion. It will lead to the error cast if user inputs
>> a negative value.
>>
>> Use kstrtoull() instead of simple_strtoll() to convert a string got
>> from the user to an unsigned value. The former will return '-EINVAL' if
>> it gets a negetive value, but the latter can't handle the situation
>> correctly. Make 'val' unsigned long long as what kstrtoull() takes, this
>> will eliminate the compile warning on no 64-bit architectures.
>>
>> Fixes: f7b88631a897 ("fs/libfs.c: fix simple_attr_write() on 32bit machines")
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> ---
>> Change since v1:
>> - address the compile warning for non-64 bit platform.
>> Change since v2:
>> Link: https://lore.kernel.org/linux-fsdevel/1605000324-7428-1-git-send-email-yangyicong@hisilicon.com/
>> - make 'val' unsigned long long and mentioned in the commit
>> Link: https://lore.kernel.org/linux-fsdevel/1605261369-551-1-git-send-email-yangyicong@hisilicon.com/
> 
> Belated error report on this. Some validation team just moved to
> v5.10 and found their error injection scripts no longer work.
> 
> They have been using:
> 
> # echo $((-1 << 12)) > /sys/kernel/debug/apei/einj/param2
> 
> to write the mask value 0xfffffffffffff000 for many years ... but
> now writing a negative value (-4096) to this file gives an EINVAL error.
> 

ok. i didn't know this usage. I was using debugfs for my driver but
found I cannot figure out whether user has entered a negative value.

> Maybe they've been taking advantage of a bug all this time? The
> comment for debugfs_create_x64() says it is for reading/writing
> an unsigned value. But when a bug fix breaks user code ... then
> we are supposed to ask whether that bug is actually a feature.
> 

ok. sounds reasonable.

> If there was a debugfs_create_s64() I might just fix einj.c to
> use that ... but there isn't :-(

yes, a debugfs_create_s64() seems better for this case.
But it's okay for me to revert this fix if we regard this bug as
a feature.

Thanks
Yicong

