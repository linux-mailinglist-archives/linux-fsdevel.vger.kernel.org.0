Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA42F2D029B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Dec 2020 11:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbgLFKSf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Dec 2020 05:18:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbgLFKSf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Dec 2020 05:18:35 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46364C0613D4
        for <linux-fsdevel@vger.kernel.org>; Sun,  6 Dec 2020 02:17:43 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id t37so6452344pga.7
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Dec 2020 02:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=47URTm8Dh9aVQTOnIPzCjSnQ3r0uw/hpFPQHZdAjXJk=;
        b=ZFrm0RAsDKjEspMJB3v1V7ooekc7E7o5kl6qta47nxPfgFfA0L3kv9YJmSyWr+/B31
         JHbHQopIMAu9OZDsv9OzAyQyEvdtpOUYOU4uChMVGIF7Rha4Kuyjtf6rvPmWRFq5r0Hb
         YpLTSeIofdez0J4pdps2gKdUCVEdB8v5HEpGQlyPdg9S6BnGVAvnNjCt9SvzcI6vyvP0
         AnBBUWKm3mxAbbRDBv+EBHvtTprB++jbhIeX1HnMXf4B51kCpzqpciDO6VLGjCSqEfqj
         l7aae0EI4r2sW1m8S0lkLyNyXIeCmU8aRNz4NeRgVcg0KuTQ+ZB92ejjuYcxaPQNk/6O
         FZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=47URTm8Dh9aVQTOnIPzCjSnQ3r0uw/hpFPQHZdAjXJk=;
        b=E6ncL6rekR6sUjnHvNaVPeUeKZ8FBsGzQPRsSwcXfrqJu744bqznvLnz00NpDmssVr
         gTxLbhvOe3PHv1URorLNkV1okRL1gWeJrDY/tvMO/h/zftobgH3yOADE7imxLgx546aN
         lEjI2hj9LfWnmAfYosDXGpTtojE8EIF1CepDY/+rEknc6/yQ7uZjkxVCdWhEa03wIuzD
         g3klDGZx/TvCK766+/0dOLUkqfSCqDbl53zQ7DQ2JXCOSrxTayAEY2Nz5Sg1bkOl/qWS
         QSws3j0oQ9SP6ItsZVViDgp5dnAhGPO+VStnvcmYqOVZoHqsvlYHgKosdNAeCRiReG/A
         iAcQ==
X-Gm-Message-State: AOAM533/WlQUDuf5P0Vb+r1dLFmAOD0Zf6kQpjam8OL3m50/X1LY40PG
        AH7ohVwzMqaapRWBMfU4cHCh0A==
X-Google-Smtp-Source: ABdhPJyRYGohzoTg4dhzau/id+aOZcLwu77zYAllJcJ4h4jgoseBbrsSpJiXHpTE4u8OWvmslmKRBw==
X-Received: by 2002:a62:6346:0:b029:198:3d33:feb with SMTP id x67-20020a6263460000b02901983d330febmr11740529pfb.8.1607249862830;
        Sun, 06 Dec 2020 02:17:42 -0800 (PST)
Received: from localhost.localdomain ([103.136.221.70])
        by smtp.gmail.com with ESMTPSA id g16sm10337657pfb.201.2020.12.06.02.17.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Dec 2020 02:17:42 -0800 (PST)
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
Subject: [RESEND PATCH v2 06/12] mm: memcontrol: convert NR_FILE_PMDMAPPED account to pages
Date:   Sun,  6 Dec 2020 18:14:45 +0800
Message-Id: <20201206101451.14706-7-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201206101451.14706-1-songmuchun@bytedance.com>
References: <20201206101451.14706-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert NR_FILE_PMDMAPPED account to pages

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 drivers/base/node.c | 3 +--
 fs/proc/meminfo.c   | 2 +-
 mm/rmap.c           | 6 ++++--
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index e5abc6144dab..f77652e6339f 100644
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
index 84886b2cc2f7..5a83012d8b72 100644
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
diff --git a/mm/rmap.c b/mm/rmap.c
index 3089ad6bf468..e383c5619501 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1222,7 +1222,8 @@ void page_add_file_rmap(struct page *page, bool compound)
 			__mod_lruvec_page_state(page, NR_SHMEM_PMDMAPPED,
 						HPAGE_PMD_NR);
 		else
-			__inc_node_page_state(page, NR_FILE_PMDMAPPED);
+			__mod_lruvec_page_state(page, NR_FILE_PMDMAPPED,
+						HPAGE_PMD_NR);
 	} else {
 		if (PageTransCompound(page) && page_mapping(page)) {
 			VM_WARN_ON_ONCE(!PageLocked(page));
@@ -1264,7 +1265,8 @@ static void page_remove_file_rmap(struct page *page, bool compound)
 			__mod_lruvec_page_state(page, NR_SHMEM_PMDMAPPED,
 						-HPAGE_PMD_NR);
 		else
-			__dec_node_page_state(page, NR_FILE_PMDMAPPED);
+			__mod_lruvec_page_state(page, NR_FILE_PMDMAPPED,
+						-HPAGE_PMD_NR);
 	} else {
 		if (!atomic_add_negative(-1, &page->_mapcount))
 			return;
-- 
2.11.0

