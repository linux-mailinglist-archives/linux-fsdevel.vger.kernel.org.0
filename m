Return-Path: <linux-fsdevel+bounces-31789-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E010499AEB8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Oct 2024 00:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CC8828406F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 22:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4111D3578;
	Fri, 11 Oct 2024 22:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXphMzjp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7915D1D14E0
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 22:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728686230; cv=none; b=iwWJyKuXIPv2sKqfxFh245cYzF1e4NbMYMmVYN1ro6pXkT3TnUwWIV9wzCCkYU2XYHJLk5EL1ABckn5/pPZ1pr+SCFbgsoWHx+rz9jd2wl5hOezYspa86A5F/dJWlquLYJC/DXJJ0P0RCwBVjJSfl8y4hYfTp194MdheJRIO9rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728686230; c=relaxed/simple;
	bh=1gxqPesjvRjJIOKvNfbfNsc5I925I6Rn1NxNRCG++gs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WtCjtsHrvqjvkfAhD/4L0lRLM2i82gt4vpEFje8nO2lT7/l0b5qOzJ30j5BxRTge8R+ERPwokPaqSsBWb6NFKG4he9vjuLje8Im/otDmFnzLQDhCeG3Uwob7D2yvqLPHqeAZDU/7HvsO80CaCMaD8FFt/9Jgy4cpDNRZk7sPqjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MXphMzjp; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6e2e3e4f65dso26491257b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 15:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728686227; x=1729291027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EVBwS0kB/21OlCWBOP74hlFI7tXMz3WpRGWEmLnozGQ=;
        b=MXphMzjpuRf4Wg2R1XHvr09tgQXQqjvBxhX3g/SrzOLlgu2oYFIcAAs7aQMyUhFHe/
         +dCBmjrAWv7UFYkztlAtg/Kp4LhzWLRA19J94cv42d/5J0N/UPFEBKMYKpUqGlP1d2pz
         wRM/GiI3eKAna21pCe+bFmiPXOt3J3iPEQJBhVhKVXlRd72nTF7Vq8Fy3cnVwTCJqK9S
         qtpRNo8N7wNBRsmxLPn+0ISDZv6MqrKYQWRXTjuEash1bKPDOoBn4y5CwjgJWNpI10co
         qudiYswINdgicORMtrKIzQDb1hpPWIQfm3v8rsPsAtgXtJIN3nC+nClOezPFEw3jtUct
         zKdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728686227; x=1729291027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EVBwS0kB/21OlCWBOP74hlFI7tXMz3WpRGWEmLnozGQ=;
        b=Qz3tkjVOh4GvB3auiUmZPEkX8QNMwNgLP0CRNucm+HlacDoi91lYR8SI6w33fn7l/c
         HbNPQkRp8WkiKGS/x56eCHOuzPKlmdUy85YxbMNoZQyPXaJQ9USf3f1ydgve3iC1oRGx
         EYNXHIIziXdD3i0vRpKKlRbedphi4RPBWK1ph6+iVddx1tASTg4ASsNHb66d0Q8B/sIo
         jh3Hgvx/WBW1HcL04Z/wAI1Rdl+2puKC4Zxwg4z8pU1ny+4suTsNXkh0S6pSXUBie1up
         kffA57I7pG9sFeKsmcGHYXaC23WXYhopZjrwa8zvmPxH+CDvgjkGafEWEKKlUZMlyw8y
         EN4g==
X-Forwarded-Encrypted: i=1; AJvYcCUjXbhOx3FZQmTybMptsQdLJZa2aJhcVd/OMIwUvLqWh3/pcjYV48QRe5OvrhiXM0pyNIRnuIBg4tHNl1I8@vger.kernel.org
X-Gm-Message-State: AOJu0YwMm5BjJ/V2xn0rjCwzfkmEopNs9BtwNAof64txPCpWT0B8Wrd9
	Vf/0wccdPbY8dUfjcszRtjqxIen8jxP7VUduv0pw7CMwfK/oqkbk
X-Google-Smtp-Source: AGHT+IE2ggII9zuF93xLkN5tvo1f9eFYdZNuT8JapHPFW9KMeFDqXbm+s7xph1uIjxQ11M/0r9QoNg==
X-Received: by 2002:a05:690c:2892:b0:6e3:21a9:d3c4 with SMTP id 00721157ae682-6e3477c05ddmr28910037b3.1.1728686227375;
        Fri, 11 Oct 2024 15:37:07 -0700 (PDT)
Received: from localhost (fwdproxy-nha-113.fbsv.net. [2a03:2880:25ff:71::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e332bad6dasm7703447b3.73.2024.10.11.15.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 15:37:07 -0700 (PDT)
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
Subject: [PATCH 1/2] mm: skip reclaiming folios in writeback contexts that may trigger deadlock
Date: Fri, 11 Oct 2024 15:34:33 -0700
Message-ID: <20241011223434.1307300-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241011223434.1307300-1-joannelkoong@gmail.com>
References: <20241011223434.1307300-1-joannelkoong@gmail.com>
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

This commit allows filesystems to set a ASOP_NO_RECLAIM_IN_WRITEBACK
flag in the address_space_operations struct to signify that reclaim
should not happen when the folio is already in writeback. This only has
effects on the case where cgroupv1 memcg encounters a folio under
writeback that already has the reclaim flag set (eg case 3 above), and
allows for the suboptimal workarounds added to address the "reclaim wait
on writeback" deadlock scenario to be removed.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/linux/fs.h | 14 ++++++++++++++
 mm/vmscan.c        |  6 ++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index e3c603d01337..808164e3dd84 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -394,7 +394,10 @@ static inline bool is_sync_kiocb(struct kiocb *kiocb)
 	return kiocb->ki_complete == NULL;
 }
 
+typedef unsigned int __bitwise asop_flags_t;
+
 struct address_space_operations {
+	asop_flags_t asop_flags;
 	int (*writepage)(struct page *page, struct writeback_control *wbc);
 	int (*read_folio)(struct file *, struct folio *);
 
@@ -438,6 +441,12 @@ struct address_space_operations {
 	int (*swap_rw)(struct kiocb *iocb, struct iov_iter *iter);
 };
 
+/**
+ * This flag is only to be used by filesystems whose folios cannot be
+ * reclaimed when in writeback (eg fuse)
+ */
+#define ASOP_NO_RECLAIM_IN_WRITEBACK	((__force asop_flags_t)(1 << 0))
+
 extern const struct address_space_operations empty_aops;
 
 /**
@@ -586,6 +595,11 @@ static inline void mapping_allow_writable(struct address_space *mapping)
 	atomic_inc(&mapping->i_mmap_writable);
 }
 
+static inline bool mapping_no_reclaim_in_writeback(struct address_space *mapping)
+{
+	return mapping->a_ops->asop_flags & ASOP_NO_RECLAIM_IN_WRITEBACK;
+}
+
 /*
  * Use sequence counter to get consistent i_size on 32-bit processors.
  */
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 749cdc110c74..2beffbdae572 100644
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
+			    (mapping && mapping_no_reclaim_in_writeback(mapping))) {
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


