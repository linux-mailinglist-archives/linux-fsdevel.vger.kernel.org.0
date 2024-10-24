Return-Path: <linux-fsdevel+bounces-32807-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AEB9AEDD0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 19:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 833A01F23ED0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 17:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E60C1FF049;
	Thu, 24 Oct 2024 17:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uog6nR7v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8431FDFB0
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2024 17:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729790498; cv=none; b=YN+D4auTwtcvJke7swqqOVB0y2+oY78DTd/VmDlppA/Y6o149wXxtbKn5L0aLTTcuL3H3q/wasgITyEc3MP6V+v5mdJi6UdyGhflsGgfLh1lzmhplMIWVRI7OKDcTqtYlnvONSQsHvjzRiFCeJolmzy0ObXGaZzSqlXIrICwB3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729790498; c=relaxed/simple;
	bh=Gu2YSvK2+EbyNYnxZcb7N27GGbib1KlhygWAxajgM9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VWRob9aJ6MGkIP6rJ05b/AqNcwzFR8Wef7SmK3GI4r5+IP7mpZPjtd5RE99ueJ6t+Ou1CqR67jlQJHU8zuEPYMjHSesc0HkjTCnUzrA5WPqVnue9WbC4f0S4Sa7d+33lans/8bBU2+pxilM6HiC9rsVBDtP+OWov7HEIGrXPTGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uog6nR7v; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6e5fadb5e23so10715667b3.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2024 10:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729790495; x=1730395295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r0lb+FlCJ27wc1DnrIwBxhXfE5e/7ONhHuRmNbuyD0I=;
        b=Uog6nR7vbxqJjC4/Xb/L9lNV2bgZVcuL4IxaI/isZQVdYo2sZOFDLt2Ot2LE+riqfb
         myFWZ1aFqKJ8z8/PHVVY0xAfJxvvjZVB3JuhPQLTPsulWB+9yf+U7pQgVi9BzPWpuoZA
         BUmUU5sdI0qf0yp7y8P74qX8hJZZmhy5EwOipyERlHlTPaSMbVEx3FQeWeL2Z+NtuhpJ
         ysNOJS3n013XUG0F2Ur6AEph3AWOcP9F9TSDut8wnXD54jSvIfKhYvKJzfo9P2Cxm0Os
         /oxynhf2Nf6UpJ25rbmIn9Fc7caCpoPijkBXT9CZxVMczimQ3PKXNsvvYqZVAaUwX54Q
         U7mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729790495; x=1730395295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r0lb+FlCJ27wc1DnrIwBxhXfE5e/7ONhHuRmNbuyD0I=;
        b=hGtjJxBiovaZXibxsllVodMMZAe7/cYaOCyQU477T31eOYcb8wOW3EU3u56GQOTu/G
         mxPaUuDNuKVgCfIxrgTQk82u3CC/Djl36wbL/CSLInwKA+8IQBJjez4d+vks/0+9cHZH
         sofnHlzRxmE9tIA/nypx/CjYoXu0Ug6ecQ4RVZMOm4aaVo16/Eg0pdFpmQ/B5Vf3jWlI
         AZJQZhdCziIPQTDp+Jj1ob7Pv4pcqxwu1sd5PgyDzoZkHjAiRbP0FDw7HBEY5APWCr4o
         plldKk9XsuB+EQ4IJ2HLzyjwo9FcJcpA+mUXHCZUM+megJZIhNCog9c0qFTQONQzDTW6
         BQ+w==
X-Forwarded-Encrypted: i=1; AJvYcCWo+jQvRYkcNjsLusxulQnB8UDy8oeqwtg0pqYJimzH/1M5rJQt7sE4J4erJ0UyA7oXZnu0HpYLEPH9dFKX@vger.kernel.org
X-Gm-Message-State: AOJu0YwMlXSQiXEd7z0Ceq2WEkPwro6gub6BCvieOcjmayCzpfZnj2f4
	J30Ax+3i38gu48GDAw9P5HUVNnjVo5Lu8PZlUF1fGk243S7PwSvp
X-Google-Smtp-Source: AGHT+IGe5u/RgvzaFz7YeGd/DRqrZg8oBD74lUpxoYrfVjMOAyWJ/6AZ0/w+myAAyZHDUtazFZFZZw==
X-Received: by 2002:a05:690c:998c:b0:6e3:a7b:49b3 with SMTP id 00721157ae682-6e86632cf47mr33223247b3.41.1729790495415;
        Thu, 24 Oct 2024 10:21:35 -0700 (PDT)
Received: from localhost (fwdproxy-nha-000.fbsv.net. [2a03:2880:25ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f59f5253sm20779387b3.2.2024.10.24.10.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 10:21:34 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	willy@infradead.org,
	kernel-team@meta.com
Subject: [PATCH v3 11/13] mm/writeback: add folio_mark_dirty_lock()
Date: Thu, 24 Oct 2024 10:18:07 -0700
Message-ID: <20241024171809.3142801-12-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241024171809.3142801-1-joannelkoong@gmail.com>
References: <20241024171809.3142801-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new convenience helper folio_mark_dirty_lock() that grabs the
folio lock before calling folio_mark_dirty().

Refactor set_page_dirty_lock() to directly use folio_mark_dirty_lock().

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/linux/mm.h  |  1 +
 mm/folio-compat.c   |  6 ++++++
 mm/page-writeback.c | 22 +++++++++++-----------
 3 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ecf63d2b0582..446d7096c48f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2539,6 +2539,7 @@ struct kvec;
 struct page *get_dump_page(unsigned long addr);
 
 bool folio_mark_dirty(struct folio *folio);
+bool folio_mark_dirty_lock(struct folio *folio);
 bool set_page_dirty(struct page *page);
 int set_page_dirty_lock(struct page *page);
 
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index 80746182e9e8..1d1832e2a599 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -52,6 +52,12 @@ bool set_page_dirty(struct page *page)
 }
 EXPORT_SYMBOL(set_page_dirty);
 
+int set_page_dirty_lock(struct page *page)
+{
+	return folio_mark_dirty_lock(page_folio(page));
+}
+EXPORT_SYMBOL(set_page_dirty_lock);
+
 bool clear_page_dirty_for_io(struct page *page)
 {
 	return folio_clear_dirty_for_io(page_folio(page));
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index fcd4c1439cb9..db00a66d8b84 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2914,25 +2914,25 @@ bool folio_mark_dirty(struct folio *folio)
 EXPORT_SYMBOL(folio_mark_dirty);
 
 /*
- * set_page_dirty() is racy if the caller has no reference against
- * page->mapping->host, and if the page is unlocked.  This is because another
- * CPU could truncate the page off the mapping and then free the mapping.
+ * folio_mark_dirty() is racy if the caller has no reference against
+ * folio->mapping->host, and if the folio is unlocked.  This is because another
+ * CPU could truncate the folio off the mapping and then free the mapping.
  *
- * Usually, the page _is_ locked, or the caller is a user-space process which
+ * Usually, the folio _is_ locked, or the caller is a user-space process which
  * holds a reference on the inode by having an open file.
  *
- * In other cases, the page should be locked before running set_page_dirty().
+ * In other cases, the folio should be locked before running folio_mark_dirty().
  */
-int set_page_dirty_lock(struct page *page)
+bool folio_mark_dirty_lock(struct folio *folio)
 {
-	int ret;
+	bool ret;
 
-	lock_page(page);
-	ret = set_page_dirty(page);
-	unlock_page(page);
+	folio_lock(folio);
+	ret = folio_mark_dirty(folio);
+	folio_unlock(folio);
 	return ret;
 }
-EXPORT_SYMBOL(set_page_dirty_lock);
+EXPORT_SYMBOL(folio_mark_dirty_lock);
 
 /*
  * This cancels just the dirty bit on the kernel page itself, it does NOT
-- 
2.43.5


