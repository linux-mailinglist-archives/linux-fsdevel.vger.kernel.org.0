Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B403CD32D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2019 17:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfJFPtS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Oct 2019 11:49:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53522 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbfJFPsh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Oct 2019 11:48:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kskppOSJpC2+f0PmdqX+/uMUoW32qU3S5s1t8sYooIg=; b=sh0xOcNalQDTSNtUETgvlgbZDw
        C3SlA4ApX7FUjGPPqX5AHNLuuxcCLQwWbCl5RJi0VwpKeyqdXTatRtAfnVKNF2XMwKg3q3cJzE1/D
        Gwl63mIoQcbLzze9FxPDio0Y+jZ2VM76zadCCNdQsQtbVvMORQZmff+4cDDnbHW2hmECgI9G1BnXY
        NDKz7iizDUZeqXrBHwcynlm9udXvrBA3hJSG8R0rXyXMfr6sSxs48TRpjdY6F0UD/fTOVN1Fd/ovV
        wmAG7+gd8XGcqcu5Ek39umaOpK2VfOJJwhNAhkPNC1oZVdCY6jQ2bYRJa7xaYcnRIfzpZirl6nzCk
        7/RVeYMQ==;
Received: from [2001:4bb8:18c:4d4a:c70:4a89:bc61:3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iH8lv-0008Sy-8y; Sun, 06 Oct 2019 15:48:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/11] iomap: zero newly allocated mapped blocks
Date:   Sun,  6 Oct 2019 17:46:02 +0200
Message-Id: <20191006154608.24738-6-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191006154608.24738-1-hch@lst.de>
References: <20191006154608.24738-1-hch@lst.de>
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
index 23cc308f971d..4132c0cccb0a 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -207,6 +207,14 @@ iomap_read_inline_data(struct inode *inode, struct page *page,
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
@@ -230,7 +238,7 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 	if (plen == 0)
 		goto done;
 
-	if (iomap->type != IOMAP_MAPPED || pos >= i_size_read(inode)) {
+	if (iomap_block_needs_zeroing(inode, iomap, pos)) {
 		zero_user(page, poff, plen);
 		iomap_set_range_uptodate(page, poff, plen);
 		goto done;
@@ -544,7 +552,7 @@ iomap_read_page_sync(struct inode *inode, loff_t block_start, struct page *page,
 	struct bio_vec bvec;
 	struct bio bio;
 
-	if (iomap->type != IOMAP_MAPPED || block_start >= i_size_read(inode)) {
+	if (iomap_block_needs_zeroing(inode, iomap, block_start)) {
 		zero_user_segments(page, poff, from, to, poff + plen);
 		iomap_set_range_uptodate(page, poff, plen);
 		return 0;
-- 
2.20.1

