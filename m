Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6638876ECAC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Aug 2023 16:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236548AbjHCOes (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Aug 2023 10:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236764AbjHCOed (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:34:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21631BFD
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Aug 2023 07:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691073153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ymf0b+2Kqr9mLIxdkVxybggSGs/fK9hNLVEJOY2Qbdo=;
        b=cVhpsIC01lenR7bEXrnq71EA5UZECwkQkjTO2L+f+8w3QrZe7lUH9g7v8/DxPMZdeALztF
        Lh7FEKTu3HIfdN6hMoUrQU6W1TCze7dhRXIkFdWbeGeBDeX3Ch8UuLcYWtaemgLK5aaN7O
        Yg8plLaQrzuSmEcPQm2OKCByCjIEKnI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-423-0ded6q7sOS-M6lJ3orix1Q-1; Thu, 03 Aug 2023 10:32:30 -0400
X-MC-Unique: 0ded6q7sOS-M6lJ3orix1Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3FD4C857FD1;
        Thu,  3 Aug 2023 14:32:29 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.193.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4653F201F11C;
        Thu,  3 Aug 2023 14:32:26 +0000 (UTC)
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
        Paolo Bonzini <pbonzini@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH v3 5/7] pgtable: improve pte_protnone() comment
Date:   Thu,  3 Aug 2023 16:32:06 +0200
Message-ID: <20230803143208.383663-6-david@redhat.com>
In-Reply-To: <20230803143208.383663-1-david@redhat.com>
References: <20230803143208.383663-1-david@redhat.com>
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

Especially the "For PROT_NONE VMAs, the PTEs are not marked
_PAGE_PROTNONE" part is wrong: doing an mprotect(PROT_NONE) will end up
marking all PTEs on x86_64 as _PAGE_PROTNONE, making pte_protnone()
indicate "yes".

So let's improve the comment, so it's easier to grasp which semantics
pte_protnone() actually has.

Acked-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/pgtable.h | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 6005b5dff0c1..222a33b9600d 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1446,12 +1446,16 @@ static inline int pud_trans_unstable(pud_t *pud)
 
 #ifndef CONFIG_NUMA_BALANCING
 /*
- * Technically a PTE can be PROTNONE even when not doing NUMA balancing but
- * the only case the kernel cares is for NUMA balancing and is only ever set
- * when the VMA is accessible. For PROT_NONE VMAs, the PTEs are not marked
- * _PAGE_PROTNONE so by default, implement the helper as "always no". It
- * is the responsibility of the caller to distinguish between PROT_NONE
- * protections and NUMA hinting fault protections.
+ * In an inaccessible (PROT_NONE) VMA, pte_protnone() may indicate "yes". It is
+ * perfectly valid to indicate "no" in that case, which is why our default
+ * implementation defaults to "always no".
+ *
+ * In an accessible VMA, however, pte_protnone() reliably indicates PROT_NONE
+ * page protection due to NUMA hinting. NUMA hinting faults only apply in
+ * accessible VMAs.
+ *
+ * So, to reliably identify PROT_NONE PTEs that require a NUMA hinting fault,
+ * looking at the VMA accessibility is sufficient.
  */
 static inline int pte_protnone(pte_t pte)
 {
-- 
2.41.0

