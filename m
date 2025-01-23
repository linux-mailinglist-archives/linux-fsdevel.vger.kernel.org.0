Return-Path: <linux-fsdevel+bounces-39899-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 109A1A19C3A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 02:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B85C16BCDA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 01:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F013EA83;
	Thu, 23 Jan 2025 01:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1YTqJYl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326353A8D0
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 01:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737595700; cv=none; b=bNdvTiC58vxPs7IIUqFKepILkIQyN9uvWh2yqe27gaYQVWWvwwDYJ3O6INQ/TtekIwkN5RxyGDtDcVSFBuSfMnpTCELA/3nFkgCbChODMxL60KG3V4lF+bGFCZflmThX0Emdagjavc7fTVWUB2dVJz2eo0HM48C2/ZXIaKVT1nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737595700; c=relaxed/simple;
	bh=w6y1oAzDDWQkJFzcWqlCoUhEtiG+SBY2QmdHUhlZ8dU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PXtEyx+7u0lC4GGW4IzOpnKEXs86nfMv7d4uXxMB1EU7yZgSb71aIgERTyHfPzjdxfvuG5Hb2d34oLohKzvnz+ddNHDiE+DJw5tou1+pVKNE2I5FLyNt6nm1U01AbwZkj3cTyTOkkKZdSWNDbXbD+nzAf69drVi3ixYSx3c2Lck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V1YTqJYl; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e5447fae695so670976276.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2025 17:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737595698; x=1738200498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dLtMHv5hhZnPwkxgLGZh9zHGDqqn6F5OwQ80wc70wtQ=;
        b=V1YTqJYl7YEsruXfG99gbRsINXgI/HGtsibdo1bXYSJmcvpuZKsjW09ii0XLH8juIx
         xYgpjF05q/v4o1OO9qPhin3tidY5orpwHUO11CCTSbV1tnkyasiYzadosQSWkk3aBEmF
         YUanhrneBUmbUETZV/lqoQ//XNuwe+0IF6T9+GaHzrHQTi3YX+v7QY6s9vI6sIDv/MU8
         lF+sYZ8xPldQaysyGV4gJlQE+1hwqWmfg4P04jRSgcXF0J5LSoqxAhFYQjTlxKEoMDyv
         RsYROdXtPOqCPGsczpcCMUX8/B+fZRgw0gunw9S0Vs9udSuWn2WCQluN7VG3nK4IE28l
         BGZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737595698; x=1738200498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dLtMHv5hhZnPwkxgLGZh9zHGDqqn6F5OwQ80wc70wtQ=;
        b=j472uXhdc63MytSU7sJpHbwWJxGlblSzf/C56zvMXPQ8CzBmK5Uq+uzBGihU2JbpzF
         tLGwHJ3dWBeP7fbhWjwxjNn9pcB96+pNNEuHWBGh98egyxuzaD7HQ3SMQAariap35/uE
         8lilcn1QqGrm4QIyPAV7IVHhvXNgLrNR+ZcnJN8qJlnb1AjmCKIMZR283GadC3Jr3Itd
         3zLAbgWSFdqvo4MwN4pAu88vScTO+oA9Z+jiroF46IOlDoWmaHPSyGOyqko18yTltrDs
         vdgVecOXJwt+1dDPpKMD92kb4xdNeEuEWhMNcShnf9wv9fniQ8jaBP6tk8/Rmc9u9e1E
         VYyw==
X-Forwarded-Encrypted: i=1; AJvYcCVDdSuurALqDHRdT7tApnrSC38FFNHLLem1X0mnPcnTmaLJjsJV3VQogxdlz5Z36b3lkqspQ4CpmDbPPvsM@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2FwuSdtgIYGH/2w+JRXapS+Plf2SE782W3lwIsblFllsx61QH
	2DP/fkY1+jmmcZRUcNyXTCWVWA9sC2Ei7gKsMdTV68ngNDa/F8JK
X-Gm-Gg: ASbGncuFI/UL7ZKBsrAd9ig4vGdzRHRs0pcyQ324CPwBrLajbThMHwVsEHfsYul6nHy
	H66cw+NV1Uz5fCM80+BG8nZXacrIR5K6jCIJ5adnL7A/osqCw7GfBRLTfur4I7opy30VbKqEAoQ
	4AAeIj3xNm5DMqf3ZudhVOSmwvQ7HpOXIScsFrkD9NmqQj1+JFdObsSv6J7b6VoxGHU2EiTPXMI
	jfxO9WASYFx7nKl9qBLZh6s6lTV0yEapDruWyI8zn2jYWc02pmLyIxUE6jNFqLOYmx5VFEujXtx
	Lg==
X-Google-Smtp-Source: AGHT+IEvdBMzNuYvaKIBGFpzlCjxgwREfReVmz73bTdSHqx0msrsLejoLg2715Eb9R52I10gyjZt6A==
X-Received: by 2002:a05:6902:1144:b0:e2b:dbe5:851d with SMTP id 3f1490d57ef6-e57b107b025mr16956311276.28.1737595698176;
        Wed, 22 Jan 2025 17:28:18 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:a::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e57ab2e6ed8sm2373428276.20.2025.01.22.17.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 17:28:17 -0800 (PST)
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
Subject: [PATCH v4 10/10] fuse: optimize direct io large folios processing
Date: Wed, 22 Jan 2025 17:24:48 -0800
Message-ID: <20250123012448.2479372-11-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250123012448.2479372-1-joannelkoong@gmail.com>
References: <20250123012448.2479372-1-joannelkoong@gmail.com>
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
---
 fs/fuse/file.c | 52 +++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 39 insertions(+), 13 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 5c98dcc337d4..1e49589c8928 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1566,7 +1566,8 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
 	}
 
 	while (nbytes < *nbytesp && nr_pages < max_pages) {
-		unsigned nfolios, i;
+		struct folio *prev_folio = NULL;
+		unsigned npages, i;
 		size_t start;
 
 		ret = iov_iter_extract_pages(ii, &pages,
@@ -1578,23 +1579,48 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
 
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


