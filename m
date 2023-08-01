Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10EC476B50B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 14:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbjHAMtj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 08:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbjHAMti (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 08:49:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BAC10EA
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Aug 2023 05:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690894131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=RHFvfXcP0yrcIaYOdQEvaIRqqVbMZney2Vh1PcaD7Io=;
        b=fn75Dx0qzhAvlJAtUU7QOhNQHvqDlZYocg+SJbwePjD18/V5xDkBNE9WvCTtgAujR2VI3E
        4e3cNH9vPmW/GsnEfs2jDycsIjNOVH306aR8aW4k/J1ZzYm5WUK2SBpGrUkzgjoWiMNf4L
        8KnDzXnuN9qaSFyNsDQmhu5P/02zqfo=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-46-92PRgIToNqSHCN5sbvkKmg-1; Tue, 01 Aug 2023 08:48:50 -0400
X-MC-Unique: 92PRgIToNqSHCN5sbvkKmg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8876C3C14AA4;
        Tue,  1 Aug 2023 12:48:49 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.193.232])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B7B1EC585A0;
        Tue,  1 Aug 2023 12:48:45 +0000 (UTC)
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
Subject: [PATCH v2 0/8] smaps / mm/gup: fix gup_can_follow_protnone fallout
Date:   Tue,  1 Aug 2023 14:48:36 +0200
Message-ID: <20230801124844.278698-1-david@redhat.com>
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

This is agains mm/mm-unstable, but everything except patch #7 and #8
should apply on current master. Especially patch #1 and #2 should go
upstream first, so we can let the other stuff mature a bit longer.


Next attempt to handle the fallout of 474098edac26
("mm/gup: replace FOLL_NUMA by gup_can_follow_protnone()") where I
accidentially missed that follow_page() and smaps implicitly kept the
FOLL_NUMA flag clear by not setting it if FOLL_FORCE is absent, to
not trigger faults on PROT_NONE-mapped PTEs.

Patch #1 fixes the known issues by reintroducing FOLL_NUMA as
FOLL_HONOR_NUMA_FAULT and decoupling it from FOLL_FORCE.

Patch #2 is a cleanup that I think actually fixes some corner cases, so
I added a Fixes: tag.

Patch #3 makes KVM explicitly set FOLL_HONOR_NUMA_FAULT in the single
case where it is required, and documents the situation.

Patch #4 then stops implicitly setting FOLL_HONOR_NUMA_FAULT. But note that
for FOLL_WRITE we always implicitly honor NUMA hinting faults.

Patch #5 and patch #6 cleanup some comments.

Patch #7 improves the KVM functional tests such that patch #8 can
actually check for one of the known issues: KSM no longer working on
PROT_NONE mappings on x86-64 with CONFIG_NUMA_BALANCING.

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

David Hildenbrand (8):
  mm/gup: reintroduce FOLL_NUMA as FOLL_HONOR_NUMA_FAULT
  smaps: use vm_normal_page_pmd() instead of follow_trans_huge_pmd()
  kvm: explicitly set FOLL_HONOR_NUMA_FAULT in hva_to_pfn_slow()
  mm/gup: don't implicitly set FOLL_HONOR_NUMA_FAULT
  pgtable: improve pte_protnone() comment
  mm/huge_memory: remove stale NUMA hinting comment from
    follow_trans_huge_pmd()
  selftest/mm: ksm_functional_tests: test in mmap_and_merge_range() if
    anything got merged
  selftest/mm: ksm_functional_tests: Add PROT_NONE test

 fs/proc/task_mmu.c                            |   3 +-
 include/linux/mm.h                            |  21 +++-
 include/linux/mm_types.h                      |   9 ++
 include/linux/pgtable.h                       |  16 ++-
 mm/gup.c                                      |  23 +++-
 mm/huge_memory.c                              |   3 +-
 .../selftests/mm/ksm_functional_tests.c       | 106 ++++++++++++++++--
 virt/kvm/kvm_main.c                           |  13 ++-
 8 files changed, 164 insertions(+), 30 deletions(-)

-- 
2.41.0

