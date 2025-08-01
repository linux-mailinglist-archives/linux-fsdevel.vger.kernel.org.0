Return-Path: <linux-fsdevel+bounces-56488-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D112FB17A97
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 02:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E4E8546795
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 00:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FD61C69D;
	Fri,  1 Aug 2025 00:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2HGsK2D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D604BE49
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Aug 2025 00:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754008063; cv=none; b=BgeuOeDANoPg56VGgtjvBKw451dCO8d2RZX/bNhgj7v36AwaSXNAAZzJpso6VeoaIddtSoRq/MA6yB9mpfhZmJOsxl/MsDFFCs7SkvC+6T9nJ9DTycUUgP1Nw2z0XUM5QKV9kLzIDaF8a3YpCsMg5Y/6PMxBvhS1JFZpJXyJRkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754008063; c=relaxed/simple;
	bh=HIpv3/Qd6+bCTLMue6qgkGz5g7VjSzVmTADUJMVs0R0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kue98cTHczWWH3KNJEZBj32srajQIKtBSyF5UapIUygT8U30xWqf57eCqAGJTILBv/tKhZlcivhztz9uIvpNuJfRuSAHKWKbOE6FRiCQanqxFGDdeyZWkXMK1qhociunzHbamhGDS/LcKpabPBjkRnN3cruYPkUzaa7hxfwDOf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V2HGsK2D; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-313a001d781so946387a91.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Jul 2025 17:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754008061; x=1754612861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6PfFH/5CksO26SsqXvAjBIPtqYbrdkRKJgAw7r8E6gs=;
        b=V2HGsK2DlsDZnLwdC+yOImL/vHy4qm7mtXnLLp0HDqRocGQzcFj3QHa2VazjdMqR+c
         mrYgM81Abs3ZGBQzhJvi+Pz8IrAjIX2NaHk8UN5o1nW6XosqBRQJcyS8Mgrz0BQRHcV5
         CQOwCrtP/DkkThfMvEeBdW33/GgCiCDtlOyLzZj2ZJ5MfhzE0YKHirWRTycbKAcZyqU4
         gMCuvP3fpU3cmNCX/msgAniDisE52OyKDOjuZv7f7AmTlTm7ftWuzHrX83jmagOIwCN7
         Iree7DVsvx4QbwCTuzmYnyHKsCSP4fMF2YRusxU6cbO/agxFG8b7fdhdEc21EzpW4yXb
         SuOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754008061; x=1754612861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6PfFH/5CksO26SsqXvAjBIPtqYbrdkRKJgAw7r8E6gs=;
        b=nuK30RPuZB0eKfiIpHPmj3RYwoqw55zgMGk15j4rWV8Wrz8bOBDpNHIrxTdp7COdQn
         Tkhb1QEIyrXwMOFtDwzoYmWRx8jJ5N8xJrQSBJB+ElGf4aCgmtfRyCWM9VK9DcRb9Q5K
         jFR5CgCL01KDL0ZGNmTBmAJtKeC7HMJzYF4o/dfc/eQOYwt3LclRxpHTNqkiR6lrrxYg
         dG56aQ6W2csKWoRt8yX9IxfXxWsefuT0FrsKSt92QwJTQ1Z2iC+tzwLfC+ppnBZIboG6
         DWQh002dM0XWUBGmPIOXjzHTnAtDm1KcZLXbCskQqezlrH6ieRDK3hyi0v2bV9S1Hfrb
         lEZA==
X-Forwarded-Encrypted: i=1; AJvYcCUKvIJF4zHPlVJb6xf++VYXKnpYrc+/0lYckkeihZelP6ACWqDF+kS7lseiGknBpvmB40l8zpV+RCsTF2YA@vger.kernel.org
X-Gm-Message-State: AOJu0YyS93CkNcp4F7gOv/iOKir6tmLIVZZ042xO7WzNejRqXHWrH7U2
	aGNXUSOebe+bIPkjpM8fzB+WgTKTniVsLoBkJYKOREvt0+thAhyd79fU
X-Gm-Gg: ASbGncuiE3e3Je3AA/f9hmww0t5gwBVKQ00HBkAxvH1JCIQ4yRmhteYkIASWzgXlmYv
	k6dMGA6AMXUz9tsS/yNc8xw6V7YZ+JxYH4CZWFecpWejTtZ+dh9+yeQm2D/LA2pAj7hXLbJOCfg
	2vhMGBKYsb5ZDmjXhaT8UxVB3i0IAC6sKQnBiJXuRnGkIR/gFWnNQ7AB5iIZBDPXwoz4sAlQiA1
	eBmLTBLcgijfaNXh0hdcZER1eR0PjnV6ATOFu4W6R2H5ZAkIaAd5cdWRgviYZdrJoeO8auL73Uw
	4iGj0zmZlm8778l+LdqGAGBOMx0aCgU2QiULYzJmEDvFr+EyeZHFcodlH4n/Dbdydd/EiAx1k90
	ue7D/ZUOpFYA++MnX
X-Google-Smtp-Source: AGHT+IFX9OKTc8E6IqQTZzYxWlAhFuyYeJjqwUvFOABkby4ARQ+mPLkz5IqLHTXHIkeZR7lsYZtWqA==
X-Received: by 2002:a17:90b:1e09:b0:311:b413:f5e1 with SMTP id 98e67ed59e1d1-320fbf3dfb7mr1055555a91.32.1754008061258;
        Thu, 31 Jul 2025 17:27:41 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63da8fcfsm5855606a91.7.2025.07.31.17.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 17:27:40 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: linux-mm@kvack.org,
	brauner@kernel.org
Cc: willy@infradead.org,
	jack@suse.cz,
	hch@infradead.org,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [RFC PATCH v1 03/10] mm: add folio_end_writeback_pages() helper
Date: Thu, 31 Jul 2025 17:21:24 -0700
Message-ID: <20250801002131.255068-4-joannelkoong@gmail.com>
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

Add folio_end_writeback_pages() which takes in the number of pages
written back.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/linux/pagemap.h |  1 +
 mm/filemap.c            | 25 +++++++++++++++----------
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index e63fbfbd5b0f..312209e0371a 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1202,6 +1202,7 @@ void folio_wait_writeback(struct folio *folio);
 int folio_wait_writeback_killable(struct folio *folio);
 void end_page_writeback(struct page *page);
 void folio_end_writeback(struct folio *folio);
+void folio_end_writeback_pages(struct folio *folio, long nr_pages);
 void folio_wait_stable(struct folio *folio);
 void __folio_mark_dirty(struct folio *folio, struct address_space *, int warn);
 void folio_account_cleaned(struct folio *folio, struct bdi_writeback *wb);
diff --git a/mm/filemap.c b/mm/filemap.c
index b69ba95746f0..1a292cff0803 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1626,15 +1626,7 @@ static void filemap_end_dropbehind_write(struct folio *folio)
 	}
 }
 
-/**
- * folio_end_writeback - End writeback against a folio.
- * @folio: The folio.
- *
- * The folio must actually be under writeback.
- *
- * Context: May be called from process or interrupt context.
- */
-void folio_end_writeback(struct folio *folio)
+void folio_end_writeback_pages(struct folio *folio, long nr_pages)
 {
 	VM_BUG_ON_FOLIO(!folio_test_writeback(folio), folio);
 
@@ -1657,13 +1649,26 @@ void folio_end_writeback(struct folio *folio)
 	 * reused before the folio_wake_bit().
 	 */
 	folio_get(folio);
-	if (__folio_end_writeback(folio, folio_nr_pages(folio)))
+	if (__folio_end_writeback(folio, nr_pages))
 		folio_wake_bit(folio, PG_writeback);
 
 	filemap_end_dropbehind_write(folio);
 	acct_reclaim_writeback(folio);
 	folio_put(folio);
 }
+
+/**
+ * folio_end_writeback - End writeback against a folio.
+ * @folio: The folio.
+ *
+ * The folio must actually be under writeback.
+ *
+ * Context: May be called from process or interrupt context.
+ */
+void folio_end_writeback(struct folio *folio)
+{
+	folio_end_writeback_pages(folio, folio_nr_pages(folio));
+}
 EXPORT_SYMBOL(folio_end_writeback);
 
 /**
-- 
2.47.3


