Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711A330426C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 16:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391502AbhAZPZy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 10:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389908AbhAZPZc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 10:25:32 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D26C061D73;
        Tue, 26 Jan 2021 07:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=D/eDIBgr0QhzI/ySPX/2hbyfNquR7e3bfpvNVnt2JfU=; b=D0vECFFPgjNDQdJXrlwGlO9SXK
        bqCpsr0IXEJRRcGpwx6o5eclpUuMr9hHDwI1bvP9dHmDZCFUvdFXs74twhireq6A3R0hjw3E27Nhq
        gND3stVtzuc7AUN5QzdwSwuYTW+D6ywHC6ueGNxmoNigkTBe53X3elgpHHvEzb3YXnLWpSzS6cRY3
        b+0bPbazRaqeOhh/6Ib7cYH6Q/rvQJcP32gM5YG6ZgJ9hUwYhUtMGEdDPzgQv3QJ5k9q3J/5gW/oc
        SobtocU4AJ+ibrvafFyuDHBvtV8jwxST24FpYyK6VNjS7eabZ5oOXO7IlLknAN9gmIoy8gv7yJ8WG
        rrOnQYxQ==;
Received: from [2001:4bb8:191:e347:5918:ac86:61cb:8801] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l4Q8n-005ohh-NM; Tue, 26 Jan 2021 15:21:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        linux-nilfs@vger.kernel.org, dm-devel@redhat.com,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-block@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 16/17] nilfs2: remove cruft in nilfs_alloc_seg_bio
Date:   Tue, 26 Jan 2021 15:52:46 +0100
Message-Id: <20210126145247.1964410-17-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210126145247.1964410-1-hch@lst.de>
References: <20210126145247.1964410-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

bio_alloc never returns NULL when it can sleep.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nilfs2/segbuf.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/nilfs2/segbuf.c b/fs/nilfs2/segbuf.c
index 1a8729eded8b14..1e75417bfe6e52 100644
--- a/fs/nilfs2/segbuf.c
+++ b/fs/nilfs2/segbuf.c
@@ -386,10 +386,6 @@ static struct bio *nilfs_alloc_seg_bio(struct the_nilfs *nilfs, sector_t start,
 	struct bio *bio;
 
 	bio = bio_alloc(GFP_NOIO, nr_vecs);
-	if (bio == NULL) {
-		while (!bio && (nr_vecs >>= 1))
-			bio = bio_alloc(GFP_NOIO, nr_vecs);
-	}
 	if (likely(bio)) {
 		bio_set_dev(bio, nilfs->ns_bdev);
 		bio->bi_iter.bi_sector =
-- 
2.29.2

