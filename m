Return-Path: <linux-fsdevel+bounces-16478-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC0989E35A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 21:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 080031C21A6B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 19:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E48B1581E9;
	Tue,  9 Apr 2024 19:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mj8euJmy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39895157E81
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Apr 2024 19:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712690704; cv=none; b=sheh9KD8nwc46r5Yv3drDPrcPIO0tA1dGVzUvavszWZvpDxjqVNpEnBzt53JYxdUDEpKSP5QBJ95asKdmkzgU6MbsacONy8OCCu2TbXNdLNZqqHSCTiq5JEUq7rQTQfmORZzR2T4Vt2pSVhMOAvDyj3Sxm59m2pr2v17drRWWVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712690704; c=relaxed/simple;
	bh=FAIHwezgBzib8qVcIz1KMdTokmMBm7CLgJNhlG06JSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hny19y4wJWd5bFw6ox4jwO2cbW6SNB/UglF5Lwb5QUVs0Dsj3Jn66H+r1iTQwkeB5Yj7Jz/fSwchapUrZjo5qArseIeW9e1pI8tEMq25CAWkQO29u5v4V3/6SD4gH8kP1pPSAxhffYEEIQf6aIWqsNKoCicX53SaLWulTaWlXHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mj8euJmy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712690702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6rnCGH1F82LpMt5YjVvPZTK3t5BGo8uUqDhbNYCO1mM=;
	b=Mj8euJmyRbkqnGtXpMHf65w26Z9md3rt3ifAm+BoSVIrjYQjF6/TWfFWxPaOn/O3w2vUo6
	AenTeskHeiXKQMCTVVBG861ko4x+M35IMY9vNL5kIr91Fg82VeXT4va2j8p22Jr6YxvXmj
	3Vi/Slmvart/Rh0cNZgL2NHKU7Zq9AM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-195-HVcby02FNvy6GQIyoWw54g-1; Tue,
 09 Apr 2024 15:24:57 -0400
X-MC-Unique: HVcby02FNvy6GQIyoWw54g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6D86429AA392;
	Tue,  9 Apr 2024 19:24:56 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.106])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0A40740B497A;
	Tue,  9 Apr 2024 19:24:42 +0000 (UTC)
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
Subject: [PATCH v1 07/18] mm/memory: use folio_mapcount() in zap_present_folio_ptes()
Date: Tue,  9 Apr 2024 21:22:50 +0200
Message-ID: <20240409192301.907377-8-david@redhat.com>
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
absolutely necessary. In zap_present_folio_ptes(), let's simply check
the folio mapcount(). If there is some issue, it will underflow at some
point either way when unmapping.

As indicated already in commit 10ebac4f95e7 ("mm/memory: optimize unmap/zap
with PTE-mapped THP"), we already documented "If we ever have a cheap
folio_mapcount(), we might just want to check for underflows there.".

There is no change for small folios. For large folios, we'll now catch
more underflows when batch-unmapping, because instead of only testing
the mapcount of the first subpage, we'll test if the folio mapcount
underflows.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 78422d1c7381..178492efb4af 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1502,8 +1502,7 @@ static __always_inline void zap_present_folio_ptes(struct mmu_gather *tlb,
 	if (!delay_rmap) {
 		folio_remove_rmap_ptes(folio, page, nr, vma);
 
-		/* Only sanity-check the first page in a batch. */
-		if (unlikely(page_mapcount(page) < 0))
+		if (unlikely(folio_mapcount(folio) < 0))
 			print_bad_pte(vma, addr, ptent, page);
 	}
 
-- 
2.44.0


