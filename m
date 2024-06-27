Return-Path: <linux-fsdevel+bounces-22559-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C283919BCE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 02:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90987B22A5F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 00:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED7F5672;
	Thu, 27 Jun 2024 00:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dI66lZAj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A25FA94F
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jun 2024 00:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719448846; cv=none; b=jjfMa3PyVMxQJ+bIQe0m1AB3fcfjwG8vJJtALlWewOFc19gRUhahdNELDcNhHS13ngkaMPMJN4lrbMErmTcXNXQSYRNiGP+PtdB7AoBwpuZjs4IJlgvNnuTWnrzT0EBx21tDrYYcYeKdFJZiodgn6aVbyoAeiOTdBaGri+UjDyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719448846; c=relaxed/simple;
	bh=1/vTUHqkePMQDhqmfkZcXE+JnHBahBkDKApQ779qjvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MAJY+vCy2Y+V2m5l1G65R++4gFu5epNqeKH9RbUf8juVyYcTUMjCKFeQh4I9XXu7Pq0KzK5sxbNPgfi4dwmoWlBPxNNnP6fMJV0NFHCG2PNYpHsEVOPQNIItK6CehRQ3+q9AIMItWHfTYxbn+E2wgq3Uq3li6FPyM2ln00Gn8+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dI66lZAj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719448844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jpi+fgLo1ULqWmpEQ2+qF68D2vMR0O19pRh9JT+w8Y8=;
	b=dI66lZAjhX0zRiLKSAK2ydQ6u4bt3utZ7WpsyrfLCodVm7M0CKOylI7RNuSiz0Re2NQLXF
	NMn/sPHTBu0pZigUYGZzrUVScfxKG85w+Qw2GIukLb3yEzKvULW8WnnxfPatTl7n8WEx3I
	VFLE2egJSThzBOT/ksKhQNbnUkr6Gyw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-338-R7BSrjyTOliwFewI5PiLbA-1; Wed,
 26 Jun 2024 20:40:39 -0400
X-MC-Unique: R7BSrjyTOliwFewI5PiLbA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2AA631956096;
	Thu, 27 Jun 2024 00:40:37 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.remote.csb (unknown [10.64.136.58])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BE1C71956087;
	Thu, 27 Jun 2024 00:40:30 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	david@redhat.com,
	willy@infradead.org,
	akpm@linux-foundation.org,
	ryan.roberts@arm.com,
	hughd@google.com,
	william.kucharski@oracle.com,
	djwong@kernel.org,
	torvalds@linux-foundation.org,
	ddutile@redhat.com,
	zhenyzha@redhat.com,
	shan.gavin@gmail.com
Subject: [PATCH v2 2/4] mm/readahead: Limit page cache size in page_cache_ra_order()
Date: Thu, 27 Jun 2024 10:39:50 +1000
Message-ID: <20240627003953.1262512-3-gshan@redhat.com>
In-Reply-To: <20240627003953.1262512-1-gshan@redhat.com>
References: <20240627003953.1262512-1-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

In page_cache_ra_order(), the maximal order of the page cache to be
allocated shouldn't be larger than MAX_PAGECACHE_ORDER. Otherwise,
it's possible the large page cache can't be supported by xarray when
the corresponding xarray entry is split.

For example, HPAGE_PMD_ORDER is 13 on ARM64 when the base page size
is 64KB. The PMD-sized page cache can't be supported by xarray.

Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
Cc: stable@kernel.org # v5.18+
Signed-off-by: Gavin Shan <gshan@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 mm/readahead.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index c1b23989d9ca..817b2a352d78 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -503,11 +503,11 @@ void page_cache_ra_order(struct readahead_control *ractl,
 
 	limit = min(limit, index + ra->size - 1);
 
-	if (new_order < MAX_PAGECACHE_ORDER) {
+	if (new_order < MAX_PAGECACHE_ORDER)
 		new_order += 2;
-		new_order = min_t(unsigned int, MAX_PAGECACHE_ORDER, new_order);
-		new_order = min_t(unsigned int, new_order, ilog2(ra->size));
-	}
+
+	new_order = min_t(unsigned int, MAX_PAGECACHE_ORDER, new_order);
+	new_order = min_t(unsigned int, new_order, ilog2(ra->size));
 
 	/* See comment in page_cache_ra_unbounded() */
 	nofs = memalloc_nofs_save();
-- 
2.45.1


