Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097F1778156
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 21:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbjHJTVt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 15:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbjHJTVs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 15:21:48 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7539010D
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 12:21:47 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5840614b13cso23921687b3.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 12:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691695306; x=1692300106;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JVwAsL8GyIj4mx5rACaLqR7121szF8L7kVa/VdSYhKk=;
        b=W/I0jMUUR76P+6pY9PNw6/9lrs82do/vNTSTR7MQbf0T5sxD5ee07o/AopBu6jRp2E
         WZnCIRWERMlxTbBmgviUTWUKyaRGjZ2Xtt1BFf1MsbHT42k3S+u6IuCKQHRfDmTvVkCE
         Cgwa+5SM2CMJrzCWkOBVh5eYlaF0Vb0S9olgCPGKYX3KqTvn3i8MswXT95LHLMmNMoew
         bn/cMAlDdhvhTpkNRRFfiCYCF4vOpk6ZCG73MqBGRK/Sb7T78Wp3u8WtYw8fSZ2yrpmE
         q8mlC5QOTvl4xRYwIKw3SSeZQe5wrTD/reHyzKv2bJRFQMN2wpSoIKnnaNwfM+A/yBCh
         BIMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691695306; x=1692300106;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JVwAsL8GyIj4mx5rACaLqR7121szF8L7kVa/VdSYhKk=;
        b=eV+5BGQQ9tsdihVxahIGbnwzqqXR4qktsLxGiB4Wv5D4TnlUGk8tDUYxBfIT0cIrTh
         4kb6gb9QoAF7jhFhkizVBaovie37h718KgX3HRDX2ylYinuQqV8jyZkzRe9T8zJppEYS
         6t73rsZ9V1u/Kt+oqDezhWRfyU/b8NJleZKythos9AbgNooTVZ9DXHPrl6GvKCZmHO50
         4w5FXGQEFNr1sjxFyeQULTevjicaBhqEGElNIo28BNc3bRw4nvjl3KGmohHHMKQHs7W0
         bXW9u3ZLnXveRNLbbZWqFDZH5yEwZhTbX4Ob+Tn9D32Q4PrB+7sktNDmhyKc1kNM0GlA
         eRbA==
X-Gm-Message-State: AOJu0YwCJ03eEqzWl2z1kDmVSdwZR8hbel4Fb/0IOeA5jf+7UjhlbSpO
        UuPAMR7rZIwYsHbqCi4LHtVd4nl9Zmez4vswIeAd
X-Google-Smtp-Source: AGHT+IGL5UhB5HhvTOWpZuR6v95NxwJe4g+zXUVXUS554aEFsc/GlWZiIV916LpXuIgo0/V184I8wNlnKoIYhiZEQhlq
X-Received: from axel.svl.corp.google.com ([2620:15c:2a3:200:cc07:13ef:656b:e8de])
 (user=axelrasmussen job=sendgmr) by 2002:a81:a94a:0:b0:56c:ed45:442c with
 SMTP id g71-20020a81a94a000000b0056ced45442cmr65776ywh.5.1691695306687; Thu,
 10 Aug 2023 12:21:46 -0700 (PDT)
Date:   Thu, 10 Aug 2023 12:21:28 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230810192128.1855570-1-axelrasmussen@google.com>
Subject: [PATCH mm-unstable fix] mm: userfaultfd: check for start + len
 overflow in validate_range: fix
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
        Steven Barrett <steven@liquorix.net>,
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A previous fixup to this commit fixed one issue, but introduced another:
we're now overly strict when validating the src address for UFFDIO_COPY.

Most of the validation in validate_range is useful to apply to src as
well as dst, but page alignment is only a requirement for dst, not src.
So, split the function up so src can use an "unaligned" variant, while
still allowing us to share the majority of the code between the
different cases.

Reported-by: Ryan Roberts <ryan.roberts@arm.com>
Closes: https://lore.kernel.org/linux-mm/8fbb5965-28f7-4e9a-ac04-1406ed8fc2d4@arm.com/T/#t
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 fs/userfaultfd.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index bb5c474a0a77..1091cb461747 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1287,13 +1287,11 @@ static __always_inline void wake_userfault(struct userfaultfd_ctx *ctx,
 		__wake_userfault(ctx, range);
 }

-static __always_inline int validate_range(struct mm_struct *mm,
-					  __u64 start, __u64 len)
+static __always_inline int validate_unaligned_range(
+	struct mm_struct *mm, __u64 start, __u64 len)
 {
 	__u64 task_size = mm->task_size;

-	if (start & ~PAGE_MASK)
-		return -EINVAL;
 	if (len & ~PAGE_MASK)
 		return -EINVAL;
 	if (!len)
@@ -1309,6 +1307,15 @@ static __always_inline int validate_range(struct mm_struct *mm,
 	return 0;
 }

+static __always_inline int validate_range(struct mm_struct *mm,
+					  __u64 start, __u64 len)
+{
+	if (start & ~PAGE_MASK)
+		return -EINVAL;
+
+	return validate_unaligned_range(mm, start, len);
+}
+
 static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 				unsigned long arg)
 {
@@ -1759,7 +1766,8 @@ static int userfaultfd_copy(struct userfaultfd_ctx *ctx,
 			   sizeof(uffdio_copy)-sizeof(__s64)))
 		goto out;

-	ret = validate_range(ctx->mm, uffdio_copy.src, uffdio_copy.len);
+	ret = validate_unaligned_range(ctx->mm, uffdio_copy.src,
+				       uffdio_copy.len);
 	if (ret)
 		goto out;
 	ret = validate_range(ctx->mm, uffdio_copy.dst, uffdio_copy.len);
--
2.41.0.640.ga95def55d0-goog

