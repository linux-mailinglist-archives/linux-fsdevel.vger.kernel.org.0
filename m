Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1DD61BAC3E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 20:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgD0SUM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 14:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726213AbgD0SUL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 14:20:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF98FC0610D5;
        Mon, 27 Apr 2020 11:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=fiuWFSiyWrxr5pZxiwa99BOM3ARppZRkANpBIsZuVbs=; b=MQDdxaEOPo3jyEb2jTCN+6gQ7D
        dtKY4UfqsrGwySU7WkTNhFRP2nDeha90iIjHzlmTH1+Ojpy86uJqx+JLDq8ilnhMnvoYcEOQAh3DZ
        OA3B1kDuVndepPd1RjN9NKxNoSfvIXqlmYACmFQ7F7CNRbDJyxF9iImUNYkHyh/y158P+g0VIPGze
        6StZk/GqD+rGUAWlvOs4waHNxwysYN3rBF3xdOhX+Y3L2ske2PEb3BoXmJ2ugXJbpw8FqNIf0xOgR
        vs9XxolzbfAJPvD1fsHJ+Ug8I+hwhNkFwcPnCjvxWAih7MIAyJKljj2JqhJu+vu00bIqMc1gxy97o
        i5ks6MlQ==;
Received: from [2001:4bb8:193:f203:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jT8MV-0003ry-8S; Mon, 27 Apr 2020 18:20:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-ext4@vger.kernel.org, viro@zeniv.linux.org.uk
Cc:     jack@suse.cz, tytso@mit.edu, adilger@dilger.ca,
        riteshh@linux.ibm.com, amir73il@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: [PATCH 05/11] fs: mark __generic_block_fiemap static
Date:   Mon, 27 Apr 2020 20:19:51 +0200
Message-Id: <20200427181957.1606257-6-hch@lst.de>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200427181957.1606257-1-hch@lst.de>
References: <20200427181957.1606257-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is no caller left outside of ioctl.c.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/ioctl.c         | 4 +---
 include/linux/fs.h | 4 ----
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index 282d45be6f453..f55f53c7824bb 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -299,8 +299,7 @@ static inline loff_t blk_to_logical(struct inode *inode, sector_t blk)
  * If you use this function directly, you need to do your own locking. Use
  * generic_block_fiemap if you want the locking done for you.
  */
-
-int __generic_block_fiemap(struct inode *inode,
+static int __generic_block_fiemap(struct inode *inode,
 			   struct fiemap_extent_info *fieinfo, loff_t start,
 			   loff_t len, get_block_t *get_block)
 {
@@ -445,7 +444,6 @@ int __generic_block_fiemap(struct inode *inode,
 
 	return ret;
 }
-EXPORT_SYMBOL(__generic_block_fiemap);
 
 /**
  * generic_block_fiemap - FIEMAP for block based inodes
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 4f6f59b4f22a8..3104c6f7527b5 100644
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
2.26.1

