Return-Path: <linux-fsdevel+bounces-18177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E4D8B61C2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 21:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F0181F222CA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 19:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335ED13B7A7;
	Mon, 29 Apr 2024 19:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7bsrhX6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD7413B598;
	Mon, 29 Apr 2024 19:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714418002; cv=none; b=U/nQgI2ti31phiqgS7EPYLVaGmUSQ772ySxHm8o/CJpkqCz+XbUmJYdqVhVUh7lEItW82RllVZylcNF62xPDlxxHi9SN5976qBzN1ah20aKMBABr+TWF5EU7FqCQnuvNajJbqrvvbtVrLO7bujbOTDXMvA2YkyapmB9fA6CxhVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714418002; c=relaxed/simple;
	bh=sgR0dU15JB8rGvD/MDR+dhiv67zgFby0JOYk45sAObs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W2mxemUD0n0d+XMMEUrXY5pxIj/CPwWY6IZwDlZuCtCPmz4vGB4ET8220m1PGrKo0/It17YHZQigxsf7EHf0pkCU3u20Go14AWumHNCn7P7KsWJMwZdgwvXGjcwXiZwzJiT6WGU2qdzKjSp63jC7AxG911fbtv0VuHxq3+rECyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7bsrhX6; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6f4081574d6so1065517b3a.2;
        Mon, 29 Apr 2024 12:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714418001; x=1715022801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hcA4nZ293WdWUF1yQsfhWEusCPbJDpQqrWzNvwMbGT0=;
        b=V7bsrhX6LZVEC3aKL2uLuwxn1avCMvO4nQyQmHDEHK/9wAOFISJFAGPs8cF58mm/YK
         bGJDhsTFRM4Ztjing/WgQUm2pN0Nlbap8RfW+oZjR2TY61KBAySKWa4OsVCHLrkYaLwo
         wJDwJL1gyBsZYlAV2jPMVdMMHZXvbITdEkTdf3fZvLBJulnecZKAWAgqVjt28ZS7FWjT
         +BszWc8w4dZKNmInqx5UknpsmllyuUiX9Fhq95s/32VHYGPTbfB6jrKFzeag3ROvtTgF
         Z2193ziC6mo7LCVlnoo5tmA7j438r1CILHzrQbSVyBE5IeR0jRpvfh8PN+6eF9wdvD4A
         Qang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714418001; x=1715022801;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hcA4nZ293WdWUF1yQsfhWEusCPbJDpQqrWzNvwMbGT0=;
        b=djDtbODSML5P7EZMV9n8FaC9mh4MSXIh0/DMQ/M2Vcp145u3jE++iPxn8M0B3UMGuu
         whBavL8qJB9FFsV6kLWvbIhaPqHvMzbD2M3zWKWXq7DWJrsQo/5R7TI50R74iSy7IZEk
         OPw0yzPrgTW8JQpEeirjIeeKhTs2qww16iQuyUnYk0QwJAlxHQbz0hpFgiiyTMwKCB3x
         DGVktH6stP8JO27ifFrJDNdqvEZ0cYcvQxLgJ8BTHJVf1QjDU74l7Icw/4kDcP9U0vRT
         oYdxudDkmVZqsmftZd5tQ4r6vGUwoMk+EWt3fgMSoQA6CbiksJo5hrTIAzEs5lQ8zjgr
         ujcQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3VOzoqNYfqzlFEJGZQgAfG7v3ra4PMaWCgqtanoDc+ECuB+KYYRciQAQyJ8yegRL/h0utwyG1COJQyBdU2KH60ReQ2gjrepM/h/+PwVC+Pb5F42tZUu580Dyz5goz5umgYxsmXce8ibpSlg==
X-Gm-Message-State: AOJu0Yx2zMyUdZjS+J3CnVj93O/LI4IRLyUutXsoLz+LRkgi34AC4PGS
	OweHxJCRnAskid8+NlF+8nMw+OdSYqWr6Qn6hGrhf+UxylB7NRkh
X-Google-Smtp-Source: AGHT+IHLvjgAnYI9Ysv2ceA6BnVwlRDqXI0/taYU8YoY6DhE56amomjz9GVryhH/eJ61mj48VwV1lw==
X-Received: by 2002:a05:6a20:2d0a:b0:1aa:930d:3dd7 with SMTP id g10-20020a056a202d0a00b001aa930d3dd7mr14861872pzl.6.1714418000676;
        Mon, 29 Apr 2024 12:13:20 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([1.203.116.31])
        by smtp.gmail.com with ESMTPSA id e10-20020aa7980a000000b006ed38291aebsm20307988pfl.178.2024.04.29.12.13.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Apr 2024 12:13:20 -0700 (PDT)
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
Subject: [PATCH v3 10/12] mm: remove page_file_offset and folio_file_pos
Date: Tue, 30 Apr 2024 03:11:36 +0800
Message-ID: <20240429191138.34123-3-ryncsn@gmail.com>
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
index 4e85f33721c4..91474dcc6cce 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -917,11 +917,6 @@ static inline loff_t page_offset(struct page *page)
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
@@ -931,18 +926,6 @@ static inline loff_t folio_pos(struct folio *folio)
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


