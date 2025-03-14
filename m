Return-Path: <linux-fsdevel+bounces-44050-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DF1A61E5C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 22:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0B35460758
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 21:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B4D204F6F;
	Fri, 14 Mar 2025 21:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XP0ejiBY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544571A5B82
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Mar 2025 21:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741988307; cv=none; b=o6pRvr4Of7eaNOS/X9LMENC5O0nx99srkETtTeG+mOirUeSxqtND0xKbN4/pFPI7FFlse+CNYzbe2/NJB6hyyvpb1nZ+ZH8kU84qnqXx9uD+DgLGoFF296eQwdMtodSoI/yUh+DC33yxKh0GQj3aSe5M1gCOpN22irNxWzuoX6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741988307; c=relaxed/simple;
	bh=KR7Rgigui5nMqE+lqkr212HsL5acvMFEx4PkGQEmMBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tW1c2XxnXfbu8lQD0OEujKn4WPlQvITEaUDrgR1KuvfLurZNJXsj+MG+H9uNMds7fC3HiBzjeztnRgNd9EkxURWu5ycjxcLrGfSJAPjEH2Bjfvt+O2CsE9zHmHEWUttJDcLY5u3GuiVn3XICXSBPo9o+faqj6+WcJwd2Ua2CYSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XP0ejiBY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741988305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Syhhy4ulIUlWqTYydvlvGA6nZmvGM1l/r4DiZeh/SB8=;
	b=XP0ejiBYDdD8oyssUKQjtjXfAeXN8qIphonnq71+/3G5R6Pq0X4g7V3AqEBjX0bfAIZYQ2
	/6z8rpzH9ERz5PqG2BPBGo2dv4FQOVRVpLeHoQzWOuIXGeKv6D0o2etM+TP505gg7ssoQd
	pIzm3OGVq1EiKoNzwvVlqWVli/HzmMY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-116-ltqb4lcePE69hcWXSe8vYA-1; Fri,
 14 Mar 2025 17:38:21 -0400
X-MC-Unique: ltqb4lcePE69hcWXSe8vYA-1
X-Mimecast-MFC-AGG-ID: ltqb4lcePE69hcWXSe8vYA_1741988298
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 28885180034D;
	Fri, 14 Mar 2025 21:38:17 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.80.88])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B05D41944DC5;
	Fri, 14 Mar 2025 21:38:11 +0000 (UTC)
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
Subject: [PATCH v2 1/4] meminfo: add a per node counter for balloon drivers
Date: Fri, 14 Mar 2025 15:37:54 -0600
Message-ID: <20250314213757.244258-2-npache@redhat.com>
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

Add NR_BALLOON_PAGES counter to track memory used by balloon drivers and
expose it through /proc/meminfo and other memory reporting interfaces.

Signed-off-by: Nico Pache <npache@redhat.com>
---
 fs/proc/meminfo.c      | 2 ++
 include/linux/mmzone.h | 1 +
 mm/show_mem.c          | 4 +++-
 mm/vmstat.c            | 1 +
 4 files changed, 7 insertions(+), 1 deletion(-)

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


