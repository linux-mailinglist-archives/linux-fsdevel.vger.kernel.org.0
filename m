Return-Path: <linux-fsdevel+bounces-23987-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8BE9372B4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 05:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D15451C20F75
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 03:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690781863E;
	Fri, 19 Jul 2024 03:22:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15D72566;
	Fri, 19 Jul 2024 03:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721359332; cv=none; b=qMyxi8MRr1f+IPZTK7QDHtEN1dIKiO+nCGtXg/e9u++gppsDiqNVqzBux7jMRFjiYS3Efvh4SXTyzcR89HnAsYsK0ubO8JP7vbBfWDO+H8xonj375WN9MosY3gR7IKLMU93TQvu/lGJI+q4BynFr5NlGNawrZiXON5BPIGYkPrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721359332; c=relaxed/simple;
	bh=/l0yJGO5EBjL933kX1ZtOmzUj71Ck6fbHD/HyU7QBtw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=gCCLPzRAShKHJGmtqDCTrHsPYlhmv/GSOirrA4DZXL6vmTHegHFzMVz78B3+/l3PdhCgMGTuXhodBsFEf/fOMio5hUMKFqDTRNRB+puDyodRjztjt8kPpuoiZHBGazm3iWtYWJMP8pC19wsJEGA7awBbCgIpt/r2M6sk/9rYWMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WQFMg0tRxz4f3lVc;
	Fri, 19 Jul 2024 11:21:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 683F71A08D7;
	Fri, 19 Jul 2024 11:22:04 +0800 (CST)
Received: from [10.174.178.46] (unknown [10.174.178.46])
	by APP4 (Coremail) with SMTP id gCh0CgCHaTfa25lmVg0nAg--.34469S3;
	Fri, 19 Jul 2024 11:22:04 +0800 (CST)
Subject: Re: [BUG REPORT] potential deadlock in inode evicting under the inode
 lru traversing context on ext4 and ubifs
To: Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 linux-ext4@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 linux-mtd <linux-mtd@lists.infradead.org>,
 Richard Weinberger <richard@nod.at>, "zhangyi (F)" <yi.zhang@huawei.com>,
 yangerkun <yangerkun@huawei.com>, "wangzhaolong (A)"
 <wangzhaolong1@huawei.com>
References: <37c29c42-7685-d1f0-067d-63582ffac405@huaweicloud.com>
 <20240712143708.GA151742@mit.edu> <20240718134031.sxnwwzzj54jxl3e5@quack3>
From: Zhihao Cheng <chengzhihao@huaweicloud.com>
Message-ID: <0b0a7b95-f6d0-a56e-5492-b48882d9a35d@huaweicloud.com>
Date: Fri, 19 Jul 2024 11:21:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240718134031.sxnwwzzj54jxl3e5@quack3>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHaTfa25lmVg0nAg--.34469S3
X-Coremail-Antispam: 1UD129KBjvJXoW3JrWktr43Xw1DZr18GF4kZwb_yoWxGr4kpF
	Z2qFyfKr4kJFy0k3s7trs0vrn2kayDtr4UJ348Kw4kZ3Z5JryftF1xGr4ayF98Ar4kCrWj
	qr4UCrnxCFsIy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: xfkh0wx2klxt3r6k3tpzhluzxrxghudrp/

Hi, Jan

ÔÚ 2024/7/18 21:40, Jan Kara Ð´µÀ:
> On Fri 12-07-24 10:37:08, Theodore Ts'o wrote:
>> On Fri, Jul 12, 2024 at 02:27:20PM +0800, Zhihao Cheng wrote:
>>> Problem description
>>> ===================
>>>
>>> The inode reclaiming process(See function prune_icache_sb) collects all
>>> reclaimable inodes and mark them with I_FREEING flag at first, at that
>>> time, other processes will be stuck if they try getting these inodes(See
>>> function find_inode_fast), then the reclaiming process destroy the
>>> inodes by function dispose_list().
>>> Some filesystems(eg. ext4 with ea_inode feature, ubifs with xattr) may
>>> do inode lookup in the inode evicting callback function, if the inode
>>> lookup is operated under the inode lru traversing context, deadlock
>>> problems may happen.
>>>
>>> Case 1: In function ext4_evict_inode(), the ea inode lookup could happen
>>> if ea_inode feature is enabled, the lookup process will be stuck under
>>> the evicting context like this:
>>>
>>>   1. File A has inode i_reg and an ea inode i_ea
>>>   2. getfattr(A, xattr_buf) // i_ea is added into lru // lru->i_ea
>>>   3. Then, following three processes running like this:
>>>
>>>      PA                              PB
>>>   echo 2 > /proc/sys/vm/drop_caches
>>>    shrink_slab
>>>     prune_dcache_sb
>>>     // i_reg is added into lru, lru->i_ea->i_reg
>>>     prune_icache_sb
>>>      list_lru_walk_one
>>>       inode_lru_isolate
>>>        i_ea->i_state |= I_FREEING // set inode state
>>>        i_ea->i_state |= I_FREEING // set inode state
>>
>> Um, I don't see how this can happen.  If the ea_inode is in use,
>> i_count will be greater than zero, and hence the inode will never be
>> go down the rest of the path in inode_lru_inode():
>>
>> 	if (atomic_read(&inode->i_count) ||
>> 	    ...) {
>> 		list_lru_isolate(lru, &inode->i_lru);
>> 		spin_unlock(&inode->i_lock);
>> 		this_cpu_dec(nr_unused);
>> 		return LRU_REMOVED;
>> 	}
>>
>> Do you have an actual reproduer which triggers this?  Or would this
>> happen be any chance something that was dreamed up with DEPT?
> 
> No, it looks like a real problem and I agree with the analysis. We don't
> hold ea_inode reference (i.e., ea_inode->i_count) from a normal inode. The
> normal inode just owns that that special on-disk xattr reference. Standard
> inode references are acquired and dropped as needed.
> 
> And this is exactly the problem: ext4_xattr_inode_dec_ref_all() called from
> evict() needs to lookup the ea_inode and iget() it. So if we are processing
> a list of inodes to dispose, all inodes have I_FREEING bit already set and
> if ea_inode and its parent normal inode are both in the list, then the
> evict()->ext4_xattr_inode_dec_ref_all()->iget() will deadlock.

Yes, absolutely right.
> 
> Normally we don't hit this path because LRU list walk is not handling
> inodes with 0 link count. But a race with unlink can make that happen with
> iput() from inode_lru_isolate().

Another reason is that mapping_empty(&inode->i_data) is consistent with 
mapping_shrinkable(&inode->i_data) in most cases(CONFIG_HIGHMEM is 
disabled in default on 64bit platforms, so mapping_shrinkable() hardly 
returns true if file inode's mapping has pagecahes), the problem path 
expects that mapping_shrinkable() returns true and mapping_empty() 
returns false.

Do we have any other methods to replace following if-branch without 
invoking __iget()?

         /* 

          * On highmem systems, mapping_shrinkable() permits dropping 

          * page cache in order to free up struct inodes: lowmem might 

          * be under pressure before the cache inside the highmem zone. 

          */ 

         if (inode_has_buffers(inode) || !mapping_empty(&inode->i_data)) 
{
                 __iget(inode);
                 ...
                 iput(inode); 

                 spin_lock(lru_lock); 

                 return LRU_RETRY; 

         }
> 
> I'm pondering about the best way to fix this. Maybe we could handle the
> need for inode pinning in inode_lru_isolate() in a similar way as in
> writeback code so that last iput() cannot happen from inode_lru_isolate().
> In writeback we use I_SYNC flag to pin the inode and evict() waits for this
> flag to clear. I'll probably sleep to it and if I won't find it too
> disgusting to live tomorrow, I can code it.
> 

I guess that you may modify like this:
diff --git a/fs/inode.c b/fs/inode.c
index f356fe2ec2b6..5b1a9b23f53f 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -457,7 +457,7 @@ EXPORT_SYMBOL(ihold);

  static void __inode_add_lru(struct inode *inode, bool rotate)
  {
-       if (inode->i_state & (I_DIRTY_ALL | I_SYNC | I_FREEING | 
I_WILL_FREE))
+       if (inode->i_state & (I_DIRTY_ALL | I_SYNC | I_FREEING | 
I_WILL_FREE | I_PINING))
                 return;
         if (atomic_read(&inode->i_count))
                 return;
@@ -845,7 +845,7 @@ static enum lru_status inode_lru_isolate(struct 
list_head *item,
          * be under pressure before the cache inside the highmem zone.
          */
         if (inode_has_buffers(inode) || !mapping_empty(&inode->i_data)) {
-               __iget(inode);
+               inode->i_state |= I_PINING;
                 spin_unlock(&inode->i_lock);
                 spin_unlock(lru_lock);
                 if (remove_inode_buffers(inode)) {
@@ -857,7 +857,10 @@ static enum lru_status inode_lru_isolate(struct 
list_head *item,
                                 __count_vm_events(PGINODESTEAL, reap);
                         mm_account_reclaimed_pages(reap);
                 }
-               iput(inode);
+               spin_lock(&inode->i_lock);
+               inode->i_state &= ~I_PINING;
+               wake_up_bit(&inode->i_state, __I_PINING);
+               spin_unlock(&inode->i_lock);
                 spin_lock(lru_lock);
                 return LRU_RETRY;
         }
@@ -1772,6 +1775,7 @@ static void iput_final(struct inode *inode)
                 return;
         }

+       inode_wait_for_pining(inode);
         state = inode->i_state;
         if (!drop) {
                 WRITE_ONCE(inode->i_state, state | I_WILL_FREE);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index fd34b5755c0b..daf094fff5fe 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2415,6 +2415,8 @@ static inline void kiocb_clone(struct kiocb 
*kiocb, struct kiocb *kiocb_src,
  #define I_DONTCACHE            (1 << 16)
  #define I_SYNC_QUEUED          (1 << 17)
  #define I_PINNING_NETFS_WB     (1 << 18)
+#define __I_PINING             19
+#define I_PINING               (1 << __I_PINING)

  #define I_DIRTY_INODE (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
  #define I_DIRTY (I_DIRTY_INODE | I_DIRTY_PAGES)

, which means that we will import a new inode state to solve the problem.


