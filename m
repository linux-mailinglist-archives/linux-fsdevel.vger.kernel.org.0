Return-Path: <linux-fsdevel+bounces-17181-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3108E8A89F9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 19:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5AC21F226EB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 17:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C090171640;
	Wed, 17 Apr 2024 17:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wGxSJXSO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789DB172BA8;
	Wed, 17 Apr 2024 17:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713373795; cv=none; b=qk+mIBYWrTj0Hw4DkdMpCR8wjpoPNj24RB/MBsXd91OBwjMPVUNYGw14vedfo0fMf42iOBvqRwfcZ5cSFN8KYTdLdvcX/RuXVtQ5P2C76gklVx+sGwXkk26cUuqsxlkwaJB6FM8AMOw8pGvpVvHl7ND+88jgY+t9Dj23dUIw16Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713373795; c=relaxed/simple;
	bh=IsgfukMEwJW9jhqCmijzm0Xn8L9yo1SpFpxIm0dhqIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nitdmjx7mvUAWJtAGYQbAE9vzwhhIBjqGGSN6gMZyqh2IvbNEmUFqx3XwvLvSS3dwv+H6e5fdGkls2/4YIRYziKHukVcvOuHftvbDKvZP0NSzX0BTSAcoxN6Pd9M+E+Aaizg5xM17DBbE1ROPIM8wX3azkYFyzwESmXW+e1lj/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wGxSJXSO; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=sVLC2SOQAmPn3AChIpktUkfkcZacBQhX9T6iZ3X49dw=; b=wGxSJXSOGxb7ow+NiJGvKONh3s
	0n4bEC3355TGPgFtN5HQX0ri6WwWKTI5xek/APzDRZZPQnuhTzZGx64Zr++JKB2f6M7PSkZRb8/9T
	JQih9FMPY2cAhtNvjMRebOiXudwawExikjuNQPdKj+7qmftk/pzCv6uVcFTc1Bnm3fo5f4808ByES
	F8O/G7mmAu7nkkbQfJ/SFNv37RqIuJSyxl7FCZ7CKTE0ucs21vvr2OVTDziwpKCeaTkHYp0a6WF1A
	ONBHHZdTF3qJxrz6Wzg2zQPnjTHNPky7Ww9ZIKra9Xybaji5V50hgCrhv2+lsqq9r7zXPPPXvHVhi
	tNmSSL1A==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx8nA-00000003LNq-15py;
	Wed, 17 Apr 2024 17:09:52 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 08/10] ntfs3: Use a folio to read UpCase
Date: Wed, 17 Apr 2024 18:09:36 +0100
Message-ID: <20240417170941.797116-9-willy@infradead.org>
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

Add a memcpy_from_folio_le16() which does the byteswapping.
This is now large folio safe and avoids kmap().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ntfs3/super.c        | 25 +++++++++++--------------
 include/linux/highmem.h | 31 +++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 14 deletions(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index f6a9ab0f5cad..00700598a717 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -1493,26 +1493,23 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 		goto put_inode_out;
 	}
 
-	for (idx = 0; idx < (0x10000 * sizeof(short) >> PAGE_SHIFT); idx++) {
-		const __le16 *src;
+	idx = 0;
+	while (idx < (0x10000 * sizeof(u16) >> PAGE_SHIFT)) {
 		u16 *dst = Add2Ptr(sbi->upcase, idx << PAGE_SHIFT);
-		struct page *page = ntfs_map_page(inode->i_mapping, idx);
+		struct folio *folio = read_mapping_folio(inode->i_mapping,
+				idx, NULL);
+		size_t limit = 0x10000 * sizeof(u16) - idx * PAGE_SIZE;
 
-		if (IS_ERR(page)) {
-			err = PTR_ERR(page);
+		if (IS_ERR(folio)) {
+			err = PTR_ERR(folio);
 			ntfs_err(sb, "Failed to read $UpCase (%d).", err);
 			goto put_inode_out;
 		}
 
-		src = page_address(page);
-
-#ifdef __BIG_ENDIAN
-		for (i = 0; i < PAGE_SIZE / sizeof(u16); i++)
-			*dst++ = le16_to_cpu(*src++);
-#else
-		memcpy(dst, src, PAGE_SIZE);
-#endif
-		ntfs_unmap_page(page);
+		memcpy_from_folio_le16(dst, folio, 0,
+				min(limit, folio_size(folio)));
+		idx += folio_nr_pages(folio);
+		folio_put(folio);
 	}
 
 	shared = ntfs_set_shared(sbi->upcase, 0x10000 * sizeof(short));
diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 00341b56d291..20b5d5a5feaf 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -467,6 +467,37 @@ static inline void memcpy_from_folio(char *to, struct folio *folio,
 	} while (len > 0);
 }
 
+#ifdef __BIG_ENDIAN
+static inline void memcpy_from_folio_le16(u16 *to, struct folio *folio,
+		size_t offset, size_t len)
+{
+	VM_BUG_ON(offset + len > folio_size(folio));
+
+	do {
+		const __le16 *from = kmap_local_folio(folio, offset);
+		size_t chunk = len;
+
+		if (folio_test_highmem(folio) &&
+		    chunk > PAGE_SIZE - offset_in_page(offset))
+			chunk = PAGE_SIZE - offset_in_page(offset);
+
+		for (i = 0; i < chunk / sizeof(*to); i++)
+			*to++ = le16_to_cpu(*from++);
+		kunmap_local(from);
+
+		to += chunk / sizeof(*to);
+		offset += chunk;
+		len -= chunk;
+	} while (len > 0);
+}
+#else
+static inline void memcpy_from_folio_le16(u16 *to, struct folio *folio,
+		size_t offset, size_t len)
+{
+	memcpy_from_folio((char *)to, folio, offset, len);
+}
+#endif
+
 /**
  * memcpy_to_folio - Copy a range of bytes to a folio.
  * @folio: The folio to write to.
-- 
2.43.0


