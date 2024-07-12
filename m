Return-Path: <linux-fsdevel+bounces-23606-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED1492F588
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2024 08:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F311B20977
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2024 06:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF29C13D533;
	Fri, 12 Jul 2024 06:27:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AACD17BBE;
	Fri, 12 Jul 2024 06:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720765667; cv=none; b=XJPb9lT+497dbvsgQO+voJyGedvdmINpZJpnRXyKxA/zXBLEYLlDAexOapVHMtZJuzt0oPzZPjNBwIWUGUbax78nSvIHxb+bIS9fMX0zZws9vkh51opzK/iDVDcEzFgyfoYaZSHxnpy5/XRtrtvavlV5f8wqnb/Qqy2DWoMw0H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720765667; c=relaxed/simple;
	bh=3L4Y7nsXbhrfQy+s59yoRG1+TN1gXL3IuWxdlQYndxw=;
	h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type; b=VpZP5GwoHfUtHRw6Em9ez1S7x7gLysT4iYmPWpSc2I9MmdKwaMxr5TYGmhdQE0PF++qp4nhA75ST2uW3Sf5I3qMwdlj3q28UYwjMXNrQbCdwbFT9nzuaxRGVkbqvpm2gkfxj5ZccTGsr7PFAGn9OZf3h382nfB1goqdjnNPqfsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WL1q24LWdz4f3kvq;
	Fri, 12 Jul 2024 14:27:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 8ADAC1A0568;
	Fri, 12 Jul 2024 14:27:39 +0800 (CST)
Received: from [10.174.178.46] (unknown [10.174.178.46])
	by APP2 (Coremail) with SMTP id Syh0CgB34YbZzJBmRSN_Bw--.31285S3;
	Fri, 12 Jul 2024 14:27:37 +0800 (CST)
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 linux-ext4@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Ted Tso <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
 Christoph Hellwig <hch@infradead.org>,
 linux-mtd <linux-mtd@lists.infradead.org>,
 Richard Weinberger <richard@nod.at>, "zhangyi (F)" <yi.zhang@huawei.com>,
 yangerkun <yangerkun@huawei.com>, "wangzhaolong (A)"
 <wangzhaolong1@huawei.com>
From: Zhihao Cheng <chengzhihao@huaweicloud.com>
Subject: [BUG REPORT] potential deadlock in inode evicting under the inode lru
 traversing context on ext4 and ubifs
Message-ID: <37c29c42-7685-d1f0-067d-63582ffac405@huaweicloud.com>
Date: Fri, 12 Jul 2024 14:27:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgB34YbZzJBmRSN_Bw--.31285S3
X-Coremail-Antispam: 1UD129KBjvJXoWxKFWfKr4xZF17AF1rArWUArb_yoWxJw45pr
	WDWrySyr4kXFyY934vqr4kXw1093WkKF4UXr95CrnrZ3WDJF1IqF17try5AFW7GrWkA3s0
	qa1UCr1DCa1ay3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UQzVbUUUUU=
X-CM-SenderInfo: xfkh0wx2klxt3r6k3tpzhluzxrxghudrp/

Hi. Recently, we found a deadlock in inode recliaiming process caused by 
circular dependence between file inode and file's xattr inode.

Problem description
===================

The inode reclaiming process(See function prune_icache_sb) collects all 
reclaimable inodes and mark them with I_FREEING flag at first, at that 
time, other processes will be stuck if they try getting these inodes(See 
function find_inode_fast), then the reclaiming process destroy the 
inodes by function dispose_list().
Some filesystems(eg. ext4 with ea_inode feature, ubifs with xattr) may 
do inode lookup in the inode evicting callback function, if the inode 
lookup is operated under the inode lru traversing context, deadlock 
problems may happen.

Case 1: In function ext4_evict_inode(), the ea inode lookup could happen 
if ea_inode feature is enabled, the lookup process will be stuck under 
the evicting context like this:

  1. File A has inode i_reg and an ea inode i_ea
  2. getfattr(A, xattr_buf) // i_ea is added into lru // lru->i_ea
  3. Then, following three processes running like this:

     PA                              PB
  echo 2 > /proc/sys/vm/drop_caches
   shrink_slab
    prune_dcache_sb
    // i_reg is added into lru, lru->i_ea->i_reg
    prune_icache_sb
     list_lru_walk_one
      inode_lru_isolate
       i_ea->i_state |= I_FREEING // set inode state
      inode_lru_isolate
       __iget(i_reg)
       spin_unlock(&i_reg->i_lock)
       spin_unlock(lru_lock)
                                      rm file A
                                       i_reg->nlink = 0
       iput(i_reg) // i_reg->nlink is 0, do evict
        ext4_evict_inode
         ext4_xattr_delete_inode
          ext4_xattr_inode_dec_ref_all
       ext4_xattr_inode_iget
            ext4_iget(i_ea->i_ino)
             iget_locked
              find_inode_fast
               __wait_on_freeing_inode(i_ea) ----¡ú AA deadlock
     dispose_list // cannot be executed by prune_icache_sb
      wake_up_bit(&i_ea->i_state)

Case 2: In deleted inode writing function ubifs_jnl_write_inode(), file 
deleting process holds BASEHD's wbuf->io_mutex while getting the xattr 
inode, which could race with inode reclaiming process(The reclaiming 
process could try locking BASEHD's wbuf->io_mutex in inode evicting 
function), then an ABBA deadlock problem would happen as following:

  1. File A has inode ia and a xattr(with inode ixa), regular file B has
     inode ib and a xattr.
  2. getfattr(A, xattr_buf) // ixa is added into lru // lru->ixa
  3. Then, following three processes running like this:

         PA                PB                        PC
                 echo 2 > /proc/sys/vm/drop_caches
                  shrink_slab
           prune_dcache_sb
           // ib and ia are added into lru, lru->ixa->ib->ia
                   prune_icache_sb
                    list_lru_walk_one
                     inode_lru_isolate
                      ixa->i_state |= I_FREEING // set inode state
                     inode_lru_isolate
                      __iget(ib)
                      spin_unlock(&ib->i_lock)
                      spin_unlock(lru_lock)
                                                    rm file B
                                                     ib->nlink = 0
  rm file A
   iput(ia)
    ubifs_evict_inode(ia)
     ubifs_jnl_delete_inode(ia)
      ubifs_jnl_write_inode(ia)
       make_reservation(BASEHD) // Lock wbuf->io_mutex
       ubifs_iget(ixa->i_ino)
        iget_locked
         find_inode_fast
          __wait_on_freeing_inode(ixa)
           |          iput(ib) // ib->nlink is 0, do evict
           |           ubifs_evict_inode
           |            ubifs_jnl_delete_inode(ib)
          ¡ý             ubifs_jnl_write_inode
      ABBA deadlock ¡û-----make_reservation(BASEHD)
                    dispose_list // cannot be executed by prune_icache_sb
                     wake_up_bit(&ixa->i_state)

Reproducer:
===========

https://bugzilla.kernel.org/show_bug.cgi?id=219022

About solutions
===============

We have thought some solutions, but all of them will import new influence.

Solution 1: Don't cache xattr inode, make drop_inode callback return 
true for xattr inode. It will make getting xattr slower.
Test code:
     gettimeofday(&s, NULL);
     for (i = 0; i < 10000; ++i)
         if (getxattr("/root/temp/file_a", "user.a", buf, 4098) < 0)
             perror("getxattr");
     gettimeofday(&e, NULL);
     printf("cost %ld us\n", 1000000 * (e.tv_sec - s.tv_sec) + e.tv_usec 
- s.tv_usec);
Result:
ext4:
cost 151068 us // without fix
cost 321594 us // with fix
ubifs:
134125 us // without fix
371023 us // with fix

Solution 2: Don't put xattr inode into lru, which is implemented by 
holding xattr inode's refcnt until the file inode is evicted, besides 
that, make drop_inode callback return true for xattr inode. The solution 
pins xattr inode in memory until the file inode is evicted, file inode 
won't be evicted if it has pagecahes, specifically:
inode_lru_isolate
  if (inode_has_buffers(inode) || !mapping_empty(&inode->i_data)) { // 
file inode won't be evicted, so its' xattr inode won't be reclaimed too, 
which will increase the memory noise.
   __iget(inode);
   if (remove_inode_buffers(inode))
   ...
   iput(inode);
  }

Solution 3: Forbid inode evicting under the inode lru traversing 
context. Specifically, mark inode with 'I_FREEING' instead of getting 
its' refcnt to eliminate the inode getting chance in 
inode_lru_isolate(). The solution is wrong, because the pagecahes may 
still alive after invalidate_mapping_pages(), so we cannot destroy the 
file inode after clearing I_WILL_FREE.
diff --git a/fs/inode.c b/fs/inode.c
index 3a41f83a4ba5..c649be22f841 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -843,7 +844,7 @@ static enum lru_status inode_lru_isolate(struct 
list_head *item,
       * be under pressure before the cache inside the highmem zone.
       */
      if (inode_has_buffers(inode) || !mapping_empty(&inode->i_data)) {
-        __iget(inode);
+        inode->i_state |= I_WILL_FREE;
          spin_unlock(&inode->i_lock);
          spin_unlock(lru_lock);
          if (remove_inode_buffers(inode)) {
@@ -855,9 +856,9 @@ static enum lru_status inode_lru_isolate(struct 
list_head *item,
                  __count_vm_events(PGINODESTEAL, reap);
              mm_account_reclaimed_pages(reap);
          }
-        iput(inode);
+        spin_lock(&inode->i_lock);
+        inode->i_state &= ~I_WILL_FREE;
          spin_lock(lru_lock);
-        return LRU_RETRY;
      }

Solution 4: Break the circular dependence between file inode and file's 
xattr inode, for example, after comparing 
inode_lru_isolate(prune_icache_sb) with invalidate_inodes, we found that 
invalidate_mapping_pages is not invoked by invalidate_inodes, can we 
directly remove the branch 'if (inode_has_buffers(inode) || 
!mapping_empty(&inode->i_data))' from inode_lru_isolate?

Any better solutions?


