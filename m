Return-Path: <linux-fsdevel+bounces-18482-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9ED68B96C0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 10:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 531081F227F6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 08:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25AF4776A;
	Thu,  2 May 2024 08:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KF+QIr1D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E622355C26;
	Thu,  2 May 2024 08:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714639652; cv=none; b=YXMQyRQvEMKs4D/aOyL6MTG79pBWBhhbhWDdDEyqkyCYXUbocBtYbvH01YVWBLIv+ZJOik1bSfmjDTBOoTHBk+ffOoAzmd6ZTFJOX9mpywL5iOsu8dj5nZUtgSA766f2/aETb/xtwnIYFku8sK7qspwaIw4g9wzaXvJSUGe4cHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714639652; c=relaxed/simple;
	bh=pMXBuRSYRvxJ/Pm5/D0Ih9VGkrkcDFfmsJy8ADz5Yxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TAmGkJvkid3giC51f53uULInrNKLkVwZbwxUnxUzNf/awRoT3uiz+iPopOLOPFcoW1Wr7POto+uLQW+DMtFTQC6of2JqWcHV/yCVwYpr1KIYdYhjDHP3yjoF50Zb9ThcCf5SyzrpQPPkEiNAq8HDj8CD2eKisCop6jp8HpAm9kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KF+QIr1D; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2b3c711dfd3so202913a91.2;
        Thu, 02 May 2024 01:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714639650; x=1715244450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BixicrujN2w/NN7W8Yk1bOtYDD16jf87ysiCrI+mjZw=;
        b=KF+QIr1DqAONLzH3vB2jI6l5AXTccKA/RqU8OeYJWEM0eI0jr2oAliAHcfd3UxuPCo
         0ThfNF0bIPk3rBxShRAa0RgVY/S5RRAGs7vmEfEGu5eUGsB5AOWdtU/SlPTY4BhpZPDs
         7tU2nY2iDX5zTrIdClM4ArS300zJ7dhgmIsobeiDyE40BmCeleAW6vdMTmh0Ya/I1cuH
         4ZRsvoyLaMy+WYLRXrIKKyDTH9Q10X7ffOj3kZoAHCeG7c84DGgUKaRBpxehOukoFi1d
         H7a0k3yCC/J5ZQ3n+Cjtw6201hD4ygKbYURKiH7rSu3hmZ6SK8RIS/kSNTj7fcegQqU/
         whVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714639650; x=1715244450;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BixicrujN2w/NN7W8Yk1bOtYDD16jf87ysiCrI+mjZw=;
        b=mMXjJdQlRoXKMt/3xAcSJbNjMlFbCXhSboXykBzFn/ySQr6rmHjcDu+un9xMvvqlxZ
         qRmar/Roixd4bYN1Zu4WyxNgNvwV3u2JUapSmn27Xc35LkPGOYV6EmSXbHE807UdCkVO
         JyeyKSncHAWVHShjEZVf2QR+wPSbeUFncA5jgJZyTeSGJuUpkbOaw39DCccyLaWG0Lnq
         RHc0U2wVwen/bPNCVFJLh7/lICV4jMPDDnJYVEhQF4BWsYB1P3zuYTRbzVcpYh4+d1Rl
         +zFasnX9TOPBCyMESm8nHYMO6QsHu/GuOVVXWy5wOytHR/9pRamkaafop6qFAORErJsY
         ZPFg==
X-Forwarded-Encrypted: i=1; AJvYcCVrMVbMp75FDo05ChffofO/xq9/0oC0CrDxjgf52Ip3dLZp+jcZpPm8rdMz+AWTnrNwvtpYCq3idFkm2VFmpZnkwCEjDoZGeuu1Wl5YejGINplmYEMRhVriInLIdovkANZdlPGOdi6vfFGsxfhJ/+bzRY6oLO44h8nvEo3IyTAh/OXIG+GbNA==
X-Gm-Message-State: AOJu0YxYrv+UXETXZKUmUe0b1f+qZSae+CSeDAOHOHS1ByLtgV1z6a7o
	6VwVjpBQwY5umf9ttDxDQx/oW/NjFECNpLLaDnV05gtJJ5y3yloo
X-Google-Smtp-Source: AGHT+IGbccr4qE+jXDa3rX92HM+k+7c2FUJ+mYHNc+51KVaTYbTEv0IftYCbT5tTMeNMMnMz/pxdug==
X-Received: by 2002:a17:90a:8814:b0:2af:fe34:8ce5 with SMTP id s20-20020a17090a881400b002affe348ce5mr4726191pjn.12.1714639650104;
        Thu, 02 May 2024 01:47:30 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([1.203.116.31])
        by smtp.gmail.com with ESMTPSA id q6-20020a17090a938600b002b273cbbdf1sm686805pjo.49.2024.05.02.01.47.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 May 2024 01:47:29 -0700 (PDT)
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
Subject: [PATCH v4 04/12] NFS: remove nfs_page_lengthg and usage of page_index
Date: Thu,  2 May 2024 16:46:01 +0800
Message-ID: <20240502084609.28376-5-ryncsn@gmail.com>
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


