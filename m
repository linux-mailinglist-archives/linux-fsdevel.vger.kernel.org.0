Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 455EAC2E14
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2019 09:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732958AbfJAHQ3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Oct 2019 03:16:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45522 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732829AbfJAHQ3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Oct 2019 03:16:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qHxMYKAGFAW7BBIc3Hk1n+qh2T7tSZmjeIMqsQWu/wU=; b=g5amSLSXuxqQFFzwhMfkX2gU4M
        dDlbRxZKJkuGe19uIuP6Gh2jZI3vUdf/hdFE1U+WPSl6fprTrSEwTT80mEJV5zGD0sM3hG0zoYLhH
        AH+Voxi0aLwQKcgPKU3lR9ia84e+Oq/FIJ6JSQn9E9unkTXNw6PJP8EKUfEya2h7D1VubPLBy1/Xu
        jL9+FK/S93OVZJmukhJOV5SAvEh7wyRZ/UTEY6dLiA/3qZi0iQeyIZjkrtNuMmNwl0rleoCJuzFYo
        enSIN3fWEd3z1CaJkrFdzS0lYkcazkl+PsS3Z9yZtzf6srRoNKPYk/nijIP2LHJOTR+nkIkBbH7lH
        LSMM90Tg==;
Received: from [2001:4bb8:18c:4d4a:b9e5:f9f0:a515:3f0a] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iFCOZ-0001Qz-5T; Tue, 01 Oct 2019 07:16:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/11] iomap: zero newly allocated mapped blocks
Date:   Tue,  1 Oct 2019 09:11:46 +0200
Message-Id: <20191001071152.24403-6-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191001071152.24403-1-hch@lst.de>
References: <20191001071152.24403-1-hch@lst.de>
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
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/iomap/buffered-io.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 61f067b3261b..dcf95e8b31fe 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -209,6 +209,14 @@ iomap_read_inline_data(struct inode *inode, struct page *page,
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
@@ -232,7 +240,7 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 	if (plen == 0)
 		goto done;
 
-	if (iomap->type != IOMAP_MAPPED || pos >= i_size_read(inode)) {
+	if (iomap_block_needs_zeroing(inode, iomap, pos)) {
 		zero_user(page, poff, plen);
 		iomap_set_range_uptodate(page, poff, plen);
 		goto done;
@@ -546,7 +554,7 @@ iomap_read_page_sync(struct inode *inode, loff_t block_start, struct page *page,
 	struct bio_vec bvec;
 	struct bio bio;
 
-	if (iomap->type != IOMAP_MAPPED || block_start >= i_size_read(inode)) {
+	if (iomap_block_needs_zeroing(inode, iomap, block_start)) {
 		zero_user_segments(page, poff, from, to, poff + plen);
 		iomap_set_range_uptodate(page, poff, plen);
 		return 0;
-- 
2.20.1

