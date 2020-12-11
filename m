Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 087592D6F31
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Dec 2020 05:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404951AbgLKEYw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Dec 2020 23:24:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395384AbgLKEYm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Dec 2020 23:24:42 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409C7C0613CF
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Dec 2020 20:23:47 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id d2so6211919pfq.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Dec 2020 20:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c1LVwFTVmqjgTFBygiYf9KRS/M2MDULFm8W3CcAScWk=;
        b=sHMPxQiX9HU37cGIlQKYuTVGVR1QPCEbEEnvCmq1qHG5L+syE+EtC++5V++Y8LmEN8
         gOrCGT9Ye2l+SD2JnOdPsE0b/2uvmNdTkhYjo26CkdGNqNr9/K0qF49nz7ftVV51cipT
         UsR8aYpkXMvucEHBXXhdrQMlTS8B+g4KXiPyiBUOu5DFjtoy7vnp++5+5xRaG8+FnYe1
         8RRDwH6oPVoJbEst3xbvp3AtHixH6JqaIKrZvrkEduKy0YScajgC30DFxvNqqk/Yzz60
         IMWwPzI7dR4ebv/zrcaAyU5VMrVt38yjZW51GIFUjhN7kTvBEiDufL0YmDJs4UOyTn3s
         nVrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c1LVwFTVmqjgTFBygiYf9KRS/M2MDULFm8W3CcAScWk=;
        b=cD6jYKyw0Zzt0nZcamq4/vNyR6J63O4iyRBH/w5yoY1VtZWplh33feFISIoeNriHEs
         pSK7YP5N1TE6PxBGbFoIM3tNeoVkFRGohbeGfJfrRB3vZSf3EQx2n3jVtL1NmGyyuQZQ
         Cb2jYZuYwrMYHoq8FY7m6jO/9R1wIw/O3hOOXy71nPEVk9A6qKROGXlaVE4o/8vVnosm
         YThSVhejodRTVUIcHnpB/5Qrl0cEF5HmrjKJ2eUlM05P7vF1dIBOkrGMIFMGdZBkhocc
         NKJn3NcgejjkRhq2IfJpUgLUchB8tBuh/3T2EpuN0NRLehVzJhYiO5kNNNxhw25FAchp
         rCcA==
X-Gm-Message-State: AOAM532PN0/Wz2chlHF2U4mOk2CdWIU9C+qXETPPo2+XS8JdS5JiVZjp
        xk3L+ANrpjVnk6+tKxINiyj6Lg==
X-Google-Smtp-Source: ABdhPJzvI52xrdQRDVgHYSZXJEjSxmWy+Pk9gYCoF+D8vHIorOD99kxCXFDzu/WJ7Akt1GmsLOn10Q==
X-Received: by 2002:a63:4950:: with SMTP id y16mr9800008pgk.415.1607660626886;
        Thu, 10 Dec 2020 20:23:46 -0800 (PST)
Received: from localhost.localdomain ([103.136.221.66])
        by smtp.gmail.com with ESMTPSA id 19sm8623352pfu.85.2020.12.10.20.23.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Dec 2020 20:23:46 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, adobriyan@gmail.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, hughd@google.com, shakeelb@google.com,
        guro@fb.com, samitolvanen@google.com, feng.tang@intel.com,
        neilb@suse.de, iamjoonsoo.kim@lge.com, rdunlap@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 6/7] mm: memcontrol: convert NR_FILE_PMDMAPPED account to pages
Date:   Fri, 11 Dec 2020 12:19:53 +0800
Message-Id: <20201211041954.79543-7-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201211041954.79543-1-songmuchun@bytedance.com>
References: <20201211041954.79543-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The unit of NR_FILE_PMDMAPPED is HPAGE_PMD_NR. Convert NR_FILE_PMDMAPPED
account to pages.

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
index d6b13b9327be..c587343a3884 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -218,7 +218,8 @@ static __always_inline bool vmstat_item_print_in_thp(enum node_stat_item item)
 	return item == NR_ANON_THPS ||
 	       item == NR_FILE_THPS ||
 	       item == NR_SHMEM_THPS ||
-	       item == NR_SHMEM_PMDMAPPED;
+	       item == NR_SHMEM_PMDMAPPED ||
+	       item == NR_FILE_PMDMAPPED;
 }
 
 /*
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

