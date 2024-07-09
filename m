Return-Path: <linux-fsdevel+bounces-23407-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B9692BDB9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 17:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D20028835D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 15:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E333E19D095;
	Tue,  9 Jul 2024 15:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XWsINxQS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4A319CCED
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jul 2024 15:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720537399; cv=none; b=tC4q+JgYdQbJFrPYqQ6Bu/RIi92tb1PnAFy93sIJ42BJJCBn7rC/5ZMXeFOvncCKa7XQaOis4brqULfmQaFyMW80HfvpLC72tlr93eV3J5ye9HIc8uB3w4Cozxg15GEVLOEbSM7EUuO3SCX3U5AHypuYKS5xRJh3IkIhpMIpJwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720537399; c=relaxed/simple;
	bh=3FZTLXuaU09VVvMBzOjdk8Z8qReFeOFUk3dTmgnFQF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=svoyuAf/ySrfAb4EpWxSJuq6TiEY84g8y21z5Z2qnjm9LEa74MWptu/PmRyDYo83rtwYfDBCXW0m4S41FBLiK//Aw8tyC+J7Nl8WuEZKPSHuaCEUfUgSm8Enaidc351upsfcQwsA7HVTg1IpJwYNJMBD2mUSqyQmUmgywgx/CsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XWsINxQS; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=KJaLSVXi592y0gacfuTTiBm+7QT8qlBLotHuY2MXYgc=; b=XWsINxQSXVyn1U6hRMh2UBaOko
	JrePQjUQAtEAM8Ja3/9GFOWfEs/yO5H7QuWWGUsBBmlicnA1H88iZRaeD/mWLcBlYivIkoPDBmzUu
	fviF8GB7kW4Ebx4g5rZLYQSiMQzMEDZsK0xY3VnYB+3FjJJ4Nwvb2AexSUnV9FGXCSvL3XzEB8Lmv
	FpiENDF+Ygsn91Y2u4DKZhOWTu5YGG9EtSulM95X2eXi/WiqP1Zr1/9/6tWZVz/F1psQ3fCZLbxSl
	GYVcMNnOQI60jBgH8jmxa4dBZTMK+wheVgNly4vhIZRtXcQn3GrVk9c7cg3/ZEp45Jxe7vsdMsLrZ
	k5neeIlg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRCNA-00000007zsN-0fQs;
	Tue, 09 Jul 2024 15:03:16 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 6/7] sysv: Convert sysv_prepare_chunk() to take a folio
Date: Tue,  9 Jul 2024 16:03:11 +0100
Message-ID: <20240709150314.1906109-7-willy@infradead.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240709150314.1906109-1-willy@infradead.org>
References: <20240709150314.1906109-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All callers now have a folio, so convert ufs_prepare_chunk() to take one.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/sysv/dir.c   | 8 ++++----
 fs/sysv/itree.c | 4 ++--
 fs/sysv/sysv.h  | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/sysv/dir.c b/fs/sysv/dir.c
index 5f91a82a2966..43615b803fee 100644
--- a/fs/sysv/dir.c
+++ b/fs/sysv/dir.c
@@ -213,7 +213,7 @@ int sysv_add_link(struct dentry *dentry, struct inode *inode)
 got_it:
 	pos = folio_pos(folio) + offset_in_folio(folio, de);
 	folio_lock(folio);
-	err = sysv_prepare_chunk(&folio->page, pos, SYSV_DIRSIZE);
+	err = sysv_prepare_chunk(folio, pos, SYSV_DIRSIZE);
 	if (err)
 		goto out_unlock;
 	memcpy (de->name, name, namelen);
@@ -238,7 +238,7 @@ int sysv_delete_entry(struct sysv_dir_entry *de, struct folio *folio)
 	int err;
 
 	folio_lock(folio);
-	err = sysv_prepare_chunk(&folio->page, pos, SYSV_DIRSIZE);
+	err = sysv_prepare_chunk(folio, pos, SYSV_DIRSIZE);
 	if (err) {
 		folio_unlock(folio);
 		return err;
@@ -259,7 +259,7 @@ int sysv_make_empty(struct inode *inode, struct inode *dir)
 
 	if (IS_ERR(folio))
 		return PTR_ERR(folio);
-	err = sysv_prepare_chunk(&folio->page, 0, 2 * SYSV_DIRSIZE);
+	err = sysv_prepare_chunk(folio, 0, 2 * SYSV_DIRSIZE);
 	if (err) {
 		folio_unlock(folio);
 		goto fail;
@@ -335,7 +335,7 @@ int sysv_set_link(struct sysv_dir_entry *de, struct folio *folio,
 	int err;
 
 	folio_lock(folio);
-	err = sysv_prepare_chunk(&folio->page, pos, SYSV_DIRSIZE);
+	err = sysv_prepare_chunk(folio, pos, SYSV_DIRSIZE);
 	if (err) {
 		folio_unlock(folio);
 		return err;
diff --git a/fs/sysv/itree.c b/fs/sysv/itree.c
index 19bcb51a2203..c8511e286673 100644
--- a/fs/sysv/itree.c
+++ b/fs/sysv/itree.c
@@ -466,9 +466,9 @@ static int sysv_read_folio(struct file *file, struct folio *folio)
 	return block_read_full_folio(folio, get_block);
 }
 
-int sysv_prepare_chunk(struct page *page, loff_t pos, unsigned len)
+int sysv_prepare_chunk(struct folio *folio, loff_t pos, unsigned len)
 {
-	return __block_write_begin(page, pos, len, get_block);
+	return __block_write_begin(&folio->page, pos, len, get_block);
 }
 
 static void sysv_write_failed(struct address_space *mapping, loff_t to)
diff --git a/fs/sysv/sysv.h b/fs/sysv/sysv.h
index fec9f6b883d5..0a48b2e7edb1 100644
--- a/fs/sysv/sysv.h
+++ b/fs/sysv/sysv.h
@@ -133,8 +133,8 @@ extern void sysv_free_block(struct super_block *, sysv_zone_t);
 extern unsigned long sysv_count_free_blocks(struct super_block *);
 
 /* itree.c */
-extern void sysv_truncate(struct inode *);
-extern int sysv_prepare_chunk(struct page *page, loff_t pos, unsigned len);
+void sysv_truncate(struct inode *);
+int sysv_prepare_chunk(struct folio *folio, loff_t pos, unsigned len);
 
 /* inode.c */
 extern struct inode *sysv_iget(struct super_block *, unsigned int);
-- 
2.43.0


