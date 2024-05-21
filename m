Return-Path: <linux-fsdevel+bounces-19929-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF1F8CB340
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 20:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD5951C2199C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 18:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E8914A4EC;
	Tue, 21 May 2024 17:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tf7Gyqhu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A81914A4DB;
	Tue, 21 May 2024 17:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716314384; cv=none; b=H/1JzjEHUBQ4XL6p/YQUZXkOEBqU8RSX7BcLFPnfRUC2AWZtwlW7YtLGaO35clQDool/KMMkBySxeQF45TLo55O0tqBD3GoRdpxpmiCNtJnViXiwlyxf+4itXRSlOrjXCuO/E1ylnan/KGqq4wO8ybYl2YIr2aLe2LCpoyzTY2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716314384; c=relaxed/simple;
	bh=fF9uSlLawr19O3w96oImtZJmaTPOxhRLrgNGWkUu8zc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pVARrJPS8WdJiROxrnkijQYAKUW6QB/m4exQGM1Pqcu02sn++zrfPtGcTXWJEDiOMg+2VA3+idXHYL67Q6vlVyNll8y89Mfof9a8cj+oTZW7wrT8rEB6Holajeld1tdMx2kJ0Q+UXnMlSJhv3k3055ebFeaBInwEyj6zL8nGzdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tf7Gyqhu; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1ec4dc64c6cso3417745ad.0;
        Tue, 21 May 2024 10:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716314383; x=1716919183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PHrzc7CPuMjcf8HiikXMyTuP6q46A9jLQj3ikc6Mh0Q=;
        b=Tf7GyqhuFEvwKORgqAdFWrYyhVr9AocuHxfp+9Nq9rU8vHXWR3hiWNBenZ2OoiP/zP
         wD09L1CgVUKKsr+dFyiuFL1/YcxHrWSpv2MVh9TPvFzS4tfMOP/PYhsyDU2UatwqoJfR
         z/IaWEL3uKwxRVcISsoUQQ8d1xCDr9whVZYl2nNoy+n0HStXZoTvwndo/wGyKC6aDU9Z
         Bg3UE0F0/m9LadQC3ffAV3uYsQztfW+3SBC5LL+KKSIOn6r2E1n6+gpmQPUtPAGgTcG4
         x76AYzrkWb+P2edTOi9G9dCpKlTpkFK0XL9wfgiQErcRpeszdiwE4+vySETgR95vFDnE
         gsXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716314383; x=1716919183;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PHrzc7CPuMjcf8HiikXMyTuP6q46A9jLQj3ikc6Mh0Q=;
        b=NTy8vDGS5NSqXWn+MHPuxamg/7dxikr4FQaS2PXBHEorgGZayqWJnBH7dGha/i4NrO
         +e1+nOjfy4sb+vwForfAN56ML5FVx7mIK2gxCKJ0Zud5/q0evr6UxG+oxwHpkMIOovt7
         P0+pnNr51pUkh09zisg92QtzJVmOq9FODCDjC3nekPIdMCGySlEe6U8QtqwEJDgD8eRv
         uvgPQi9VuI9V/GByDNevLtxqHSNy6RZyc3rokPf7dR5XKjnfi4xa70G6HD360ZH+6PK0
         1rSsmo0Ymqwt2zKDAXh4CFM7Q0o2JzMBQiE5Ls6a2868o4PjMwH8KMInTUSiPcFormb5
         hjXg==
X-Forwarded-Encrypted: i=1; AJvYcCWjBxuC6KgVtnQ/MbSUPvTlrvZ3sIXVI5xNCfpThIdVwYRVQy/xhXaDhPtrsIttzxu1FM9cg3dvrr6I8uy6OBKLf5CdJJ+YkNU5vln+5oE9DMxDM/sKUgDIZ23PRTDEYsiNe74psI6yAjrbBg==
X-Gm-Message-State: AOJu0YwGtOGyn4ojvxN3gBB3VR4ozYW/3mK/E1tCvHMGfyCYJcswBoWB
	IdFM5w3zgYilY+rsin/AQh0v2X6jy4Pan644d29fDhl8T73+IDfrqMn5kRejOoI=
X-Google-Smtp-Source: AGHT+IEqeNhAh7ppNHI9aB2X1JvWm56eouCLIcYDXiomK1yXxCwOtcxJysWQ/3ie5h+P2MMqSoR/GA==
X-Received: by 2002:a17:903:2287:b0:1f2:f512:7a5f with SMTP id d9443c01a7336-1f2f5127d48mr99268225ad.42.1716314382853;
        Tue, 21 May 2024 10:59:42 -0700 (PDT)
Received: from localhost.localdomain ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f2fcdf87besm44646935ad.105.2024.05.21.10.59.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 21 May 2024 10:59:42 -0700 (PDT)
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
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v6 09/11] mm: remove page_file_offset and folio_file_pos
Date: Wed, 22 May 2024 01:58:51 +0800
Message-ID: <20240521175854.96038-10-ryncsn@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240521175854.96038-1-ryncsn@gmail.com>
References: <20240521175854.96038-1-ryncsn@gmail.com>
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
Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
---
 include/linux/pagemap.h | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 3d69589c00a4..010ce7340244 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -920,11 +920,6 @@ static inline loff_t page_offset(struct page *page)
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
@@ -934,18 +929,6 @@ static inline loff_t folio_pos(struct folio *folio)
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
2.45.0


