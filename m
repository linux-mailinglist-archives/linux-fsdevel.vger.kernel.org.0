Return-Path: <linux-fsdevel+bounces-41628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DE5A3379D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 06:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48B2E167B97
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 05:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CC2207657;
	Thu, 13 Feb 2025 05:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HjOh95ZJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011B4207670;
	Thu, 13 Feb 2025 05:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739426185; cv=none; b=HqJZzbk9Zf5BRPfkTYktUNH4bPCVgLEUCfbB+ayoIVxCLQ4ma386yg53fQsyK6tRlRaWeJAlO4bmLe7B0eA9u3mTPE/250/OaZytCqWM8iMyhy7CdC2MK4uoYTDmifikHHY7ijeiKqKkvji1+DOLaqKOqESgnOpRzV4tafwxiMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739426185; c=relaxed/simple;
	bh=/ctVPI1RMkXy1FiC9qg/UhR+kvm9gPz3ywgM1bFQm8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a8k+upjJC16KBN9a78LYBAcr171NSZR/zL1djPUC9/Ad/ujP2S4MWCpP0zZ3l5wh+YTQPyRJOzeTtBN7Oe/w/uhjPAK7u5s0AB9dzbFPJLG1wq7SPHFa1Xu+e7HaR0MAjnlWT+b75Nx2xeSAm3P8xJvauTfW9HA8LsxxZLDxqZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HjOh95ZJ; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739426173; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=rASHGD09VIAcvDVE/Y5zG8ZXrXsg0FttXsa+JAeYPMY=;
	b=HjOh95ZJu9C0fD6ebAJkjFfWYE9CguTlClzZqHOZcehz5kwg0EVc5RTlbxrl0ZLJ4vqyTKJh3EOkcsu52xGL/IUyvaxc/R8+Mr7xWpRgIM72LwQ8V4uYGO22RHpNbHkeaGe7qWYDlt4j8w9Tpu3ffVWRPdxiaxNMqDMDPZUSq9w=
Received: from localhost(mailfrom:guanjun@linux.alibaba.com fp:SMTPD_---0WPMKlTX_1739426172 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 13 Feb 2025 13:56:12 +0800
From: 'Guanjun' <guanjun@linux.alibaba.com>
To: willy@infradead.org,
	akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: guanjun@linux.alibaba.com
Subject: [PATCH mm 1/1] filemap: Remove redundant folio_test_large check in filemap_free_folio
Date: Thu, 13 Feb 2025 13:56:12 +0800
Message-ID: <20250213055612.490993-1-guanjun@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guanjun <guanjun@linux.alibaba.com>

The folio_test_large check in filemap_free_folio is unnecessary because
folio_nr_pages, which is called internally, already performs this check.
Removing the redundant condition simplifies the code and avoids double
validation.

This change improves code readability and reduces unnecessary operations
in the folio freeing path.

Signed-off-by: Guanjun <guanjun@linux.alibaba.com>
---
 mm/filemap.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 804d7365680c..2b860b59a521 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -227,15 +227,12 @@ void __filemap_remove_folio(struct folio *folio, void *shadow)
 void filemap_free_folio(struct address_space *mapping, struct folio *folio)
 {
 	void (*free_folio)(struct folio *);
-	int refs = 1;
 
 	free_folio = mapping->a_ops->free_folio;
 	if (free_folio)
 		free_folio(folio);
 
-	if (folio_test_large(folio))
-		refs = folio_nr_pages(folio);
-	folio_put_refs(folio, refs);
+	folio_put_refs(folio, folio_nr_pages(folio));
 }
 
 /**
-- 
2.43.5


