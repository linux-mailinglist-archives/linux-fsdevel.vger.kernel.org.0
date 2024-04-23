Return-Path: <linux-fsdevel+bounces-17530-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 936AC8AF4E8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 19:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BB75284E45
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 17:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D22213E8B5;
	Tue, 23 Apr 2024 17:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUtsxvPc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CA14CB55;
	Tue, 23 Apr 2024 17:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713891846; cv=none; b=MtS1tw1sAFUwVwPonDL2D/rAcD1NK+Y6DEypY/t6/biSUHCiG7GX1CuUqM/El/eW+oRof1N04Tp4k6HO7EXAWM74dxYF9CfSMYn9vsk2EcKGskMU1vy4w1qBIOQAPtiYkl47fUqa/EHtnEwW+oL9EsU285cdybCtVz9yCWxoHEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713891846; c=relaxed/simple;
	bh=UaTaQyDAPYJXzxuGE+S2wWuP7fLVM+PYcfLn2sBx5RA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bjqM7LS2Nf3qz96CZpm3uM2aawgjmZxtOR4msuPps9rUpGJ8kzMZIjCSfeBxM4aGyMCxcE6Xt8rHDk6XgWU3AeUYX9HW1868vJG3l85VGb+cmKJhIpCxhFJkCZz4J5yJGW9dHX7kJwGte885iBXZ4RO4AHp7FrYwH9uoEiGSvD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gUtsxvPc; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2a58209b159so3913749a91.3;
        Tue, 23 Apr 2024 10:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713891844; x=1714496644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ccxP7TY1LZd03lAzTUSjd/WMiiw2l1TFGZjibmTvaRo=;
        b=gUtsxvPc/b7Tv8Lie0u04p+EHBvjcwrWMZl/IfuAh41zxDpsMykv3ToPAWt1o/15ig
         xamnLWhwnuVI99FCWuSd/r5HfIoDm38gs70uaxRKwKeoF/bboOr0nafzdDGt3tem9dcu
         xy8q9B+YkxNmznJ7CJOpUYyInJX4JfA5VRhnEZ9xHTN4zq0CH4HwPkoc/mj9dOpumnvL
         BxzRsQlRSYY6+QKJsbOYfqYb/gCexIll7jObAoD62DB4tvl9bx3nmSodMBHm1ky/ZgPO
         AUlfpvteMLuyPBJIjzb6p3wLLOM6jS5QSZNuNMWYV4M9of89DLIjC8E591EDt8r+pDNR
         cQkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713891844; x=1714496644;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ccxP7TY1LZd03lAzTUSjd/WMiiw2l1TFGZjibmTvaRo=;
        b=f7+5QtPTW3N36DioN/woV2DFMCCVjjR1tayr63YWBO8nqfA3ngYZNbK9rt3PS8LM9t
         twgV5wKUNjpM3JF7x+pIYb5fEhK/tFDdxp+uKtEDAJFpWcgiMkFQzgy7czl+7IYuPia+
         rVmAFQSxP42KA62kRyDKgMJeo/3qKpr4vgWbQ56vsYod1DuLhAOpGn41hCZ9smDlL7Wg
         fHNw8ju8CdbBEJ2PegVimIpm9AmVKDR31Ub7C7Q7gXzZ0Noaj9/a2Y1GqmW0WxmeZQVF
         rwWyR8UkGg/8TRE7yrwdQR/KPrgfGNZ3VHEm9nH7oZi5UBHT/FquBqytD3Fs15swcVeU
         9C0g==
X-Forwarded-Encrypted: i=1; AJvYcCXBK8sYVBardR6kj4bT1Y1ZUq5CDVgnwppcKnMxYE6mMXhIuf5Fj2F6AyQnid2WbNYIGqBWcWlcA1p0wdmvs1iPjczXsNN/wLCjvkwMnMtT35C/nCiqvDdn1fNsFk1fYm+sx69wufLj/xDrlA==
X-Gm-Message-State: AOJu0YwSN6Gtpxn2B/KiuvfXYvkPh8jLyHol87O9851DK71+0j6xf0We
	XFMyp79K7R8t/CCCJGYiSKmTn4A+zQkNgYT0VMxLODar/28rvQ7R
X-Google-Smtp-Source: AGHT+IFl9PJyw3gV5yMYnps/pmPpaL5DbNMyQbbzhrOpZIakLlc/OOAGq7K0pRF3PyTBE2M2iwLZlw==
X-Received: by 2002:a17:90b:238b:b0:2af:15db:c741 with SMTP id mr11-20020a17090b238b00b002af15dbc741mr325358pjb.13.1713891844299;
        Tue, 23 Apr 2024 10:04:04 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([1.203.116.31])
        by smtp.gmail.com with ESMTPSA id s19-20020a17090a881300b002a5d684a6a7sm9641148pjn.10.2024.04.23.10.04.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 23 Apr 2024 10:04:03 -0700 (PDT)
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
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH v2 3/8] f2fs: drop usage of page_index
Date: Wed, 24 Apr 2024 01:03:34 +0800
Message-ID: <20240423170339.54131-4-ryncsn@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423170339.54131-1-ryncsn@gmail.com>
References: <20240423170339.54131-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

page_index is needed for mixed usage of page cache and swap cache,
for pure page cache usage, the caller can just use page->index instead.

It can't be a swap cache page here, so just drop it.

Signed-off-by: Kairui Song <kasong@tencent.com>
Cc: Chao Yu <chao@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net
---
 fs/f2fs/data.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index d9494b5fc7c1..12d5bbd18755 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2057,7 +2057,7 @@ static int f2fs_read_single_page(struct inode *inode, struct page *page,
 	sector_t block_nr;
 	int ret = 0;
 
-	block_in_file = (sector_t)page_index(page);
+	block_in_file = (sector_t)page->index;
 	last_block = block_in_file + nr_pages;
 	last_block_in_file = bytes_to_blks(inode,
 			f2fs_readpage_limit(inode) + blocksize - 1);
@@ -4086,8 +4086,7 @@ void f2fs_clear_page_cache_dirty_tag(struct page *page)
 	unsigned long flags;
 
 	xa_lock_irqsave(&mapping->i_pages, flags);
-	__xa_clear_mark(&mapping->i_pages, page_index(page),
-						PAGECACHE_TAG_DIRTY);
+	__xa_clear_mark(&mapping->i_pages, page->index, PAGECACHE_TAG_DIRTY);
 	xa_unlock_irqrestore(&mapping->i_pages, flags);
 }
 
-- 
2.44.0


