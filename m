Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9522765E30
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 23:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjG0V3m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 17:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjG0V3l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 17:29:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F00113
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 14:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690493334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MHtDEcJmjYkfEI+Ix28zkYwSjHjzxbeRw7Afa8s+sDk=;
        b=V1sPIIzftjOYK8qE/VqLnjqIpKJnj11YlUdStCrSUt7UBjpMY9UhO6zdOiX6r+yBS8nj9E
        dBjU2JvKSH7djaxsYA9xlpFWSHIQtR58gNC4cUr+E0egLqvgsZ6MukU4vHwQTaaArRQ5yN
        HE/x+SK4Atayv19HiJiF9StfvYrjJPc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-477-SSSPx73SMmCaNq4xHLAjEw-1; Thu, 27 Jul 2023 17:28:50 -0400
X-MC-Unique: SSSPx73SMmCaNq4xHLAjEw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D69AE101A54E;
        Thu, 27 Jul 2023 21:28:49 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C073D40C2063;
        Thu, 27 Jul 2023 21:28:46 +0000 (UTC)
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
Subject: [PATCH v1 0/4]  smaps / mm/gup: fix gup_can_follow_protnone fallout
Date:   Thu, 27 Jul 2023 23:28:41 +0200
Message-ID: <20230727212845.135673-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is my proposal on how to handle the fallout of 474098edac26
("mm/gup: replace FOLL_NUMA by gup_can_follow_protnone()") where I
accidentially missed that follow_page() and smaps implicitly kept the
FOLL_NUMA flag clear by *not* setting it if FOLL_FORCE is absent, to
not trigger faults on PROT_NONE-mapped PTEs.

(maybe it's just me who considers that confusing)

Patch #1 is the original fix proposal, which patch #3 cleans up. Patch #2
is another fix for the issue on the follow_page() level pointed out by
Peter. Patch #4 documents the FOLL_FORCE situation.

Peter prefers a revert of that commit [1], I disagree and am still happy to
see FOLL_NUMA gone that implicitly relied on FOLL_FORCE.

An alternative might be to use an internal FOLL_PROTNONE or
FOLL_NO_PROTNONE flag in patch #3, not so sure about that.

Did a quick sanity test, will do more testing tomorrow.

[1] https://lkml.kernel.org/r/ZMK+jSDgOmJKySTr@x1n

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: liubo <liubo254@huawei.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: John Hubbard <jhubbard@nvidia.com>

David Hildenbrand (3):
  mm/gup: Make follow_page() succeed again on PROT_NONE PTEs/PMDs
  smaps: use vm_normal_page_pmd() instead of follow_trans_huge_pmd()
  mm/gup: document FOLL_FORCE behavior

liubo (1):
  smaps: Fix the abnormal memory statistics obtained through
    /proc/pid/smaps

 fs/proc/task_mmu.c       |  3 +--
 include/linux/mm_types.h | 25 ++++++++++++++++++++++++-
 mm/gup.c                 | 10 +++++++++-
 3 files changed, 34 insertions(+), 4 deletions(-)

-- 
2.41.0

