Return-Path: <linux-fsdevel+bounces-42959-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBCFA4C7B9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 17:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA49816EFD3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 16:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48B7253332;
	Mon,  3 Mar 2025 16:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JaSzZFcv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9162512F4
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Mar 2025 16:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019460; cv=none; b=a0H++G/rLWTeXqp+5pfI7/G++fCPTXmCEmqq2+i/ONOga8bua3BFHLvGM1ndcZKta55GNpRqL8yZ9UUlXbALsIA0hsInIBO2WHjZMyrt1ZwxE+G51QdbDcse2+SOtCjgJCjqFEGbgqr77C0lDLSykJD7gQ4L2z6lTe5YhMRZZAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019460; c=relaxed/simple;
	bh=tNn8Asbeia05psqh1fHi3T/D4xLY6zTouZa9tD22HYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=is3Z1Ph7aGK49CmlcjdZhX5IEPM/H9mHSmd5EAe93CZyrz0oxxbQqI7iP5o3QjN5Osdj5V5AoMj0uXCxKtnpmjBhCdXPY87lqjIbh+ojt0Y9lMRsDdAlSOd+ATjgaGWxfu+U3sMUshQxC9p3E+Yqy3wc2AslnJsJDX2DQdYt3cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JaSzZFcv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741019457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dM3d7FaE0s/3W03pV+cOCeas1Rcyk2uf0DwTQW3h1Ys=;
	b=JaSzZFcvN8aC+Qd8NPWykyxPweoZ6at35MT4NzVATPZYeHL7IVn10+CXYAvJv7OOS5rD77
	MvDmGoM0MS6PVWUP/ls8qYpN4MvW+T226jjLPubWJuu19OH/0ZdGEOYK8+9/H+zVeXVb4B
	oaOYXEyMV01SHj/OVVM1AdgOti3v9WE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-vM8xvqwkPryoc6LojcalWw-1; Mon, 03 Mar 2025 11:30:55 -0500
X-MC-Unique: vM8xvqwkPryoc6LojcalWw-1
X-Mimecast-MFC-AGG-ID: vM8xvqwkPryoc6LojcalWw_1741019454
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-390eb06d920so3314188f8f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Mar 2025 08:30:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741019454; x=1741624254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dM3d7FaE0s/3W03pV+cOCeas1Rcyk2uf0DwTQW3h1Ys=;
        b=uS+Ei+EfEmg16J3LdWUA4wsWyPQt2id2dpcrw5jG0hPaXGy65a72fruHMD5+whYQyP
         88NiGg48/Ou0eR52Shw9icFbTunmjUtlD+nBxd7J6SAFxrvBPx9GSOeuJupU8Jt1kEcg
         WbalWLcWMFT3mGHnG03yRHdXcebDzsIYPVJdBdBoeJJHGAw8TMraoyqBRvgYgjI1YZHk
         BGoBgeDJRS791YjPP8DYHpYrxqWkV/K/lgTyE2GerFVk45Oyp0VxhR/eweci3aR0ddF/
         Rz3ULHAc7TUawF4jFJLNzN8wF9L37jlni/xmm2UuIgQB2nTvzxhIsfh4o8rgrdR0AVE6
         EPGw==
X-Forwarded-Encrypted: i=1; AJvYcCXqnJLF5wtuuMNp9VzrZ/2lR33rCjiAuGA4oOA3FAnETJyBZ3IcU3gW/xdbRdAncRDYQrcbEqLq+gG7LPLJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxUTCIanB8E/5HL3sCPpSHPwfdbsihyGYg1OdV3Kd3yO69x5/q0
	jpBb5s/3774kNRZi79qxOR0nNvJ6NpWQAqi1zL+e8PLyzEFLhfbo6Ye16k3ghPzFMFg1nLO9/j1
	tF03pX92CiIEHAGdPamuQZzYfPlAg0r5RYHQmUaDlnvY98ZvG8nSYWqn6ZR3KWWk=
X-Gm-Gg: ASbGnct+SF4lsyfEsJxZhIL+Anq2ffHchltwOpWc0tWF7VsXn04JdM55Kn0z/yd47iq
	mtpNztxJy2H4N6eF7ULZ6qzg79hVN0zltEgasKynQTpHxpuOsOMYEOLv5XdP/mapZeXfywDZwyJ
	N1pN/ZQekn9YBB4LxC//y4wYbavDKkwUNmdN60JLiAaR/RlbNgiXUAFwrNZDGX6eRpRED0CJuo0
	YyTDLz94I2RTJ0tRiEiV2St0mY52BalGvKe4HTLCKqprs8pE2Uz8JKRhwiSj9WVowWnR+hbjuRz
	VAP+NEPTBymUg6iyY3LonJUn16qoIyTCcw7qtvMbheSh6G9kVSKzOSqzrcYi1DuEyw8p8TgN/mn
	S
X-Received: by 2002:a05:6000:4c6:b0:38d:c44a:a64b with SMTP id ffacd0b85a97d-390eca2589amr11095174f8f.48.1741019453844;
        Mon, 03 Mar 2025 08:30:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFDds/9qj55eCL2sJuyoEBZpLXmN9fljVQo3ZoynXY2Ft4dglS/KTUjLVmC7la2kWf5hOqFtQ==
X-Received: by 2002:a05:6000:4c6:b0:38d:c44a:a64b with SMTP id ffacd0b85a97d-390eca2589amr11095139f8f.48.1741019453402;
        Mon, 03 Mar 2025 08:30:53 -0800 (PST)
Received: from localhost (p200300cbc7349600af274326a2162bfb.dip0.t-ipconnect.de. [2003:cb:c734:9600:af27:4326:a216:2bfb])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43bbbff18b3sm56885465e9.24.2025.03.03.08.30.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 08:30:53 -0800 (PST)
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
Subject: [PATCH v3 16/20] fs/proc/page: remove per-page mapcount dependency for /proc/kpagecount (CONFIG_NO_PAGE_MAPCOUNT)
Date: Mon,  3 Mar 2025 17:30:09 +0100
Message-ID: <20250303163014.1128035-17-david@redhat.com>
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

Let's implement an alternative when per-page mapcounts in large folios
are no longer maintained -- soon with CONFIG_NO_PAGE_MAPCOUNT.

For large folios, we'll return the per-page average mapcount within the
folio, whereby we round to the closest integer when calculating the
average: however, we'll always return at least 1 if the folio is
mapped.

So assuming a folio with 512 pages, the average would be:
* 0 if not pages are mapped
* 1 if there are 1 .. 767 per-page mappings
* 2 if there are 767 .. 1279 per-page mappings
...

For hugetlb folios and for large folios that are fully mapped
into all address spaces, there is no change.

We'll make use of this helper in other context next.

As an alternative, we could simply return 0 for non-hugetlb large folios,
or disable this legacy interface with CONFIG_NO_PAGE_MAPCOUNT.

But the information exposed by this interface can still be valuable, and
frequently we deal with fully-mapped large folios where the average
corresponds to the actual page mapcount. So we'll leave it like this for
now and document the new behavior.

Note: this interface is likely not very relevant for performance. If
ever required, we could try doing a rather expensive rmap walk to collect
precisely how often this folio page is mapped.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 Documentation/admin-guide/mm/pagemap.rst |  7 ++++-
 fs/proc/internal.h                       | 35 ++++++++++++++++++++++++
 fs/proc/page.c                           | 11 ++++++--
 3 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/mm/pagemap.rst b/Documentation/admin-guide/mm/pagemap.rst
index a297e824f9900..d6647daca9122 100644
--- a/Documentation/admin-guide/mm/pagemap.rst
+++ b/Documentation/admin-guide/mm/pagemap.rst
@@ -43,7 +43,12 @@ There are four components to pagemap:
    skip over unmapped regions.
 
  * ``/proc/kpagecount``.  This file contains a 64-bit count of the number of
-   times each page is mapped, indexed by PFN.
+   times each page is mapped, indexed by PFN. Some kernel configurations do
+   not track the precise number of times a page part of a larger allocation
+   (e.g., THP) is mapped. In these configurations, the average number of
+   mappings per page in this larger allocation is returned instead. However,
+   if any page of the large allocation is mapped, the returned value will
+   be at least 1.
 
 The page-types tool in the tools/mm directory can be used to query the
 number of times a page is mapped.
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 1695509370b88..96ea58e843114 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -174,6 +174,41 @@ static inline int folio_precise_page_mapcount(struct folio *folio,
 	return mapcount;
 }
 
+/**
+ * folio_average_page_mapcount() - Average number of mappings per page in this
+ *				   folio
+ * @folio: The folio.
+ *
+ * The average number of user page table entries that reference each page in
+ * this folio as tracked via the RMAP: either referenced directly (PTE) or
+ * as part of a larger area that covers this page (e.g., PMD).
+ *
+ * The average is calculated by rounding to the nearest integer; however,
+ * to avoid duplicated code in current callers, the average is at least
+ * 1 if any page of the folio is mapped.
+ *
+ * Returns: The average number of mappings per page in this folio.
+ */
+static inline int folio_average_page_mapcount(struct folio *folio)
+{
+	int mapcount, entire_mapcount, avg;
+
+	if (!folio_test_large(folio))
+		return atomic_read(&folio->_mapcount) + 1;
+
+	mapcount = folio_large_mapcount(folio);
+	if (unlikely(mapcount <= 0))
+		return 0;
+	entire_mapcount = folio_entire_mapcount(folio);
+	if (mapcount <= entire_mapcount)
+		return entire_mapcount;
+	mapcount -= entire_mapcount;
+
+	/* Round to closest integer ... */
+	avg = ((unsigned int)mapcount + folio_large_nr_pages(folio) / 2) >> folio_large_order(folio);
+	/* ... but return at least 1. */
+	return max_t(int, avg + entire_mapcount, 1);
+}
 /*
  * array.c
  */
diff --git a/fs/proc/page.c b/fs/proc/page.c
index a55f5acefa974..23fc771100ae5 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -67,9 +67,14 @@ static ssize_t kpagecount_read(struct file *file, char __user *buf,
 		 * memmaps that were actually initialized.
 		 */
 		page = pfn_to_online_page(pfn);
-		if (page)
-			mapcount = folio_precise_page_mapcount(page_folio(page),
-							       page);
+		if (page) {
+			struct folio *folio = page_folio(page);
+
+			if (IS_ENABLED(CONFIG_PAGE_MAPCOUNT))
+				mapcount = folio_precise_page_mapcount(folio, page);
+			else
+				mapcount = folio_average_page_mapcount(folio);
+		}
 
 		if (put_user(mapcount, out)) {
 			ret = -EFAULT;
-- 
2.48.1


