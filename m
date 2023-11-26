Return-Path: <linux-fsdevel+bounces-3844-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C5E7F92A9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Nov 2023 13:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7997BB20D83
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Nov 2023 12:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293B9D305;
	Sun, 26 Nov 2023 12:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Vo7JB0Qn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD92E5;
	Sun, 26 Nov 2023 04:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=nO66HhDVj8qK+jri+LLhFBDwrCdlEsgQHS76+niCImc=; b=Vo7JB0QnB3MzgqOklRJt+XL8nq
	MUR5y32Hh3qVcbveYww8wlDpS3LVOlfj4YWp5pxv0YMlWUp/5lrNBNudiKb20zJsBuQ/b2+nyGThg
	6YcwfmoJqQqsYsXWzUfYbjs12IACHESnBkM3WCntqAesy9nN0mJQb4+19G6HI+XDqFSPC8Fe049pW
	P9H2XxygtCdxFs/ZqZOi/YGWua/FARzJ8denfNvPxQ6aVQ/ZDEC/Cp7gKagrAcZwDa5KQThUUlGTV
	xvgQWcwDd6gLJCXP1QxrKZtkc14QATiPqgvMf2susJp/5I+R/kY4ErJNKZJC4G3jMkcDQe9PAk39V
	DabdRsvQ==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1r7EXv-00BCEh-1a;
	Sun, 26 Nov 2023 12:47:36 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Zhang Yi <yi.zhang@huaweicloud.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 03/13] iomap: move the io_folios field out of struct iomap_ioend
Date: Sun, 26 Nov 2023 13:47:10 +0100
Message-Id: <20231126124720.1249310-4-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231126124720.1249310-1-hch@lst.de>
References: <20231126124720.1249310-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The io_folios member in struct iomap_ioend counts the number of folios
added to an ioend.  It is only used at submission time and can thus be
moved to iomap_writepage_ctx instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 7 ++++---
 include/linux/iomap.h  | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index b1bcc43baf0caf..b28c57f8603303 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1685,10 +1685,11 @@ iomap_alloc_ioend(struct inode *inode, struct iomap_writepage_ctx *wpc,
 	ioend->io_flags = wpc->iomap.flags;
 	ioend->io_inode = inode;
 	ioend->io_size = 0;
-	ioend->io_folios = 0;
 	ioend->io_offset = offset;
 	ioend->io_bio = bio;
 	ioend->io_sector = sector;
+
+	wpc->nr_folios = 0;
 	return ioend;
 }
 
@@ -1732,7 +1733,7 @@ iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t offset,
 	 * also prevents long tight loops ending page writeback on all the
 	 * folios in the ioend.
 	 */
-	if (wpc->ioend->io_folios >= IOEND_BATCH_SIZE)
+	if (wpc->nr_folios >= IOEND_BATCH_SIZE)
 		return false;
 	return true;
 }
@@ -1829,7 +1830,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 		count++;
 	}
 	if (count)
-		wpc->ioend->io_folios++;
+		wpc->nr_folios++;
 
 	WARN_ON_ONCE(!wpc->ioend && !list_empty(&submit_list));
 	WARN_ON_ONCE(!folio_test_locked(folio));
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 96dd0acbba44ac..b2a05dff914d0c 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -293,7 +293,6 @@ struct iomap_ioend {
 	struct list_head	io_list;	/* next ioend in chain */
 	u16			io_type;
 	u16			io_flags;	/* IOMAP_F_* */
-	u32			io_folios;	/* folios added to ioend */
 	struct inode		*io_inode;	/* file being written to */
 	size_t			io_size;	/* size of the extent */
 	loff_t			io_offset;	/* offset in the file */
@@ -329,6 +328,7 @@ struct iomap_writepage_ctx {
 	struct iomap		iomap;
 	struct iomap_ioend	*ioend;
 	const struct iomap_writeback_ops *ops;
+	u32			nr_folios;	/* folios added to the ioend */
 };
 
 void iomap_finish_ioends(struct iomap_ioend *ioend, int error);
-- 
2.39.2


