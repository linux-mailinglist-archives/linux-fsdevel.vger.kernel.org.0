Return-Path: <linux-fsdevel+bounces-25063-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B2F9487EE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 05:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B5A81F23B84
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 03:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05065BAF0;
	Tue,  6 Aug 2024 03:32:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB75184D;
	Tue,  6 Aug 2024 03:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722915131; cv=none; b=dcFLmOgsryIcs+V+X7pgWXJfgurSj6cB3+uWdxem30PEJkAYpYvt569cNUMChNgXIYXWUOqGLsIDj9oaIDEqalLllR6aBs/9+6fRphsge9u5Ys+a+7jhkqJUAbSICcSL5GTlkjsgCYGgBhwAbGHWfTAb0Iej1iUphl96VdCOcPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722915131; c=relaxed/simple;
	bh=dbHqsLuKz5rqNhNxP6FSPo02iYxp8GzW/NhLzNY1nQU=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=YqB0184gOPvA7DYKUjIEzzlCxIKvHiMIhTMcqQ71SzYnNIYn+kFRQNiuIxOlP1Zsr1nK4qSVN1suDYRit5NkOMWZ3YVSAONQQlcCynOS42bts7MqJh9S23yIY71qf5bB8m2pYEF0r4dBSI1YYo3nnWtHNE2SSE9RolCh0PhNDn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WdJkp5Br2z1LB1h;
	Tue,  6 Aug 2024 11:31:46 +0800 (CST)
Received: from kwepemm000013.china.huawei.com (unknown [7.193.23.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 82644180102;
	Tue,  6 Aug 2024 11:32:05 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm000013.china.huawei.com (7.193.23.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 6 Aug 2024 11:32:04 +0800
Subject: Re: [PATCH] vfs: Don't evict inode under the inode lru traversing
 context
To: Jan Kara <jack@suse.cz>, Zhihao Cheng <chengzhihao@huaweicloud.com>
CC: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <tahsin@google.com>,
	<mjguzik@gmail.com>, <error27@gmail.com>, <tytso@mit.edu>,
	<rydercoding@hotmail.com>, <hch@infradead.org>, <andreas.dilger@intel.com>,
	<richard@nod.at>, <linux-fsdevel@vger.kernel.org>,
	<linux-ext4@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <wangzhaolong1@huawei.com>
References: <20240805013446.814357-1-chengzhihao@huaweicloud.com>
 <20240805153018.3sju3nowiqggykvf@quack3>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <f942ec06-974b-b9dd-7238-63636e82f3fb@huawei.com>
Date: Tue, 6 Aug 2024 11:31:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240805153018.3sju3nowiqggykvf@quack3>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm000013.china.huawei.com (7.193.23.81)

在 2024/8/5 23:30, Jan Kara 写道:
> On Mon 05-08-24 09:34:46, Zhihao Cheng wrote:
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
>> Case 1: In function ext4_evict_inode(), the ea inode lookup could happen
>>          if ea_inode feature is enabled, the lookup process will be stuck
>> 	under the evicting context like this:
>>
>>   1. File A has inode i_reg and an ea inode i_ea
>>   2. getfattr(A, xattr_buf) // i_ea is added into lru // lru->i_ea
>>   3. Then, following three processes running like this:
>>
>>      PA                              PB
>>   echo 2 > /proc/sys/vm/drop_caches
>>    shrink_slab
>>     prune_dcache_sb
>>     // i_reg is added into lru, lru->i_ea->i_reg
>>     prune_icache_sb
>>      list_lru_walk_one
>>       inode_lru_isolate
>>        i_ea->i_state |= I_FREEING // set inode state
>>       inode_lru_isolate
>>        __iget(i_reg)
>>        spin_unlock(&i_reg->i_lock)
>>        spin_unlock(lru_lock)
>>                                       rm file A
>>                                        i_reg->nlink = 0
>>        iput(i_reg) // i_reg->nlink is 0, do evict
>>         ext4_evict_inode
>>          ext4_xattr_delete_inode
>>           ext4_xattr_inode_dec_ref_all
>>            ext4_xattr_inode_iget
>>             ext4_iget(i_ea->i_ino)
>>              iget_locked
>>               find_inode_fast
>>                __wait_on_freeing_inode(i_ea) ----→ AA deadlock
>>      dispose_list // cannot be executed by prune_icache_sb
>>       wake_up_bit(&i_ea->i_state)
>>
>> Case 2: In deleted inode writing function ubifs_jnl_write_inode(), file
>>          deleting process holds BASEHD's wbuf->io_mutex while getting the
>> 	xattr inode, which could race with inode reclaiming process(The
>>          reclaiming process could try locking BASEHD's wbuf->io_mutex in
>> 	inode evicting function), then an ABBA deadlock problem would
>> 	happen as following:
>>
>>   1. File A has inode ia and a xattr(with inode ixa), regular file B has
>>      inode ib and a xattr.
>>   2. getfattr(A, xattr_buf) // ixa is added into lru // lru->ixa
>>   3. Then, following three processes running like this:
>>
>>          PA                PB                        PC
>>                  echo 2 > /proc/sys/vm/drop_caches
>>                   shrink_slab
>>                    prune_dcache_sb
>>                    // ib and ia are added into lru, lru->ixa->ib->ia
>>                    prune_icache_sb
>>                     list_lru_walk_one
>>                      inode_lru_isolate
>>                       ixa->i_state |= I_FREEING // set inode state
>>                      inode_lru_isolate
>>                       __iget(ib)
>>                       spin_unlock(&ib->i_lock)
>>                       spin_unlock(lru_lock)
>>                                                     rm file B
>>                                                      ib->nlink = 0
>>   rm file A
>>    iput(ia)
>>     ubifs_evict_inode(ia)
>>      ubifs_jnl_delete_inode(ia)
>>       ubifs_jnl_write_inode(ia)
>>        make_reservation(BASEHD) // Lock wbuf->io_mutex
>>        ubifs_iget(ixa->i_ino)
>>         iget_locked
>>          find_inode_fast
>>           __wait_on_freeing_inode(ixa)
>>            |          iput(ib) // ib->nlink is 0, do evict
>>            |           ubifs_evict_inode
>>            |            ubifs_jnl_delete_inode(ib)
>>            ↓             ubifs_jnl_write_inode
>>       ABBA deadlock ←-----make_reservation(BASEHD)
>>                     dispose_list // cannot be executed by prune_icache_sb
>>                      wake_up_bit(&ixa->i_state)
>>
>> Fix it by forbidding inode evicting under the inode lru traversing
>> context. In details, we import a new inode state flag 'I_LRU_ISOLATING'
>> to pin inode without holding i_count under the inode lru traversing
>> context, the inode evicting process will wait until this flag is
>> cleared from i_state.
> 
> Thanks for the patch and sorry for not getting to this myself!  Let me
> rephrase the above paragraph a bit for better readability:
> 
> Fix the possible deadlock by using new inode state flag I_LRU_ISOLATING to
> pin the inode in memory while inode_lru_isolate() reclaims its pages
> instead of using ordinary inode reference. This way inode deletion cannot
> be triggered from inode_lru_isolate() thus avoiding the deadlock. evict()
> is made to wait for I_LRU_ISOLATING to be cleared before proceeding with
> inode cleanup.
> 

Looks clearer, thanks for the rephrasing, you're really nice.
>> @@ -488,6 +488,36 @@ static void inode_lru_list_del(struct inode *inode)
>>   		this_cpu_dec(nr_unused);
>>   }
>>   
>> +static void inode_lru_isolating(struct inode *inode)
> 
> Perhaps call this inode_pin_lru_isolating()

Adopt. Will change in v2.
> 
>> +{
>> +	BUG_ON(inode->i_state & (I_LRU_ISOLATING | I_FREEING | I_WILL_FREE));
>> +	inode->i_state |= I_LRU_ISOLATING;
>> +}
>> +
>> +static void inode_lru_finish_isolating(struct inode *inode)
> 
> And call this inode_unpin_lru_isolating()?

Adopt. Will change in v2.
> 
> Otherwise the patch looks good so feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> 								Honza
> 


