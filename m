Return-Path: <linux-fsdevel+bounces-17533-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 381EB8AF4F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 19:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 534341C21E70
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 17:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C231411FA;
	Tue, 23 Apr 2024 17:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/NZJ2jJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A861411E0;
	Tue, 23 Apr 2024 17:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713891860; cv=none; b=hOMCSkK899i/dQpcWVAJ/KdVwT1XE1tSo4AfP6d3fQhTe5V8fmpVg7tqfuTVwY5d34VLekNzynfg3DOcolhU2eXt8Qh0Xbui/vI2GRygaqJSsRimubz4PIlVTfDppNepGW+vQsLafgQKwUam7b0PvzZqrtnaSD8CFa848WfyZRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713891860; c=relaxed/simple;
	bh=ZHTQ4D6mBwXm8rBHAXZMODNowQ4ZDuM4+W3lPfOCPV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IFIeeWhAaoRpemZ6eTMxeYU8JSXxZEbD9jnWchwKrtML7BBP2/0KGTthDCkM00W7puuXxj+ESoiQkPE1Jgne7pwzTuhfDTbH2tOHZA+OXCv6rZCLSo1z3/ne13VOeRTk/A8Yad21Md1KTNvTPI1B8GVrKemlAo4ZdJfnypULvs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/NZJ2jJ; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ab1ddfded1so4913034a91.1;
        Tue, 23 Apr 2024 10:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713891858; x=1714496658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KNG88VEX6ymli+8A661y92lZCXehoPGwKzjIttUG4iQ=;
        b=S/NZJ2jJXPa29jNRwA6/W3nIShrL8rqUy28ADap1Ci+2DWunTUIm+TSawJQCrzRrIE
         xsmRvoR6bNknhgt1YnDgy2tqwiQ9VnzyKaBW05o39/AYv0Dr3TGpswPT0FPvZOaWBhjv
         vyWEndoRVSleExwfZM0zYTvZlz93v66xZt6ZCVf9T6O+/uBllDf89gcoGOJXyXXZuApf
         y7VckDNgOmPTUQV8gX20N+3YgWr2VXCpM81U49rD/LPF6LX+He3jfCQwAxR4ogSEbHr/
         Jd5cEIx/aa9X5MaSYSGTp26a8u7PjNRwPHbwrbYR/XYPig8WcWFcTloprkmbZmp9ELbC
         4rBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713891858; x=1714496658;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KNG88VEX6ymli+8A661y92lZCXehoPGwKzjIttUG4iQ=;
        b=Rn+SQtuL1AP3QOgzMrwryollp1CP9TtLuwgGQRnLVqo3eZFgep/iVGRI7Zz1w0+chj
         yqV6cgdFXZP8IyYMLcp+GDGEmQ6g6fzNSw27bX53VfNuIInY0EYU0ym1O8AAh03JL5PY
         hKSIPBDP7WUDvwIbr+9K/R4EKVgbJ6zzVtuCeHLoD0GmZ4D5vJvxffctB13sROggAH9J
         WG9Nnh0eF9/dwiD/P2cs1IvjzTqZI/iUE+8e0kXvBZmKkAD0MIQHYHMJax45fr/yH51/
         mjXAkZ6taWp1K5RWkGl8vCzGJHkeS2MutbN3DtCVkSbWthjOhH8oEE/2YkgBPM3z7FfA
         cXxQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2nkNX059+L4RuJvLfFdkjwa5z7irfiN4HVzLnM2WJcLjV7+aNrdu/+xCc1n47yXZO4W5kzQpCPwbMPBQ3M0mtiGy7Kj5BZP51u+osBSlqEHnl329NVGjX3BPMkoVlQIWT9go+xEnC9hnd+Q==
X-Gm-Message-State: AOJu0YywwC+Rg4qKdGo3IOrvUlmDBvz/KP4WbAHPDXD7Gutqg9ZFRboT
	7Wx9wYbQiYV7tncSJ/NkjyhzSytxVSVhCRGjHDbuTV+Nzh+EbVim
X-Google-Smtp-Source: AGHT+IHXKQ3glHiIimSKVos8NC6ThIL+D5to0mzqdpKPEwEZ9osxyRN208oepV+c07VYuM6yym9TLw==
X-Received: by 2002:a17:90a:7847:b0:2a2:981b:2c9e with SMTP id y7-20020a17090a784700b002a2981b2c9emr14886163pjl.36.1713891858028;
        Tue, 23 Apr 2024 10:04:18 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([1.203.116.31])
        by smtp.gmail.com with ESMTPSA id s19-20020a17090a881300b002a5d684a6a7sm9641148pjn.10.2024.04.23.10.04.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 23 Apr 2024 10:04:17 -0700 (PDT)
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
Subject: [PATCH v2 6/8] mm/swap: get the swap file offset directly
Date: Wed, 24 Apr 2024 01:03:37 +0800
Message-ID: <20240423170339.54131-7-ryncsn@gmail.com>
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
index ae2b49055e43..615812cfe4ca 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -279,7 +279,7 @@ static void sio_write_complete(struct kiocb *iocb, long ret)
 		 * be temporary.
 		 */
 		pr_err_ratelimited("Write error %ld on dio swapfile (%llu)\n",
-				   ret, page_file_offset(page));
+				   ret, swap_dev_pos(page_swap_entry(page)));
 		for (p = 0; p < sio->pages; p++) {
 			page = sio->bvec[p].bv_page;
 			set_page_dirty(page);
@@ -298,7 +298,7 @@ static void swap_writepage_fs(struct folio *folio, struct writeback_control *wbc
 	struct swap_iocb *sio = NULL;
 	struct swap_info_struct *sis = swp_swap_info(folio->swap);
 	struct file *swap_file = sis->swap_file;
-	loff_t pos = folio_file_pos(folio);
+	loff_t pos = swap_dev_pos(folio->swap);
 
 	count_swpout_vm_event(folio);
 	folio_start_writeback(folio);
@@ -429,7 +429,7 @@ static void swap_read_folio_fs(struct folio *folio, struct swap_iocb **plug)
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


