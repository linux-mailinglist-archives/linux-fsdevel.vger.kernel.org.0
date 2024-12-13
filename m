Return-Path: <linux-fsdevel+bounces-37389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5359F1911
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 23:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30A8E160459
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 22:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA591EF092;
	Fri, 13 Dec 2024 22:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYXrAq1h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1511F03D1
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 22:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734128602; cv=none; b=LEIx8PkLrQBPSuVX0MyeYBXaIecS0y0xFHa5JmQdf0+F3lzdjUuG0KqvsosGXgv4czmy+aD96DBWS+HjsQFK4vjQv+Irp/JA4WZ5TkktoW7cilB/7n2vcmQngr6gyNCLkVKuAqPVJpkYUnlm2iwkkWDPqyWE+5VrwAPo2xBXVUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734128602; c=relaxed/simple;
	bh=tGaWQLVlPWCnNy7xQeYNyj6KemM4AVuEiF8enHQE8UM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mDv3g/F2zE/mzfc28iRhDQti6lzVVmY6srZnsXz9rb111WjMX2Be26Eb9M5eC9Y6yttt1aMz6hiUDZygtJ2nksvl6TmjbrxGD77AjxMiRHkw9KHRwITnrZ6rH0sI+YfuazrwW8lziVhusQNZOllXo/fpKuXoVjh6YMTdTfKiNAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WYXrAq1h; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6f145e5cd83so20358257b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 14:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734128599; x=1734733399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wbdOnre4tcEgjC5l17NJYFK2NhHpto3wV/mVLhyi1bk=;
        b=WYXrAq1hoNxrD9GfDYXXzasoNEQflwIjfs+FXjB3QkOVr2NENIdwQAeFCts4SJDYZL
         M1SZ6F/qzLSAxcbcKXJOk3sDRHJV0TzT5fxL0JDBH2N3RJX2JJrVSlkmAG4YbSNfA4up
         I2lqXfA/B0TqBhsqeHUA1t5IworeljvWmDwOapGmuEoFPAp/nWAL8jqv5zXLjIvx0Spm
         dhT8bmWaUqk60EqfS6k+RND+fPsGgjWV1wDcGlj4yMRdVzkraF/fe2BOrguOzeP1ahJv
         YED5dRzUHfWGvaEBJ36JLRf2x1H6hfzSAwwsSperyxvn8AKNhmFYweN8a/VPMl5uWhnu
         Bzyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734128599; x=1734733399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wbdOnre4tcEgjC5l17NJYFK2NhHpto3wV/mVLhyi1bk=;
        b=Ou4svFpOtuEXXV9gGYhlBtmHJxHoaIqr4yiuFA15NT82DV5X809uXuQ8qjfBcgKDMa
         LLZQiHB7kvnEM4u5WSG4T1xzT2mF8Kvm20ETTH4GspoE3sLjVY/aOpglCx9tf7s7J+ay
         bnzmHwjp4zb8uyvE6gTuZ8SPAvjSdG+czUyY9ePTDqX7bk1/9+53hOARs4Afw+WEf+LA
         VJ55m0vJWpza6JQ49XsghVoqC7Y7u6MPZUKFDC7T2jRYsX5E4sFez2t1ezzjO1Dkeai5
         sfM48BGcNpqdR8rrw9v64DI3ZDzv46EdW3HRLBSNivOoaljL8olS9LC9iShJjZu6raKY
         2M3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVQ15U//aVQ5ymJuHA2At+eMHyR7wPEMd4si7gClaKpFtcsNAYKjKARyEe0yB0war5r28+q2yc0xcUAWxny@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1eW1nGpJ4Sh5Hid8tjK/U+XZY/nqBTpdKqZfmtz5H8YdMNAVZ
	aHYIIXuQiHRfzRo0unedE8z4A1gAGkzQ0Ny7PZPvVQGt4Ot6dFX0
X-Gm-Gg: ASbGncs3kxOXlLrsPzA9/6sGYeQ27k6pY0jQ+y6VNFRyOdnjd72ItH2TIoVAM5j5Ejf
	aNzygbLwljWj2VmTZkSBaXv4PIhYNAc18v0APyiMpQBv/kqQS+4JHTXtTNrqrOLdhsFnAz5IX7h
	BhVkEO6qp2L+4GwANL3+Y3qBAz+5kaRK7/j5IK3LNvu9UpAd23V+C3jj0BYjuSxOlVEPmAP7PVr
	4nkUhz33LfmAgAJPo/6slPPs/nKjs4a10YxCMNcEXNKUHDfTBVwFiUU1wOjHhMIFDGeUG/59tmc
	gIDsUh3LYi246VU=
X-Google-Smtp-Source: AGHT+IEeXl+7N5Pcx2BytUUu4W70lIdiX0BBJ+RV3PdfFd7ZiXgcGxRwyJ2p07JqTDmQ2ANnfJeNuQ==
X-Received: by 2002:a05:690c:6505:b0:6ef:4ed2:7dfe with SMTP id 00721157ae682-6f279b8d668mr48653977b3.31.1734128599570;
        Fri, 13 Dec 2024 14:23:19 -0800 (PST)
Received: from localhost (fwdproxy-nha-008.fbsv.net. [2a03:2880:25ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f288ff3a6dsm1222467b3.44.2024.12.13.14.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 14:23:19 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	willy@infradead.org,
	jefflexu@linux.alibaba.com,
	shakeel.butt@linux.dev,
	jlayton@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v3 10/12] fuse: optimize direct io large folios processing
Date: Fri, 13 Dec 2024 14:18:16 -0800
Message-ID: <20241213221818.322371-11-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241213221818.322371-1-joannelkoong@gmail.com>
References: <20241213221818.322371-1-joannelkoong@gmail.com>
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
---
 fs/fuse/file.c | 52 +++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 39 insertions(+), 13 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 971624557810..bbc862c1b3fa 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1484,7 +1484,8 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
 	}
 
 	while (nbytes < *nbytesp && nr_pages < max_pages) {
-		unsigned nfolios, i;
+		struct folio *prev_folio = NULL;
+		unsigned npages, i;
 		size_t start;
 
 		ret = iov_iter_extract_pages(ii, &pages,
@@ -1496,23 +1497,48 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
 
 		nbytes += ret;
 
-		nfolios = DIV_ROUND_UP(ret + start, PAGE_SIZE);
+		npages = DIV_ROUND_UP(ret + start, PAGE_SIZE);
 
-		for (i = 0; i < nfolios; i++) {
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
 			struct folio *folio = page_folio(pages[i]);
-			unsigned int offset = start +
-				(folio_page_idx(folio, pages[i]) << PAGE_SHIFT);
-			unsigned int len = min_t(unsigned int, ret, PAGE_SIZE - start);
+			unsigned int offset;
+			unsigned int len;
+
+			WARN_ON(!folio);
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
2.43.5


