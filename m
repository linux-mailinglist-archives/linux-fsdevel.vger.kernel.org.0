Return-Path: <linux-fsdevel+bounces-19921-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA988CB327
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 19:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AA381C21869
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 17:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69AA5148FF4;
	Tue, 21 May 2024 17:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fta008Ki"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9EA148859;
	Tue, 21 May 2024 17:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716314347; cv=none; b=fj6FXTm1d3T2hm6wVGHpAAfqZOWBkiyZP9c/NwQFtloocxhMJO189QpHtbCBvpgER3ZqDxmXCka8kCh06FL+rKaZGjYmAySKjVnW5l1W5mjTEsiGGNyAjM8xz8awoJKHaji0/JoLhQYcLgu2mtzL7I/Bt6MN6ZLRyv/GKRwDrdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716314347; c=relaxed/simple;
	bh=ku8t2GgilDn0tasewSdg0prSSx3qEczJXd6flM0DvOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R0qbQg5suJPRHycyypNYSO6UYWdV3Mejz+h+CCeBhn6jdWXtZ1gvnbZQmtPdCAPW1P5jIN+rwS6Ubm2BIHtlNzEl0JIqduxjEGFQ2g0Zcam9zn3Wr4hn6kbJZMxR/rEf7tlCOJHedjrxFPQ58N5XUGz/vd5tHMhFesyrvUohfbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fta008Ki; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6f44dc475f4so1472461b3a.2;
        Tue, 21 May 2024 10:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716314346; x=1716919146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R7lhdO5v0hVN0l2qTLtMelKVtmq+aBFR854K3Ld5uQo=;
        b=Fta008KiV0PFaHv8K6X+/D+800H+zYqsuVnK1CrXShDpjMRoDsQlMlYeEkdnpTbMy9
         SXw8LxQ03gasZ0+zKxuokJa6MhP591IAVRvmqZKZ1mZPpDxOzDkYSHbNx/ZBD2u+cxPv
         Bp11FyrhEniiR7kdNvaCMWy2Ouocb6jSojDT/f8KvvjxbV1+h7D53ec4uOgOMFF59+E6
         Zw2CtPQbF+BwNPq6A4J4cDV4FkN6PXpoiTqkMdfQKgyKa69YOQA4JU13/s3ivhaJXAsv
         76e2ukl05hTXS7MAntL6uaxlpe0zJKJWzLEdbzirag2GTECJvZtrn7LA3BZamC++4Cy6
         BXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716314346; x=1716919146;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R7lhdO5v0hVN0l2qTLtMelKVtmq+aBFR854K3Ld5uQo=;
        b=ISp6+EJw39JwUQfJN74q87V6BbgFjLgYTa6eeFlquag4TpCeAVY2ZENb+GAVW0rlll
         VhR2nJJ8JrEmqom419YsMIEw4BgA6jfszMfp8fENA98KOLHBcHmA0s0wuNYrgAx9nY40
         fN7LKKDGYIklAzcKPArMo52Zlj9Zuntg9JKxlyIW/cRbeuZRp/Kz8dNDYeBCaClKOkXI
         cJI585uR10WhOmpEynJLvk+uPU3oe43xuC5ppVZbSDA7WB9Uk0MaAh2wzjtet+VgLjNY
         pRE4o470MnZtoxpaUWAukg7GfJ1QLBYOB3vBrCtvdPHBpAoyHFxBgUGQCA5VfG9je95+
         dZ/A==
X-Forwarded-Encrypted: i=1; AJvYcCWDg4UO+aWx6XH/FXemPWrT9FHRTgn+coE6PJPl3xlGH62If63jOtUPVRaQ0pe5Q0zb6NFWMfLyPq1eJna9H4xqEfHOVWyuhNPtp5dCPDTdHbizIA3F53g8xQk/xxZAld5ANvmyCMZOhJ0ONQ==
X-Gm-Message-State: AOJu0Yz5tze8SYWTZhS1usvpdbkQnWUDGAB+pdZVBIfOfE9DVMu9JRKi
	87b1g/4YN5F0hZ9CEEyGiNr7pB30pQl2GXTFXN8uXwLXLvR8YtjC
X-Google-Smtp-Source: AGHT+IEPpozMM0L+20HNGIEKpe29SmAQZrslVrxqPFNwn5ThpFi4hMV2N2JdR99RXw3BFqLPSnJwLg==
X-Received: by 2002:a17:903:245:b0:1e4:4ade:f504 with SMTP id d9443c01a7336-1ef44161e45mr347769925ad.46.1716314345665;
        Tue, 21 May 2024 10:59:05 -0700 (PDT)
Received: from localhost.localdomain ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f2fcdf87besm44646935ad.105.2024.05.21.10.59.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 21 May 2024 10:59:05 -0700 (PDT)
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
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH v6 01/11] f2fs: drop usage of page_index
Date: Wed, 22 May 2024 01:58:43 +0800
Message-ID: <20240521175854.96038-2-ryncsn@gmail.com>
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

page_index is needed for mixed usage of page cache and swap cache,
for pure page cache usage, the caller can just use page->index instead.

It can't be a swap cache page here, so just drop it.

[ This commit will not be needed once f2fs converted
  f2fs_mpage_readpages() to use folio]

Signed-off-by: Kairui Song <kasong@tencent.com>
Cc: Chao Yu <chao@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net
---
 fs/f2fs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 961e6ff77c72..c0e1459702e6 100644
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
-- 
2.45.0


