Return-Path: <linux-fsdevel+bounces-19280-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 981148C23FA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 13:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B64811C2405F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 11:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8D4172BA7;
	Fri, 10 May 2024 11:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTWpwKIt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D63F172795;
	Fri, 10 May 2024 11:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715341833; cv=none; b=RQZSkRAVbN8y8u40vWYcOLfXKK8X1riGqC84PqbH876EhOtS8596wGv1dGcnMNLpEUDDT1aKyXktPP9MkFN+q8/oinqowp1SIGHs5mySj74W+Ib73HTH+hCeXBC9SadodCjSMKqtJVc0pGbG+pWhfN6K4ljf5rumUq9QhLVwIek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715341833; c=relaxed/simple;
	bh=1SAVvMr94KYXIST+pzvRHms13THqgeIYsOrrjA5MSRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ofF8ayib0zjYBTlI7feKoCsT+RYpGRZEWGhaT+gOdHnJJerOFl4NcMZSKJekVNwOsaZXQSZqnEPhLQjpzfIgCDcQFfDQq+BLn5j5QUv6T4IBMIScS/MNYFblgSgxwcmi+/Gs7S4odV6keiRbjJ2374i4OfH5208Cc5rFAODOkuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RTWpwKIt; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1ecddf96313so16452025ad.2;
        Fri, 10 May 2024 04:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715341830; x=1715946630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D1huxSjfPNpI2elfAn7WJAQ+EPp79T3Zke3qFamrARc=;
        b=RTWpwKIt5zNLF83nVl0M/t3XTmWXQESJKvJLGOXHQbplIh1AGHDxAB1tdpg2flbuld
         s9V91iai1aoQI+zn2UPWOwjmNJx0EAa2gOCsqT6jdiOiXsRwapcBxs0OdDiLrG8DFQMW
         zukDHQ0kDdSqbmP1HNFU/EitQeoCCRCmaDbiS3NvPdxNOX1btQITiTcIyxNPBuze/O4Y
         lkkRBXLDQBCUeagb8K6wUw5uckFWqLvdm+IxwDcl+qcI71boFS/xW9WAZuQY+r63xyU6
         JYTGT6zQvuU2udDAZH8nvLwkzY9XeNAp3Uuq7x681cv3r3ixsxoqJwctypn1T//X97FH
         6lJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715341830; x=1715946630;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D1huxSjfPNpI2elfAn7WJAQ+EPp79T3Zke3qFamrARc=;
        b=hM2IV8109I8Z1dGKTFRUMdO7cffHoKsyAGgDy1Qpx7Im9+z1HW1BpOHYJsHAh8NrfM
         fGNlLrleVWG85dMoBwmJVbJ90WUDCfUNFyliGQ3cFBado3TzImd8KrPKUKJRoUb5QVas
         KRLeVQ6/jKIN5nUWaXvuI4tyr/TIPcd618kA//LeO1pd1MAwnUlW4U8VoZpH18nQOWkC
         oMuGfc9nQApdU4q7QgmU6kgX7c/vaM+Po1jQfWoaeVLaqZKWJwwIhlI0WRSED/s+VXVx
         py308NigmQ+921rCYIWBsiPeGGafEp3EKnhol6qdGxf998jvT4JIM5bvfrmZJ6Yw1HJR
         pnMg==
X-Forwarded-Encrypted: i=1; AJvYcCUggOUJvokr/YjZpXF7Td70sr4aZF1aOVZ+xWoABvxqNfc1ZOIIbsBVSBNpFusGhawaFya2+qrkrnj1BCAU6MaZDi1vSAltUneZ3htoUcgIQULRFpCgSrKWNUEaLcx8DoB8/GMxmhfRUUgi+w==
X-Gm-Message-State: AOJu0YwyXER1qtMbv9Ht82xcBfW/JiGBFRNwpskB/7TvbggRjUR4g77W
	SbonZaXcA/TIvV26hXMFjCmGk4KoR6oKugPgrHUZ9jSnoPYJpLA9
X-Google-Smtp-Source: AGHT+IEEg6dE9/dabWmlAkHlSPTCpPJRcc/k2Jrk8P/i3G+yAdrIEP6CyhaxILwoXp+bzQftvYAMNg==
X-Received: by 2002:a17:902:ecc7:b0:1ec:7b0d:9eb9 with SMTP id d9443c01a7336-1ef4404e44bmr34221205ad.64.1715341830560;
        Fri, 10 May 2024 04:50:30 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c134155sm30183825ad.231.2024.05.10.04.50.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 May 2024 04:50:30 -0700 (PDT)
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
Subject: [PATCH v5 09/12] mm/swap: get the swap device offset directly
Date: Fri, 10 May 2024 19:47:44 +0800
Message-ID: <20240510114747.21548-10-ryncsn@gmail.com>
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


