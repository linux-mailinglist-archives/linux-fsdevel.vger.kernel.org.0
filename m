Return-Path: <linux-fsdevel+bounces-17160-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EA18A8879
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 18:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04BD81C21FA2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 16:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AEB1494AE;
	Wed, 17 Apr 2024 16:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxnuBve+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2249E148FEA;
	Wed, 17 Apr 2024 16:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713370184; cv=none; b=i9tDLQIqkmLCulcxFh8FGF7Ga/SjU8Fm9wRtLjLBWzFYB622Uvj5F+g5OUG6wJSWH6qtU2b3Y9CkFaUF27IahrIW4k6RgDreqvbaSX/BeaZ3BIbp29E9uPA+cB2Xv86m7MrTQu6n3eOmXj/JabGZC9PXHWKsgLJe2bsrcNH1YHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713370184; c=relaxed/simple;
	bh=pMXBuRSYRvxJ/Pm5/D0Ih9VGkrkcDFfmsJy8ADz5Yxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l/1f1JRwkjgevD0IG2ZYOr6sRdU/t4HW+Z6x7ihy77WZvDEqRedL4V8MP90W+Vuw7zeZs0ecFLguLauEu4/YOJkHbuPglWGn7yp+2OHsHEDLySHsDpI75Ay6vQbv7NI98FN4LIXnw4WNPKuwMSk6x+1l2ofIZrrvZ4w3oPw79e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DxnuBve+; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ecf1bb7f38so5305241b3a.0;
        Wed, 17 Apr 2024 09:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713370182; x=1713974982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BixicrujN2w/NN7W8Yk1bOtYDD16jf87ysiCrI+mjZw=;
        b=DxnuBve+OgB7iTJSOkoYbkli5a7MkAcAS8KAGlIBhAYS/qasj9afZQqCR/uejQNtQU
         BFuUzTR6YDIun78IZCZ8Wls9hDW3CaoPdzB0qvc6dy1vRmgd4mhKDftzHbh8V/bW9w3u
         e46dEVZjkcJD7kTfi4VipDT8VWpU3FUiz4Ro5fhFcON1PN4zdWfIFe9IN/jkLSjzEGmN
         fZR7Q1zye9yASeq/oWLgKJgoy2km03ZJlK37dxNeACeWVcNI8/dmuujSCaiMvYXeMjAJ
         OYlHVwd2lLxsFFfXeeVDkk0YAlwxDV4K5/rTZeVJKyoN5cIfXdx7ePPKlwBffLrM3hQz
         lecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713370182; x=1713974982;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BixicrujN2w/NN7W8Yk1bOtYDD16jf87ysiCrI+mjZw=;
        b=LR4JRQOxnqnOXvr0oMYQz3Lyy5gU/wKqpH8g9ux4t1QH4sRGnyOwc/s+jKxwFI+Jrd
         dwo7PqcQDsIetlnj5GSSoxVehh0oHAGn3XpT0y0LAOsCZT2K6oOkqzVLsxEMaFOMJgHj
         zs25IxHiw2ZDWsmH6YilyLP2lyfAHYTujyKBy1lorhnKyJEf+1wK+eakjqZ6XelCy1to
         HXCAxzEa3f+SfOpnYwYPo+NHnExi7clQbyrjooIGrUXRK+q0qmqxY34RkI4EZj97/p3W
         5ZOPtpkHp8jzJ8A5NGg4nTekk+T4JMG9C3PrQ3Uqt7Eu/YwzlefUvlyUL8n6kc0ahue/
         vpbw==
X-Forwarded-Encrypted: i=1; AJvYcCU6a4LCmttOa9B5v4Vza1gk95AkXZvRB2MGeGCy5Gm/P7dx8ex1FfC+LKA7w0Ha5hNiyIquYlhzEr4IrJmnfhP4vsbOd/HkwVEPrYZSlhNYc56BXUNIUJXUyYl2p+LR8yubqFdgr3Hmqxng3M6yD/ix7Ip3IL+E14ibgR2JcF6+cTs+rO37oQ==
X-Gm-Message-State: AOJu0YzkpWdWRTDnFY/X81rJW3PZ2E+QdJgHnZXl+m+xGMQbfWGExaP3
	vrWQqvsGwmOszMTC/bzT3s1tQUD0bB/EWixOgoMh/28NBg78rT1o
X-Google-Smtp-Source: AGHT+IHADX305+lhsZl65TBVJfwFNnUajwhJ6mgc1Rrgzv/e0DGcheSabgx4i4+AnxNft/shYQftQw==
X-Received: by 2002:a05:6a20:dd88:b0:1a5:6a85:8ce9 with SMTP id kw8-20020a056a20dd8800b001a56a858ce9mr71965pzb.12.1713370182271;
        Wed, 17 Apr 2024 09:09:42 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([115.171.40.106])
        by smtp.gmail.com with ESMTPSA id h189-20020a6383c6000000b005f75cf4db92sm5708366pge.82.2024.04.17.09.09.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 17 Apr 2024 09:09:41 -0700 (PDT)
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
Subject: [PATCH 1/8] NFS: remove nfs_page_lengthg and usage of page_index
Date: Thu, 18 Apr 2024 00:08:35 +0800
Message-ID: <20240417160842.76665-2-ryncsn@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240417160842.76665-1-ryncsn@gmail.com>
References: <20240417160842.76665-1-ryncsn@gmail.com>
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


