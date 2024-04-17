Return-Path: <linux-fsdevel+bounces-17180-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9DC8A89F8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 19:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 249F31C21E62
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 17:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DAD172BD0;
	Wed, 17 Apr 2024 17:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BQKRFwAs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0690A171640;
	Wed, 17 Apr 2024 17:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713373795; cv=none; b=RPxwyakcU54S7ytVgKuzPbTtx5ParJlqCLYRn56n9XvxTSVJJWO3SnfJMuzYNHw1K5YDuCJz41CPPCgbpy5ba/b4W20kQiYObzIMnvFM7nJ0qLTjxnb0/kAcDdppYS1UHU1JTIJClkKyF9JW0sKynAhyPZh3ZbLQnjxQOSOTrag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713373795; c=relaxed/simple;
	bh=DpVHRUtZmw09qOBriykBMM3ziyBXu+Njf0EOYqDFKXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z87F5SauSh8a9+krhThtOVOAAtaL5W7xbWJHQp7D73BEITZVhG/a5WSpLO6jQ9KM+w8W8yK/4KDw/ksc5ZTyvs6rV9lnQ1POpyTqi3tb9+ZklwLr0YxuyC1u6EUjsY/BRe16ZYffXGGpcs8FVtWA6l+rbPEHltP1HXDSc4uCiio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BQKRFwAs; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Gd/hLk3fvNrVja4FG3MXbWsqnGurE8K7zthCOdTqPwA=; b=BQKRFwAsS6FTLEi9Vc5iQ1iWMJ
	yFWGVq4ySEVBQ+r9kTf3bWPuquRcUq+ny74eAcvLOFgBuObmexrGyjK5H3n5PYNYFqMSbuePin2bU
	29c8fE54tdC7bHTvmSG/AcmhlDH81w8McWcKK0eqzxc4GlVdLlv2qDe1OeKOXjt070SVb9vQkeSsb
	r7eoxkWBjN/Y2VkxGBAObuPcGW1ahWhF4nJrDUG2q+4q0CpuyJESEUuR/OEzy2kU5uahBN1/enkWm
	V8ol8TU0W94CveDok3MCm/pPugymO9fA+BbZlrXSKt2gqKihum3B5nnrqc5HO9HbB+mKXz5PGI+7I
	QllVxQdA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx8n9-00000003LNk-2Z3h;
	Wed, 17 Apr 2024 17:09:52 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 07/10] ntfs3: Convert reading $AttrDef to use folios
Date: Wed, 17 Apr 2024 18:09:35 +0100
Message-ID: <20240417170941.797116-8-willy@infradead.org>
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

This is now large folio safe, although we're not enabling
large folios yet.  It does eliminate a use of kmap().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ntfs3/super.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 71dfeb0c4323..f6a9ab0f5cad 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -1429,18 +1429,22 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 		goto put_inode_out;
 	}
 
-	for (done = idx = 0; done < bytes; done += PAGE_SIZE, idx++) {
+	done = idx = 0;
+	while (done < bytes) {
 		unsigned long tail = bytes - done;
-		struct page *page = ntfs_map_page(inode->i_mapping, idx);
+		struct folio *folio = read_mapping_folio(inode->i_mapping,
+				idx, NULL);
 
-		if (IS_ERR(page)) {
-			err = PTR_ERR(page);
+		if (IS_ERR(folio)) {
+			err = PTR_ERR(folio);
 			ntfs_err(sb, "Failed to read $AttrDef (%d).", err);
 			goto put_inode_out;
 		}
-		memcpy(Add2Ptr(t, done), page_address(page),
-		       min(PAGE_SIZE, tail));
-		ntfs_unmap_page(page);
+		memcpy_from_folio(Add2Ptr(t, done), folio, 0,
+				min(tail, folio_size(folio)));
+		done += folio_size(folio);
+		idx += folio_nr_pages(folio);
+		folio_put(folio);
 
 		if (!idx && ATTR_STD != t->type) {
 			ntfs_err(sb, "$AttrDef is corrupted.");
-- 
2.43.0


