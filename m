Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE17D2C275D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 14:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388137AbgKXN2l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 08:28:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388134AbgKXN2k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 08:28:40 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C03C0617A6;
        Tue, 24 Nov 2020 05:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=/O13+dcLk1L7JyoO+1N94KNWJ8AA8wxdNDwugfkz49U=; b=T0mbtousMy3gTU4W+Hav1SXmPG
        ntoJpVsr1rVrypAPqknRPUnpesJSMBrUc00lVI6rw9tW7L0UTd5qDYChjsDIp5I+2p9rgRfczorvW
        myNaorvAqWHtFI8YzROhDDUSGaAL1oE03jbsWr7RUeag8w/Fra4vYKypkXrsbnoMydets0qq/jCNw
        kAWVxaa3y0zHwqhTRdVwYBa7yrqO3jWUl7tXKnrMDreCJh9HnCSyQhcMGVcHEbB5RfozmnnymLj8T
        T8hSeMtKcFNU6MG3WPtXCg75QSQ31Et+ZdTKD3UyLrPnveQ8KHIGAcZK2WiJCk91FG4lz+px4829j
        pUPMLhxA==;
Received: from [2001:4bb8:180:5443:c70:4a89:bc61:3] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khYMe-0006WC-FD; Tue, 24 Nov 2020 13:28:12 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        dm-devel@redhat.com, Richard Weinberger <richard@nod.at>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 12/45] block: remove a superflous check in blkpg_do_ioctl
Date:   Tue, 24 Nov 2020 14:27:18 +0100
Message-Id: <20201124132751.3747337-13-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201124132751.3747337-1-hch@lst.de>
References: <20201124132751.3747337-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

sector_t is now always a u64, so this check is not needed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
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

