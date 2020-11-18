Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00E462B793A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 09:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgKRIsY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 03:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbgKRIsY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 03:48:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067A2C061A4F;
        Wed, 18 Nov 2020 00:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=HlR8BHDvXv9Sgk92bGXzXu1h5fBqLDHnxGaHmTelGu0=; b=KdghkPK+bK39xYpfOITSgGrMVp
        BZli70ghNiYun7n+87JdzQVckkFmjA/iVEU1uoAHxbpWKwGwUBpwv8NlGzqCCuztL0lPtEylchCPx
        X77Zf9jDIFy/H0VRo0NOUt6YvmcSPgxMUC7DF5aAGAQes6WU3Pdt/eM+kILHXyjoQeMLFgGOGqGO2
        2wQ3zSfil9jGD9rGJGwOm7NLvJIwXJnBSIFtI1p+WPxnBXhtK4tCfAOpvizcMYINpM9jc8zU6z+H6
        QZvAKdshaOtNqnFRSbHHIEzczFZ/YzEf/GcUelmoGKLkJaXLcQNXVKFdaUzmSzDBrHLYmuWBgWQTb
        Qy4idlSQ==;
Received: from [2001:4bb8:18c:31ba:32b1:ec66:5459:36a] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kfJ8K-0007ko-U7; Wed, 18 Nov 2020 08:48:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com, Richard Weinberger <richard@nod.at>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 04/20] block: use disk_part_iter_exit in disk_part_iter_next
Date:   Wed, 18 Nov 2020 09:47:44 +0100
Message-Id: <20201118084800.2339180-5-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201118084800.2339180-1-hch@lst.de>
References: <20201118084800.2339180-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Call disk_part_iter_exit in disk_part_iter_next instead of duplicating
the functionality.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 4e039524f92b8f..0bd9c41dd4cb69 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -227,8 +227,7 @@ struct hd_struct *disk_part_iter_next(struct disk_part_iter *piter)
 	int inc, end;
 
 	/* put the last partition */
-	disk_put_part(piter->part);
-	piter->part = NULL;
+	disk_part_iter_exit(piter);
 
 	/* get part_tbl */
 	rcu_read_lock();
-- 
2.29.2

