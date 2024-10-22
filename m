Return-Path: <linux-fsdevel+bounces-32609-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7786A9AB652
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 20:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 340E2284BEC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 18:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768991CDA35;
	Tue, 22 Oct 2024 18:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AiK3LNKr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485781CB328
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Oct 2024 18:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729623299; cv=none; b=PlLfB0Z+KyJRx1ZnYi/Enmy9uzGPPNIVBXFfsick4h4ZjTyhR/BW1LrDce5w5npIQ7G7Ztb1phsaSukorELW7Vm5paAZ5QMSYp3yJ8M+YhFaykYupX+dWqnkETawm3rkvJ672lknVYZXE3MQOq6N7iMrjBn4aeQqccPje8um1Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729623299; c=relaxed/simple;
	bh=Gu2YSvK2+EbyNYnxZcb7N27GGbib1KlhygWAxajgM9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RqnlP6W/Moxo/J3HgkZWClRlNX4TaPHshIfsesXiuVPIufCZZWUZ9VNolP4iU7JCOf13/nJEN/DU31JnscCrAp4McbqPYxv83Dw8oXUwZgeRd1NEbMYeIBa5HmB7J8m0mjGuas0govQ7/x0NHFW2r8CxoIJD3CeG0XeC3ogMH1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AiK3LNKr; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6e2e3e4f65dso66077767b3.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Oct 2024 11:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729623297; x=1730228097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r0lb+FlCJ27wc1DnrIwBxhXfE5e/7ONhHuRmNbuyD0I=;
        b=AiK3LNKr5B4ZcS/loQhWUxTa2KiSqyaOGQIO8U0g8iMPiFJRFf/qK+gMczOaSXYgP+
         Nv9RNsLKKSD5l0403zFOwQOUQJKHTqM5TdscOtYi7HdJpb4UCOt8ZaOEP1Ymsq9SgL0e
         12oMnXI8u9BarPNXnm67L64W6jO4iQBKDenNZ0rmCVxYTJRCICp5YaHGJfhyWlqkoxwL
         BdBZLUm+W8uTHy6HERkliMmjgNS0gab1h2MXH29fPSJGWk93YoI685+rkhowChWJ6tJF
         zvIPXvgSo8yabnEq5pS1qVUi5Pn3BDJyYdymhecIiY38KD5Opxoikb+Wq09YBnXBIWY7
         lQlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729623297; x=1730228097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r0lb+FlCJ27wc1DnrIwBxhXfE5e/7ONhHuRmNbuyD0I=;
        b=J4NTpfb3phgk0glVRC4KXvVwGmn8bDySDZaf8hGWNde0i44EVMYbNVm/1LLaKttq7m
         dMWBnSC6akpLq15wcqt6l2Gq7ikAWcZ9q9xnBalZPJPAUXV5bo5d0uzprK+iXDAkH71E
         yEMofZBaWnnnoSWl7TZZtjUNbv5609pHv/XFR1WAFayPKSd/hs9LGA8cPGXP//bBti1U
         LA+E6BxUDuI3NpRp36Ne1Sxxq3J7mOvVpCX+ITTuUA/8hUEfd/YRzaYz+uMX5MTgETiT
         U1vCuoqSmWWH9WYY4ct+p743MqgNhzmRXFJvK0Whn5E3TCccBLEUxoUGjqdV5HG/G6M6
         phaw==
X-Forwarded-Encrypted: i=1; AJvYcCUmulYQRteSP9Scy4oI78HP+V/H+tkzYBxBx13ZPqKTsnV070jgg8ii0bdn7u3+ZZsPk66NjViZOMO1B0AS@vger.kernel.org
X-Gm-Message-State: AOJu0YwGu4YSgydCIWVpuoyeCh18lKedj5d5wZToTOPzv+7I6rP2hNkH
	i84K7QDaICvdSObU4Rny9JiMrRfqKeGrcB8hYPae46EMarb/WTs3
X-Google-Smtp-Source: AGHT+IEHMn2QAHwEJNj0Pjj/vTCwiZUq5sdR3j2aKasb2Q+ETG8v+k9pVCrfFsA8EUKTsTZDVb+UoQ==
X-Received: by 2002:a05:690c:dc8:b0:6e2:f61e:8c9 with SMTP id 00721157ae682-6e5bfd4ca84mr165062897b3.30.1729623297205;
        Tue, 22 Oct 2024 11:54:57 -0700 (PDT)
Received: from localhost (fwdproxy-nha-002.fbsv.net. [2a03:2880:25ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5ccbae5sm11957477b3.81.2024.10.22.11.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 11:54:56 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	willy@infradead.org,
	kernel-team@meta.com
Subject: [PATCH v2 11/13] mm/writeback: add folio_mark_dirty_lock()
Date: Tue, 22 Oct 2024 11:54:41 -0700
Message-ID: <20241022185443.1891563-12-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241022185443.1891563-1-joannelkoong@gmail.com>
References: <20241022185443.1891563-1-joannelkoong@gmail.com>
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


