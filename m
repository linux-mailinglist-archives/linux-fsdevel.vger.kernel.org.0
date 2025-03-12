Return-Path: <linux-fsdevel+bounces-43746-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC642A5D37D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 01:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E950D3B45A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 00:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA0C3C30;
	Wed, 12 Mar 2025 00:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JyNDqmP8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C061CF8B
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 00:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741738069; cv=none; b=bOMu2KgGbdv29JjpxyF6ensAkAA7e4D1HQhJcBuipOdRZDOknj233jAFL5RiLgbFbpMEZ0x+oLcHWM2t8VXJYATRrbjHs02Am34obCE0T5WQXeu4NoouOwfPetD18mcMMYJWBThaiax3OJcc+lzA+ZQF+GHRqQiyUaoVztst/yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741738069; c=relaxed/simple;
	bh=jW6AtWVyMEM7z+apFni+IjLD4TPe9lTig4C1iMyf6J0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gi8Ot+Fmzzfxony9gyl8S8sHoL9IRtWnM2xdZiRNIs4vqKXGkLR0YWRr/5Qxr3PS4DTsu3hiEIezJ3ZCfoNI83UxE3QSNspQ3vpsbEI1QZnG2vWG4MN2jlUltucJSYvHWhrzGmwyTOWzt7lieNcF5M57j1kvoNNuL0aZ91H+Sfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JyNDqmP8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741738066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ceDeMBe52N2seuUa756T2OuNElv+sx4xmpEJqAZFNJ0=;
	b=JyNDqmP8FSmPprO18lh2oK8kozc+lT5HfJJfBXA87zGk01g85llVqb3Z0s4u1H2gOt3btN
	AwLsijjck4Q/ziA5X+ieEGchbJYyH0npfRd+AXtE/KZvww97uwQdkPvVBuLaiOxPKuZQ86
	q9OXMsYDUvIMfdZ2SuXdNQNCmZZCPM4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-223-vkQ8710FPFOYX9_CxAjz-Q-1; Tue,
 11 Mar 2025 20:07:42 -0400
X-MC-Unique: vkQ8710FPFOYX9_CxAjz-Q-1
X-Mimecast-MFC-AGG-ID: vkQ8710FPFOYX9_CxAjz-Q_1741738058
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2CA19195608F;
	Wed, 12 Mar 2025 00:07:38 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.88.56])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3CA451955F0F;
	Wed, 12 Mar 2025 00:07:30 +0000 (UTC)
From: Nico Pache <npache@redhat.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	xen-devel@lists.xenproject.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	jerrin.shaji-george@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	mst@redhat.com,
	david@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	jgross@suse.com,
	sstabellini@kernel.org,
	oleksandr_tyshchenko@epam.com,
	akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	nphamcs@gmail.com,
	yosry.ahmed@linux.dev,
	kanchana.p.sridhar@intel.com,
	alexander.atanasov@virtuozzo.com
Subject: [RFC 1/5] meminfo: add a per node counter for balloon drivers
Date: Tue, 11 Mar 2025 18:06:56 -0600
Message-ID: <20250312000700.184573-2-npache@redhat.com>
In-Reply-To: <20250312000700.184573-1-npache@redhat.com>
References: <20250312000700.184573-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Add NR_BALLOON_PAGES counter to track memory used by balloon drivers and
expose it through /proc/meminfo and other memory reporting interfaces.

Signed-off-by: Nico Pache <npache@redhat.com>
---
 fs/proc/meminfo.c      | 2 ++
 include/linux/mmzone.h | 1 +
 mm/memcontrol.c        | 1 +
 mm/show_mem.c          | 4 +++-
 mm/vmstat.c            | 1 +
 5 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index 8ba9b1472390..83be312159c9 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -162,6 +162,8 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 	show_val_kb(m, "Unaccepted:     ",
 		    global_zone_page_state(NR_UNACCEPTED));
 #endif
+	show_val_kb(m, "Balloon:        ",
+		    global_node_page_state(NR_BALLOON_PAGES));
 
 	hugetlb_report_meminfo(m);
 
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 9540b41894da..71d3ff19267a 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -223,6 +223,7 @@ enum node_stat_item {
 #ifdef CONFIG_HUGETLB_PAGE
 	NR_HUGETLB,
 #endif
+	NR_BALLOON_PAGES,
 	NR_VM_NODE_STAT_ITEMS
 };
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4de6acb9b8ec..182b44646bfa 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1377,6 +1377,7 @@ static const struct memory_stat memory_stats[] = {
 #ifdef CONFIG_HUGETLB_PAGE
 	{ "hugetlb",			NR_HUGETLB			},
 #endif
+	{ "nr_balloon_pages",		NR_BALLOON_PAGES		},
 
 	/* The memory events */
 	{ "workingset_refault_anon",	WORKINGSET_REFAULT_ANON		},
diff --git a/mm/show_mem.c b/mm/show_mem.c
index 43afb56abbd3..6af13bcd2ab3 100644
--- a/mm/show_mem.c
+++ b/mm/show_mem.c
@@ -260,6 +260,7 @@ static void show_free_areas(unsigned int filter, nodemask_t *nodemask, int max_z
 			" pagetables:%lukB"
 			" sec_pagetables:%lukB"
 			" all_unreclaimable? %s"
+			" Balloon:%lukB"
 			"\n",
 			pgdat->node_id,
 			K(node_page_state(pgdat, NR_ACTIVE_ANON)),
@@ -285,7 +286,8 @@ static void show_free_areas(unsigned int filter, nodemask_t *nodemask, int max_z
 #endif
 			K(node_page_state(pgdat, NR_PAGETABLE)),
 			K(node_page_state(pgdat, NR_SECONDARY_PAGETABLE)),
-			str_yes_no(pgdat->kswapd_failures >= MAX_RECLAIM_RETRIES));
+			str_yes_no(pgdat->kswapd_failures >= MAX_RECLAIM_RETRIES),
+			K(node_page_state(pgdat, NR_BALLOON_PAGES)));
 	}
 
 	for_each_populated_zone(zone) {
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 16bfe1c694dd..d3b11891a942 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1276,6 +1276,7 @@ const char * const vmstat_text[] = {
 #ifdef CONFIG_HUGETLB_PAGE
 	"nr_hugetlb",
 #endif
+	"nr_balloon_pages",
 	/* system-wide enum vm_stat_item counters */
 	"nr_dirty_threshold",
 	"nr_dirty_background_threshold",
-- 
2.48.1


