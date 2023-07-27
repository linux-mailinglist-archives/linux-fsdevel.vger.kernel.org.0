Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C3C765E37
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 23:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbjG0Vaf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 17:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbjG0VaY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 17:30:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44B81984
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 14:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690493338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3V6q8K76IOW6dvze9Iao5sragyvrE9hiergd1FJ9CnQ=;
        b=QfVpS+sZ0KzzSBMiSLaHnlmxftylQ5WGVGfCFcnoYLOi9rAijbCYFS0DbuS2l44Ui9IQug
        kdPZdDclchrqcwYJ0KAqweF2ke16ByReBJMIRBdWKsdVJezluBECLGnlgXkut0kMtWWOI1
        Lz9OMOrgMVBd4gO1FgP/YJs40HarXSg=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-16-1ckDkazHPumtGeeYi-ezOg-1; Thu, 27 Jul 2023 17:28:53 -0400
X-MC-Unique: 1ckDkazHPumtGeeYi-ezOg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2E0FA3810D42;
        Thu, 27 Jul 2023 21:28:53 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 41E6C40C2063;
        Thu, 27 Jul 2023 21:28:50 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        liubo <liubo254@huawei.com>, Peter Xu <peterx@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>, stable@vger.kernel.org
Subject: [PATCH v1 1/4] smaps: Fix the abnormal memory statistics obtained through /proc/pid/smaps
Date:   Thu, 27 Jul 2023 23:28:42 +0200
Message-ID: <20230727212845.135673-2-david@redhat.com>
In-Reply-To: <20230727212845.135673-1-david@redhat.com>
References: <20230727212845.135673-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: liubo <liubo254@huawei.com>

In commit 474098edac26 ("mm/gup: replace FOLL_NUMA by
gup_can_follow_protnone()"), FOLL_NUMA was removed and replaced by
the gup_can_follow_protnone interface.

However, for the case where the user-mode process uses transparent
huge pages, when analyzing the memory usage through
/proc/pid/smaps_rollup, the obtained memory usage is not consistent
with the RSS in /proc/pid/status.

Related examples are as follows:
cat /proc/15427/status
VmRSS:  20973024 kB
RssAnon:        20971616 kB
RssFile:            1408 kB
RssShmem:              0 kB

cat /proc/15427/smaps_rollup
00400000-7ffcc372d000 ---p 00000000 00:00 0 [rollup]
Rss:            14419432 kB
Pss:            14418079 kB
Pss_Dirty:      14418016 kB
Pss_Anon:       14418016 kB
Pss_File:             63 kB
Pss_Shmem:             0 kB
Anonymous:      14418016 kB
LazyFree:              0 kB
AnonHugePages:  14417920 kB

The root cause is that the traversal In the page table, the number of
pages obtained by smaps_pmd_entry does not include the pages
corresponding to PROTNONE,resulting in a different situation.

Therefore, when obtaining pages through the follow_trans_huge_pmd
interface, add the FOLL_FORCE flag to count the pages corresponding to
PROTNONE to solve the above problem.

Signed-off-by: liubo <liubo254@huawei.com>
Cc: stable@vger.kernel.org
Fixes: 474098edac26 ("mm/gup: replace FOLL_NUMA by gup_can_follow_protnone()")
Signed-off-by: David Hildenbrand <david@redhat.com> # AKPM fixups, cc stable
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/proc/task_mmu.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index c1e6531cb02a..7075ce11dc7d 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -571,8 +571,12 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
 	bool migration = false;
 
 	if (pmd_present(*pmd)) {
-		/* FOLL_DUMP will return -EFAULT on huge zero page */
-		page = follow_trans_huge_pmd(vma, addr, pmd, FOLL_DUMP);
+		/*
+		 * FOLL_DUMP will return -EFAULT on huge zero page
+		 * FOLL_FORCE follow a PROT_NONE mapped page
+		 */
+		page = follow_trans_huge_pmd(vma, addr, pmd,
+					     FOLL_DUMP | FOLL_FORCE);
 	} else if (unlikely(thp_migration_supported() && is_swap_pmd(*pmd))) {
 		swp_entry_t entry = pmd_to_swp_entry(*pmd);
 
-- 
2.41.0

