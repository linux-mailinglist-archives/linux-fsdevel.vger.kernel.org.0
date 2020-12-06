Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB3BE2D01C9
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Dec 2020 09:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbgLFI1m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Dec 2020 03:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbgLFI1m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Dec 2020 03:27:42 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B518C061A53
        for <linux-fsdevel@vger.kernel.org>; Sun,  6 Dec 2020 00:26:51 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id j13so5669565pjz.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Dec 2020 00:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dMdFQuYVxvcZn8v/8mwYCe8GX7PJ+nj7kDaLzG21jFc=;
        b=bkG0WB3RwFLFzPbPgpLleJ0rGpSRW4ZQxqqCN4SZCVMNhOE+6vRa7Ver9MYRZVo4t3
         rPtQfxUPapsWjqVM6Y7U7hpwUw5niO3DrO+s3axG5coXtERIg4yIWb0ik49349FczzWS
         I8+FgDwL5u1kifwFAttp/XswWwZBO3znNOiZybI/11JT/W0twTy0eFX+G2ysNTVBpToZ
         K+FoosB92qJt4nqZBt3/MxGQdvjIVF51JIu9/ajN1Crj+QkaYNmJagv79NoCPzpK9L4H
         RTKTSSI4zHK69vBOJfXY8y3AsfqrNC9c5LiWa7tacsnG9FTsiwr55gWMmVNUAqdfaK9f
         weHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dMdFQuYVxvcZn8v/8mwYCe8GX7PJ+nj7kDaLzG21jFc=;
        b=QQESaWQGJdsZnIJ8ZcK5kl5vPcdXELX0TRwg2wGbm3sokb9Joo0I2pN4XIlxk5RFVk
         2YJOau1VcM5W2MGbd9mdiJOYDH4pL1smML+08JkbgKhvkkNGrEStumhHAtOzrPHv5AZZ
         XZlozklrYnTh5WOrhfwrfQXPulpVBr41uUXInMdehQ9llUi/fPq6Lvt4FQ21g+IHlb4a
         blU+mrQKbV2hNFsLIRSMQ21QhXIULcpiUE9xCEFTTBFZcxcVVbaYEkHgFNuaiFL4xuNx
         AEQqeFNbF4zFnFR1P2860h/GyEWzQzlfoEreH9WWN4R81Y5EECn7YDx4mFH5ojEJXOTm
         DHRg==
X-Gm-Message-State: AOAM530ZeV3iT+kmKQ5BecysQ+NnK9UVrEQllB5nojssafKk7YNFFDEu
        4uUQVjzGAXCaG/BvFNm27xkaRA==
X-Google-Smtp-Source: ABdhPJwcjHAfTtSUxS7urJ6wJNdAgpbJNYdhbRgdmKaXU+rhJtTE9zSDtELoP3aX0EHa2HVHeel0fQ==
X-Received: by 2002:a17:902:7481:b029:da:c15d:8646 with SMTP id h1-20020a1709027481b02900dac15d8646mr11221261pll.54.1607243210975;
        Sun, 06 Dec 2020 00:26:50 -0800 (PST)
Received: from localhost.localdomain ([103.136.221.70])
        by smtp.gmail.com with ESMTPSA id iq3sm6884104pjb.57.2020.12.06.00.26.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Dec 2020 00:26:50 -0800 (PST)
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
Subject: [PATCH v2 05/12] mm: memcontrol: convert NR_SHMEM_PMDMAPPED account to pages
Date:   Sun,  6 Dec 2020 16:23:07 +0800
Message-Id: <20201206082318.11532-11-songmuchun@bytedance.com>
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
index 3e1094717e40..e5abc6144dab 100644
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
index b4d8a6ee822d..84886b2cc2f7 100644
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
index b6a79196e870..d103513b3e4f 100644
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

