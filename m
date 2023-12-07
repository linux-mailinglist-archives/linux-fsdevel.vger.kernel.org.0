Return-Path: <linux-fsdevel+bounces-5114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D51B808352
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 09:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD216283BDA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 08:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9755F328AD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 08:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Vh0UFb5U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D926BD53;
	Wed,  6 Dec 2023 23:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Zq1p2D6CIWYIAN1TsIMnd1JMbwcaUt5eEkAWi8KwBmU=; b=Vh0UFb5UqYlCnXfTGHim8JxHXr
	joTNw9ufG9VAmBSi1dyBPWk7nFDOj41pMvIEfV9Kh9PuiW4i4hCpJamF/ezTz3aRL2MlzT6fw7d22
	WfkrF5WCE95qZaXcb+Ezkv+jMW1WPYgSeguUlh/t2g2yGyh4zYuZAg0Gx5kUouxY4bYbgyr1/JXw/
	wLQkVX4PsQRryLceWm2PdgfkRLMX9UoGC43+e6/yvTORQYrNuEmKcmthDxm3BWG48MgVHRV6E7Sax
	DvtLvZCdya63/sjbRy0zvIhZE0f9eIwCzHVipndj8psejg6hcWeIOSYFZpHeuIpZUNT13meBljImJ
	ytVjE6DA==;
Received: from [2001:4bb8:191:e7ca:4bf6:cea4:9bbf:8b02] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rB8n5-00C4yV-1S;
	Thu, 07 Dec 2023 07:27:24 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Zhang Yi <yi.zhang@huaweicloud.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev
Subject: [PATCH 03/14] iomap: move the io_folios field out of struct iomap_ioend
Date: Thu,  7 Dec 2023 08:26:59 +0100
Message-Id: <20231207072710.176093-4-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231207072710.176093-1-hch@lst.de>
References: <20231207072710.176093-1-hch@lst.de>
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
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/iomap/buffered-io.c | 7 ++++---
 include/linux/iomap.h  | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 2426cab70b7102..dc5039cdacd928 100644
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


