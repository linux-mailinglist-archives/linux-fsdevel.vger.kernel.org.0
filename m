Return-Path: <linux-fsdevel+bounces-48785-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2534AB47C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 01:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F2957A9D0F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 22:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C5E29A9F8;
	Mon, 12 May 2025 22:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6B7Owbz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED52729A9C2
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 22:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747090784; cv=none; b=mmpQuCKZVrQ369DPPH18r4j7N8rZFUPq6POYeCfS6c3INCGFMqNYdyghMzwppKX/4+LgaGh8U+GqAvlkhpNa8GIGsOuOmMaV/vLDAdKfjWPdXI7cDTiyHTRgn1q4P6X1xY2ANGwSOcMTDIqGAEwsveiJkDw0yWUrCcJN3dCtaGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747090784; c=relaxed/simple;
	bh=GpphkWlJcSX/BgQ8GWm7RnjSh0p21sQzl14FiROV5wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TgYhMlp+Fwaiu7+l5rGGq51up8BWF3TG0FcZFNUR91uZlG+O5XwDzC2kryDvDY9E6HydIRAktcF7poUfU3AIBoZ9UJpcAr4lynWnbEn1hLl0J3eceNTC5MAoKTNa4QGS/eK2cZ4IzRgUJkPquunapAkoh33NJn1+CkdLsQG2aLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6B7Owbz; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-72d3b48d2ffso5117138b3a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 15:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747090782; x=1747695582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BUHH27OEHnjht0WdPNISwFE+AjdSf/dMLSagjBI21Uk=;
        b=P6B7Owbztv31O9wyZQUXl4wp4rVYqPky6jKNylpeXKEcsaEF5ipoc9YU7/5aODUq/d
         QgjRN3u70OPEBWSeX9T3o7nj1AfA0WGcbeJ/fDHiWzp3NYQEs4iV228egCz2TV+qXLro
         EHTwUoSFlj52jrR5Fncr/PS/xMvk2iB8Eu0LCpqZvF8wmJUm2Bnr23mzq8KvO7ZkEE3/
         szNWdyFpseXPdwgq2UkTFgGDbAhteIWqxfnXRATlMxOfCVxMZKcV8xMLJF81wygxC2Kf
         ATWrtKmXY4j2NCgDjzaeuhItYR7U/fYNb6jf7Amt8xIluI4eTklJ/ifElE2ORAaSoX0s
         L4bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747090782; x=1747695582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BUHH27OEHnjht0WdPNISwFE+AjdSf/dMLSagjBI21Uk=;
        b=h+DHfl9HGGeH6cPcrx0cwN+RPkLZJMv/xopIZcL5lxTDFuKaUug7KHC02V7UxszC1B
         z/Pu2hPKGAOoCB1t9eaQQAllgGdvEC3B8M9/epYIq/El4/B8w+FmZqO6yFc2Bb2pjidh
         FBVVR8TnUtpQ+fWqQ+zKnv8tjHOllBQ2fsxv7Gx713Zf7rC5fOgBMsguDIBJHkm3btYZ
         Reg9M0fcp3WAgIhg5B+DkbW6OtoOvCQ8jRylteqmdhuKa9ZLJBzfH+/hqj8iYSiuFDQC
         5SUUg3s5jFk0rNjUcE9L0+BxqzDvrxQEWddgm2Qc/Q2w05jnc9P0fCu38O3KufSDoV3N
         PenQ==
X-Gm-Message-State: AOJu0YyHxoaico1TpWf0+n3UJs2GIVJ7xeWr1B7B5RoxSly/TuD7EJ6Y
	tMWHZknICCVdiKzOSUyi9Afda6GHnwW4n/cQGtKMjxwaA67sUQlzZ4GoNA==
X-Gm-Gg: ASbGnctpXM+20GtIOZmuchNu1II7G1Ft10Xwne3Gz8LESbtRPzPtUA4nBklLjn2qT6r
	Q9fuGGuQ7GAkLmTHe0aYBPKt/62MfTuDPal8tVIzaE2SXqLQYxrWopMCB9qv0BV0Em1ANKSNskG
	pRAq9cXMm89ZHCf5NnbjmGv+bjV/vczRMXuBq5tGRXb+W0UXO7qQyFPTeWZ3PW2IifqhgotsWUT
	sKzjGmQoYEa7XEPdqejhRlZYCL4N9oBluSlK+E9dzdbq4i9MBe5mETHfMqa025mR6Av+i60JZWr
	FV2YoyNx0nTN8er+LOa/W7yiR62n/9sUHesUgZO0YwDPGkoqRZOgClPxmw==
X-Google-Smtp-Source: AGHT+IHOCTTT2ovNbcLwEFigTF1D2YuverPX9Yce8MFDvrGf0yYrqlwnpjyCGQYqOXlGc68RIdNDpw==
X-Received: by 2002:a05:6a00:3e28:b0:736:51ab:7aed with SMTP id d2e1a72fcca58-7423c040e1fmr19241433b3a.16.1747090782024;
        Mon, 12 May 2025 15:59:42 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:40::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237a0cf76sm6562173b3a.86.2025.05.12.15.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 15:59:41 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	bernd.schubert@fastmail.fm,
	jlayton@kernel.org,
	jefflexu@linux.alibaba.com,
	josef@toxicpanda.com,
	willy@infradead.org,
	kernel-team@meta.com,
	Bernd Schubert <bschubert@ddn.com>
Subject: [PATCH v6 10/11] fuse: optimize direct io large folios processing
Date: Mon, 12 May 2025 15:58:39 -0700
Message-ID: <20250512225840.826249-11-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512225840.826249-1-joannelkoong@gmail.com>
References: <20250512225840.826249-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Optimize processing folios larger than one page size for the direct io
case. If contiguous pages are part of the same folio, collate the
processing instead of processing each page in the folio separately.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/file.c | 55 +++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 41 insertions(+), 14 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 07ff81469a59..e4d86ced9aac 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1491,7 +1491,8 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
 	}
 
 	while (nbytes < *nbytesp && nr_pages < max_pages) {
-		unsigned nfolios, i;
+		struct folio *prev_folio = NULL;
+		unsigned npages, i;
 		size_t start;
 
 		ret = iov_iter_extract_pages(ii, &pages,
@@ -1503,23 +1504,49 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
 
 		nbytes += ret;
 
-		nfolios = DIV_ROUND_UP(ret + start, PAGE_SIZE);
+		npages = DIV_ROUND_UP(ret + start, PAGE_SIZE);
 
-		for (i = 0; i < nfolios; i++) {
-			struct folio *folio = page_folio(pages[i]);
-			unsigned int offset = start +
-				(folio_page_idx(folio, pages[i]) << PAGE_SHIFT);
-			unsigned int len = min_t(unsigned int, ret, PAGE_SIZE - start);
+		/*
+		 * We must check each extracted page. We can't assume every page
+		 * in a large folio is used. For example, userspace may mmap() a
+		 * file PROT_WRITE, MAP_PRIVATE, and then store to the middle of
+		 * a large folio, in which case the extracted pages could be
+		 *
+		 * folio A page 0
+		 * folio A page 1
+		 * folio B page 0
+		 * folio A page 3
+		 *
+		 * where folio A belongs to the file and folio B is an anonymous
+		 * COW page.
+		 */
+		for (i = 0; i < npages && ret; i++) {
+			struct folio *folio;
+			unsigned int offset;
+			unsigned int len;
+
+			WARN_ON(!pages[i]);
+			folio = page_folio(pages[i]);
+
+			len = min_t(unsigned int, ret, PAGE_SIZE - start);
+
+			if (folio == prev_folio && pages[i] != pages[i - 1]) {
+				WARN_ON(ap->folios[ap->num_folios - 1] != folio);
+				ap->descs[ap->num_folios - 1].length += len;
+				WARN_ON(ap->descs[ap->num_folios - 1].length > folio_size(folio));
+			} else {
+				offset = start + (folio_page_idx(folio, pages[i]) << PAGE_SHIFT);
+				ap->descs[ap->num_folios].offset = offset;
+				ap->descs[ap->num_folios].length = len;
+				ap->folios[ap->num_folios] = folio;
+				start = 0;
+				ap->num_folios++;
+				prev_folio = folio;
+			}
 
-			ap->descs[ap->num_folios].offset = offset;
-			ap->descs[ap->num_folios].length = len;
-			ap->folios[ap->num_folios] = folio;
-			start = 0;
 			ret -= len;
-			ap->num_folios++;
 		}
-
-		nr_pages += nfolios;
+		nr_pages += npages;
 	}
 	kfree(pages);
 
-- 
2.47.1


