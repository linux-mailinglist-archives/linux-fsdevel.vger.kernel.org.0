Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C93F32C753D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Nov 2020 23:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730502AbgK1VtZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Nov 2020 16:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731248AbgK1SsT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Nov 2020 13:48:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B49C0254C6;
        Sat, 28 Nov 2020 08:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=+N9nj4aeGcaY7E1cQ0C8G5//2Sxe7PPFKlTYCp379Nc=; b=Sh9Kvg4mkZ4XkPadEWLnVIdZ3T
        saZLEqTiDzaNBysUYvfcJruhwPbuksCUFc+ke5gwjhVFkndBZ57UQ7fn4y7YpckR8b4ZDwiQukngD
        3h/QoUNnAjcd3Kh+WVbHZCWu4czXKsHXG2oNQ/C57Y7zLCfqJvaPsuSEwog3vAo4qKbHYDBeHNS05
        j0CdaOXRTKvrHx3+Vjw2wphhy2k7x7Rqdy6fTts7RjMxuXtZEmSClWEQYqBDZpRO+fKBAa4QqDo4M
        WYpyRFXXAZlz172qFqypLsbK3XlhKzPxNn+C11J542iRyoxaNNArlsXG8/JrIEaIBLhF136iBBo3g
        l+1fCoyg==;
Received: from [2001:4bb8:18c:1dd6:48f3:741a:602e:7fdd] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kj2sr-0000G4-Tr; Sat, 28 Nov 2020 16:15:38 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        dm-devel@redhat.com, Jan Kara <jack@suse.com>,
        linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 16/45] block: switch bdgrab to use igrab
Date:   Sat, 28 Nov 2020 17:14:41 +0100
Message-Id: <20201128161510.347752-17-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201128161510.347752-1-hch@lst.de>
References: <20201128161510.347752-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All of the current callers already have a reference, but to prepare for
additional users ensure bdgrab returns NULL if the block device is beeing
freed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/block_dev.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index d707ab376da86e..962fabe8a67b83 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -894,10 +894,14 @@ static struct block_device *bdget(dev_t dev)
 /**
  * bdgrab -- Grab a reference to an already referenced block device
  * @bdev:	Block device to grab a reference to.
+ *
+ * Returns the block_device with an additional reference when successful,
+ * or NULL if the inode is already beeing freed.
  */
 struct block_device *bdgrab(struct block_device *bdev)
 {
-	ihold(bdev->bd_inode);
+	if (!igrab(bdev->bd_inode))
+		return NULL;
 	return bdev;
 }
 EXPORT_SYMBOL(bdgrab);
-- 
2.29.2

