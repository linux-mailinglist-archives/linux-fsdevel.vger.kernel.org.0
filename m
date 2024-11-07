Return-Path: <linux-fsdevel+bounces-33868-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3289BFF0A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 08:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B6ED283227
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 07:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42406199EAD;
	Thu,  7 Nov 2024 07:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GhSZhb6v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2D51991A4
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Nov 2024 07:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730964407; cv=none; b=BFLaM03kUtXNO0loUlLZWQKK0g4+pkWHks/hmt42Cfe9dxZTj4GnAf91DU6qLr6dJJF4TphyQyrP+jKGbcXTET7+sJCkdhEVfKiQ0iLVaOKFDxg0wl0ws3BWjPUunuMqT9zSLw+ePUA5+BPoyVDjz2kmPVK8Ijpau2i7iFf2Kxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730964407; c=relaxed/simple;
	bh=nuw65G079l26ykLjhNd50Ng1qsvULyJKlJS3USpmOFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t6kSUn1oxstYL4uMPA10Y63f7XV7gLnc5+v+XlPO4vKXRaDbla7YP9z6mY4bk7k/dhLwNf90zW1nCjkVgWpKM/4ww4tZ3IWTKtw6lRBs8UloEcFiF2fIqdRBSgAzoz5FQ1PH52Xz02s7Sh2CdsVHXPyVmw1ENjLAPghDW57XQFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GhSZhb6v; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=GTxk/+7chIHsJj97Udh5zysMB24zstbu0C4YBidTDAQ=; b=GhSZhb6vWp3QQXYT1V5z8gfiOX
	AAz3HSvZoQY6+2d8HTGwzdeTHTFGvh/wSSsElkBR6mDmla4UIdODINe3SAjup5Yb/FkqeLxR2/Z7g
	z/OD3A5fhFfprJC6rW5Oekap/tEVJ1ONyZ/kOPGm+gAth2JCWDEI9YNiIOQW6zoaKl8x6wgDKdRdK
	ZSvIN/2b6JIOadn5TC9Foqe/LxOKKCMChZHvvprdz6t9Deg0oU0cYtjZBrWRf4KjUq71qRYbUdJeo
	EFM5480Pp8BtELrF4eZblswkueeB6qwwxesObq+mzK6M7R5JRXGV5+tnb0j00lWg2k8cbYqU8NhOH
	da9sh0Sg==;
Received: from 213-147-165-243.nat.highway.webapn.at ([213.147.165.243] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t8wui-00000005z7s-3LFd;
	Thu, 07 Nov 2024 07:26:45 +0000
From: Christoph Hellwig <hch@lst.de>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] writeback: move wbc_attach_and_unlock_inode out of line
Date: Thu,  7 Nov 2024 07:26:19 +0000
Message-ID: <20241107072632.672795-3-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241107072632.672795-1-hch@lst.de>
References: <20241107072632.672795-1-hch@lst.de>
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


