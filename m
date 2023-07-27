Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E8A765E3B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 23:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbjG0Vaj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 17:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbjG0Vac (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 17:30:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938B91BC3
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 14:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690493343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gg+vYFf2MUM715aNnpsI37yVDyYtQwBsTVNC7NmhATc=;
        b=e3VCchc75lZUUCtzE/TjD1I5f3oVWv8LqGr7uoUV3TZGqNRWjHEyEjJtLutoDP17IE/e75
        uQcGOTqm2yxEjuN1sc1T8trOlj9VtIyXcD23oM8mcB6bnWniU1OoCog6fwXNyPPHyzc5MS
        omPnY1zl2TMwU+vRcuuQSUacqyMWhwg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-359-RlyUAFoMPPO8N1iA8aE7qw-1; Thu, 27 Jul 2023 17:28:58 -0400
X-MC-Unique: RlyUAFoMPPO8N1iA8aE7qw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 924CC805951;
        Thu, 27 Jul 2023 21:28:57 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 91ABF40C2063;
        Thu, 27 Jul 2023 21:28:55 +0000 (UTC)
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
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v1 3/4] smaps: use vm_normal_page_pmd() instead of follow_trans_huge_pmd()
Date:   Thu, 27 Jul 2023 23:28:44 +0200
Message-ID: <20230727212845.135673-4-david@redhat.com>
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

We really shouldn't be using a GUP-internal helper if it can be avoided,
and avoiding the FOLL_FORCE here is certainly desirable.

Similar to smaps_pte_entry() that uses vm_normal_page(), let's use
vm_normal_page_pmd() -- that didn't exist back when we introduced that
code -- that similarly refuses to return the huge zeropage.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/proc/task_mmu.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 7075ce11dc7d..b8ea270bf68b 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -571,12 +571,7 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
 	bool migration = false;
 
 	if (pmd_present(*pmd)) {
-		/*
-		 * FOLL_DUMP will return -EFAULT on huge zero page
-		 * FOLL_FORCE follow a PROT_NONE mapped page
-		 */
-		page = follow_trans_huge_pmd(vma, addr, pmd,
-					     FOLL_DUMP | FOLL_FORCE);
+		page = vm_normal_page_pmd(vma, addr, *pmd);
 	} else if (unlikely(thp_migration_supported() && is_swap_pmd(*pmd))) {
 		swp_entry_t entry = pmd_to_swp_entry(*pmd);
 
-- 
2.41.0

