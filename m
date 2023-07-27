Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8DD5765E3A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 23:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjG0Vai (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 17:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbjG0Vac (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 17:30:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875CF1BF4
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 14:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690493346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jGnguQzUAnXSgoEJGq4aUCEYI9GBqFjghH3nhnid2s4=;
        b=LIC7PjXhU9JMtnKM9nSmeuF1a9xgG9GFaBlxxlaWTzxGhlur1/EHHl6cMA/PB6irJFFvHR
        w6rgIbpOiD1oZRcHhps7I4vwqJA9ir3HGxekS1nQtxLRIg9yT4psGr+6Grs4AE/ogvHQo8
        TC7uDaptFi8DjjSsuC+OMyKw10nneEw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-49-u7XBChHRONmnMfoWeq8OoQ-1; Thu, 27 Jul 2023 17:29:00 -0400
X-MC-Unique: u7XBChHRONmnMfoWeq8OoQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C80A3856F66;
        Thu, 27 Jul 2023 21:28:59 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CDA6240C2063;
        Thu, 27 Jul 2023 21:28:57 +0000 (UTC)
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
Subject: [PATCH v1 4/4] mm/gup: document FOLL_FORCE behavior
Date:   Thu, 27 Jul 2023 23:28:45 +0200
Message-ID: <20230727212845.135673-5-david@redhat.com>
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

As suggested by Peter, let's document FOLL_FORCE handling and make it
clear that without FOLL_FORCE, we will always trigger NUMA-hinting
faults when stumbling over a PROT_NONE-mapped PTE.

Also add a comment regarding follow_page() and its interaction with
FOLL_FORCE.

Let's place the doc next to the definition, where it certainly can't be
missed.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm_types.h | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 2fa6fcc740a1..96cf78686c29 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1243,7 +1243,30 @@ enum {
 	FOLL_GET = 1 << 1,
 	/* give error on hole if it would be zero */
 	FOLL_DUMP = 1 << 2,
-	/* get_user_pages read/write w/o permission */
+	/*
+	 * Make get_user_pages() and friends ignore some VMA+PTE permissions.
+	 *
+	 * This flag should primarily only be used by ptrace and some
+	 * GUP-internal functionality, such as for mlock handling.
+	 *
+	 * Without this flag, these functions always trigger page faults
+	 * (such as NUMA hinting faults) when stumbling over a
+	 * PROT_NONE-mapped PTE.
+	 *
+	 * !FOLL_WRITE: succeed even if the PTE is PROT_NONE
+	 * * Rejected if the VMA is currently not readable and it cannot
+	 *   become readable
+	 *
+	 * FOLL_WRITE: succeed even if the PTE is not writable.
+	 *  * Rejected if the VMA is currently not writable and
+	 *   * it is a hugetlb mapping
+	 *   * it is not a COW mapping that could become writable
+	 *
+	 * Note: follow_page() does not accept FOLL_FORCE. Historically,
+	 * follow_page() behaved similar to FOLL_FORCE without FOLL_WRITE:
+	 * succeed even if the PTE is PROT_NONE and FOLL_WRITE is not set.
+	 * However, VMA permissions are not checked.
+	 */
 	FOLL_FORCE = 1 << 3,
 	/*
 	 * if a disk transfer is needed, start the IO and return without waiting
-- 
2.41.0

