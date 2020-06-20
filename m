Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C02D20223A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jun 2020 09:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgFTHR1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Jun 2020 03:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbgFTHRM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Jun 2020 03:17:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2191FC06174E;
        Sat, 20 Jun 2020 00:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=zelkr+SM8XFpWH/uxQ7pO/ZVcwZFMxEHAVg6KgUuZNw=; b=r9OPc4mVqFx6CMkHuQU2rk0CNs
        aphyOheC3GNpDpzI352XMI/xrGUzNL3EgXHHrCowKKJjgASAD5ysQPs9NnsXchvkTatOkuW+UeSGV
        /FG34j6ovPyQUerIQxm8dALSfd4evm3rRYfZByEi0kH7ZnIz3Vi06cdCqrAiAqWe0LhvWSjiNAwDG
        xCyke98Sl0/qEXd4D7gyKzggxc/JEfPHlnE2CRQXEd24z+TpdOm3+iBdzMxuLwrnNVb+o6j1qq/Rc
        unc7fpS5sgScoSEt1aDht54L+0LXu9CTsTJLw9NYVkATh/U2YNzHvYE8kHvL757Crt5r5FOxFDitu
        /IE40kXA==;
Received: from 195-192-102-148.dyn.cablelink.at ([195.192.102.148] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jmXkT-0003tj-Uw; Sat, 20 Jun 2020 07:17:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/10] fs: move the buffer_heads_over_limit stub to buffer_head.h
Date:   Sat, 20 Jun 2020 09:16:42 +0200
Message-Id: <20200620071644.463185-9-hch@lst.de>
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

Move the !CONFIG_BLOCK stub to the same place as the non-stub
declaration.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blkdev.h      | 1 -
 include/linux/buffer_head.h | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 50fccb121b876e..973253ce202d87 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1840,7 +1840,6 @@ struct block_device;
 /*
  * stubs for when the block layer is configured out
  */
-#define buffer_heads_over_limit 0
 
 static inline long nr_blockdev_pages(void)
 {
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 22fb11e2d2e04d..6b47f94378c5ad 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -406,6 +406,7 @@ static inline int inode_has_buffers(struct inode *inode) { return 0; }
 static inline void invalidate_inode_buffers(struct inode *inode) {}
 static inline int remove_inode_buffers(struct inode *inode) { return 1; }
 static inline int sync_mapping_buffers(struct address_space *mapping) { return 0; }
+#define buffer_heads_over_limit 0
 
 #endif /* CONFIG_BLOCK */
 #endif /* _LINUX_BUFFER_HEAD_H */
-- 
2.26.2

