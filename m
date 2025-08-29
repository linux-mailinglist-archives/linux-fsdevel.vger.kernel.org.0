Return-Path: <linux-fsdevel+bounces-59671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6B0B3C5A9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Aug 2025 01:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CA0B1B244EB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 23:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0BC313E27;
	Fri, 29 Aug 2025 23:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhSRM7Re"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0038276025
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 23:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756510796; cv=none; b=KkMMUuPNWx/sFH8tGLG/9/4v9D26nB+UmubtHrOWs76NmU2iiAULJty+irLtMFjxabjk7t8fEXtSmMn0NVyKw9PgiCxj/A9a1hk5LUMPYwIIAA3sQGfK1uMN4Gch8eqnr/3iV7FSHqhmEGlwGIRsFMJ298uSahl0Sp6VdA4vfyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756510796; c=relaxed/simple;
	bh=UuQGq4c8t1gTyoyqVSwpRxUbrbVdFQ+aHwmJecpf9ZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W62W5nywBUF32jFxUGlyH1GNn1gWadE9bcUX2NrjjD5WRFr2mUHFss7MIfY8beGL4LA5mOliKJOymd/q4Sk1IetzSyEY2ITV9AQoXaENLhXyHsHTvHO/gYkxvBVLlTpNy1sH6FQD0oByah8XvHD2a8+3U5c+ktmxvPN4y97Llp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AhSRM7Re; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-771ed4a8124so2693720b3a.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 16:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756510794; x=1757115594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJA038u/hVaTfJzlpSdIW82J/HgeOkdB6HYf+GuBfk8=;
        b=AhSRM7ReqqOSLWFau+xA08oHbg2aNBMK4zBjTjuSqj8HSMM85MN+KKaxpd9WTa4QH+
         HkIWFjCv82ox5rEZ1SKp1uAcWTV9GZOPnqGtB/kihB8z2jO66Qdqvmre3emg2dTNr1FM
         Go6zy4P6Q6MiSowv5ObKX8aWt4725sBIcIs+LgboIXsH0dk6E5sDkIc/TZIb9AEfekab
         pIFIjgRFal0ITGnFr2x+d57WP9P1YnqxQ/gm4IOk6et5afnT6DOLRTMEYe+os2oU98yJ
         wSOm5SVUeLsQmohYXM/aRN0W/9cW1/QR6wuS9jS9GhCjkIfCVMO/1hZtS6G6Gm5/d1hy
         mSdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756510794; x=1757115594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FJA038u/hVaTfJzlpSdIW82J/HgeOkdB6HYf+GuBfk8=;
        b=TnO4+0hEx9h9k9yD8YtNLZRXIKnfgAm7DTPidkx2Pgo7G3s7tZHZ/mw+lTyB0uGUkY
         HVC6JO5KFpC77RF5h4dRc3pnH91C1KxlZISLwg1DwxjmH3Qo1sT2rJk16hRGFRASaKfb
         ir3IunQ8x/PjCjTYBZy1PzcLH0c+/92e2uFAma2lvKgCSvgvg+FIER/T5WtOdGOmc5Pd
         4xHHdxVvL3PQ3m+hFhroswinmnJyOtNZbxJToARKfNZPMQPXBtqGDz3AwQk17OcaqM6z
         fARRmNMRFSIebrgiWXhaKJzfSJmskMBCxgc2MZmTWiRsdjSrDDSt23QWzX22Q5ZC8rge
         fOtA==
X-Forwarded-Encrypted: i=1; AJvYcCXEt4sXeOIr91XXgaf/DRboKgCaz7LMAQ0Q9nO+xtxOxQfxsSXkYxbFVRaIhm6L79CKEStD2RChSmBW6Vhh@vger.kernel.org
X-Gm-Message-State: AOJu0YxObEfGcLH7khrr0jh3X3n1zUwwY+ozxGizrI5VrD0iGn36r6Fp
	bxWp7NFI86r67g9QTpnIa2yzJTJrBe045JTvnrmtWzUg2xGz9+WwqSGg
X-Gm-Gg: ASbGnctvaWeqj38vwJex6WWmslrl7J2oANDikJhGEfq7Ke548MqJxMPVuRkHXm54jBu
	eXyO+BE3UXvZFbUvVjP7St/bztg61eyxUJhQ7hcFnUw+rMBGYWFaGbhgj+AJdXp99TrbzhIDu+8
	0O9gxxu3qjSczM0CnqAHKLL59a0NM3g4Yp1PgMKAt2/mLBJiUbZmxa3ok33qTJ8W9j3NhK5hPyR
	A7OSUk29IJj8v/KXmO+37aTTblXcuhn9+MrpFIBfRiuG/ljOh9hdf9ywBZlCZztDYrZAp4jgCZj
	CS9jwDh9gDdBx2tqz+rxPg+FDP6UrSSGLBCxBBXFXx5FKLcBY8/qzTbZs3RhC91dMSsh6O8Mci8
	BxjYNUPEvfpE9yyhemg==
X-Google-Smtp-Source: AGHT+IEBPziX3AMkqRWppj89LkOFryUfRsFbxlcudKr1XhSz9+T7ZzWbMWnph4rPkKvGAQaf5UikVw==
X-Received: by 2002:a05:6a20:244d:b0:238:3f64:41a4 with SMTP id adf61e73a8af0-243d6f37d92mr537160637.44.1756510794143;
        Fri, 29 Aug 2025 16:39:54 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4e::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd006e546sm3226572a12.4.2025.08.29.16.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 16:39:53 -0700 (PDT)
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
Subject: [PATCH v2 03/12] mm: add folio_end_writeback_pages() helper
Date: Fri, 29 Aug 2025 16:39:33 -0700
Message-ID: <20250829233942.3607248-4-joannelkoong@gmail.com>
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

Add folio_end_writeback_pages() which takes in the number of pages
written back.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/linux/pagemap.h |  1 +
 mm/filemap.c            | 12 +++++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 12a12dae727d..362900730247 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1221,6 +1221,7 @@ void folio_wait_writeback(struct folio *folio);
 int folio_wait_writeback_killable(struct folio *folio);
 void end_page_writeback(struct page *page);
 void folio_end_writeback(struct folio *folio);
+void folio_end_writeback_pages(struct folio *folio, long nr_pages);
 void folio_wait_stable(struct folio *folio);
 void __folio_mark_dirty(struct folio *folio, struct address_space *, int warn);
 void folio_account_cleaned(struct folio *folio, struct bdi_writeback *wb);
diff --git a/mm/filemap.c b/mm/filemap.c
index cbfb0f085eb6..6d50afaff930 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1627,14 +1627,15 @@ static void filemap_end_dropbehind_write(struct folio *folio)
 }
 
 /**
- * folio_end_writeback - End writeback against a folio.
+ * folio_end_writeback_pages - End writeback against a folio.
  * @folio: The folio.
+ * @nr_pages: The number of pages written back.
  *
  * The folio must actually be under writeback.
  *
  * Context: May be called from process or interrupt context.
  */
-void folio_end_writeback(struct folio *folio)
+void folio_end_writeback_pages(struct folio *folio, long nr_pages)
 {
 	VM_BUG_ON_FOLIO(!folio_test_writeback(folio), folio);
 
@@ -1657,13 +1658,18 @@ void folio_end_writeback(struct folio *folio)
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
+void folio_end_writeback(struct folio *folio)
+{
+	folio_end_writeback_pages(folio, folio_nr_pages(folio));
+}
 EXPORT_SYMBOL(folio_end_writeback);
 
 /**
-- 
2.47.3


