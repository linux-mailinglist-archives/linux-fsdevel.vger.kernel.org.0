Return-Path: <linux-fsdevel+bounces-23455-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E097492C7E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 03:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C3D71F23B92
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 01:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D750C4C85;
	Wed, 10 Jul 2024 01:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="At1YkZhA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948D12566
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jul 2024 01:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720574609; cv=none; b=ftXwvO0m38iibmz2XO/s9Cgwqz01J9K4XJ23NNd29Jxn3f7rRhejggrQ/Fm80ozJZEazKTyOd3x60G34Xw/0m1Y3+tPg6Nk6JEIHq6HVWG2PicRic5VemGHRS26VBxhOqoDo8HltWbPDXdei53LEwVwitg6XSO6hi5YdE41L5Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720574609; c=relaxed/simple;
	bh=UkawOYDzSih/dnAYjFZDxTf4D97cB6+NvFnrtStYr4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qTth4Om99YamSdwYlMRb5zOep9Fe3MhjuyqL+RBr3WAwCu2WUoIyDu9jKArSEz+VyGbKakT3lmOuE+Ph2cd1MUeJTkzkvme7ZS5USpMAefKuc873mn9ZW2xzMdZyhfVGGqj1Lxu59D91GwibfG4Jb1yvzxKZdG8GMSvEgd1dFrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=At1YkZhA; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=LCJ2oxqA9TRGO6xMAamg+HEiAooFaPR2RqIubURQO/Y=; b=At1YkZhArE6JaB1QRI7Bc4U2So
	S8N4AMbQTNoBCpfYp+MBWOjNG1MHNXmq4kpnpk8OLt7QyqKPlUHc88HpG9qRjwljm3Vw+cD0Eim1G
	Q6NIG+iVYAQUsDi+TSKT4+tVXFL4JdOlCKees0nDLQRbTN4TECoxeubaSRBNk3Inwb6S8OiUagllB
	c0TQTbr9kzQ/A/MjqKIcObzB4CjhySEe65aIP5gz6aPvpYhMq8VpnYq7e5AT6D/8KGlJ3KruybL2/
	lYDKsSS/iPklhqdI9moJp2QqERPS1S3GM8FKj2NNii+K8SmV/xc+eo1h/ho/bmA829TRPgypXRkRE
	KYcTCGZw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRM3J-00000008YaA-3RdM;
	Wed, 10 Jul 2024 01:23:25 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 5/7] minixfs: Convert minix_make_empty() to use a folio
Date: Wed, 10 Jul 2024 02:23:19 +0100
Message-ID: <20240710012323.2039519-6-willy@infradead.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240710012323.2039519-1-willy@infradead.org>
References: <20240710012323.2039519-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Removes a few hidden calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/minix/dir.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/minix/dir.c b/fs/minix/dir.c
index 994bbbd3dea2..15b3ef1e473c 100644
--- a/fs/minix/dir.c
+++ b/fs/minix/dir.c
@@ -309,21 +309,21 @@ int minix_delete_entry(struct minix_dir_entry *de, struct folio *folio)
 
 int minix_make_empty(struct inode *inode, struct inode *dir)
 {
-	struct page *page = grab_cache_page(inode->i_mapping, 0);
+	struct folio *folio = filemap_grab_folio(inode->i_mapping, 0);
 	struct minix_sb_info *sbi = minix_sb(inode->i_sb);
 	char *kaddr;
 	int err;
 
-	if (!page)
-		return -ENOMEM;
-	err = minix_prepare_chunk(page, 0, 2 * sbi->s_dirsize);
+	if (IS_ERR(folio))
+		return PTR_ERR(folio);
+	err = minix_prepare_chunk(&folio->page, 0, 2 * sbi->s_dirsize);
 	if (err) {
-		unlock_page(page);
+		folio_unlock(folio);
 		goto fail;
 	}
 
-	kaddr = kmap_local_page(page);
-	memset(kaddr, 0, PAGE_SIZE);
+	kaddr = kmap_local_folio(folio, 0);
+	memset(kaddr, 0, folio_size(folio));
 
 	if (sbi->s_version == MINIX_V3) {
 		minix3_dirent *de3 = (minix3_dirent *)kaddr;
@@ -344,10 +344,10 @@ int minix_make_empty(struct inode *inode, struct inode *dir)
 	}
 	kunmap_local(kaddr);
 
-	dir_commit_chunk(page, 0, 2 * sbi->s_dirsize);
+	dir_commit_chunk(&folio->page, 0, 2 * sbi->s_dirsize);
 	err = minix_handle_dirsync(inode);
 fail:
-	put_page(page);
+	folio_put(folio);
 	return err;
 }
 
-- 
2.43.0


