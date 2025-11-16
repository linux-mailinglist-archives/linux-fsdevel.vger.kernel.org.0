Return-Path: <linux-fsdevel+bounces-68599-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF12C60EB2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Nov 2025 02:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 081253BD565
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Nov 2025 01:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBC71DA23;
	Sun, 16 Nov 2025 01:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fMyDMWoz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2D7219A86
	for <linux-fsdevel@vger.kernel.org>; Sun, 16 Nov 2025 01:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763257649; cv=none; b=qiPl49OrZuEMXchW8n1lR9mL/oLS3VKvZ6vluw+pcUPnN1tVs8evzZwobCvHDSn6WA+Fl7H/cTv2uWnf0ZN5xFXG7kOglWiqMAxM5/zPywKGuS2BPwzbwmkq2woAlKHb/EszSQqv4EdplpE9YF74jJPZ6y0G+cXMBdKF5j5Z2n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763257649; c=relaxed/simple;
	bh=uyaZF+lF6L8ptszVVGKgVrp5Zdu7E4WsbkiWNa/nfUg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TXimZwybtZsR+R4Vm6acm4hUFnsC/lahw7iDcMHXL3EfsnhcoZrE2sFGyFnW0/hSVz5q7fYFyqvgoZjaZaERt8w3U9xoM2g81/mbYE/s7Xm0AXbSPLFbXYUwazLp4T1Xvlo9X87gCnv5XrUrO3JZSetF/AhrV1sUhX6peTqslVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fMyDMWoz; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-340c0604e3dso3969479a91.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 15 Nov 2025 17:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763257647; x=1763862447; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ydqY8kHaLqM8e+ckUd1GoyNEbjtXYhx/4GzlhdYJPLg=;
        b=fMyDMWozbrb5BfRiljWMQSZzEe0aWv1+q/mxVFZ/MyXodqTLv5Ma+z2zfuS9HLOiTG
         xFeQFwavoMrucVTvLUfk46/g9ItiNJ+vCzivLpZt1cRPBj/pH3japS31PhODAInsII8m
         7W+GzfAn9VHj7GURMFHNk7OA2OExMBEuUKxefnELE3mmzzhX8glmDQ3C7Wz0YjyDIfzg
         Wo+EXkjCIj+Z4Y/AOEMFGkqoHFsIjI/IqMC5MKBC8E2lSpGJ1NlulKJjfViv+ttbDv6Q
         2ke0FJt+3SYjNnPdx9Rc6BOKzUZsDDhMHtmdQ1Zi1pRD4ZloThQDfBwX3rWuYMUDImXO
         k6HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763257647; x=1763862447;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ydqY8kHaLqM8e+ckUd1GoyNEbjtXYhx/4GzlhdYJPLg=;
        b=dHQMM6yygSKR/Q7wGokfIvWGwfL8DlkasuogrzIpACzatpzrNV2DYl7tfD1n8xDnmv
         poElfvWGjeB7RUQf1YpMz41rcfAJWWZayJXIbmOpYN7zI3pJcBy8Y7oYEbCDeAQgbO+9
         H8MQRXpDUXvsIVrL1Jdj8fWbRHWfcrnS9Uac7Y+HhlUIeZeraJjERu8gpZVNIqvGtZz9
         eaxOUBjIR7R4HwT2izWnvrUz3WqYTDb8UIQxrJGuY5MSNy7SlLezoZPtOraH7Uh+mJ/j
         aTMoi3u2DH92++kwI3LFLdP7Whyq/bNQSSLTiLCNF6DzFnTzyP5dIaPPZWReTHnqhLiC
         vcew==
X-Forwarded-Encrypted: i=1; AJvYcCVsUYxW7zQgo6DEOYj/fHC6MVVOv8m/6g/jnPay3xniKS7fh4+31cQAE/cdiY3pYMQ3RaLUlTZ2suvqoGiN@vger.kernel.org
X-Gm-Message-State: AOJu0YyzrtAE2sgfrLn181MTiKzgjmSYjQem12Wp4K5G3Xexkt7QAhXq
	/Ao1UiZdUy9IL3H8nT1HZYbAN536qAK+rvVhl4zY4RY7dEnyb7KU3efXSyK+XBKWAV9M0MiByyU
	fnmLhlRNTKztExA==
X-Google-Smtp-Source: AGHT+IG+V3JoR1zxw8jLEaEAc7T7dwC4LvlgdWGc3WKTGU3XOduJztVqaChJIeTyJ4+Ey/Vrzth5e+wjM1k7sA==
X-Received: from pjbnk23.prod.google.com ([2002:a17:90b:1957:b0:343:c010:4493])
 (user=jiaqiyan job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3fd0:b0:330:bca5:13d9 with SMTP id 98e67ed59e1d1-343fa732781mr7620970a91.32.1763257647429;
 Sat, 15 Nov 2025 17:47:27 -0800 (PST)
Date: Sun, 16 Nov 2025 01:47:21 +0000
In-Reply-To: <20251116014721.1561456-1-jiaqiyan@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251116014721.1561456-1-jiaqiyan@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251116014721.1561456-3-jiaqiyan@google.com>
Subject: [PATCH v1 2/2] mm/memory-failure: avoid free HWPoison high-order folio
From: Jiaqi Yan <jiaqiyan@google.com>
To: nao.horiguchi@gmail.com, linmiaohe@huawei.com, ziy@nvidia.com
Cc: david@redhat.com, lorenzo.stoakes@oracle.com, william.roche@oracle.com, 
	harry.yoo@oracle.com, tony.luck@intel.com, wangkefeng.wang@huawei.com, 
	willy@infradead.org, jane.chu@oracle.com, akpm@linux-foundation.org, 
	osalvador@suse.de, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Jiaqi Yan <jiaqiyan@google.com>
Content-Type: text/plain; charset="UTF-8"

At the end of dissolve_free_hugetlb_folio, when a free HugeTLB
folio becomes non-HugeTLB, it is released to buddy allocator
as a high-order folio, e.g. a folio that contains 262144 pages
if the folio was a 1G HugeTLB hugepage.

This is problematic if the HugeTLB hugepage contained HWPoison
subpages. In that case, since buddy allocator does not check
HWPoison for non-zero-order folio, the raw HWPoison page can
be given out with its buddy page and be re-used by either
kernel or userspace.

Memory failure recovery (MFR) in kernel does attempt to take
raw HWPoison page off buddy allocator after
dissolve_free_hugetlb_folio. However, there is always a time
window between freed to buddy allocator and taken off from
buddy allocator.

One obvious way to avoid this problem is to add page sanity
checks in page allocate or free path. However, it is against
the past efforts to reduce sanity check overhead [1,2,3].

Introduce hugetlb_free_hwpoison_folio to solve this problem.
The idea is, in case a HugeTLB folio for sure contains HWPoison
page(s), first split the non-HugeTLB high-order folio uniformly
into 0-order folios, then let healthy pages join the buddy
allocator while reject the HWPoison ones.

[1] https://lore.kernel.org/linux-mm/1460711275-1130-15-git-send-email-mgorman@techsingularity.net/
[2] https://lore.kernel.org/linux-mm/1460711275-1130-16-git-send-email-mgorman@techsingularity.net/
[3] https://lore.kernel.org/all/20230216095131.17336-1-vbabka@suse.cz

Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
---
 include/linux/hugetlb.h |  4 ++++
 mm/hugetlb.c            |  8 ++++++--
 mm/memory-failure.c     | 43 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 8e63e46b8e1f0..e1c334a7db2fe 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -870,8 +870,12 @@ int dissolve_free_hugetlb_folios(unsigned long start_pfn,
 				    unsigned long end_pfn);
 
 #ifdef CONFIG_MEMORY_FAILURE
+extern void hugetlb_free_hwpoison_folio(struct folio *folio);
 extern void folio_clear_hugetlb_hwpoison(struct folio *folio);
 #else
+static inline void hugetlb_free_hwpoison_folio(struct folio *folio)
+{
+}
 static inline void folio_clear_hugetlb_hwpoison(struct folio *folio)
 {
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 0455119716ec0..801ca1a14c0f0 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1596,6 +1596,7 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
 						struct folio *folio)
 {
 	bool clear_flag = folio_test_hugetlb_vmemmap_optimized(folio);
+	bool has_hwpoison = folio_test_hwpoison(folio);
 
 	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
 		return;
@@ -1638,12 +1639,15 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
 	 * Move PageHWPoison flag from head page to the raw error pages,
 	 * which makes any healthy subpages reusable.
 	 */
-	if (unlikely(folio_test_hwpoison(folio)))
+	if (unlikely(has_hwpoison))
 		folio_clear_hugetlb_hwpoison(folio);
 
 	folio_ref_unfreeze(folio, 1);
 
-	hugetlb_free_folio(folio);
+	if (unlikely(has_hwpoison))
+		hugetlb_free_hwpoison_folio(folio);
+	else
+		hugetlb_free_folio(folio);
 }
 
 /*
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 3edebb0cda30b..e6a9deba6292a 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2002,6 +2002,49 @@ int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
 	return ret;
 }
 
+void hugetlb_free_hwpoison_folio(struct folio *folio)
+{
+	struct folio *curr, *next;
+	struct folio *end_folio = folio_next(folio);
+	int ret;
+
+	VM_WARN_ON_FOLIO(folio_ref_count(folio) != 1, folio);
+
+	ret = uniform_split_unmapped_folio_to_zero_order(folio);
+	if (ret) {
+		/*
+		 * In case of split failure, none of the pages in folio
+		 * will be freed to buddy allocator.
+		 */
+		pr_err("%#lx: failed to split free %d-order folio with HWPoison page(s): %d\n",
+		       folio_pfn(folio), folio_order(folio), ret);
+		return;
+	}
+
+	/* Expect 1st folio's refcount==1, and other's refcount==0. */
+	for (curr = folio; curr != end_folio; curr = next) {
+		next = folio_next(curr);
+
+		VM_WARN_ON_FOLIO(folio_order(curr), curr);
+
+		if (PageHWPoison(&curr->page)) {
+			if (curr != folio)
+				folio_ref_inc(curr);
+
+			VM_WARN_ON_FOLIO(folio_ref_count(curr) != 1, curr);
+			pr_warn("%#lx: prevented freeing HWPoison page\n",
+				folio_pfn(curr));
+			continue;
+		}
+
+		if (curr == folio)
+			folio_ref_dec(curr);
+
+		VM_WARN_ON_FOLIO(folio_ref_count(curr), curr);
+		free_frozen_pages(&curr->page, folio_order(curr));
+	}
+}
+
 /*
  * Taking refcount of hugetlb pages needs extra care about race conditions
  * with basic operations like hugepage allocation/free/demotion.
-- 
2.52.0.rc1.455.g30608eb744-goog


