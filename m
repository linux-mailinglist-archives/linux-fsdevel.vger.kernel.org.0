Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A986271DF2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Sep 2020 10:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgIUI3v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Sep 2020 04:29:51 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56202 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726211AbgIUI3v (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Sep 2020 04:29:51 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7B9769B2D2B0593A0B8C;
        Mon, 21 Sep 2020 16:29:49 +0800 (CST)
Received: from [10.174.179.226] (10.174.179.226) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Mon, 21 Sep 2020 16:29:43 +0800
Subject: Re: [PATCH RESEND] fs: fix race condition oops between destroy_inode
 and writeback_sb_inodes
To:     Matthew Wilcox <willy@infradead.org>
CC:     <linux-fsdevel@vger.kernel.org>, <viro@zeniv.linux.org.uk>,
        <lihaotian9@huawei.com>, <lutianxiong@huawei.com>, <jack@suse.cz>,
        <linfeilong@huawei.com>
References: <20200919093923.19016-1-luoshijie1@huawei.com>
 <20200919145632.GM32101@casper.infradead.org>
From:   Shijie Luo <luoshijie1@huawei.com>
Message-ID: <30ea42a6-bb76-387c-1197-eabfcfca1ec7@huawei.com>
Date:   Mon, 21 Sep 2020 16:29:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200919145632.GM32101@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.179.226]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 2020/9/19 22:56, Matthew Wilcox wrote:
> This part is unnecessary.  We just allocated 'new' two lines above;
> nobody else can see 'new' yet.  We make it visible with hlist_add_head_rcu()
> which uses rcu_assign_pointer() whch contains a memory barrier, so it's
> impossible for another CPU to see a stale i_state.
>
>>   			inode = inode_insert5(new, hashval, test, set, data);
>> -			if (unlikely(inode != new))
>> +			if (unlikely(inode != new)) {
>> +				spin_lock(&new->i_lock);
>> +				new->i_state |= I_FREEING;
>> +				spin_unlock(&new->i_lock);
>> +				inode_wait_for_writeback(new);
>>   				destroy_inode(new);
> This doesn't make sense either.  If an inode is returned here which is not
> 'new', then adding 'new' to the hash failed, and new was never visible
> to another CPU.
>
>> @@ -1218,6 +1225,11 @@ struct inode *iget_locked(struct super_block *sb, unsigned long ino)
>>   		 * allocated.
>>   		 */
>>   		spin_unlock(&inode_hash_lock);
>> +
>> +		spin_lock(&inode->i_lock);
>> +		inode->i_state |= I_FREEING;
>> +		spin_unlock(&inode->i_lock);
>> +		inode_wait_for_writeback(inode);
>>   		destroy_inode(inode);
> Again, this doesn't make sense.  This is also a codepath which failed to
> make 'inode' visible to any other thread.
>
> I don't understand how this patch could fix anything.
> .

Thanks for your review，the underlying filesystem is ext4, 
ext4_alloc_inode doesn't

allocate a new vfs inode from slab, and I found the "new inode" was used 
by another

thread in vmcore, in other words, the new inode should be a new one , 
but not.

Maybe it's not a filesystem problem, and fixing this problem in 
iget_locked is not

a good way, I 'll try to find the root cause and fix it.


