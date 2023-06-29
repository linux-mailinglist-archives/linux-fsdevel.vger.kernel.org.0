Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF49C742EE8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 22:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbjF2Uu5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 16:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbjF2Uuy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 16:50:54 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB953583
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 13:50:50 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-569e7aec37bso9292727b3.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 13:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688071850; x=1690663850;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R8jkAmCGbYNygAZgSop/zKP0BAnGYhZIuFEhOa1in5M=;
        b=a8O0wagyUtUHav4dJ+0FTU4BfULv1hqXducKGWGQFuo+G+tIPjHy7DS1ADLv5ngmlB
         RSngMc0CnR4cfT4Dl1/3ekbmm7f4jkeC6RGHf37xUtQNDImjBtBI9DhIP8Z9AdXeugxu
         EEIqVXFJE09pcCYmkIu4KbepOYvezPBB0mUQ8g4biI54D+MfCLg+3QhsHFv6yxYBACnS
         hW5iDv/qv08V0YHMgwph0e9b+5pGUlXVr84spJ6yslQMHWase0Q3RfrmBefxTbxnzdJF
         i1oPLS3gMTFjIwMQZ2twKVJdYWAw+m3Lbi649+iUQ0hPFKbJ4IuR/hqznd3O1UEd0bUk
         66bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688071850; x=1690663850;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R8jkAmCGbYNygAZgSop/zKP0BAnGYhZIuFEhOa1in5M=;
        b=I6NHZzbJ3iDK+EdRyAGhri57tGmeDn4SUxrAd9WCpVE3fGQBta4RllllP7308HZn+j
         PW08w6MaYmRzfg+krLr2CHBgqAfHou9mj+IcA0EZNAwXKZw3CQyc9yvWwB8W5ZMFbHcs
         DNUji30wyo1rP1mgG8DQ6PdWZqCZNkSAHXcDOtLrMdmUA+o2DE9cxgS5t8rHGxPOlxAy
         u9hC5oHrO5xySa8JM08893PuOkGh7MRYiUtRYovgMGt+sXTdeUa+Us3NuyXDQo9HNCTQ
         7veRtQY18qiRgevBZd+v0eMUCu01T/ExPaLBWtxaTPkZePBpAcHuCijh7T5IhZocM/44
         wafQ==
X-Gm-Message-State: ABy/qLYzVlCxcNiXH62oW84xqLTkgoZv7mXS8GPBgrIzrX+B1a/BD92c
        Qz0sJtHRFTtU6C54zWAa28OB/6spOGbA1PV8UvVW
X-Google-Smtp-Source: APBJJlEqqtwXeQ2F+CB5P4eAYTWY2GLrYOnygDGt3hdnYMvy8/GPfEVbxlgghXg+IFwNtZpThqff4X0A++LKH4Bo56yy
X-Received: from axel.svl.corp.google.com ([2620:15c:2a3:200:e20f:5917:3efa:d4bb])
 (user=axelrasmussen job=sendgmr) by 2002:a25:738e:0:b0:bcc:285c:66ea with
 SMTP id o136-20020a25738e000000b00bcc285c66eamr5716ybc.3.1688071850044; Thu,
 29 Jun 2023 13:50:50 -0700 (PDT)
Date:   Thu, 29 Jun 2023 13:50:36 -0700
In-Reply-To: <20230629205040.665834-1-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20230629205040.665834-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230629205040.665834-2-axelrasmussen@google.com>
Subject: [PATCH v2 2/6] mm: userfaultfd: refactor hugetlb folio allocation /
 lookup code
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        James Houghton <jthoughton@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Nadav Amit <namit@vmware.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        ZhangPeng <zhangpeng362@huawei.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

At the top of `hugetlb_mfill_atomic_pte`, we need to get the folio we're
going to be mapping. There are three basic cases we're dealing with
here:

1. We're doing a UFFDIO_CONTINUE, in which case we lookup an existing
   folio in the pagecache, instead of allocating a new one.
2. We need to allocate a new folio.
3. We previously failed while populating our new folio, so we "returned"
   a temporary folio using `foliop` and had our caller retry.

In a future commit I'm going to add a fourth case for UFFDIO_POISON,
where we aren't going to map a folio at all (newly allocated or
otherwise). This end state will be simpler, and we can re-use a bit more
code, if we stop using `if (...)` to distinguish the cases.

So, refactor the cases so they share most of the same code, and instead
switch to `goto` to skip some parts depending on the case at hand.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 mm/hugetlb.c | 53 +++++++++++++++++++++++++---------------------------
 1 file changed, 25 insertions(+), 28 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index bce28cca73a1..38711d49e4db 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6259,22 +6259,32 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 		if (IS_ERR(folio))
 			goto out;
 		folio_in_pagecache = true;
-	} else if (!*foliop) {
-		/* If a folio already exists, then it's UFFDIO_COPY for
-		 * a non-missing case. Return -EEXIST.
-		 */
-		if (vm_shared &&
-		    hugetlbfs_pagecache_present(h, dst_vma, dst_addr)) {
-			ret = -EEXIST;
-			goto out;
+		goto ready;
+	}
+
+	/* If a folio already exists, then it's UFFDIO_COPY for
+	 * a non-missing case. Return -EEXIST.
+	 */
+	if (vm_shared && hugetlbfs_pagecache_present(h, dst_vma, dst_addr)) {
+		ret = -EEXIST;
+		if (*foliop) {
+			folio_put(*foliop);
+			*foliop = NULL;
 		}
+		goto out;
+	}
 
-		folio = alloc_hugetlb_folio(dst_vma, dst_addr, 0);
-		if (IS_ERR(folio)) {
-			ret = -ENOMEM;
-			goto out;
+	folio = alloc_hugetlb_folio(dst_vma, dst_addr, 0);
+	if (IS_ERR(folio)) {
+		ret = -ENOMEM;
+		if (*foliop) {
+			folio_put(*foliop);
+			*foliop = NULL;
 		}
+		goto out;
+	}
 
+	if (!*foliop) {
 		ret = copy_folio_from_user(folio, (const void __user *) src_addr,
 					   false);
 
@@ -6302,22 +6312,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 			 */
 			goto out;
 		}
-	} else {
-		if (vm_shared &&
-		    hugetlbfs_pagecache_present(h, dst_vma, dst_addr)) {
-			folio_put(*foliop);
-			ret = -EEXIST;
-			*foliop = NULL;
-			goto out;
-		}
-
-		folio = alloc_hugetlb_folio(dst_vma, dst_addr, 0);
-		if (IS_ERR(folio)) {
-			folio_put(*foliop);
-			ret = -ENOMEM;
-			*foliop = NULL;
-			goto out;
-		}
+	} else { /* Caller retried because we set *foliop previously */
 		ret = copy_user_large_folio(folio, *foliop, dst_addr, dst_vma);
 		folio_put(*foliop);
 		*foliop = NULL;
@@ -6327,6 +6322,8 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 		}
 	}
 
+ready: /* `folio` ready to map (non-NULL, populated) */
+
 	/*
 	 * The memory barrier inside __folio_mark_uptodate makes sure that
 	 * preceding stores to the page contents become visible before
-- 
2.41.0.255.g8b1d071c50-goog

