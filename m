Return-Path: <linux-fsdevel+bounces-48322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F004AAAD4FC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 07:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F27AC984D2D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 05:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594881DF24F;
	Wed,  7 May 2025 05:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L5pbCRap"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EBD27726;
	Wed,  7 May 2025 05:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746595021; cv=none; b=jmS5di9WejcUvvHMdsCzhKSbvIYd9iGpwKObx4JtswvIkSSj5CATifZGDk7xB2Hm/iCpSAsjlE8B4GrT1+HAkwlyqz7JfYcCpJra9orWo8CJYqkOcJB2U3eKFDXdrIg2lZG1/yuVnRUlT8xjsVlbIBf/UIS6azfVx57wZtd0HuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746595021; c=relaxed/simple;
	bh=cyiNYAkaoP6KbT11OpjJCnXCYx6t0Ih55Xbg9TE7zJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NtQgpBSwZrPUYtk9jci2dF2XLwPy06S+yEl7bcvptuEeC57LXRSZWqAmLJWomZr6AtCZNXQwtHBRRg64hNst7lSo/8Wft5Fvhyfb28i8gFxg9nCsmrFpMrMQwjeOzTWhuSRCTS1ikCRm8cSnvOAv9BTkyI6K/RJ/slIwkEawDLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=L5pbCRap; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=o/Ou+Hidj9xU0O3E9pkms4lLkc6uuKm7e3/PItzKl3o=; b=L5pbCRaplDtRNihR1RgNK41N5D
	sxh13oD/MuWWEzIUut4x08sttQzdpLFtIeBEJQda4YeVmuSlheMhP81Zd56panqTnJOcYLWZluh0G
	iuYTyByU4El+hZhvBjq0E3TInHtkAxleoBiuP9wpLG6hbD1NEURHSQguhnRZfhGn/yZ1cnTS5wYJF
	JaT0Nmukeah53Uf0ycHyaGMd8rpObzBsJbrQ9zhNEjxQp6oC0b0HLsDqcr3W6nMgQUBG6dua6JpR5
	/p+HlpjVfss+bDNykIZqLQM2M4IGNWntGVo+QRpfKoPQXzU00F5TIz/ArjQSmMwSgVjwjVOZqigoF
	m6chQ0gw==;
Received: from 2a02-8389-2341-5b80-3ba7-83fe-7065-4f0b.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:3ba7:83fe:7065:4f0b] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCX9P-0000000EFR9-2Gtj;
	Wed, 07 May 2025 05:17:00 +0000
From: Christoph Hellwig <hch@lst.de>
To: willy@infradead.org
Cc: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2] xarray: fix kerneldoc for __xa_cmpxchg
Date: Wed,  7 May 2025 07:16:20 +0200
Message-ID: <20250507051656.3900864-1-hch@lst.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Fix the documentation for __xa_cmpxchg to actually describe the
cmpxch-like semantics correctly, based on the version for xa_cmpxchg.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---

Changes since v1:
 - and now the version with my fold patch actually folded in to make
   it compile after the copy and paste.  Sigh.

 lib/xarray.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/lib/xarray.c b/lib/xarray.c
index 9644b18af18d..76dde3a1cacf 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -1742,20 +1742,23 @@ static inline void *__xa_cmpxchg_raw(struct xarray *xa, unsigned long index,
 			void *old, void *entry, gfp_t gfp);
 
 /**
- * __xa_cmpxchg() - Store this entry in the XArray.
+ * __xa_cmpxchg() - Conditionally replace an entry in the XArray.
  * @xa: XArray.
  * @index: Index into array.
  * @old: Old value to test against.
- * @entry: New entry.
+ * @entry: New value to place in array.
  * @gfp: Memory allocation flags.
  *
  * You must already be holding the xa_lock when calling this function.
  * It will drop the lock if needed to allocate memory, and then reacquire
  * it afterwards.
  *
+ * If the entry at @index is the same as @old, replace it with @entry.
+ * If the return value is equal to @old, then the exchange was successful.
+ *
  * Context: Any context.  Expects xa_lock to be held on entry.  May
  * release and reacquire xa_lock if @gfp flags permit.
- * Return: The old entry at this index or xa_err() if an error happened.
+ * Return: The old value at this index or xa_err() if an error happened.
  */
 void *__xa_cmpxchg(struct xarray *xa, unsigned long index,
 			void *old, void *entry, gfp_t gfp)
-- 
2.47.2


