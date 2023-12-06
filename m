Return-Path: <linux-fsdevel+bounces-5053-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5B3807B65
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 23:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E250B210AF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 22:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B42C6ABAD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 22:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QQfmeVEZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD866181
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Dec 2023 12:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=o3B7u1P/k6TzmVja45VGtrilsyev3YFMEAt9Vx4rKAM=; b=QQfmeVEZlZxVdEUHIBYOZ/D19+
	gOhp8kYyqFESYAZj6xfiIjF214EmQZXzg/yUwIAkOi6zEt1wta469NwjtTpKQQrD0Z3W3PXdGYa1n
	IZgQV5dX0ZVwZw2iHTeCGK4x3+kTXxBgKnFn/zbTHbmJp7wkMkweKz51af8IZTtSMpxp9PehkFJRp
	m5kW/78gHnrzjBY5lioTcXK1GyECGob4kw4HIBr8HMhdbZiLUflFAFI+7Eg3duwpnX2l6GCEpG5QK
	it5CRP4bzk7/Cw5FLdNEGxGTjt2yLJD6yVESncqFGNt+aQ2zG4X3JmLtAQiWy3Z+Dsw6XgIlvgD6A
	jE7Gdo6A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rAymt-003Emf-5j; Wed, 06 Dec 2023 20:46:31 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] freevxfs: Convert vxfs_immed_read_folio to the new folio APIs
Date: Wed,  6 Dec 2023 20:46:29 +0000
Message-Id: <20231206204629.771797-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use folio_fill_tail() and folio_end_read() instead of open-coding them.
Add a sanity check in case a folio is allocated above index 0.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/freevxfs/vxfs_immed.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/fs/freevxfs/vxfs_immed.c b/fs/freevxfs/vxfs_immed.c
index 9b49ec36e667..b9c6c7118e58 100644
--- a/fs/freevxfs/vxfs_immed.c
+++ b/fs/freevxfs/vxfs_immed.c
@@ -28,19 +28,16 @@
  * Locking status:
  *   @folio is locked and will be unlocked.
  */
-static int vxfs_immed_read_folio(struct file *fp, struct folio *folio)
+static int vxfs_immed_read_folio(struct file *file, struct folio *folio)
 {
 	struct vxfs_inode_info *vip = VXFS_INO(folio->mapping->host);
-	void *src = vip->vii_immed.vi_immed + folio_pos(folio);
-	unsigned long i;
+	size_t len = VXFS_NIMMED;
 
-	for (i = 0; i < folio_nr_pages(folio); i++) {
-		memcpy_to_page(folio_page(folio, i), 0, src, PAGE_SIZE);
-		src += PAGE_SIZE;
-	}
+	if (folio->index > 0)
+		len = 0;
 
-	folio_mark_uptodate(folio);
-	folio_unlock(folio);
+	folio_fill_tail(folio, 0, vip->vii_immed.vi_immed, len);
+	folio_end_read(folio, true);
 
 	return 0;
 }
-- 
2.42.0


