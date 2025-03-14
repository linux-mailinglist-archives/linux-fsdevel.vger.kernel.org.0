Return-Path: <linux-fsdevel+bounces-44051-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C18A6A61E5E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 22:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D2A78830CB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 21:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48BC1204F8C;
	Fri, 14 Mar 2025 21:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yid/BI6G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166FD1E8327
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Mar 2025 21:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741988316; cv=none; b=ofP+bzpU5JaegBMbVv9tdtDOD5g2CdHnPYeHOuMCnh5ojaPstNpPkIxjeFkToS1A/M7Vkm6oLIwBd9t/2r4afseztgRIGsN5MJYpC3ds1xRDPp5IzTyiDrw6Zy2+cYoLAA9xS1AiGB+Pp3Fqvt5eNMwiLZSTxxhVxcAJ7csMalI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741988316; c=relaxed/simple;
	bh=aL6XpG6waIwRsJU0cAQlfQb9j2y/yn0NcY83ozborHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=smFGRBmOkZxO3BPRf806no4vI4QfWCZnPUdK07xe5iaMmU50anMweUUiYnfHEXcQfkFfRYRQ5gBUmIbTmsJOR+53w7FWQgODRdrhaJq3x+x6rt9WMFY6SGh+IjOll1czy/2Y6iNNoUylCtPjazyhjajoVlaSTag2TEi+MwUH02Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yid/BI6G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741988314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3RXL+coJsdtD8dzVN3au7Q2NbBlOYxUwoHTJ/KoQPU4=;
	b=Yid/BI6G5Z51PR+EjAgOz1CKMB2IGMXXCnah5+meB+JXGzV8X3eqYCd1OdbOWc/fcNw+E2
	Fku9tJzBLUepyNBNMp9IrvpjZOwOs/ziLIDYZRbFsPt6Dqd3tjJkFEKqWoEmpXKrRYdcJV
	FqKy2O++o+ZgR1telTQVtqDgdwBVtkw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-646-0r6UKT9IMtuF-Il_bN2UWQ-1; Fri,
 14 Mar 2025 17:38:30 -0400
X-MC-Unique: 0r6UKT9IMtuF-Il_bN2UWQ-1
X-Mimecast-MFC-AGG-ID: 0r6UKT9IMtuF-Il_bN2UWQ_1741988303
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A8BDC195608D;
	Fri, 14 Mar 2025 21:38:22 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.80.88])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6352D1944E42;
	Fri, 14 Mar 2025 21:38:17 +0000 (UTC)
From: Nico Pache <npache@redhat.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	virtualization@lists.linux.dev
Cc: alexander.atanasov@virtuozzo.com,
	muchun.song@linux.dev,
	roman.gushchin@linux.dev,
	mhocko@kernel.org,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	jgross@suse.com,
	sstabellini@kernel.org,
	oleksandr_tyshchenko@epam.com,
	akpm@linux-foundation.org,
	mst@redhat.com,
	david@redhat.com,
	yosry.ahmed@linux.dev,
	hannes@cmpxchg.org,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	kanchana.p.sridhar@intel.com,
	llong@redhat.com,
	shakeel.butt@linux.dev
Subject: [PATCH v2 2/4] balloon_compaction: update the NR_BALLOON_PAGES state
Date: Fri, 14 Mar 2025 15:37:55 -0600
Message-ID: <20250314213757.244258-3-npache@redhat.com>
In-Reply-To: <20250314213757.244258-1-npache@redhat.com>
References: <20250314213757.244258-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Update the NR_BALLOON_PAGES counter when pages are added or removed using
the balloon compaction interface.

The virtio, Vmware, and pseries-cmm balloon drivers utilize the
balloon_compaction interface to allocate and free balloon pages. Other
balloon drivers will have to maintain this counter manually.

Signed-off-by: Nico Pache <npache@redhat.com>
---
 mm/balloon_compaction.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
index 6597ebea8ae2..d3e00731e262 100644
--- a/mm/balloon_compaction.c
+++ b/mm/balloon_compaction.c
@@ -24,6 +24,7 @@ static void balloon_page_enqueue_one(struct balloon_dev_info *b_dev_info,
 	balloon_page_insert(b_dev_info, page);
 	unlock_page(page);
 	__count_vm_event(BALLOON_INFLATE);
+	inc_node_page_state(page, NR_BALLOON_PAGES);
 }
 
 /**
@@ -103,6 +104,7 @@ size_t balloon_page_list_dequeue(struct balloon_dev_info *b_dev_info,
 		__count_vm_event(BALLOON_DEFLATE);
 		list_add(&page->lru, pages);
 		unlock_page(page);
+		dec_node_page_state(page, NR_BALLOON_PAGES);
 		n_pages++;
 	}
 	spin_unlock_irqrestore(&b_dev_info->pages_lock, flags);
-- 
2.48.1


