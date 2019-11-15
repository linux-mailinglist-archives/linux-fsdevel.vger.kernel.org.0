Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2685BFDAC7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2019 11:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfKOKIf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Nov 2019 05:08:35 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6679 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727004AbfKOKIf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Nov 2019 05:08:35 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E7CA218E69BF78DB8678;
        Fri, 15 Nov 2019 18:08:32 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.96) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Fri, 15 Nov 2019
 18:08:25 +0800
Subject: Re: [PATCH 1/3] dcache: add a new enum type for 'dentry_d_lock_class'
To:     Greg KH <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
CC:     <rafael@kernel.org>, <rostedt@goodmis.org>, <oleg@redhat.com>,
        <mchehab+samsung@kernel.org>, <corbet@lwn.net>, <tytso@mit.edu>,
        <jmorris@namei.org>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <zhengbin13@huawei.com>,
        <yi.zhang@huawei.com>, <chenxiang66@hisilicon.com>,
        <xiexiuqi@huawei.com>
References: <1573788472-87426-1-git-send-email-yukuai3@huawei.com>
 <1573788472-87426-2-git-send-email-yukuai3@huawei.com>
 <20191115032759.GA795729@kroah.com>
 <20191115041243.GN26530@ZenIV.linux.org.uk>
 <20191115072011.GA1203354@kroah.com>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <1d2220d1-711a-d1c7-3df9-c755971f6cc3@huawei.com>
Date:   Fri, 15 Nov 2019 18:08:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191115072011.GA1203354@kroah.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.96]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2019/11/15 15:20, Greg KH wrote:
> On Fri, Nov 15, 2019 at 04:12:43AM +0000, Al Viro wrote:
>> On Fri, Nov 15, 2019 at 11:27:59AM +0800, Greg KH wrote:
>>> On Fri, Nov 15, 2019 at 11:27:50AM +0800, yu kuai wrote:
>>>> 'dentry_d_lock_class' can be used for spin_lock_nested in case lockdep
>>>> confused about two different dentry take the 'd_lock'.
>>>>
>>>> However, a single 'DENTRY_D_LOCK_NESTED' may not be enough if more than
>>>> two dentry are involed. So, and in 'DENTRY_D_LOCK_NESTED_2'
>>>>
>>>> Signed-off-by: yu kuai <yukuai3@huawei.com>
>>>> ---
>>>>   include/linux/dcache.h | 3 ++-
>>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
>>>> index 10090f1..8eb84ef 100644
>>>> --- a/include/linux/dcache.h
>>>> +++ b/include/linux/dcache.h
>>>> @@ -129,7 +129,8 @@ struct dentry {
>>>>   enum dentry_d_lock_class
>>>>   {
>>>>   	DENTRY_D_LOCK_NORMAL, /* implicitly used by plain spin_lock() APIs. */
>>>> -	DENTRY_D_LOCK_NESTED
>>>> +	DENTRY_D_LOCK_NESTED,
>>>> +	DENTRY_D_LOCK_NESTED_2
>>>
>>> You should document this, as "_2" does not make much sense to anyone
>>> only looking at the code :(
>>>
>>> Or rename it better.
>>
>> FWIW, I'm not sure it's a good solution.  What are the rules for callers
>> of that thing, anyway?  If it can be called when somebody is creating
>> more files in that subtree, we almost certainly will have massive
>> problems with the lifetimes of underlying objects...
>>
>> Could somebody familiar with debugfs explain how is that thing actually
>> used and what is required from/promised to its callers?  I can try and
>> grep through the tree and guess what the rules are, but I've way too
>> much on my platter right now and I don't want to get sidetracked into yet
>> another tree-wide search and analysis session ;-/
> 
> Yu wants to use simple_empty() in debugfs_remove_recursive() instead of
> manually checking:
> 	if (!list_empty(&child->d_subdirs)) {
> 
> See patch 3 of this series for that change and why they feel it is
> needed:
> 	https://lore.kernel.org/lkml/1573788472-87426-4-git-send-email-yukuai3@huawei.com/
> 
> As to if patch 3 really is needed, I'll leave that up to Yu given that I
> thought we had resolved these types of issues already a year or so ago.
> 
> thanks,
> 
> greg k-h
> 
> .
> 
The main purpose of this patchset is to fix the infinite loop in
debugfs_remove_recursive. Steven point out that simple replace
list_empty with simple_empty will cause a splat with lockdep enabled.
We try to fix it with the first two patch, do you think it's appropriate?

Thanks,
Yu Kuai

