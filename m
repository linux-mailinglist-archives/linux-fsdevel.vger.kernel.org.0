Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1E2C1EBD54
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jun 2020 15:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgFBNtL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Jun 2020 09:49:11 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46020 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725940AbgFBNtL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Jun 2020 09:49:11 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7A0744E0C9076D929E6E;
        Tue,  2 Jun 2020 21:49:09 +0800 (CST)
Received: from [127.0.0.1] (10.166.212.218) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Tue, 2 Jun 2020
 21:49:05 +0800
Subject: Re: [PATCH] locks: add locks_move_blocks in posix_lock_inode
To:     NeilBrown <neilb@suse.de>, <viro@zeniv.linux.org.uk>,
        <jlayton@kernel.org>, <neilb@suse.com>
CC:     <linux-fsdevel@vger.kernel.org>
References: <20200601091616.34137-1-yangerkun@huawei.com>
 <877dwq757c.fsf@notabene.neil.brown.name>
From:   yangerkun <yangerkun@huawei.com>
Message-ID: <eaf471c1-ef00-beb5-3143-fdcc62a7058a@huawei.com>
Date:   Tue, 2 Jun 2020 21:49:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <877dwq757c.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.166.212.218]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



ÔÚ 2020/6/2 7:10, NeilBrown Ð´µÀ:
> On Mon, Jun 01 2020, yangerkun wrote:
> 
>> We forget to call locks_move_blocks in posix_lock_inode when try to
>> process same owner and different types.
>>
> 
> This patch is not necessary.
> The caller of posix_lock_inode() must calls locks_delete_block() on
> 'request', and that will remove all blocked request and retry them.
> 
> So calling locks_move_blocks() here is at most an optimization.  Maybe
> it is a useful one.
> 
> What led you to suggesting this patch?  Were you just examining the
> code, or was there some problem that you were trying to solve?



Actually, case of this means just replace a exists file_lock. And once 
we forget to call locks_move_blocks, the function call of 
posix_lock_inode will also call locks_delete_block, and will wakeup all 
blocked requests and retry them. But we should do this until we UNLOCK 
the file_lock! So, it's really a bug here.

Thanks,
Kun.


> 
> Thanks,
> NeilBrown
> 
> 
>> Signed-off-by: yangerkun <yangerkun@huawei.com>
>> ---
>>   fs/locks.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/fs/locks.c b/fs/locks.c
>> index b8a31c1c4fff..36bd2c221786 100644
>> --- a/fs/locks.c
>> +++ b/fs/locks.c
>> @@ -1282,6 +1282,7 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
>>   				if (!new_fl)
>>   					goto out;
>>   				locks_copy_lock(new_fl, request);
>> +				locks_move_blocks(new_fl, request);
>>   				request = new_fl;
>>   				new_fl = NULL;
>>   				locks_insert_lock_ctx(request, &fl->fl_list);
>> -- 
>> 2.21.3

