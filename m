Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698A674B8E3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jul 2023 23:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbjGGVzx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jul 2023 17:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbjGGVzt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jul 2023 17:55:49 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5AB1FF0
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jul 2023 14:55:48 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c118efd0c3cso2503654276.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Jul 2023 14:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688766947; x=1691358947;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NbMcVYI2pBRE777guUXN8FaAW75orbR1/eldPHt/4Qo=;
        b=NOEsj6QlU33fkoMHjc+WtoODa05QBYjoZyIbXV7SYMyRK4hq0SF4tb/6rEhclUqRYC
         mOAiI18o28n3yIQcsYTOwNtyQs9I4Y75+l2ujaQgav71uvbNCaDX8ZAB71qsYgJ7+xTa
         uxTM2xxcQMPCK82+u5G0FIcYmJndcJvSC2j4rI/o0BwYIadvkUVSbCsJTgLi+uxz3KVd
         Q99KgDvVH0Fhf1f3UtgXY26LR8Gv38XOQazfPV3NexlCyCTv+Yqi8QmGof9JmvYLxs5o
         0PxXYucNeE0EtG/ra5xrr2THGEnwJn3zj/1ct12e0dwMeVPDE0288jdN/lwXa8MEHOhK
         4RFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688766947; x=1691358947;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NbMcVYI2pBRE777guUXN8FaAW75orbR1/eldPHt/4Qo=;
        b=ftClsJGTALeC3E11H4wJf/aO/bcKm4gX6+CvY/ofViKutcDHnBOLb0487hKkSVC3y8
         2nvPNu5o4MU9FpWgHq2OP5Jn8Kl+xk0+vlL6UUlIVz6PMKpr9dfUAsxO7/2O9qqUwJdo
         qC/xXxYTSuc7FOPY5O+frIghul02+azaHDQuMoVjcViY2JYDvrFHvS7u1V1apOKiDWOd
         3Sp9Qz/8GYbpcxNNImMhdZ5GXVxqDstraGWE7to31m1FF8UOBqCRscSylTbdlHCWftb0
         PKwGuvu2R4RZ8iws/FlWVfyDNhJekaZZLggoZk9OlPC3zTNMmdnlQX7ggZoLhmIoxB6T
         dBFg==
X-Gm-Message-State: ABy/qLZDA81zdRpYSV0SC0qa8XqxpwgBduPlaTxKFs2r60EZSO9Pctfz
        3+5wvYJ4cB/LOsB4q7/f8JCbilmlZlPCnSDhZoft
X-Google-Smtp-Source: APBJJlEoVC4taEJfd9VKK1x5AQ0VZDBfiUiNYwaYXwEPy1wLKPyTHC7hYYwTD01ltEHbhNSVCtGCPYme0YQ0PD4Gp2hC
X-Received: from axel.svl.corp.google.com ([2620:15c:2a3:200:c201:5125:39d1:ef3f])
 (user=axelrasmussen job=sendgmr) by 2002:a25:ac9e:0:b0:c5b:c4:1789 with SMTP
 id x30-20020a25ac9e000000b00c5b00c41789mr33953ybi.1.1688766947243; Fri, 07
 Jul 2023 14:55:47 -0700 (PDT)
Date:   Fri,  7 Jul 2023 14:55:34 -0700
In-Reply-To: <20230707215540.2324998-1-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20230707215540.2324998-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230707215540.2324998-3-axelrasmussen@google.com>
Subject: [PATCH v4 2/8] mm: userfaultfd: check for start + len overflow in validate_range
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brian Geffon <bgeffon@google.com>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        James Houghton <jthoughton@google.com>,
        "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>,
        Jiaqi Yan <jiaqiyan@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Nadav Amit <namit@vmware.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Peter Xu <peterx@redhat.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "T.J. Alumbaugh" <talumbau@google.com>,
        Yu Zhao <yuzhao@google.com>,
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

Most userfaultfd ioctls take a `start + len` range as an argument.
We have the validate_range helper to check that such ranges are valid.
However, some (but not all!) ioctls *also* check that `start + len`
doesn't wrap around (overflow).

Just check for this in validate_range. This saves some repetitive code,
and adds the check to some ioctls which weren't bothering to check for
it before.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 fs/userfaultfd.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 7cecd49e078b..2e84684c46f0 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1306,6 +1306,8 @@ static __always_inline int validate_range(struct mm_struct *mm,
 		return -EINVAL;
 	if (len > task_size - start)
 		return -EINVAL;
+	if (start + len <= start)
+		return -EINVAL;
 	return 0;
 }
 
@@ -1760,14 +1762,8 @@ static int userfaultfd_copy(struct userfaultfd_ctx *ctx,
 	ret = validate_range(ctx->mm, uffdio_copy.dst, uffdio_copy.len);
 	if (ret)
 		goto out;
-	/*
-	 * double check for wraparound just in case. copy_from_user()
-	 * will later check uffdio_copy.src + uffdio_copy.len to fit
-	 * in the userland range.
-	 */
+
 	ret = -EINVAL;
-	if (uffdio_copy.src + uffdio_copy.len <= uffdio_copy.src)
-		goto out;
 	if (uffdio_copy.mode & ~(UFFDIO_COPY_MODE_DONTWAKE|UFFDIO_COPY_MODE_WP))
 		goto out;
 	if (uffdio_copy.mode & UFFDIO_COPY_MODE_WP)
@@ -1927,11 +1923,6 @@ static int userfaultfd_continue(struct userfaultfd_ctx *ctx, unsigned long arg)
 		goto out;
 
 	ret = -EINVAL;
-	/* double check for wraparound just in case. */
-	if (uffdio_continue.range.start + uffdio_continue.range.len <=
-	    uffdio_continue.range.start) {
-		goto out;
-	}
 	if (uffdio_continue.mode & ~(UFFDIO_CONTINUE_MODE_DONTWAKE |
 				     UFFDIO_CONTINUE_MODE_WP))
 		goto out;
-- 
2.41.0.255.g8b1d071c50-goog

