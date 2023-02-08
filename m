Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC5D68F145
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Feb 2023 15:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbjBHOxs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Feb 2023 09:53:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjBHOxp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Feb 2023 09:53:45 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B3093E0;
        Wed,  8 Feb 2023 06:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=TTM2LCEcKRo7ysqHQyalM6+7+sVXpuzC/6B32xfg/Y0=; b=IdUzCc3Zzpj0dk7Y3co7Xeb9Hu
        K1pFmhmbEWbghQC8l4HyI7WYZ5bqIPecSVLYqZtI3XGnLF59S92cQzcbCZzCarhz5TfeHsA6joJep
        e9oBXYOGl1W3+8N5ieshbvXsiS2dbNnWrTf5G4IOj2PUx7cHvVujcxiLbwQJmdNU0rp1yFtafGqG9
        ci4/6P1yNZ1uBrxEfeuo6ByOQUrd5I7c2pipHz/uWlY6zWnAldLGOwR2noGeyjl1y/xz9cA0xByhX
        V7fH8JaTWJGILwteEObitdanCl9gv1oqgfgSKNWxnAf1cjCbr/nihjaupG2qKmuHSC8BppP2t8Tjy
        /sfL/PGQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pPlpK-001HwT-Ut; Wed, 08 Feb 2023 14:53:38 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-xfs@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 2/3] afs: Split afs_pagecache_valid() out of afs_validate()
Date:   Wed,  8 Feb 2023 14:53:34 +0000
Message-Id: <20230208145335.307287-3-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230208145335.307287-1-willy@infradead.org>
References: <20230208145335.307287-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For the map_pages() method, we need a test that does not sleep.  The page
fault handler will continue to call the fault() method where we can
sleep and do the full revalidation there.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/afs/file.c     | 14 ++------------
 fs/afs/inode.c    | 27 +++++++++++++++++++--------
 fs/afs/internal.h |  1 +
 3 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index 68d6d5dc608d..719b31374879 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -569,20 +569,10 @@ static void afs_vm_close(struct vm_area_struct *vma)
 static vm_fault_t afs_vm_map_pages(struct vm_fault *vmf, pgoff_t start_pgoff, pgoff_t end_pgoff)
 {
 	struct afs_vnode *vnode = AFS_FS_I(file_inode(vmf->vma->vm_file));
-	struct afs_file *af = vmf->vma->vm_file->private_data;
 
-	switch (afs_validate(vnode, af->key)) {
-	case 0:
+	if (afs_pagecache_valid(vnode))
 		return filemap_map_pages(vmf, start_pgoff, end_pgoff);
-	case -ENOMEM:
-		return VM_FAULT_OOM;
-	case -EINTR:
-	case -ERESTARTSYS:
-		return VM_FAULT_RETRY;
-	case -ESTALE:
-	default:
-		return VM_FAULT_SIGBUS;
-	}
+	return 0;
 }
 
 static ssize_t afs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 0167e96e5198..b1bdffd5e888 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -667,6 +667,24 @@ bool afs_check_validity(struct afs_vnode *vnode)
 	return false;
 }
 
+/*
+ * Returns true if the pagecache is still valid.  Does not sleep.
+ */
+bool afs_pagecache_valid(struct afs_vnode *vnode)
+{
+	if (unlikely(test_bit(AFS_VNODE_DELETED, &vnode->flags))) {
+		if (vnode->netfs.inode.i_nlink)
+			clear_nlink(&vnode->netfs.inode);
+		return true;
+	}
+
+	if (test_bit(AFS_VNODE_CB_PROMISED, &vnode->flags) &&
+	    afs_check_validity(vnode))
+		return true;
+
+	return false;
+}
+
 /*
  * validate a vnode/inode
  * - there are several things we need to check
@@ -684,14 +702,7 @@ int afs_validate(struct afs_vnode *vnode, struct key *key)
 	       vnode->fid.vid, vnode->fid.vnode, vnode->flags,
 	       key_serial(key));
 
-	if (unlikely(test_bit(AFS_VNODE_DELETED, &vnode->flags))) {
-		if (vnode->netfs.inode.i_nlink)
-			clear_nlink(&vnode->netfs.inode);
-		goto valid;
-	}
-
-	if (test_bit(AFS_VNODE_CB_PROMISED, &vnode->flags) &&
-	    afs_check_validity(vnode))
+	if (afs_pagecache_valid(vnode))
 		goto valid;
 
 	down_write(&vnode->validate_lock);
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index ad8523d0d038..5c95df6621f9 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1171,6 +1171,7 @@ extern struct inode *afs_iget(struct afs_operation *, struct afs_vnode_param *);
 extern struct inode *afs_root_iget(struct super_block *, struct key *);
 extern bool afs_check_validity(struct afs_vnode *);
 extern int afs_validate(struct afs_vnode *, struct key *);
+bool afs_pagecache_valid(struct afs_vnode *);
 extern int afs_getattr(struct mnt_idmap *idmap, const struct path *,
 		       struct kstat *, u32, unsigned int);
 extern int afs_setattr(struct mnt_idmap *idmap, struct dentry *, struct iattr *);
-- 
2.35.1

