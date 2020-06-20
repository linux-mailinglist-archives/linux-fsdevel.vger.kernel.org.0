Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFCC202240
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jun 2020 09:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbgFTHRF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Jun 2020 03:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbgFTHRD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Jun 2020 03:17:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46549C06174E;
        Sat, 20 Jun 2020 00:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=3sYWqj8JjLR1Bdg3r/XBhCA3mEw2Ww30VmPxbStNzPs=; b=Lea++MvGmvo2vTLnbq9YHSLUkK
        STTWLb3tkkBifi11ZhIz21buWqXPhjcMfEtn3Bapr6a6QS9hzwNFRqZnHJQId3kHKRNsVMvKzgPIP
        0yxrltdk1WqCDLTgfrEA1eKAorgJ90jVkMe6+X3hLU8OKqyjrJp4AXKmu0eeYoLEmtXZYSL43q1DP
        CLTOJ1KBXEaFPOXicd2jsB/ioEYEh1WUu08n3WISFuEYyA0tOSQ3pE1R2Kjz6JvkPzLpCiA8Fpo6D
        cLWvAV89YwrBhSIoEZyu2nN23s86CqAuE04jVcbSjekpisopH0BcXtNmvneJsduhLBGPqqxUHMpIi
        VZzf3nEg==;
Received: from 195-192-102-148.dyn.cablelink.at ([195.192.102.148] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jmXkL-0003rw-BV; Sat, 20 Jun 2020 07:17:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/10] fs: remove the mount_bdev and kill_block_super stubs
Date:   Sat, 20 Jun 2020 09:16:39 +0200
Message-Id: <20200620071644.463185-6-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200620071644.463185-1-hch@lst.de>
References: <20200620071644.463185-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

No one calls these functions without CONFIG_BLOCK, so don't bother
stubbing them out.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/fs.h | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 224edcc5b56e62..9ee09e2b5a9716 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2256,18 +2256,9 @@ struct file_system_type {
 
 #define MODULE_ALIAS_FS(NAME) MODULE_ALIAS("fs-" NAME)
 
-#ifdef CONFIG_BLOCK
 extern struct dentry *mount_bdev(struct file_system_type *fs_type,
 	int flags, const char *dev_name, void *data,
 	int (*fill_super)(struct super_block *, void *, int));
-#else
-static inline struct dentry *mount_bdev(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data,
-	int (*fill_super)(struct super_block *, void *, int))
-{
-	return ERR_PTR(-ENODEV);
-}
-#endif
 extern struct dentry *mount_single(struct file_system_type *fs_type,
 	int flags, void *data,
 	int (*fill_super)(struct super_block *, void *, int));
@@ -2276,14 +2267,7 @@ extern struct dentry *mount_nodev(struct file_system_type *fs_type,
 	int (*fill_super)(struct super_block *, void *, int));
 extern struct dentry *mount_subtree(struct vfsmount *mnt, const char *path);
 void generic_shutdown_super(struct super_block *sb);
-#ifdef CONFIG_BLOCK
 void kill_block_super(struct super_block *sb);
-#else
-static inline void kill_block_super(struct super_block *sb)
-{
-	BUG();
-}
-#endif
 void kill_anon_super(struct super_block *sb);
 void kill_litter_super(struct super_block *sb);
 void deactivate_super(struct super_block *sb);
-- 
2.26.2

