Return-Path: <linux-fsdevel+bounces-37259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B12D29F030F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 04:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62E4D28476D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 03:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE45155A52;
	Fri, 13 Dec 2024 03:27:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1AD22094;
	Fri, 13 Dec 2024 03:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734060435; cv=none; b=TmEoYLeHtHR2gIAIbivdxktwj7/InfhzThWt4iSjo3p9tn7I0ITuOwU/EBCvDbzeoUtXtkfrTsB1ZZbSaSBFq1YgZfA1urDKYYMKkKPFJ0RlYl7NMctTMWN9VK/mpj7vNvFIdn/+bzZLzK5FzZyzoNC8BjJappB/Moaa6nSNX6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734060435; c=relaxed/simple;
	bh=MAQm411/eIeBmu5Cz0vLascSpAftZreb77KZ0OqUlI4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FdYJrdfaifEfy4YZLNuLc6NmEKq03zdW7hhM1VlAw/9HdKbD3hZ0gw+mKIzM+BKmi4sBjGgJuVKNA3h1GobbkDItw7DbocQwaqRT354mvdwKOwHR2MjmD6zn+g33N5sT6F4O9CDY0cFh4/3cuWX7miqQziZ7foXon9rEx7N4usE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Y8ZWZ4plRz4f3jXc;
	Fri, 13 Dec 2024 11:26:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 018A01A018D;
	Fri, 13 Dec 2024 11:27:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP4 (Coremail) with SMTP id gCh0CgBHcISMqVtnfJ3KEQ--.55430S3;
	Fri, 13 Dec 2024 11:27:09 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: akpm@linux-foundation.org,
	willy@infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v3 1/5] Xarray: Do not return sibling entries from xas_find_marked()
Date: Fri, 13 Dec 2024 20:25:19 +0800
Message-Id: <20241213122523.12764-2-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241213122523.12764-1-shikemeng@huaweicloud.com>
References: <20241213122523.12764-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHcISMqVtnfJ3KEQ--.55430S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZFyfJw18Wr15Cw43Kr15Arb_yoWrCF4fpF
	W8KFyDKr4ktr4UAr97Aay8XrWrW3y8XFWSyFWrGr1ayFnxA3WYkF1j9FyjqF9rZrWDAF4S
	yF40934UZF1DG3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_Jrv_JF4l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28E
	F7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F4
	0EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_
	Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r
	126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
	1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUswZ2DUUU
	U
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

Here is an example how this bug could be triggerred in tmpfs which
enables large folio in mapping:
Let's take a look at involved racer:
1. How pages could be created and dirtied in shmem file.
write
 ksys_write
  vfs_write
   new_sync_write
    shmem_file_write_iter
     generic_perform_write
      shmem_write_begin
       shmem_get_folio
        shmem_allowable_huge_orders
        shmem_alloc_and_add_folios
        shmem_alloc_folio
        __folio_set_locked
        shmem_add_to_page_cache
         XA_STATE_ORDER(..., index, order)
         xax_store()
      shmem_write_end
       folio_mark_dirty()

2. How dirty pages could be deleted in shmem file.
ioctl
 do_vfs_ioctl
  file_ioctl
   ioctl_preallocate
    vfs_fallocate
     shmem_fallocate
      shmem_truncate_range
       shmem_undo_range
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

Kernel will crash as following:
1.Create               2.Search             3.Delete
/* write page 2,3 */
write
 ...
  shmem_write_begin
   XA_STATE_ORDER(xas, i_pages, index = 2, order = 1)
   xa_store(&xas, folio)
  shmem_write_end
   folio_mark_dirty()

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
  shmem_write_begin
   XA_STATE_ORDER(xas, i_pages, index = 0, order = 2)
   xa_store(&xas, folio)
  shmem_write_end
   folio_mark_dirty(folio)

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


