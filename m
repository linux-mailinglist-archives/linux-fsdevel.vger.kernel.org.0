Return-Path: <linux-fsdevel+bounces-16477-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E80989E356
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 21:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52EFB1F236ED
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 19:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC6D1586C0;
	Tue,  9 Apr 2024 19:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JyD2fiHj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997E5158212
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Apr 2024 19:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712690693; cv=none; b=fzNpMjF9y/RFsA8fP3Oe8n4Pvd556xx4F8qlN7E8SQN2KsUMAwPmTLIGP+ChPQYW72XHYoirdcL6vBRpd6R8KXE2dxxEyh7NgKqbrIaxhoZR/3Vli9mnF3gUmp7crD7CSqhu1Y/DrMRWj7VmVHtQGnp7mx2ZWyAB6plTNmbS8mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712690693; c=relaxed/simple;
	bh=f2r6XGWVgx08KSMlFSZ6qHtz58Yi8+jxNoK6fRu4Nds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nu+6Kud0e2svbk8/8WUfLTozROxUjgpyLOI9+jT8VkxFPFzwfektqB6QiME+rHq7Tv9siqnqSuz8wpSjGHUVgBaaiYYTPJP7oUkcbekjuYM5NIPq/CqW78UfPTJGUKNld7hwdlAUERKKX2SQ2PfJaIB7kcPOdIyI+4ow9RPjXLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JyD2fiHj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712690690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kfmOqlR3LeI6JA5XUUI6YoG07vX8W74qIyKiUchjaJU=;
	b=JyD2fiHjiLQfbwFCydKVWOonHr3AYfBobrYWYGx1t4vQG5pFUih5y/LS7JcFtC7EC8lAC6
	UsVpzr1FwWtbAeHv2M8NjGmLyZ9uY5ueafp9t+KokPIBIHW5ss/TmzGEiF63M2H5JQ5nEc
	dIIBgCgQwbwGLzf7HoiwaCB6MZvITTU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-N-WWN3PRODGQvvQK2vZjIQ-1; Tue, 09 Apr 2024 15:24:44 -0400
X-MC-Unique: N-WWN3PRODGQvvQK2vZjIQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B730680B51A;
	Tue,  9 Apr 2024 19:24:42 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.106])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DCED040B4979;
	Tue,  9 Apr 2024 19:24:33 +0000 (UTC)
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
Subject: [PATCH v1 06/18] mm: make folio_mapcount() return 0 for small typed folios
Date: Tue,  9 Apr 2024 21:22:49 +0200
Message-ID: <20240409192301.907377-7-david@redhat.com>
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

We already handle it properly for large folios. Let's also return "0"
for small typed folios, like page_mapcount() currently would.

Consequently, folio_mapcount() will never return negative values for
typed folios, but may return negative values for underflows.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index daf687f0e8e5..d453232bba62 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1260,12 +1260,19 @@ static inline int folio_large_mapcount(const struct folio *folio)
  * references the entire folio counts exactly once, even when such special
  * page table entries are comprised of multiple ordinary page table entries.
  *
+ * Will report 0 for pages which cannot be mapped into userspace, such as
+ * slab, page tables and similar.
+ *
  * Return: The number of times this folio is mapped.
  */
 static inline int folio_mapcount(const struct folio *folio)
 {
-	if (likely(!folio_test_large(folio)))
-		return atomic_read(&folio->_mapcount) + 1;
+	int mapcount;
+
+	if (likely(!folio_test_large(folio))) {
+		mapcount = atomic_read(&folio->_mapcount);
+		return page_type_has_type(mapcount) ? 0 : mapcount + 1;
+	}
 	return folio_large_mapcount(folio);
 }
 
-- 
2.44.0


