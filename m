Return-Path: <linux-fsdevel+bounces-24963-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFED89472F5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 03:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96415280E52
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 01:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB9613C9D4;
	Mon,  5 Aug 2024 01:24:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C2717C;
	Mon,  5 Aug 2024 01:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722821073; cv=none; b=dismK0xNkxTTkFzd4+KpogRFYV0oRE+TkkUi6x4iPQExdO2iZCVTVSCQ0IqRMpyDVH6IMP1OdIfNaSmva2yqSWJawvvkRQSS9XSp7PXCHcqXkLtnXhfeibzbBphjDnAMByLnAXu2YiljUsIcysVBIM8sCJw6g4wAwTcjCUjX/LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722821073; c=relaxed/simple;
	bh=/ZOk4AgEJQcDHrophfwvbq7U63RPcEwIzfw4QAjG874=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=OnJ2eINA/qRrq1Hkb5RHOC2EJm8W8VarqWcf0SlhxDHO53nJFJHv2mX865TDWbTNz9DvgO4rVHlOh4mrOmuYVgRqYvE5t0QLcHXp4+f8mwNM8DkmpF1xhfd/Yaa70LPFI7x9Az9Oho8CqTJHaNpJh9KBn/6kEkHcFer02kVSWOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wcdy82XgSz4f3jjk;
	Mon,  5 Aug 2024 09:24:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3E44D1A0E96;
	Mon,  5 Aug 2024 09:24:25 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
	by APP4 (Coremail) with SMTP id gCh0CgB37ILAKbBmNuwwAw--.55750S4;
	Mon, 05 Aug 2024 09:24:21 +0800 (CST)
From: Zhihao Cheng <chengzhihao@huaweicloud.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	tahsin@google.com,
	mjguzik@gmail.com,
	error27@gmail.com,
	tytso@mit.edu,
	rydercoding@hotmail.com,
	jack@suse.cz,
	hch@infradead.org,
	andreas.dilger@intel.com,
	richard@nod.at
Cc: linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	chengzhihao1@huawei.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	wangzhaolong1@huawei.com
Subject: [PATCH] vfs: Don't evict inode under the inode lru traversing context
Date: Mon,  5 Aug 2024 09:34:46 +0800
Message-Id: <20240805013446.814357-1-chengzhihao@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB37ILAKbBmNuwwAw--.55750S4
X-Coremail-Antispam: 1UD129KBjvJXoWxKF45Ar1DtrWDJw48JF48Crg_yoWxKFyfpF
	9rWryFkrs5XFyI93s7tr40gw1Yka1kGr47try8Wr1kAFn8J34SqFnFgr13ZFyUtrZ7Z390
	qF4UCrn7uw42y3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
	6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUIa0PDUUUU
X-CM-SenderInfo: xfkh0wx2klxt3r6k3tpzhluzxrxghudrp/

From: Zhihao Cheng <chengzhihao1@huawei.com>

The inode reclaiming process(See function prune_icache_sb) collects all
reclaimable inodes and mark them with I_FREEING flag at first, at that
time, other processes will be stuck if they try getting these inodes
(See function find_inode_fast), then the reclaiming process destroy the
inodes by function dispose_list(). Some filesystems(eg. ext4 with
ea_inode feature, ubifs with xattr) may do inode lookup in the inode
evicting callback function, if the inode lookup is operated under the
inode lru traversing context, deadlock problems may happen.

Case 1: In function ext4_evict_inode(), the ea inode lookup could happen
        if ea_inode feature is enabled, the lookup process will be stuck
	under the evicting context like this:

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
              __wait_on_freeing_inode(i_ea) ----→ AA deadlock
    dispose_list // cannot be executed by prune_icache_sb
     wake_up_bit(&i_ea->i_state)

Case 2: In deleted inode writing function ubifs_jnl_write_inode(), file
        deleting process holds BASEHD's wbuf->io_mutex while getting the
	xattr inode, which could race with inode reclaiming process(The
        reclaiming process could try locking BASEHD's wbuf->io_mutex in
	inode evicting function), then an ABBA deadlock problem would
	happen as following:

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
          ↓             ubifs_jnl_write_inode
     ABBA deadlock ←-----make_reservation(BASEHD)
                   dispose_list // cannot be executed by prune_icache_sb
                    wake_up_bit(&ixa->i_state)

Fix it by forbidding inode evicting under the inode lru traversing
context. In details, we import a new inode state flag 'I_LRU_ISOLATING'
to pin inode without holding i_count under the inode lru traversing
context, the inode evicting process will wait until this flag is
cleared from i_state.

Link: https://lore.kernel.org/all/37c29c42-7685-d1f0-067d-63582ffac405@huaweicloud.com/
Link: https://bugzilla.kernel.org/show_bug.cgi?id=219022
Fixes: e50e5129f384 ("ext4: xattr-in-inode support")
Fixes: 7959cf3a7506 ("ubifs: journal: Handle xattrs like files")
Cc: stable@vger.kernel.org
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Suggested-by: Jan Kara <jack@suse.cz>
Suggested-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/inode.c         | 37 +++++++++++++++++++++++++++++++++++--
 include/linux/fs.h |  5 +++++
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 86670941884b..f1c6e8072f39 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -488,6 +488,36 @@ static void inode_lru_list_del(struct inode *inode)
 		this_cpu_dec(nr_unused);
 }
 
+static void inode_lru_isolating(struct inode *inode)
+{
+	BUG_ON(inode->i_state & (I_LRU_ISOLATING | I_FREEING | I_WILL_FREE));
+	inode->i_state |= I_LRU_ISOLATING;
+}
+
+static void inode_lru_finish_isolating(struct inode *inode)
+{
+	spin_lock(&inode->i_lock);
+	BUG_ON(!(inode->i_state & I_LRU_ISOLATING));
+	inode->i_state &= ~I_LRU_ISOLATING;
+	wake_up_bit(&inode->i_state, __I_LRU_ISOLATING);
+	spin_unlock(&inode->i_lock);
+}
+
+static void inode_wait_for_lru_isolating(struct inode *inode)
+{
+	DEFINE_WAIT_BIT(wq, &inode->i_state, __I_LRU_ISOLATING);
+	wait_queue_head_t *wqh;
+
+	spin_lock(&inode->i_lock);
+	wqh = bit_waitqueue(&inode->i_state, __I_LRU_ISOLATING);
+	while (inode->i_state & I_LRU_ISOLATING) {
+		spin_unlock(&inode->i_lock);
+		__wait_on_bit(wqh, &wq, bit_wait, TASK_UNINTERRUPTIBLE);
+		spin_lock(&inode->i_lock);
+	}
+	spin_unlock(&inode->i_lock);
+}
+
 /**
  * inode_sb_list_add - add inode to the superblock list of inodes
  * @inode: inode to add
@@ -657,6 +687,9 @@ static void evict(struct inode *inode)
 
 	inode_sb_list_del(inode);
 
+	/* Wait for LRU isolating to finish. */
+	inode_wait_for_lru_isolating(inode);
+
 	/*
 	 * Wait for flusher thread to be done with the inode so that filesystem
 	 * does not start destroying it while writeback is still running. Since
@@ -855,7 +888,7 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
 	 * be under pressure before the cache inside the highmem zone.
 	 */
 	if (inode_has_buffers(inode) || !mapping_empty(&inode->i_data)) {
-		__iget(inode);
+		inode_lru_isolating(inode);
 		spin_unlock(&inode->i_lock);
 		spin_unlock(lru_lock);
 		if (remove_inode_buffers(inode)) {
@@ -867,7 +900,7 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
 				__count_vm_events(PGINODESTEAL, reap);
 			mm_account_reclaimed_pages(reap);
 		}
-		iput(inode);
+		inode_lru_finish_isolating(inode);
 		spin_lock(lru_lock);
 		return LRU_RETRY;
 	}
diff --git a/include/linux/fs.h b/include/linux/fs.h
index fd34b5755c0b..fb0426f349fc 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2392,6 +2392,9 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
  *
  * I_PINNING_FSCACHE_WB	Inode is pinning an fscache object for writeback.
  *
+ * I_LRU_ISOLATING	Inode is pinned being isolated from LRU without holding
+ *			i_count.
+ *
  * Q: What is the difference between I_WILL_FREE and I_FREEING?
  */
 #define I_DIRTY_SYNC		(1 << 0)
@@ -2415,6 +2418,8 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
 #define I_DONTCACHE		(1 << 16)
 #define I_SYNC_QUEUED		(1 << 17)
 #define I_PINNING_NETFS_WB	(1 << 18)
+#define __I_LRU_ISOLATING	19
+#define I_LRU_ISOLATING		(1 << __I_LRU_ISOLATING)
 
 #define I_DIRTY_INODE (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
 #define I_DIRTY (I_DIRTY_INODE | I_DIRTY_PAGES)
-- 
2.39.2


