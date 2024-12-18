Return-Path: <linux-fsdevel+bounces-37704-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2576D9F5EC7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 07:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61E61166321
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 06:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47754157A55;
	Wed, 18 Dec 2024 06:48:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F9614E2CF;
	Wed, 18 Dec 2024 06:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734504493; cv=none; b=WMYbDAT9R201I1kdFO/NMkcYrmD7Rp2ktPVjjl5Y37WqBWpTbw+5qUwvmAizFWUl+32CqzHMlo0u2aZ4PNOC4AxExMinPQBFDMoxQ3Vlq/1+bDyAW2gYl7XyKL6xLwuSfwYxwBISKfQl6moor4n6BxZobkOHOk/BG1rAhZSq6Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734504493; c=relaxed/simple;
	bh=Dxd3wbrklUEwkrkxVvGEjNb/3baOIVwjw20y1hzf2E8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DrwGEPUtr9FarVOUzWyKq73d2imfVZMgQNOA3BlVqsoFW9Hu7iv248HLYBGshsDVDtEgXlMYNUruj4HZSG0ByfP8Dnto47ktfjoANCTq/V2HDqdf5m6y21xE7TMudB3QKfFh3o45mPyykThv2Q8z1wiNeTMx/xBAXuxiwDG9Q3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YCkl74PVSz4f3lDq;
	Wed, 18 Dec 2024 14:47:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 277C61A0E96;
	Wed, 18 Dec 2024 14:48:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP1 (Coremail) with SMTP id cCh0CgA33a4mcGJnxKU7Ew--.4083S3;
	Wed, 18 Dec 2024 14:48:08 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: akpm@linux-foundation.org,
	willy@infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH v4 1/5] Xarray: Do not return sibling entries from xas_find_marked()
Date: Wed, 18 Dec 2024 23:46:09 +0800
Message-Id: <20241218154613.58754-2-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241218154613.58754-1-shikemeng@huaweicloud.com>
References: <20241218154613.58754-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgA33a4mcGJnxKU7Ew--.4083S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZFyfJw18Wr15Cw43Kr15Arb_yoWrCF45pF
	W8GFykKr4xtr4UArykAayUXFWru34UXFWayFWrG34av3Z8J3WjkF1j9FyjqF9rZrWDZF4f
	ZF40v3yUZ3WDC3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxV
	WUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jfAwsU
	UUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Similar to issue fixed in commit cbc02854331ed ("XArray: Do not return
sibling entries from xa_load()"), we may return sibling entries from
xas_find_marked as following:
    Thread A:               Thread B:
                            xa_store_range(xa, entry, 6, 7, gfp);
			    xa_set_mark(xa, 6, mark)
    XA_STATE(xas, xa, 6);
    xas_find_marked(&xas, 7, mark);
    offset = xas_find_chunk(xas, advance, mark);
    [offset is 6 which points to a valid entry]
                            xa_store_range(xa, entry, 4, 7, gfp);
    entry = xa_entry(xa, node, 6);
    [entry is a sibling of 4]
    if (!xa_is_node(entry))
        return entry;

Skip sibling entry like xas_find() does to protect caller from seeing
sibling entry from xas_find_marked() or caller may use sibling entry
as a valid entry and crash the kernel.

Besides, load_race() test is modified to catch mentioned issue and modified
load_race() only passes after this fix is merged.

Here is an example how this bug could be triggerred in theory in nfs which
enables large folio in mapping:
Let's take a look at involved racer:
1. How pages could be created and dirtied in nfs.
write
 ksys_write
  vfs_write
   new_sync_write
    nfs_file_write
     generic_perform_write
      nfs_write_begin
       fgf_set_order
        __filemap_get_folio
      nfs_write_end
       nfs_update_folio
        nfs_writepage_setup
	 nfs_mark_request_dirty
	  filemap_dirty_folio
	   __folio_mark_dirty
	    __xa_set_mark

2. How dirty pages could be deleted in nfs.
ioctl
 do_vfs_ioctl
  file_ioctl
   ioctl_preallocate
    vfs_fallocate
     nfs42_fallocate
      nfs42_proc_deallocate
       truncate_pagecache_range
        truncate_inode_pages_range
	 truncate_inode_folio
	  filemap_remove_folio
	   page_cache_delete
	    xas_store(&xas, NULL);

3. How dirty pages could be lockless searched
sync_file_range
 ksys_sync_file_range
  __filemap_fdatawrite_range
   filemap_fdatawrite_wbc
    do_writepages
     writeback_use_writepage
      writeback_iter
       writeback_get_folio
        filemap_get_folios_tag
         find_get_entry
          folio = xas_find_marked()
          folio_try_get(folio)

In theory, kernel will crash as following:
1.Create               2.Search             3.Delete
/* write page 2,3 */
write
 ...
  nfs_write_begin
   fgf_set_order
   __filemap_get_folio
    ...
     /* index = 2, order = 1 */
     xa_store(&xas, folio)
  nfs_write_end
   ...
    __folio_mark_dirty

                       /* sync page 2 and page 3 */
                       sync_file_range
                        ...
                         find_get_entry
                          folio = xas_find_marked()
                          /* offset will be 2 */
                          offset = xas_find_chunk()

                                             /* delete page 2 and page 3 */
                                             ioctl
                                              ...
                                               xas_store(&xas, NULL);

/* write page 0-3 */
write
 ...
  nfs_write_begin
   fgf_set_order
   __filemap_get_folio
    ...
     /* index = 0, order = 2 */
     xa_store(&xas, folio)
  nfs_write_end
   ...
    __folio_mark_dirty

                          /* get sibling entry from offset 2 */
                          entry = xa_entry(.., 2)
                          /* use sibling entry as folio and crash kernel */
                          folio_try_get(folio)

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 lib/xarray.c                          | 2 ++
 tools/testing/radix-tree/multiorder.c | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/lib/xarray.c b/lib/xarray.c
index 32d4bac8c94c..fa87949719a0 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -1382,6 +1382,8 @@ void *xas_find_marked(struct xa_state *xas, unsigned long max, xa_mark_t mark)
 		entry = xa_entry(xas->xa, xas->xa_node, xas->xa_offset);
 		if (!entry && !(xa_track_free(xas->xa) && mark == XA_FREE_MARK))
 			continue;
+		if (xa_is_sibling(entry))
+			continue;
 		if (!xa_is_node(entry))
 			return entry;
 		xas->xa_node = xa_to_node(entry);
diff --git a/tools/testing/radix-tree/multiorder.c b/tools/testing/radix-tree/multiorder.c
index cffaf2245d4f..eaff1b036989 100644
--- a/tools/testing/radix-tree/multiorder.c
+++ b/tools/testing/radix-tree/multiorder.c
@@ -227,6 +227,7 @@ static void *load_creator(void *ptr)
 			unsigned long index = (3 << RADIX_TREE_MAP_SHIFT) -
 						(1 << order);
 			item_insert_order(tree, index, order);
+			xa_set_mark(tree, index, XA_MARK_1);
 			item_delete_rcu(tree, index);
 		}
 	}
@@ -242,8 +243,11 @@ static void *load_worker(void *ptr)
 
 	rcu_register_thread();
 	while (!stop_iteration) {
+		unsigned long find_index = (2 << RADIX_TREE_MAP_SHIFT) + 1;
 		struct item *item = xa_load(ptr, index);
 		assert(!xa_is_internal(item));
+		item = xa_find(ptr, &find_index, index, XA_MARK_1);
+		assert(!xa_is_internal(item));
 	}
 	rcu_unregister_thread();
 
-- 
2.30.0


