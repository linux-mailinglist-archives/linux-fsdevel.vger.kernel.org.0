Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2BF6FCDC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2019 11:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729424AbfGVJvB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jul 2019 05:51:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40642 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729418AbfGVJvA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jul 2019 05:51:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=cABJAC81WTfvAsX4yATKnx6SK90w2XcHzkRpr1xGDvc=; b=i2kr/bAJkKVbh2A8CybECWcPA3
        EmDsrp5UxkdNcrdWWAVnus10ZuPOcOtkDs/pqYJRXkHM9DnXbMe4PrdfTAZ48VilNv/kML4S01IRE
        l8OQ1SfB3snqRTqUcDhpLz8tVE/MBFZxxaqX59FDC1+4+GWpjQYi4RRdp2kD8qMFSJ/6TQtABtEg+
        7Omm7Ho5OySOtQwNRfeZN+EGIOerh+pWQ6UKcxUAbeCxGXBGy1qlCJlcSBTqqAtoNEOmXGPfTp5Ab
        9mhYFXHpCe9+uT3NP3J8tAzl7XH3ywPeS+kSmwpcC+vp2o0PcsvY4x2S7wgPdZfH1/JcUXNTQ6FED
        6xsPiVgw==;
Received: from 089144207240.atnat0016.highway.bob.at ([89.144.207.240] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hpUy9-0005ix-Hb; Mon, 22 Jul 2019 09:50:57 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/12] iomap: zero newly allocated mapped blocks
Date:   Mon, 22 Jul 2019 11:50:24 +0200
Message-Id: <20190722095024.19075-13-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722095024.19075-1-hch@lst.de>
References: <20190722095024.19075-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

File systems like gfs2 don't support delayed allocations or unwritten
extents and thus allocate normal mapped blocks to fill holes.  To
cover the case of such file systems allocating new blocks to fill holes
also zero out mapped blocks with the new flag.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 91a9796f8a7c..ba0511131868 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -226,6 +226,14 @@ iomap_read_inline_data(struct inode *inode, struct page *page,
 	SetPageUptodate(page);
 }
 
+static inline bool iomap_block_needs_zeroing(struct inode *inode,
+		struct iomap *iomap, loff_t pos)
+{
+	return iomap->type != IOMAP_MAPPED ||
+		(iomap->flags & IOMAP_F_NEW) ||
+		pos >= i_size_read(inode);
+}
+
 static loff_t
 iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 		struct iomap *iomap)
@@ -249,7 +257,7 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 	if (plen == 0)
 		goto done;
 
-	if (iomap->type != IOMAP_MAPPED || pos >= i_size_read(inode)) {
+	if (iomap_block_needs_zeroing(inode, iomap, pos)) {
 		zero_user(page, poff, plen);
 		iomap_set_range_uptodate(page, poff, plen);
 		goto done;
@@ -563,7 +571,7 @@ iomap_read_page_sync(struct inode *inode, loff_t block_start, struct page *page,
 	struct bio_vec bvec;
 	struct bio bio;
 
-	if (iomap->type != IOMAP_MAPPED || block_start >= i_size_read(inode)) {
+	if (iomap_block_needs_zeroing(inode, iomap, block_start)) {
 		zero_user_segments(page, poff, from, to, poff + plen);
 		iomap_set_range_uptodate(page, poff, plen);
 		return 0;
-- 
2.20.1

