Return-Path: <linux-fsdevel+bounces-17562-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 635278AFC45
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 00:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94AF01C2204D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 22:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41DE381DA;
	Tue, 23 Apr 2024 22:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NT2phuhB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E134218B04;
	Tue, 23 Apr 2024 22:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713912965; cv=none; b=lZUXcj6HFp3NQKywuyqGxh9pbDedvButH5+TTMKLcNzhFjhuVaTR2iG7EutRfrZ0DqYsJIFr6SzUyrED/knQdEU9p94xzPdkizUxXtyLNYPSLG9o8Gz5id6oFKXlBkGkMvO41VEQY58ypGfWea+1aA2dQGwFxL0HPAE9gXoswFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713912965; c=relaxed/simple;
	bh=yVX3L0/mzon+qEKCJUk3SLiwzTsR0/rXbZi6nOebKOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WHwOT5Gfq3vrtB8hEaZ22iyQ6c3bGVFbFcDkSuqEnmU4T6pZojMJkKPVTO2iz6sRn9wr9RoiFXMoo6SlilI/Kwf+YZyaEUbJVstD9MnqR0XtF+MsIqYEjkmvC6KNAH7dMdZpgP65HHRdhVpgdr4Zsj9USFS4KCP3aWfFH/9Xup8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NT2phuhB; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=INusEyB6dR3vgU5usJpWnfIw4VplmU4zwONWpNN/d/w=; b=NT2phuhB9ilem0ZbyyRx5jBEPe
	JMbXTjlRG5reeWvDli1o699wO7DV0K1j8OXZXC8c8ksIm2T9sSZfzRhbwbbmtDaYai/OMJX/h/1JI
	2Hn/U3vhEWzalCdjm77c4mqnQ+rH/OsTFTV8JaPtAvfgZwPAvz5UHlCvTC8+vsBdFMTjE3HcZXKYo
	DpCBiYu1SklMcCKYgHCwhIswIDNhKdBrOEFI9xxAiMPxg3s4gsElsBR9yY7M+djUeP8uizrw/2tDR
	YHfKURym5m/8DjC3/f6CiRiSoFIkd0ryFFDjaIS3EB+O0v+cFV4uZQo6kEfFJbQf6gmj6pJeYFn6Y
	S3L4opow==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzP3K-0000000HG6E-1Erv;
	Tue, 23 Apr 2024 22:55:54 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH 1/6] fscrypt: Convert bh_get_inode_and_lblk_num to use a folio
Date: Tue, 23 Apr 2024 23:55:32 +0100
Message-ID: <20240423225552.4113447-2-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423225552.4113447-1-willy@infradead.org>
References: <20240423225552.4113447-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove uses of page->index, page_mapping() and b_page.  Saves a call
to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/crypto/inline_crypt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/crypto/inline_crypt.c b/fs/crypto/inline_crypt.c
index b4002aea7cdb..40de69860dcf 100644
--- a/fs/crypto/inline_crypt.c
+++ b/fs/crypto/inline_crypt.c
@@ -284,7 +284,7 @@ static bool bh_get_inode_and_lblk_num(const struct buffer_head *bh,
 				      const struct inode **inode_ret,
 				      u64 *lblk_num_ret)
 {
-	struct page *page = bh->b_page;
+	struct folio *folio = bh->b_folio;
 	const struct address_space *mapping;
 	const struct inode *inode;
 
@@ -292,13 +292,13 @@ static bool bh_get_inode_and_lblk_num(const struct buffer_head *bh,
 	 * The ext4 journal (jbd2) can submit a buffer_head it directly created
 	 * for a non-pagecache page.  fscrypt doesn't care about these.
 	 */
-	mapping = page_mapping(page);
+	mapping = folio_mapping(folio);
 	if (!mapping)
 		return false;
 	inode = mapping->host;
 
 	*inode_ret = inode;
-	*lblk_num_ret = ((u64)page->index << (PAGE_SHIFT - inode->i_blkbits)) +
+	*lblk_num_ret = ((u64)folio->index << (PAGE_SHIFT - inode->i_blkbits)) +
 			(bh_offset(bh) >> inode->i_blkbits);
 	return true;
 }
-- 
2.43.0


