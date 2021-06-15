Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 586F73A8679
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 18:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhFOQ3r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 12:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbhFOQ3q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 12:29:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD88FC061574;
        Tue, 15 Jun 2021 09:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=tEikZHVbQy/CarH94Sq7Qfka7DsiKOsOPQjFqQ1Nn/k=; b=EuMLwmM8ZNhXiP2UeZbfChyRBM
        JFYrf72i3Ivdlub5GRCQ3m1NMjoTVNH5+J+UrY7JL5Wb3qCc9BM/YfzKNaq5QLdtP3/0rqE9wu/r9
        aBJfXMBzVuxZz/K9JcIfXX1E85xSxDwAAMKUO+sBcjQqiY10Mbx4kxskb46H5d+aji/hSCPT7OSgo
        jbSfjm61sOxnsJahd5eO4fTpPPwoyKHt2uf2PwPbpOUPBYuJl0rTZgJ2dpLa2mB5Jk4v73kvyHAIR
        zl3JzWL03+qMtaPswsVTeTWxsVOeoGPo2C3H28h8srkwmOuaoIP+rkC+UePo/DLLqhup0mraV0Bco
        J1q5hzlA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltBt5-0070Uw-FO; Tue, 15 Jun 2021 16:26:07 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 6/6] mm: Move page dirtying prototypes from mm.h
Date:   Tue, 15 Jun 2021 17:23:42 +0100
Message-Id: <20210615162342.1669332-7-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210615162342.1669332-1-willy@infradead.org>
References: <20210615162342.1669332-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These functions implement the address_space ->set_page_dirty operation
and should live in pagemap.h, not mm.h so that the rest of the kernel
doesn't get funny ideas about calling them directly.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/fuse/dax.c           | 1 +
 fs/zonefs/super.c       | 2 +-
 include/linux/mm.h      | 3 ---
 include/linux/pagemap.h | 4 ++++
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index 515ad0895345..fb733eb5aead 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -9,6 +9,7 @@
 #include <linux/delay.h>
 #include <linux/dax.h>
 #include <linux/uio.h>
+#include <linux/pagemap.h>
 #include <linux/pfn_t.h>
 #include <linux/iomap.h>
 #include <linux/interval_tree.h>
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 3aacf016c7c2..dbf03635869c 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -5,7 +5,7 @@
  * Copyright (C) 2019 Western Digital Corporation or its affiliates.
  */
 #include <linux/module.h>
-#include <linux/fs.h>
+#include <linux/pagemap.h>
 #include <linux/magic.h>
 #include <linux/iomap.h>
 #include <linux/init.h>
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1086b556961a..5608f75ecc80 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1853,9 +1853,6 @@ extern int try_to_release_page(struct page * page, gfp_t gfp_mask);
 extern void do_invalidatepage(struct page *page, unsigned int offset,
 			      unsigned int length);
 
-void __set_page_dirty(struct page *, struct address_space *, int warn);
-int __set_page_dirty_nobuffers(struct page *page);
-int __set_page_dirty_no_writeback(struct page *page);
 int redirty_page_for_writepage(struct writeback_control *wbc,
 				struct page *page);
 void account_page_cleaned(struct page *page, struct address_space *mapping,
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 5f0582de24e7..090e45616172 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -752,6 +752,10 @@ int wait_on_page_writeback_killable(struct page *page);
 extern void end_page_writeback(struct page *page);
 void wait_for_stable_page(struct page *page);
 
+void __set_page_dirty(struct page *, struct address_space *, int warn);
+int __set_page_dirty_nobuffers(struct page *page);
+int __set_page_dirty_no_writeback(struct page *page);
+
 void page_endio(struct page *page, bool is_write, int err);
 
 /**
-- 
2.30.2

