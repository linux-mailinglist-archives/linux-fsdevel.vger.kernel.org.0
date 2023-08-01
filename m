Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADAFC76B52A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 14:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbjHAMus (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 08:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbjHAMuS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 08:50:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C562107
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Aug 2023 05:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690894166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ETNtty+qD9MfEou6PkXGN63LTSt4s/cNeotNKd9s/vU=;
        b=UK93yNpxDbIxT3k7ddN7S7AnJ137QUogB4SeCupNzkElArGbQXVE9A/yC2087UkSt1RUIm
        vBvIb1bAhmD6KkYAxOe5F8dgBVH2JHHf4n+GDXEZ+2iTqfeZo0bA0ZzxSK2+tKTiNapuNN
        3cLJxjTvV6GAomi9U+MOsyhMW9ziZHQ=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-613-KCGrX7soNoWrUz7xASwZ2A-1; Tue, 01 Aug 2023 08:49:20 -0400
X-MC-Unique: KCGrX7soNoWrUz7xASwZ2A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0FC5529ABA07;
        Tue,  1 Aug 2023 12:49:20 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.193.232])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0D58AC585A0;
        Tue,  1 Aug 2023 12:49:16 +0000 (UTC)
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
Subject: [PATCH v2 6/8] mm/huge_memory: remove stale NUMA hinting comment from follow_trans_huge_pmd()
Date:   Tue,  1 Aug 2023 14:48:42 +0200
Message-ID: <20230801124844.278698-7-david@redhat.com>
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

That comment for pmd_protnone() was added in commit 2b4847e73004
("mm: numa: serialise parallel get_user_page against THP migration"), which
noted:

	THP does not unmap pages due to a lack of support for migration
	entries at a PMD level.  This allows races with get_user_pages

Nowadays, we do have PMD migration entries, so the comment no longer
applies. Let's drop it.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/huge_memory.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2cd3e5502180..0b709d2c46c6 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1467,7 +1467,6 @@ struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
 	if ((flags & FOLL_DUMP) && is_huge_zero_pmd(*pmd))
 		return ERR_PTR(-EFAULT);
 
-	/* Full NUMA hinting faults to serialise migration in fault paths */
 	if (pmd_protnone(*pmd) && !gup_can_follow_protnone(vma, flags))
 		return NULL;
 
-- 
2.41.0

