Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDBB4361779
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Apr 2021 04:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238152AbhDPCT5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Apr 2021 22:19:57 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16129 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236747AbhDPCT5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Apr 2021 22:19:57 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FM0Fc6t9VzpXj7;
        Fri, 16 Apr 2021 10:16:36 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.498.0; Fri, 16 Apr
 2021 10:19:28 +0800
Subject: Re: [PATCH] direct-io: use read lock for DIO_LOCKING flag
To:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
CC:     <jack@suse.com>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20210415094332.37231-1-yuchao0@huawei.com>
 <20210415102413.GA25217@quack2.suse.cz>
 <YHjds1kY6h2kzIZ+@zeniv-ca.linux.org.uk>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <914e86e7-f53a-ea69-ab9d-d05cd28a9802@huawei.com>
Date:   Fri, 16 Apr 2021 10:19:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <YHjds1kY6h2kzIZ+@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/4/16 8:43, Al Viro wrote:
> On Thu, Apr 15, 2021 at 12:24:13PM +0200, Jan Kara wrote:
>> On Thu 15-04-21 17:43:32, Chao Yu wrote:
>>> 9902af79c01a ("parallel lookups: actual switch to rwsem") changes inode
>>> lock from mutex to rwsem, however, we forgot to adjust lock for
>>> DIO_LOCKING flag in do_blockdev_direct_IO(),
> 
> The change in question had nothing to do with the use of ->i_mutex for
> regular files data access.
> 
>>> so let's change to hold read
>>> lock to mitigate performance regression in the case of read DIO vs read DIO,
>>> meanwhile it still keeps original functionality of avoiding buffered access
>>> vs direct access.
>>>
>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>>
>> Thanks for the patch but this is not safe. Originally we had exclusive lock
>> (with i_mutex), switching to rwsem doesn't change that requirement. It may
>> be OK for some filesystems to actually use shared acquisition of rwsem for
>> DIO reads but it is not clear that is fine for all filesystems (and I
>> suspect those filesystems that actually do care already don't use
>> DIO_LOCKING flag or were already converted to iomap_dio_rw()). So unless
>> you do audit of all filesystems using do_blockdev_direct_IO() with
>> DIO_LOCKING flag and make sure they are all fine with inode lock in shared
>> mode, this is a no-go.
> 
> Aye.  Frankly, I would expect that anyone bothering with that kind of
> analysis for given filesystem (and there are fairly unpleasant ones in the
> list) would just use the fruits of those efforts to convert it over to
> iomap.

Actually, I was misguided by DIO_LOCKING comments more or less, it looks it
was introduced to avoid race case only in between buffered IO and DIO.

	/* need locking between buffered and direct access */
	DIO_LOCKING	= 0x01,

I don't think it is easy for me to analyse usage scenario/restriction of all
DIO_LOCKING users, and get their developers' acks for this change.

Converting fs to use iomap_dio_rw looks a better option for me, thanks, Jan
and Al. :)

Thanks,

> 
> "Read DIO" does not mean that accesses to private in-core data structures used
> by given filesystem can be safely done in parallel.  So blanket patch like
> that is not safe at all.
> .
> 
