Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95B276EC98
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Aug 2023 16:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236694AbjHCOdy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Aug 2023 10:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236310AbjHCOdw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:33:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E952E19B9
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Aug 2023 07:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691073150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xlcu86mCEhwN5RlV1rQQu0rKBbZXpgB+gRX7zo+2ELE=;
        b=Kehr/pCMNKR86cFEzoxpFzHR/k9NH5dSll1fNfRt52WZtJUO6bYfvovKpedYIUYThsiyYv
        FRG9zNzDivs8Hj+3S44Uvmy3jtPLOqySmftJn3XRP0a1J9SAbMv79/S1AaLQiWYUPezroF
        pdxLQ70Ac2TTJjEJscGMkqXi0NCsg0U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-194-xKca5kjkPeqZ-tCl_i7x9A-1; Thu, 03 Aug 2023 10:32:26 -0400
X-MC-Unique: xKca5kjkPeqZ-tCl_i7x9A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0BE7B805AF6;
        Thu,  3 Aug 2023 14:32:26 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.193.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7401F201EE6E;
        Thu,  3 Aug 2023 14:32:23 +0000 (UTC)
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
Subject: [PATCH v3 4/7] mm/gup: don't implicitly set FOLL_HONOR_NUMA_FAULT
Date:   Thu,  3 Aug 2023 16:32:05 +0200
Message-ID: <20230803143208.383663-5-david@redhat.com>
In-Reply-To: <20230803143208.383663-1-david@redhat.com>
References: <20230803143208.383663-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 mm/gup.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 3bbfae411880..ee4fc15ce88e 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2244,13 +2244,6 @@ static bool is_valid_gup_args(struct page **pages, int *locked,
 		gup_flags |= FOLL_UNLOCKABLE;
 	}
 
-	/*
-	 * For now, always trigger NUMA hinting faults. Some GUP users like
-	 * KVM require the hint to be as the calling context of GUP is
-	 * functionally similar to a memory reference from task context.
-	 */
-	gup_flags |= FOLL_HONOR_NUMA_FAULT;
-
 	/* FOLL_GET and FOLL_PIN are mutually exclusive. */
 	if (WARN_ON_ONCE((gup_flags & (FOLL_PIN | FOLL_GET)) ==
 			 (FOLL_PIN | FOLL_GET)))
-- 
2.41.0

