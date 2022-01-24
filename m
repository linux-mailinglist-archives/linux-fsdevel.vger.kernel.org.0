Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01390497B51
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jan 2022 10:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242610AbiAXJLi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jan 2022 04:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242600AbiAXJLf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jan 2022 04:11:35 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59082C06173D;
        Mon, 24 Jan 2022 01:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=cyA51tgTzJ0oURPYTTRoUDyOePKkV9xxN4Hqcjy0whE=; b=24POPMuL96/As8aG9GXRe4flkw
        PU2voX+TtVVlvvdQoBbajVZWFUX5Dxw0G62WsA11q+Z8rRjH+LEx651hKp3XtfjI7gXtHN4ZzkX/+
        zbZ+tlG5Y0PtCwK4dK1YvN9MT7GYMmhUZbx6oA7tclLFQqB/Hk6HGXGms/H0HPQsHLOdwunOcJ2He
        Z/XTdU7e0f03aHpCO6hyntFD+lSqUwmcuScLWrUHjNVwxSomsOA9gkK7UTP2pkv+Rq271Q+ptnz5u
        RQQj2WoPvjf4xtnwoz0FDtxL394f4gkw9/czqcZnSk+qNyA0Xz4vOPLIi9B+cPZ8PvyvkOOGVnRjM
        +yBS+85g==;
Received: from [2001:4bb8:184:72a4:a337:a75f:a24e:7e39] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nBvNo-002k7w-Qx; Mon, 24 Jan 2022 09:11:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Md . Haris Iqbal " <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.co>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
        xen-devel@lists.xenproject.org, drbd-dev@lists.linbit.com
Subject: [PATCH 07/19] dm-snap: use blkdev_issue_flush instead of open coding it
Date:   Mon, 24 Jan 2022 10:10:55 +0100
Message-Id: <20220124091107.642561-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220124091107.642561-1-hch@lst.de>
References: <20220124091107.642561-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use blkdev_issue_flush, which uses an on-stack bio instead of an
opencoded version with a bio embedded into struct dm_snapshot.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/dm-snap.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/md/dm-snap.c b/drivers/md/dm-snap.c
index dcf34c6b05ad3..0d336b5ec5714 100644
--- a/drivers/md/dm-snap.c
+++ b/drivers/md/dm-snap.c
@@ -141,11 +141,6 @@ struct dm_snapshot {
 	 * for them to be committed.
 	 */
 	struct bio_list bios_queued_during_merge;
-
-	/*
-	 * Flush data after merge.
-	 */
-	struct bio flush_bio;
 };
 
 /*
@@ -1127,17 +1122,6 @@ static void snapshot_merge_next_chunks(struct dm_snapshot *s)
 
 static void error_bios(struct bio *bio);
 
-static int flush_data(struct dm_snapshot *s)
-{
-	struct bio *flush_bio = &s->flush_bio;
-
-	bio_reset(flush_bio);
-	bio_set_dev(flush_bio, s->origin->bdev);
-	flush_bio->bi_opf = REQ_OP_WRITE | REQ_PREFLUSH;
-
-	return submit_bio_wait(flush_bio);
-}
-
 static void merge_callback(int read_err, unsigned long write_err, void *context)
 {
 	struct dm_snapshot *s = context;
@@ -1151,7 +1135,7 @@ static void merge_callback(int read_err, unsigned long write_err, void *context)
 		goto shut;
 	}
 
-	if (flush_data(s) < 0) {
+	if (blkdev_issue_flush(s->origin->bdev) < 0) {
 		DMERR("Flush after merge failed: shutting down merge");
 		goto shut;
 	}
@@ -1340,7 +1324,6 @@ static int snapshot_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	s->first_merging_chunk = 0;
 	s->num_merging_chunks = 0;
 	bio_list_init(&s->bios_queued_during_merge);
-	bio_init(&s->flush_bio, NULL, 0);
 
 	/* Allocate hash table for COW data */
 	if (init_hash_tables(s)) {
@@ -1528,8 +1511,6 @@ static void snapshot_dtr(struct dm_target *ti)
 
 	dm_exception_store_destroy(s->store);
 
-	bio_uninit(&s->flush_bio);
-
 	dm_put_device(ti, s->cow);
 
 	dm_put_device(ti, s->origin);
-- 
2.30.2

