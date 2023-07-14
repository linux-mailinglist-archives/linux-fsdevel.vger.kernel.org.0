Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C714754291
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jul 2023 20:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236857AbjGNS3o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jul 2023 14:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235734AbjGNS3n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jul 2023 14:29:43 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434BCC6
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Jul 2023 11:29:42 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bfae0f532e4so1822653276.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Jul 2023 11:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689359381; x=1691951381;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yxAUfh9tXsKn2HpY20y1qdPrUCx+3NBgZb4IkMtE0Gs=;
        b=mRXoMTCmgDEUqGGQOSIsn5uuIWxzrKXnwuch52uQZkXJzVeF5h7KiOw042B2VG4MjP
         Ud668hnCaHqrAsJelWng9Y2s3bZEVDGgCwmtA+RKaeDYCfKMRATcF36o9bwXZSjLJXmD
         xGwtxtYrORJWP/GtvcdJ6DB3nWNbNp1NNsvwoy5dkJJkXV1mjG4ZyIAPBxa0ZeJy47wC
         lRAwtwRfLuaZHPN6fZIxopQbbbLZSH+r7pelwbYbHYvr6TN2ykZ5n8m7RT6Rx1PDAv41
         itfOO1Y5wnapfiZ17WHQSzoXlIaDEkigdLEJ+n13E7rjAc5bMhn9nmE0OvXONw09Gqtv
         LCkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689359381; x=1691951381;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yxAUfh9tXsKn2HpY20y1qdPrUCx+3NBgZb4IkMtE0Gs=;
        b=giCdrMU40T8xqc7pRBgCjjBKBFLsCT7/+xLBORhbZW9/jfK9AUFm3QimXy3mDS8p65
         hKcPNFKlna5FoEfv07DLMCiJWRaABKE4OCTyoBavUEiRMN+0wuJfzzCzblZO8AxXvJJU
         ZkWI+/4SOIZHfZXHTrQGt6VVTkc8JOiRylPzMDoAHb3NDCma/fAmA2WkuQkviHKW2w9h
         86kveLhHdOGC5S4A5bnZhZSKNZ/ztIErAhSvYPOxtpUUrG9kDSbxFTnZaMaijbT/ZhZk
         Wki0OGlkacEi/q3l/QrTQ4+vJROvjDZN1HnooJm+kzSOxKPQXjjeINZXriUVWF8LBkF5
         sO/g==
X-Gm-Message-State: ABy/qLYuZoqW/lKH/83HcQaV641bLHpyK5IM7YOQcJMrnTha4DJuzIWl
        U17L8iKAbn7G9E9720w0qTWcjHkaCTRAgWPdb7l/
X-Google-Smtp-Source: APBJJlHJ/kyB4gtYJRA2tBe4+IdzDMyqED2Fs1IG5ccfZHYtkPxqRy1tdgRGDnnyoyPph5LKlnKkyWQ84gNPe3dqgbnb
X-Received: from axel.svl.corp.google.com ([2620:15c:2a3:200:eeac:4e26:b121:5ef2])
 (user=axelrasmussen job=sendgmr) by 2002:a25:4157:0:b0:c10:8d28:d3ae with
 SMTP id o84-20020a254157000000b00c108d28d3aemr26174yba.8.1689359381331; Fri,
 14 Jul 2023 11:29:41 -0700 (PDT)
Date:   Fri, 14 Jul 2023 11:29:32 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230714182932.2608735-1-axelrasmussen@google.com>
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
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "T.J. Alumbaugh" <talumbau@google.com>,
        Yu Zhao <yuzhao@google.com>,
        ZhangPeng <zhangpeng362@huawei.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>,
        syzbot+42309678e0bc7b32f8e9@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This commit removed an extra check for zero-length ranges, and folded it
into the common validate_range() helper used by all UFFD ioctls.

It failed to notice though that UFFDIO_COPY *only* called validate_range
on the dst range, not the src range. So removing this check actually let
us proceed with zero-length source ranges, eventually hitting a BUG
further down in the call stack.

The correct fix seems clear: call validate_range() on the src range too.

Other ioctls are not affected by this, as they only have one range, not
two (src + dst).

Reported-by: syzbot+42309678e0bc7b32f8e9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=42309678e0bc7b32f8e9
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 fs/userfaultfd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 53a7220c4679..36d233759233 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1759,6 +1759,9 @@ static int userfaultfd_copy(struct userfaultfd_ctx *ctx,
 			   sizeof(uffdio_copy)-sizeof(__s64)))
 		goto out;
 
+	ret = validate_range(ctx->mm, uffdio_copy.src, uffdio_copy.len);
+	if (ret)
+		goto out;
 	ret = validate_range(ctx->mm, uffdio_copy.dst, uffdio_copy.len);
 	if (ret)
 		goto out;
-- 
2.41.0.255.g8b1d071c50-goog

