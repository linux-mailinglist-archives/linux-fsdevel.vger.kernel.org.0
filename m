Return-Path: <linux-fsdevel+bounces-18488-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E1F8B96D8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 10:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 764A81F23E37
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 08:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BF7537FF;
	Thu,  2 May 2024 08:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7mux7+r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C955053E25;
	Thu,  2 May 2024 08:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714639832; cv=none; b=YN3Q2CpWAGXHQAfOyEuYB90AFclmdzRKvQVeZP5ka3bCexHgVG0UUkm0wiBNmPM+zU7cBla0th2I/mnoITgvMhZFez4KYChQnadKdid/6MmJQz2kFlsWSr4InDRmKNvVaBZEZuvYlRzzQEJ9pqvdgP+g1YzCnumYO/+KV16soAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714639832; c=relaxed/simple;
	bh=6okZCup/hwaohEI/Nc0kJ/Ps32cRxS/nkELSSS3LsjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kyymup6Dnl2MyT8Sn7A9ezzUeyPbWLWAB84jRzusF7C+PT9lJUnNLgjbxKGxa+3UCjS/seRylTK1vJPVHlF1IIwT4CcbUGeN7iEwk7wBPa1fLPtVchHkGW0bXqmcplULinn1dwxguPNC/1nvKhcJs/yfkD+3KnzyX9meC3QLTpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T7mux7+r; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e651a9f3ffso39782775ad.1;
        Thu, 02 May 2024 01:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714639830; x=1715244630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hRYCaxyc5VxJ2RJEf4Sa/SOe2k8+YTvkzKGpn4vzx7s=;
        b=T7mux7+r3An3mECH17YpLxqK0QDcfXdoPg7Okbj9V6Z8dsOnrpRIbv6lJje9jvbDRm
         Ldp8/h1Rs/cdO/z2e//Wj9mFRA+9NAFmLjp6yg7OeuqQ2JXtmnUeIuVjGNlLxurec3E1
         zbdWB49JCi48s6ziCx2rV7Cd2z5xM2cgpSYI6zSTIg/4q6rchK6X4Dzx2N6pNpq2/gNt
         JPzyPaYSNbbtzNqZshBKIM39Ql68Li7Ld88l12o+8lfhXiGqDlJZLpTZn/QJFgbxM+xk
         uy5gRy8QFU+JHoJVWdRvtmXCWtIiwyHBtdicJf4qHqTWV+xYCk844RDpmta/fpUuTm7Q
         zlVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714639830; x=1715244630;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hRYCaxyc5VxJ2RJEf4Sa/SOe2k8+YTvkzKGpn4vzx7s=;
        b=JhbP3HZhjim4VE/sfeuIKD37QjRe00Kadreq9LzdahqwljG/S6hrhmKtRhkEfjgWDA
         4gNaAk8nLSVN7+50T7MdBTQoyKu0o8dQsufuyyGd2LjFgb4ITZA5DQB6CuR8LOTQEY1V
         WxrxbOzsg6uuGO5IaXIKt8okMUD68U+BoKjPKosWwjRKAuDqx3G84Jk+O4vc3S/nXVP/
         RF7JVYncIp4W53n008e7TvtBxzu2TvZssJZGgQH/N/7Uf7fv3/w9t1rfCFBZBCl/a6eF
         2DKy612cf5HOvffoYvS7lzHYwrRPUKtr7FKr9JbSjk9mdcPM28baVQNo5v7XrbTtn8zX
         QRKw==
X-Forwarded-Encrypted: i=1; AJvYcCXRybxg3m8bDWUIVb1Ki2qoCw1AE88uga2wzi/FtLQeKDl6mrGb80AE7mlJoNd6zYdaf+YWix+CmgapKuwh5R1+djn4tAQ5OS7tq3FHR+GZA8bNpLC9fVlMagpkYm+PIqG3eNeaQL299UgVTw==
X-Gm-Message-State: AOJu0YwgNk3bnbYcV3OG04aUCzDuhkquEAgYT0YeOPwUnbZhyyaRiQHH
	xkE5VHXBKslHfAxrvGtr1Ak6hNYYjhd6pXeFQOH0dM6RT7ryGLVBLaDIpyaGfmY=
X-Google-Smtp-Source: AGHT+IHufI+b2KEWe7q4ZEgCWkfvkErjirIAQy1x6ZDt9+l/U2kkILUWyLVdHUQcPqggeeFX9lCXKQ==
X-Received: by 2002:a17:902:c3d5:b0:1dc:a605:5435 with SMTP id j21-20020a170902c3d500b001dca6055435mr4637953plj.31.1714639830052;
        Thu, 02 May 2024 01:50:30 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([1.203.116.31])
        by smtp.gmail.com with ESMTPSA id j12-20020a170903024c00b001e43576a7a1sm737712plh.222.2024.05.02.01.50.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 May 2024 01:50:28 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Huang, Ying" <ying.huang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Chris Li <chrisl@kernel.org>,
	Barry Song <v-songbaohua@oppo.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Neil Brown <neilb@suse.de>,
	Minchan Kim <minchan@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	David Hildenbrand <david@redhat.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v4 10/12] mm: remove page_file_offset and folio_file_pos
Date: Thu,  2 May 2024 16:49:37 +0800
Message-ID: <20240502084939.30250-3-ryncsn@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240502084609.28376-1-ryncsn@gmail.com>
References: <20240502084609.28376-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

These two helpers were useful for mixed usage of swap cache and page
cache, which help retrieve the corresponding file or swap device offset
of a page or folio.

They were introduced in commit f981c5950fa8 ("mm: methods for teaching
filesystems about PG_swapcache pages") and used in commit d56b4ddf7781
("nfs: teach the NFS client how to treat PG_swapcache pages"), suppose
to be used with direct_IO for swap over fs.

But after commit e1209d3a7a67 ("mm: introduce ->swap_rw and use it
for reads from SWP_FS_OPS swap-space"), swap with direct_IO is no more,
and swap cache mapping is never exposed to fs.

Now we have dropped all users of page_file_offset and folio_file_pos,
so they can be deleted.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 include/linux/pagemap.h | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 850d32057939..a324582ea702 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -918,11 +918,6 @@ static inline loff_t page_offset(struct page *page)
 	return ((loff_t)page->index) << PAGE_SHIFT;
 }
 
-static inline loff_t page_file_offset(struct page *page)
-{
-	return ((loff_t)page_index(page)) << PAGE_SHIFT;
-}
-
 /**
  * folio_pos - Returns the byte position of this folio in its file.
  * @folio: The folio.
@@ -932,18 +927,6 @@ static inline loff_t folio_pos(struct folio *folio)
 	return page_offset(&folio->page);
 }
 
-/**
- * folio_file_pos - Returns the byte position of this folio in its file.
- * @folio: The folio.
- *
- * This differs from folio_pos() for folios which belong to a swap file.
- * NFS is the only filesystem today which needs to use folio_file_pos().
- */
-static inline loff_t folio_file_pos(struct folio *folio)
-{
-	return page_file_offset(&folio->page);
-}
-
 /*
  * Get the offset in PAGE_SIZE (even for hugetlb folios).
  */
-- 
2.44.0


