Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30CFA1AEB8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2019 03:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfEMB2f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 May 2019 21:28:35 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:54496 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727054AbfEMB2f (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 May 2019 21:28:35 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 37AC3B4F05FB5C5EF4EE;
        Mon, 13 May 2019 09:28:33 +0800 (CST)
Received: from [127.0.0.1] (10.177.33.43) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Mon, 13 May 2019
 09:28:26 +0800
Subject: Re: [Question] softlockup in __fsnotify_update_child_dentry_flags
To:     Matthew Wilcox <willy@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>
CC:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "zhangyi (F)" <yi.zhang@huawei.com>, Hou Tao <houtao1@huawei.com>,
        <huawei.libin@huawei.com>, Miao Xie <miaoxie@huawei.com>,
        <suoben@huawei.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Waiman Long <longman@redhat.com>,
        Dave Chinner <dchinner@redhat.com>
References: <0ce0173a-78f0-ae69-05b2-8374fbe3ba37@huawei.com>
 <CAOQ4uxjVf5yTNpuj=6Yb9eXpUwALx3-4tmbFG9g_WKrtkWw7wA@mail.gmail.com>
 <20190512123739.GA8050@bombadil.infradead.org>
From:   yangerkun <yangerkun@huawei.com>
Message-ID: <7d79bdc1-fc11-e605-2d15-7d2787c81444@huawei.com>
Date:   Mon, 13 May 2019 09:25:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190512123739.GA8050@bombadil.infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.33.43]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



Matthew Wilcox wrote on 2019/5/12 20:37:
> On Sun, May 12, 2019 at 12:20:14PM +0300, Amir Goldstein wrote:
>> On Fri, May 10, 2019 at 5:38 PM yangerkun <yangerkun@huawei.com> wrote:
>>> We find the lock of lockref has been catched with cpu 40. And since
>>> there is too much negative dentry in root dentry's d_subdirs, traversing
>>> will spend so long time with holding d_lock of root dentry. So other
>>> thread waiting for the lockref.lock will softlockup.
>>
>> IMO, this is DoS that can be manifested in several other ways.
>> __fsnotify_update_child_dentry_flags() is just a private case of single
>> level d_walk(). Many other uses of d_walk(), such as path_has_submounts()
>> will exhibit the same behavior under similar DoS.
>>
>> Here is a link to a discussion of a similar issue with negative dentries:
>> https://lore.kernel.org/lkml/187ee69a-451d-adaa-0714-2acbefc46d2f@redhat.com/
>>
>> I suppose we can think of better ways to iterate all non-negative
>> child dentries,
>> like keep them all at the tail of d_subdirs, but not sure about the implications
>> of moving the dentry in the list on d_instantiate().
>> We don't really have to move the dentries that turn negative (i.e. d_delete()),
>> because those are not likely to be the real source of DoS.
> 
> We should probably be more aggressive about reclaiming negative dentries.
> It's clearly ludicrous to have a million negative dentries in a single
> directory, for example.

How about add a reference to record allocation of negative under one 
dir, and once it come to the limit, we return false directly in 
retain_dentry while wo do dput?

Thanks,
Kun.
> 
> .
> 

