Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5149435B9E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 09:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbhJUHZn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 03:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbhJUHZm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 03:25:42 -0400
Received: from out10.migadu.com (out10.migadu.com [IPv6:2001:41d0:2:e8e3::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E180C061749;
        Thu, 21 Oct 2021 00:23:26 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1634800445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=9KLEK9MFTq792PjvS76Q5yWvjTEoH/I/UieEFfVCP7c=;
        b=wr5UArmAtS2YpuTtcC97824VSUxr6/WFW0+hhqePf4qiZanUxKn4LTA7TFnTpUkZTHwncM
        38mqh9Nhx80Df0VChBYXPabseCPwIyGOFMR9gopWLJdT0xxZsoXlgHv3Az2M1RCNTqPhJS
        629Xy0oxCG0b3nEXeAdzRhpMLjSckTc=
From:   Jackie Liu <liu.yun@linux.dev>
To:     axboe@kernel.dk, hch@lst.de
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        liu.yun@linux.dev
Subject: [PATCH 1/2] fs: bdev: fix conflicting comment from lookup_bdev
Date:   Thu, 21 Oct 2021 15:13:43 +0800
Message-Id: <20211021071344.1600362-1-liu.yun@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: liu.yun@linux.dev
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Jackie Liu <liuyun01@kylinos.cn>

We switched to directly use dev_t to get block device, lookup changed the
meaning of use, now we fix this conflicting comment.

Fixes: 4e7b5671c6a8 ("block: remove i_bdev")
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 block/bdev.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 485a258b0ab3..51d69243d315 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -962,9 +962,11 @@ EXPORT_SYMBOL(blkdev_put);
  * @pathname:	special file representing the block device
  * @dev:	return value of the block device's dev_t
  *
- * Get a reference to the blockdevice at @pathname in the current
- * namespace if possible and return it.  Return ERR_PTR(error)
- * otherwise.
+ * Lookup the block device's dev_t at @pathname in the current
+ * namespace if possible and return it by @dev.
+ *
+ * RETURNS:
+ * 0 if succeeded, errno otherwise.
  */
 int lookup_bdev(const char *pathname, dev_t *dev)
 {
-- 
2.25.1

