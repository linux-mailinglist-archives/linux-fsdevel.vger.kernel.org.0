Return-Path: <linux-fsdevel+bounces-48992-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A886AB7284
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 19:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5E6C4C3856
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 17:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CA728033B;
	Wed, 14 May 2025 17:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s8T9onjz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F8327703E;
	Wed, 14 May 2025 17:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747242800; cv=none; b=Wnh6q5O7KRj42hPjtbhoOpCmhV052tg/h005blIyM3WSAsT2PDPT4NtueIraMM2l91Bz41wqS+E2V05qhf8wAPzeBIISOQWD7AQfd6Q8az0UT21w8/4g+AHPfQD4Qe4+GJKchDhRLWzG1Koj1zrreCOFDwTU9eQSORDBKGqfG2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747242800; c=relaxed/simple;
	bh=1Zw/VAwJiJhekem58x0jPUc8ssifiueBteQ5XHc0qw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eHqUsrnjaBlobjQk91H9dM+Kgb1ZTd5umTPZSQ2+hR/hFnwInKFcT5fP0nI8V7X6L8P7Qq3E5JeJN+uQAeFXHJTBOTrEttNZMioKrXA0vrc9NC8RWFBBwpVm3o1WqZHuSWUTuKcCX33ndmLAvEJWnq9dIe0lcRDNzTaBV53k6v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=s8T9onjz; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=QnNgoY4uculrq/ANJIPIZTZJUA1KZFWSKlB0fR9q+Jg=; b=s8T9onjzVoQU29j6FYFfHUqgys
	1/RIBSJThwqh7DhoX5L50fwVmDnEp1VLPekSl7XeS5A7tOwEMKBzxGzpDymCaCTXx4SifxuHZUOkq
	jhPoVkhovF0To1+SToEs4v3VW+WdPhGzcb9A3bPZow4ICE1wkcGHFRCN9eTM1qoLVCmW4Gkve08x5
	yCMJ4yid4LO917dlQY7g4IV9mWmOz+DKCOisS59JP237OChh1IYbg5vlce3rJFkFADkUiSDTuEVI/
	oXFKfRiBKny2R2nIat6k3Z1abmyGPded43AzYe5YNfZFt8bkDrH1t3GnS7totNGnZXbYy/5nSukbx
	6oZw2pbA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFFfR-0000000CbCk-2YgY;
	Wed, 14 May 2025 17:13:17 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH 2/3] nfs: Use a folio in nfs_get_link()
Date: Wed, 14 May 2025 18:13:13 +0100
Message-ID: <20250514171316.3002934-3-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250514171316.3002934-1-willy@infradead.org>
References: <20250514171316.3002934-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mirror the changes to __page_get_link() by retrieving a folio from
the page cache instead of a page.  Removes two hidden calls to
compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/nfs/symlink.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/nfs/symlink.c b/fs/nfs/symlink.c
index 1c62a5a9f51d..004a8f6c568e 100644
--- a/fs/nfs/symlink.c
+++ b/fs/nfs/symlink.c
@@ -40,31 +40,31 @@ static const char *nfs_get_link(struct dentry *dentry,
 				struct inode *inode,
 				struct delayed_call *done)
 {
-	struct page *page;
+	struct folio *folio;
 	void *err;
 
 	if (!dentry) {
 		err = ERR_PTR(nfs_revalidate_mapping_rcu(inode));
 		if (err)
 			return err;
-		page = find_get_page(inode->i_mapping, 0);
-		if (!page)
+		folio = filemap_get_folio(inode->i_mapping, 0);
+		if (IS_ERR(folio))
 			return ERR_PTR(-ECHILD);
-		if (!PageUptodate(page)) {
-			put_page(page);
+		if (!folio_test_uptodate(folio)) {
+			folio_put(folio);
 			return ERR_PTR(-ECHILD);
 		}
 	} else {
 		err = ERR_PTR(nfs_revalidate_mapping(inode, inode->i_mapping));
 		if (err)
 			return err;
-		page = read_cache_page(&inode->i_data, 0, nfs_symlink_filler,
+		folio = read_cache_folio(&inode->i_data, 0, nfs_symlink_filler,
 				NULL);
-		if (IS_ERR(page))
-			return ERR_CAST(page);
+		if (IS_ERR(folio))
+			return ERR_CAST(folio);
 	}
-	set_delayed_call(done, page_put_link, page);
-	return page_address(page);
+	set_delayed_call(done, page_put_link, &folio->page);
+	return folio_address(folio);
 }
 
 /*
-- 
2.47.2


