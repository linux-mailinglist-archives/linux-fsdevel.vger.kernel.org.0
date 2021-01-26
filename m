Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC7B30423E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 16:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406198AbhAZPVb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 10:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406317AbhAZPVP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 10:21:15 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7210FC0698C2;
        Tue, 26 Jan 2021 07:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=hT6VVHBE+h6JAvE1DToGRa2iclpKhRp2E4jpRU5fhfg=; b=a5C/DS8xF1Qgcw0TbOpCyVosGS
        Zrj/lJFI88P49DOf+/Bv7oVHux9xqSc90dqCb+MgQFhiF1iNvcTKtNotsaqaT9GZ5O2lfHYWPU8f9
        MWSyAVCn+XzTVBXvoQFlhs6Nk75UUNAvCFZY8DGZ+OF3VElW6b7AOCAZODHM1g0BPGh6KHJ7SLPKZ
        ldxaH+8wFBz/F2aTXvOIhpfh3/7iT/Vec2zTOjOdaNV8EKhaGb4msUb18JCH4H9nVObBYh45mZ/t7
        Mt7fD5vi0lda03mpky5eT1QtbuYJV5pgTQU/Q9GheLbpEAbrqXTRFm9yHPYEgOqLWBKQ/o7X2nMXc
        I/Ys90sw==;
Received: from [2001:4bb8:191:e347:5918:ac86:61cb:8801] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l4Q39-005o7b-JG; Tue, 26 Jan 2021 15:15:32 +0000
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
Subject: [PATCH 13/17] md: remove md_bio_alloc_sync
Date:   Tue, 26 Jan 2021 15:52:43 +0100
Message-Id: <20210126145247.1964410-14-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210126145247.1964410-1-hch@lst.de>
References: <20210126145247.1964410-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

md_bio_alloc_sync is never called with a NULL mddev, and ->sync_set is
initialized in md_run, so it always must be initialized as well.  Just
open code the remaining call to bio_alloc_bioset.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/md.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 6a27f52007c871..399c81bddc1ae1 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -340,14 +340,6 @@ static int start_readonly;
  */
 static bool create_on_open = true;
 
-static struct bio *md_bio_alloc_sync(struct mddev *mddev)
-{
-	if (!mddev || !bioset_initialized(&mddev->sync_set))
-		return bio_alloc(GFP_NOIO, 1);
-
-	return bio_alloc_bioset(GFP_NOIO, 1, &mddev->sync_set);
-}
-
 /*
  * We have a system wide 'event count' that is incremented
  * on any 'interesting' event, and readers of /proc/mdstat
@@ -989,7 +981,7 @@ void md_super_write(struct mddev *mddev, struct md_rdev *rdev,
 	if (test_bit(Faulty, &rdev->flags))
 		return;
 
-	bio = md_bio_alloc_sync(mddev);
+	bio = bio_alloc_bioset(GFP_NOIO, 1, &mddev->sync_set);
 
 	atomic_inc(&rdev->nr_pending);
 
-- 
2.29.2

