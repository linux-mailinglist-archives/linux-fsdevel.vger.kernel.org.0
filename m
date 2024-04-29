Return-Path: <linux-fsdevel+bounces-18176-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C694B8B61C0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 21:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45E74284218
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 19:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4033013AD2F;
	Mon, 29 Apr 2024 19:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbp9bn6V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6292F12B73;
	Mon, 29 Apr 2024 19:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714417998; cv=none; b=fZ81HgckpBoMCNIfEIJ/bgKFBKt1VW/f1midmmmbMas+yz5SmXPf4dbO7audqyBsFi6mtg5dumkvFEPIvibf52CEjOa8Mo8Tvj5nILZvcDWvErA2DM4wpt8p1S6DI4bXEzPHpONv63ihG3mtJZU/iaj+EW/fJxTIcSWHSALCN7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714417998; c=relaxed/simple;
	bh=jgvygBW8CqDhFBa68pFHF5Z1PEjjMQjnloI/Wq6AjY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S7mSX6ROwtEO1/8X8slgxs1Jpqq3NqnXu22SmboPU+BO24uE0HdIfINoWUeJ0L2rrr750+7Sl1LVvhWCntBGOGgJlZSd21LDnnu9McD072XrrnH8RjtDvnpdRz4WTipfxhiHD7ULQUo0k/4mg07CbLorSB2eyshxg4wXT4TCPQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fbp9bn6V; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f26588dd5eso4140309b3a.0;
        Mon, 29 Apr 2024 12:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714417997; x=1715022797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=54tBEeL3WLk/xvTe7LsTeIRT4DqSpvAgzssbqgMQpYw=;
        b=fbp9bn6VRXCdZNbfERvTb1fe82W24gw3vbhcf/eaPtBcSTmA2qFoLRx1d1cjzp/DaC
         +wJpVacIGIbpTHgTl0npVZ6xp19yx+Nf4a2BxzxJyeZOzedcAwi1GG3W93Bn75K1F8x8
         ulROygEPf662WkyNRIZH459DGTHtNV+k+hgIPy0S1Io/O4cONolqnGtQyfYfByNix79q
         6305kPdria4Jra0QakuwD9ZJoJq/Ey3PqTxnF2xnf04/FfS4WKP/b8gIUv+orJ5X/63G
         VbtGzVmRGQ1bfrrYV14+EIXlGa0avLLvZDJYrzyV9CtJaNasuiA/QmQ+B90qHpp7quxP
         p77g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714417997; x=1715022797;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=54tBEeL3WLk/xvTe7LsTeIRT4DqSpvAgzssbqgMQpYw=;
        b=JyPvrsuUQFmUOgYZ0Gwqgn2JZrPObF9utklw24icS6W9bt8zTxxdIJB0aZuOiH+8S5
         aVwvbSPHMP5xmvCD5qxgHi593sWhVVv10qW/g9DUmlJWhlRxCArUAmiK0BpciuvqdB7w
         aEv5idGutgv9WSOq+BkpdyxYWGBzsfbWM/+8KmilqmEXs7hlQrKqWzwdNH7EIYVrsy/0
         26Q1G0SCeoy0xCMYNndP5tVSe1QyXFPg5yVhx7YFblPyC32b5SW0Q/slx3ZIVOyBzIk8
         vJsAgaKWbTh5l0Fcu++MbnUnHDxLW8Iku9FehF+0ke4vY/bEY6J90MK2jbeGXSrNluod
         NnoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVX0Lk8LlS/XUgGivC9dk8RHjiHsF5rZrxK3IMgfeBz6XJKJqa+Pl7nkxkcxmvLV5LcuKrpcBOqf4kt4NV1o/SetEwQ+dTAyU0kMlDjw+jBfOlA446XYyElNIGaLcLmTUvuoXt+FpKhg7SbYQ==
X-Gm-Message-State: AOJu0YxJ8emtGq3i9Tr5Ht4TNHm9KkxdRrl7ZGuvPC/D0GkQqfI+LzeW
	mLQ17WlwRDlC6loZGxNMlKDf3jIWLSie5LodnVI3NdZSZVGf362R
X-Google-Smtp-Source: AGHT+IEkukKzFyXvcUcUCBcg+pFFl4Blb7KQzrcsvkEmMumk82TvVZAkxzMjSXvoKBD5ECjHeKmIeQ==
X-Received: by 2002:a05:6a00:3a07:b0:6ec:ea4b:f07a with SMTP id fj7-20020a056a003a0700b006ecea4bf07amr12308186pfb.34.1714417996587;
        Mon, 29 Apr 2024 12:13:16 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([1.203.116.31])
        by smtp.gmail.com with ESMTPSA id e10-20020aa7980a000000b006ed38291aebsm20307988pfl.178.2024.04.29.12.13.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Apr 2024 12:13:15 -0700 (PDT)
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
Subject: [PATCH v3 09/12] mm/swap: get the swap file offset directly
Date: Tue, 30 Apr 2024 03:11:35 +0800
Message-ID: <20240429191138.34123-2-ryncsn@gmail.com>
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

folio_file_pos and page_file_offset are for mixed usage of swap cache
and page cache, it can't be page cache here, so introduce a new helper
to get the swap offset in swap file directly.

Need to include swapops.h in mm/swap.h to ensure swp_offset is always
defined before use.

Signed-off-by: Kairui Song <kasong@tencent.com>
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
2.44.0


