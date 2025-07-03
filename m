Return-Path: <linux-fsdevel+bounces-53818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB4FAF7E2B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 18:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 159841C88590
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 16:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9481925A659;
	Thu,  3 Jul 2025 16:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ErRuanKo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C46025A2C6
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Jul 2025 16:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751561243; cv=none; b=lNRbeciB6d70w+mpZKoCSJW5wzlMOY3T+CcR2Lv9bVuCZmqVQZlxDLOMwIUhqToNnaG3wl3AGwPRH/k6dbM90PDDlMW6yxKD/D9GM1fIzL65BV5DI1Jl8afE9ntwSpehODHjpocjzt1P79SPN6Y0+lMMzmLXvv5mY66pOwyXVxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751561243; c=relaxed/simple;
	bh=ymN0caO638YIrBUfIvDxjodSeoG5pQRZOYD4b/rqSDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DIgyR6vMTrjnkuo6srVnCXMQM36jT0fBR9SPsqTz8TR4/QSCu6SzA5YOJXABlfWW+mnyxZQXBEpEZqc8NtiFw6druRJpRr0GxLpwDg3SL2RvcEefQJQYwXiI7bGDkmiTsTil7DPxPbM3kx6qczjJHGKd4fO7R2XJ/rCV3684b1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ErRuanKo; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2353a2bc210so1790315ad.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Jul 2025 09:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751561241; x=1752166041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LzPrs/cw6/T8P+hvS+w5GXjybxPCP9SB4/u8tu5ZvA0=;
        b=ErRuanKo/YNlamsCVc6W8TJrkseAw0ugjbV8K/7lFLQJoYpFjHfS2edmQyNs03wTfA
         7iC3KJetbQLQA2Nqoss9K4EPrYV6pLnq0ok/ggrUrgRMri8uL4pH+HsZh+tpJDjioy0r
         L2jyISECGyZDqopt7/44d8H1ptqausQLadTjCOPjCymCpeYRvpdjQdVRFLG415NMTnsY
         fBZeEKAMpFkFwe0ykn9nCzzluqxdmfsQb6/Ny7KyXkOybUjZUe+wliWCnCdYcKtnTDF3
         K6aksixVAAP3SvVDmG6/ig2fLRHh/U2J56Y/f6gpFAUq0Kqd5sBAJDPuHL/q+KJrGgRd
         wi2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751561241; x=1752166041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LzPrs/cw6/T8P+hvS+w5GXjybxPCP9SB4/u8tu5ZvA0=;
        b=bv06KQb9tM/NaMsfD1XBNM8YFXXBOKKAjSjPfwb+uxZA+l+nQakH0VMOOQrgKdm9mC
         E2uc7x8q6ySTIBCrz+OrBGgKVYEFP+MdWjeRFYX6RROLjzTnEVCzDUgZH9TB5HhSwlO+
         rqkhl/H95cENfgljnuGQypUrktWtruzRsTKVAWrtNsCpmRs/9pqWUDe2DX2m/COWiRUX
         25qBl2BX7I9xmjAxLl37INVOx3MVPFc9etOLDtAghNIpOKGcMAwKf4z9VLZpV1VXtYOY
         QNJddp4Z0fjxeimPYIpQXXGUSSIvkyPrj2LZJwDZ4V2Oy4XsUz/Bv6h/zwr84GO6Q6mD
         Suyg==
X-Gm-Message-State: AOJu0YyamoOFFetP5CnBcz4i+iBgxzetamHJR0kyaEt26At13jPzVx6R
	wx34cVqH5PDyG8e5wa3T6rftv/7HVN3fTaupfwjAlCGOVDPxD8ptll0w
X-Gm-Gg: ASbGncvHL1AadLU23i3tHvETL5y/fNie71pzbtcE6EhfI86nlwfG2astVda2JgxzyPc
	tJyZkpeMAYVsQpVvFjMBcFzGm36KIMpN8TFK5OBGltoLEDtk7JT5QgB/kuPOOpVmCF6dPhIu4N3
	fIbJnxo1oNUGCG3xc6wxUhNbYk+QT5N46t8LQdpQMMp1dZcfPB67X1Yr+VImFwQCH/ucaPqN2gM
	pHHYTUAFZDH6bnltBN2GMohBbWXTMPkIad9ER1I0BgQpAe58u+koIDhZdzO93JWFasrUFNRdWm0
	p4OFNsM7+gb3t9YqbMYqR7PysxI5/i7yDs+CvKjigc27ASUUn13rI3Jr
X-Google-Smtp-Source: AGHT+IEd1BiAxp7iO+s7y67gtPGe/U/cvIipcgPzIxO7BSfY4uZv8ogk4V/ZUl/rIjo55tQr2w+uIw==
X-Received: by 2002:a17:902:d48e:b0:237:ed8e:51d4 with SMTP id d9443c01a7336-23c797a854fmr67215695ad.24.1751561240756;
        Thu, 03 Jul 2025 09:47:20 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8455b966sm84775ad.101.2025.07.03.09.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 09:47:20 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	willy@infradead.org,
	linux-mm@kvack.org
Subject: [PATCH v1 2/2] mm: remove BDI_CAP_WRITEBACK_ACCT
Date: Thu,  3 Jul 2025 09:45:56 -0700
Message-ID: <20250703164556.1576674-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250703164556.1576674-1-joannelkoong@gmail.com>
References: <20250703164556.1576674-1-joannelkoong@gmail.com>
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


