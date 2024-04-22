Return-Path: <linux-fsdevel+bounces-17427-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C71128AD4E4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 21:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25ED1B21D09
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 19:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE4E155391;
	Mon, 22 Apr 2024 19:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ERBLU/Sw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B78155335;
	Mon, 22 Apr 2024 19:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713814330; cv=none; b=uLWehih8HjMR+s3H/zqkY0k6/kkTOPCpXuyWMusgx76a8rvJvIjKftpjxQYQMoWpx8bPwpaaHJXKK1oHR4fZy5TLob1cur4NHVbOGt2tscZ4WQH3/mvmSo01FyZFY6L+7FbWHhnIVUs5OrYpLPNXGauC439i8zO9SitkwRwBQQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713814330; c=relaxed/simple;
	bh=NnHDD4XZ2kCQ4d7HJke1yukYvowdpmKldE7q4gVSDOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FdwxVBX6FZIxNdnZOrnhKwlsbQcic1vGvrmtvCeNUpatRe8R9r4nSWz0ZeQ4phY66YF0sd/7TD0vlsiIQhsonCT4PqISZB4xLMIUSMtbdefpqN6Ro6r1utMYspDyiN3jrKlIXH5O6Q+lIAz1e9wEOPlOnDiWrKScTn1GJ7Zvyuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ERBLU/Sw; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=d70RGPIKcgF9cV4nDWNd7glVkTC0Q68eNqTUdJA0Mv4=; b=ERBLU/Swu1L0F903yFoWFcPLKk
	8nwwbTmesEcXZ/8SIVKFS/5zHM2wOnQdiBi6yFmoiGFAJtxzEKxIxzJTMMQGlxoOJff3NG46fG8N1
	z4EeOPLpbTo2CzdlByvhPec0fm1OAG4HMbDFR2aO7ObkN7Iwp9tDz05Lgdn1yXQhbRljtyhE8BMls
	/zzO+4pddkvRfbA5CTlY4J0dXLtRtE7ZrWskty2SAtULVwv9rPOp/T+tDtmYxvj6YH8A9llqUFiQb
	KQCx4ED3X7fQ2o89NZloxf1CqK8RMeVeQ/c7FmflEZ/bQYbt3VGEsT9CU/5O4iv2iKbsm0N1o1YRE
	omcT12YQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryzOZ-0000000EpOX-2ObQ;
	Mon, 22 Apr 2024 19:32:07 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 06/11] ntfs3: Convert attr_make_nonresident to use a folio
Date: Mon, 22 Apr 2024 20:31:56 +0100
Message-ID: <20240422193203.3534108-7-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240422193203.3534108-1-willy@infradead.org>
References: <20240422193203.3534108-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fetch a folio from the page cache instead of a page and operate on it.
Take advantage of the new helpers to avoid handling highmem ourselves,
and combine the uptodate + unlock operations into folio_end_read().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ntfs3/attrib.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index 02fa3245850a..d253840c26cf 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -302,22 +302,20 @@ int attr_make_nonresident(struct ntfs_inode *ni, struct ATTRIB *attr,
 			if (err)
 				goto out2;
 		} else if (!page) {
-			char *kaddr;
-
-			page = grab_cache_page(ni->vfs_inode.i_mapping, 0);
-			if (!page) {
-				err = -ENOMEM;
+			struct address_space *mapping = ni->vfs_inode.i_mapping;
+			struct folio *folio;
+
+			folio = __filemap_get_folio(mapping, 0,
+					FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
+					mapping_gfp_mask(mapping));
+			if (IS_ERR(folio)) {
+				err = PTR_ERR(folio);
 				goto out2;
 			}
-			kaddr = kmap_atomic(page);
-			memcpy(kaddr, data, rsize);
-			memset(kaddr + rsize, 0, PAGE_SIZE - rsize);
-			kunmap_atomic(kaddr);
-			flush_dcache_page(page);
-			SetPageUptodate(page);
-			set_page_dirty(page);
-			unlock_page(page);
-			put_page(page);
+			folio_fill_tail(folio, 0, data, rsize);
+			folio_mark_dirty(folio);
+			folio_end_read(folio, true);
+			folio_put(folio);
 		}
 	}
 
-- 
2.43.0


