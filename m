Return-Path: <linux-fsdevel+bounces-16480-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D075689E365
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 21:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8574D28319E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 19:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42518158855;
	Tue,  9 Apr 2024 19:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aE3ERRay"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE80157A6F
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Apr 2024 19:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712690728; cv=none; b=eIG2XvCAS7GCtCZau7CzvjF1YboSsJ2/hDO1lDoZn0XvdE4JxR4PuT7sHzk1OX6gDo6N/SSFuQLQQLTyyB4eZXXiynikVp572kFXLWowVse4aEkTrtv5CPGHrhm0QQISiD/Vc3F8XMvrQDEMlSSi8L16sPhv6JEv/bpsRpw9GV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712690728; c=relaxed/simple;
	bh=8ggUQvHKaMkbaZKa6fSqKVjkq7jK/5ChUl8Qcha1vQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ccB9ohY0WCZr4E4X4WTMGhhyg7K0dwpotUKUAJ2Un4DaqgqmfEvR3xNb4vzvK7AO0zdb8NYOZaovaVbClz+TXqx9E26jE8jz0LKyrXoVsrWc5lUPdk+MwMMi+7tp/Zs0y76HSAFluyIHrQzLCJwRK7YCeUZqQDS3TgifhjL2IL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aE3ERRay; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712690726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UDO/LuGyFJsgzNpcvXk5nDcpkN8Vm1hlfEW8fwIXGqY=;
	b=aE3ERRayW9PGzqV0JaiCgUhOOYxvfhOWBIfVVTPZiinJ6Tu0vC0LhIQXFi5dc6tJjTtfMN
	/aYwOLI8f1OyDgDC8WAA6jRa85i3wl1W4taemluK27SE80UW/Y4hLqNMS322ih/ySSS44u
	BrBcGb0GkYYbPEBoXsM7NzqYqPJ3aUo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-q_7BzCqOO76DTj4PZpIcDA-1; Tue, 09 Apr 2024 15:25:22 -0400
X-MC-Unique: q_7BzCqOO76DTj4PZpIcDA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E95FE890524;
	Tue,  9 Apr 2024 19:25:20 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.106])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E1E2B40AE784;
	Tue,  9 Apr 2024 19:25:08 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Peter Xu <peterx@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Yin Fengwei <fengwei.yin@intel.com>,
	Yang Shi <shy828301@gmail.com>,
	Zi Yan <ziy@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Hugh Dickins <hughd@google.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Muchun Song <muchun.song@linux.dev>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <naoya.horiguchi@nec.com>,
	Richard Chang <richardycc@google.com>
Subject: [PATCH v1 09/18] mm/memory-failure: use folio_mapcount() in hwpoison_user_mappings()
Date: Tue,  9 Apr 2024 21:22:52 +0200
Message-ID: <20240409192301.907377-10-david@redhat.com>
In-Reply-To: <20240409192301.907377-1-david@redhat.com>
References: <20240409192301.907377-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

We want to limit the use of page_mapcount() to the places where it is
absolutely necessary. We can only unmap full folios; page_mapped(),
which we check here, is translated to folio_mapped() -- based on
folio_mapcount(). So let's print the folio mapcount instead.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory-failure.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 88359a185c5f..ee2f4b8905ef 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1628,8 +1628,8 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
 
 	unmap_success = !page_mapped(p);
 	if (!unmap_success)
-		pr_err("%#lx: failed to unmap page (mapcount=%d)\n",
-		       pfn, page_mapcount(p));
+		pr_err("%#lx: failed to unmap page (folio mapcount=%d)\n",
+		       pfn, folio_mapcount(page_folio(p)));
 
 	/*
 	 * try_to_unmap() might put mlocked page in lru cache, so call
-- 
2.44.0


