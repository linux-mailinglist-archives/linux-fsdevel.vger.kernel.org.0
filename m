Return-Path: <linux-fsdevel+bounces-64409-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACA9BE63BD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 05:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C40E76215E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 03:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E0D2F9C2A;
	Fri, 17 Oct 2025 03:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4buTEpGP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8F62F90C4;
	Fri, 17 Oct 2025 03:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760672794; cv=none; b=SZ8n1tP9FhE5wYY0nW0Mp8i0uDKeU0jOFVocgFny4i6iBRm+2Wc2szpRdoy4EglIe33FY96kDloGuu+gd4KT/z/kyszdl00yOKQjT26PzUxJKpszGXeVzxZu2TKOg1kGW4qqgvvGCxh9y4BoXRQyoyKVEG+je9UEJSzCv06CnCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760672794; c=relaxed/simple;
	bh=Lhs79IIXMmXDOCRPHN61DTjCk7vf6rBieixHmXJ2p40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mTALtfRysvDPiI4iXcGidR2bjfq+igiMfYe1a2TJyTAq9TwKAoYwy2r2pcjwcdA47yFAITs27P/Xi5rwQ6geuh7DC3aw9A12dJ4+fy4W5OxDfJKUDQilwLsGw51l+Q7ixg3DMxhOIqaPanhqdUUW2sHFSj0Oy76MKnI5V7qwR3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4buTEpGP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=YKsfrgXDaorO3CUsvOJQhLL7y61inEH+Bd5/BDdkvPw=; b=4buTEpGPEo6NSTYStECW27un8S
	6A0/K7zKACjM+GCGgU3G0n7fF8aoL6jLPYrGKWyhfsEdwRPbZttIM5EfuGRiHfVEHdiFGuNwuG7KI
	pM1VLyvQoTkuD31kkEu+ChXPzhHmsOSISP/MS4snVyI4TmqgkIWQKyHElWw6A0MJ/b0bHnjAndVVl
	XHEBxKjfjohYKpWejuBcyvUyp5ALvzpOEzc7HRp3xhVLblq6HJC0YSCQRMLNsGsWDCO26nafq2BJ4
	iUvEv+9UBhqe99Q4dpLUHwn9/mofAsN75USNw8x3dk7K3B7G7dmSnzXVGrTUbk5OobQ6fv18pDnHu
	7WFgEYrw==;
Received: from 5-226-109-134.static.ip.netia.com.pl ([5.226.109.134] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9bQE-00000006Tyi-1K4F;
	Fri, 17 Oct 2025 03:46:30 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Carlos Maiolino <cem@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	willy@infradead.org,
	dlemoal@kernel.org,
	hans.holmberg@wdc.com,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 2/3] writeback: allow the file system to override MIN_WRITEBACK_PAGES
Date: Fri, 17 Oct 2025 05:45:48 +0200
Message-ID: <20251017034611.651385-3-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251017034611.651385-1-hch@lst.de>
References: <20251017034611.651385-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The relatively low minimal writeback size of 4MiB means that written back
inodes on rotational media are switched a lot.  Besides introducing
additional seeks, this also can lead to extreme file fragmentation on
zoned devices when a lot of files are cached relative to the available
writeback bandwidth.

Add a superblock field that allows the file system to override the
default size.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/fs-writeback.c         | 14 +++++---------
 fs/super.c                |  1 +
 include/linux/fs.h        |  1 +
 include/linux/writeback.h |  5 +++++
 4 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 11fd08a0efb8..6d50b02cdab6 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -31,11 +31,6 @@
 #include <linux/memcontrol.h>
 #include "internal.h"
 
-/*
- * 4MB minimal write chunk size
- */
-#define MIN_WRITEBACK_PAGES	(4096UL >> (PAGE_SHIFT - 10))
-
 /*
  * Passed into wb_writeback(), essentially a subset of writeback_control
  */
@@ -1874,8 +1869,8 @@ static int writeback_single_inode(struct inode *inode,
 	return ret;
 }
 
-static long writeback_chunk_size(struct bdi_writeback *wb,
-				 struct wb_writeback_work *work)
+static long writeback_chunk_size(struct super_block *sb,
+		struct bdi_writeback *wb, struct wb_writeback_work *work)
 {
 	long pages;
 
@@ -1898,7 +1893,8 @@ static long writeback_chunk_size(struct bdi_writeback *wb,
 	pages = min(wb->avg_write_bandwidth / 2,
 		    global_wb_domain.dirty_limit / DIRTY_SCOPE);
 	pages = min(pages, work->nr_pages);
-	return round_down(pages + MIN_WRITEBACK_PAGES, MIN_WRITEBACK_PAGES);
+	return round_down(pages + sb->s_min_writeback_pages,
+			sb->s_min_writeback_pages);
 }
 
 /*
@@ -2000,7 +1996,7 @@ static long writeback_sb_inodes(struct super_block *sb,
 		inode->i_state |= I_SYNC;
 		wbc_attach_and_unlock_inode(&wbc, inode);
 
-		write_chunk = writeback_chunk_size(wb, work);
+		write_chunk = writeback_chunk_size(inode->i_sb, wb, work);
 		wbc.nr_to_write = write_chunk;
 		wbc.pages_skipped = 0;
 
diff --git a/fs/super.c b/fs/super.c
index 5bab94fb7e03..599c1d2641fe 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -389,6 +389,7 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 		goto fail;
 	if (list_lru_init_memcg(&s->s_inode_lru, s->s_shrink))
 		goto fail;
+	s->s_min_writeback_pages = MIN_WRITEBACK_PAGES;
 	return s;
 
 fail:
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c895146c1444..ae6f37c6eaa4 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1583,6 +1583,7 @@ struct super_block {
 
 	spinlock_t		s_inode_wblist_lock;
 	struct list_head	s_inodes_wb;	/* writeback inodes */
+	long			s_min_writeback_pages;
 } __randomize_layout;
 
 static inline struct user_namespace *i_user_ns(const struct inode *inode)
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 22dd4adc5667..49e1dd96f43e 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -374,4 +374,9 @@ bool redirty_page_for_writepage(struct writeback_control *, struct page *);
 void sb_mark_inode_writeback(struct inode *inode);
 void sb_clear_inode_writeback(struct inode *inode);
 
+/*
+ * 4MB minimal write chunk size
+ */
+#define MIN_WRITEBACK_PAGES	(4096UL >> (PAGE_SHIFT - 10))
+
 #endif		/* WRITEBACK_H */
-- 
2.47.3


