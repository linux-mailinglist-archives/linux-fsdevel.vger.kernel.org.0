Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC55E2E3392
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Dec 2020 03:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgL1CQG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Dec 2020 21:16:06 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9998 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726361AbgL1CQF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Dec 2020 21:16:05 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4D41Mb685Czj05M;
        Mon, 28 Dec 2020 10:14:35 +0800 (CST)
Received: from [10.174.177.6] (10.174.177.6) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.498.0; Mon, 28 Dec 2020
 10:15:16 +0800
Subject: Re: [RFC PATCH RESEND] fs: fix a hungtask problem when
 freeze/unfreeze fs
To:     Al Viro <viro@zeniv.linux.org.uk>
CC:     <linux-fsdevel@vger.kernel.org>, <yangerkun@huawei.com>,
        <yi.zhang@huawei.com>, <linfeilong@huawei.com>, <jack@suse.cz>
References: <20201226095641.17290-1-luoshijie1@huawei.com>
 <20201226155500.GB3579531@ZenIV.linux.org.uk>
From:   Shijie Luo <luoshijie1@huawei.com>
Message-ID: <870c4a20-ac5e-c755-fe8c-e1a192bffb29@huawei.com>
Date:   Mon, 28 Dec 2020 10:15:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20201226155500.GB3579531@ZenIV.linux.org.uk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.177.6]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 2020/12/26 23:55, Al Viro wrote:
> On Sat, Dec 26, 2020 at 04:56:41AM -0500, Shijie Luo wrote:
>
>> The root cause is that when offline/onlines disks, the filesystem can easily get into
>> a error state and this makes it change to be read-only. Function freeze_super() will hold
>> all sb_writers rwsems including rwsem of SB_FREEZE_WRITE when filesystem not read-only,
>> but thaw_super_locked() cannot release these while the filesystem suddenly become read-only,
>> because the logic will go to out.
>>
>> freeze_super
>>      hold sb_writers rwsems
>>          sb->s_writers.frozen = SB_FREEZE_COMPLETE
>>                                                   thaw_super_locked
>>                                                       sb_rdonly
>>                                                          sb->s_writers.frozen = SB_UNFROZEN;
>>                                                              goto out // not release rwsems
>>
>> And at this time, if we call mnt_want_write(), the process will be blocked.
>>
>> This patch fixes this problem, when filesystem is read-only, just not to set sb_writers.frozen
>> be SB_FREEZE_COMPLETE in freeze_super() and then release all rwsems in thaw_super_locked.
> I really don't like that - you end up with a case when freeze_super() returns 0 *and*
> consumes the reference it had been give.

Consuming the reference here because we won't "set frozen = 
SB_FREEZE_COMPLETE" in thaw_super_locked() now.

If don't do that, we never have a chance to consume it, 
thaw_super_locked() will directly return "-EINVAL". But I do

agree that it's not a good idea to return 0. How about returning 
"-EINVAL or -ENOTSUPP" ?

And, If we keep "frozen = SB_FREEZE_COMPLETE" in freeze_super() here, it 
will cause another problem, thaw_super_locked()

will always release rwsems in my logic, but freeze_super() won't acquire 
the rwsems when filesystem is read-only.

Thanks.

>>   	if (sb_rdonly(sb)) {
>> -		/* Nothing to do really... */
>> -		sb->s_writers.frozen = SB_FREEZE_COMPLETE;
>> -		up_write(&sb->s_umount);
>> +		deactivate_locked_super(sb);
>>   		return 0;
>>   	}
> .
>
