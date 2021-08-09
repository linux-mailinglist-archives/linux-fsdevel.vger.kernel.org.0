Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F23963E4769
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Aug 2021 16:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbhHIOV1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Aug 2021 10:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234986AbhHIOVZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Aug 2021 10:21:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D82C061796;
        Mon,  9 Aug 2021 07:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=XU6ud6GFQfd/gs3ssOGWEAi2zJPaSrUQBYHYU+p+0Vs=; b=gY8TLua/+YBr0U0KXj8dTN2emm
        Vw9fqV/WUIYfS0rIBwQ26vKkcEXtAV8qJ5pmxrfp5OIhVw9lMuk2w1G01J4F3H27FusOakvMWFa4F
        O2Lrg//IqS/IbdJdY2vFHeCsPOTukFvSgB/SpztcvKDHTed8ZAJkZ8mMVikeQ1zW0yd5fYx7qx9N3
        Nb4EviWcZ4K4Mr7/s5cSlxXC91CYuscyXCb++mzWzXUPReRDHIHtvWihYw0icKUTxiBjepHalsP95
        iB7sF5CexQRBeECPSWLeBnINpRtXyX5/tuEsod50hTKPjsl/Tar7ef2ujYyxA7efcTK8v3L1QcKqc
        X3apWGFA==;
Received: from [2001:4bb8:184:6215:d19a:ace4:57f0:d5ad] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mD685-00B4AA-Ao; Mon, 09 Aug 2021 14:20:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 3/5] block: add a queue_has_disk helper
Date:   Mon,  9 Aug 2021 16:17:42 +0200
Message-Id: <20210809141744.1203023-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210809141744.1203023-1-hch@lst.de>
References: <20210809141744.1203023-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a helper to check if a gendisk is associated with a request_queue.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blkdev.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index ac3642c88a4d..96f3d9617cd8 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -664,6 +664,7 @@ extern void blk_clear_pm_only(struct request_queue *q);
 	dma_map_page_attrs(dev, (bv)->bv_page, (bv)->bv_offset, (bv)->bv_len, \
 	(dir), (attrs))
 
+#define queue_has_disk(q)	((q)->kobj.parent != NULL)
 #define queue_to_disk(q)	(dev_to_disk(kobj_to_dev((q)->kobj.parent)))
 
 static inline bool queue_is_mq(struct request_queue *q)
-- 
2.30.2

