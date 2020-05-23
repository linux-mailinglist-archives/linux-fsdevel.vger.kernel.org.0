Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 674221DF59D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 May 2020 09:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387725AbgEWHaa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 May 2020 03:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387713AbgEWHa2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 May 2020 03:30:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9CAC05BD43;
        Sat, 23 May 2020 00:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=K+6DnygQna6F4X0yLRFvx3ynmJY+i5QVJvf2vVw60Ts=; b=sH2vg1R2keTXQ5znmXOwpIRwKS
        MYD5JRwEkAjEQu7Sz3n1ozdv2ega1q9w14PFvqNSOGkZHsYt648UXXLgnol2/k3L57ixj8No78o7E
        smjFJNXXwvPG4HZUTXe5QX2IqT3SHzlOe804LO7rqgIjl6G1AJ8X5VJkpYWnOcjSBPCWqHGqPka9q
        oGXVHhPCs7xV1WNyoFm9POn5Rf6Xyj3nEiPZ1mALUl232BuH0ydaE5vLk+mShW98jDBaOEK86UXzH
        0dbdrkYPAH2zepdvYBh1Y+9CflfYZbGAOxMhIRE8nri3f6ZiB5Gqc/Rdawlxu0X1eKsNyzJsa+MgY
        QeEf7VhA==;
Received: from [2001:4bb8:18c:5da7:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jcObz-0007rp-Qh; Sat, 23 May 2020 07:30:28 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-ext4@vger.kernel.org, viro@zeniv.linux.org.uk
Cc:     jack@suse.cz, tytso@mit.edu, adilger@dilger.ca,
        riteshh@linux.ibm.com, amir73il@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Subject: [PATCH 3/9] fs: mark __generic_block_fiemap static
Date:   Sat, 23 May 2020 09:30:10 +0200
Message-Id: <20200523073016.2944131-4-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200523073016.2944131-1-hch@lst.de>
References: <20200523073016.2944131-1-hch@lst.de>
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
Reviewed-by: Jan Kara <jack@suse.cz>
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

