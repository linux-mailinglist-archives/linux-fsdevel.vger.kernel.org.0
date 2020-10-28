Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF05429D7D9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Oct 2020 23:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733248AbgJ1W1X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 18:27:23 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6570 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733245AbgJ1W1W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:27:22 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CLdGt2GKFzhckW;
        Wed, 28 Oct 2020 14:00:54 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.238) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Wed, 28 Oct 2020
 14:00:45 +0800
Subject: Re: [PATCH] pipe: fix potential inode leak in create_pipe_files()
To:     Al Viro <viro@zeniv.linux.org.uk>
CC:     <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <cai@redhat.com>
References: <779f767d-c08b-0c03-198e-06270100d529@huawei.com>
 <20201028035453.GI3576660@ZenIV.linux.org.uk>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Message-ID: <5b121dd9-7752-2ea0-ef8b-63ba2a3c3966@huawei.com>
Date:   Wed, 28 Oct 2020 14:00:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20201028035453.GI3576660@ZenIV.linux.org.uk>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.238]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2020/10/28 11:54, Al Viro wrote:
> On Wed, Oct 28, 2020 at 11:03:52AM +0800, Zhiqiang Liu wrote:
>>
>> In create_pipe_files(), if alloc_file_clone() fails, we will call
>> put_pipe_info to release pipe, and call fput() to release f.
>> However, we donot call iput() to free inode.
> 
> Huh?  Have you actually tried to trigger that failure exit?
>
>> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
>> Signed-off-by: Feilong Lin <linfeilong@huawei.com>
>> ---
>>  fs/pipe.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/fs/pipe.c b/fs/pipe.c
>> index 0ac197658a2d..8856607fde65 100644
>> --- a/fs/pipe.c
>> +++ b/fs/pipe.c
>> @@ -924,6 +924,7 @@ int create_pipe_files(struct file **res, int flags)
>>  	if (IS_ERR(res[0])) {
>>  		put_pipe_info(inode, inode->i_pipe);
>>  		fput(f);
>> +		iput(inode);
>>  		return PTR_ERR(res[0]);
> 
> No.  That inode is created with refcount 1.  If alloc_file_pseudo()
> succeeds, the reference we'd been holding has been transferred into
> dentry allocated by alloc_file_pseudo() (and attached to f).
>>From that point on we do *NOT* own a reference to inode and no
> subsequent failure exits have any business releasing it.
> 
> In particular, alloc_file_clone() DOES NOT create extra references
> to inode, whether it succeeds or fails.  Dropping the reference
> to f will take care of everything.
> 
> If you tried to trigger that failure exit with your patch applied,
> you would've seen double iput(), as soon as you return from sys_pipe()
> to userland and task_work is processed (which is where the real
> destructor of struct file will happen).
> 
> NAK.
> 

Thanks for your patient response. Learned a lot from your reply.
Please ignore the patch.

> .
> 

