Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 300341EC6A2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jun 2020 03:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgFCBW4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Jun 2020 21:22:56 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5840 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726112AbgFCBW4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Jun 2020 21:22:56 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1C443241117DE6A3F4A9;
        Wed,  3 Jun 2020 09:22:54 +0800 (CST)
Received: from [127.0.0.1] (10.166.212.218) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Wed, 3 Jun 2020
 09:22:50 +0800
Subject: Re: [PATCH] locks: add locks_move_blocks in posix_lock_inode
To:     Jeff Layton <jlayton@kernel.org>, NeilBrown <neilb@suse.de>,
        <viro@zeniv.linux.org.uk>, <neilb@suse.com>
CC:     <linux-fsdevel@vger.kernel.org>,
        "bfields@vger.kernel.org" <bfields@vger.kernel.org>
References: <20200601091616.34137-1-yangerkun@huawei.com>
 <877dwq757c.fsf@notabene.neil.brown.name>
 <eaf471c1-ef00-beb5-3143-fdcc62a7058a@huawei.com>
 <63020790a240cfcd1d798147edebbc231b1ff32b.camel@kernel.org>
From:   yangerkun <yangerkun@huawei.com>
Message-ID: <e4a8cdbc-dfe6-4630-ce5e-49958f5f0813@huawei.com>
Date:   Wed, 3 Jun 2020 09:22:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <63020790a240cfcd1d798147edebbc231b1ff32b.camel@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.166.212.218]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2020/6/2 23:56, Jeff Layton 写道:
> On Tue, 2020-06-02 at 21:49 +0800, yangerkun wrote:
>>
>> 在 2020/6/2 7:10, NeilBrown 写道:
>>> On Mon, Jun 01 2020, yangerkun wrote:
>>>
>>>> We forget to call locks_move_blocks in posix_lock_inode when try to
>>>> process same owner and different types.
>>>>
>>>
>>> This patch is not necessary.
>>> The caller of posix_lock_inode() must calls locks_delete_block() on
>>> 'request', and that will remove all blocked request and retry them.
>>>
>>> So calling locks_move_blocks() here is at most an optimization.  Maybe
>>> it is a useful one.
>>>
>>> What led you to suggesting this patch?  Were you just examining the
>>> code, or was there some problem that you were trying to solve?
>>
>>
>> Actually, case of this means just replace a exists file_lock. And once
>> we forget to call locks_move_blocks, the function call of
>> posix_lock_inode will also call locks_delete_block, and will wakeup all
>> blocked requests and retry them. But we should do this until we UNLOCK
>> the file_lock! So, it's really a bug here.
>>
> 
> Waking up waiters to re-poll a lock that's still blocked seems wrong. I
> agree with Neil that this is mainly an optimization, but it does look
> useful.

Agree. Logic of this seems wrong, but it won't trigger any problem since
the waiters will conflict and try wait again.

> 
> Unfortunately this is the type of thing that's quite difficult to test
> for in a userland testcase. Is this something you noticed due to the
> extra wakeups or did you find it by inspection? It'd be great to have a
> better way to test for this in xfstests or something.

Notice this after reading the patch 5946c4319ebb ("fs/locks: allow a
lock request to block other requests."), and find that we have do the
same thing exist in flock_lock_inode and another place exists in
posix_lock_inode.

> 
> I'll plan to add this to linux-next. It should make v5.9, but let me
> know if this is causing real-world problems and maybe we can make a case
> for v5.8.

Actually, I have not try to find will this lead to some real-world
problems... Sorry for this.:(


Thanks,
Kun.

> 
> Thanks,
> Jeff
> 
>>>
>>>> Signed-off-by: yangerkun <yangerkun@huawei.com>
>>>> ---
>>>>    fs/locks.c | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/fs/locks.c b/fs/locks.c
>>>> index b8a31c1c4fff..36bd2c221786 100644
>>>> --- a/fs/locks.c
>>>> +++ b/fs/locks.c
>>>> @@ -1282,6 +1282,7 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
>>>>    				if (!new_fl)
>>>>    					goto out;
>>>>    				locks_copy_lock(new_fl, request);
>>>> +				locks_move_blocks(new_fl, request);
>>>>    				request = new_fl;
>>>>    				new_fl = NULL;
>>>>    				locks_insert_lock_ctx(request, &fl->fl_list);
>>>> -- 
>>>> 2.21.3
> 

