Return-Path: <linux-fsdevel+bounces-19924-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EEA8CB332
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 20:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05D71B222EB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 18:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36A3148FE4;
	Tue, 21 May 2024 17:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AiAahNAq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC99914885B;
	Tue, 21 May 2024 17:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716314362; cv=none; b=oXHsQIQFnBg+LXZ7hLMLHfR2i/ud9OFpmDHNArhrrITme3avI7r4PhP+1GZoRmVLJjbcgSzKpu8cA2h3o/RchNE5OndIJizltCg+V7DlfppnzxFrBe6UiIkKyq7MJw9LjYIAzOcKWxnIIYkob1kXugr6XWKgGV/80i1fEablmIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716314362; c=relaxed/simple;
	bh=ShAn5fhCYPl8qlhBHZU43ypZj6BFHQvlTb/1BJsqubw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TacF9syJ+Wq0aSOsn5OL8EwSmqgQjAkUnevKHN1bSLSgje9le7EZQJYLAUsYKQizLiJee6Lk7LJCyDcOVM//eww9gJ4iYycdzqVbl60oX3fYQF2Jd6Zccs4K2m+3QL6AK6nMFaa9/GurpePTmCrAzQIA7bGct5d9leO/FT5pPSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AiAahNAq; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1ed835f3c3cso3881045ad.3;
        Tue, 21 May 2024 10:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716314360; x=1716919160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T/Y01wUoc8GqRpvXAplln3XTaKFYbBI0hlcfHL66MPg=;
        b=AiAahNAqpArWDRE8AbpeyAaitqGUv6JLlT/9Cr25UxYKzlwvOAZz4eIxTRSD9p2Zyo
         oRSMMLvsYoTH9A0IMUfsyvWTONiEzodtL0CEiCv//R7KqXn2UnNia7UjRdeIzF7mhZU0
         bF510YgbNmVdqppkDYf2/kN7s8pmDlBxmlkpoa6eJ/TC8UZje0v5F/CiP9HoOBBUgcEp
         ggD+jRrhKzqW+wuh9At2MVtU4oqH0mUdpjJJUD6KlnPByEHDwoWuVVJC824zhmge6hpO
         iNzhsOaAiSuhJC2EY0AqoIU+3NFtsRzNzJgymKCMrCmTeWa9mJRTzhkxbqYLdhEFnNRu
         6SgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716314360; x=1716919160;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T/Y01wUoc8GqRpvXAplln3XTaKFYbBI0hlcfHL66MPg=;
        b=FxRdsdNVKUyl0sl8qjGUJPwnSlOyS1k98skj1C4KDbVO+q7hejr0y3+x6aM3NGzRfX
         Jr/4dgq5lp8xeQTwKi3QfGl76hUC3mV7jVv+DXCUdi9a2qqFOX1NJkiWPffQzYJ4oTCA
         Blj4Lto4h2U907Ya3TgO4sMPlboH1y6kOzET/gxYUXnq/cx73FgnRoufNV2Y4y/wMrTS
         Y7SXQmnKGDk6ddnFEXx1PiPjpRrL2uBtFKzfU1sDsx6eQ7ehCcKKKJRdXwNlknNp2Hxo
         0IlJHTLsOdYwMpHTfYDp7B3QQbulEDajipDFn8ow9agQgTbx65IBxq1kNrXXF8fcU+6g
         mFCg==
X-Forwarded-Encrypted: i=1; AJvYcCUH4C5WXiImIQkhU1U3M7/wu45azEVCs09obulQXrvyRo9HYnpCZL2rsmqSL5ARMgu4PVXu8lpIkPZtoPZL2rd2xngiIZZQUO3S/Jp+vWgUhH2VaAjldu8RunyJTujtCNyy5iJ0pl7rEMnZohNZzJe11UKT4mwr/r2ZJr89Jkha8cQ0AuKjQA==
X-Gm-Message-State: AOJu0Yy8mgTSi+uec43/R3ZIrZUdzNckcXqVoUpV7dZ3sDm7vE4dAMmU
	V1JGmaC6IzV45+fLpnacbb5FCXasbz19z5k0wyGjWYfWVDDsEvwL
X-Google-Smtp-Source: AGHT+IHoEUt/0l1rn7y24nEEjHG5IB3IdC9BGhTGoiXG18qSAHAVRm5IJU0l3mpAfVMLarJhvGzQmA==
X-Received: by 2002:a17:902:e847:b0:1f3:21e:23c4 with SMTP id d9443c01a7336-1f3021e275bmr80072115ad.21.1716314359988;
        Tue, 21 May 2024 10:59:19 -0700 (PDT)
Received: from localhost.localdomain ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f2fcdf87besm44646935ad.105.2024.05.21.10.59.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 21 May 2024 10:59:19 -0700 (PDT)
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
	Kairui Song <kasong@tencent.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v6 04/11] NFS: remove nfs_page_lengthg and usage of page_index
Date: Wed, 22 May 2024 01:58:46 +0800
Message-ID: <20240521175854.96038-5-ryncsn@gmail.com>
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

This function is no longer used after
commit 4fa7a717b432 ("NFS: Fix up nfs_vm_page_mkwrite() for folios"),
all users have been converted to use folio instead, just delete it to
remove usage of page_index.

Signed-off-by: Kairui Song <kasong@tencent.com>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
---
 fs/nfs/internal.h | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 06253695fe53..deac98dce6ac 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -790,25 +790,6 @@ static inline void nfs_folio_mark_unstable(struct folio *folio,
 	}
 }
 
-/*
- * Determine the number of bytes of data the page contains
- */
-static inline
-unsigned int nfs_page_length(struct page *page)
-{
-	loff_t i_size = i_size_read(page_file_mapping(page)->host);
-
-	if (i_size > 0) {
-		pgoff_t index = page_index(page);
-		pgoff_t end_index = (i_size - 1) >> PAGE_SHIFT;
-		if (index < end_index)
-			return PAGE_SIZE;
-		if (index == end_index)
-			return ((i_size - 1) & ~PAGE_MASK) + 1;
-	}
-	return 0;
-}
-
 /*
  * Determine the number of bytes of data the page contains
  */
-- 
2.45.0


