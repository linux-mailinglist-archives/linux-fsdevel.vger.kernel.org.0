Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E379621016E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jul 2020 03:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbgGABYz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jun 2020 21:24:55 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7321 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725868AbgGABYz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jun 2020 21:24:55 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id F3812A17D93A4122CF33;
        Wed,  1 Jul 2020 09:24:52 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.106) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Wed, 1 Jul 2020
 09:24:49 +0800
Subject: Re: [PATCH] cifs: remove the retry in cifs_poxis_lock_set
To:     NeilBrown <neilb@suse.de>, <sfrench@samba.org>,
        <jlayton@kernel.org>, <neilb@suse.com>
CC:     <linux-cifs@vger.kernel.org>, <samba-technical@lists.samba.org>,
        <linux-fsdevel@vger.kernel.org>
References: <20200624071053.993784-1-yangerkun@huawei.com>
 <62b291ab-291c-339f-e8e8-ba7b0c4f6670@huawei.com>
 <878sg42nf1.fsf@notabene.neil.brown.name>
From:   yangerkun <yangerkun@huawei.com>
Message-ID: <a08a0eb9-1021-c72d-afee-690036bf57d5@huawei.com>
Date:   Wed, 1 Jul 2020 09:24:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <878sg42nf1.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.106]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2020/7/1 6:34, NeilBrown 写道:
> On Tue, Jun 30 2020, yangerkun wrote:
> 
>> Ping...
>>
>> 在 2020/6/24 15:10, yangerkun 写道:
>>> The caller of cifs_posix_lock_set will do retry(like
>>> fcntl_setlk64->do_lock_file_wait) if we will wait for any file_lock.
>>> So the retry in cifs_poxis_lock_set seems duplicated, remove it to
>>> make a cleanup.
> 
> If cifs_posix_try_lock() returns FILE_LOCK_DEFERRED (which it might
> after your patch), then cifs_setlk() will check the return value:
> 
> 		if (!rc || rc < 0)
> 			return rc;
> 
> These tests will fail (as FILE_LOCK_DEFERRED is 1) and so it will
> continue on as though the lock was granted.
> 
> So I think your patch is wrong.
> However I think your goal is correct.  cifs shouldn't be waiting.
> No other filesystem waits when it gets FILE_LOCK_DEFERRED.
> 
> So maybe try to fix up your patch.

Yes, we should check FILE_LOCK_DEFERRED in cifs_setlk after this patch.
Also we may change 'int rc = 1;' exists in cifs_posix_lock_set since
FILE_LOCK_DEFERRED equals to 1.

I will send a v2 and thanks a lot for your review!

Thanks,
Kun.

> Thanks,
> NeilBrown
> 
> 
>>>
>>> Signed-off-by: yangerkun <yangerkun@huawei.com>
>>> ---
>>>    fs/cifs/file.c | 8 --------
>>>    1 file changed, 8 deletions(-)
>>>
>>> diff --git a/fs/cifs/file.c b/fs/cifs/file.c
>>> index 9b0f8f33f832..2c9c24b1805d 100644
>>> --- a/fs/cifs/file.c
>>> +++ b/fs/cifs/file.c
>>> @@ -1162,7 +1162,6 @@ cifs_posix_lock_set(struct file *file, struct file_lock *flock)
>>>    	if ((flock->fl_flags & FL_POSIX) == 0)
>>>    		return rc;
>>>    
>>> -try_again:
>>>    	cifs_down_write(&cinode->lock_sem);
>>>    	if (!cinode->can_cache_brlcks) {
>>>    		up_write(&cinode->lock_sem);
>>> @@ -1171,13 +1170,6 @@ cifs_posix_lock_set(struct file *file, struct file_lock *flock)
>>>    
>>>    	rc = posix_lock_file(file, flock, NULL);
>>>    	up_write(&cinode->lock_sem);
>>> -	if (rc == FILE_LOCK_DEFERRED) {
>>> -		rc = wait_event_interruptible(flock->fl_wait,
>>> -					list_empty(&flock->fl_blocked_member));
>>> -		if (!rc)
>>> -			goto try_again;
>>> -		locks_delete_block(flock);
>>> -	}
>>>    	return rc;
>>>    }
>>>    
>>>

