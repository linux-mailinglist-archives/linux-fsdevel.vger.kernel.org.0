Return-Path: <linux-fsdevel+bounces-15114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B301D88713B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 17:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68C942839F4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 16:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39C45D917;
	Fri, 22 Mar 2024 16:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="VW2nPlDV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE555FDAD
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Mar 2024 16:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711126207; cv=none; b=XlD9DvAYk8zG9UCwJOO8N43UtcFwVIFIbQlqILq0DuIj/J+KaudiHqyYd7jjAUfmMuqtNJliJU+Z4gr0SPwo4Q/VbOu+favzCH3jATpvjnkb/CwSz2PmVvInZhiG1jZZs9KH5KwzXD8Q+DNCz3m1VO8jcP70x+ncsrFPjLqCcjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711126207; c=relaxed/simple;
	bh=mPCCVJRa/QVXByUAn0xqqpuKab7OaVXxpWb4L3ZEwU8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UEZQ8UNiNDds+bpH1stxVyNPtnW5nCmE+XPCXjq+imPOFTesblkostzkEgLQ/0/f/Z7Q91SXF4S3BsDVzivNe/xt4zjMhzcPCrjkOlSHcUEKQDgyT3xXmz82gDAa4SLHRw/iIjM+YS7m/WT8gwc8OUzHNFkVqijosB8Wabi3wPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=VW2nPlDV; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-788598094c4so127111985a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Mar 2024 09:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1711126202; x=1711731002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WJAQS09wl5gL4zlCIvpp2eOQaFo+rGQU6/Vm4ehOJB4=;
        b=VW2nPlDVvgJU3ULRkDcmjiK3SBZCnSmwHod4EKz0qkEOAU8vtVpcTt1mi6knexvNEp
         LEwtaQ1hfeQWVTcGSANfafUPTkefqGB/IQp5QSN0T7X4eTOg2aHZsCJvp/BSnuSTd3J4
         sCl4VyuCx3WOI5P7p9mlLUOmwTiITTrs+qm0ss2rmiXFX3Dq+1w2dQfT/UGWJ/LEfqfd
         2AoEIesmSJjVgsGqJtDJ5aOpNh3Svx7s+HeaM/mfqUhw1D44w7CiIycr95uDepz94P6w
         LDdJMzxmXHxP2W8dHGaNkxdTUlzqbXVvQZcrZiD+L4TlM2cpnpBl9PcJHfMgPNlJgnIw
         yW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711126202; x=1711731002;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WJAQS09wl5gL4zlCIvpp2eOQaFo+rGQU6/Vm4ehOJB4=;
        b=cZuSOHYsQo2eOdcTpwPJ3KqpRzC/knpJ394kGLpT80fjREXVqK8uw7cXnq8PEFoWSK
         AG3KKg7HNwM6AGf+etVVct2l/KvvYcMOzWJja/Sr2+EX2dlYS4sphb5iLniBRwaCuf/y
         5wexTX7Wo+Rr1POpdbbUhs5eUxiMrkZEUUuuS4CfWBiu2svnF7Yr6xYy3bTbOCXILshY
         Bk9S0hSYunzAUm8w6x2Qp7kSTPDcdtn2hkGaKIMydLcpLiL8KmvK0sIwCjs8fF82qGMd
         dRIgvAGmvYx2RlxYTAz1TWTf0UW73pqlsNbt8ccxqdfFy3augpuo8up/dZSCUwrwv1Of
         aioA==
X-Forwarded-Encrypted: i=1; AJvYcCUhvXmWrSpVQncjHZEZLAJzYcvqHP88LZnDk+dLYdrNngekJsHbe3g/IkcsTUOEvHkF8TXFahTBejlPXGIDJuqWyMe+MpF0SRzhUMVuxA==
X-Gm-Message-State: AOJu0Ywg7r3t7cCWvnsq27+BMjbWB0SvrLmzn0FFbnB7rBPMI1RUFX0y
	q1unwR12t3HCFp4y2+nUr6j4BcmMfPuGsOHkTNthq1OIQE2iHl0C01lAcoFwvNY=
X-Google-Smtp-Source: AGHT+IFexvyRbIqkdvdtyRG6N0/IbDNMA+Uq6i3Kv3Q5rLDDu+usO7MCuXyl/v3JGfS729p6TE5JqQ==
X-Received: by 2002:a05:620a:8110:b0:789:ebd1:445a with SMTP id os16-20020a05620a811000b00789ebd1445amr2857290qkn.42.1711126202341;
        Fri, 22 Mar 2024 09:50:02 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:16be])
        by smtp.gmail.com with ESMTPSA id bi18-20020a05620a319200b0078a0774d1basm913629qkb.15.2024.03.22.09.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 09:50:01 -0700 (PDT)
From: Johannes Weiner <hannes@cmpxchg.org>
To: linux-mm@kvack.org
Cc: ying.huang@intel.com,
	david@redhat.com,
	hughd@google.com,
	osandov@fb.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] mm: swapfile: fix SSD detection with swapfile on btrfs
Date: Fri, 22 Mar 2024 12:42:21 -0400
Message-ID: <20240322164956.422815-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btrfs sets si->bdev during swap activation, which currently happens
after swapon's SSD detection and cluster setup. Thus none of the SSD
optimizations and cluster lock splitting are enabled for btrfs swap.

Rearrange the swapon sequence so that filesystem activation happens
before determining swap behavior based on the backing device.

Afterwards, the nonrotational drive is detected correctly:

- Adding 2097148k swap on /mnt/swapfile.  Priority:-3 extents:1 across:2097148k
+ Adding 2097148k swap on /mnt/swapfile.  Priority:-3 extents:1 across:2097148k SS

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/swapfile.c | 141 +++++++++++++++++++++++++-------------------------
 1 file changed, 70 insertions(+), 71 deletions(-)

This survives a swapping smoketest, but I would really appreciate more
eyes on the swap and fs implications of this change.

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 4919423cce76..4dd5f2e8190d 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2919,22 +2919,15 @@ static unsigned long read_swap_header(struct swap_info_struct *p,
 static int setup_swap_map_and_extents(struct swap_info_struct *p,
 					union swap_header *swap_header,
 					unsigned char *swap_map,
-					struct swap_cluster_info *cluster_info,
 					unsigned long maxpages,
 					sector_t *span)
 {
-	unsigned int j, k;
 	unsigned int nr_good_pages;
+	unsigned long i;
 	int nr_extents;
-	unsigned long nr_clusters = DIV_ROUND_UP(maxpages, SWAPFILE_CLUSTER);
-	unsigned long col = p->cluster_next / SWAPFILE_CLUSTER % SWAP_CLUSTER_COLS;
-	unsigned long i, idx;
 
 	nr_good_pages = maxpages - 1;	/* omit header page */
 
-	cluster_list_init(&p->free_clusters);
-	cluster_list_init(&p->discard_clusters);
-
 	for (i = 0; i < swap_header->info.nr_badpages; i++) {
 		unsigned int page_nr = swap_header->info.badpages[i];
 		if (page_nr == 0 || page_nr > swap_header->info.last_page)
@@ -2942,25 +2935,11 @@ static int setup_swap_map_and_extents(struct swap_info_struct *p,
 		if (page_nr < maxpages) {
 			swap_map[page_nr] = SWAP_MAP_BAD;
 			nr_good_pages--;
-			/*
-			 * Haven't marked the cluster free yet, no list
-			 * operation involved
-			 */
-			inc_cluster_info_page(p, cluster_info, page_nr);
 		}
 	}
 
-	/* Haven't marked the cluster free yet, no list operation involved */
-	for (i = maxpages; i < round_up(maxpages, SWAPFILE_CLUSTER); i++)
-		inc_cluster_info_page(p, cluster_info, i);
-
 	if (nr_good_pages) {
 		swap_map[0] = SWAP_MAP_BAD;
-		/*
-		 * Not mark the cluster free yet, no list
-		 * operation involved
-		 */
-		inc_cluster_info_page(p, cluster_info, 0);
 		p->max = maxpages;
 		p->pages = nr_good_pages;
 		nr_extents = setup_swap_extents(p, span);
@@ -2973,9 +2952,55 @@ static int setup_swap_map_and_extents(struct swap_info_struct *p,
 		return -EINVAL;
 	}
 
+	return nr_extents;
+}
+
+static struct swap_cluster_info *setup_clusters(struct swap_info_struct *p,
+						unsigned char *swap_map)
+{
+	unsigned long nr_clusters = DIV_ROUND_UP(p->max, SWAPFILE_CLUSTER);
+	unsigned long col = p->cluster_next / SWAPFILE_CLUSTER % SWAP_CLUSTER_COLS;
+	struct swap_cluster_info *cluster_info;
+	unsigned long i, j, k, idx;
+	int cpu, err = -ENOMEM;
+
+	cluster_info = kvcalloc(nr_clusters, sizeof(*cluster_info), GFP_KERNEL);
 	if (!cluster_info)
-		return nr_extents;
+		goto err;
+
+	for (i = 0; i < nr_clusters; i++)
+		spin_lock_init(&cluster_info[i].lock);
 
+	p->cluster_next_cpu = alloc_percpu(unsigned int);
+	if (!p->cluster_next_cpu)
+		goto err_free;
+
+	/* Random start position to help with wear leveling */
+	for_each_possible_cpu(cpu)
+		per_cpu(*p->cluster_next_cpu, cpu) =
+			get_random_u32_inclusive(1, p->highest_bit);
+
+	p->percpu_cluster = alloc_percpu(struct percpu_cluster);
+	if (!p->percpu_cluster)
+		goto err_free;
+
+	for_each_possible_cpu(cpu) {
+		struct percpu_cluster *cluster;
+
+		cluster = per_cpu_ptr(p->percpu_cluster, cpu);
+		cluster_set_null(&cluster->index);
+	}
+
+	/*
+	 * Mark unusable pages as unavailable. The clusters aren't
+	 * marked free yet, so no list operations are involved yet.
+	 */
+	for (i = 0; i < round_up(p->max, SWAPFILE_CLUSTER); i++)
+		if (i >= p->max || swap_map[i] == SWAP_MAP_BAD)
+			inc_cluster_info_page(p, cluster_info, i);
+
+	cluster_list_init(&p->free_clusters);
+	cluster_list_init(&p->discard_clusters);
 
 	/*
 	 * Reduce false cache line sharing between cluster_info and
@@ -2994,7 +3019,13 @@ static int setup_swap_map_and_extents(struct swap_info_struct *p,
 					      idx);
 		}
 	}
-	return nr_extents;
+
+	return cluster_info;
+
+err_free:
+	kvfree(cluster_info);
+err:
+	return ERR_PTR(err);
 }
 
 SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
@@ -3090,6 +3121,17 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 		goto bad_swap_unlock_inode;
 	}
 
+	error = swap_cgroup_swapon(p->type, maxpages);
+	if (error)
+		goto bad_swap_unlock_inode;
+
+	nr_extents = setup_swap_map_and_extents(p, swap_header, swap_map,
+						maxpages, &span);
+	if (unlikely(nr_extents < 0)) {
+		error = nr_extents;
+		goto bad_swap_unlock_inode;
+	}
+
 	if (p->bdev && bdev_stable_writes(p->bdev))
 		p->flags |= SWP_STABLE_WRITES;
 
@@ -3097,61 +3139,18 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 		p->flags |= SWP_SYNCHRONOUS_IO;
 
 	if (p->bdev && bdev_nonrot(p->bdev)) {
-		int cpu;
-		unsigned long ci, nr_cluster;
-
 		p->flags |= SWP_SOLIDSTATE;
-		p->cluster_next_cpu = alloc_percpu(unsigned int);
-		if (!p->cluster_next_cpu) {
-			error = -ENOMEM;
-			goto bad_swap_unlock_inode;
-		}
-		/*
-		 * select a random position to start with to help wear leveling
-		 * SSD
-		 */
-		for_each_possible_cpu(cpu) {
-			per_cpu(*p->cluster_next_cpu, cpu) =
-				get_random_u32_inclusive(1, p->highest_bit);
-		}
-		nr_cluster = DIV_ROUND_UP(maxpages, SWAPFILE_CLUSTER);
-
-		cluster_info = kvcalloc(nr_cluster, sizeof(*cluster_info),
-					GFP_KERNEL);
-		if (!cluster_info) {
-			error = -ENOMEM;
-			goto bad_swap_unlock_inode;
-		}
-
-		for (ci = 0; ci < nr_cluster; ci++)
-			spin_lock_init(&((cluster_info + ci)->lock));
-
-		p->percpu_cluster = alloc_percpu(struct percpu_cluster);
-		if (!p->percpu_cluster) {
-			error = -ENOMEM;
+		cluster_info = setup_clusters(p, swap_map);
+		if (IS_ERR(cluster_info)) {
+			error = PTR_ERR(cluster_info);
+			cluster_info = NULL;
 			goto bad_swap_unlock_inode;
 		}
-		for_each_possible_cpu(cpu) {
-			struct percpu_cluster *cluster;
-			cluster = per_cpu_ptr(p->percpu_cluster, cpu);
-			cluster_set_null(&cluster->index);
-		}
 	} else {
 		atomic_inc(&nr_rotate_swap);
 		inced_nr_rotate_swap = true;
 	}
 
-	error = swap_cgroup_swapon(p->type, maxpages);
-	if (error)
-		goto bad_swap_unlock_inode;
-
-	nr_extents = setup_swap_map_and_extents(p, swap_header, swap_map,
-		cluster_info, maxpages, &span);
-	if (unlikely(nr_extents < 0)) {
-		error = nr_extents;
-		goto bad_swap_unlock_inode;
-	}
-
 	if ((swap_flags & SWAP_FLAG_DISCARD) &&
 	    p->bdev && bdev_max_discard_sectors(p->bdev)) {
 		/*
-- 
2.44.0


