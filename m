Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D46923BDF4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Aug 2020 18:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbgHDQSN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Aug 2020 12:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbgHDQSA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Aug 2020 12:18:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F063C06179F
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2020 09:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=fw3P6kp9M4/LmEF88EWSj+1JuY5UZSo/KVP/TRf78l8=; b=i6NSMYfRnEAOcV0wowy8TXs3Lh
        RArlH0wUi1U4zuG2ICK2Ip9PCaDlBfRVCt6yTebj71YdXn2ht243CqIbJqrqyc4JEwbau7gkkh680
        AKybdh0bWgb/mYQ/GoTwsmUy2ewOsU7r2ONx29i7nnmYpYuCV/hz5Cz840Un1+gItCQpOUYA7YyCY
        yABsHxrNBv/tgP50buLIa1eBMsvbpwf8vPREWVMAt9VjxxbZ/xEMxXm/ClMX3dX6eudtNy239CHs1
        6EWWokN+LR3WbdTqtUDuIvIcj5J3Tvu9uiPAyJ/Lxpi5lD39jhhhDR4/SLTzYvrwq9FGL6RANwWHw
        0hT86cDw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k2zdW-0002eM-Ec; Tue, 04 Aug 2020 16:17:58 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-nvdimm@lists.01.org
Subject: [PATCH 4/4] mm: Remove nrexceptional from inode
Date:   Tue,  4 Aug 2020 17:17:55 +0100
Message-Id: <20200804161755.10100-5-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200804161755.10100-1-willy@infradead.org>
References: <20200804161755.10100-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We no longer track anything in nrexceptional, so remove it, saving 8
bytes per inode.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/inode.c         | 2 +-
 include/linux/fs.h | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 72c4c347afb7..b5c4aff077b7 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -528,7 +528,7 @@ void clear_inode(struct inode *inode)
 	 */
 	xa_lock_irq(&inode->i_data.i_pages);
 	BUG_ON(inode->i_data.nrpages);
-	BUG_ON(inode->i_data.nrexceptional);
+	BUG_ON(!page_cache_empty(&inode->i_data));
 	xa_unlock_irq(&inode->i_data.i_pages);
 	BUG_ON(!list_empty(&inode->i_data.private_list));
 	BUG_ON(!(inode->i_state & I_FREEING));
diff --git a/include/linux/fs.h b/include/linux/fs.h
index f5abba86107d..4fd8923cba43 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -436,7 +436,6 @@ int pagecache_write_end(struct file *, struct address_space *mapping,
  * @i_mmap: Tree of private and shared mappings.
  * @i_mmap_rwsem: Protects @i_mmap and @i_mmap_writable.
  * @nrpages: Number of page entries, protected by the i_pages lock.
- * @nrexceptional: Shadow or DAX entries, protected by the i_pages lock.
  * @writeback_index: Writeback starts here.
  * @a_ops: Methods.
  * @flags: Error bits and flags (AS_*).
@@ -457,7 +456,6 @@ struct address_space {
 	struct rb_root_cached	i_mmap;
 	struct rw_semaphore	i_mmap_rwsem;
 	unsigned long		nrpages;
-	unsigned long		nrexceptional;
 	pgoff_t			writeback_index;
 	const struct address_space_operations *a_ops;
 	unsigned long		flags;
-- 
2.27.0

