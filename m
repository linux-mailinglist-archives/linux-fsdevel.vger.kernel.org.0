Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1037A2D220C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 05:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbgLHEWe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 23:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbgLHEWd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 23:22:33 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C36DC0611CF
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Dec 2020 20:21:28 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id o4so11044834pgj.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Dec 2020 20:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5QtzUPSaCCxeqzmaLwiZLdmUDR0T79YdbdBWjz3bjU0=;
        b=mc4LQi+8Dvw0LMhxU20Dluvm2ZSyZowOBRFKbsg4+E2QKQkG+5WEUvL3sq7+H+KsIG
         /2PbPyQsG1YW1ToGRNXGF9EmUdWNsHJTkjDCNcOvPqwNrTOViEnPA2kmUGOPQ9xIR8bm
         YGC4aheG0ammcsnwywGtpfGNKK9Zd3GigZ61K7sz44/qSRPuehM2Qqwo12E4wpkhvrH9
         aAnnFsNssqM9nCLjet0TxIL/KzaOE4fRuZwnTtNc5sEgPGlBOlMLBSSz0y72K1ctDj6D
         S51rJ0KDs5C1EOhBpJH1OXIpV3SRLdo7Raf1opYzy5xE0kanXE5ccDXXUhjDIkAzh3T0
         X7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5QtzUPSaCCxeqzmaLwiZLdmUDR0T79YdbdBWjz3bjU0=;
        b=Y2b/aIHf70m2cpyC5FpjcPsjOslTHPUwfEO1XnxKgnyOGlGXNIp7eJ/iYKKRJcXTYX
         g4xYgffRrqYJMPX1NmBfbDyK887bskvw0hhPslGyZSsjM6yBMHjpEcpKGNfvC5Vtb54L
         zWTYL6x6UJ/cN7/ocevfhkYIc92qUd0cYXWMJDPWhKCXTD9NWq2nLldD8aIUD1/Qt1lE
         zuR/SoGFonHADmDfm/gFUZpYT47vapmWDscLi8FmMH99EeeFhDqjB6A8bXMyPoALN1Kv
         STwY2phBmtF0u+9AEoVMkFbCJuSyw7d+lDcKrtb+HKPwmMaKkeT7ldy6QcEuDcHoYg/8
         YWeA==
X-Gm-Message-State: AOAM5312maztlXdSr5ZJ1KD1vzJTw++AtXsYo1rJGhaRTUSjlJeG5vjt
        5zZ+DvUW3F+IQ0lHm7bjI2c/pA==
X-Google-Smtp-Source: ABdhPJwgTvXrSNNUdeX86od1g83iYDUqnnM9L9ZoCFjA9qyAxMxXscN568YbBrQgdQtIM9Jk5wEabQ==
X-Received: by 2002:a62:5c87:0:b029:197:5f13:b66c with SMTP id q129-20020a625c870000b02901975f13b66cmr19288373pfb.73.1607401288139;
        Mon, 07 Dec 2020 20:21:28 -0800 (PST)
Received: from localhost.localdomain ([103.136.221.70])
        by smtp.gmail.com with ESMTPSA id mr7sm1031166pjb.31.2020.12.07.20.21.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2020 20:21:27 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, adobriyan@gmail.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, hughd@google.com, shakeelb@google.com,
        guro@fb.com, samitolvanen@google.com, feng.tang@intel.com,
        neilb@suse.de, iamjoonsoo.kim@lge.com, rdunlap@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 5/7] mm: memcontrol: convert NR_SHMEM_PMDMAPPED account to pages
Date:   Tue,  8 Dec 2020 12:18:45 +0800
Message-Id: <20201208041847.72122-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201208041847.72122-1-songmuchun@bytedance.com>
References: <20201208041847.72122-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The unit of NR_SHMEM_PMDMAPPED is HPAGE_PMD_NR. Convert NR_SHMEM_PMDMAPPED
account to pages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 drivers/base/node.c | 3 +--
 fs/proc/meminfo.c   | 2 +-
 mm/page_alloc.c     | 3 +--
 mm/rmap.c           | 6 ++++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index a7f298ae693a..45293084bb19 100644
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
index cfb107eaa3e6..c61f440570f9 100644
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
index 720fb5a220b6..575fbfeea4b5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5578,8 +5578,7 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
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

