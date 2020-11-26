Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD712C5491
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Nov 2020 14:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389888AbgKZNG5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Nov 2020 08:06:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389873AbgKZNGz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:06:55 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C560BC0613D4;
        Thu, 26 Nov 2020 05:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=2uWDeQgsBeIc9r8ohTt9OrV40AdHP0SZhV+7+E52opA=; b=SSIkA7Jwmun7vSHnczcicqQ4lG
        UjMHkibDFctJGfKeI+vQ0holL/u1HaWSuDuUihk5P2PDzonczmJk9wc3uFgr08cwFB57TNrT5oSP2
        vcMucs3y60oVdjbj5A/QqIpqAFHb0lsbNyDfWwlEyWA0uxExQ5pG2BYzjikkA14ePil5HCAQBUngw
        PVVOxQoUwVmzWGWbLURnW2+g9R0Ih8SgiafAlJG5rFu9FGUQ35fmjsQD9qua5gsQHSc0/Gx1M5N24
        nVtvyEhO0E85s8yafzS/yk4a2pKqEf++6ErXd3aZ07xWvHw5cEy0shRdaxolyN7YW1u7oD5/9XBQI
        IU8K1rqw==;
Received: from [2001:4bb8:18c:1dd6:27b8:b8a1:c13e:ceb1] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kiGyx-0003xi-ML; Thu, 26 Nov 2020 13:06:44 +0000
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
Subject: [PATCH 07/44] loop: do not call set_blocksize
Date:   Thu, 26 Nov 2020 14:03:45 +0100
Message-Id: <20201126130422.92945-8-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201126130422.92945-1-hch@lst.de>
References: <20201126130422.92945-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

set_blocksize is used by file systems to use their preferred buffer cache
block size.  Block drivers should not set it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 drivers/block/loop.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 9a27d4f1c08aac..b42c728620c9e4 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1164,9 +1164,6 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	size = get_loop_size(lo, file);
 	loop_set_size(lo, size);
 
-	set_blocksize(bdev, S_ISBLK(inode->i_mode) ?
-		      block_size(inode->i_bdev) : PAGE_SIZE);
-
 	lo->lo_state = Lo_bound;
 	if (part_shift)
 		lo->lo_flags |= LO_FLAGS_PARTSCAN;
-- 
2.29.2

