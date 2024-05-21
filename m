Return-Path: <linux-fsdevel+bounces-19928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 056C08CB33F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 20:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97FC3B22679
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 18:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F0F14901C;
	Tue, 21 May 2024 17:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPd4mqu3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3036214A092;
	Tue, 21 May 2024 17:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716314380; cv=none; b=Ikmi7lXbkPwzpiXz0EJYtCJbKIp1tPv4H/dmvTvR8/6ixzj4Vqs9LA1C47uRYJvpkVFSLQYATqhAtNo7YgUNtbsWlk3cYtj9FHqxc+Huv7dgJgluSTvJv1Wt4ptSlEKiDj0KgqRSSPXbn0DMdq1Ml3HUii/sEQgAouVdVlJbf9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716314380; c=relaxed/simple;
	bh=1SAVvMr94KYXIST+pzvRHms13THqgeIYsOrrjA5MSRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cwA7/JrBMmq+6SScogt5KjsAPXiLnbGmBu7uHgRBwdawtflSOHuoVHwgnxIxP0fiIBYn8qTmEt/jQSV+XCttjyuc+7VeLdJD1/GIBkCbYrg/0MYyMjZb3jDYt4Ol5pSbN++qvdbJjwmXVDIicH0laDIsLjZjShHclLpKxy+WexM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NPd4mqu3; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1ecd3867556so3832305ad.0;
        Tue, 21 May 2024 10:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716314378; x=1716919178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D1huxSjfPNpI2elfAn7WJAQ+EPp79T3Zke3qFamrARc=;
        b=NPd4mqu3NU0f7qss566tcJ/azZMP4iUWlPIq2D0PWoL2McobfvI/4K+ITZFarnTc5V
         ZvXo9UMFf3rES4IoWRFzkVKH59EjJc41V+vAEJ8v5a0NbGZsHU/d3zeA/+/NBnzrjt9r
         qr+3naN7+ai0e0BNAjKWvVAG19kUhdy0tr8Tayj69QMwSYUItxuzTHAaVborBH6L9sBQ
         VHRvmr9I971vEUh7D8FBgoPOhGAeCfNOT5THqLPPyjM9LyXajinlSSFpsu278TtSVN1q
         FUe4mBwpvZs+Nesz6fIa1Yn/bQIIVymAEo/aJRrbHJanAzYW4rAi4wft8yXagH4a2N+5
         Hr/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716314378; x=1716919178;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D1huxSjfPNpI2elfAn7WJAQ+EPp79T3Zke3qFamrARc=;
        b=hMDNXzwkfei4QgB4+u+hu/tAHgZBoL4zeULUgQoSh8dAn7NyPmeZqrBfaA3vxscmhO
         3XFLZ0JyN9R38te/kJL11/GsCj6g0Osf1+i2No63FzNIsWbyE8CWpR4bUDnOVBp4DR2b
         g99GRvjWVyO8xaBXDcy6UziFmAts3avzWXFIUmshNc04ohPM/DPVe7MsJiMM23sk7tln
         hS2vvxks1DOzmB16IS8rJGQQFqjVU+UuMWvZAuPFNL9vKNvXtetDKKHvvCWw8B6Um7T7
         Z3TSAhi9L5Kf+QL+GIWXYkzY1dAf+2KNWv9a8cGVZoby6I+sqqPd8xxbV+pHyVsV10Yf
         YTOA==
X-Forwarded-Encrypted: i=1; AJvYcCVGnKTkKN3A+48jwENQQrE11APu4i+ga0THTi5yr0qVi7Ai/0F/TrDXQFQVOeKTmozTOwLasJdwSxZT9IrEF5huE3oNf64Pyjl2HN2V98rIJ6FOstxf52ZKK3QV4b4CFS2THjEespuRnzeXOg==
X-Gm-Message-State: AOJu0YzeNf7/8IPwbLH7xcwdulCsCc8Cswzx4TcfXggUj9U1EwdGpUlU
	4yhdf/te8o0UqCGpp7HOkI7cswXvZTX7VImPSTmC++iCBBwrVWnu
X-Google-Smtp-Source: AGHT+IFhWVOawISt67dDcpWfcLwWNuJAcHjeZXZi5aR2zc9zllf3tQdQzGB28iJi3njxKzYTcZWE2A==
X-Received: by 2002:a17:902:db09:b0:1f3:1026:2750 with SMTP id d9443c01a7336-1f310262acfmr25409265ad.61.1716314378510;
        Tue, 21 May 2024 10:59:38 -0700 (PDT)
Received: from localhost.localdomain ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f2fcdf87besm44646935ad.105.2024.05.21.10.59.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 21 May 2024 10:59:38 -0700 (PDT)
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
Subject: [PATCH v6 08/11] mm/swap: get the swap device offset directly
Date: Wed, 22 May 2024 01:58:50 +0800
Message-ID: <20240521175854.96038-9-ryncsn@gmail.com>
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

folio_file_pos and page_file_offset are for mixed usage of swap cache
and page cache, it can't be page cache here, so introduce a new helper
to get the swap offset in swap device directly.

Need to include swapops.h in mm/swap.h to ensure swp_offset is always
defined before use.

Signed-off-by: Kairui Song <kasong@tencent.com>
Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
---
 mm/page_io.c | 6 +++---
 mm/swap.h    | 9 +++++++++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index 46c603dddf04..a360857cf75d 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -280,7 +280,7 @@ static void sio_write_complete(struct kiocb *iocb, long ret)
 		 * be temporary.
 		 */
 		pr_err_ratelimited("Write error %ld on dio swapfile (%llu)\n",
-				   ret, page_file_offset(page));
+				   ret, swap_dev_pos(page_swap_entry(page)));
 		for (p = 0; p < sio->pages; p++) {
 			page = sio->bvec[p].bv_page;
 			set_page_dirty(page);
@@ -299,7 +299,7 @@ static void swap_writepage_fs(struct folio *folio, struct writeback_control *wbc
 	struct swap_iocb *sio = NULL;
 	struct swap_info_struct *sis = swp_swap_info(folio->swap);
 	struct file *swap_file = sis->swap_file;
-	loff_t pos = folio_file_pos(folio);
+	loff_t pos = swap_dev_pos(folio->swap);
 
 	count_swpout_vm_event(folio);
 	folio_start_writeback(folio);
@@ -430,7 +430,7 @@ static void swap_read_folio_fs(struct folio *folio, struct swap_iocb **plug)
 {
 	struct swap_info_struct *sis = swp_swap_info(folio->swap);
 	struct swap_iocb *sio = NULL;
-	loff_t pos = folio_file_pos(folio);
+	loff_t pos = swap_dev_pos(folio->swap);
 
 	if (plug)
 		sio = *plug;
diff --git a/mm/swap.h b/mm/swap.h
index fc2f6ade7f80..82023ab93205 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -5,6 +5,7 @@
 struct mempolicy;
 
 #ifdef CONFIG_SWAP
+#include <linux/swapops.h> /* for swp_offset */
 #include <linux/blk_types.h> /* for bio_end_io_t */
 
 /* linux/mm/page_io.c */
@@ -31,6 +32,14 @@ extern struct address_space *swapper_spaces[];
 	(&swapper_spaces[swp_type(entry)][swp_offset(entry) \
 		>> SWAP_ADDRESS_SPACE_SHIFT])
 
+/*
+ * Return the swap device position of the swap entry.
+ */
+static inline loff_t swap_dev_pos(swp_entry_t entry)
+{
+	return ((loff_t)swp_offset(entry)) << PAGE_SHIFT;
+}
+
 void show_swap_cache_info(void);
 bool add_to_swap(struct folio *folio);
 void *get_shadow_from_swap_cache(swp_entry_t entry);
-- 
2.45.0


