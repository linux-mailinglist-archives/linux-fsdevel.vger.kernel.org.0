Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE4845BA7C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2019 13:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbfGALVd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jul 2019 07:21:33 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8247 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727239AbfGALVd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jul 2019 07:21:33 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DAAC2A264424BE86046E;
        Mon,  1 Jul 2019 19:21:28 +0800 (CST)
Received: from [127.0.0.1] (10.184.213.217) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Mon, 1 Jul 2019
 19:21:21 +0800
Subject: Re: [PATCH] fs: change last_ino type to unsigned long
To:     Matthew Wilcox <willy@infradead.org>
CC:     <viro@zeniv.linux.org.uk>, <linux-fsdevel@vger.kernel.org>,
        <houtao1@huawei.com>, <yi.zhang@huawei.com>, <rui.xiang@huawei.com>
References: <1561811293-75769-1-git-send-email-zhengbin13@huawei.com>
 <20190629142101.GA1180@bombadil.infradead.org>
 <b8edc95d-0073-ab0f-27f2-3aee3a728d00@huawei.com>
 <20190701015257.GA18754@bombadil.infradead.org>
From:   "zhengbin (A)" <zhengbin13@huawei.com>
Message-ID: <34ee1d36-25d2-6971-9d10-17dd0ab721b1@huawei.com>
Date:   Mon, 1 Jul 2019 19:21:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190701015257.GA18754@bombadil.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.184.213.217]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/7/1 9:52, Matthew Wilcox wrote:

> On Mon, Jul 01, 2019 at 09:48:03AM +0800, zhengbin (A) wrote:
>> On 2019/6/29 22:21, Matthew Wilcox wrote:
>>> On Sat, Jun 29, 2019 at 08:28:13PM +0800, zhengbin wrote:
>>>> tmpfs use get_next_ino to get inode number, if last_ino wraps,
>>>> there will be files share the same inode number. Change last_ino
>>>> type to unsigned long.
>>> Is this a serious problem?
>> Yes, if two files share the same inode number, when application uses dlopen to get
>>
>> file handle,  there will be problems.
> That wasn't what I meant.  Does it happen in practice?  Have you observed
> it, or are you just worrying about a potential problem?
>
>> Maybe we could use iunique to try to get a unique i_ino value(when we allocate new inode,
>>
>> we need to add it to the hashtable), the questions are:
>>
>> 1. inode creation will be slow down, as the comment of function  iunique says:
>>
>>  *    BUGS:
>>  *    With a large number of inodes live on the file system this function
>>  *    currently becomes quite slow.
>>
>> 2. we need to convert all callers of  get_next_ino to use iunique (tmpfs, autofs, configfs...),
>>
>> moreover, the more callers are converted, the function of iunique will be more slower.
>>
>>
>> Looking forward to your reply, thanks.
>>> I'd be more convinced by a patch to use
>>> the sbitmap data structure than a blind conversion to use atomic64_t.
> You ignored this sentence.

Hi, maybe sbitmap is not a good solution, max_inodes of tmpfs are controlled by mount options--nrinodes,

which can be modified by remountfs(bigger or smaller), as the comment of function sbitmap_resize says:

 * Doesn't reallocate anything. It's up to the caller to ensure that the new
 * depth doesn't exceed the depth that the sb was initialized with.

We can modify this to meet the growing requirements, there will still be questions as follows:

1. tmpfs is a ram filesystem, we need to allocate sbitmap memory for sbinfo->max_inodes(while this maybe huge)

2.If remountfs changes  max_inode, we have to deal with it, while this may take a long time

(bigger: we need to free the old sbitmap memory, allocate new memory, copy the old sbitmap to new sbitmap

smaller: How do we deal with it?ie: we use sb->map[inode number/8] to find the sbitmap, we need to change the exist

inode numbers?while this maybe used by userspace application.)

>
> .
>

