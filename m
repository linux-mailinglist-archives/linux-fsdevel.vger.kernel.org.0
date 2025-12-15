Return-Path: <linux-fsdevel+bounces-71343-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 866ABCBE5A4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 15:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7DB43301275E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 14:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD863446D3;
	Mon, 15 Dec 2025 14:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/CA3vtW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E898D3446C3
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 14:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765808387; cv=none; b=nL9Ow/eqct4NvhB+x2KFDPJlEzAksygL80yWbPBx+OubJBlBe1kOP824d38q1qG3+BK/8Cs1V68+BpyXpuZjj8ZOJM0K2TS29Fi9uYbXpGME9TyvsYuWWZnjb7eONU0dZFEBIXYM5zX0E4ASKpFQO6QCpaFjiMdYr6RxFygVPPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765808387; c=relaxed/simple;
	bh=OzMBOJxaVDe8N1dePuBrfiBywTYG3E45s+K3aAqvcXs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tw3ReHK1uzepTMYwgiwyRdaUj0VdY1roixXMMgOqGZRo/1hNKhzqUjTHlhFnn/En3dj3MoWj7S+Uws1Y2P758Z1loUFknBoQDuJmZbGyqHWkq9TNMSSLVblg/0StY5I+ZRWF66XmFYX3AXn3vd+CUykZIXjGfTxVGNjkfg0MY0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/CA3vtW; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-34c61194e88so944655a91.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 06:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765808385; x=1766413185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sz2ZyabzWF0ZrqxI+wXOJC7zHA/OIk4HRDatPq5ZR/Y=;
        b=A/CA3vtW8Iiob46zM5WfQslL4YcacgGnaT6+e+Pc+wi5BHqXkGfNBR3oNJFjlP6g2u
         mW6lVitN9LWIo63h//QgX1H9ekrxgmbuY7jT11ilMsS9z3vdhMHigO5miVma7zCkFmj+
         vT1p1oU2ycPpdoV5TSG+xSaJembnEUEtF0oF7MAFO4MgrxK9AUPzxm0Pkc9pk9UnGaRF
         Wtia1sSa1ceIVEnbGZJN8epYGlBKmh50t9pJr5o5dP7pU0Et1qz1mHCIVmPwom0FaDrr
         Ti4fjWmWVSz8p6QO3jgBzHFTzkjfjy+4M4wvIXkQdF0DmIpzyMlDh+6oUSuPULcFSJA2
         RFrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765808385; x=1766413185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sz2ZyabzWF0ZrqxI+wXOJC7zHA/OIk4HRDatPq5ZR/Y=;
        b=RchwzN/VFKr1HMAHoYvc8Ebiny5Da/1bDu9REmbCUn2ylZ3sSDPhdslsOIANfjGlX5
         uFJgcxXmkL6B+aeSUc8g5IApDmGIl/uJUBNbROgYU1N+HMLyvqvpKGEcdczVuwsKJaQQ
         bMHPLnwzydPtZnk+iWt8WHWHVkPJU86CGfVUXA3bP0lUHv69mYMcJBmHpwp2cRUfdxSL
         5aT6oHUEnAdCnDNfZ6f+RM2AMZyei9LQXoGNWQbI9YzfWpQotZZEumoR8kKpbU6h1FcX
         99m51c3cf9ufbY98x9exxT013mDHPi8hKvBFeaX8KsAeaV5m+PmJrf86E3TWg0QcGRLS
         z60w==
X-Forwarded-Encrypted: i=1; AJvYcCVDQPFXMxoV9T77pSTuFUDKSfLe+O1sby+z2yvKzbSyT+FkdSXdmv1dyRqlroj7t7c5odk6wQA6OtC2sb9/@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7vTskk1RpaNAJiBR+8xNg0XQNlw/R3R5+c+SADOVyucSMs3os
	9V8YPlg3fYImMRlb4N0uHw2FBP1lVx6Lqcshetu5rstF/308x1GE5kgM
X-Gm-Gg: AY/fxX6G4GFFiQaWKXwl3ORbbCaqUnMEkhaPrOfomAanaG4uPZQ7qjYp592yYBea6jG
	0nadzzAoFJixd+ehf5KRXCDAH6diS0Qr2IdHjmjK1W230jOZ2yS92HBeBIBKvut1PByab0VCjdG
	LG1eZZOjr+10s/1y7oisac3eHaT16H2zdTn1SUMv/Z7/7MBr0YLVcZ+LzHrDrXZzvLbK1US1WuQ
	OI+MaZY8Bz23JGu9HErCzWOIoSfdtiM1xHksGIXbMSejryv+rxxn8SCXA1RLP4oVLmZHkIAj1v4
	kP7qozjwdv3+p4MXj/DJVyS0EATmTbTosabEJz2leL16kCo2VSmuh+NTfiEVNPXkyKVyzAs2EYS
	ir9Ul6xgBmsfbfbtC2/Go1eLBdnjpGE1uMZzd1q3tN4oXQUIwq+cUVDfaJG+jvvss5w/K5i+ULJ
	sYk9I=
X-Google-Smtp-Source: AGHT+IGdF2f/MNFoSK/nrxLbzKgQ5vS0nfeLfMK+djS7OwzM+f7jzutmhjxvjiyFHRAZZn9EuGNBFQ==
X-Received: by 2002:a17:90b:3c4f:b0:340:9cf1:54d0 with SMTP id 98e67ed59e1d1-34abd7a93f1mr9394279a91.1.1765808385125;
        Mon, 15 Dec 2025 06:19:45 -0800 (PST)
Received: from localhost ([2a12:a304:100::105b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34abe1ffde5sm9524411a91.1.2025.12.15.06.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 06:19:44 -0800 (PST)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>,
	syzbot+4d3cc33ef7a77041efa6@syzkaller.appspotmail.com,
	syzbot+fdba5cca73fee92c69d6@syzkaller.appspotmail.com
Subject: [PATCH] mm/readahead: read min folio constraints under invalidate lock
Date: Mon, 15 Dec 2025 22:19:00 +0800
Message-ID: <20251215141936.1045907-1-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

page_cache_ra_order() and page_cache_ra_unbounded() read mapping minimum folio
constraints before taking the invalidate lock, allowing concurrent changes to
violate page cache invariants.

Move the lookups under filemap_invalidate_lock_shared() to ensure readahead
allocations respect the mapping constraints.

Fixes: 47dd67532303 ("block/bdev: lift block size restrictions to 64k")
Reported-by: syzbot+4d3cc33ef7a77041efa6@syzkaller.appspotmail.com
Reported-by: syzbot+fdba5cca73fee92c69d6@syzkaller.appspotmail.com
Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/readahead.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index b415c9969176..74acd6c4f87c 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -214,7 +214,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 	unsigned long index = readahead_index(ractl);
 	gfp_t gfp_mask = readahead_gfp_mask(mapping);
 	unsigned long mark = ULONG_MAX, i = 0;
-	unsigned int min_nrpages = mapping_min_folio_nrpages(mapping);
+	unsigned int min_nrpages;
 
 	/*
 	 * Partway through the readahead operation, we will have added
@@ -232,6 +232,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 				      lookahead_size);
 	filemap_invalidate_lock_shared(mapping);
 	index = mapping_align_index(mapping, index);
+	min_nrpages = mapping_min_folio_nrpages(mapping);
 
 	/*
 	 * As iterator `i` is aligned to min_nrpages, round_up the
@@ -467,7 +468,7 @@ void page_cache_ra_order(struct readahead_control *ractl,
 	struct address_space *mapping = ractl->mapping;
 	pgoff_t start = readahead_index(ractl);
 	pgoff_t index = start;
-	unsigned int min_order = mapping_min_folio_order(mapping);
+	unsigned int min_order;
 	pgoff_t limit = (i_size_read(mapping->host) - 1) >> PAGE_SHIFT;
 	pgoff_t mark = index + ra->size - ra->async_size;
 	unsigned int nofs;
@@ -485,13 +486,16 @@ void page_cache_ra_order(struct readahead_control *ractl,
 
 	new_order = min(mapping_max_folio_order(mapping), new_order);
 	new_order = min_t(unsigned int, new_order, ilog2(ra->size));
-	new_order = max(new_order, min_order);
 
 	ra->order = new_order;
 
 	/* See comment in page_cache_ra_unbounded() */
 	nofs = memalloc_nofs_save();
 	filemap_invalidate_lock_shared(mapping);
+
+	min_order = mapping_min_folio_order(mapping);
+	new_order = max(new_order, min_order);
+
 	/*
 	 * If the new_order is greater than min_order and index is
 	 * already aligned to new_order, then this will be noop as index
-- 
2.43.0


