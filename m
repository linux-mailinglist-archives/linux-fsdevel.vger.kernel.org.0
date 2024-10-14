Return-Path: <linux-fsdevel+bounces-31913-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 440B799D665
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 20:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 044992830E7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 18:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D566C1C8FCE;
	Mon, 14 Oct 2024 18:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBkROChC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59721C3054
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Oct 2024 18:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728930231; cv=none; b=i5TT5UPgFv9ApY6fFKVx04AEG2wbvO9TzRQv8jl/6yfK2W6wuT/Vde+tg6S87lU5LdwLiqxvLS5o61n5W2wdWzUYnK9vHOGLvbVoM3fs9fsQQzF1NQ1o68VqtFtLAhqIjkl1qecVTeVi1X8FHI579ZF8R8FdUme8iWz5LFY0Xps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728930231; c=relaxed/simple;
	bh=o+F688ikawdBtF9LrJNYrzfXNPqhMPpGznKRbHo6Gu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fjq5Qu1YmzR2905ut9WR1kzBmzoDoxDn4iOHaUDHO8JZTtCreXgAUSrz9g3zXC7yyyMl1US6b0QY47ZD17UZnlmvXfgQFCqfSSCgVFzroJkxonPuhPFUjzLxSpgmIbNT2RjQHtjHpRgnlRhAEQncN8xfP3w+Z6F0asxHH0IofkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aBkROChC; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e28fea0f5b8so4037502276.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Oct 2024 11:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728930228; x=1729535028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fdBz15jaWsg8cxk/btL9PXuORpPlgL7NIU4wQ/z1ydQ=;
        b=aBkROChCeLAb8n+NAlvOF7cB2Fk+MXIFAznA96JNnEIPl9MCuCb1Y65rFI6fVuCbZU
         UFWiHlwVkn5JgxLiOXPhK36PMhB5MiiW0xTLQ+BEeE9anJ8cdefegRCukpWxOQawd5aF
         nztjgLVt8tzYV018dyMI06JnqFfcEkR9ZYiTEStP5hLnJmGbtzLN2tPLwykAA7dRj7HW
         u/ZnX1DIsOHbkJRAVNMtP8ePO0V6jffr/BRL3d8cXsOB3jdoUtWcH0xrF+MAM3pxTxg2
         MP4Cl5B9njQzl47tPxmcJM3Qpl8X4c5GKCDsnAYELFsbNzJNrcgwz/xREIADcD9AM5Au
         mMYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728930228; x=1729535028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fdBz15jaWsg8cxk/btL9PXuORpPlgL7NIU4wQ/z1ydQ=;
        b=XwdB8rA2O1WyFap5BI/sTH02GO8EQyBkytZjsUS7K0OkADEXwjxVqxH8VXk8R+suCV
         qHqVp2taAHMznLzSJ+Y+TwunRFqXHSgH4CIODQE2o+uxzOFifP8nqT1/FDmfgWGK3SX6
         q11A0wqMFrDi6MHhEO5xq3sllLNoZ55nk2WVpzhff8xTynZS3/J206H+dtBBilZKK+p4
         Axecac0HdN+jeBdRRzomt9Wixy7CDXbWMh2CdD/MslJSUWIoawL5jycXY41nX7lLyB53
         sA8YjDjYaehuWBJ8hI2XEn1pPffv2eNRmynRF6r0h9UVfYOn2QOeD/JxJblbA3FvBJ7n
         XfDg==
X-Forwarded-Encrypted: i=1; AJvYcCVyBBFMJFTpXyZ3ea9btGBwNtnzZo0hzRw+h3Bdfy6SuDOY9EUTDOxiik1K0knBlTctJeDSVs2BdQqAW4d1@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7LkvDS7p7BYtrrPhO3uCDtywH2L2gabShKra0evKOFKus8c31
	x/AV9zNnAi2J2GENQXHzq6u/IOGfEBrN2OxYyefbeQJN0Mrrn4kB
X-Google-Smtp-Source: AGHT+IH0HBiv9xojtsirLqVwsKrhBEcPpvem9jXWisw4CBG6ZuEb3+X3anL3lNcMpVwQK3GNkEA0FQ==
X-Received: by 2002:a05:690c:660a:b0:6e3:430c:b120 with SMTP id 00721157ae682-6e3477bad81mr88698067b3.5.1728930228550;
        Mon, 14 Oct 2024 11:23:48 -0700 (PDT)
Received: from localhost (fwdproxy-nha-114.fbsv.net. [2a03:2880:25ff:72::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e332cac1c6sm16249157b3.132.2024.10.14.11.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 11:23:48 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	hannes@cmpxchg.org,
	shakeel.butt@linux.dev,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: [PATCH v2 1/2] mm: skip reclaiming folios in writeback contexts that may trigger deadlock
Date: Mon, 14 Oct 2024 11:22:27 -0700
Message-ID: <20241014182228.1941246-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241014182228.1941246-1-joannelkoong@gmail.com>
References: <20241014182228.1941246-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently in shrink_folio_list(), reclaim for folios under writeback
falls into 3 different cases:
1) Reclaim is encountering an excessive number of folios under
   writeback and this folio has both the writeback and reclaim flags
   set
2) Dirty throttling is enabled (this happens if reclaim through cgroup
   is not enabled, if reclaim through cgroupv2 memcg is enabled, or
   if reclaim is on the root cgroup), or if the folio is not marked for
   immediate reclaim, or if the caller does not have __GFP_FS (or
   __GFP_IO if it's going to swap) set
3) Legacy cgroupv1 encounters a folio that already has the reclaim flag
   set and the caller did not have __GFP_FS (or __GFP_IO if swap) set

In cases 1) and 2), we activate the folio and skip reclaiming it while
in case 3), we wait for writeback to finish on the folio and then try
to reclaim the folio again. In case 3, we wait on writeback because
cgroupv1 does not have dirty folio throttling, as such this is a
mitigation against the case where there are too many folios in writeback
with nothing else to reclaim.

The issue is that for filesystems where writeback may block, sub-optimal
workarounds need to be put in place to avoid potential deadlocks that may
arise from the case where reclaim waits on writeback. (Even though case
3 above is rare given that legacy cgroupv1 is on its way to being
deprecated, this case still needs to be accounted for)

For example, for FUSE filesystems, when a writeback is triggered on a
folio, a temporary folio is allocated and the pages are copied over to
this temporary folio so that writeback can be immediately cleared on the
original folio. This additionally requires an internal rb tree to keep
track of writeback state on the temporary folios. Benchmarks show
roughly a ~20% decrease in throughput from the overhead incurred with 4k
block size writes. The temporary folio is needed here in order to avoid
the following deadlock if reclaim waits on writeback:
* single-threaded FUSE server is in the middle of handling a request that
  needs a memory allocation
* memory allocation triggers direct reclaim
* direct reclaim waits on a folio under writeback (eg falls into case 3
  above) that needs to be written back to the fuse server
* the FUSE server can't write back the folio since it's stuck in direct
  reclaim

This commit adds a new flag, AS_NO_WRITEBACK_RECLAIM, to "enum
mapping_flags" which filesystems can set to signify that reclaim
should not happen when the folio is already in writeback. This only has
effects on the case where cgroupv1 memcg encounters a folio under
writeback that already has the reclaim flag set (eg case 3 above), and
allows for the suboptimal workarounds added to address the "reclaim wait
on writeback" deadlock scenario to be removed.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/linux/pagemap.h | 11 +++++++++++
 mm/vmscan.c             |  6 ++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 68a5f1ff3301..513a72b8451b 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -210,6 +210,7 @@ enum mapping_flags {
 	AS_STABLE_WRITES = 7,	/* must wait for writeback before modifying
 				   folio contents */
 	AS_INACCESSIBLE = 8,	/* Do not attempt direct R/W access to the mapping */
+	AS_NO_WRITEBACK_RECLAIM = 9, /* Do not reclaim folios under writeback */
 	/* Bits 16-25 are used for FOLIO_ORDER */
 	AS_FOLIO_ORDER_BITS = 5,
 	AS_FOLIO_ORDER_MIN = 16,
@@ -335,6 +336,16 @@ static inline bool mapping_inaccessible(struct address_space *mapping)
 	return test_bit(AS_INACCESSIBLE, &mapping->flags);
 }
 
+static inline void mapping_set_no_writeback_reclaim(struct address_space *mapping)
+{
+	set_bit(AS_NO_WRITEBACK_RECLAIM, &mapping->flags);
+}
+
+static inline int mapping_no_writeback_reclaim(struct address_space *mapping)
+{
+	return test_bit(AS_NO_WRITEBACK_RECLAIM, &mapping->flags);
+}
+
 static inline gfp_t mapping_gfp_mask(struct address_space * mapping)
 {
 	return mapping->gfp_mask;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 749cdc110c74..885d496ae652 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1110,6 +1110,8 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 		if (writeback && folio_test_reclaim(folio))
 			stat->nr_congested += nr_pages;
 
+		mapping = folio_mapping(folio);
+
 		/*
 		 * If a folio at the tail of the LRU is under writeback, there
 		 * are three cases to consider.
@@ -1165,7 +1167,8 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 			/* Case 2 above */
 			} else if (writeback_throttling_sane(sc) ||
 			    !folio_test_reclaim(folio) ||
-			    !may_enter_fs(folio, sc->gfp_mask)) {
+			    !may_enter_fs(folio, sc->gfp_mask) ||
+			    (mapping && mapping_no_writeback_reclaim(mapping))) {
 				/*
 				 * This is slightly racy -
 				 * folio_end_writeback() might have
@@ -1320,7 +1323,6 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 		if (folio_maybe_dma_pinned(folio))
 			goto activate_locked;
 
-		mapping = folio_mapping(folio);
 		if (folio_test_dirty(folio)) {
 			/*
 			 * Only kswapd can writeback filesystem folios
-- 
2.43.5


