Return-Path: <linux-fsdevel+bounces-27649-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BDE9633AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 23:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B97C1F23263
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 21:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141841AC447;
	Wed, 28 Aug 2024 21:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="RWwJM0ek"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8B61AC429
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 21:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724879686; cv=none; b=PdvU/CcowJQuXAartsK1jycfO3NVdSYHugtnYi1VPRKPxR9mve2WU979/UjAcywTyUbPprWq3xb2y4zArcaZcaHQ6iK+3fETobp2jn0QCMfMfpmCXGdm4W02zYudVt+nlxls/8e7kGwh/wsMEbNuz4MIMIXw02ZE2zHeOpupzcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724879686; c=relaxed/simple;
	bh=F49A7krWFoimk3w+If7pTG08lS3KZ/Ht+3AzohNhokQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BKNxK9SZZfhzT65Q5sfOjD+XrnykhoomPa6uMCW7buxDxxmLNBe57ad9Mk6AgYeewJKB2sx13b7+1PcPLSeZk9eksMIDi5Vhq77txAeONspftfc7+/zNgIEyah5XbDv1bXZkgFZSdYojAySbxPb3a3yNdPywScS/LCmucCN/IkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=RWwJM0ek; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6bf9db9740aso32066836d6.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 14:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724879683; x=1725484483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=snmcu8eKXQ5sijqek9QxKjvkksZ3ghfNCeeEaNxDCDk=;
        b=RWwJM0ekx1T3h7dcf72fhKIux65NsqLIrppuU8iPCS2alQk4o6RWQeSQrTkVuZWIuk
         ZmqTnovGE78/hWKKlIvkjH3o9QyyBLXODWBUz00IxBU+LoWhwa13ZTNT3MEizmPM8Adh
         3D9uxfjxFwao4HyIILVsYkksaSsahZwb1u5j1Eaia5tv+LEUUjhxgAbfydijmBmiJtmG
         MkExhL4v4F6W9DS3e4F6kJ9i2Q4a07+qjimGxFcQ0kqtR3h1N5ytGF4PlM03BtnmJ0L7
         PeMlHe5cJ94tsQmAxZnqo7qCYnO+xokEdbPUf2VaI2Z4G7Dn1kGkFurVG7gv7xb9yJ9u
         awWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724879683; x=1725484483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=snmcu8eKXQ5sijqek9QxKjvkksZ3ghfNCeeEaNxDCDk=;
        b=ZJxkzw6odUFKWzJAQ6Gavl+W2q5M154yrzeRj7UIlZuTeN1qV87TL4+HnNQyXaC5JM
         ZtmQUrPDhO6XcjAH/2N/YI1ASPVBB/vh+/APlluwzdmm/GNuQ7sFfc+TQgVOtHBqfCkw
         PUBg4FBheIUDx3mGKLLIZt/X58WzSJrA/VTcSeO0UnknigYaT3ci05s95B41OySaFkOi
         l2xYBT0MjHP4OXflU+5p2f+r6Zcx2JMROs88ibhlDARmxb4Wa2S+J7NZkTeTGt9+IH8K
         pRlc+0frWXk+9kuJfEXikW5/SVV/1JMefQGFu5hHj9JOfsdFG56oJpamWRcGEiJofa/P
         Ih9w==
X-Gm-Message-State: AOJu0YwAUgxf6+RLt+DRzIO5hAhOrMqctDXsl0zj3Nfe38Jy6fVlFInD
	zD5PFm46D8oN3e1pulxrgE+V17+XprZl7DoWBRFJSOm8IqhG/F8hxHyTU6aDYCPzaF7HyL2RGAo
	b
X-Google-Smtp-Source: AGHT+IH7FwjmQiE2dhccr8Qbs/jL35RdivTELcfA88CXADM3LBAVKUSsqDCsyFRfRRYPBqEeeQNjlQ==
X-Received: by 2002:a05:6214:5f0b:b0:6b5:9439:f048 with SMTP id 6a1803df08f44-6c33e62759dmr8345146d6.19.1724879683592;
        Wed, 28 Aug 2024 14:14:43 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162d1d696sm69064976d6.13.2024.08.28.14.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 14:14:43 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com,
	miklos@szeredi.hu,
	joannelkoong@gmail.com,
	bschubert@ddn.com,
	willy@infradead.org
Subject: [PATCH v2 03/11] fuse: convert fuse_fill_write_pages to use folios
Date: Wed, 28 Aug 2024 17:13:53 -0400
Message-ID: <dedbbd18a94cb969f0ea9cc7d003de8f78296d5c.1724879414.git.josef@toxicpanda.com>
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

Convert this to grab the folio directly, and update all the helpers to
use the folio related functions.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fuse/file.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 275af3a7c50b..08fc44419f01 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1206,7 +1206,7 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 
 	do {
 		size_t tmp;
-		struct page *page;
+		struct folio *folio;
 		pgoff_t index = pos >> PAGE_SHIFT;
 		size_t bytes = min_t(size_t, PAGE_SIZE - offset,
 				     iov_iter_count(ii));
@@ -1218,25 +1218,27 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 		if (fault_in_iov_iter_readable(ii, bytes))
 			break;
 
-		err = -ENOMEM;
-		page = grab_cache_page_write_begin(mapping, index);
-		if (!page)
+		folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
+					    mapping_gfp_mask(mapping));
+		if (IS_ERR(folio)) {
+			err = PTR_ERR(folio);
 			break;
+		}
 
 		if (mapping_writably_mapped(mapping))
-			flush_dcache_page(page);
+			flush_dcache_folio(folio);
 
-		tmp = copy_page_from_iter_atomic(page, offset, bytes, ii);
-		flush_dcache_page(page);
+		tmp = copy_folio_from_iter_atomic(folio, offset, bytes, ii);
+		flush_dcache_folio(folio);
 
 		if (!tmp) {
-			unlock_page(page);
-			put_page(page);
+			folio_unlock(folio);
+			folio_put(folio);
 			goto again;
 		}
 
 		err = 0;
-		ap->pages[ap->num_pages] = page;
+		ap->pages[ap->num_pages] = &folio->page;
 		ap->descs[ap->num_pages].length = tmp;
 		ap->num_pages++;
 
@@ -1248,10 +1250,10 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 
 		/* If we copied full page, mark it uptodate */
 		if (tmp == PAGE_SIZE)
-			SetPageUptodate(page);
+			folio_mark_uptodate(folio);
 
-		if (PageUptodate(page)) {
-			unlock_page(page);
+		if (folio_test_uptodate(folio)) {
+			folio_unlock(folio);
 		} else {
 			ia->write.page_locked = true;
 			break;
-- 
2.43.0


