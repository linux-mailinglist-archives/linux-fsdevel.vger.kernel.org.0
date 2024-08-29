Return-Path: <linux-fsdevel+bounces-27914-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8281F964C68
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 19:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C99D2B21E9B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 17:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D2C1B86C5;
	Thu, 29 Aug 2024 16:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MIDHBggJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EDD1B81DB
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 16:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724950742; cv=none; b=WVzlTr/o6q57N4bAZ/QbjT4bSNApFK6F9aXT7O3w1YhMQx0k1bYxIr4hS55iaTxyTbW/UpA/6dbA3ciE5tOF4OjBnvSVn3ufZdx8p5Jffjo69PiuYYWWW942GmeeflPWk1q30gXH4lNxXKcPlkbtkI/qte4VucBjB/6rZDaZNcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724950742; c=relaxed/simple;
	bh=HNUw6L79YorAY7Er9IcXo5/0qoizTqeiSeFuYwU1AX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=naa++6cmRE5NijOizhPOtZdJTb737wYgQeS7SPoe0feUTv9vxl1B3mN2jSgCZRr5bfD9o14FSQblp4JYa3i3mzwSBy/ptx6tKF9PBlXfrOyEK6k6ZroJkyuPOrNPg6Yq3kb/surprwB9B+mebiODjcmuIJQ/SgoK8LpdGrf05Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MIDHBggJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724950740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/4w50puZlu0HXrTGynq7fLz3hKXbxnRdIDDiKfwRwdI=;
	b=MIDHBggJjuRbN5jmkFDAYktU12AH0nDt/FqD1zLCI/Hl0v1nRWzFA7pUwrFtmjZeyTkNBZ
	S2L1hkq2E8/cVbAn25UGDffFn1+Wpu6mLnfPoVG14dlEnsruDEpQWhyYiQZTGvzYXMep1N
	xmRJrANuwDlVwQqw+ge6iFjpCobft3I=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-251-I4RGjMuXNxC500-cFdsqyQ-1; Thu,
 29 Aug 2024 12:58:55 -0400
X-MC-Unique: I4RGjMuXNxC500-cFdsqyQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4912C18F498B;
	Thu, 29 Aug 2024 16:58:51 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.193.245])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1C0F81955F21;
	Thu, 29 Aug 2024 16:58:44 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	x86@kernel.org,
	linux-fsdevel@vger.kernel.org,
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
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v1 13/17] fs/proc/page: remove per-page mapcount dependency for /proc/kpagecount (CONFIG_NO_PAGE_MAPCOUNT)
Date: Thu, 29 Aug 2024 18:56:16 +0200
Message-ID: <20240829165627.2256514-14-david@redhat.com>
In-Reply-To: <20240829165627.2256514-1-david@redhat.com>
References: <20240829165627.2256514-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Let's implement an alternative when per-page mapcounts in large folios
are no longer maintained -- soon with CONFIG_NO_PAGE_MAPCOUNT.

For large folios, we'll return the per-page average mapcount within the
folio, except when the average is 0 but the folio is mapped: then we
return 1.

For hugetlb folios and for large folios that are fully mapped
into all address spaces, there is no change.

As an alternative, we could simply return 0 for non-hugetlb large folios,
or disable this legacy interface with CONFIG_NO_PAGE_MAPCOUNT.

But the information exposed by this interface can still be valuable, and
frequently we deal with fully-mapped large folios where the average
corresponds to the actual page mapcount. So we'll leave it like this for
now and document the new behavior.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 Documentation/admin-guide/mm/pagemap.rst |  7 +++++-
 fs/proc/internal.h                       | 31 ++++++++++++++++++++++++
 fs/proc/page.c                           | 18 +++++++++++---
 3 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/mm/pagemap.rst b/Documentation/admin-guide/mm/pagemap.rst
index caba0f52dd36c..49590306c61a0 100644
--- a/Documentation/admin-guide/mm/pagemap.rst
+++ b/Documentation/admin-guide/mm/pagemap.rst
@@ -42,7 +42,12 @@ There are four components to pagemap:
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
index cc520168f8b69..3c687f97e18c4 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -174,6 +174,37 @@ static inline int folio_precise_page_mapcount(struct folio *folio,
 	return mapcount;
 }
 
+/**
+ * folio_average_page_mapcount() - Average number of mappings per page in this
+ *				   folio
+ * @folio: The folio.
+ *
+ * The average number of present user page table entries that reference each
+ * page in this folio as tracked via the RMAP: either referenced directly
+ * (PTE) or as part of a larger area that covers this page (e.g., PMD).
+ *
+ * Returns: The average number of mappings per page in this folio. 0 for
+ * folios that are not mapped to user space or are not tracked via the RMAP
+ * (e.g., shared zeropage).
+ */
+static inline int folio_average_page_mapcount(struct folio *folio)
+{
+	int mapcount, entire_mapcount;
+	unsigned int adjust;
+
+	if (!folio_test_large(folio))
+		return atomic_read(&folio->_mapcount) + 1;
+
+	mapcount = folio_large_mapcount(folio);
+	entire_mapcount = folio_entire_mapcount(folio);
+	if (mapcount <= entire_mapcount)
+		return entire_mapcount;
+	mapcount -= entire_mapcount;
+
+	adjust = folio_large_nr_pages(folio) / 2;
+	return ((mapcount + adjust) >> folio_large_order(folio)) +
+		entire_mapcount;
+}
 /*
  * array.c
  */
diff --git a/fs/proc/page.c b/fs/proc/page.c
index a55f5acefa974..c7838de949287 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -67,9 +67,21 @@ static ssize_t kpagecount_read(struct file *file, char __user *buf,
 		 * memmaps that were actually initialized.
 		 */
 		page = pfn_to_online_page(pfn);
-		if (page)
-			mapcount = folio_precise_page_mapcount(page_folio(page),
-							       page);
+		if (page) {
+			struct folio *folio = page_folio(page);
+
+#ifdef CONFIG_PAGE_MAPCOUNT
+			mapcount = folio_precise_page_mapcount(folio, page);
+#else /* !CONFIG_PAGE_MAPCOUNT */
+			/*
+			 * Indicate the per-page average, but at least "1" for
+			 * mapped folios.
+			 */
+			mapcount = folio_average_page_mapcount(folio);
+			if (!mapcount && folio_test_large(folio) && folio_mapped(folio))
+				mapcount = 1;
+#endif /* !CONFIG_PAGE_MAPCOUNT */
+		}
 
 		if (put_user(mapcount, out)) {
 			ret = -EFAULT;
-- 
2.46.0


