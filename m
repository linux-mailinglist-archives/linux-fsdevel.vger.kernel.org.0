Return-Path: <linux-fsdevel+bounces-20361-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 789848D21EC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 18:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A19F71C23090
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 16:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6A6174EE2;
	Tue, 28 May 2024 16:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xf1WvXMv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446D9173324;
	Tue, 28 May 2024 16:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716914914; cv=none; b=q7iSKLilaAFU4KNR36uzm/JqrWcWHxUauaFovXdw1uhJmzRHZIcm8WUHh+Xq2hMsn7y6hQKfd/7LLhWK638pHy/V9lK3ZzE/kKjM9IteuCbLAVw8/11GlzElEF6ibGwhJsvyI1oYjq9uiUJByIRHi+Q0SYrppWdW/hTBcKCSGIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716914914; c=relaxed/simple;
	bh=ZCJeakTcJ6p69GvYR2jMvA2yFZ2ccNHLw/EMpWoY354=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FrODt33zE5XnYcxgUaE5ia3Mtp3/WTHCnpH1kgS7b5Qau407/QJX79C/j7E/a97ZNsY3o12Bt85mvQEC1qqf2qaHS94yG4qhL805BmmUqPcNNOiX3EkpDc+Njzgoeml3MYt+SKlwv/9FFHIuHuTJftvgUlzh+GfFDvQ1lau29Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Xf1WvXMv; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=+R2mjNBAIE/TqRuotFDeDo18cL36mswtB3So/eMZdyk=; b=Xf1WvXMvl5WlVX8u0ljEDCV5So
	uItvkVqBDJLPub2s/K4y487zJ4rn+Z4P48WTZRTL6e876elM3+diD72CEGB4yK0hvCZSVoNSWO76u
	3TJJYaRWItJ2InVUFt1swNPhcgMvBS43fDG5fxqcKjqHJUxXMWHAvFdeJPFCUPGulkhlSZK1Dr2GY
	Y9UOcdOE0a6KEIx4/BF41ksKTAW4HAE7+eqOnFBMh28U88q5Mer/Dyd0DCht6KzGP0OJ1w1dCVBcJ
	huYVfcq4G7+Q+ICGYrp3snMztABD31qRrkNcxS3Drjbh9QCr1Sm24PvY79ksTP9j9M57XVNARVvRA
	+nr27XNg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBzzz-00000008pjL-2Mcf;
	Tue, 28 May 2024 16:48:31 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH 4/7] fs: Add filemap_symlink()
Date: Tue, 28 May 2024 17:48:25 +0100
Message-ID: <20240528164829.2105447-5-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240528164829.2105447-1-willy@infradead.org>
References: <20240528164829.2105447-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the equivalent of page_symlink() but takes a
buffered_write_operations structure.  It also doesn't handle GFP_NOFS
for you; if you need that, use memalloc_nofs_save() yourself.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/namei.c              | 25 +++++++++++++++++++++++++
 include/linux/pagemap.h |  2 ++
 2 files changed, 27 insertions(+)

diff --git a/fs/namei.c b/fs/namei.c
index 37fb0a8aa09a..4352206b0408 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -5255,6 +5255,31 @@ int page_symlink(struct inode *inode, const char *symname, int len)
 }
 EXPORT_SYMBOL(page_symlink);
 
+int filemap_symlink(struct inode *inode, const char *symname, int len,
+		const struct buffered_write_operations *ops, void **fsdata)
+{
+	struct address_space *mapping = inode->i_mapping;
+	struct folio *folio;
+	int err;
+
+retry:
+	folio = ops->write_begin(NULL, mapping, 0, len-1, fsdata);
+	if (IS_ERR(folio))
+		return PTR_ERR(folio);
+
+	memcpy(folio_address(folio), symname, len-1);
+
+	err = ops->write_end(NULL, mapping, 0, len-1, len-1, folio, fsdata);
+	if (err < 0)
+		return err;
+	if (err < len-1)
+		goto retry;
+
+	mark_inode_dirty(inode);
+	return 0;
+}
+EXPORT_SYMBOL(filemap_symlink);
+
 const struct inode_operations page_symlink_inode_operations = {
 	.get_link	= page_get_link,
 };
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 2921c1cc6335..a7540f757368 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -39,6 +39,8 @@ ssize_t generic_file_write_iter(struct kiocb *, struct iov_iter *);
 #define __generic_file_write_iter(kiocb, iter)		\
 	__filemap_write_iter(kiocb, iter, NULL, NULL)
 
+int filemap_symlink(struct inode *inode, const char *symname, int len,
+		const struct buffered_write_operations *bw, void **fsdata);
 unsigned long invalidate_mapping_pages(struct address_space *mapping,
 					pgoff_t start, pgoff_t end);
 
-- 
2.43.0


