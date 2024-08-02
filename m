Return-Path: <linux-fsdevel+bounces-24884-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D9C94610A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 17:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AD16B2281F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 15:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FD721C18B;
	Fri,  2 Aug 2024 15:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HuLoOscQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A321537B5
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Aug 2024 15:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722614185; cv=none; b=EAmU/fz+vpOB1J2MmlQoRvY0qNExZidbWj/dZ3/ksJ2YT/Rw0FihZS5/RXdGTfz4m082mSWZcWoNu++Vgqn+YvfaVNG5Mc5gqS7dAPfTexDGK1yYto4oEez9i+6b3+HBWLZlWr98AVddj3kxXtVvqEs/yuENPGeSfxayBHBxMiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722614185; c=relaxed/simple;
	bh=zyobrQ+EEzE8yl0gNwh8+PYSEOv1I4PIQJWs9IzsPB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nKj+Fyog2qdN7Ke6wXh09C9j5GBbNTIsEW93tx1npnj8qaAPZ3DwdGUQD0678t330Br5mH1nDYKFWZwx7BuKm0rq92MIZU3arQOd9Dh5INToM/3b+hkg5xov91U4AyZGGpui1BOFmIVL/oMexmotF6KZi7sXAeLfxRoLEvzzEnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HuLoOscQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722614183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9RoWh69jXPnUan+groy9VerJmyWjUE6OshAG0jiN7k8=;
	b=HuLoOscQFYrc9mvVRei+ZFuoqJYaHprOOPjgJvXQLtrAG4lvRh23A83FxTMpuK55dKr8iz
	6KNlzelTfSyUAvoX9zsg1njSbNgHEbDeIxDimfiQL864HDpK+ltz4JDvxdprpJUeexHYG6
	N51MtgYDkfzCZyY2qx7NIRSAXXUR39o=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-6rd6U-xePRWdI5xPe_dR3w-1; Fri,
 02 Aug 2024 11:56:15 -0400
X-MC-Unique: 6rd6U-xePRWdI5xPe_dR3w-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 45CAA18B65ED;
	Fri,  2 Aug 2024 15:56:13 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.113])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8A4CE300018D;
	Fri,  2 Aug 2024 15:56:06 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Subject: [PATCH v1 06/11] mm/ksm: convert scan_get_next_rmap_item() from follow_page() to folio_walk
Date: Fri,  2 Aug 2024 17:55:19 +0200
Message-ID: <20240802155524.517137-7-david@redhat.com>
In-Reply-To: <20240802155524.517137-1-david@redhat.com>
References: <20240802155524.517137-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Let's use folio_walk instead, for example avoiding taking temporary
folio references if the folio does obviously not even apply and getting
rid of one more follow_page() user. We cannot move all handling under the
PTL, so leave the rmap handling (which implies an allocation) out.

Note that zeropages obviously don't apply: old code could just have
specified FOLL_DUMP. Further, we don't care about losing the secretmem
check in follow_page(): these are never anon pages and
vma_ksm_compatible() would never consider secretmem vmas
(VM_SHARED | VM_MAYSHARE must be set for secretmem, see secretmem_mmap()).

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/ksm.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 742b005f3f77..0f5b2bba4ef0 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2564,36 +2564,46 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
 			ksm_scan.address = vma->vm_end;
 
 		while (ksm_scan.address < vma->vm_end) {
+			struct page *tmp_page = NULL;
+			struct folio_walk fw;
+			struct folio *folio;
+
 			if (ksm_test_exit(mm))
 				break;
-			*page = follow_page(vma, ksm_scan.address, FOLL_GET);
-			if (IS_ERR_OR_NULL(*page)) {
-				ksm_scan.address += PAGE_SIZE;
-				cond_resched();
-				continue;
+
+			folio = folio_walk_start(&fw, vma, ksm_scan.address, 0);
+			if (folio) {
+				if (!folio_is_zone_device(folio) &&
+				     folio_test_anon(folio)) {
+					folio_get(folio);
+					tmp_page = fw.page;
+				}
+				folio_walk_end(&fw, vma);
 			}
-			if (is_zone_device_page(*page))
-				goto next_page;
-			if (PageAnon(*page)) {
-				flush_anon_page(vma, *page, ksm_scan.address);
-				flush_dcache_page(*page);
+
+			if (tmp_page) {
+				flush_anon_page(vma, tmp_page, ksm_scan.address);
+				flush_dcache_page(tmp_page);
 				rmap_item = get_next_rmap_item(mm_slot,
 					ksm_scan.rmap_list, ksm_scan.address);
 				if (rmap_item) {
 					ksm_scan.rmap_list =
 							&rmap_item->rmap_list;
 
-					if (should_skip_rmap_item(*page, rmap_item))
+					if (should_skip_rmap_item(tmp_page, rmap_item)) {
+						folio_put(folio);
 						goto next_page;
+					}
 
 					ksm_scan.address += PAGE_SIZE;
-				} else
-					put_page(*page);
+					*page = tmp_page;
+				} else {
+					folio_put(folio);
+				}
 				mmap_read_unlock(mm);
 				return rmap_item;
 			}
 next_page:
-			put_page(*page);
 			ksm_scan.address += PAGE_SIZE;
 			cond_resched();
 		}
-- 
2.45.2


