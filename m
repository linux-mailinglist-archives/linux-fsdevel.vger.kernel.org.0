Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23EB1252B1E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Aug 2020 12:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbgHZKGj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Aug 2020 06:06:39 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:40193 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728019AbgHZKGi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Aug 2020 06:06:38 -0400
X-IronPort-AV: E=Sophos;i="5.76,355,1592841600"; 
   d="scan'208";a="98568779"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 26 Aug 2020 18:06:35 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 4D79148990D7;
        Wed, 26 Aug 2020 18:06:33 +0800 (CST)
Received: from [10.167.225.206] (10.167.225.206) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Wed, 26 Aug 2020 18:06:33 +0800
Subject: Re: [PATCH] fs: Kill DCACHE_DONTCACHE dentry even if
 DCACHE_REFERENCED is set
From:   "Li, Hao" <lihao2018.fnst@cn.fujitsu.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     <viro@zeniv.linux.org.uk>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <y-goto@fujitsu.com>,
        Dave Chinner <david@fromorbit.com>, <darrick.wong@oracle.com>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
References: <20200821015953.22956-1-lihao2018.fnst@cn.fujitsu.com>
 <20200821174040.GG3142014@iweiny-DESK2.sc.intel.com>
 <20200823065413.GA535011@iweiny-DESK2.sc.intel.com>
 <66cbc944-064f-01e9-e282-fd4a4ec99ad0@cn.fujitsu.com>
Message-ID: <2e46fc36-79e5-16a4-6fca-6168f38e5ac6@cn.fujitsu.com>
Date:   Wed, 26 Aug 2020 18:06:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <66cbc944-064f-01e9-e282-fd4a4ec99ad0@cn.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.167.225.206]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201)
X-yoursite-MailScanner-ID: 4D79148990D7.AD412
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lihao2018.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

CC to Dave, darrick.wong and xfs/nvdimm list to get more discussions.

Thanks.
Hao Li

On 2020/8/24 14:17, Li, Hao wrote:
> On 2020/8/23 14:54, Ira Weiny wrote:
>> On Fri, Aug 21, 2020 at 10:40:41AM -0700, 'Ira Weiny' wrote:
>>> On Fri, Aug 21, 2020 at 09:59:53AM +0800, Hao Li wrote:
>>>> Currently, DCACHE_REFERENCED prevents the dentry with DCACHE_DONTCACHE
>>>> set from being killed, so the corresponding inode can't be evicted. If
>>>> the DAX policy of an inode is changed, we can't make policy changing
>>>> take effects unless dropping caches manually.
>>>>
>>>> This patch fixes this problem and flushes the inode to disk to prepare
>>>> for evicting it.
>>> This looks intriguing and I really hope this helps but I don't think this will
>>> guarantee that the state changes immediately will it?
>>>
>>> Do you have a test case which fails before and passes after?  Perhaps one of
>>> the new xfstests submitted by Xiao?
>> Ok I just went back and read your comment before.[1]  Sorry for being a bit
>> slow on the correlation between this patch and that email.  (BTW, I think it
>> would have been good to put those examples in the commit message and or
>> reference that example.)
> Thanks for your advice. I will add those examples in v2 after further
> discussion of this patch.
>
>> I'm assuming that with this patch example 2 from [1]
>> works without a drop_cache _if_ no other task has the file open?
> Yes. If no other task is opening the file, the inode and page cache of this
> file will be dropped during xfs_io exiting process. There is no need to run
> echo 2 > drop_caches.
>
>> Anyway, with that explanation I think you are correct that this improves the
>> situation _if_ the only references on the file is controlled by the user and
>> they have indeed closed all of them.
>>
>> The code for DCACHE_DONTCACHE as I attempted to write it was that it should
>> have prevented further caching of the inode such that the inode would evict
>> sooner.  But it seems you have found a bug/optimization?
> Yes. This patch is an optimization and can also be treated as a bugfix.
> On the other side, even though this patch can make DCACHE_DONTCACHE more
> reasonable, I am not quite sure if my approach is safe and doesn't impact
> the fs performance. I hope the community can give me more advice.
>
>> In the end, however, if another user (such as a backup running by the admin)
>> has a reference the DAX change may still be delayed.
> Yes. In this situation, neither drop_caches approach nor this patch can make
> the DAX change take effects soon.
> Moreover, things are different if the backup task exits, this patch
> will make sure the inode and page cache of the file can be dropped
> _automatically_ without manual intervention. By contrast, the original
> approach needs a manual cache dropping.
>
>> So I'm thinking the
>> documentation should remain largely as is?  But perhaps I am wrong.  Does this
>> completely remove the need for a drop_caches or only in the example you gave?
> I think the contents related to drop_caches in documentation can be removed
> if this patch's approach is acceptable.
>
>> Since I'm not a FS expert I'm still not sure.
> Frankly, I'm not an expert either, so I hope this patch can be discussed
> further in case it has side effects.
>
> Thanks,
> Hao Li
>
>> Regardless, thanks for the fixup!  :-D
>> Ira
>>
>> [1] https://lore.kernel.org/linux-xfs/ba98b77e-a806-048a-a0dc-ca585677daf3@cn.fujitsu.com/
>>
>>> Ira
>>>
>>>> Signed-off-by: Hao Li <lihao2018.fnst@cn.fujitsu.com>
>>>> ---
>>>>  fs/dcache.c | 3 ++-
>>>>  fs/inode.c  | 2 +-
>>>>  2 files changed, 3 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/fs/dcache.c b/fs/dcache.c
>>>> index ea0485861d93..486c7409dc82 100644
>>>> --- a/fs/dcache.c
>>>> +++ b/fs/dcache.c
>>>> @@ -796,7 +796,8 @@ static inline bool fast_dput(struct dentry *dentry)
>>>>  	 */
>>>>  	smp_rmb();
>>>>  	d_flags = READ_ONCE(dentry->d_flags);
>>>> -	d_flags &= DCACHE_REFERENCED | DCACHE_LRU_LIST | DCACHE_DISCONNECTED;
>>>> +	d_flags &= DCACHE_REFERENCED | DCACHE_LRU_LIST | DCACHE_DISCONNECTED
>>>> +			| DCACHE_DONTCACHE;
>>>>  
>>>>  	/* Nothing to do? Dropping the reference was all we needed? */
>>>>  	if (d_flags == (DCACHE_REFERENCED | DCACHE_LRU_LIST) && !d_unhashed(dentry))
>>>> diff --git a/fs/inode.c b/fs/inode.c
>>>> index 72c4c347afb7..5218a8aebd7f 100644
>>>> --- a/fs/inode.c
>>>> +++ b/fs/inode.c
>>>> @@ -1632,7 +1632,7 @@ static void iput_final(struct inode *inode)
>>>>  	}
>>>>  
>>>>  	state = inode->i_state;
>>>> -	if (!drop) {
>>>> +	if (!drop || (drop && (inode->i_state & I_DONTCACHE))) {
>>>>  		WRITE_ONCE(inode->i_state, state | I_WILL_FREE);
>>>>  		spin_unlock(&inode->i_lock);
>>>>  
>>>> -- 
>>>> 2.28.0
>>>>
>>>>
>>>>
>
>



