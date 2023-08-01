Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E0776B51A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 14:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbjHAMuZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 08:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232866AbjHAMuI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 08:50:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4251212A
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Aug 2023 05:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690894153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZVj1eNQXOQKDlAdeuW3yrTqXO0l5971B6VcwmwMnAdw=;
        b=BuJQaQGO2cWfTFITPmDKW6Q/4T5B++Ns0F0ET0yGeLqccCsqUNA0EFDVpeAtAnOABAghQg
        wf4UIkz0aBtPYQWti9gemq7RZ7KgJbMBVafdLILNGa1UCkKbn3N3CzTVIRrJB2bBRs3Oxc
        fC1fedNZ8HyZTa9qqKyLN+EXcUOGStQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-674-yaGk4Z3HMGqR7gEOj687BA-1; Tue, 01 Aug 2023 08:49:12 -0400
X-MC-Unique: yaGk4Z3HMGqR7gEOj687BA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8CE761044596;
        Tue,  1 Aug 2023 12:49:11 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.193.232])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 12865C585A0;
        Tue,  1 Aug 2023 12:49:07 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        liubo <liubo254@huawei.com>, Peter Xu <peterx@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Mel Gorman <mgorman@suse.de>, Shuah Khan <shuah@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 4/8] mm/gup: don't implicitly set FOLL_HONOR_NUMA_FAULT
Date:   Tue,  1 Aug 2023 14:48:40 +0200
Message-ID: <20230801124844.278698-5-david@redhat.com>
In-Reply-To: <20230801124844.278698-1-david@redhat.com>
References: <20230801124844.278698-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Commit 0b9d705297b2 ("mm: numa: Support NUMA hinting page faults from
gup/gup_fast") from 2012 documented as the primary reason why we would want
to handle NUMA hinting faults from GUP:

  KVM secondary MMU page faults will trigger the NUMA hinting page
  faults through gup_fast -> get_user_pages -> follow_page ->
  handle_mm_fault.

That is still the case today, and relevant KVM code has been converted to
manually set FOLL_HONOR_NUMA_FAULT. So let's stop setting
FOLL_HONOR_NUMA_FAULT for all GUP users and cross fingers that not that
many other ones that really require such handling for autonuma remain.

Possible interaction with MMU notifiers:

 Assume a driver obtains a page using get_user_pages() to map it into
 a secondary MMU, and uses the MMU notifier framework to get notified on
 changes.

 Assume get_user_pages() succeeded on a PROT_NONE-mapped page (because
 FOLL_HONOR_NUMA_FAULT is not set) in an accessible VMA and the page is
 mapped into a secondary MMU. Once user space would turn that mapping
 inaccessible using mprotect(PROT_NONE), the actual PTE in the page table
 might not change. If the MMU notifier would be smart and optimize for that
 case "why notify if the PTE didn't change", that could be problematic.

 At least change_pmd_range() with MMU_NOTIFY_PROTECTION_VMA for now does an
 unconditional mmu_notifier_invalidate_range_start() ->
 mmu_notifier_invalidate_range_end() and should be fine.

 Note that even if a PTE in an accessible VMA is pte_protnone(), the
 underlying page might be accessed by a secondary MMU that does not set
 FOLL_HONOR_NUMA_FAULT, and test_young() MMU notifiers would return "true".

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/gup.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index f463d3004ddc..ee4fc15ce88e 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2244,12 +2244,6 @@ static bool is_valid_gup_args(struct page **pages, int *locked,
 		gup_flags |= FOLL_UNLOCKABLE;
 	}
 
-	/*
-	 * For now, always trigger NUMA hinting faults. Some GUP users like
-	 * KVM really require it to benefit from autonuma.
-	 */
-	gup_flags |= FOLL_HONOR_NUMA_FAULT;
-
 	/* FOLL_GET and FOLL_PIN are mutually exclusive. */
 	if (WARN_ON_ONCE((gup_flags & (FOLL_PIN | FOLL_GET)) ==
 			 (FOLL_PIN | FOLL_GET)))
-- 
2.41.0

