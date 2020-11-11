Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 268EA2AEEA5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Nov 2020 11:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbgKKKSk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Nov 2020 05:18:40 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:7881 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbgKKKSj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Nov 2020 05:18:39 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CWLKc4TR8z6xQ3;
        Wed, 11 Nov 2020 18:18:28 +0800 (CST)
Received: from [10.65.58.147] (10.65.58.147) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Wed, 11 Nov 2020
 18:18:28 +0800
Subject: Re: [RESEND PATCH] libfs: fix error cast of negative value in
 simple_attr_write()
To:     Andrew Morton <akpm@linux-foundation.org>
References: <1605000324-7428-1-git-send-email-yangyicong@hisilicon.com>
 <20201110111842.1bc76e9def94279d4453ff67@linux-foundation.org>
CC:     <viro@zeniv.linux.org.uk>, <linux-fsdevel@vger.kernel.org>,
        <akinobu.mita@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <prime.zeng@huawei.com>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <0b3954a4-1ac9-c454-a0ea-1fa1be5975b8@hisilicon.com>
Date:   Wed, 11 Nov 2020 18:18:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20201110111842.1bc76e9def94279d4453ff67@linux-foundation.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.58.147]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Thanks for reviewing this.


On 2020/11/11 3:18, Andrew Morton wrote:
> On Tue, 10 Nov 2020 17:25:24 +0800 Yicong Yang <yangyicong@hisilicon.com> wrote:
>
>> The attr->set() receive a value of u64, but simple_strtoll() is used
>> for doing the conversion. It will lead to the error cast if user inputs
>> a negative value.
>>
>> Use kstrtoull() instead of simple_strtoll() to convert a string got
>> from the user to an unsigned value. The former will return '-EINVAL' if
>> it gets a negetive value, but the latter can't handle the situation
>> correctly.
>>
>> ...
>>
>> --- a/fs/libfs.c
>> +++ b/fs/libfs.c
>> @@ -977,7 +977,9 @@ ssize_t simple_attr_write(struct file *file, const char __user *buf,
>>  		goto out;
>>  
>>  	attr->set_buf[size] = '\0';
>> -	val = simple_strtoll(attr->set_buf, NULL, 0);
>> +	ret = kstrtoull(attr->set_buf, 0, &val);
>> +	if (ret)
>> +		goto out;
>>  	ret = attr->set(attr->data, val);
>>  	if (ret == 0)
>>  		ret = len; /* on success, claim we got the whole input */
> kstrtoull() takes an `unsigned long long *', but `val' is a u64.
>
> I think this probably works OK on all architectures (ie, no 64-bit
> architectures are using `unsigned long' for u64).  But perhaps `val'
> should have type `unsigned long long'?

the attr->set() takes 'val' as u64, so maybe we can stay it unchanged here
if it works well.

Thanks,
Yicong


> .
>

