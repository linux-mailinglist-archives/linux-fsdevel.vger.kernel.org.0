Return-Path: <linux-fsdevel+bounces-34391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D7E9C4E63
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 06:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E743D1F26783
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 05:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CADF20A5C7;
	Tue, 12 Nov 2024 05:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Gy5uV//K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBED1A3BDA
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 05:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731390255; cv=none; b=Pzae1leDeCE+FSLYGzJLZb1yRQlsRTH7F3AapoqByy6oDL1bYp65rDP7Y+WiTsSTU+Y5aUXpRPhN69p6KeLy8B1131tbYPFEUVdo6nwvlRakJMHFfBs/ditMQDvPamq5uBnBCWC+xQHF7bQhvvYtCMRrNHqZ1CMXkT9RYkLVVjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731390255; c=relaxed/simple;
	bh=BzajZdw0dc5wu6ieeytC+Fzpy7Z5dS+zIyU+UGYWXLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pCDsLzcbGwvS8J65ei3YFidA7WULxSOZAq2ZiJBC2T5BYcgeRZFuvVKE3mqXWIfuS2QxSPjO6GKCj3Xyxr/1LAEwJfoVbbGAeFMlETR7LZAA7o4khaPLJY+JqmV7QTpp3JD2JH4HZql6xS3Hjb9flRrt7Ph1WJbp6sZPD1k2OKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Gy5uV//K; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=HjUCUl7Ss/IglFF+ockSljmczaHG7wCrwAO/DZwgkpM=; b=Gy5uV//Ks4p3yyBFt2RdMaNhfl
	fwXgtP3ORtuWThgrs2RMC4LNOg9dBwt2k7ZkUzt+xXI0itq0Ye0/pFMp/xx7sGkseyaGy6NcCV5he
	FvsgdJjb4tRobaGky4QAw+1+kSR4lmavHTp7L7emqH2oVshAoFF2zsMPk6MhhwNWWJEZXkWyqXQ3a
	nPh7O6OEAvtH0CfDfrgO2CI/y37WMvzHd5HhD8VXpSvN84WXfbJvaqsfOlREnkPwdjUaLKeMVvES5
	e/E20h3zRqPj2cUrM133w9MjGEHIocL6g9oY6vO/3Ng0gF+onrtjli6S6USZFsndE1n3+TjRzF81W
	b/NTi6Ig==;
Received: from 2a02-8389-2341-5b80-9a3d-4734-1162-bba0.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:9a3d:4734:1162:bba0] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tAjhF-00000002HQx-1eGF;
	Tue, 12 Nov 2024 05:44:14 +0000
From: Christoph Hellwig <hch@lst.de>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] writeback: wbc_attach_fdatawrite_inode out of line
Date: Tue, 12 Nov 2024 06:43:55 +0100
Message-ID: <20241112054403.1470586-3-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241112054403.1470586-1-hch@lst.de>
References: <20241112054403.1470586-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

This allows exporting this high-level interface only while keeping
wbc_attach_and_unlock_inode private in fs-writeback.c and unexporting
__inode_attach_wb.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/fs-writeback.c         | 31 +++++++++++++++++++++++++++----
 include/linux/writeback.h | 28 ++--------------------------
 2 files changed, 29 insertions(+), 30 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 3fb115ae44b1..77db1f10023e 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -290,7 +290,6 @@ void __inode_attach_wb(struct inode *inode, struct folio *folio)
 	if (unlikely(cmpxchg(&inode->i_wb, NULL, wb)))
 		wb_put(wb);
 }
-EXPORT_SYMBOL_GPL(__inode_attach_wb);
 
 /**
  * inode_cgwb_move_to_attached - put the inode onto wb->b_attached list
@@ -731,8 +730,8 @@ bool cleanup_offline_cgwb(struct bdi_writeback *wb)
  * writeback completion, wbc_detach_inode() should be called.  This is used
  * to track the cgroup writeback context.
  */
-void wbc_attach_and_unlock_inode(struct writeback_control *wbc,
-				 struct inode *inode)
+static void wbc_attach_and_unlock_inode(struct writeback_control *wbc,
+		struct inode *inode)
 	__releases(&inode->i_lock)
 {
 	if (!inode_cgwb_enabled(inode)) {
@@ -763,7 +762,24 @@ void wbc_attach_and_unlock_inode(struct writeback_control *wbc,
 	if (unlikely(wb_dying(wbc->wb) && !css_is_dying(wbc->wb->memcg_css)))
 		inode_switch_wbs(inode, wbc->wb_id);
 }
-EXPORT_SYMBOL_GPL(wbc_attach_and_unlock_inode);
+
+/**
+ * wbc_attach_fdatawrite_inode - associate wbc and inode for fdatawrite
+ * @wbc: writeback_control of interest
+ * @inode: target inode
+ *
+ * This function is to be used by __filemap_fdatawrite_range(), which is an
+ * alternative entry point into writeback code, and first ensures @inode is
+ * associated with a bdi_writeback and attaches it to @wbc.
+ */
+void wbc_attach_fdatawrite_inode(struct writeback_control *wbc,
+		struct inode *inode)
+{
+	spin_lock(&inode->i_lock);
+	inode_attach_wb(inode, NULL);
+	wbc_attach_and_unlock_inode(wbc, inode);
+}
+EXPORT_SYMBOL_GPL(wbc_attach_fdatawrite_inode);
 
 /**
  * wbc_detach_inode - disassociate wbc from inode and perform foreign detection
@@ -1228,6 +1244,13 @@ static void bdi_split_work_to_wbs(struct backing_dev_info *bdi,
 	}
 }
 
+static inline void wbc_attach_and_unlock_inode(struct writeback_control *wbc,
+					       struct inode *inode)
+	__releases(&inode->i_lock)
+{
+	spin_unlock(&inode->i_lock);
+}
+
 #endif	/* CONFIG_CGROUP_WRITEBACK */
 
 /*
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index d6db822e4bb3..aee3e1b4c50f 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -213,9 +213,6 @@ static inline void wait_on_inode(struct inode *inode)
 #include <linux/bio.h>
 
 void __inode_attach_wb(struct inode *inode, struct folio *folio);
-void wbc_attach_and_unlock_inode(struct writeback_control *wbc,
-				 struct inode *inode)
-	__releases(&inode->i_lock);
 void wbc_detach_inode(struct writeback_control *wbc);
 void wbc_account_cgroup_owner(struct writeback_control *wbc, struct page *page,
 			      size_t bytes);
@@ -254,22 +251,8 @@ static inline void inode_detach_wb(struct inode *inode)
 	}
 }
 
-/**
- * wbc_attach_fdatawrite_inode - associate wbc and inode for fdatawrite
- * @wbc: writeback_control of interest
- * @inode: target inode
- *
- * This function is to be used by __filemap_fdatawrite_range(), which is an
- * alternative entry point into writeback code, and first ensures @inode is
- * associated with a bdi_writeback and attaches it to @wbc.
- */
-static inline void wbc_attach_fdatawrite_inode(struct writeback_control *wbc,
-					       struct inode *inode)
-{
-	spin_lock(&inode->i_lock);
-	inode_attach_wb(inode, NULL);
-	wbc_attach_and_unlock_inode(wbc, inode);
-}
+void wbc_attach_fdatawrite_inode(struct writeback_control *wbc,
+		struct inode *inode);
 
 /**
  * wbc_init_bio - writeback specific initializtion of bio
@@ -303,13 +286,6 @@ static inline void inode_detach_wb(struct inode *inode)
 {
 }
 
-static inline void wbc_attach_and_unlock_inode(struct writeback_control *wbc,
-					       struct inode *inode)
-	__releases(&inode->i_lock)
-{
-	spin_unlock(&inode->i_lock);
-}
-
 static inline void wbc_attach_fdatawrite_inode(struct writeback_control *wbc,
 					       struct inode *inode)
 {
-- 
2.45.2


