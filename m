Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 407AE3B2F6E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jun 2021 14:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbhFXMzq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Jun 2021 08:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbhFXMzq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Jun 2021 08:55:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B5EC061574;
        Thu, 24 Jun 2021 05:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Zby1cv3k7TPvTR1dET271ZGDFyCAZ0wjGKz7eFC0/b8=; b=Cp/ty0N/4jxxqncvZuTU9CqzUz
        5sgoMSMvgede3l70qAJlh/7UsPt5OZ8/IxHorbo3zs0bRNmmyjMHNW1v5qIzByykMQofHHPCD7n4R
        K3SarkENsvUZ2aDYNeTcfp7JnfABRI57tyZ8BH835DJixtNpG7FNQEA9hzfb2yWA3HmezQFOMpL06
        vpzWbzok2nxlhSsDfRX7WGL3X4G1nhJ7kKl4WAITSCEOMDQjVZbdVUE7YnDCGqID5kuoul9wjJNhn
        V4GXqwKbT5VdRWyLbT89hlQHeHimopLBcOBeCcHO74r7IWO5GRLw9PqLUCMJaMHB1wRqMkqebjxE2
        2D90kLKQ==;
Received: from 213-225-9-92.nat.highway.a1.net ([213.225.9.92] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwOqj-00GaS7-2s; Thu, 24 Jun 2021 12:53:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     akpm@linux-foundation.org
Cc:     code@tyhicks.com, ecryptfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] ecryptfs: add a ->set_page_dirty cludge
Date:   Thu, 24 Jun 2021 14:52:50 +0200
Message-Id: <20210624125250.536369-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

"fix" ecryptfs to work the same as before the recent change to the
behavior without a ->set_page_dirty method.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/ecryptfs/mmap.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/ecryptfs/mmap.c b/fs/ecryptfs/mmap.c
index 392e721b50a3..7d85e64ea62f 100644
--- a/fs/ecryptfs/mmap.c
+++ b/fs/ecryptfs/mmap.c
@@ -533,7 +533,20 @@ static sector_t ecryptfs_bmap(struct address_space *mapping, sector_t block)
 	return block;
 }
 
+#include <linux/buffer_head.h>
+
 const struct address_space_operations ecryptfs_aops = {
+	/*
+	 * XXX: This is pretty broken for multiple reasons: ecryptfs does not
+	 * actually use buffer_heads, and ecryptfs will crash without
+	 * CONFIG_BLOCK.  But it matches the behavior before the default for
+	 * address_space_operations without the ->set_page_dirty method was
+	 * cleaned up, so this is the best we can do without maintainer
+	 * feedback.
+	 */
+#ifdef CONFIG_BLOCK
+	.set_page_dirty = __set_page_dirty_buffers,
+#endif
 	.writepage = ecryptfs_writepage,
 	.readpage = ecryptfs_readpage,
 	.write_begin = ecryptfs_write_begin,
-- 
2.30.2

