Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EAC52C756D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Nov 2020 23:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731686AbgK1VtV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Nov 2020 16:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731169AbgK1Sry (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Nov 2020 13:47:54 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34F5C025597;
        Sat, 28 Nov 2020 08:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=6YDwceZWXpj1NQcHFGXJHKjMSWHoc1O1qwpXMktypjQ=; b=jdMRMFgyWv7mA57t3vj2lq5WPc
        LawQuf0tT/ceNr1l/EmSJzNWijN+Z4DImOblq/pvKOmEcs8Ud8nQf3OJndw1yVzcKD32F+/rCTE4n
        70bC16j+pvePlhvBTS7MYPzzX9HlTkrnwiVzXdh8mrVNang6zP7iyTq6Bh3xmfd8mCGJZLBrlb2Sx
        eA1tAJ1UPoQ4LpLtYfNUCIBIFypEMZbj50zQycyJ5AZMzPCuz/Cib8Uwrw5h9mUGxQgJNR8R0UCbA
        EdCU/7SLbDDycvc3HxnNiqbfMeFzMANYBBfaMFrCw19KU4L1oggxypy+WyZ/2z2I1/VjGl4lOUj7t
        O8gaW80Q==;
Received: from [2001:4bb8:18c:1dd6:48f3:741a:602e:7fdd] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kj2sj-0000EZ-PR; Sat, 28 Nov 2020 16:15:30 +0000
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
        linux-mm@kvack.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 11/45] block: remove a superflous check in blkpg_do_ioctl
Date:   Sat, 28 Nov 2020 17:14:36 +0100
Message-Id: <20201128161510.347752-12-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201128161510.347752-1-hch@lst.de>
References: <20201128161510.347752-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

sector_t is now always a u64, so this check is not needed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Acked-by: Tejun Heo <tj@kernel.org>
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

