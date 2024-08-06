Return-Path: <linux-fsdevel+bounces-25065-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E5694880B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 05:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BB1A1C2232D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 03:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0E21B9B5E;
	Tue,  6 Aug 2024 03:49:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45FF17C203;
	Tue,  6 Aug 2024 03:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722916146; cv=none; b=CBrUeybwqftekAt/sac5NTEhHrhxOwxxFC2XN/MKoX9pt8v6uRNuWPbjrFa87FT7tlZRKHvgW92H1ds88M1BIhH/oxlWMB0GYBRYPrRjPu7PZGZRJReAPDK3275pjkAPnOAnbOFHs/17881gtFTnki8FUQGhSTOgQ7mOtBrPi5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722916146; c=relaxed/simple;
	bh=YpT/++I3Fgd1g9Ai+uSPnGC+7c2sQUlHivfbtMMk1vo=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=GxJ+NWZhea2+lWNmRlq2kYcs+cMzZCbUcv2tzXGKfckcv6ZerQT6v23PvP4DlaYPfgiCS32qDxTbVsubhh83vAFQ6aCRVvn7hpyKvFnjjaOhV+KukBSgpls+5c7osFrbQLmgizonkhFChYe3WOFszdFB3I2ydEs/d0BZmE/AoRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WdK6K65fFz1L9bV;
	Tue,  6 Aug 2024 11:48:41 +0800 (CST)
Received: from kwepemm000013.china.huawei.com (unknown [7.193.23.81])
	by mail.maildlp.com (Postfix) with ESMTPS id A35EB180102;
	Tue,  6 Aug 2024 11:49:00 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm000013.china.huawei.com (7.193.23.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 6 Aug 2024 11:48:59 +0800
Subject: Re: [PATCH] vfs: Don't evict inode under the inode lru traversing
 context
To: Mateusz Guzik <mjguzik@gmail.com>, Zhihao Cheng
	<chengzhihao@huaweicloud.com>
CC: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <tahsin@google.com>,
	<error27@gmail.com>, <tytso@mit.edu>, <rydercoding@hotmail.com>,
	<jack@suse.cz>, <hch@infradead.org>, <andreas.dilger@intel.com>,
	<richard@nod.at>, <linux-fsdevel@vger.kernel.org>,
	<linux-ext4@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <wangzhaolong1@huawei.com>
References: <20240805013446.814357-1-chengzhihao@huaweicloud.com>
 <CAGudoHHVnB3ZV1Pa235uqw+KoJZ6EN4b5An4LsW-z=EVhgHiVg@mail.gmail.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <3a6d4838-7f3b-8790-81dc-ec512930dabf@huawei.com>
Date: Tue, 6 Aug 2024 11:48:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAGudoHHVnB3ZV1Pa235uqw+KoJZ6EN4b5An4LsW-z=EVhgHiVg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm000013.china.huawei.com (7.193.23.81)

在 2024/8/6 0:10, Mateusz Guzik 写道:
> On Mon, Aug 5, 2024 at 3:24 AM Zhihao Cheng <chengzhihao@huaweicloud.com> wrote:
>>
>> From: Zhihao Cheng <chengzhihao1@huawei.com>
>>
>> The inode reclaiming process(See function prune_icache_sb) collects all
>> reclaimable inodes and mark them with I_FREEING flag at first, at that
>> time, other processes will be stuck if they try getting these inodes
>> (See function find_inode_fast), then the reclaiming process destroy the
>> inodes by function dispose_list(). Some filesystems(eg. ext4 with
>> ea_inode feature, ubifs with xattr) may do inode lookup in the inode
>> evicting callback function, if the inode lookup is operated under the
>> inode lru traversing context, deadlock problems may happen.
>>
[...]
> 
> I only have some tidy-ups with stuff I neglected to mention when
> typing up my proposal.
> 
>> ---
>>   fs/inode.c         | 37 +++++++++++++++++++++++++++++++++++--
>>   include/linux/fs.h |  5 +++++
>>   2 files changed, 40 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/inode.c b/fs/inode.c
>> index 86670941884b..f1c6e8072f39 100644
>> --- a/fs/inode.c
>> +++ b/fs/inode.c
>> @@ -488,6 +488,36 @@ static void inode_lru_list_del(struct inode *inode)
>>                  this_cpu_dec(nr_unused);
>>   }
>>
>> +static void inode_lru_isolating(struct inode *inode)
>> +{
> 
>          lockdep_assert_held(&inode->i_lock);

Adopt, will change in v2.
> 
>> +       BUG_ON(inode->i_state & (I_LRU_ISOLATING | I_FREEING | I_WILL_FREE));
>> +       inode->i_state |= I_LRU_ISOLATING;
>> +}
>> +
>> +static void inode_lru_finish_isolating(struct inode *inode)
>> +{
>> +       spin_lock(&inode->i_lock);
>> +       BUG_ON(!(inode->i_state & I_LRU_ISOLATING));
>> +       inode->i_state &= ~I_LRU_ISOLATING;
>> +       wake_up_bit(&inode->i_state, __I_LRU_ISOLATING);
>> +       spin_unlock(&inode->i_lock);
>> +}
>> +
>> +static void inode_wait_for_lru_isolating(struct inode *inode)
>> +{
>> +       DEFINE_WAIT_BIT(wq, &inode->i_state, __I_LRU_ISOLATING);
>> +       wait_queue_head_t *wqh;
>> +
> 
> Top of evict() asserts on I_FREEING being set, used to decide it's not
> legit to pin above. This dependency can be documented it in the
> routine as well:
> 
> BUG_ON(!(inode->i_state & I_FREEING));

Sorry, I don't understand it, do you mean add the 
'BUG_ON(!(inode->i_state & I_FREEING))' in 
inode_wait_for_lru_isolating()? Just like you talked, evict() already 
has one. So far, the inode_wait_for_lru_isolating() is called only in 
evict(), we can add the BUG_ON if it is called more than one places in 
future.>
>> +       spin_lock(&inode->i_lock);
> 
> This lock acquire is avoidable, which is always nice to do for
> single-threaded perf. Probably can be also done for the writeback code
> below. Maybe I'll massage it myself after the patch lands.

Yes, maybe inode_wait_for_writeback() and inode_wait_for_lru_isolating() 
can be lockless, and a smp_rmb() is needed, I think.
> 
>> +       wqh = bit_waitqueue(&inode->i_state, __I_LRU_ISOLATING);
>> +       while (inode->i_state & I_LRU_ISOLATING) {
>> +               spin_unlock(&inode->i_lock);
>> +               __wait_on_bit(wqh, &wq, bit_wait, TASK_UNINTERRUPTIBLE);
>> +               spin_lock(&inode->i_lock);
>> +       }
>> +       spin_unlock(&inode->i_lock);
>> +}
> 
> So new arrivals *are* blocked by this point thanks to I_FREEING being
> set on entry to evict(). This also means the flag can show up at most
> once.
> 
> Thus instead of looping this should merely go to sleep once and assert
> the I_LRU_ISOLATING flag is no longer set after waking up.

Good improvement, will change in v2.
> 
>> +
>>   /**
>>    * inode_sb_list_add - add inode to the superblock list of inodes
>>    * @inode: inode to add
>> @@ -657,6 +687,9 @@ static void evict(struct inode *inode)
>>
>>          inode_sb_list_del(inode);
>>
>> +       /* Wait for LRU isolating to finish. */
> 
> I don't think this comment adds anything given the name of the func.

Adopt, will be deleted in v2.
> 
>> +       inode_wait_for_lru_isolating(inode);
>> +
>>          /*
>>           * Wait for flusher thread to be done with the inode so that filesystem
>>           * does not start destroying it while writeback is still running. Since
>> @@ -855,7 +888,7 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
>>           * be under pressure before the cache inside the highmem zone.
>>           */
>>          if (inode_has_buffers(inode) || !mapping_empty(&inode->i_data)) {
>> -               __iget(inode);
>> +               inode_lru_isolating(inode);
>>                  spin_unlock(&inode->i_lock);
>>                  spin_unlock(lru_lock);
>>                  if (remove_inode_buffers(inode)) {
>> @@ -867,7 +900,7 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
>>                                  __count_vm_events(PGINODESTEAL, reap);
>>                          mm_account_reclaimed_pages(reap);
>>                  }
>> -               iput(inode);
>> +               inode_lru_finish_isolating(inode);
>>                  spin_lock(lru_lock);
>>                  return LRU_RETRY;
>>          }
>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>> index fd34b5755c0b..fb0426f349fc 100644
>> --- a/include/linux/fs.h
>> +++ b/include/linux/fs.h
>> @@ -2392,6 +2392,9 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
>>    *
>>    * I_PINNING_FSCACHE_WB        Inode is pinning an fscache object for writeback.
>>    *
>> + * I_LRU_ISOLATING     Inode is pinned being isolated from LRU without holding
>> + *                     i_count.
>> + *
>>    * Q: What is the difference between I_WILL_FREE and I_FREEING?
>>    */
>>   #define I_DIRTY_SYNC           (1 << 0)
>> @@ -2415,6 +2418,8 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
>>   #define I_DONTCACHE            (1 << 16)
>>   #define I_SYNC_QUEUED          (1 << 17)
>>   #define I_PINNING_NETFS_WB     (1 << 18)
>> +#define __I_LRU_ISOLATING      19
>> +#define I_LRU_ISOLATING                (1 << __I_LRU_ISOLATING)
>>
>>   #define I_DIRTY_INODE (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
>>   #define I_DIRTY (I_DIRTY_INODE | I_DIRTY_PAGES)
>> --
>> 2.39.2
>>
> 
> 


