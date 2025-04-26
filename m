Return-Path: <linux-fsdevel+bounces-47433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1A6A9D696
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Apr 2025 02:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB6284C7F08
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Apr 2025 00:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5601198A08;
	Sat, 26 Apr 2025 00:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZoTPKo4S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC69519006B
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Apr 2025 00:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745626226; cv=none; b=INvhqJMgIQdSxT6RkDLk8kEzZxvMSWOBjXBdFWJBBdDeUM2JUYF0MQXszizaMQ6M3KG+TO+AsVckroMY7xAssVxRKkiuw+BFyDqU16elIWmnqQOsY9TMQJLRnRWTm/4HX2nauHy3uSURzxOaNZlCc32kBdzqoNHxt5fpXSlbwf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745626226; c=relaxed/simple;
	bh=QN3P95jsFiTHmUPoA0kG1UffLiqYKygCp0OotawAiVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YKqEtIifQZH1aUr27CpOIsLqzKBOFHlvJlPvTi4pPrVyeARXbqTSNXSQmSTXYmT5jXwBhbqzaS1PHVhk8nQAMUZhn6PTQbpCnxJIA+41BZgmVx4NKoNThtHkr9hXAQXjwZMrlVV//qOEjNkaDBL3Ud9yMwJqE6msxEDQUmBdsKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZoTPKo4S; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-301c4850194so2353505a91.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 17:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745626224; x=1746231024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YhbWEEzk8a1t6b2npgyUooTJ+eY87n5siINGEZlHWtQ=;
        b=ZoTPKo4SCH0eRwbTL3ry6RmHck0J8r42DvzcdURcyxQEFV1pCC41OQtYaROLJIo7Qy
         OMJko7G9zoSO07I92/m0l3odg9/Rkt0Gdwt9dv/hGOtU/2R+3OvoM05Fte0ILAczT3EP
         I5Utr2P6iyC1Zgjk012jPt8FFA5+3c1D2Dmc97VYKb5LS7TH/t1YlMAaZ5tObkBvQfgS
         uT5rv352AZd2qDjjRZ+WEYzSSEt4MJ5qMcSD2lXdwlKDuaWm5PQMVcC5ThIwK01I4F6W
         SnkKVO/8v77M6PXzOMxf4wDuUcJRVTOU4vncnJ5n4UYXUUu5F7dHIaRbjn5sJ1KbVDL0
         Oqcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745626224; x=1746231024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YhbWEEzk8a1t6b2npgyUooTJ+eY87n5siINGEZlHWtQ=;
        b=FxmUQj+GAUtC1Por/y6uISDt75cJQAESW7k0IgEaIgMqaFUzb3Kik84r97QKD/NCw3
         U8WMV3LqCXBLXECP0BlaoNJCtPPIqfIOk5iQAp5V0pKRJbGdIsySzN9+68FcYHNFcLOq
         6aDcTM80N1Tsy0TdCKnugt12tlDMaCBoYXF+SQbQQIGa4TE6iNlaGcvS37tHUaspzQak
         5QyPbf4SzJ9dQHOpq/0zIq3NdzLbmVKrkh5hcoaXKd5FsvHo4vmpFvNvuvSV72ZYeBiP
         bK7llCWbHgX3pMq11LFZTwLay/LVvjYs5cjuqsQfQm3KiU02HhwqGlxK7y0Fk0r5fuBc
         Y/CA==
X-Gm-Message-State: AOJu0YwyTVvybBxnHJS9H/VD9HVu9VTTEFhuHL8AEWwBhWziXW3MQrzz
	OxHYuvJ93yJPaX/cOf2kpgcoNWiN1FMTU3eyglVqyKRxi8K7E/aZRev0eA==
X-Gm-Gg: ASbGncuYcHak4wHlfYcngbdDx10jeg8q0HB8ri47/jKkIpgLW6WxEuznDO6KDwtsWpL
	F6ywpJwPBAyoDVzCRrY97qACSb3+aLFzTmj6Y93n8qCOuz58DI7RIsofFMvBzDoReSrpXUNT2dY
	ZL0HdQE+94O2EY8Y8m3yjpR38tVChBMd+XlobeYj/z/9C71FtxrG+b5yWcGsSRelATaFD6xduer
	rc9MRjnnYhGnzddMgEj/6h1g4lslt+F5EIRMOKFOL/Um78qfCFuPQujN3nJq77Q9shj49RWtP4F
	SRfkOVgEkOao8yicZD/abEke2rDHpuRz8g2mhV9bkwXWJw==
X-Google-Smtp-Source: AGHT+IFuyszkNvN2B0qisP3OXAGh7tH7Gc6ZhwuSzA9zCIMtIQrQZAoW9lqpmhFe3/wBiDMrgsrKmQ==
X-Received: by 2002:a17:90b:3904:b0:2fe:afbc:cd53 with SMTP id 98e67ed59e1d1-30a0139955cmr1920833a91.28.1745626223510;
        Fri, 25 Apr 2025 17:10:23 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:9::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309f7749938sm2336185a91.11.2025.04.25.17.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 17:10:23 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	jlayton@kernel.org,
	jefflexu@linux.alibaba.com,
	josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	willy@infradead.org,
	kernel-team@meta.com
Subject: [PATCH v5 10/11] fuse: optimize direct io large folios processing
Date: Fri, 25 Apr 2025 17:08:27 -0700
Message-ID: <20250426000828.3216220-11-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250426000828.3216220-1-joannelkoong@gmail.com>
References: <20250426000828.3216220-1-joannelkoong@gmail.com>
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
 fs/fuse/file.c | 55 +++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 41 insertions(+), 14 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 9a31f2a516b9..61eaec1c993b 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1490,7 +1490,8 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
 	}
 
 	while (nbytes < *nbytesp && nr_pages < max_pages) {
-		unsigned nfolios, i;
+		struct folio *prev_folio = NULL;
+		unsigned npages, i;
 		size_t start;
 
 		ret = iov_iter_extract_pages(ii, &pages,
@@ -1502,23 +1503,49 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
 
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


