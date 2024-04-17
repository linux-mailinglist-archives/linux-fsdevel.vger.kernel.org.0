Return-Path: <linux-fsdevel+bounces-17175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE0F8A89F2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 19:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EFA3281CCC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 17:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98E117277B;
	Wed, 17 Apr 2024 17:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N/Lsbot1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D130817166B;
	Wed, 17 Apr 2024 17:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713373792; cv=none; b=fJwmKkM/X+u4N0RvuM7Dv8rmsGRzf6eemSaqO89SYzlk1N5GMRYYjwMIAfZXxz1dglYgXpsc74uQ8aZHpd/A5DXp4LtW22p/DC2niaOWPzKpByHe/zajE2xevuD7ZmJUwfwqi5WzNux4kwy4NFzeWU6zagIPiWynYcrQA0ylSk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713373792; c=relaxed/simple;
	bh=ZIQADL2PgbPutONs6shBGTMMzJYF/vEFFU9wUYLdnWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eQdgMFLNETSBiTWBnLnrgNuj2Uv0R+4IHHITVOqke/2BvXUt8VSigFEk1A3Om6f0OnBr5Z88LghjEmaeBWjbMPKmGoio3qNLHIeZb/Tbw9N+WBJZ7JIarcrmcT/iifWG53C9G7un5FKpJVy/s5SLuzPpmu+7v1EABsyA28dkNT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=N/Lsbot1; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=8ReugmAKeubw491/vs0c3edm6WFEtt1rFDHXHFd0JCU=; b=N/Lsbot1AVRSr2pOvU7pi2xM3i
	VvNGgZf/iBp0dbCcnTeYgkaIUraSPq86EOwPy6UiLKbceaEE/hel2No4jOjDK2XSQlotJAu5KIpdR
	lmYkGFGHE9OmyQAbmXAn7uLiM96jG3DAInF6vM5Os16FfEH8WHK/2O567HfsusZz08yOXuL34xpuE
	D8uhI+fFZGUkkIbpmnDZX7z2OXHVZLZAFCni+SmhdeXfS79JdZzNx4emoH96PxF2xujr7Ic8r4Zp2
	H8yo0r6WjC1mOorOUTLdnmLJL5nSW5ZTyg6HMGukPQXRhNv/kESi34pycM69W76eqnkbfHjwrZxfz
	U8pUAPew==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx8n6-00000003LNA-1o09;
	Wed, 17 Apr 2024 17:09:48 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 02/10] ntfs3: Convert ntfs_write_begin to use a folio
Date: Wed, 17 Apr 2024 18:09:30 +0100
Message-ID: <20240417170941.797116-3-willy@infradead.org>
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

Retrieve a folio from the page cache instead of a precise page.
This function is now large folio safe, but its called function is not.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ntfs3/inode.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index f833d9cd383d..25be12e68d6e 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -901,24 +901,25 @@ int ntfs_write_begin(struct file *file, struct address_space *mapping,
 
 	*pagep = NULL;
 	if (is_resident(ni)) {
-		struct page *page =
-			grab_cache_page_write_begin(mapping, pos >> PAGE_SHIFT);
+		struct folio *folio = __filemap_get_folio(mapping,
+				pos >> PAGE_SHIFT, FGP_WRITEBEGIN,
+				mapping_gfp_mask(mapping));
 
-		if (!page) {
-			err = -ENOMEM;
+		if (IS_ERR(folio)) {
+			err = PTR_ERR(folio);
 			goto out;
 		}
 
 		ni_lock(ni);
-		err = attr_data_read_resident(ni, page);
+		err = attr_data_read_resident(ni, &folio->page);
 		ni_unlock(ni);
 
 		if (!err) {
-			*pagep = page;
+			*pagep = &folio->page;
 			goto out;
 		}
-		unlock_page(page);
-		put_page(page);
+		folio_unlock(folio);
+		folio_put(folio);
 
 		if (err != E_NTFS_NONRESIDENT)
 			goto out;
-- 
2.43.0


