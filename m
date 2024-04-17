Return-Path: <linux-fsdevel+bounces-17174-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3098A89F1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 19:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C08CE1C21C29
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 17:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D5B17166F;
	Wed, 17 Apr 2024 17:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NtiNMMvX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504EA17277B;
	Wed, 17 Apr 2024 17:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713373791; cv=none; b=SXgBHcrRQFGw/OpKDZBqkt4T3n88j5GGGVE9E7C1XcAd/YosCKHve37TEbMF7MWrPs8ENOKedQiqNCzHK056AsKdnFyX2M0E5uHE/zZk3mnVKsjPoEwfMDxfIHitVUWj9FVp4mmDnJ+16vYRi+LrVeMEIvFTyAELq480A5IKil8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713373791; c=relaxed/simple;
	bh=cmaiNkl/cK+cmJoIQq3i7y1M7pu/CeYgGhABAaIDvMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kSO7qOEfRvk1jHR9GFOakUY3Z2rG0Utfvir5mnR+asNpbjK6NaI7XnAgfKuLTsx6uOjY0O7PK43Ll5/4K27LzuZWmpIFktpT6gQxmwV9Tps6bGBjPyyff98ssa/bmHIlbiO59sSYHC9STS+eAPkJNeA9YLHxxSM8SRGP7I2SFr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NtiNMMvX; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=9dr4ClrBHPYafianVPFPF3onj3SGS8CyeDvCS79fFaE=; b=NtiNMMvXVOLWt03g7n5zXetJwk
	GptA+3JKqAJjibaxXvj3tl5Umfy/bxCrbqfaAS/DBEaIjZO7nkjueQ7TxGBMbhIWvvwo3aissBR73
	Vm3T8eyCpL8JjfwmS31Q0hmZg0tHKYU2mkgr5gQ0owJu7cmG0XCrA+h+WL7c7T3kTJVhtcmoyOl+J
	Fa9vn1FZBzXbd/0C/249SBnRqkr4BkHLg46m/hMA/GhHK6PNv4cmC/RbtU0hoywmcZH6o/S2ywmXS
	QEg+LYbpOh/JY9cvzIF+Jd2/qOF6mY4hKpU3vQF5wWoa3RPQ8aO44GQRgl4xmsRBo673H6aCyWR86
	zI7+nBdA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx8n5-00000003LN4-2o1e;
	Wed, 17 Apr 2024 17:09:47 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 01/10] ntfs3: Convert ntfs_read_folio to use a folio
Date: Wed, 17 Apr 2024 18:09:29 +0100
Message-ID: <20240417170941.797116-2-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240417170941.797116-1-willy@infradead.org>
References: <20240417170941.797116-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the struct page conversion, and use a folio throughout.  We still
convert back to a struct page for calling some internal functions,
but those will change soon.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ntfs3/inode.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 3c4c878f6d77..f833d9cd383d 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -698,25 +698,24 @@ static sector_t ntfs_bmap(struct address_space *mapping, sector_t block)
 
 static int ntfs_read_folio(struct file *file, struct folio *folio)
 {
-	struct page *page = &folio->page;
 	int err;
-	struct address_space *mapping = page->mapping;
+	struct address_space *mapping = folio->mapping;
 	struct inode *inode = mapping->host;
 	struct ntfs_inode *ni = ntfs_i(inode);
 
 	if (is_resident(ni)) {
 		ni_lock(ni);
-		err = attr_data_read_resident(ni, page);
+		err = attr_data_read_resident(ni, &folio->page);
 		ni_unlock(ni);
 		if (err != E_NTFS_NONRESIDENT) {
-			unlock_page(page);
+			folio_unlock(folio);
 			return err;
 		}
 	}
 
 	if (is_compressed(ni)) {
 		ni_lock(ni);
-		err = ni_readpage_cmpr(ni, page);
+		err = ni_readpage_cmpr(ni, &folio->page);
 		ni_unlock(ni);
 		return err;
 	}
-- 
2.43.0


