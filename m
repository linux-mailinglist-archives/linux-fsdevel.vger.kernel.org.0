Return-Path: <linux-fsdevel+bounces-18169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B97F88B61A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 21:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE394280F51
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 19:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8804313C804;
	Mon, 29 Apr 2024 19:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jb3GjCmg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FA113AD3D;
	Mon, 29 Apr 2024 19:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714417627; cv=none; b=AbOVWgwG4gOryYWUjYHGclQLq+eZn0fmaie5PFqVbY9KxzLJx+1L60uultdfsjafbH8plPOXJnr7FHIw2Mn3KIz+ycDzPjtEavK9igGDYBWdb1K893Bhj0zBeYiBnTZ61CR3kcau54ImGfqqAdvc77hShN7U1k8/0CLkU8/v/1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714417627; c=relaxed/simple;
	bh=pMXBuRSYRvxJ/Pm5/D0Ih9VGkrkcDFfmsJy8ADz5Yxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lzhu9D+BIrgmJbfgtqk1bQgExGQUbzFPWAPL3QL56SQPUwtUVvNUbKNVMX8NQWmQTjBB8rGDkwDzSJpwBUwfkmhHkjiMpVq52O9L770UMqBy+3q4uGwnzVCR/cejelPQSAZJb50Q0Gy5LbphwfUZ1zGLVyH4698CTfqoETzQYro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jb3GjCmg; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e51398cc4eso43793365ad.2;
        Mon, 29 Apr 2024 12:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714417625; x=1715022425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BixicrujN2w/NN7W8Yk1bOtYDD16jf87ysiCrI+mjZw=;
        b=jb3GjCmgbgnZGDW8oQFmVnPqrI+A1+wyhXYjEvAV2G/Y/AVTFmMVU1dzAPUNh5iXss
         IqLMOK9Ig50wh/YxIGnHzYVl5fYq60oxdcewfQ0gZU275PTgXu9SF/xXSrNKOP+7auz6
         JQMdssfl9+jBQnkIckrk479Jx15tvHsZPPFZRakxfarA2ll+zngrYCEmKLMpYHhkVAEU
         y4ODhtp09cpE0YOKqwZT6XuAcJqNarWzy6VY6BJYfbjy5TFq0VPMJJ4kfctk9a8mXadM
         zyz9uUHQwcYPpHBWeYOALdBgs7+zS2ozVdJwytgGWY4BH/xqnQ3uLhEepKXcBZA9eey8
         Wg2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714417625; x=1715022425;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BixicrujN2w/NN7W8Yk1bOtYDD16jf87ysiCrI+mjZw=;
        b=kFQqhGfOkh8nKWxIvmRJvshzyPutE8oPbxLAuKGq8yFfFMjB82FGb7ZyTeVCHdMgjs
         xnfRufZgoYq/P+QVRipgthlFl9ZTQ2R5PD2Bs7agQWIa378zb6libAhrhMcojBgloqI2
         QtX6lCRPEkpfRFVDc7G6wjRnULexwUEBeLUfsya1PonpV+MzxdBdp6SK3HJBj9UfSvhH
         5VQUcC3VZYN9WaVeyM7pAlc9YhQlW0DiNOD6DCSM6IpZwxRCDbZ1LV1m13KTdNOT3DqA
         h1ft6f0vvdxyN0nW90jUmRMoj3fAW0BL8uqWeUqFE7KZKfz2YRtCXUojBwDz+GfxCpAI
         j5xg==
X-Forwarded-Encrypted: i=1; AJvYcCVX2bbm1YeIYPZmyFBqbeOpsFU68Nb7bTVrwLcP0tDotLdOP+KT0SsHFkQQvqZIj075mmeUU9LXhfS8K7FK1tyZl4RMY/6KWzl4CfaS+0+oQLmNy9+29keccYdU7T6a8GBuTg/o3UMlt+IcVf9bDO3uapx3Emqcgxfzbk0uWCeqcgHk7MMRAQ==
X-Gm-Message-State: AOJu0Yx8CZwZNjIgMo9dIPoDV/qlOy2HdBqbScf7bIFiDpRBEJrWikUq
	Jtp+islLuXVRZtqmcp9nZMjT5UED171npb3HwSQrg7jpYsBP1It3
X-Google-Smtp-Source: AGHT+IGCpCshl3e+0jgFbNefsapLc8x0wT7Iwt/SLS3EHILX+IdhnoyhK9bIf4QdB7KeidxbJ/QzBA==
X-Received: by 2002:a17:902:da8a:b0:1e4:a667:5528 with SMTP id j10-20020a170902da8a00b001e4a6675528mr16722842plx.3.1714417624876;
        Mon, 29 Apr 2024 12:07:04 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([1.203.116.31])
        by smtp.gmail.com with ESMTPSA id y4-20020a170902864400b001e49428f313sm20619356plt.261.2024.04.29.12.07.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Apr 2024 12:07:04 -0700 (PDT)
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
	Kairui Song <kasong@tencent.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v3 04/12] NFS: remove nfs_page_lengthg and usage of page_index
Date: Tue, 30 Apr 2024 03:04:52 +0800
Message-ID: <20240429190500.30979-5-ryncsn@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429190500.30979-1-ryncsn@gmail.com>
References: <20240429190500.30979-1-ryncsn@gmail.com>
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
2.44.0


