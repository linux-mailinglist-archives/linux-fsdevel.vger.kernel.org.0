Return-Path: <linux-fsdevel+bounces-68598-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49572C60EAF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Nov 2025 02:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4040E3B1B8E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Nov 2025 01:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93D921D3DC;
	Sun, 16 Nov 2025 01:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nPp+9hLO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E63C17A2E8
	for <linux-fsdevel@vger.kernel.org>; Sun, 16 Nov 2025 01:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763257648; cv=none; b=EX4FzKSzSrFEZfdZJJvSnaB8I1jeXHQGUJQALC1mWLfoWDxoe2/fZTBUAnPRDANxxUJi5BijmdjPZfg8h2K0ZNjgvh2o5kv4MF7US1xSvlXVYvHup4lY+zxwcD/dhu/FaZhYl6knv8ytyEXy3JOlHYql9w/qlTPLeyW8SOoPOOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763257648; c=relaxed/simple;
	bh=56cMUgnKf+QaHfDzv3rUqe4MzNOeCRhzSSrVCQXlcxc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lXIRqc2vq7VmX7tneQy47UXtPdH781CXmxp7cCfUkEm5nauPP+PP3awQto3pzV+gu1QUk1PfSxc1Xejj214v7bV0Hp9PDnzknX68gItnAC/cOkNM8LRHZWfuq3ylUgtYlzZj0cwrFcRZkSJWGMQxoUMJM0KIg2ziDLMv5B4kIuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nPp+9hLO; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-343e17d7ed5so3746579a91.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 15 Nov 2025 17:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763257646; x=1763862446; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8iahc/OE7c9HoKRDc0duvnCB5sVq2ZelHCgN4s7hCPM=;
        b=nPp+9hLOz1wIoI4UevvUSi8X8yvg8fNaxbZTp43dXN7W6v2Ii7V66HOkjakWKYZzzE
         HacvoCw7gUm9aOjSnWIeJaiEkhsz/cq43eEcjb502ht9c7PjtEy8jwchjRxNEqdr2JRv
         EZjOdQ7S74krvRn2LcLwNrL7elhXiH1wWELb9pQle2VK+sr3yo3Qx1/5dK53QjICzcU1
         kQIdHKHSTQ6XaScvt4n3nnBYWCMADFGjoqo6Ewk4UW7TQKB2bJw7+wbh+nr94RKyWfS1
         IzFmKwNG3pxkrJGfxWAlBoW3w+TFiTTFlMVvaeRscgU1leaA4PFWM2qDCigqK0GInbr+
         /zgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763257646; x=1763862446;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8iahc/OE7c9HoKRDc0duvnCB5sVq2ZelHCgN4s7hCPM=;
        b=J7/FqnTJMHtA0yGrsTEo8bubBOiTA53h3kon3RvbMJMVew4Z6ORDw1j1ESLieA/mk2
         ElLUKbkXMPsJ9bq6wEonUSNjTb43iDIf0+S3UB+/rC4NPllI1QunM/Ddim8HbG6KGCxz
         23rPgzGMOY8OYli9GzG3cpR3+f7wxRmpDmFsB6ZGc3EPgRbZuj+icjR1D1bzZNNixoys
         HUjhjcZZZDh1ftR1OWpiYAxwnxoFKj7B/pr5puZyrlflVdNdePFFzkdgoUjXj43TP0nP
         DWMNjeJwdJuLw1V7tr06x+bMPiF8qH0/2xhE9Xf/bbi7W5tm6YSzgIwoPnJ48Le/gyGb
         8f9A==
X-Forwarded-Encrypted: i=1; AJvYcCWqMZcTGHXAARd6RjSlCvXT3Yf927QkqXE1UbkTfKpQ1LhiWzItohZriaVq9Jt0Ov9dY7lW9tCkM3xtVKtD@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9sUXT2d4zTCJ3870yTwaL2koS6zbr+D/1nIJM31BCY4awThHS
	eA+GsJ9L6ktkPLgbjy4yQWGuyyYUHd8+m7kuoDzdC7yifkgK1RkJ6GUbt4XVX5AcJIK1YMK49Q6
	k08njJm7UcwHHCQ==
X-Google-Smtp-Source: AGHT+IENVvEwJMRWsbG8t8DKamJf+m7Kq67/5OJ3seeLWXwPuYI2slv5FtZcLQnrkEJ74Z2KnexNe0JoOpqTUg==
X-Received: from pjod1.prod.google.com ([2002:a17:90a:8d81:b0:33b:b692:47b0])
 (user=jiaqiyan job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1a8a:b0:341:69e3:785a with SMTP id 98e67ed59e1d1-343f9fdf8efmr10663049a91.16.1763257645886;
 Sat, 15 Nov 2025 17:47:25 -0800 (PST)
Date: Sun, 16 Nov 2025 01:47:20 +0000
In-Reply-To: <20251116014721.1561456-1-jiaqiyan@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251116014721.1561456-1-jiaqiyan@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251116014721.1561456-2-jiaqiyan@google.com>
Subject: [PATCH v1 1/2] mm/huge_memory: introduce uniform_split_unmapped_folio_to_zero_order
From: Jiaqi Yan <jiaqiyan@google.com>
To: nao.horiguchi@gmail.com, linmiaohe@huawei.com, ziy@nvidia.com
Cc: david@redhat.com, lorenzo.stoakes@oracle.com, william.roche@oracle.com, 
	harry.yoo@oracle.com, tony.luck@intel.com, wangkefeng.wang@huawei.com, 
	willy@infradead.org, jane.chu@oracle.com, akpm@linux-foundation.org, 
	osalvador@suse.de, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Jiaqi Yan <jiaqiyan@google.com>
Content-Type: text/plain; charset="UTF-8"

When freeing a high-order folio that contains HWPoison pages,
to ensure these HWPoison pages are not added to buddy allocator,
we can first uniformly split a free and unmapped high-order folio
to 0-order folios first, then only add non-HWPoison folios to
buddy allocator and exclude HWPoison ones.

Introduce uniform_split_unmapped_folio_to_zero_order, a wrapper
to the existing __split_unmapped_folio. Caller can use it to
uniformly split an unmapped high-order folio into 0-order folios.

No functional change. It will be used in a subsequent commit.

Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
---
 include/linux/huge_mm.h | 6 ++++++
 mm/huge_memory.c        | 8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 71ac78b9f834f..ef6a84973e157 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -365,6 +365,7 @@ unsigned long thp_get_unmapped_area_vmflags(struct file *filp, unsigned long add
 		vm_flags_t vm_flags);
 
 bool can_split_folio(struct folio *folio, int caller_pins, int *pextra_pins);
+int uniform_split_unmapped_folio_to_zero_order(struct folio *folio);
 int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 		unsigned int new_order);
 int min_order_for_split(struct folio *folio);
@@ -569,6 +570,11 @@ can_split_folio(struct folio *folio, int caller_pins, int *pextra_pins)
 {
 	return false;
 }
+static inline int uniform_split_unmapped_folio_to_zero_order(struct folio *folio)
+{
+	VM_WARN_ON_ONCE_PAGE(1, page);
+	return -EINVAL;
+}
 static inline int
 split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 		unsigned int new_order)
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 323654fb4f8cf..c7b6c1c75a18e 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3515,6 +3515,14 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
 	return ret;
 }
 
+int uniform_split_unmapped_folio_to_zero_order(struct folio *folio)
+{
+	return __split_unmapped_folio(folio, /*new_order=*/0,
+				      /*split_at=*/&folio->page,
+				      /*xas=*/NULL, /*mapping=*/NULL,
+				      /*uniform_split=*/true);
+}
+
 bool non_uniform_split_supported(struct folio *folio, unsigned int new_order,
 		bool warns)
 {
-- 
2.52.0.rc1.455.g30608eb744-goog


