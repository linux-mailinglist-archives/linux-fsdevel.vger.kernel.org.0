Return-Path: <linux-fsdevel+bounces-42953-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E31A4C7A7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 17:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B08C188A71B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 16:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAF024E4C4;
	Mon,  3 Mar 2025 16:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fTZ06RUb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40C72475CD
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Mar 2025 16:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019450; cv=none; b=rDVfkme/xTUhgj7Upy3YgUZyPiFUJPfw3jY1LxwsihBhzinL97iZifUO2PEWmcGZymYAsSyKlmZyzKppUqivd6ytdfcRskJpKBoGI6dN/96IlKopgxiCoLh2A9QIe/+ErZpcXVOQODelIETet2SS86v7M33j8yT18e6mjchBrm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019450; c=relaxed/simple;
	bh=jBMc/6KfiUuhsqx8U3JCMjpv5FKb+tGdfD4lU0RajKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J8xt9pdCtooWn57NS2BMJmdC+fofLe8573U2MvSNmonVI8byi7RWC5eo1rgVLNurAj4/NepYloFXe40J7vLds7kC5DRVjpJe+L0SKmCqcURHIi5/x9kemGZyfdxEP+YYoJAqCRPWdXBGORChlCP/LVdnRd3aIJWyfPxf9K6+OQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fTZ06RUb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741019448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lWnUBbJbNal4OtQP6KylSC1HMhJkWgV+LTGJMK3tR3E=;
	b=fTZ06RUb6fwTRp6oS5vFzEB52lvEgMxR0hsHNw9TTtPWWPzT3QYDsAmuFB8wGFsxO6VOrg
	EusBotGzWg75iGxJgTNXjogKB0b+YXva5J7FcjQwqmXOLZlc5bc2EALpEIlWiq0cF3M4ac
	HA1upbr7Hma/pE56lEFQM4wMv+aUW3s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-0y7A5gKLOwmpDMo_iZmlGg-1; Mon, 03 Mar 2025 11:30:36 -0500
X-MC-Unique: 0y7A5gKLOwmpDMo_iZmlGg-1
X-Mimecast-MFC-AGG-ID: 0y7A5gKLOwmpDMo_iZmlGg_1741019436
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-438da39bb69so33337135e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Mar 2025 08:30:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741019436; x=1741624236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lWnUBbJbNal4OtQP6KylSC1HMhJkWgV+LTGJMK3tR3E=;
        b=GtVUM7q4I6pBD/O0PT7GvenTzbQvJonkyG4KBpqAwMlV0MyYu/zFc3SG6RXSegi7wg
         BJk7uUdPiiBzy1is2SD8CVMU/u6i69aem9yzlckVj/rUp7gYTRGFiiDUHKk3yYcy780C
         OhD/EvMCN543UuxGHPto6ZzPrpCVqWNxBjn8SZSCZpNBU8earNeN1DuOI3wuPKFdVazW
         sQkjuD/ephbZ0U4V8J5oK3P3shAYj2SSuwATgfbtSLQWr8x68Km+N/sB1gR3aegerOcd
         Tz5ikuUIelP12ER1lY0ibMrZb5I9gBf0flAFxmcuv3n7JorUHZlEF0K8ZSAt0XxuMNWL
         Qogg==
X-Forwarded-Encrypted: i=1; AJvYcCX//3LttSv4mVfn/AqhiVXMoEOemL1Dz3tmTnybHi5dXjB9TGCWCjg2KaO/r+XTxilX+WafoCH6ahs5aM3d@vger.kernel.org
X-Gm-Message-State: AOJu0YyTOXpEf3kjoeVwaP9LyJRSDEc5TV7d7lClBYdEcgys63553997
	AtCrklGZBfHov094Csj1aHW1v9tLpY9djSfRA/KvEKjSYxeYsHkQY/+HU5SjHv5TagB8dGpxSwm
	l5AxQ90mXlCXRE/iZIH5i+mun+jhJfW9W9fxWO0hcK76ZGrq4sy/75hw1BQvwjv0=
X-Gm-Gg: ASbGncultIgshZC7hBObIyW+AT4FrL7MoO7WxECqWueAcrpXPiAwd+UeADaHR5YqWqS
	urAKiw3HsOw3PMTBQj2ASm5f6NfIAHnfGNJ0lLq6StUb3o1rqpRoppnSDdBaiLJU+zdYEn8dGVr
	7W8S916IMNDQhstgGmjXVebHtOiE74MK+LK/WglO30jrketNpOjfxiBEMsjGA+Nv4US4uvbWTuU
	Li19DZ3frl1Guk6+dhhhUzJCNxpXzR83Qp87umvKq+xrTkSUwhWHiDWW7vfckNJzDJedcyr1UGi
	4cfROeykB7uIgH56gL43LHBkA1XhT3byOPvhUFLu83zaZStJ2eSstwrBj8Eq4mR1BhMzyFnO9t/
	x
X-Received: by 2002:a05:600c:19c7:b0:439:6b57:c68 with SMTP id 5b1f17b1804b1-43ba6710a51mr128366155e9.17.1741019435396;
        Mon, 03 Mar 2025 08:30:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEHH2uqcGG6+HqLvILt026VDKtCx0hMTXydneDmvGOTb2RHDZET1RLo/ABtW5TIvoZEd6mWJw==
X-Received: by 2002:a05:600c:19c7:b0:439:6b57:c68 with SMTP id 5b1f17b1804b1-43ba6710a51mr128365725e9.17.1741019434989;
        Mon, 03 Mar 2025 08:30:34 -0800 (PST)
Received: from localhost (p200300cbc7349600af274326a2162bfb.dip0.t-ipconnect.de. [2003:cb:c734:9600:af27:4326:a216:2bfb])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43bc63877desm18077035e9.1.2025.03.03.08.30.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 08:30:33 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Muchun Song <muchun.song@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jann Horn <jannh@google.com>
Subject: [PATCH v3 08/20] mm/rmap: pass vma to __folio_add_rmap()
Date: Mon,  3 Mar 2025 17:30:01 +0100
Message-ID: <20250303163014.1128035-9-david@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250303163014.1128035-1-david@redhat.com>
References: <20250303163014.1128035-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We'll need access to the destination MM when modifying the mapcount
large folios next. So pass in the VMA.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/rmap.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index bcec8677f68df..8a7d023b02e0c 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1242,8 +1242,8 @@ int pfn_mkclean_range(unsigned long pfn, unsigned long nr_pages, pgoff_t pgoff,
 }
 
 static __always_inline unsigned int __folio_add_rmap(struct folio *folio,
-		struct page *page, int nr_pages, enum rmap_level level,
-		int *nr_pmdmapped)
+		struct page *page, int nr_pages, struct vm_area_struct *vma,
+		enum rmap_level level, int *nr_pmdmapped)
 {
 	atomic_t *mapped = &folio->_nr_pages_mapped;
 	const int orig_nr_pages = nr_pages;
@@ -1411,7 +1411,7 @@ static __always_inline void __folio_add_anon_rmap(struct folio *folio,
 
 	VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
 
-	nr = __folio_add_rmap(folio, page, nr_pages, level, &nr_pmdmapped);
+	nr = __folio_add_rmap(folio, page, nr_pages, vma, level, &nr_pmdmapped);
 
 	if (likely(!folio_test_ksm(folio)))
 		__page_check_anon_rmap(folio, page, vma, address);
@@ -1582,7 +1582,7 @@ static __always_inline void __folio_add_file_rmap(struct folio *folio,
 
 	VM_WARN_ON_FOLIO(folio_test_anon(folio), folio);
 
-	nr = __folio_add_rmap(folio, page, nr_pages, level, &nr_pmdmapped);
+	nr = __folio_add_rmap(folio, page, nr_pages, vma, level, &nr_pmdmapped);
 	__folio_mod_stat(folio, nr, nr_pmdmapped);
 
 	/* See comments in folio_add_anon_rmap_*() */
-- 
2.48.1


