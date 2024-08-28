Return-Path: <linux-fsdevel+bounces-27657-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA2A9633B2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 23:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CF1BB2207C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 21:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81B11AD9DB;
	Wed, 28 Aug 2024 21:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="fqtKtSsI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92351AD9D5
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 21:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724879698; cv=none; b=q6Bl7hyoQ4ki1EosAAsf21IO4p6dX6QpVlIMYvL3f9UtDnqTVvgmT35FYYFZYe1noaTZx2j+5dHhQzY+GxTOmnWhYrTMsUyTtZQthvqAZ1gDmpsAWqKXQpCRKjv12zJRZFq6lcjFT1e77vO9kEkBFuuGIrqPMJAAuOz/S0Mjek0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724879698; c=relaxed/simple;
	bh=X0DApJFK7Z5eoBilBYIivvWd5ORVAHNlmLt50Lda20s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lfuMYA/cwObg84CsLK5qJ1lFWMuM4TzIAFGrPPvY6OMa9bRFzQBBolYJfCwjPk9FTUkWagge3kT0M2FmayhIFHA5RgHd+g6+8e/EGHczdALdq0Psi/KWpeL2jgDr4ddUBSPdrspEVjO1Eds1x5VfFcCE84A5XD8BN3Ii32pl6rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=fqtKtSsI; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-844c333b03bso3022241.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 14:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724879695; x=1725484495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mQ15t9uWlNPdfkJDsR4E1Urv+RYku/UF4TJezYHI1D8=;
        b=fqtKtSsIyxAxHLVq3RPOvT0cnLDRdKw04eZafgPfR4wA+H+4N8ehl9ebpLnlHAU77E
         oRK0RVJqxYeT3P+B4h32shAbltLGguTAOarlaeJh6XK/o1tOXsKd3jbGU4XKuqbguhr2
         flXhDAqYwxdOBcx4tKn1S7XKY2+N9eMzpvOFu3vhybBlQ3Yt8C2x936zxlvEMmMOLiSW
         JAEIDPubVjIakH9XYRldRKSjLXnhYOIvLU6wnZrxzuyVCQdtFS+w6s2FbJKzqrrHYkYI
         lD87cZ5hATxwhMI2U9aB6LfA9+KxVnOHz8W24Bkn9sLu5ccpe6r/FmPRY8Eqq5fVPO6Z
         8JMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724879695; x=1725484495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mQ15t9uWlNPdfkJDsR4E1Urv+RYku/UF4TJezYHI1D8=;
        b=tze+H+ACTXhX3CubQH4KowtqcRQRHHrfhd8HI80o1Ngdew+JYOtvWcizusow7HIt49
         Z4DINW3IuyzHL6Rkt826gSkIBv3BiGzIw1ByE6Tg7BoeMck17sLalpccI8TtyZE8CnM9
         1MalGJV0ayx/r5CGiMSwFqBcGIikehWnQaSgcWUvGL2o2bWdmYlg4xaH46A7I2XYYNe/
         wFqDqGgN/quBLa3MtudRvSjgXH6k4zWEolZgJB1nbbePLBX+xDnAsdbv+UQOqL09eLhY
         dBJVQZEPUpFeNiryLCnZPeHLJ1bCFvRbVXME+N+6axsmtdFjQx0hQ9ZvqglCD52aR9Hm
         rekg==
X-Gm-Message-State: AOJu0Yzh2vkCAZEfrrlPdghJYR7g/7bClIWkoOCIPT1iCWI5eO8GVuTt
	bwaIyw9sGCgaweufyjWyDku1BzW6FO0TKK0wME3gNYrz9mrPiZ0hMkewyb9vkgVZJO6gENPyB6c
	d
X-Google-Smtp-Source: AGHT+IFkhV/basfN1i49vA2sQlF653aznbM7x+swturFUn1MRyd0UAYuYiIbhR9jqEeU27fdmZPrIQ==
X-Received: by 2002:a05:6102:f10:b0:498:c2cd:1ac5 with SMTP id ada2fe7eead31-49a5ae3a057mr1247859137.9.1724879695365;
        Wed, 28 Aug 2024 14:14:55 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162d20f07sm68345536d6.26.2024.08.28.14.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 14:14:54 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com,
	miklos@szeredi.hu,
	joannelkoong@gmail.com,
	bschubert@ddn.com,
	willy@infradead.org
Subject: [PATCH v2 11/11] fuse: convert fuse_notify_store to use folios
Date: Wed, 28 Aug 2024 17:14:01 -0400
Message-ID: <f8c9005a66ee69c1e373d7e8a64c120683dcb0d4.1724879414.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1724879414.git.josef@toxicpanda.com>
References: <cover.1724879414.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This function creates pages in an inode and copies data into them,
update the function to use a folio instead of a page, and use the
appropriate folio helpers.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fuse/dev.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index bcce75e07678..eeb5cea4b7e4 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1607,24 +1607,28 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
 
 	num = outarg.size;
 	while (num) {
+		struct folio *folio;
 		struct page *page;
 		unsigned int this_num;
 
-		err = -ENOMEM;
-		page = find_or_create_page(mapping, index,
-					   mapping_gfp_mask(mapping));
-		if (!page)
+		folio = __filemap_get_folio(mapping, index,
+					    FGP_LOCK|FGP_ACCESSED|FGP_CREAT,
+					    mapping_gfp_mask(mapping));
+		if (IS_ERR(folio)) {
+			err = PTR_ERR(folio);
 			goto out_iput;
-
-		this_num = min_t(unsigned, num, PAGE_SIZE - offset);
-		err = fuse_copy_page(cs, &page, offset, this_num, 0);
-		if (!PageUptodate(page) && !err && offset == 0 &&
-		    (this_num == PAGE_SIZE || file_size == end)) {
-			zero_user_segment(page, this_num, PAGE_SIZE);
-			SetPageUptodate(page);
 		}
-		unlock_page(page);
-		put_page(page);
+
+		page = &folio->page;
+		this_num = min_t(unsigned, num, folio_size(folio) - offset);
+		err = fuse_copy_page(cs, &page, offset, this_num, 0);
+		if (!folio_test_uptodate(folio) && !err && offset == 0 &&
+		    (this_num == folio_size(folio) || file_size == end)) {
+			folio_zero_range(folio, this_num, folio_size(folio));
+			folio_mark_uptodate(folio);
+		}
+		folio_unlock(folio);
+		folio_put(folio);
 
 		if (err)
 			goto out_iput;
-- 
2.43.0


