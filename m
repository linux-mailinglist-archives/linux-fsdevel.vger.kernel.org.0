Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDCF276B51D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 14:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233974AbjHAMu1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 08:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232622AbjHAMuK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 08:50:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6422128
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Aug 2023 05:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690894152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k5L4YtRFm7cOLJR+l6dUREkXQfCqKIU8byjm44bC064=;
        b=HzYzQgmO9DXT+hka+umx2SxydFRiCaOq0GqTOjB31OoLqpt3mrnI4WxSi/kiVKQbm4ynhh
        Fa38IK6DUyo6SdpDEKZGPxNMnklhOag616EoVIMZanQVz19CGNZ02naXm1nfPbEQMC4Ofl
        s9Zg4f6LVV/5IDCJMHIJC+L8NnM3gTc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-275-nQOIVHn-OOObXZamCc7BOQ-1; Tue, 01 Aug 2023 08:49:08 -0400
X-MC-Unique: nQOIVHn-OOObXZamCc7BOQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B20E68007CE;
        Tue,  1 Aug 2023 12:49:07 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.193.232])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 266B5C585A0;
        Tue,  1 Aug 2023 12:48:57 +0000 (UTC)
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
Subject: [PATCH v2 3/8] kvm: explicitly set FOLL_HONOR_NUMA_FAULT in hva_to_pfn_slow()
Date:   Tue,  1 Aug 2023 14:48:39 +0200
Message-ID: <20230801124844.278698-4-david@redhat.com>
In-Reply-To: <20230801124844.278698-1-david@redhat.com>
References: <20230801124844.278698-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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

KVM is *the* case we know that really wants to honor NUMA hinting falls.
As we want to stop setting FOLL_HONOR_NUMA_FAULT implicitly, set
FOLL_HONOR_NUMA_FAULT whenever we might obtain pages on behalf of a VCPU
to map them into a secondary MMU, and add a comment why.

Do that unconditionally in hva_to_pfn_slow() when calling
get_user_pages_unlocked().

kvmppc_book3s_instantiate_page(), hva_to_pfn_fast() and
gfn_to_page_many_atomic() are similarly used to map pages into a
secondary MMU. However, FOLL_WRITE and get_user_page_fast_only() always
implicitly honor NUMA hinting faults -- as documented for
FOLL_HONOR_NUMA_FAULT -- so we can limit this change to a single location
for now.

Don't set it in check_user_page_hwpoison(), where we really only want to
check if the mapped page is HW-poisoned.

We won't set it for other KVM users of get_user_pages()/pin_user_pages()
* arch/powerpc/kvm/book3s_64_mmu_hv.c: not used to map pages into a
  secondary MMU.
* arch/powerpc/kvm/e500_mmu.c: only used on shared TLB pages with userspace
* arch/s390/kvm/*: s390x only supports a single NUMA node either way
* arch/x86/kvm/svm/sev.c: not used to map pages into a secondary MMU.

This is a preparation for making FOLL_HONOR_NUMA_FAULT no longer
implicitly be set by get_user_pages() and friends.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 virt/kvm/kvm_main.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index dfbaafbe3a00..6e4f2b81541e 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2517,7 +2517,18 @@ static bool hva_to_pfn_fast(unsigned long addr, bool write_fault,
 static int hva_to_pfn_slow(unsigned long addr, bool *async, bool write_fault,
 			   bool interruptible, bool *writable, kvm_pfn_t *pfn)
 {
-	unsigned int flags = FOLL_HWPOISON;
+	/*
+	 * When a VCPU accesses a page that is not mapped into the secondary
+	 * MMU, we lookup the page using GUP to map it, so the guest VCPU can
+	 * make progress. We always want to honor NUMA hinting faults in that
+	 * case, because GUP usage corresponds to memory accesses from the VCPU.
+	 * Otherwise, we'd not trigger NUMA hinting faults once a page is
+	 * mapped into the secondary MMU and gets accessed by a VCPU.
+	 *
+	 * Note that get_user_page_fast_only() and FOLL_WRITE for now
+	 * implicitly honor NUMA hinting faults and don't need this flag.
+	 */
+	unsigned int flags = FOLL_HWPOISON | FOLL_HONOR_NUMA_FAULT;
 	struct page *page;
 	int npages;
 
-- 
2.41.0

