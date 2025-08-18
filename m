Return-Path: <linux-fsdevel+bounces-58120-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 828A0B2996C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 08:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC9497A925D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 06:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBB4272E5D;
	Mon, 18 Aug 2025 06:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Tlbmw4vQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056CE272803;
	Mon, 18 Aug 2025 06:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755497425; cv=none; b=A+PIZ+z4UuRQCxo2NWfk4ARQu9Bgxq+r5oNFc/E4u1ZHbC6cn2tM1ova6+uFFbtg/j+iGvILevw2LTYYmfjXuhYyN6Dw7KjReHbauv/0t+d2CQi0HhId5yVJaeZpd2NHHDM8OkCXwm+EYFhjscL96NZpo3WBUM0ttSWOdhxmDmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755497425; c=relaxed/simple;
	bh=lEyCN2VwpElardVxVNro7Ptbb5PNqKjNzjphw/UahGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g3+MfGHUGo2HTISdlomAKslqJwXROeP645BqIZnvgdV+c5UYBFBihEPdP/KuF3hJTRy2FG1DOh9MiNTrhKCssEypVs6jbZUfd6cR6hHg1/15DFUcm5Q9J4k92fFUBtmzzgr8BYmDMDa0wstgetzP71VLALKyBKnFGZ2bbvHJkoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Tlbmw4vQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=aeSQ7eBoZowddy0LRvxIFt8h4KXKJcQQ/6taewzmG9s=; b=Tlbmw4vQOEVbufkCIs65ZnEobQ
	8vsNebYv1ST3EvpCMTvJZci/y5eE4S7imFHUKIIiMRLFnnfKqzpI+21jeBuYUrd8lBJP5N/PMXhgI
	U+SEm11/BPwWQhuS7iEIVlAelxVfNBytm3gY43MUqGKnG+mtok6l1P/C+WumwHktgT7R79+/z/qSf
	qTWD52sEDjHRbu4VI2qOFXaagsOOFm/SU/xnIx9CU9yv8omuRZyEkAi4wgkmy3yse95fLW9KqhZxL
	IK5eH+UfP1swn2IYqNBUM0TJ2Rx5u8EZOOcB01LkVuou8WhX9nfs0a5y9q8vi0ciMLU/h4sM+kgGA
	sfgNy8Dg==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unt4Y-00000006bmO-3TjI;
	Mon, 18 Aug 2025 06:10:23 +0000
From: Christoph Hellwig <hch@lst.de>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	linux-bcachefs@vger.kernel.org,
	ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/3] ntfs3: stop using write_cache_pages
Date: Mon, 18 Aug 2025 08:10:08 +0200
Message-ID: <20250818061017.1526853-2-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250818061017.1526853-1-hch@lst.de>
References: <20250818061017.1526853-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Stop using the obsolete write_cache_pages and use writeback_iter directly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/ntfs3/inode.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 37cbbee7fa58..48b4f73a93ee 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -871,9 +871,9 @@ int ntfs_set_size(struct inode *inode, u64 new_size)
 }
 
 static int ntfs_resident_writepage(struct folio *folio,
-				   struct writeback_control *wbc, void *data)
+				   struct writeback_control *wbc)
 {
-	struct address_space *mapping = data;
+	struct address_space *mapping = folio->mapping;
 	struct inode *inode = mapping->host;
 	struct ntfs_inode *ni = ntfs_i(inode);
 	int ret;
@@ -907,9 +907,14 @@ static int ntfs_writepages(struct address_space *mapping,
 	if (unlikely(ntfs3_forced_shutdown(inode->i_sb)))
 		return -EIO;
 
-	if (is_resident(ntfs_i(inode)))
-		return write_cache_pages(mapping, wbc, ntfs_resident_writepage,
-					 mapping);
+	if (is_resident(ntfs_i(inode))) {
+		struct folio *folio = NULL;
+		int error;
+
+		while ((folio = writeback_iter(mapping, wbc, folio, &error)))
+			error = ntfs_resident_writepage(folio, wbc);
+		return error;
+	}
 	return mpage_writepages(mapping, wbc, ntfs_get_block);
 }
 
-- 
2.47.2


