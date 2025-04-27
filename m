Return-Path: <linux-fsdevel+bounces-47456-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C442FA9E43E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Apr 2025 21:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E88103BBEF5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Apr 2025 19:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385FB1FAC42;
	Sun, 27 Apr 2025 19:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POny5gUV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E341AF0D0;
	Sun, 27 Apr 2025 19:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745780417; cv=none; b=N5vJjnamTgJi7P8G1vPdit1t35gRd9TiSIgVDLjvtu5ttZP4j5eShIYHNgAL0EuwPBiwCzJxoLSn6/02NvWplCvSkFnvHrmvPH6bMwtV1OXLCBbe2Vp6AHYRjEHr2TicXyrCdni9wiWik16sW74GcFFNfMYW/+/XoO1xgciCilI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745780417; c=relaxed/simple;
	bh=2MeVGcC/JbBXjj6Z9aXrANwGElZGb7UdYFZ3+Z4IcYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TOROjzERj72rTciiUguhv7iRiuUQgW/pBy+1MN2CxI1JNdCMntQJaKnIZZOEksS8qeAEYLplXVH0t3lGtjx8ckVyeeGH/Bg4v7vzC9JYfAgacAo7jfFbVeKV6SSAQRmTfh8lDK2BJbQGUK6bfZI19yIkK2PLU50oyHUYMPjqfHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=POny5gUV; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-736dd9c4b40so4428332b3a.0;
        Sun, 27 Apr 2025 12:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745780409; x=1746385209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jHQnw9mBKPJvkNcz1FYOPZlxw2bb5IcvypIEEOwJyYI=;
        b=POny5gUV0llVGcO5W+bgyWbW+NI2OZD3i/IpuW+hsp+9T35JdDF8rm/bRfWQQmg3ZF
         NpPGLgJN/UHGMtQuZEdiLMtmjMi6wbxQYStTIt0i6IDaLkqMjfotsnpgRCigFnpFJQ3P
         QbJ3qY43SC/9bTldeIF5san8bpxix03G/xOM3gDafsE5qIUUyvWpKLIulqgxhppXOtP6
         iw4GtwCv2UA1/1pFykWlJVFKP0kh9Vt4YNPWhbsbhqVVPMXdTYmCLf82HmyrpNUFsuif
         eVvTEm+R5Av5ECUC+g8d2GSMLfzjlXWJfTQXg/lf76St3WEYzKTsdhU0/vd/c1/zZek7
         8LOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745780409; x=1746385209;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jHQnw9mBKPJvkNcz1FYOPZlxw2bb5IcvypIEEOwJyYI=;
        b=i4LrYRNXiSoXLS4M/XkJYKF+W+WWDhN847inaOWg2ZBYsx+gSorE4c0/B59Dm1aGgq
         /mAW/vCl88fyNiyVZJMxyVnEzLMrOwwGCMihG0lgGAH1YEsnNQ50fOPvu9nveNkmCdz+
         LZb8eineFeoqo7lQ97y3AUf391WQJtaGfPuVlBnrEY/P1gGGfRvDxqEjyWlqmBahEZKK
         3cxqNGf6ht3mjFOPaSZgTyvlZghRGBFZ9G/i7atzdAiZJ84N1x4+cbuwC38XfZ2vbzBR
         9Dzo5l5VMvNpZ049c1mpHyAKZk2Co81QVMc11/mWhUtouPPNR5SVVExT+Y8d4ifYCVgL
         rRkg==
X-Forwarded-Encrypted: i=1; AJvYcCUTYgQndq1x/lC/GGODkCT2Jh7EWjOVwnnqeK+oW5aROG/VfZVl5gt6M5PwsnoBfBK51K5oJUOxrmE2yshp@vger.kernel.org, AJvYcCWpNdKQEsxPqmMzhrNpfjtq3dDv81x5KyF73+a24nmaGJFSWy+H1Np04kgk6TKnmrPXZVw4E4Xk4OwEVQbM@vger.kernel.org
X-Gm-Message-State: AOJu0YzqVKFZnbJaR9Wo+1Cf+srHxa0WeEDHow9HpXJ7tzkLqCaNlMbs
	VHDrEOWbklpEGAq8dEFMVtNv0JAAxqlId1i78WjZYKxHlY08OgUTuRyIZEdhNnE=
X-Gm-Gg: ASbGnctMPTXAPFYSnUoHXB6bPoaybYBboNHrF3KjVukW8a/3OERsptaC0i7uRxwhO0+
	gyOoQoFJ24Swqd294IDPCN4PlmWmLWxkLDBqwqtb3XWyph6wpLj//IjsaUSiTOQVtglHLuhhYz9
	UnlSvcC8AeEAlCqjpaKdb3g7ep+r7fHFzEfqVM502NFZE17gFwL/ST4yuMsoMFRpagRZ3KTbwQg
	t/7GrSgUh7anQmDT8Pt7dSH1GxoesrXE/5MrswxdcjIvWYBpxBh2mx3IZLeZwafSVyao3bN/3NB
	gB9frLwoQEEdY8cyc1kgYBNtXnB7CFiRtbQ/md6Ookcg6pTVfJA4UiJSAvN0MQ==
X-Google-Smtp-Source: AGHT+IFFL5uf7jvIZwZoQNOWOpv1lhMyIRa7HYcY56NDs4Zz2MFGHKVsUV9AK/hefFCN4GDGqPUEyQ==
X-Received: by 2002:a05:6a20:d709:b0:1ee:c830:abdc with SMTP id adf61e73a8af0-20445fb971dmr17217657637.15.1745780409348;
        Sun, 27 Apr 2025 12:00:09 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([115.171.40.102])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b15faded554sm5862153a12.72.2025.04.27.12.00.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 27 Apr 2025 12:00:08 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Chris Li <chrisl@kernel.org>,
	Yosry Ahmed <yosryahmed@google.com>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Joanne Koong <joannelkoong@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/6] fuse: drop usage of folio_index
Date: Mon, 28 Apr 2025 02:59:03 +0800
Message-ID: <20250427185908.90450-2-ryncsn@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250427185908.90450-1-ryncsn@gmail.com>
References: <20250427185908.90450-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

folio_index is only needed for mixed usage of page cache and swap
cache, for pure page cache usage, the caller can just use
folio->index instead.

It can't be a swap cache folio here.  Swap mapping may only call into fs
through `swap_rw` and that is not supported for fuse.  So just drop it
and use folio->index instead.

uigned-off-by: Kairui Song <kasong@tencent.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Kairui Song <kasong@tencent.com>
---
 fs/fuse/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 754378dd9f71..6f19a4daa559 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -487,7 +487,7 @@ static inline bool fuse_folio_is_writeback(struct inode *inode,
 					   struct folio *folio)
 {
 	pgoff_t last = folio_next_index(folio) - 1;
-	return fuse_range_is_writeback(inode, folio_index(folio), last);
+	return fuse_range_is_writeback(inode, folio->index, last);
 }
 
 static void fuse_wait_on_folio_writeback(struct inode *inode,
@@ -2349,7 +2349,7 @@ static bool fuse_writepage_need_send(struct fuse_conn *fc, struct folio *folio,
 		return true;
 
 	/* Discontinuity */
-	if (data->orig_folios[ap->num_folios - 1]->index + 1 != folio_index(folio))
+	if (data->orig_folios[ap->num_folios - 1]->index + 1 != folio->index)
 		return true;
 
 	/* Need to grow the pages array?  If so, did the expansion fail? */
-- 
2.49.0


