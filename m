Return-Path: <linux-fsdevel+bounces-27916-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF58A964C6F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 19:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BD12B241E3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 17:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0661B86DA;
	Thu, 29 Aug 2024 16:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JlaYG4gg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B8B1B86D7
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 16:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724950757; cv=none; b=DqzOh60eQ7nBkid7xTpfSSW11Pk+xRKR+sCy6ktB5lT3dDZduobV+cOzB3rxcgT8blB5PZ1oTiB9j6R91NXHe8P9FA8ssXmrwNcIee5vH0pvgs8OksbtC4psBcF3If7q/jB/mgANUC5mB8uaygLn4pThy2KRW567SxMiGk4PtmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724950757; c=relaxed/simple;
	bh=/4f3liGgTHCSBxlNCkznXeziGc69WaWwlAw0W8Tv14I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iboz/eg2I5jGmiBxWF76C8/IubZcxHKRfRwDKAkOxe+Q8sfFHvCMdifz4JOmNWbR2+9VjnUFLr37/xHe/Iz9CIdhwOD1AS45y7PCtPKaZUMYV/a3ak/gwueQaY+s4+nQljmbkj+VHQjUB0o9VjtSYVqBzBm8wlWRbbFw03bhveM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JlaYG4gg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724950755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MiGCooKskvY1haSoDErYW63CNhCWGlypowkYLoi/78c=;
	b=JlaYG4ggMiutZJ6H3Un4SXHxPC9ict6ee9mC22M+8KWxaa/pT67o/trsfeaWk9dm5XRAip
	q+1f9iqMmcR2SU5/840eeFcbWnQGBCoVo+/ZQVH5mtZUNA9r/iqBJ3Q8/QsZmMMVI8UnTz
	p2l0peQtI3hsgdMb7iAc0N7MLor8Ed8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-169-8aXbFsVPOVG-1DFlGxFIdw-1; Thu,
 29 Aug 2024 12:59:11 -0400
X-MC-Unique: 8aXbFsVPOVG-1DFlGxFIdw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6AE9218BC2D7;
	Thu, 29 Aug 2024 16:59:08 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.193.245])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A5CBF1955F21;
	Thu, 29 Aug 2024 16:59:00 +0000 (UTC)
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
Subject: [PATCH v1 15/17] fs/proc/task_mmu: remove per-page mapcount dependency for "mapmax" (CONFIG_NO_PAGE_MAPCOUNT)
Date: Thu, 29 Aug 2024 18:56:18 +0200
Message-ID: <20240829165627.2256514-16-david@redhat.com>
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

Let's implement an alternative when per-page mapcounts in large folios are
no longer maintained -- soon with CONFIG_NO_PAGE_MAPCOUNT.

For calculating "mapmax", we now use the average per-page mapcount in
a large folio instead of the per-page mapcount.

For hugetlb folios and folios that are not partially mapped into MMs,
there is no change.

Likely, this change will not matter much in practice, and an alternative
might be to simple remove this stat with CONFIG_NO_PAGE_MAPCOUNT.
However, there might be value to it, so let's keep it like that and
document the behavior.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 Documentation/filesystems/proc.rst | 5 +++++
 fs/proc/task_mmu.c                 | 8 +++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index e834779d96115..bed03e77c0f91 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -684,6 +684,11 @@ Where:
 node locality page counters (N0 == node0, N1 == node1, ...) and the kernel page
 size, in KB, that is backing the mapping up.
 
+Note that some kernel configurations do not track the precise number of times
+a page part of a larger allocation (e.g., THP) is mapped. In these
+configurations, "mapmax" might corresponds to the average number of mappings
+per page in such a larger allocation instead.
+
 1.2 Kernel data
 ---------------
 
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index f35a63c4b7c7a..3d9fe99346478 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -2872,7 +2872,13 @@ static void gather_stats(struct page *page, struct numa_maps *md, int pte_dirty,
 			unsigned long nr_pages)
 {
 	struct folio *folio = page_folio(page);
-	int count = folio_precise_page_mapcount(folio, page);
+	int count;
+
+#ifdef CONFIG_PAGE_MAPCOUNT
+	count = folio_precise_page_mapcount(folio, page);
+#else
+	count = min_t(int, folio_average_page_mapcount(folio), 1);
+#endif
 
 	md->pages += nr_pages;
 	if (pte_dirty || folio_test_dirty(folio))
-- 
2.46.0


