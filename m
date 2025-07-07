Return-Path: <linux-fsdevel+bounces-54201-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EB0AFBEC0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 01:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26848189F254
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 23:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0249F28ECCB;
	Mon,  7 Jul 2025 23:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7Qdpaxt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B872528C025
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Jul 2025 23:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751932024; cv=none; b=EnlYffMCtb/1TXrnNxFppgkzUzv487UW8SCyziyLPF05oery64V6PptZoSa9Eo3OQWuonBQzofOe3Nac+9ky9VrCyv9Rb3bb380PGQLVlDxR9tykOsIXv6hM3Z1JtLy6vZZmeXmeJJzjdYuLpNLWd0VwiR9VYrPYoagONlcM2i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751932024; c=relaxed/simple;
	bh=lx6B8cE4tR0sSbAEDRM8YJtVnVFq/eMDPyRDOKo2ync=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AjYmw3WqsGzBgAtQZnCQLJVi2ajyVQni4a6nPWdBsniN6f2Qlz6OVqEVJAaM16ewfYMFGfrPHaYZ8mDpsGpNss9wmRfB+2DzT0GlkLnub6iTa/qGPcwW9bPUivVU1sR6vzqvD76iDfL9QYuerKhDuQsA6aNPv3wbSZgrf8YlgLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d7Qdpaxt; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-74b27c1481bso2267682b3a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Jul 2025 16:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751932022; x=1752536822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OdGYSGKF0yFRva8stggfVno3BcRuAvK5kKP1ryZLRnY=;
        b=d7Qdpaxtw7rfaGVD2gKvNFbvXkQ4OLnYmrizMZuDQ8XYhc8WuyXns/sDj63Kdl4vTJ
         fur8r/naN+uIJyXtBrgcBMM4apr/lCqIPx85IeZet8q/vGLglJA50AZtFIoMUAX1C+5D
         6I3PHeG3ZZ7IQM40RWumqXIruU+4RAOL+GJBGVYqL5K2obUPTvjLMT3Dn+fWhOW4l2ot
         /5bksndkGYXJpjdCxreFzqJ7YpmSaYNzYr89a1BzmLgGKasvE/VWHIhXVGZ3asHiaPC0
         sy17FYY9gBzkueaw+FAv/HQ2t3kn1j4QxNxifkZmLLNEjohr6Eoj55Og9w8yXt3UrZ3I
         rq7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751932022; x=1752536822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OdGYSGKF0yFRva8stggfVno3BcRuAvK5kKP1ryZLRnY=;
        b=fA4use5RqA4wT819H1DBguMEYWGg224Gi81zX68P2/95wIo04YNHupfyr/KOx0AbPf
         e0DvrZIZku4lhnuQ5XGBjAMTE3NDth4oLFneOAsEA/G9jXj9dHQJHtgxgA8KZxXbc8rK
         yIzxdA14OCQ3bGNrXEsvaR5YieKuHDeRUIrdUH9pECpHmROyZqcVnSgHcGs0Q0HmolRy
         WqIFCswRkYfgESWTSMYaayqJoL5hcQ2sMJ9aBJ8qNJTzp7yg/dvEduPOR4jbBdSfwHPb
         TABjI45tsA23O92bYUf82CZLRBfPszxAa8AXJOk+Z1UNYpntIMBbYyJS0rCNLoC5sma2
         EGOw==
X-Gm-Message-State: AOJu0YyRyyktMIb296nLUqjwlTx7Vs1GUNjAkdAe0q425yIvEX4g7lXM
	mvpSj9tsmSFfTrdRjLfYpAU8d85Mi95UUk4Y/s8t+j/aRs2Z14IxNgfH
X-Gm-Gg: ASbGncsdswRYiI5Qbvb+R1IEm4kx9KsSAWThHdbLNYWU0B1tcjHC4HsNi3hsitqxolJ
	lchvYuMVFQ0NkJzDZuMLKUit3BjMkIIkn2FEb+8H3/s9ig8mv7IcgctUFwvmExYO1eHhE1UkRoJ
	Z72x0pAZlgMntXPtbRtF06w/RZkNDpKi5qFU9zdXoSlVDL4rw0Fpgtt96iBVuBxU8EudRmPbRv+
	x9ij04Fb2Qjj8xA5+CPvqZ3N0MNLEXuIOKCEYuI/EMLm6caNOSay292FEQ8Y3CMT4OVEHviTpX7
	iPztfHhL0Rg8AEcHWimcj0uAz77MyZAqvynfSjqiw4jKtX4Tr4w/2raHsA==
X-Google-Smtp-Source: AGHT+IHWHr7ssfLlhBYcNXtN/lq/1wEoA1hp95PFcXkQB/s/MLmSSxLOazWdl/RLxCJ8k39mTTfzKQ==
X-Received: by 2002:a05:6a21:920a:b0:1f5:882e:60f with SMTP id adf61e73a8af0-22b438d2707mr1122970637.17.1751932021912;
        Mon, 07 Jul 2025 16:47:01 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:70::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b391adf1f08sm3440595a12.33.2025.07.07.16.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 16:47:01 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	david@redhat.com,
	willy@infradead.org,
	linux-mm@kvack.org
Subject: [PATCH v2 2/2] mm: remove BDI_CAP_WRITEBACK_ACCT
Date: Mon,  7 Jul 2025 16:46:06 -0700
Message-ID: <20250707234606.2300149-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250707234606.2300149-1-joannelkoong@gmail.com>
References: <20250707234606.2300149-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are no users of BDI_CAP_WRITEBACK_ACCT now that fuse doesn't do
its own writeback accounting. This commit removes
BDI_CAP_WRITEBACK_ACCT.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 include/linux/backing-dev.h |  4 +---
 mm/backing-dev.c            |  2 +-
 mm/page-writeback.c         | 43 ++++++++++++++++---------------------
 3 files changed, 20 insertions(+), 29 deletions(-)

diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 9a1e895dd5df..3e64f14739dd 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -108,12 +108,10 @@ int bdi_set_strict_limit(struct backing_dev_info *bdi, unsigned int strict_limit
  *
  * BDI_CAP_WRITEBACK:		Supports dirty page writeback, and dirty pages
  *				should contribute to accounting
- * BDI_CAP_WRITEBACK_ACCT:	Automatically account writeback pages
  * BDI_CAP_STRICTLIMIT:		Keep number of dirty pages below bdi threshold
  */
 #define BDI_CAP_WRITEBACK		(1 << 0)
-#define BDI_CAP_WRITEBACK_ACCT		(1 << 1)
-#define BDI_CAP_STRICTLIMIT		(1 << 2)
+#define BDI_CAP_STRICTLIMIT		(1 << 1)
 
 extern struct backing_dev_info noop_backing_dev_info;
 
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 783904d8c5ef..35f11e75e30e 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -1026,7 +1026,7 @@ struct backing_dev_info *bdi_alloc(int node_id)
 		kfree(bdi);
 		return NULL;
 	}
-	bdi->capabilities = BDI_CAP_WRITEBACK | BDI_CAP_WRITEBACK_ACCT;
+	bdi->capabilities = BDI_CAP_WRITEBACK;
 	bdi->ra_pages = VM_READAHEAD_PAGES;
 	bdi->io_pages = VM_READAHEAD_PAGES;
 	timer_setup(&bdi->laptop_mode_wb_timer, laptop_mode_timer_fn, 0);
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 72b0ff0d4bae..11f9a909e8de 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -3016,26 +3016,22 @@ bool __folio_end_writeback(struct folio *folio)
 
 	if (mapping && mapping_use_writeback_tags(mapping)) {
 		struct inode *inode = mapping->host;
-		struct backing_dev_info *bdi = inode_to_bdi(inode);
+		struct bdi_writeback *wb = inode_to_wb(inode);
 		unsigned long flags;
 
 		xa_lock_irqsave(&mapping->i_pages, flags);
 		ret = folio_xor_flags_has_waiters(folio, 1 << PG_writeback);
 		__xa_clear_mark(&mapping->i_pages, folio_index(folio),
 					PAGECACHE_TAG_WRITEBACK);
-		if (bdi->capabilities & BDI_CAP_WRITEBACK_ACCT) {
-			struct bdi_writeback *wb = inode_to_wb(inode);
 
-			wb_stat_mod(wb, WB_WRITEBACK, -nr);
-			__wb_writeout_add(wb, nr);
-			if (!mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK))
-				wb_inode_writeback_end(wb);
+		wb_stat_mod(wb, WB_WRITEBACK, -nr);
+		__wb_writeout_add(wb, nr);
+		if (!mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK)) {
+			wb_inode_writeback_end(wb);
+			if (mapping->host)
+				sb_clear_inode_writeback(mapping->host);
 		}
 
-		if (mapping->host && !mapping_tagged(mapping,
-						     PAGECACHE_TAG_WRITEBACK))
-			sb_clear_inode_writeback(mapping->host);
-
 		xa_unlock_irqrestore(&mapping->i_pages, flags);
 	} else {
 		ret = folio_xor_flags_has_waiters(folio, 1 << PG_writeback);
@@ -3060,7 +3056,7 @@ void __folio_start_writeback(struct folio *folio, bool keep_write)
 	if (mapping && mapping_use_writeback_tags(mapping)) {
 		XA_STATE(xas, &mapping->i_pages, folio_index(folio));
 		struct inode *inode = mapping->host;
-		struct backing_dev_info *bdi = inode_to_bdi(inode);
+		struct bdi_writeback *wb = inode_to_wb(inode);
 		unsigned long flags;
 		bool on_wblist;
 
@@ -3071,21 +3067,18 @@ void __folio_start_writeback(struct folio *folio, bool keep_write)
 		on_wblist = mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK);
 
 		xas_set_mark(&xas, PAGECACHE_TAG_WRITEBACK);
-		if (bdi->capabilities & BDI_CAP_WRITEBACK_ACCT) {
-			struct bdi_writeback *wb = inode_to_wb(inode);
-
-			wb_stat_mod(wb, WB_WRITEBACK, nr);
-			if (!on_wblist)
-				wb_inode_writeback_start(wb);
+		wb_stat_mod(wb, WB_WRITEBACK, nr);
+		if (!on_wblist) {
+			wb_inode_writeback_start(wb);
+			/*
+			 * We can come through here when swapping anonymous
+			 * folios, so we don't necessarily have an inode to
+			 * track for sync.
+			 */
+			if (mapping->host)
+				sb_mark_inode_writeback(mapping->host);
 		}
 
-		/*
-		 * We can come through here when swapping anonymous
-		 * folios, so we don't necessarily have an inode to
-		 * track for sync.
-		 */
-		if (mapping->host && !on_wblist)
-			sb_mark_inode_writeback(mapping->host);
 		if (!folio_test_dirty(folio))
 			xas_clear_mark(&xas, PAGECACHE_TAG_DIRTY);
 		if (!keep_write)
-- 
2.47.1


