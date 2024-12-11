Return-Path: <linux-fsdevel+bounces-37096-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34ECA9ED7FD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 22:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C567A283F42
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 21:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB311242F02;
	Wed, 11 Dec 2024 20:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhUZOq1e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5EE242EEB
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2024 20:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733950702; cv=none; b=NtKXV9bJ1D83iy6bHnvfiXe9ZteL3yqgjajShLfA92cOqyCBSskNt5xVsgJSbiAFIZebJ1S/mpsTqd0z5RwV2ckYkb/nUCwPHxU3xSqORPdz0hlrKVpw2T+0Np1JbpBuYXFuyZvasRIhxPGEUx1vFeGdkR3W3DBAbDvUziGgMpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733950702; c=relaxed/simple;
	bh=nq6Tmz4iQeGsJ1FObzOmjafA+mVWXec3vamkaxwHAJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aNKLHyqUVTgTlAjeMU6KiIWe3kF94E2cO+vqoluT/wRHHKlcM/zerC4rZbeYV6bNC/tykkOG87c3iq7dBiJHqeIxCbWe4MKaCYTEoJKIC0uSsA6dBNZ74HN+D9U7jboqfW99c2x4tPKsUd4MubJQrDwP1NmlcYtK7S+NWjD3u10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DhUZOq1e; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e396c98af22so5715263276.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2024 12:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733950698; x=1734555498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZN3ZvQogFCDbgispW4MpKyZwnROw0NhPwHACNZ95MfU=;
        b=DhUZOq1eaO9y8KJ9hBNb03mJMPHg5shB01I3mI17YYHmvM19gPW7mfgwrV4E93FvLw
         qWqEJ6YnyYlyFgHDCobz3MeJI1dNiQoqbzLUz89KDmMZ2MQyjrn0lXSZDGMw9tdSIztH
         6wp/HUAVTvvB41T9b87DY2yGE8etr5UJO4/WXXzJP9P7r8W+zK/hMzHw4WqtoOAIp0E9
         YjU7j4TsWgjcqI0YeqUR8R7dezUj8FmlWyjjvXODmVT0Z/2dlBiPisEG+qlssdDLXm3h
         aAaWyFDJOyjbGJH00j7ptyvK/l0hnyxhO/Vkaav2/An2wdDguvAk3jNHJcdfrtJR4w7t
         JswQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733950698; x=1734555498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZN3ZvQogFCDbgispW4MpKyZwnROw0NhPwHACNZ95MfU=;
        b=lNnFCSHbXdK4sOHMCRDKbBCN1LKgqEA+Xu6Mrf4ZUAi04dQjF6HZ4Xcyn47dYoepOt
         WAYGpgCic6ipRLz5hk+0x7kg/oKQQnIw/MXwBkLPBvmo9B2SIkWFaT3JI7sihJvh5BqC
         Ld+DDlyah881VzZECm4i7+QwWHJ2RIYB4uc1bNU7hTXefIQlYbkl8zRAl7+uJ6VrPXsj
         /q4UAEyih5SW3PZ6iQe/TFhmHoF60XjRiyLT4Db4GG9chkUCRV7ORhGSx0HMeMlpHZHB
         hs8bV/YxCVopVwu5xJRLWYPDc5bJsnJaDrNsJfwN7/T3au3YgaGsZAXBMBciR4hNypSe
         RXzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvphdTdBXhJJjWBfsLYoUMzJ1Fet5+R6+E2M7e6G/Tll7qCxX9z2D4DZNE3gjMyjPsX53ii+BCke/zFohE@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlo07oRiVJoPBzw9b4bAyLEdDRUrt4P1Pn5A10PrHWJRQfIVWI
	ffnDJRKxt12qWL0bLR0+Ef1uLY5cIsgy1BzuTyZkoIyQ6RfcZTrE
X-Gm-Gg: ASbGnctXX9bqDTTDC/omt8y8b1kqm7ddF7WWUOIcFMULvuDCzSVMN7N315g49avr5Xy
	SQkyTxvRIWfCN94+yH7V6Sr1xc67/ZSvaXBWOg3SxOZQHAgGfLwkQeoyGjumnAyQhpqmT6z/mhT
	E3likDKAH9EexERR7T3LnlNTta6kTPod1KjgCz7vvKV4ML0W43HdCWxYa0W+W2o46OSCmpWDji3
	IlScXG146DaSxqzAuNgaZJKv4PVi1JTI2eBAPiWaIL6iQtqbIGuIP3ItB46KWRkPUzCofLy19td
	L0bxsHpkCbOH
X-Google-Smtp-Source: AGHT+IE6mM8Iub3K2m2sG88VVJX+tslXkvGuAQHLOeKPmcRpuVnjbXPy9K8i9RXf34oAsviDwYY21g==
X-Received: by 2002:a05:6902:cc6:b0:e3a:19da:160e with SMTP id 3f1490d57ef6-e3da0d5e86amr696964276.30.1733950698471;
        Wed, 11 Dec 2024 12:58:18 -0800 (PST)
Received: from localhost (fwdproxy-nha-005.fbsv.net. [2a03:2880:25ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e3c94a12fbcsm467934276.35.2024.12.11.12.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 12:58:18 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	malte.schroeder@tnxip.de,
	willy@infradead.org,
	kent.overstreet@linux.dev,
	jefflexu@linux.alibaba.com,
	kernel-team@meta.com
Subject: [PATCH 1/1] fuse: fix direct io folio offset and length calculation
Date: Wed, 11 Dec 2024 12:55:56 -0800
Message-ID: <20241211205556.1754646-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241211205556.1754646-1-joannelkoong@gmail.com>
References: <20241211205556.1754646-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For the direct io case, the pages from userspace may be part of a huge
folio, even if all folios in the page cache for fuse are small.

Fix the logic for calculating the offset and length of the folio for
the direct io case, which currently incorrectly assumes that all folios
encountered are one page size.

Fixes: 3b97c3652d91 ("fuse: convert direct io to use folios")
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/file.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 88d0946b5bc9..15b08d6a5739 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1557,18 +1557,22 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
 
 		nbytes += ret;
 
-		ret += start;
-		/* Currently, all folios in FUSE are one page */
-		nfolios = DIV_ROUND_UP(ret, PAGE_SIZE);
-
-		ap->descs[ap->num_folios].offset = start;
-		fuse_folio_descs_length_init(ap->descs, ap->num_folios, nfolios);
-		for (i = 0; i < nfolios; i++)
-			ap->folios[i + ap->num_folios] = page_folio(pages[i]);
-
-		ap->num_folios += nfolios;
-		ap->descs[ap->num_folios - 1].length -=
-			(PAGE_SIZE - ret) & (PAGE_SIZE - 1);
+		nfolios = DIV_ROUND_UP(ret + start, PAGE_SIZE);
+
+		for (i = 0; i < nfolios; i++) {
+			struct folio *folio = page_folio(pages[i]);
+			unsigned int offset = start +
+				(folio_page_idx(folio, pages[i]) << PAGE_SHIFT);
+			unsigned int len = min_t(unsigned int, ret, PAGE_SIZE - start);
+
+			ap->descs[ap->num_folios].offset = offset;
+			ap->descs[ap->num_folios].length = len;
+			ap->folios[ap->num_folios] = folio;
+			start = 0;
+			ret -= len;
+			ap->num_folios++;
+		}
+
 		nr_pages += nfolios;
 	}
 	kfree(pages);
-- 
2.43.5


