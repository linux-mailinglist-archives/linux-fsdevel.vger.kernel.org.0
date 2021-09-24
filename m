Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDB82416D28
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Sep 2021 09:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244477AbhIXHzS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Sep 2021 03:55:18 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:20006 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237965AbhIXHzS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Sep 2021 03:55:18 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HG41Q6DZXzbmlh;
        Fri, 24 Sep 2021 15:49:30 +0800 (CST)
Received: from dggema766-chm.china.huawei.com (10.1.198.208) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Fri, 24 Sep 2021 15:53:44 +0800
Received: from [10.174.177.210] (10.174.177.210) by
 dggema766-chm.china.huawei.com (10.1.198.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Fri, 24 Sep 2021 15:53:43 +0800
Message-ID: <ffe54930-186d-6dc7-0cc6-52a4c33e0b7c@huawei.com>
Date:   Fri, 24 Sep 2021 15:53:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] ramfs: fix mount source show for ramfs
To:     Al Viro <viro@zeniv.linux.org.uk>
CC:     <akpm@linux-foundation.org>, <jack@suse.cz>,
        <gregkh@linuxfoundation.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-mm@kvack.org>, <yukuai3@huawei.com>
References: <20210811122811.2288041-1-yangerkun@huawei.com>
 <YU1VegG/+AHwHaom@zeniv-ca.linux.org.uk>
From:   yangerkun <yangerkun@huawei.com>
In-Reply-To: <YU1VegG/+AHwHaom@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.210]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggema766-chm.china.huawei.com (10.1.198.208)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2021/9/24 12:35, Al Viro 写道:
> On Wed, Aug 11, 2021 at 08:28:11PM +0800, yangerkun wrote:
>> ramfs_parse_param does not parse key "source", and will convert
>> -ENOPARAM to 0. This will skip vfs_parse_fs_param_source in
>> vfs_parse_fs_param, which lead always "none" mount source for ramfs. Fix
>> it by parse "source" in ramfs_parse_param.
>>
>> Signed-off-by: yangerkun <yangerkun@huawei.com>
>> ---
>>   fs/ramfs/inode.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
>> index 65e7e56005b8..0d7f5f655fd8 100644
>> --- a/fs/ramfs/inode.c
>> +++ b/fs/ramfs/inode.c
>> @@ -202,6 +202,10 @@ static int ramfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
>>   	struct ramfs_fs_info *fsi = fc->s_fs_info;
>>   	int opt;
>>   
>> +	opt = vfs_parse_fs_param_source(fc, param);
>> +	if (opt != -ENOPARAM)
>> +		return opt;
>> +
>>   	opt = fs_parse(fc, ramfs_fs_parameters, param, &result);
>>   	if (opt < 0) {
>>   		/*
> 
> 	Umm...  If anything, I would rather call that thing *after*
> fs_parse() gives negative, similar to what kernel/cgroup/cgroup-v1.c
> does.

Thanks for your advise. Will do it next version.

> .
> 
