Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C983E2990DA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 16:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1783629AbgJZPSy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 11:18:54 -0400
Received: from casper.infradead.org ([90.155.50.34]:43542 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1783534AbgJZPSx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 11:18:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=n6jFmTk/80oHxPEc+nlR48Wkyjmo4dNW4K8OCdeXgjc=; b=cqyQyYbVduDoU3LlPdawStRBcd
        k9JKZ+usT65v41U/kLQGzsIoTLB8YIR/y+XXv6cMlG5/JFW2duXDhmP0Gu0+9qRCCapfrrYocaatu
        ySYb84BhcAy7X0lhT64cHWlFJ2aXsIYWqrEOan6cj2T3jCiprarTM/mAwWcoyYXu9uxFwq6ppC9wq
        j4bIcU8LTet1YgryCUth5WgKFxg9qI1g79p3q5TzRjtdBD8V4bdU+yo0UifODu2CZ8zVoPYDgLhdF
        +ieu3P/fTScHyp6aP82usGr+N2NvhokP4nmIES+BPRPcduCTR2fwPHw4JZibcqQFulcI6BtnYIpQJ
        CBt1EKcA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kX4Gp-0006K8-U9; Mon, 26 Oct 2020 15:18:51 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH v2 4/4] mm: Remove nrexceptional from inode
Date:   Mon, 26 Oct 2020 15:18:49 +0000
Message-Id: <20201026151849.24232-5-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201026151849.24232-1-willy@infradead.org>
References: <20201026151849.24232-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We no longer track anything in nrexceptional, so remove it, saving 8
bytes per inode.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Tested-by: Vishal Verma <vishal.l.verma@intel.com>
---
 fs/inode.c         | 2 +-
 include/linux/fs.h | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 9d78c37b00b8..4531358ae97b 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -530,7 +530,7 @@ void clear_inode(struct inode *inode)
 	 */
 	xa_lock_irq(&inode->i_data.i_pages);
 	BUG_ON(inode->i_data.nrpages);
-	BUG_ON(inode->i_data.nrexceptional);
+	BUG_ON(!mapping_empty(&inode->i_data));
 	xa_unlock_irq(&inode->i_data.i_pages);
 	BUG_ON(!list_empty(&inode->i_data.private_list));
 	BUG_ON(!(inode->i_state & I_FREEING));
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 0bd126418bb6..a5d801430040 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -439,7 +439,6 @@ int pagecache_write_end(struct file *, struct address_space *mapping,
  * @i_mmap: Tree of private and shared mappings.
  * @i_mmap_rwsem: Protects @i_mmap and @i_mmap_writable.
  * @nrpages: Number of page entries, protected by the i_pages lock.
- * @nrexceptional: Shadow or DAX entries, protected by the i_pages lock.
  * @writeback_index: Writeback starts here.
  * @a_ops: Methods.
  * @flags: Error bits and flags (AS_*).
@@ -460,7 +459,6 @@ struct address_space {
 	struct rb_root_cached	i_mmap;
 	struct rw_semaphore	i_mmap_rwsem;
 	unsigned long		nrpages;
-	unsigned long		nrexceptional;
 	pgoff_t			writeback_index;
 	const struct address_space_operations *a_ops;
 	unsigned long		flags;
-- 
2.28.0

