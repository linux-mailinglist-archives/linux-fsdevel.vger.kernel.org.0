Return-Path: <linux-fsdevel+bounces-17350-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BB18AB903
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 04:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BD2B1C20DDF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 02:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E97118041;
	Sat, 20 Apr 2024 02:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jnGYoFwp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5186B1863F
	for <linux-fsdevel@vger.kernel.org>; Sat, 20 Apr 2024 02:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713581465; cv=none; b=kFGxa6x2bcO2NTzxo5C/FRaYlol1/qBmQsQA84ieSE6Rl/MlokZZAs1WmXpZQI+xGRVQr6QCyt6vhohanBgzpRELRBdi/h8WdTRD2Q14owA1FdtWvY4V48qZUhnyPfrwF3jI/jGOZ2KwreP+MM5QHATBzB+OoAfvmdLowZwj1Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713581465; c=relaxed/simple;
	bh=Idqxa+/CuIoHgoi7BlUOzrbP2eqRX0jkek5KzpQfEvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K3/QUmkLBpxEmk/xEZPWnv8+GmMkOi2Eyo9LBNxKsEXZX/37w/amU//g12anOkvm6ofFno7DI5TG3HN/SMoHJKfd17qwlwqRSdIr3wC1+4Dc2Apo3jX1WyPQa2jghJ0WNsi6lB8IDdNPFHExikaL9QsAVjTXnwpbWcbKUrCkLE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jnGYoFwp; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=yHXRLPSqUDx/dY1r21WKmlsbaOqpMylngLbXTnW/VC0=; b=jnGYoFwp81x/ROLoLxivKi7bt9
	glrD6O92w9hx+9SSwyjfGODFlvYTiFtwd/rH+40NqCxMSUPuFYoOOYehOj4tnJahnBPJ/K3t9g392
	m/cHM4ENfB3HAT1hplMPUQooiVLxvZ1fII4y3povUEq5TjCfFUaTQNI3xec+HanXbErvolkpa+AWd
	nC0KZGxpGYukVG2Fou0eb2v2nqBE5EGvN/CeGNwpwMDl06kKLXuowTzOmHmDauHj3mPMk6Uu3ToyR
	iNt1fB3Sxl9w00MJjP/PaLWw3sPF6yKjCFncDx4Ta0QEHW8qRl2e5widIk6T4aT3htCAPWnMS/Xqz
	mJQ0ALOw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ry0oc-000000095gJ-1Kdn;
	Sat, 20 Apr 2024 02:50:58 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Phillip Lougher <phillip@squashfs.org.uk>
Subject: [PATCH 22/30] squashfs: Convert squashfs_symlink_read_folio to use folio APIs
Date: Sat, 20 Apr 2024 03:50:17 +0100
Message-ID: <20240420025029.2166544-23-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240420025029.2166544-1-willy@infradead.org>
References: <20240420025029.2166544-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove use of page APIs, return the errno instead of 0, switch from
kmap_atomic to kmap_local and use folio_end_read() to unify the two
exit paths.

Cc: Phillip Lougher <phillip@squashfs.org.uk>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/squashfs/symlink.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/fs/squashfs/symlink.c b/fs/squashfs/symlink.c
index 2bf977a52c2c..6ef735bd841a 100644
--- a/fs/squashfs/symlink.c
+++ b/fs/squashfs/symlink.c
@@ -32,20 +32,19 @@
 
 static int squashfs_symlink_read_folio(struct file *file, struct folio *folio)
 {
-	struct page *page = &folio->page;
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = folio->mapping->host;
 	struct super_block *sb = inode->i_sb;
 	struct squashfs_sb_info *msblk = sb->s_fs_info;
-	int index = page->index << PAGE_SHIFT;
+	int index = folio_pos(folio);
 	u64 block = squashfs_i(inode)->start;
 	int offset = squashfs_i(inode)->offset;
 	int length = min_t(int, i_size_read(inode) - index, PAGE_SIZE);
-	int bytes, copied;
+	int bytes, copied, error;
 	void *pageaddr;
 	struct squashfs_cache_entry *entry;
 
 	TRACE("Entered squashfs_symlink_readpage, page index %ld, start block "
-			"%llx, offset %x\n", page->index, block, offset);
+			"%llx, offset %x\n", folio->index, block, offset);
 
 	/*
 	 * Skip index bytes into symlink metadata.
@@ -57,14 +56,15 @@ static int squashfs_symlink_read_folio(struct file *file, struct folio *folio)
 			ERROR("Unable to read symlink [%llx:%x]\n",
 				squashfs_i(inode)->start,
 				squashfs_i(inode)->offset);
-			goto error_out;
+			error = bytes;
+			goto out;
 		}
 	}
 
 	/*
 	 * Read length bytes from symlink metadata.  Squashfs_read_metadata
 	 * is not used here because it can sleep and we want to use
-	 * kmap_atomic to map the page.  Instead call the underlying
+	 * kmap_local to map the folio.  Instead call the underlying
 	 * squashfs_cache_get routine.  As length bytes may overlap metadata
 	 * blocks, we may need to call squashfs_cache_get multiple times.
 	 */
@@ -75,29 +75,26 @@ static int squashfs_symlink_read_folio(struct file *file, struct folio *folio)
 				squashfs_i(inode)->start,
 				squashfs_i(inode)->offset);
 			squashfs_cache_put(entry);
-			goto error_out;
+			error = entry->error;
+			goto out;
 		}
 
-		pageaddr = kmap_atomic(page);
+		pageaddr = kmap_local_folio(folio, 0);
 		copied = squashfs_copy_data(pageaddr + bytes, entry, offset,
 								length - bytes);
 		if (copied == length - bytes)
 			memset(pageaddr + length, 0, PAGE_SIZE - length);
 		else
 			block = entry->next_index;
-		kunmap_atomic(pageaddr);
+		kunmap_local(pageaddr);
 		squashfs_cache_put(entry);
 	}
 
-	flush_dcache_page(page);
-	SetPageUptodate(page);
-	unlock_page(page);
-	return 0;
-
-error_out:
-	SetPageError(page);
-	unlock_page(page);
-	return 0;
+	flush_dcache_folio(folio);
+	error = 0;
+out:
+	folio_end_read(folio, error == 0);
+	return error;
 }
 
 
-- 
2.43.0


