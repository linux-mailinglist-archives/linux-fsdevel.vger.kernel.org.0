Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5781C5BF5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 17:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730530AbgEEPnn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 11:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729665AbgEEPnn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 11:43:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336D5C061A10;
        Tue,  5 May 2020 08:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=+B3mGCOGwr3o9Fx1WeqyttW2mR2BwA0B1KXgOg5mlis=; b=Llo5LTeFqp91obkWJVt3NTISR8
        pB/mjVIFUiEqoVOhJJ1cqjT4PWJHSrTXiWrjlfxgnFQkTt3fRqCsLzRkHIgyrTO5rYacmj6ygSlCg
        6DH3g8mkj1mbzxknhPZ961u0/rMhd1j94fEQVJnoXmuSTP083t5M/Amg1wFlGq0gFSQvyW2wZqFN7
        1rw6DsKNEDBxlkR+ieOjMaYGlYp/btWEtSkLoFYKpiybo8YgvYWecin1HvxvYKRU0CxQUrNZmorD9
        LgTX4GcMj6ZgN8OH92Cugd04bI2uIRXfIXbIANg/sflQQs/qHRH8wYYgl2BMuEM4e7JGy3dxZXgl3
        ffKTMx2A==;
Received: from [2001:4bb8:191:66b6:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jVzjS-000418-KW; Tue, 05 May 2020 15:43:43 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-ext4@vger.kernel.org, viro@zeniv.linux.org.uk
Cc:     jack@suse.cz, tytso@mit.edu, adilger@dilger.ca,
        riteshh@linux.ibm.com, amir73il@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Subject: [PATCH 05/11] fs: mark __generic_block_fiemap static
Date:   Tue,  5 May 2020 17:43:18 +0200
Message-Id: <20200505154324.3226743-6-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200505154324.3226743-1-hch@lst.de>
References: <20200505154324.3226743-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is no caller left outside of ioctl.c.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/ioctl.c         | 4 +---
 include/linux/fs.h | 4 ----
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index 5e80b40bc1b5c..8fe5131b1deea 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -307,8 +307,7 @@ static inline loff_t blk_to_logical(struct inode *inode, sector_t blk)
  * If you use this function directly, you need to do your own locking. Use
  * generic_block_fiemap if you want the locking done for you.
  */
-
-int __generic_block_fiemap(struct inode *inode,
+static int __generic_block_fiemap(struct inode *inode,
 			   struct fiemap_extent_info *fieinfo, loff_t start,
 			   loff_t len, get_block_t *get_block)
 {
@@ -453,7 +452,6 @@ int __generic_block_fiemap(struct inode *inode,
 
 	return ret;
 }
-EXPORT_SYMBOL(__generic_block_fiemap);
 
 /**
  * generic_block_fiemap - FIEMAP for block based inodes
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 45cc10cdf6ddd..69b7619eb83d0 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3299,10 +3299,6 @@ static inline int vfs_fstat(int fd, struct kstat *stat)
 extern const char *vfs_get_link(struct dentry *, struct delayed_call *);
 extern int vfs_readlink(struct dentry *, char __user *, int);
 
-extern int __generic_block_fiemap(struct inode *inode,
-				  struct fiemap_extent_info *fieinfo,
-				  loff_t start, loff_t len,
-				  get_block_t *get_block);
 extern int generic_block_fiemap(struct inode *inode,
 				struct fiemap_extent_info *fieinfo, u64 start,
 				u64 len, get_block_t *get_block);
-- 
2.26.2

