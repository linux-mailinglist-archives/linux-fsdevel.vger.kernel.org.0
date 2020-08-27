Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A54C02542D9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 11:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbgH0J6R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 05:58:17 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:51235 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726093AbgH0J6O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 05:58:14 -0400
X-IronPort-AV: E=Sophos;i="5.76,359,1592841600"; 
   d="scan'208";a="98621923"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 27 Aug 2020 17:58:10 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id E5A1F48990D7;
        Thu, 27 Aug 2020 17:58:08 +0800 (CST)
Received: from [10.167.225.206] (10.167.225.206) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Thu, 27 Aug 2020 17:58:09 +0800
Subject: Re: [PATCH] fs: Kill DCACHE_DONTCACHE dentry even if
 DCACHE_REFERENCED is set
To:     Dave Chinner <david@fromorbit.com>
CC:     <viro@zeniv.linux.org.uk>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <y-goto@fujitsu.com>
References: <20200821015953.22956-1-lihao2018.fnst@cn.fujitsu.com>
 <20200827063748.GA12096@dread.disaster.area>
From:   "Li, Hao" <lihao2018.fnst@cn.fujitsu.com>
Message-ID: <6b3b3439-2199-8f00-ceca-d65769e94fe0@cn.fujitsu.com>
Date:   Thu, 27 Aug 2020 17:58:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <20200827063748.GA12096@dread.disaster.area>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.167.225.206]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201)
X-yoursite-MailScanner-ID: E5A1F48990D7.AD97A
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lihao2018.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/8/27 14:37, Dave Chinner wrote:
> On Fri, Aug 21, 2020 at 09:59:53AM +0800, Hao Li wrote:
>> Currently, DCACHE_REFERENCED prevents the dentry with DCACHE_DONTCACHE
>> set from being killed, so the corresponding inode can't be evicted. If
>> the DAX policy of an inode is changed, we can't make policy changing
>> take effects unless dropping caches manually.
>>
>> This patch fixes this problem and flushes the inode to disk to prepare
>> for evicting it.
>>
>> Signed-off-by: Hao Li <lihao2018.fnst@cn.fujitsu.com>
>> ---
>>  fs/dcache.c | 3 ++-
>>  fs/inode.c  | 2 +-
>>  2 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/dcache.c b/fs/dcache.c
>> index ea0485861d93..486c7409dc82 100644
>> --- a/fs/dcache.c
>> +++ b/fs/dcache.c
>> @@ -796,7 +796,8 @@ static inline bool fast_dput(struct dentry *dentry)
>>  	 */
>>  	smp_rmb();
>>  	d_flags = READ_ONCE(dentry->d_flags);
>> -	d_flags &= DCACHE_REFERENCED | DCACHE_LRU_LIST | DCACHE_DISCONNECTED;
>> +	d_flags &= DCACHE_REFERENCED | DCACHE_LRU_LIST | DCACHE_DISCONNECTED
>> +			| DCACHE_DONTCACHE;
> Seems reasonable, but you need to update the comment above as to
> how this flag fits into this code....

Yes. I will change it. Thanks.

>
>>  	/* Nothing to do? Dropping the reference was all we needed? */
>>  	if (d_flags == (DCACHE_REFERENCED | DCACHE_LRU_LIST) && !d_unhashed(dentry))
>> diff --git a/fs/inode.c b/fs/inode.c
>> index 72c4c347afb7..5218a8aebd7f 100644
>> --- a/fs/inode.c
>> +++ b/fs/inode.c
>> @@ -1632,7 +1632,7 @@ static void iput_final(struct inode *inode)
>>  	}
>>  
>>  	state = inode->i_state;
>> -	if (!drop) {
>> +	if (!drop || (drop && (inode->i_state & I_DONTCACHE))) {
>>  		WRITE_ONCE(inode->i_state, state | I_WILL_FREE);
>>  		spin_unlock(&inode->i_lock);
> What's this supposed to do? We'll only get here with drop set if the
> filesystem is mounting or unmounting.

The variable drop will also be set to True if I_DONTCACHE is set on
inode->i_state.
Although mounting/unmounting will set the drop variable, it won't set
I_DONTCACHE if I understand correctly. As a result,
drop && (inode->i_state & I_DONTCACHE) will filter out mounting/unmounting.

> In either case, why does
> having I_DONTCACHE set require the inode to be written back here
> before it is evicted from the cache?

Mounting/unmounting won't execute the code snippet which is in that if
statement, as I have explained above. However, If I_DONTCACHE is set, we
have to execute this snippet to write back inode.

I_DONTCACHE is set in d_mark_dontcache() which will be called in two
situations:
1. DAX policy is changed.
2. The inode is read through bulkstat in XFS. See commit 5132ba8f2b77
("xfs: don't cache inodes read through bulkstat") for more details.

For the first case, we have to write back the inode together with its
dirty pages before evicting.
For the second case, I think it's also necessary to write back inode before
evicting.

Thanks,
Hao Li

>
> Cheers,
>
> Dave.



