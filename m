Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9478F2C2756
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 14:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388133AbgKXN2j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 08:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388122AbgKXN2i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 08:28:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2142C061A4E;
        Tue, 24 Nov 2020 05:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=qbQZqUyuqbWI0k7YOCxXBM7JuauYhSOH9/mPud+JBEQ=; b=JPuFDbn3CeG05+vmoNAk65fF+e
        E+AWjN7EiPbhuy8d43uHrVAUMryHcbvWp/sIQsb2keLu3WxSA8fNQgXpu6WDI/oPIzGdu1t9jnCoh
        ALo16cLEzPbEOBDyyUQhXe2zb4Wg1WnXZR7b7Of0uxXZvBhKgYdSIm1GQtyXmTB80hVs2aO5jg3Wd
        JxN4GkeL/03jRIvwuCVHER5Yi938IlSwfy+kOfinhXXDGRCH8xrqmYFJRsvf9MdJi8dfiZSzBVDNv
        9Y5vxWaV8co6fpHvChVu6aEJa1JKBk5/o4XXJCwXXE79GGFIwkJ9LI5tm5QxCZm0GqpKScG6vBm6n
        A4zKiNLQ==;
Received: from [2001:4bb8:180:5443:c70:4a89:bc61:3] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khYMN-0006U7-DO; Tue, 24 Nov 2020 13:27:55 +0000
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
Subject: [PATCH 01/45] blk-cgroup: fix a hd_struct leak in blkcg_fill_root_iostats
Date:   Tue, 24 Nov 2020 14:27:07 +0100
Message-Id: <20201124132751.3747337-2-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201124132751.3747337-1-hch@lst.de>
References: <20201124132751.3747337-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

disk_get_part needs to be paired with a disk_put_part.

Fixes: ef45fe470e1 ("blk-cgroup: show global disk stats in root cgroup io.stat")
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 block/blk-cgroup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index c68bdf58c9a6e1..54fbe1e80cc41a 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -849,6 +849,7 @@ static void blkcg_fill_root_iostats(void)
 			blkg_iostat_set(&blkg->iostat.cur, &tmp);
 			u64_stats_update_end(&blkg->iostat.sync);
 		}
+		disk_put_part(part);
 	}
 }
 
-- 
2.29.2

