Return-Path: <linux-fsdevel+bounces-32210-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A6C9A264B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 17:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B33A21F226C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 15:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B861DED5C;
	Thu, 17 Oct 2024 15:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p0SmMe3l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9255FDA7;
	Thu, 17 Oct 2024 15:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729178236; cv=none; b=cWZEJVmpS69cMyOliDcT43sVz3R6lwnsAHxHF9lVTxazK8b6lYSo8OofTvNo49aYarlvCe5jzKGLOd+btbLOa8qfVMar2L8p7AtWACbd1PhNJUfCodrWlAn5MfkKxmQ103mKJZyDNn7Yv23FRl8bqu9CV6Be0sFFYRBXvded8+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729178236; c=relaxed/simple;
	bh=1caFjQQZvB3+JN+dIMswr4Vcy1txHMt8bmAs/dJUoLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TPhNeeAg1aLriJpPCgGLNHyKxZv99pzYTOeM4iFQJ6cq95EcGaJKbm1mbVoqzTlAzTy2KisWz/t8MasgjXHFupKmErB6iIv7SR0xdRTgmtqSlM8KBExMvXr5/md+Vzo6kVudc2cAqMLuBnWXTV5zYzSQ3K+isYlUe7bOR8SqFt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=p0SmMe3l; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=ng0eZp01OgC9cDIHYLX7obIwbMG6Cc8dT+Ls+v/nGIM=; b=p0SmMe3lIKO7KTukY7se+NlyqL
	Do9yvdvfNlbwxpFepAnwxbzFESd/alDbYJcE4/mRVPz26KVBqItk6rk8UZ+kXj9OkSMFqsCyChIo0
	lrnr1k53betDbcaxX8IVNrWqQrlpW+jejKwLdMRpy9xafJO5cp8qyfVyusXiuKcLeCYV8T3mvO0YS
	ubfaeNlRoD/R2ff6Vc3wIeckJERHoNDg7RFRX7fFtCfHiLl674TeRCsFcJSmI2TcBYW2mh+z59bdN
	LKu0rh8vvStOSNH0k+D0DTt9C0UQ0PFZYzgkc1hkqXZVhlHmTat2KkkBRkxgCvF6gEykh88mFNPt1
	eKSxnBJA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t1SFS-0000000BNnH-3gNT;
	Thu, 17 Oct 2024 15:17:10 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Tyler Hicks <code@tyhicks.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ecryptfs@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 02/10] ecryptfs: Use a folio throughout ecryptfs_read_folio()
Date: Thu, 17 Oct 2024 16:16:57 +0100
Message-ID: <20241017151709.2713048-3-willy@infradead.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241017151709.2713048-1-willy@infradead.org>
References: <20241017151709.2713048-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the conversion to a struct page.  Removes a few hidden calls to
compound_head().

Also remove the unnecessary call to ClearPageUptodate(); the uptodate
flag is already clear if this function is being called.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ecryptfs/mmap.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/fs/ecryptfs/mmap.c b/fs/ecryptfs/mmap.c
index 92ea39d907de..346ed5f7ff8d 100644
--- a/fs/ecryptfs/mmap.c
+++ b/fs/ecryptfs/mmap.c
@@ -178,18 +178,18 @@ ecryptfs_copy_up_encrypted_with_header(struct page *page,
  */
 static int ecryptfs_read_folio(struct file *file, struct folio *folio)
 {
-	struct page *page = &folio->page;
+	struct inode *inode = folio->mapping->host;
 	struct ecryptfs_crypt_stat *crypt_stat =
-		&ecryptfs_inode_to_private(page->mapping->host)->crypt_stat;
+		&ecryptfs_inode_to_private(inode)->crypt_stat;
 	int rc = 0;
 
 	if (!crypt_stat || !(crypt_stat->flags & ECRYPTFS_ENCRYPTED)) {
-		rc = ecryptfs_read_lower_page_segment(page, page->index, 0,
-						      PAGE_SIZE,
-						      page->mapping->host);
+		rc = ecryptfs_read_lower_page_segment(&folio->page, folio->index, 0,
+						      folio_size(folio),
+						      inode);
 	} else if (crypt_stat->flags & ECRYPTFS_VIEW_AS_ENCRYPTED) {
 		if (crypt_stat->flags & ECRYPTFS_METADATA_IN_XATTR) {
-			rc = ecryptfs_copy_up_encrypted_with_header(page,
+			rc = ecryptfs_copy_up_encrypted_with_header(&folio->page,
 								    crypt_stat);
 			if (rc) {
 				printk(KERN_ERR "%s: Error attempting to copy "
@@ -201,9 +201,9 @@ static int ecryptfs_read_folio(struct file *file, struct folio *folio)
 			}
 
 		} else {
-			rc = ecryptfs_read_lower_page_segment(
-				page, page->index, 0, PAGE_SIZE,
-				page->mapping->host);
+			rc = ecryptfs_read_lower_page_segment(&folio->page,
+					folio->index, 0, folio_size(folio),
+					inode);
 			if (rc) {
 				printk(KERN_ERR "Error reading page; rc = "
 				       "[%d]\n", rc);
@@ -211,7 +211,7 @@ static int ecryptfs_read_folio(struct file *file, struct folio *folio)
 			}
 		}
 	} else {
-		rc = ecryptfs_decrypt_page(page);
+		rc = ecryptfs_decrypt_page(&folio->page);
 		if (rc) {
 			ecryptfs_printk(KERN_ERR, "Error decrypting page; "
 					"rc = [%d]\n", rc);
@@ -219,13 +219,11 @@ static int ecryptfs_read_folio(struct file *file, struct folio *folio)
 		}
 	}
 out:
-	if (rc)
-		ClearPageUptodate(page);
-	else
-		SetPageUptodate(page);
+	if (!rc)
+		folio_mark_uptodate(folio);
 	ecryptfs_printk(KERN_DEBUG, "Unlocking page with index = [0x%.16lx]\n",
-			page->index);
-	unlock_page(page);
+			folio->index);
+	folio_unlock(folio);
 	return rc;
 }
 
-- 
2.43.0


