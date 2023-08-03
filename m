Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621DD76EC8F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Aug 2023 16:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236246AbjHCOdI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Aug 2023 10:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236007AbjHCOdG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:33:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48801981
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Aug 2023 07:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691073139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=5fvDz/G2oKfYF1lRg/Bv4LyzGTOydxYCnQFLIhcefpU=;
        b=S6EOtQ1rkYdFx/rCNxWApMwoUnlWtwoXspRmtd+lIljolvoVxMV6cwLdFyNVpRyLTnCqx0
        6dE+t77sa/iSOMFWi35h0QYsM+hmDLeaGBBGYn3N72ehsg6dQ30vcMIG54/XxzznAxCvfw
        O/VthJZfpO2olx1YMy61EmrQ0kvrkOw=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-223-I45NiEcYM16tOhTdMPGmWQ-1; Thu, 03 Aug 2023 10:32:13 -0400
X-MC-Unique: I45NiEcYM16tOhTdMPGmWQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0F8FB3C025BA;
        Thu,  3 Aug 2023 14:32:13 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.193.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A6067200B66C;
        Thu,  3 Aug 2023 14:32:09 +0000 (UTC)
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
Subject: [PATCH v3 0/7] smaps / mm/gup: fix gup_can_follow_protnone fallout
Date:   Thu,  3 Aug 2023 16:32:01 +0200
Message-ID: <20230803143208.383663-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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

This is agains mm/mm-unstable, but everything except patch #6 and #7
should apply on current master. Especially patch #1 and #2 should go
upstream first, so we can let the other stuff mature a bit longer.


Handle the fallout of 474098edac26 ("mm/gup: replace FOLL_NUMA by
gup_can_follow_protnone()") where I accidentially missed that
follow_page() and smaps implicitly kept the FOLL_NUMA flag clear by not
setting it if FOLL_FORCE is absent, to not trigger faults on
PROT_NONE-mapped PTEs.

Patch #1 fixes the known issues by reintroducing FOLL_NUMA as
FOLL_HONOR_NUMA_FAULT and decoupling it from FOLL_FORCE.

Patch #2 is a cleanup that I think actually fixes some corner cases, so
I added a Fixes: tag.

Patch #3 makes KVM explicitly set FOLL_HONOR_NUMA_FAULT in the single
case where it is required, and documents the situation.

Patch #4 then stops implicitly setting FOLL_HONOR_NUMA_FAULT. But note that
for FOLL_WRITE we always implicitly honor NUMA hinting faults.

Patch #5 cleans up a comments.

Patch #6 improves the KVM functional tests such that patch #7 can
actually check for one of the known issues: KSM no longer working on
PROT_NONE mappings on x86-64 with CONFIG_NUMA_BALANCING.

v2 -> V3:
* "mm/gup: reintroduce FOLL_NUMA as FOLL_HONOR_NUMA_FAULT"
 -> Squash one comment removal
 -> Adjust the KSM comment
* smaps: use vm_normal_page_pmd() instead of follow_trans_huge_pmd()
 -> Move follow_trans_huge_pmd() to mm/internal.h

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: liubo <liubo254@huawei.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>

David Hildenbrand (7):
  mm/gup: reintroduce FOLL_NUMA as FOLL_HONOR_NUMA_FAULT
  smaps: use vm_normal_page_pmd() instead of follow_trans_huge_pmd()
  kvm: explicitly set FOLL_HONOR_NUMA_FAULT in hva_to_pfn_slow()
  mm/gup: don't implicitly set FOLL_HONOR_NUMA_FAULT
  pgtable: improve pte_protnone() comment
  selftest/mm: ksm_functional_tests: test in mmap_and_merge_range() if
    anything got merged
  selftest/mm: ksm_functional_tests: Add PROT_NONE test

 fs/proc/task_mmu.c                            |   3 +-
 include/linux/huge_mm.h                       |   3 -
 include/linux/mm.h                            |  21 +++-
 include/linux/mm_types.h                      |   9 ++
 include/linux/pgtable.h                       |  16 ++-
 mm/gup.c                                      |  23 +++-
 mm/huge_memory.c                              |   3 +-
 mm/internal.h                                 |   7 ++
 .../selftests/mm/ksm_functional_tests.c       | 106 ++++++++++++++++--
 virt/kvm/kvm_main.c                           |  13 ++-
 10 files changed, 171 insertions(+), 33 deletions(-)

-- 
2.41.0

