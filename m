Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDD0033E396
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Mar 2021 01:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbhCQA5I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Mar 2021 20:57:08 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13635 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbhCQA4X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Mar 2021 20:56:23 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F0Wrd6B3Kz19G9M;
        Wed, 17 Mar 2021 08:54:25 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.498.0; Wed, 17 Mar
 2021 08:56:15 +0800
Subject: Re: [PATCH] zonefs: fix to update .i_wr_refcnt correctly in
 zonefs_open_zone()
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "jth@kernel.org" <jth@kernel.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chao@kernel.org" <chao@kernel.org>
References: <20210316123026.115473-1-yuchao0@huawei.com>
 <BL0PR04MB65145B310933D52C432DA7BAE76B9@BL0PR04MB6514.namprd04.prod.outlook.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <64952e0e-0bd8-cbb2-9400-b4c16a886eee@huawei.com>
Date:   Wed, 17 Mar 2021 08:56:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <BL0PR04MB65145B310933D52C432DA7BAE76B9@BL0PR04MB6514.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/3/17 7:30, Damien Le Moal wrote:
> On 2021/03/16 21:30, Chao Yu wrote:
>> In zonefs_open_zone(), if opened zone count is larger than
>> .s_max_open_zones threshold, we missed to recover .i_wr_refcnt,
>> fix this.
>>
>> Fixes: b5c00e975779 ("zonefs: open/close zone on file open/close")
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>   fs/zonefs/super.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
>> index 0fe76f376dee..be6b99f7de74 100644
>> --- a/fs/zonefs/super.c
>> +++ b/fs/zonefs/super.c
>> @@ -966,8 +966,7 @@ static int zonefs_open_zone(struct inode *inode)
>>   
>>   	mutex_lock(&zi->i_truncate_mutex);
>>   
>> -	zi->i_wr_refcnt++;
>> -	if (zi->i_wr_refcnt == 1) {
>> +	if (zi->i_wr_refcnt == 0) {
> 
> Nit: if (!zi->i_wr_refcnt) ? I can change that when applying.

More clean, thanks. :)

Thanks,

> 
>>   
>>   		if (atomic_inc_return(&sbi->s_open_zones) > sbi->s_max_open_zones) {
>>   			atomic_dec(&sbi->s_open_zones);
>> @@ -978,7 +977,6 @@ static int zonefs_open_zone(struct inode *inode)
>>   		if (i_size_read(inode) < zi->i_max_size) {
>>   			ret = zonefs_zone_mgmt(inode, REQ_OP_ZONE_OPEN);
>>   			if (ret) {
>> -				zi->i_wr_refcnt--;
>>   				atomic_dec(&sbi->s_open_zones);
>>   				goto unlock;
>>   			}
>> @@ -986,6 +984,8 @@ static int zonefs_open_zone(struct inode *inode)
>>   		}
>>   	}
>>   
>> +	zi->i_wr_refcnt++;
>> +
>>   unlock:
>>   	mutex_unlock(&zi->i_truncate_mutex);
>>   
>>
> 
> Good catch ! Will apply this and check zonefs test suite as this bug went
> undetected.
> 
> Thanks.
> 
