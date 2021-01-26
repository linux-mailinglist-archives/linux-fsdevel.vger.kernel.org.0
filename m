Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECE3304266
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 16:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392744AbhAZPYn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 10:24:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392797AbhAZPY0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 10:24:26 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3777C061A29;
        Tue, 26 Jan 2021 07:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=eRxdbvHrWwCg8ehIKzqaoZWUzsjM/Z9D1y3UwSDV4xY=; b=J6ds2suhWptTFI0URR1OjWJ7nG
        bFD9DPemPNjvWMkXWcox96rWMxKJ3XW6l1ppx21TRVcFUwpPlv6jvoA7XT9KXgcP6o2uX0j7RoRpv
        +z2mnPOBw/61en4ioO6qQ6wGDJueVg8AaKJWPDmdZAEUaq4i8ltdczsdeLE2HJcafnbJPknGxvdRx
        6NwXe9EcMss4nABThjLiNd3HAoJX9+5JELtc5RkBTpk8I4lDiozmMUqCwxXwNWPeY3eLQi68Xnwox
        gS5RyvHMHo1HvrS9S/ZtiOeZ/5pCLfhriYZcy0wlYNzlK/z57Bs0TCbgXcPCP6dq83/2TMqyhn6iV
        oe2pPxoQ==;
Received: from [2001:4bb8:191:e347:5918:ac86:61cb:8801] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l4Q7U-005oX0-8C; Tue, 26 Jan 2021 15:19:23 +0000
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
Subject: [PATCH 15/17] nfs/blocklayout: remove cruft in bl_alloc_init_bio
Date:   Tue, 26 Jan 2021 15:52:45 +0100
Message-Id: <20210126145247.1964410-16-hch@lst.de>
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
 fs/nfs/blocklayout/blocklayout.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/nfs/blocklayout/blocklayout.c b/fs/nfs/blocklayout/blocklayout.c
index 3be6836074ae92..1a96ce28efb026 100644
--- a/fs/nfs/blocklayout/blocklayout.c
+++ b/fs/nfs/blocklayout/blocklayout.c
@@ -123,11 +123,6 @@ bl_alloc_init_bio(int npg, struct block_device *bdev, sector_t disk_sector,
 
 	npg = min(npg, BIO_MAX_PAGES);
 	bio = bio_alloc(GFP_NOIO, npg);
-	if (!bio && (current->flags & PF_MEMALLOC)) {
-		while (!bio && (npg /= 2))
-			bio = bio_alloc(GFP_NOIO, npg);
-	}
-
 	if (bio) {
 		bio->bi_iter.bi_sector = disk_sector;
 		bio_set_dev(bio, bdev);
-- 
2.29.2

