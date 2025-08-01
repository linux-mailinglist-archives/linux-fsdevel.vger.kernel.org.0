Return-Path: <linux-fsdevel+bounces-56489-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EC9B17A98
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 02:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EB735A0A7B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 00:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7824C1C683;
	Fri,  1 Aug 2025 00:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQkcPuN2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBAE8F6F
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Aug 2025 00:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754008066; cv=none; b=adMCRPdsIPxEF+9rIr3vutTwJMmseJ7XGpsqsuNsDjf4lEBrX8x5RNX/CGo/Ufu5ErmmKy3dj8OqZFF17Y0uG9tgBUy/1sEGQhTGTnB9uhZzDDzXmiC0zPqYRK8NmY3y1goQ7nKZXsKW+ILjqbYMO5eUFaBdcZaYe9ykuqNFqek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754008066; c=relaxed/simple;
	bh=/t8ma1Dcq0xFOkZJwC8jlm3tu1qaRJJ+ns9tQzbew18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ru2DCty/fefdPsgywFL+PIoA3eov8H+T//ZlDVgj5/IZlJiRB/uyx4cdkBwyrVRYHL8ofCOU5mBwU12Gov4EPtKlGa+ruTBQWkx1zHdv7QEM+RMppR5DIFBOpqWxZb6ripBrcH909/yy9U0LV5TwYVbnlVQLrn7NyGBwy1uBSbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQkcPuN2; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3137c20213cso1196478a91.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Jul 2025 17:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754008065; x=1754612865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2iL5+/Du77zPuPT5BBdeDwRBoU+0kycMSYogQWZ1wZc=;
        b=PQkcPuN2stkfl8YPdvGizL4eDUHPd5cvPyeUxjBrk/9j1MeFPErJopO2RA+fJFUhSB
         o0scHbSCaV8Dc26nlFYSiqN/jJYO35XkKUNLtx/5nPfrokiO1lKF2rgBhZ06/6+rnrih
         TVLhcO6SRqTrcRt2fE3SFoI5xJey3zJeYycDxEIx1qz+O2Ao9z/tWi42n/YS+NdKxQKa
         uk2i4dzMZWPKLJwPL/n0qqVqeTUXGd+IFz56DnJ1rKzetxoqHr3zJtoBzLbA3G8d4GA8
         52iBNd5yGAB8k/2w42lMHa+au7i2sLMsSSEz9lmihtzEKqp6ckfdBfTHuQdf253smk96
         0zFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754008065; x=1754612865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2iL5+/Du77zPuPT5BBdeDwRBoU+0kycMSYogQWZ1wZc=;
        b=pRg4uR0JLWuwg+uGSsziBnSoMcbqhHIS9rXvA7gAceoGMN3jEknlFDaCTyBqKpN1h6
         FualsrwzUaF7ZnWVIJL9rbKfPMy4Imi9M1bh6T8jNxLFXBd9M68u0ZTnGxV9A2hqb7XA
         PTp/OxYMgv7NBHEarDamZMWcX7/CmAn7jhNpjSiNiFPs4ae4Ep44uKPPXc1Vofw6X4zM
         mkkGBQenQWiwhTVpxmQouXmE7jebUrvKKIE9Ch353zq0Ph51bKd23Kz4wzBdZmQ/oIvI
         gdWZwxi61dbwucMuEXxc1j9ymca2MSF39JFXdLbIz8sz+wU6TuUuDZfSBiAZpxgJ73pW
         E3YQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSA0rkyYQJN5x8Cn2Q7rFtXdLW+u5yLhdU6/3qFXBROLa//e9xdTuI5sl1MPzbM0CECGa+L1Siw0R6mCv8@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2zUQDmq3rpLjfXfD7mYtdqMGjQKTdLoY4ZFGAEhdXN493MJcX
	zRBWSHmOEE0ovAGC4LIdyFW7BNqLWVSZPcsgQFLp34CUiYZwh0aiVPkQAkj73A==
X-Gm-Gg: ASbGncu7ApFpVCVvIFJQSJABgEpF4VLoDHZeZ2kDwQKRumQtof0n2TFOaCObnKInOuA
	4eKEH9y9o+jNFV+BK5Q17lwJJsbPFvtQnKkND3k1xXtTCoUirxRwvX6xoSJ+cYr/6vZsCCaTasO
	wD1VbYk5S7G9iRcsLbyHRrjfTw11Wu6vhf6hRC+28JxwWlTqXr/JNTC4Ppdgr1kSSM0pogcoDkO
	pcXru9xlyXAzHwUer9rgzdcA2n/gCEL686hsmAOELn39iZX/X1cvj+ayhuQWG/LVH/pS/EWJ8wF
	O6kKBDsjO9MZ6zho4SIz2nhP7b4pmnwZ5OQodzk0gqrIf/qmgPbf/SAab6KIi+ICcDY1IXo30uT
	Vr0oxvD19V8IA7UY3nUta01cA3vA=
X-Google-Smtp-Source: AGHT+IFTYp2XQLCKe8uWgctEzQRHy84xjDVpnH4CLvIVboTXgumwtlR+C3477qy8FGVR/8oe4PAq7A==
X-Received: by 2002:a17:90b:1d87:b0:31f:32cd:97f0 with SMTP id 98e67ed59e1d1-320fb779607mr1021381a91.1.1754008064549;
        Thu, 31 Jul 2025 17:27:44 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3207edb588fsm3041461a91.27.2025.07.31.17.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 17:27:44 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: linux-mm@kvack.org,
	brauner@kernel.org
Cc: willy@infradead.org,
	jack@suse.cz,
	hch@infradead.org,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [RFC PATCH v1 04/10] mm: pass number of pages dirtied to __folio_mark_dirty()
Date: Thu, 31 Jul 2025 17:21:25 -0700
Message-ID: <20250801002131.255068-5-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250801002131.255068-1-joannelkoong@gmail.com>
References: <20250801002131.255068-1-joannelkoong@gmail.com>
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
index 8cf4a1dc481e..327bae3f724d 100644
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
@@ -1209,7 +1210,8 @@ void mark_buffer_dirty(struct buffer_head *bh)
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
index 312209e0371a..0ae2c1e93ca5 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1204,7 +1204,8 @@ void end_page_writeback(struct page *page);
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
index 2afdfaa285a6..b0ae10a6687d 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2677,7 +2677,7 @@ EXPORT_SYMBOL(noop_dirty_folio);
  * NOTE: This relies on being atomic wrt interrupts.
  */
 static void folio_account_dirtied(struct folio *folio,
-		struct address_space *mapping)
+		struct address_space *mapping, long nr)
 {
 	struct inode *inode = mapping->host;
 
@@ -2685,7 +2685,6 @@ static void folio_account_dirtied(struct folio *folio,
 
 	if (mapping_can_writeback(mapping)) {
 		struct bdi_writeback *wb;
-		long nr = folio_nr_pages(folio);
 
 		inode_attach_wb(inode, folio);
 		wb = inode_to_wb(inode);
@@ -2733,14 +2732,14 @@ void folio_account_cleaned(struct folio *folio, struct bdi_writeback *wb)
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
@@ -2771,7 +2770,8 @@ bool filemap_dirty_folio(struct address_space *mapping, struct folio *folio)
 	if (folio_test_set_dirty(folio))
 		return false;
 
-	__folio_mark_dirty(folio, mapping, !folio_test_private(folio));
+	__folio_mark_dirty(folio, mapping, !folio_test_private(folio),
+			folio_nr_pages(folio));
 
 	if (mapping->host) {
 		/* !PageAnon && !swapper_space */
-- 
2.47.3


