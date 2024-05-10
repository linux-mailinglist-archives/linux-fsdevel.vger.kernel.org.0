Return-Path: <linux-fsdevel+bounces-19281-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F518C23FD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 13:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ACE4B20CB9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 11:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF69172795;
	Fri, 10 May 2024 11:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVcQqjMm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6D1172BB9;
	Fri, 10 May 2024 11:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715341836; cv=none; b=hUFwEzLWz6rYPwnWMYLhUg7LD7RIFhJtlMy8s2emAZF6Y0uD1AK1f0nvBrKd1fcQXJ77NwnWK219RWGzQy1NT0Td4ms2+U65vMXL1tlVR0AkdhjEjk1jNCZWtEMEOgRaHOvirnHoiHSncm1mYr/W04xqvSyt1BIunLbjxuhGOg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715341836; c=relaxed/simple;
	bh=02q66uzfsHRLYNQh/pzEc3jR/80QOz2ISdwMRFlmOcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DqazhHaLs8AmSgQmr9y79pdylmpBN/RflIEVP9JAsl+L62Gq66lTexSAOUE4lzQcF+k2stFlU/bj76tbKqQ9JR4zx3erLUo0bskjq0qPutxo4aSX2Cxpps1ZMHXtQKb/ocbp0FLtGot40D+OIOarxqHzZHjSE+uHqOhK0cuv+OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hVcQqjMm; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1eeabda8590so15183825ad.0;
        Fri, 10 May 2024 04:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715341834; x=1715946634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=APhN0fulocDUETiygz2oAEV3IjS3U4+qkKHyL+coV+Q=;
        b=hVcQqjMmmsuNq+GbU+TfmNjrCJQcZSJn6PGlHE0c17kHaHXTG+jtYsXZnhBJABOVQV
         3HusG3Rue9rov47k3Eme5otilIjR5IrIXAVeUZQHQqf5tEHinjOI320OxGFw0gamYZdV
         orZztP4fzk7zZWsRzfmfNBTLk6qBnwjkMQilWKg4KYoT/+0SiUkH+s8ow7ZrLd+J5Q0Z
         0avUYWVugtqcPlEBCiKuXrssUzygcEBkg6mVGBVaJ/enRPJQjglK8nxpph+cdc655I3C
         z+i5YgtcD4YDO59h7PkiIhJMaV6d7kDrS45sm5dZeqgqR/L5P5XcsvWakQw3sejzBcPK
         mCsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715341834; x=1715946634;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=APhN0fulocDUETiygz2oAEV3IjS3U4+qkKHyL+coV+Q=;
        b=EG/JWICGAs5tvP3SffOCehNLzKbDNLUYT0sbwaRLuNtMZLdWGuNBP1guynQ1oum5hT
         TfmhmAbQjdLpbVDab0cbmFTuOmrEJCTD64kcAvYrVXS328eX9T/KdzMcM6aSq90rKnqp
         3+3IAm1QFPAhAwgHy5Y+L5RXZSY5fayjbv8neyYwcCILzFSAYnaVZD9tWUJ3VmUGjmCM
         vG+tQ8YH/bC1YLzCQoX4Rb2170j1luCtatXlgTMYOSS9Iu6SnpFmsXeZkRQdi6gRair+
         bdkUrXdbHET2fieWNMOxlN46elwl9CKvXmq4V8aVbGZGkEwiRP0laVVEa4NqL7+WYnww
         iO4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWtWLjtkMDUp/hGX1XAS5thclvpkKuwlKiWuiLEBmY7yLEtlrf6Uc6kIubBObUApBnhwK9BryTCBDooHZmT26v6S70d2xzV1jhqFezXV8nYiSUfQRPWhrrCC14Ap1QFBp4dHdyCfw7DGTrzog==
X-Gm-Message-State: AOJu0YzB5p4kbyM+xCQc7UR6ihyzFOHdiUGbcl9n4QPT40GkmZUYwijU
	4FtjzX8hFAjXv9Hh/9mu26IOFLDfbDPu0kObCfQnI1fgQXHlyDeW
X-Google-Smtp-Source: AGHT+IGRhm5V0At8lTwKdrzoZNWdcS6HhlYsyuvWhECri1epnW5oHdn3nfMF9ycJerAmcOjLLrBH8A==
X-Received: by 2002:a17:902:720a:b0:1ee:b47e:4ea with SMTP id d9443c01a7336-1ef43f3d39cmr21286825ad.38.1715341834585;
        Fri, 10 May 2024 04:50:34 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c134155sm30183825ad.231.2024.05.10.04.50.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 May 2024 04:50:34 -0700 (PDT)
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
Subject: [PATCH v5 10/12] mm: remove page_file_offset and folio_file_pos
Date: Fri, 10 May 2024 19:47:45 +0800
Message-ID: <20240510114747.21548-11-ryncsn@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240510114747.21548-1-ryncsn@gmail.com>
References: <20240510114747.21548-1-ryncsn@gmail.com>
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
2.45.0


