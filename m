Return-Path: <linux-fsdevel+bounces-59672-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1D7B3C5AB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Aug 2025 01:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DAF63B62CA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 23:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7942773F7;
	Fri, 29 Aug 2025 23:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RK4h5gz2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7118263C8E
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 23:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756510798; cv=none; b=KEyk7pclnLAfzNuYcAgdcOr8GzqKHKs9t8yybyK6ucW/o/T8OMOsPKt1m9X4PkJvPEoQuN+Um91zoR4Ax0uM+zwixGClphzBxkLmZV8PT4bfw3JfkHlDssUsQ8oZ6071Bzhr0DWqY8eemFaBdEdl8oYyPQd4rzacIpH70i9Njwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756510798; c=relaxed/simple;
	bh=wUySpjNx31w1tpZbax7KkmSrZ9VNgrM6aOqJqsRLPdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B20XemvMCKbIiH9XeOEMrlHy8YbUazdMlzDXCynbcdJeZq+yQK3wU70JsIroaDNA6KpsC96b6P3MVjUriC6emn68FBOgTnTC7glaB9sNREq4UiYr2k18kb8nkMHgzY/GkcYc0np8qxjxm3Y1H1IEhAkb0AskxpPmX/8c+vsU/7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RK4h5gz2; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-771ed4a8124so2693727b3a.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 16:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756510796; x=1757115596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fgzqi0XWIhbNbxLZHOGh+9AkeMfa8I23tDcpLaOZWEA=;
        b=RK4h5gz2IvEFKssY6T9siIxEuOlU9rdho1NN1hpooEF/CoYYJ8xAyv8h9T54KdPVGT
         RzHx6FGXp1HPPkSJNm/2lm3HnhIpdDENY/z2QtPq3wl7mm6kzqRLteCEeux+vON+6V9r
         b+wzV9TEIbPgouUsi68cntoY8uIImzf4BWM+lbM/06x1RhPRzFssRxnjtZ8TSza+kQKL
         pjJB02OUnbAaVGhhXGV5ii9trCEyEPLifyxjDFg2SD+tOsCClGwIDtTLdUWg++2NqYil
         q3Sy7Y5VtVEuHCDZOqXHC4WR/WPxQLRrn3lYc53t3UBnQ5TJTn+nypp6kF1Vn/GYyty6
         ou5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756510796; x=1757115596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fgzqi0XWIhbNbxLZHOGh+9AkeMfa8I23tDcpLaOZWEA=;
        b=p2bvUMPKgeBfGHCJjQO2EgLPpAepzRUSlBv6lYjHOQu3MYwqLY3vyFEeV6+QWtRuwx
         AHqaWW/wWRV5YIdo1Cb9NZJ2BYt0LMBXrTFNHMpyp6byCcrbvOIdZab9Ez3minHsUuyJ
         yFh5UMrm/JNS5ik+Aqi6nMrYdq9niJ0vSXdLDaDnaFJeXBefxmaGSqbzt8uFstI5HPUq
         5PGyGN0RD8fJz/CouooGf8YDWPOMfPQZ0X834yUtkGxucVDby/GJgKTkDsWPVR7RXI/6
         2Pf1w5uGmN6q/4PGZBf4Ak5RHO8MFhAJqXf9PPfmL0dsuJLQ2l1ylGECd5WVdMPY4X3N
         QsLw==
X-Forwarded-Encrypted: i=1; AJvYcCW77CAZYKoPtmevnFxz1AgnxMvqYC+n9VfF+1RA8GA7Zuj6CI7igoduGB7qirGnKlPrC//bDpoNB+GXKP5X@vger.kernel.org
X-Gm-Message-State: AOJu0YwliTegCHERvArq8Aih5RyJWUr0TcTqln9E+jOz58lC6RGXJf6O
	7Z5rYR9AMEJICCiovggf34IGiC8cC1e/7vmqFmdcAcmEF7DL3wdIwdKP
X-Gm-Gg: ASbGncv9U3+OcnE3Xm4kdEUZrfO17lJdzJPVbQEPMrQUUzDu2vPIs2zMJjPDmiH3jlk
	F+XedfsHx30l9BnxGbSHNwTIAY9z7tw+E69It+wSBG3w61BUZ20kjQ7FE6N9I+kK1JyH03oaR9T
	VKn9O/5Ym0u8lsKLdfWGYacO+psOBCVDoAGDNn7Gj+E450S3Uw5D4nCq8UXgXcM1P2UchM4nREp
	GzwiyxweLbRifXnQaiSWAB93pUKc/7KM6bdV8qLktUfVrP5g9P4NXOcJel8JorjTQGIx17DHMbX
	/Ks8lPGsCnP/XXfNGx1sLcxEa/WPN3WIR3LSp/72M60SLTzZflIew2+CRadZU6b/JlrjPqLNO5t
	XB2/O0DPig4ZWZq9IjA==
X-Google-Smtp-Source: AGHT+IG2yfv+4fw5qf3y8AXdHCC+mQ4DFzEwQ/Wp94S5UG+OdFL1J6XJ58uHN/rhdl/B2IeiHALL5g==
X-Received: by 2002:a05:6a20:394b:b0:243:25b0:2324 with SMTP id adf61e73a8af0-243d6f793b2mr491573637.50.1756510795887;
        Fri, 29 Aug 2025 16:39:55 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:13::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a26ac0esm3456962b3a.2.2025.08.29.16.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 16:39:55 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: linux-mm@kvack.org,
	brauner@kernel.org
Cc: willy@infradead.org,
	jack@suse.cz,
	hch@infradead.org,
	djwong@kernel.org,
	jlayton@kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 04/12] mm: pass number of pages dirtied to __folio_mark_dirty()
Date: Fri, 29 Aug 2025 16:39:34 -0700
Message-ID: <20250829233942.3607248-5-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250829233942.3607248-1-joannelkoong@gmail.com>
References: <20250829233942.3607248-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an additional arg to __folio_mark_dirty() that takes in the number
of pages dirtied, so that this can be passed to folio_account_dirtied()
when it updates the stats.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/buffer.c             |  6 ++++--
 include/linux/pagemap.h |  3 ++-
 mm/page-writeback.c     | 10 +++++-----
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 6a8752f7bbed..65c96c432800 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -751,7 +751,8 @@ bool block_dirty_folio(struct address_space *mapping, struct folio *folio)
 	spin_unlock(&mapping->i_private_lock);
 
 	if (newly_dirty)
-		__folio_mark_dirty(folio, mapping, 1);
+		__folio_mark_dirty(folio, mapping, 1,
+				   folio_nr_pages(folio));
 
 	if (newly_dirty)
 		__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
@@ -1203,7 +1204,8 @@ void mark_buffer_dirty(struct buffer_head *bh)
 		if (!folio_test_set_dirty(folio)) {
 			mapping = folio->mapping;
 			if (mapping)
-				__folio_mark_dirty(folio, mapping, 0);
+				__folio_mark_dirty(folio, mapping, 0,
+						   folio_nr_pages(folio));
 		}
 		if (mapping)
 			__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 362900730247..48745f8f6dfe 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1223,7 +1223,8 @@ void end_page_writeback(struct page *page);
 void folio_end_writeback(struct folio *folio);
 void folio_end_writeback_pages(struct folio *folio, long nr_pages);
 void folio_wait_stable(struct folio *folio);
-void __folio_mark_dirty(struct folio *folio, struct address_space *, int warn);
+void __folio_mark_dirty(struct folio *folio, struct address_space *, int warn,
+		long nr_pages);
 void folio_account_cleaned(struct folio *folio, struct bdi_writeback *wb);
 void __folio_cancel_dirty(struct folio *folio);
 static inline void folio_cancel_dirty(struct folio *folio)
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 65002552458a..e66eef2d1584 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2675,7 +2675,7 @@ EXPORT_SYMBOL(noop_dirty_folio);
  * NOTE: This relies on being atomic wrt interrupts.
  */
 static void folio_account_dirtied(struct folio *folio,
-		struct address_space *mapping)
+		struct address_space *mapping, long nr)
 {
 	struct inode *inode = mapping->host;
 
@@ -2683,7 +2683,6 @@ static void folio_account_dirtied(struct folio *folio,
 
 	if (mapping_can_writeback(mapping)) {
 		struct bdi_writeback *wb;
-		long nr = folio_nr_pages(folio);
 
 		inode_attach_wb(inode, folio);
 		wb = inode_to_wb(inode);
@@ -2731,14 +2730,14 @@ void folio_account_cleaned(struct folio *folio, struct bdi_writeback *wb)
  * try_to_free_buffers() to fail.
  */
 void __folio_mark_dirty(struct folio *folio, struct address_space *mapping,
-			     int warn)
+			     int warn, long nr_pages)
 {
 	unsigned long flags;
 
 	xa_lock_irqsave(&mapping->i_pages, flags);
 	if (folio->mapping) {	/* Race with truncate? */
 		WARN_ON_ONCE(warn && !folio_test_uptodate(folio));
-		folio_account_dirtied(folio, mapping);
+		folio_account_dirtied(folio, mapping, nr_pages);
 		__xa_set_mark(&mapping->i_pages, folio_index(folio),
 				PAGECACHE_TAG_DIRTY);
 	}
@@ -2769,7 +2768,8 @@ bool filemap_dirty_folio(struct address_space *mapping, struct folio *folio)
 	if (folio_test_set_dirty(folio))
 		return false;
 
-	__folio_mark_dirty(folio, mapping, !folio_test_private(folio));
+	__folio_mark_dirty(folio, mapping, !folio_test_private(folio),
+			folio_nr_pages(folio));
 
 	if (mapping->host) {
 		/* !PageAnon && !swapper_space */
-- 
2.47.3


