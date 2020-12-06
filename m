Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 003702D01C3
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Dec 2020 09:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbgLFI1f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Dec 2020 03:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbgLFI1e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Dec 2020 03:27:34 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBFDC08E861
        for <linux-fsdevel@vger.kernel.org>; Sun,  6 Dec 2020 00:27:17 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id f1so5497518plt.12
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Dec 2020 00:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HZOUEjYnrw/jKRYqpi7q020fqNgK9R8UvUzzMbw50zY=;
        b=RmbjjpKFtDs9T47/FGkL0CG6BFwpK6/K/YoUamLBSgnWsWjKTj8yrVmKeBycWQ7gQN
         zq6SfYe6JDMH3V+LAODwnDHVj6rBUOPNDGOXWAPmSdJTzSbdwhnAZvxteLxBBYdL3IHt
         4FMdhhJOQ6E6xQjCF+NYtuSPLkxMz5jtO8yf+Ph/PdVPaOVZGyeHci5skfARy1PX0coQ
         kkqYaKnAmKLSVucJqD7DsCFoNONObz8/Ky1I4ErghvqKJjzS46TaVvbJ9UvAIdw1OmcX
         ITzj7oL9WgeBWAqNAwagylKy2yfBMkNhKC4jOuTdoDYeiHPT6KhE1Hxywk2AOp4iVHeI
         jYhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HZOUEjYnrw/jKRYqpi7q020fqNgK9R8UvUzzMbw50zY=;
        b=sRdRfkkQOEkmNsa1hppvd5oFfjlmXFUvw6viHxT6x5Oh7Zzi8RQCgqStpLEGECra3d
         uZQIzXL1gO6lVbEYVp8W+XBems+rTLOL7ykZfu1moOZDM0EWqpfRuC5tbfBS3kHWN/j4
         X8dit5v8At0JJQUB65XQKj32woXN723L4fdHNB8Pulqhq/MpTR070Q/jcItKU+zJwB3c
         2CR+BaKqfKOzgImj0/7uc/Crj0oX4vTEDV+n5rCs3uuEo8bY0g5+KCAAm1jvq3vJOQwC
         Fq8vleaHLjDHwcXbfVhor0TrAYiZvm6pd5oITuKo8/mTbhN7dDMZtRSTRg3ke5yq7B2p
         RwZA==
X-Gm-Message-State: AOAM532CRNTpxjHv9TIM3n/At2YM5cv0dR5zEmc6NtQLI8GE/TItZsai
        lQsMJQTiOG9//tJ7tosWw2D4pg==
X-Google-Smtp-Source: ABdhPJxkX0NDcl4oC02Df6FTR9ckwWbzwLdNDFyAV7SqFskfJSRdf9BW1JW2vKcP22/0zmIY/Wubsw==
X-Received: by 2002:a17:90a:e38d:: with SMTP id b13mr11686353pjz.101.1607243236861;
        Sun, 06 Dec 2020 00:27:16 -0800 (PST)
Received: from localhost.localdomain ([103.136.221.70])
        by smtp.gmail.com with ESMTPSA id iq3sm6884104pjb.57.2020.12.06.00.27.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Dec 2020 00:27:16 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, adobriyan@gmail.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, hughd@google.com, will@kernel.org,
        guro@fb.com, rppt@kernel.org, tglx@linutronix.de, esyr@redhat.com,
        peterx@redhat.com, krisman@collabora.com, surenb@google.com,
        avagin@openvz.org, elver@google.com, rdunlap@infradead.org,
        iamjoonsoo.kim@lge.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 7/9] mm: memcontrol: convert NR_SHMEM_PMDMAPPED account to pages
Date:   Sun,  6 Dec 2020 16:23:10 +0800
Message-Id: <20201206082318.11532-14-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201206082318.11532-1-songmuchun@bytedance.com>
References: <20201206082318.11532-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert NR_SHMEM_PMDMAPPED account to pages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 drivers/base/node.c | 3 +--
 fs/proc/meminfo.c   | 2 +-
 mm/page_alloc.c     | 3 +--
 mm/rmap.c           | 6 ++++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index a64f9c5484a0..fe90888f90a8 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -463,8 +463,7 @@ static ssize_t node_read_meminfo(struct device *dev,
 			     ,
 			     nid, K(node_page_state(pgdat, NR_ANON_THPS)),
 			     nid, K(node_page_state(pgdat, NR_SHMEM_THPS)),
-			     nid, K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED) *
-				    HPAGE_PMD_NR),
+			     nid, K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED)),
 			     nid, K(node_page_state(pgdat, NR_FILE_THPS)),
 			     nid, K(node_page_state(pgdat, NR_FILE_PMDMAPPED) *
 				    HPAGE_PMD_NR)
diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index 574779b6e48c..b2bff8359497 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -133,7 +133,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 	show_val_kb(m, "ShmemHugePages: ",
 		    global_node_page_state(NR_SHMEM_THPS));
 	show_val_kb(m, "ShmemPmdMapped: ",
-		    global_node_page_state(NR_SHMEM_PMDMAPPED) * HPAGE_PMD_NR);
+		    global_node_page_state(NR_SHMEM_PMDMAPPED));
 	show_val_kb(m, "FileHugePages:  ",
 		    global_node_page_state(NR_FILE_THPS));
 	show_val_kb(m, "FilePmdMapped:  ",
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 8fb9f3d38b67..ddaa1dcd6e38 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5568,8 +5568,7 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 			K(node_page_state(pgdat, NR_SHMEM)),
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 			K(node_page_state(pgdat, NR_SHMEM_THPS)),
-			K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED)
-					* HPAGE_PMD_NR),
+			K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED)),
 			K(node_page_state(pgdat, NR_ANON_THPS)),
 #endif
 			K(node_page_state(pgdat, NR_WRITEBACK_TEMP)),
diff --git a/mm/rmap.c b/mm/rmap.c
index f59e92e26b61..3089ad6bf468 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1219,7 +1219,8 @@ void page_add_file_rmap(struct page *page, bool compound)
 		if (!atomic_inc_and_test(compound_mapcount_ptr(page)))
 			goto out;
 		if (PageSwapBacked(page))
-			__inc_node_page_state(page, NR_SHMEM_PMDMAPPED);
+			__mod_lruvec_page_state(page, NR_SHMEM_PMDMAPPED,
+						HPAGE_PMD_NR);
 		else
 			__inc_node_page_state(page, NR_FILE_PMDMAPPED);
 	} else {
@@ -1260,7 +1261,8 @@ static void page_remove_file_rmap(struct page *page, bool compound)
 		if (!atomic_add_negative(-1, compound_mapcount_ptr(page)))
 			return;
 		if (PageSwapBacked(page))
-			__dec_node_page_state(page, NR_SHMEM_PMDMAPPED);
+			__mod_lruvec_page_state(page, NR_SHMEM_PMDMAPPED,
+						-HPAGE_PMD_NR);
 		else
 			__dec_node_page_state(page, NR_FILE_PMDMAPPED);
 	} else {
-- 
2.11.0

