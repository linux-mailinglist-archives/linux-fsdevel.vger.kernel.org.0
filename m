Return-Path: <linux-fsdevel+bounces-42962-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 789DCA4C7DF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 17:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BF661883467
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 16:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D82255E31;
	Mon,  3 Mar 2025 16:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="adEnZ+oQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A325725335F
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Mar 2025 16:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019465; cv=none; b=SAjUO3YekfPATmC5jQ//deWX7cJVRx+7iBOUhnh4f4IP7OJsH5t9rWMzedFSel3QKGCQt7QfD3iNOdhiQ/Q6sB+zTD1kAOeLbX0fzw7XCaHVchQwqvHeQ1SSdc2T4tkpoF21YlBhVlS7X3ffw4b+/7wthWY5wnQXaaut2+mtJ0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019465; c=relaxed/simple;
	bh=tLoq8V+yWL9uG7J57/fSv64hWMwnlNF56fAlUed9ZyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DqoyGkurN2CE5ohQOm6zKOZ/0BNnkRpBH/ds2ytvxpCUPMFhDgNlzbFpha/r0DYKhTCNA8J0rtvDjwNDqpqaIUFAU5AN88ToOlmbXTn/9FcZ04eHvHMcmQ7Z572aFficFfgKbdyszVreE21WcNIr9F7so4KpecAnCuSokG1SJq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=adEnZ+oQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741019461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sbAdVb8IlT1mHMxqkPSZKSMArZKBklKlP7kdJIBKPLI=;
	b=adEnZ+oQOQvYbLnpMePkt3AlwHZzUy8u1XnpE+Khcr//qvPWEG6mVEfZzs3d4v/LsgOFuq
	HxrSRrBImPLcfSpVL6OpMs/iS30oKULPr4sMF8icZJQos3uw7oS89DnL4dKC/Vjl5/HXOl
	duA3gI/gMhk9NS/IJLce5dMhdleakNY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-J7EEgOtiMj-0NwJNGUoYLg-1; Mon, 03 Mar 2025 11:31:00 -0500
X-MC-Unique: J7EEgOtiMj-0NwJNGUoYLg-1
X-Mimecast-MFC-AGG-ID: J7EEgOtiMj-0NwJNGUoYLg_1741019458
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-390e27150dbso4385594f8f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Mar 2025 08:30:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741019458; x=1741624258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sbAdVb8IlT1mHMxqkPSZKSMArZKBklKlP7kdJIBKPLI=;
        b=sWgocbV0lrv6LeDGhFf3D/FZKxDxZrnmv7CPfIxLtMTUh4JgA8v+6NwLrzOVASyMHQ
         p4KS2ZSZH+oEfdB5oU0imJL1v1VHypkI9cEyEskM2HFdkU7YzoQbXabtbiTUgj0vZ5wc
         pIZfZJ8e2cELzJlWSOSndimcU41fNG7rUHqI4dTu/duAsLR8WY5gUb0yJpCN+MSz3au8
         dcolFga/8ON3LdgajogvQVYpd0xEaylrPYG9v7AiodEvNMiPCQW6XDIXj+y6zDZ4khdK
         Zl/LhgQ8lGi2Y7uX9n1RYyUXCK/9lYBlTCDAHNNWnIH7hhKHd3x5vs2wl5jWUH+v7nRK
         NnOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVB1TJdC+25dTnCrYwl6tzAQhneWuEn8WUV9YF0EojdsrEUauy5cfwUfRvQ+v8QquiCk5nqbeX0ZY/b+wCf@vger.kernel.org
X-Gm-Message-State: AOJu0YzM4uSICVGcbQVpNOaC4W8vxEqa5PFSQEczFQcAtV8UgSMgXSt+
	abkUraHrNWmlfPLU2/MxTNvXVTjG5Arn/Rr9m8AUBzPpN+ccBmxtgaHchxeqxtWiXdeUmP4vQGP
	BBdWTBqjsDIqH+4vx6gAYxU6yLEP2gz97hl6UHIqNrL7YephWxx1twVpONygJ8A8=
X-Gm-Gg: ASbGnct+EXJtXcW5FuXNpfWUu4IqPLd6iBzqFNwznfbbzKdxYI0YzTdMrW3PS7bk2G6
	kounbIfEY42iGx8kKgqoWNJKKeyUzLMdSWL3qIQ8vEfiwrQHDIJ6EAZr0sFKcYcvGIytjSTse0b
	6yiuhyJU2zYAdW1odDs7uTYlZuNG+Ux3hq/qn89fdJaXsBOHmKMQCrLYD8miFbX6ib5/3Jd37v1
	Ch8efAWfonO2wmVsV0arw9J5GrVV6trYZv3N8DJKk4POg/mv1gaV98WxTh6iuAi9eL4ZOayMj0C
	Sjy1y1OYmAbYushTQ6E1W0XxjfIEHNmIAevdzDZlvikXgbj1vTwYMe2KC5YRKo2luHBAIZ33Gw+
	+
X-Received: by 2002:a05:6000:156d:b0:38d:e3db:9058 with SMTP id ffacd0b85a97d-390ec7cb945mr10994388f8f.12.1741019457890;
        Mon, 03 Mar 2025 08:30:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvRr8UGYMtbKKLfF4vYk+epXuFbk91XT0kZhy1XfmXmyE27quXMsv2mgA7hFUbYP+d7m+S+Q==
X-Received: by 2002:a05:6000:156d:b0:38d:e3db:9058 with SMTP id ffacd0b85a97d-390ec7cb945mr10994345f8f.12.1741019457510;
        Mon, 03 Mar 2025 08:30:57 -0800 (PST)
Received: from localhost (p200300cbc7349600af274326a2162bfb.dip0.t-ipconnect.de. [2003:cb:c734:9600:af27:4326:a216:2bfb])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-390e47a6aabsm14858335f8f.26.2025.03.03.08.30.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 08:30:57 -0800 (PST)
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
Subject: [PATCH v3 18/20] fs/proc/task_mmu: remove per-page mapcount dependency for "mapmax" (CONFIG_NO_PAGE_MAPCOUNT)
Date: Mon,  3 Mar 2025 17:30:11 +0100
Message-ID: <20250303163014.1128035-19-david@redhat.com>
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
 fs/proc/task_mmu.c                 | 7 ++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 09f0aed5a08ba..1aa190017f796 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -686,6 +686,11 @@ Where:
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
index f937c2df7b3f4..5043376ebd476 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -2866,7 +2866,12 @@ static void gather_stats(struct page *page, struct numa_maps *md, int pte_dirty,
 			unsigned long nr_pages)
 {
 	struct folio *folio = page_folio(page);
-	int count = folio_precise_page_mapcount(folio, page);
+	int count;
+
+	if (IS_ENABLED(CONFIG_PAGE_MAPCOUNT))
+		count = folio_precise_page_mapcount(folio, page);
+	else
+		count = folio_average_page_mapcount(folio);
 
 	md->pages += nr_pages;
 	if (pte_dirty || folio_test_dirty(folio))
-- 
2.48.1


