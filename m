Return-Path: <linux-fsdevel+bounces-18487-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E518B96D4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 10:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 473A628554F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 08:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2E95337A;
	Thu,  2 May 2024 08:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nf18YyF8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4905524C9;
	Thu,  2 May 2024 08:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714639827; cv=none; b=mdsU8sn5VvVf4AcKxIQ09lP/duK0rJpyV0qyWP81uuz5zUJgTi4gRTDOTutdswZkEtKHj7cvq2ADe5m2C2n2EyRqrFIXhXcb4RdllnBYym/7xhLw6mDFfXcH37LfKhWITbi2dhmwNqxoxgVl3ha9/LoD8FB0wBpFymPQnJ3Lz8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714639827; c=relaxed/simple;
	bh=A16ESRJnqrffQYANB/rT6hqA8dSEkAter6OElqoTxSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bL37oCRylR6SkX+xH2W8ZoTG9CuGeR+i+oKHLMkiErbo47wVaka7D8YAPqN8jrwKGzBtdRtjnEH1/L0sXXqIYUYUZNXX+mVEovE7Roq+eifb9fmZrB45LKR86sYZrlS0Y9r5asNwbwu39TGZOClpnNfxUIdh5jpfUhJdqkcDbyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nf18YyF8; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1eab16c8d83so62453105ad.3;
        Thu, 02 May 2024 01:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714639825; x=1715244625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6hBewYHOfG4Y6OYspQ+5fYKJoHCclq56Vlvet/Fbb20=;
        b=nf18YyF82XQUXhDPk7BAkVJU7SxRpwM4pQysIqgLE5RXdygcaFZfdiVsHKMcHit0k1
         NTktnu5qgIs2DGa3IvcsC/rR3ncV6kB8OxwibF2+wFxMXfG87sIsFBCDAi5V785wTawp
         YSUBmzmBpvHu0tJ9R5pK/jc7NwVr24Ag1DHMilWdsCTGYX6rxRjbjzCvA6/nOVJjmSiD
         GvHMTUaGykV7EZ7cdq0ipsJSKJ5chs82UC7pyoQ2Nr+ec6Knh4FbAU9Dvd6iXRqJa+rK
         teVB2h7Vgf40yj/J2a/ucNaQFFy1/6vKzG+iI286hARLNQUTe8eUB05m6mJErPH42scV
         sXHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714639825; x=1715244625;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6hBewYHOfG4Y6OYspQ+5fYKJoHCclq56Vlvet/Fbb20=;
        b=p01DpRynRMgMJ/nRPTQl6zp69K6IN5LeCc4ED0Ftt7v51YKeHPYAnei5Op/8gnUOXf
         wKR5jWXTG9g5RFoYVYibcR0fklAYwavf5gBJOyIi0WxhciRiNGmK3hp1VmGBvOFuveeT
         5+PS5kdkbONueHU2sKq5HcFTxakdeLujqC91pG+ZHt7iAOSwAAFW5Ec1Qvi14SAYwZ75
         xpC/7vKcd+DwQ4qwp7vnBftvzyZftaSIU6mYymgxoVpJQSpmg6KXFw+HXhrfMnMsp/L3
         7gFqUL2MDP8jZ3cnJq86okqQGpqdx9I5q3jftn6kXQaSQYfl64gIfeMOhYamwVtxvDax
         0L6A==
X-Forwarded-Encrypted: i=1; AJvYcCXK5aPHzH2MJ+WOp+SZJ4JBqs4TVlQvXx7JvwUAnJS3Bnafx0gMUOJSI6oh/Tg632POcUmP/UqmI5L2QCiI0/LeEBHf62r801SDHB1CascafQ5je33xhwKC5zgNLWoFEKx9wkEepls4WrAcug==
X-Gm-Message-State: AOJu0YwgCIQkqg2YBJ9Vy8RQvlU55VQ9M7devt1GEJHbmYaBBoOYR2K5
	XKhOK4hG7RJhMMohqAcYtdpiAo1PVG67NtXvLkrrwwSXJzrdn7KV
X-Google-Smtp-Source: AGHT+IFwlpgfcGprAqZdcSgM1C0FcJW03lvq1L6XneBaZZ8VDethVtsd8vo2+hwdnNRHKZqs7qydvw==
X-Received: by 2002:a17:903:298f:b0:1e6:40f1:93be with SMTP id lm15-20020a170903298f00b001e640f193bemr1586793plb.27.1714639824889;
        Thu, 02 May 2024 01:50:24 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([1.203.116.31])
        by smtp.gmail.com with ESMTPSA id j12-20020a170903024c00b001e43576a7a1sm737712plh.222.2024.05.02.01.50.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 May 2024 01:50:24 -0700 (PDT)
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
Subject: [PATCH v4 09/12] mm/swap: get the swap device offset directly
Date: Thu,  2 May 2024 16:49:36 +0800
Message-ID: <20240502084939.30250-2-ryncsn@gmail.com>
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

folio_file_pos and page_file_offset are for mixed usage of swap cache
and page cache, it can't be page cache here, so introduce a new helper
to get the swap offset in swap device directly.

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


