Return-Path: <linux-fsdevel+bounces-42960-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4546AA4C7CA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 17:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05FFD1652ED
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 16:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142B3253F29;
	Mon,  3 Mar 2025 16:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bSjMpwrq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169B6253344
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Mar 2025 16:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019464; cv=none; b=jXBTVEI4GbPpqeDQHtI/PhGGAT4RpUGY0ir//mN9rxNW6TR8DhPJokxk3uXXYRVZKNc9B7b5ixutz1mESp6H3W3SSAZNbiMkpmymN4RgytZfvf+Wgs4TDeZkhe75BA3OBae+sYbRctekAgAc6TYnOdrP/LF00awISyhQogtFqAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019464; c=relaxed/simple;
	bh=67PK8pUQYPqYlMZHYSLo+XzRkAgj9tRIuRjTWNQ3VlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q1d/fscWzKwN47tfeWDXYA1mlnlGV08yfhSRJDlcWlmiH9NuJRlIkR+I+gfe8/03bMFgf/eoZUTFrtlnkyVdHaQ1asVSNK2lKIzOLxXdV/x5xLvL73BsiUJAilSIMgvL2y1/y1U3ZiL2+Cc5t0W/FzpGYJoWLXO807w7ul60HN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bSjMpwrq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741019461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Ha8UZDq7Lu61upXZpfKkXckZhfouMk5cB7+X6dnx8Y=;
	b=bSjMpwrqRn3JBCLfX6Dwrf0jtZRPCjND+Vzp1JQCpQMTY9c9ZETjoKBKwXGFHZrlgvn3Uu
	M9aWRzVS0AQkXM4CTs1zqgbi6Y20fLB72EnRqalwNkZNy0mntBk8HdKh6MkfdnKY9G7BSj
	4wtlKQDiYeyC75sQG1B6V4Q2zH72DS4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-53iqVaslOQmJdE9uq3zxHw-1; Mon, 03 Mar 2025 11:31:00 -0500
X-MC-Unique: 53iqVaslOQmJdE9uq3zxHw-1
X-Mimecast-MFC-AGG-ID: 53iqVaslOQmJdE9uq3zxHw_1741019456
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-390f3652842so1684591f8f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Mar 2025 08:30:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741019456; x=1741624256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Ha8UZDq7Lu61upXZpfKkXckZhfouMk5cB7+X6dnx8Y=;
        b=xLd55Ua+i9Dl1y4JKQF0aJjUNp1EABHgOPuK5MS4rxYY9itf+WDJu1/Z+rBos7l/6d
         63qJaX1aXLx3kV0Cw40edackOsrvel1dKY2fSVnQjsDY7ohtuOqC9LppYAZXmlVcqMFx
         JLDX79YNdQW9XAx1JzgQvcY+MvYi3zcE/uA2NFTFgE7MPp95O8t0YlqlpnGjuoPp9D88
         MvA626Mr0BEPf+5/Mnyyt1Y2xhoahgFPzm+XRc28Z8VcpuzK3GawoWq/PqR6WuWPFNWy
         jlB/JKW2Mg3m7pTzghibsaAygLcPRCWU90SLCO0xuHb8cgrWD0QSAiiTjZSRWDkaWu2t
         YKeA==
X-Forwarded-Encrypted: i=1; AJvYcCWZssjKbukDQ4MlTlteItWds8WmcEDTzG97VJT/w0PRUMd/5ygOQQzhl8bntUmbQIaKo5FpwW529JaN9KBb@vger.kernel.org
X-Gm-Message-State: AOJu0YwPdC6c9vWACR83DWI6O80e+tKHjNcB88/UA/8t2jyJ8FC85HMl
	1Pt9WBhAkZHA8VmJbe8mjuatgEmAIBKG+FjVZFJ76GsSrZHjHCjQhYZVL6GiwrwBOp5iGA/tBAL
	mnpENZxebKmkauCbLXM/4PJO1S6AYIVtEY6DSQa6NXk0xVPCyzhxxKmemu/Yhfu0=
X-Gm-Gg: ASbGncsmxpZoQulkPkm2TjuMXvms/EEpxY8tQD24tR/jgBF7AKslJqRNW8RPPGuRfrX
	bCNDr4v4HYARjFk8+4r2JLexn7rP5lREAsQZQOp/rpbAPqq9SwNxuGWZ/tiZTKZrmdBUemVvZOG
	7ccFSPFOdCdn9h/U2Cz5i7boAk2/Bo8mM1HW27quvLHgX60yAgSah+Oi8AnPIeRE8DM2Chk7Me7
	coGqWgeOpYMEnU3KN508BY8G+Bv80i/ncEp7t1KJVXllVe1ra3BogS0Qt4E0h/7HvofHMjW2UvL
	OZghS5Z4sk4bVUv45cACc4PIwYTrNG/gu35A4YsXsNo50oj0gQcTKNB56t9jYudxrBmQbTjKeI3
	E
X-Received: by 2002:a5d:64cf:0:b0:390:df6c:591f with SMTP id ffacd0b85a97d-390ec7cd2ddmr9512474f8f.17.1741019455929;
        Mon, 03 Mar 2025 08:30:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEU1cXWjWugfmabLrmr0XJAbs+GQI7107y37ij+zO9LNUtV9tqHS/ZXKWHCRmLlaLTb16eXbQ==
X-Received: by 2002:a5d:64cf:0:b0:390:df6c:591f with SMTP id ffacd0b85a97d-390ec7cd2ddmr9512425f8f.17.1741019455528;
        Mon, 03 Mar 2025 08:30:55 -0800 (PST)
Received: from localhost (p200300cbc7349600af274326a2162bfb.dip0.t-ipconnect.de. [2003:cb:c734:9600:af27:4326:a216:2bfb])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-390e485ddd1sm15052695f8f.94.2025.03.03.08.30.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 08:30:55 -0800 (PST)
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
Subject: [PATCH v3 17/20] fs/proc/task_mmu: remove per-page mapcount dependency for PM_MMAP_EXCLUSIVE (CONFIG_NO_PAGE_MAPCOUNT)
Date: Mon,  3 Mar 2025 17:30:10 +0100
Message-ID: <20250303163014.1128035-18-david@redhat.com>
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

Let's implement an alternative when per-page mapcounts in large folios are
no longer maintained -- soon with CONFIG_NO_PAGE_MAPCOUNT.

PM_MMAP_EXCLUSIVE will now be set if folio_likely_mapped_shared() is
true -- when the folio is considered "mapped shared", including when
it once was "mapped shared" but no longer is, as documented.

This might result in and under-indication of "exclusively mapped", which
is considered better than over-indicating it: under-estimating the USS
(Unique Set Size) is better than over-estimating it.

As an alternative, we could simply remove that flag with
CONFIG_NO_PAGE_MAPCOUNT completely, but there might be value to it. So,
let's keep it like that and document the behavior.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 Documentation/admin-guide/mm/pagemap.rst | 11 +++++++++++
 fs/proc/task_mmu.c                       | 11 +++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/mm/pagemap.rst b/Documentation/admin-guide/mm/pagemap.rst
index d6647daca9122..afce291649dd6 100644
--- a/Documentation/admin-guide/mm/pagemap.rst
+++ b/Documentation/admin-guide/mm/pagemap.rst
@@ -38,6 +38,17 @@ There are four components to pagemap:
    precisely which pages are mapped (or in swap) and comparing mapped
    pages between processes.
 
+   Traditionally, bit 56 indicates that a page is mapped exactly once and bit
+   56 is clear when a page is mapped multiple times, even when mapped in the
+   same process multiple times. In some kernel configurations, the semantics
+   for pages part of a larger allocation (e.g., THP) can differ: bit 56 is set
+   if all pages part of the corresponding large allocation are *certainly*
+   mapped in the same process, even if the page is mapped multiple times in that
+   process. Bit 56 is clear when any page page of the larger allocation
+   is *maybe* mapped in a different process. In some cases, a large allocation
+   might be treated as "maybe mapped by multiple processes" even though this
+   is no longer the case.
+
    Efficient users of this interface will use ``/proc/pid/maps`` to
    determine which areas of memory are actually mapped and llseek to
    skip over unmapped regions.
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 1162f0e72df2e..f937c2df7b3f4 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1652,6 +1652,13 @@ static int add_to_pagemap(pagemap_entry_t *pme, struct pagemapread *pm)
 	return 0;
 }
 
+static bool __folio_page_mapped_exclusively(struct folio *folio, struct page *page)
+{
+	if (IS_ENABLED(CONFIG_PAGE_MAPCOUNT))
+		return folio_precise_page_mapcount(folio, page) == 1;
+	return !folio_maybe_mapped_shared(folio);
+}
+
 static int pagemap_pte_hole(unsigned long start, unsigned long end,
 			    __always_unused int depth, struct mm_walk *walk)
 {
@@ -1742,7 +1749,7 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
 		if (!folio_test_anon(folio))
 			flags |= PM_FILE;
 		if ((flags & PM_PRESENT) &&
-		    folio_precise_page_mapcount(folio, page) == 1)
+		    __folio_page_mapped_exclusively(folio, page))
 			flags |= PM_MMAP_EXCLUSIVE;
 	}
 	if (vma->vm_flags & VM_SOFTDIRTY)
@@ -1817,7 +1824,7 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 			pagemap_entry_t pme;
 
 			if (folio && (flags & PM_PRESENT) &&
-			    folio_precise_page_mapcount(folio, page + idx) == 1)
+			    __folio_page_mapped_exclusively(folio, page))
 				cur_flags |= PM_MMAP_EXCLUSIVE;
 
 			pme = make_pme(frame, cur_flags);
-- 
2.48.1


