Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90BE5491FC4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jan 2022 08:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244677AbiARHUK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jan 2022 02:20:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiARHUH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jan 2022 02:20:07 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D882C061574;
        Mon, 17 Jan 2022 23:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=7QPyuzOR2N2LqXuXA08GkKhJ7fsHc2fxZXqTeovi8aQ=; b=mwLo7/0/BOPnfEnPa3xkh1wtp3
        15wY0VF1l5wgNEmlmFx9qahgWnFhyJl6myyHdYnnzRUVdOqVBkw7UQ2s8GiXprR+T/gsvB/2g/F5v
        UCaXHspI+nVqVsB58mvQw0HRJkvSn89DW90IDAfE05lkscu3Lf/H7fIN1bqOWBihdD4Tp5Ut6juFU
        WNJ1skjZ7Xkx6wUi1wozYtRk77Q0Gy2FFrBE57k2vN/cSiZKuWEEa/FwDkaLAeAptVbMHq6BGRtqX
        s60rfzBqA3qtv2QplYalZU7PGOtQaONd/6YhcyxH1JxZ9Vqhkoc/TOJtrX45PcQTGjUSplXja4jev
        6N8KX46Q==;
Received: from [2001:4bb8:184:72a4:a4a9:19c0:5242:7768] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n9ime-000ZNW-EE; Tue, 18 Jan 2022 07:20:01 +0000
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
Subject: [PATCH 02/19] nilfs2: remove nilfs_alloc_seg_bio
Date:   Tue, 18 Jan 2022 08:19:35 +0100
Message-Id: <20220118071952.1243143-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220118071952.1243143-1-hch@lst.de>
References: <20220118071952.1243143-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

bio_alloc will never fail when it can sleep.  Remove the now simple
nilfs_alloc_seg_bio helper and open code it in the only caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nilfs2/segbuf.c | 31 ++++---------------------------
 1 file changed, 4 insertions(+), 27 deletions(-)

diff --git a/fs/nilfs2/segbuf.c b/fs/nilfs2/segbuf.c
index 43287b0d3e9b6..53b7c6d21cdd8 100644
--- a/fs/nilfs2/segbuf.c
+++ b/fs/nilfs2/segbuf.c
@@ -371,29 +371,6 @@ static int nilfs_segbuf_submit_bio(struct nilfs_segment_buffer *segbuf,
 	return err;
 }
 
-/**
- * nilfs_alloc_seg_bio - allocate a new bio for writing log
- * @nilfs: nilfs object
- * @start: start block number of the bio
- * @nr_vecs: request size of page vector.
- *
- * Return Value: On success, pointer to the struct bio is returned.
- * On error, NULL is returned.
- */
-static struct bio *nilfs_alloc_seg_bio(struct the_nilfs *nilfs, sector_t start,
-				       int nr_vecs)
-{
-	struct bio *bio;
-
-	bio = bio_alloc(GFP_NOIO, nr_vecs);
-	if (likely(bio)) {
-		bio_set_dev(bio, nilfs->ns_bdev);
-		bio->bi_iter.bi_sector =
-			start << (nilfs->ns_blocksize_bits - 9);
-	}
-	return bio;
-}
-
 static void nilfs_segbuf_prepare_write(struct nilfs_segment_buffer *segbuf,
 				       struct nilfs_write_info *wi)
 {
@@ -414,10 +391,10 @@ static int nilfs_segbuf_submit_bh(struct nilfs_segment_buffer *segbuf,
 	BUG_ON(wi->nr_vecs <= 0);
  repeat:
 	if (!wi->bio) {
-		wi->bio = nilfs_alloc_seg_bio(wi->nilfs, wi->blocknr + wi->end,
-					      wi->nr_vecs);
-		if (unlikely(!wi->bio))
-			return -ENOMEM;
+		wi->bio = bio_alloc(GFP_NOIO, wi->nr_vecs);
+		bio_set_dev(wi->bio, wi->nilfs->ns_bdev);
+		wi->bio->bi_iter.bi_sector = (wi->blocknr + wi->end) <<
+			(wi->nilfs->ns_blocksize_bits - 9);
 	}
 
 	len = bio_add_page(wi->bio, bh->b_page, bh->b_size, bh_offset(bh));
-- 
2.30.2

