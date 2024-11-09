Return-Path: <linux-fsdevel+bounces-34120-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A5A9C28B4
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2024 01:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30B43282851
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2024 00:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47326C8FF;
	Sat,  9 Nov 2024 00:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PajL1n4K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A6D442C
	for <linux-fsdevel@vger.kernel.org>; Sat,  9 Nov 2024 00:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731111235; cv=none; b=a1TuuAPzWqhvE6UArcNVpbYAqnu1R0VZKLOP9MZWR5LCChSq3owSU2BLRFJv89eTi++ms0n1w1rddaHfvTJrXAZj1vDxUoriu7ewcM/z+HfaMD6OeACDGy6marx9m5ZHap1lzWMZqC5z8y94XnjVDnc+9oikNAFiENYhU4SNNX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731111235; c=relaxed/simple;
	bh=yYgzzzXpqzFKcmjR/AGOQoB7MN1LkrcU0MPdqJxLRX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DHBk+egNqWHmlrb2qWOWfGB3Vdj92oE9IUSMNvRpuyzcUc907WC0wFav8nJr1F7/0XBKXTgvrfefmyZNdU5wjMIakFfZXVSdx7KitcF5OJXdpZJOqWrSumUTAsnGha3qt0Ka+YZ8RBiWR/mbqQ3kYyQEiEWUfRXlv29djjzHzoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PajL1n4K; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6e390d9ad1dso23976967b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Nov 2024 16:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731111233; x=1731716033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TuKCwsFn40jERjPqjTeJCxFnlNE/D2gBXzbxhi0+6u8=;
        b=PajL1n4KCJ8nsaUrZ1jb/H5GJ1Js9ajWI3cNwNCHXvydII3kbWQxl8WIj7JrXU3O96
         S9zlL5CaTBq2nkwtbzmZ0pHFq+euFPJQvNfa3Tld+wQnON+2wBePfhh5C0euJkDY1Mgt
         slPACOmYCR6Qj2C08u7plb1cIMJUtk/jyTxqo5PJ5tFWta5YB2ikrEZuGISxs6HtH8s8
         mgYL1iqxDgYO52/TNpQq7u4kSn1PmJak/30B/zBqI3hLq214782hXNRZpAfgFIhx8gwM
         dQfkXBRBBvjCgcGq1QFIbv28i4tfpZun5md4NPDlwX1S0hXZNe3ZqyxAqx1VYhyvCbsN
         bbPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731111233; x=1731716033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TuKCwsFn40jERjPqjTeJCxFnlNE/D2gBXzbxhi0+6u8=;
        b=sgiNAWs18TjembFS3sb1l6agsDjD/r1ZX4uvYznsoNM+Cj7YuTurLT1TRXFUJjxrT4
         UjuccW4A9OGADys4Xr+WpCzDZD61emaoEx2AM4CmhzftiAq6kspkzT2vglt8/6PWKg9w
         jk5u5PMG633YPHc8tALoM531Xr0wXRaVzJ8fk3giP94CSlvjIDDhCY3r0+mTjvz7qSQ8
         nSDSYqU4o+0W2ZTlkahCpPMSZjt+z2PLmpn4Wr1vK38mNzVQzsmRMvRJg9//eeErDGMW
         KaDLpJ3cKH4barp9p2/IskfHOUKMRMf3oA361hYxKimFkA8gIZOl2R7I+OJL4KtjLjGg
         zxrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDOye+513hgrOADo0SKWcg0+7UEPKQg0oIXSXfiLJD3e2h6igNBRvkDvARwgU/pq/uXxWmDVdVhj+VyPSq@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp/qsD8AxceqOcvAeIeNxFbL8cullGQZyyD8a9ysOUuPf+Q6xl
	0E9vZLrxujmKGp7Vzhuevz1QtcvcZxVaBUG0EF6GEEQ/KNL9ZYtg
X-Google-Smtp-Source: AGHT+IE8dzLu7KbTLyVlkvUlD7CNZzDY6LR351WiRa04wyW+7gAVY4WYDTkuSn+eQ+09sVXoyzn+Ew==
X-Received: by 2002:a0d:c304:0:b0:6ea:ef9d:fcba with SMTP id 00721157ae682-6eaef9dfe5cmr9885817b3.6.1731111233097;
        Fri, 08 Nov 2024 16:13:53 -0800 (PST)
Received: from localhost (fwdproxy-nha-115.fbsv.net. [2a03:2880:25ff:73::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eaef0b5033sm1676997b3.43.2024.11.08.16.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 16:13:52 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	willy@infradead.org,
	shakeel.butt@linux.dev,
	kernel-team@meta.com
Subject: [PATCH 10/12] fuse: support large folios for direct io
Date: Fri,  8 Nov 2024 16:12:56 -0800
Message-ID: <20241109001258.2216604-11-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241109001258.2216604-1-joannelkoong@gmail.com>
References: <20241109001258.2216604-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for folios larger than one page size for direct io.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/file.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 255c7f2f2ed4..54e2b58df82f 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1484,7 +1484,8 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
 		return -ENOMEM;
 
 	while (nbytes < *nbytesp && nr_pages < max_pages) {
-		unsigned nfolios, i;
+		unsigned npages;
+		unsigned i = 0;
 		size_t start;
 
 		ret = iov_iter_extract_pages(ii, &pages,
@@ -1496,19 +1497,28 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
 
 		nbytes += ret;
 
-		ret += start;
-		/* Currently, all folios in FUSE are one page */
-		nfolios = DIV_ROUND_UP(ret, PAGE_SIZE);
+		npages = DIV_ROUND_UP(ret + start, PAGE_SIZE);
 
-		ap->descs[ap->num_folios].offset = start;
-		fuse_folio_descs_length_init(ap->descs, ap->num_folios, nfolios);
-		for (i = 0; i < nfolios; i++)
-			ap->folios[i + ap->num_folios] = page_folio(pages[i]);
+		while (ret && i < npages) {
+			struct folio *folio;
+			unsigned int folio_offset;
+			unsigned int len;
 
-		ap->num_folios += nfolios;
-		ap->descs[ap->num_folios - 1].length -=
-			(PAGE_SIZE - ret) & (PAGE_SIZE - 1);
-		nr_pages += nfolios;
+			folio = page_folio(pages[i]);
+			folio_offset = ((size_t)folio_page_idx(folio, pages[i]) <<
+				       PAGE_SHIFT) + start;
+			len = min_t(ssize_t, ret, folio_size(folio) - folio_offset);
+
+			ap->folios[ap->num_folios] = folio;
+			ap->descs[ap->num_folios].offset = folio_offset;
+			ap->descs[ap->num_folios].length = len;
+			ap->num_folios++;
+
+			ret -= len;
+			i += DIV_ROUND_UP(start + len, PAGE_SIZE);
+			start = 0;
+		}
+		nr_pages += npages;
 	}
 	kfree(pages);
 
-- 
2.43.5


