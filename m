Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9EEF2C549B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Nov 2020 14:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389903AbgKZNHA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Nov 2020 08:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389898AbgKZNG7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:06:59 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AE0C0613D4;
        Thu, 26 Nov 2020 05:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=hkZ3kL3dtIfOBE0h3NJSBhFvBELjgr4IDAohskoKJQM=; b=fCfJvwHPUDDStYbe0VsGaec1in
        U0zKXdrWOqg/L2l/BL9qX6NQaal1L3Uusa/6q1hmk1oWjZ7IMFo7XofMZStGwr7WznBF9TBW+s0OS
        6CulGjI2XcLUdygOsMow8BLNKQCEqU6hm8dk4yrnVZAn4AAjTF/Snw6eK0jhrsfgXJecL9mltL6ki
        HdYSZLmZaP7ZQ/fA+wo0Uxx0lBvV4iB5Vh9MgcX5/zRausT/1kLE18oDuA4RAkqJRcT1bDJHXNCm5
        kY7YN0If2gfe4bIItZVrOhw7oqhpXep1bWKV6SsURJ6x4g+QA/OnAEiRvbBTj4jOWagKSP+h389TD
        DgmdR6Ag==;
Received: from [2001:4bb8:18c:1dd6:27b8:b8a1:c13e:ceb1] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kiGz2-0003z9-Fv; Thu, 26 Nov 2020 13:06:48 +0000
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
Subject: [PATCH 11/44] block: remove a superflous check in blkpg_do_ioctl
Date:   Thu, 26 Nov 2020 14:03:49 +0100
Message-Id: <20201126130422.92945-12-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201126130422.92945-1-hch@lst.de>
References: <20201126130422.92945-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

sector_t is now always a u64, so this check is not needed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 block/ioctl.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index 6b785181344fe1..0c09bb7a6ff35f 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -35,15 +35,6 @@ static int blkpg_do_ioctl(struct block_device *bdev,
 	start = p.start >> SECTOR_SHIFT;
 	length = p.length >> SECTOR_SHIFT;
 
-	/* check for fit in a hd_struct */
-	if (sizeof(sector_t) < sizeof(long long)) {
-		long pstart = start, plength = length;
-
-		if (pstart != start || plength != length || pstart < 0 ||
-		    plength < 0 || p.pno > 65535)
-			return -EINVAL;
-	}
-
 	switch (op) {
 	case BLKPG_ADD_PARTITION:
 		/* check if partition is aligned to blocksize */
-- 
2.29.2

