Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E45292E68FB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Dec 2020 17:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634489AbgL1Qnf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Dec 2020 11:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2634539AbgL1Qne (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Dec 2020 11:43:34 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C147FC061796
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Dec 2020 08:42:30 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id n10so7592185pgl.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Dec 2020 08:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y11k/yAhQtiX4jvjt+OyLEmCGsuSKea0uuhTwB1/ieQ=;
        b=FPZLrjymQcTQhHcbFBY5GURoO6/MBFZDsa7b96P8haA5Mgx30rHleWJoIV0qhEG00G
         3z2/FS1GYAkK07qJW0/c6IwmmiUf/buufDWHAtIQbZeSS+WPzfCrMO9BCpCGfzIv6uL9
         O8HwJnuL2QTWLBqqXMLnzJNg76FcIbTxJs/Enixh80I7g23f7/+3MtX7x0rMEskFGIRd
         130BrgUutbqWc7nikubz2CzB9jgk043Dt4aadPRuTOWYD52uWhlb85p0ELZa54gwIF5o
         LRb7g+x5QsFz/CxA6liqhBdNsBQguk9VEItGopAU+zaQyG1tpF8OQHuhj17sY+Y+M591
         YL5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y11k/yAhQtiX4jvjt+OyLEmCGsuSKea0uuhTwB1/ieQ=;
        b=api7LZ6bvK8x6L6zg0w0IIDdr2HVFlt4gVbUS3jniYEC0Rn0l+JYgGgNlijAjZIG5/
         t1hjxyL+lDoPuJ5ahN5qrCknUvTrWYRWLk9EHNYXybBsk7SFWgiG63y1lZZG/rLzTpwM
         v9Z9evzkEtrcecHzGLjdkrX+mF/0fs1R6uO7sfCN8YBGh22CTohXs54Nbf6D4M7Z/t1+
         9hurahl/YsD3Vme5GVNbOacJz0sqzSSX3w523nQhnnwGwto+TSCj1ARVhUfELHF/7Lop
         OjGIoiC5iMMCChj1VX9r6Ha5IeRpaks2spps9zYpsOZf4Cmu0dFen6O9xBn8WRhR/fRA
         HwgQ==
X-Gm-Message-State: AOAM531XFhcxbEed/kIMhQlUTA8j6zKWr1n0Xl5FBGwQ+nJ+DFzKBSjl
        HtE7r21/gktFa9+gN3aykif25g==
X-Google-Smtp-Source: ABdhPJyX7LC8ivbfwXIOlAXFeG8WozkJd7NhE50k4EUfbPesepYHWkIT1/Tzg4nPQXYI0NW37RWrUw==
X-Received: by 2002:a62:8683:0:b029:1a4:4f3f:7e75 with SMTP id x125-20020a6286830000b02901a44f3f7e75mr41466468pfd.68.1609173750232;
        Mon, 28 Dec 2020 08:42:30 -0800 (PST)
Received: from localhost.bytedance.net ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id r68sm36686306pfr.113.2020.12.28.08.42.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Dec 2020 08:42:29 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, adobriyan@gmail.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, hughd@google.com, shakeelb@google.com,
        guro@fb.com, samitolvanen@google.com, feng.tang@intel.com,
        neilb@suse.de, iamjoonsoo.kim@lge.com, rdunlap@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v6 6/7] mm: memcontrol: convert NR_FILE_PMDMAPPED account to pages
Date:   Tue, 29 Dec 2020 00:41:09 +0800
Message-Id: <20201228164110.2838-7-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201228164110.2838-1-songmuchun@bytedance.com>
References: <20201228164110.2838-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently we use struct per_cpu_nodestat to cache the vmstat
counters, which leads to inaccurate statistics especially THP
vmstat counters. In the systems with hundreds of processors
it can be GBs of memory. For example, for a 96 CPUs system,
the threshold is the maximum number of 125. And the per cpu
counters can cache 23.4375 GB in total.

The THP page is already a form of batched addition (it will
add 512 worth of memory in one go) so skipping the batching
seems like sensible. Although every THP stats update overflows
the per-cpu counter, resorting to atomic global updates. But
it can make the statistics more accuracy for the THP vmstat
counters.

So we convert the NR_FILE_PMDMAPPED account to pages. This
patch is consistent with 8f182270dfec ("mm/swap.c: flush lru
pvecs on compound page arrival"). Doing this also can make the
unit of vmstat counters more unified. Finally, the unit of the
vmstat counters are pages, kB and bytes. The B/KB suffix can
tell us that the unit is bytes or kB. The rest which is without
suffix are pages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 drivers/base/node.c    | 3 +--
 fs/proc/meminfo.c      | 2 +-
 include/linux/mmzone.h | 3 ++-
 mm/rmap.c              | 6 ++++--
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 7a66aefe4e46..d02d86aec19f 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -465,8 +465,7 @@ static ssize_t node_read_meminfo(struct device *dev,
 			     nid, K(node_page_state(pgdat, NR_SHMEM_THPS)),
 			     nid, K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED)),
 			     nid, K(node_page_state(pgdat, NR_FILE_THPS)),
-			     nid, K(node_page_state(pgdat, NR_FILE_PMDMAPPED) *
-				    HPAGE_PMD_NR)
+			     nid, K(node_page_state(pgdat, NR_FILE_PMDMAPPED))
 #endif
 			    );
 	len += hugetlb_report_node_meminfo(buf, len, nid);
diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index c61f440570f9..6fa761c9cc78 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -137,7 +137,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 	show_val_kb(m, "FileHugePages:  ",
 		    global_node_page_state(NR_FILE_THPS));
 	show_val_kb(m, "FilePmdMapped:  ",
-		    global_node_page_state(NR_FILE_PMDMAPPED) * HPAGE_PMD_NR);
+		    global_node_page_state(NR_FILE_PMDMAPPED));
 #endif
 
 #ifdef CONFIG_CMA
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 7bdbfeeb5c8c..66d68e5d5a0f 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -222,7 +222,8 @@ static __always_inline bool vmstat_item_print_in_thp(enum node_stat_item item)
 	return item == NR_ANON_THPS ||
 	       item == NR_FILE_THPS ||
 	       item == NR_SHMEM_THPS ||
-	       item == NR_SHMEM_PMDMAPPED;
+	       item == NR_SHMEM_PMDMAPPED ||
+	       item == NR_FILE_PMDMAPPED;
 }
 
 /*
diff --git a/mm/rmap.c b/mm/rmap.c
index 1c1b576c0627..5ebf16fae4b9 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1223,7 +1223,8 @@ void page_add_file_rmap(struct page *page, bool compound)
 			__mod_lruvec_page_state(page, NR_SHMEM_PMDMAPPED,
 						nr_pages);
 		else
-			__inc_node_page_state(page, NR_FILE_PMDMAPPED);
+			__mod_lruvec_page_state(page, NR_FILE_PMDMAPPED,
+						nr_pages);
 	} else {
 		if (PageTransCompound(page) && page_mapping(page)) {
 			VM_WARN_ON_ONCE(!PageLocked(page));
@@ -1267,7 +1268,8 @@ static void page_remove_file_rmap(struct page *page, bool compound)
 			__mod_lruvec_page_state(page, NR_SHMEM_PMDMAPPED,
 						-nr_pages);
 		else
-			__dec_node_page_state(page, NR_FILE_PMDMAPPED);
+			__mod_lruvec_page_state(page, NR_FILE_PMDMAPPED,
+						-nr_pages);
 	} else {
 		if (!atomic_add_negative(-1, &page->_mapcount))
 			return;
-- 
2.11.0

