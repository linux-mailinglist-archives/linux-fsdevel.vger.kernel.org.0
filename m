Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C58765E32
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 23:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbjG0V3s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 17:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbjG0V3p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 17:29:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421A710CB
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 14:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690493337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NHdYsiNqqxFFYOyFZT8N/uUoLYdRyRl4LhGdK5bhGpM=;
        b=NPC43X2+TbQc6Hc2VTXizEy/a7NdbgIM5vol+c2iOZ+2hggR6tRvaRwUMQLDB5CAhmPGOe
        s1YHc15Xn3yQchCXYtwR3OVTEvGgjty+vWkNuiJGFWfvpkyuu/C3tSz3NnIf01pWMnKZdq
        DBTO7AdYuFkoPQyArBAl+meGyrxRa1Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-554-F0H8AQw3M0yhKgh2HgjDcA-1; Thu, 27 Jul 2023 17:28:56 -0400
X-MC-Unique: F0H8AQw3M0yhKgh2HgjDcA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 50B76104458B;
        Thu, 27 Jul 2023 21:28:55 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 67C2B40C2063;
        Thu, 27 Jul 2023 21:28:53 +0000 (UTC)
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
Subject: [PATCH v1 2/4] mm/gup: Make follow_page() succeed again on PROT_NONE PTEs/PMDs
Date:   Thu, 27 Jul 2023 23:28:43 +0200
Message-ID: <20230727212845.135673-3-david@redhat.com>
In-Reply-To: <20230727212845.135673-1-david@redhat.com>
References: <20230727212845.135673-1-david@redhat.com>
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

We accidentally enforced PROT_NONE PTE/PMD permission checks for
follow_page() like we do for get_user_pages() and friends. That was
undesired, because follow_page() is usually only used to lookup a currently
mapped page, not to actually access it. Further, follow_page() does not
actually trigger fault handling, but instead simply fails.

Let's restore that behavior by conditionally setting FOLL_FORCE if
FOLL_WRITE is not set. This way, for example KSM and migration code will
no longer fail on PROT_NONE mapped PTEs/PMDS.

Handling this internally doesn't require us to add any new FOLL_FORCE
usage outside of GUP code.

While at it, refuse to accept FOLL_FORCE: we don't even perform VMA
permission checks like in check_vma_flags(), so especially
FOLL_FORCE|FOLL_WRITE would be dodgy.

This issue was identified by code inspection. We'll add some
documentation regarding FOLL_FORCE next.

Reported-by: Peter Xu <peterx@redhat.com>
Fixes: 474098edac26 ("mm/gup: replace FOLL_NUMA by gup_can_follow_protnone()")
Cc: <stable@vger.kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/gup.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/mm/gup.c b/mm/gup.c
index 2493ffa10f4b..da9a5cc096ac 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -841,9 +841,17 @@ struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
 	if (vma_is_secretmem(vma))
 		return NULL;
 
-	if (WARN_ON_ONCE(foll_flags & FOLL_PIN))
+	if (WARN_ON_ONCE(foll_flags & (FOLL_PIN | FOLL_FORCE)))
 		return NULL;
 
+	/*
+	 * Traditionally, follow_page() succeeded on PROT_NONE-mapped pages
+	 * but failed follow_page(FOLL_WRITE) on R/O-mapped pages. Let's
+	 * keep these semantics by setting FOLL_FORCE if FOLL_WRITE is not set.
+	 */
+	if (!(foll_flags & FOLL_WRITE))
+		foll_flags |= FOLL_FORCE;
+
 	page = follow_page_mask(vma, address, foll_flags, &ctx);
 	if (ctx.pgmap)
 		put_dev_pagemap(ctx.pgmap);
-- 
2.41.0

