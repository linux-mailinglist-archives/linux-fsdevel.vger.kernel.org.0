Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12571DB537
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2019 19:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394941AbfJQR4y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Oct 2019 13:56:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48428 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440825AbfJQR4x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Oct 2019 13:56:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xa2gfAqianHfXMXDC3EAxZSCqzWwbZtbxVA7gYTExh4=; b=BWVQUr6+bJxXtJKuyiy1lkWTPQ
        HObnCKuf3QevYGMJiRYezmwsHFzKK5ZqJKW1l9CYiACFl9GaUZti0rzAfxCpS/j9DDa8QgUl8LxRy
        v9j1E39jlj14SCV3CdbxTn+f+vB9PPv8MLtD6P+QfT9XEhYqe3RB47PbFemWr2fFd7sawhoPc03wa
        zn2SiNTICWthrR8qAMxgFv7ewjJVkdOGNcJJxsjfULqSwzT3ci2rKTkFagoGBpy6gt0rUO6PiY7w8
        GYMtcIo5Gd0G5lTf/swekAejuCmQNiMETTUB8W7IMIdbNXmgSP86fYF0vbv0IaidV8LcX98U5XFgE
        zWGt0bUA==;
Received: from [2001:4bb8:18c:d7b:c70:4a89:bc61:3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iLA13-000128-BX; Thu, 17 Oct 2019 17:56:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
Subject: [PATCH 08/14] iomap: zero newly allocated mapped blocks
Date:   Thu, 17 Oct 2019 19:56:18 +0200
Message-Id: <20191017175624.30305-9-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017175624.30305-1-hch@lst.de>
References: <20191017175624.30305-1-hch@lst.de>
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
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/iomap/buffered-io.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index e25901ae3ff4..181ee8477aad 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -203,6 +203,14 @@ iomap_read_inline_data(struct inode *inode, struct page *page,
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
@@ -226,7 +234,7 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 	if (plen == 0)
 		goto done;
 
-	if (iomap->type != IOMAP_MAPPED || pos >= i_size_read(inode)) {
+	if (iomap_block_needs_zeroing(inode, iomap, pos)) {
 		zero_user(page, poff, plen);
 		iomap_set_range_uptodate(page, poff, plen);
 		goto done;
@@ -532,7 +540,7 @@ iomap_read_page_sync(struct inode *inode, loff_t block_start, struct page *page,
 	struct bio_vec bvec;
 	struct bio bio;
 
-	if (iomap->type != IOMAP_MAPPED || block_start >= i_size_read(inode)) {
+	if (iomap_block_needs_zeroing(inode, iomap, block_start)) {
 		zero_user_segments(page, poff, from, to, poff + plen);
 		iomap_set_range_uptodate(page, poff, plen);
 		return 0;
-- 
2.20.1

