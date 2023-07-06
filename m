Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB8274A74A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jul 2023 00:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbjGFWvx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 18:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbjGFWvY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 18:51:24 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E08210C
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Jul 2023 15:51:05 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-573a92296c7so14484477b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Jul 2023 15:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688683864; x=1691275864;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0eR1m0YpsGhZ6GlqZ9XuYhhV42VymJr50nJOc8nZiNo=;
        b=zVK6nDx2/vIL1dc7h7hFZDfr/rEOBcNDC5lzAQ8fMfaY2kDXm1d90zN+sAdZBRkAVy
         eS0e/cYLAI5GlN5hCyqzAZsI3npJTnOPGdGRNCf5Z9XQRS26+3V3iKb68AeK1pqfrrK/
         xI0bVwy1i7i/os5XjQVIXRLYlXw2zGr2RbOxqfH7TjC+dya4aBmpaEQwquOV67eYDYli
         EHdK6eJUGxQqPuxQuTMsQewM+3qR50sGQFaisJznV2893CLPnbjYkC1qV0z6IJvBHP2Q
         Qm/1xZWrhlds7/VAWCEpvN4M1cI6E8ouf/4BdK8WRTe5GRh7RJaWO+df/EurZS1IsV5C
         ESHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688683864; x=1691275864;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0eR1m0YpsGhZ6GlqZ9XuYhhV42VymJr50nJOc8nZiNo=;
        b=diP/QgAsYv05BSE6XxnraTWg6L714Ga0/yJtiAlBPMnz076SHJohAnKUqwkRxi2881
         mDTs+8ndNQeWT4Sh2TvhvQBGdCb7LpmULD15cyj2yFDtvik7IsHlINv382YZb8pDZMO/
         oaKEhu7ygQXljBACZFt1+lAAZe54IBmXl0ju00rps8ubaL9+z0basXXCex+jD00L5gr0
         euaLWRP0zJfueXeoSaDeYXM4CaoYp30yicst0naAChwFzfr28Tq5BmmSE0cRXF688JyJ
         fgl9RZ8OjPSo9rcWzDAmF0SVXdF2qOgFBZdIO7vaysDF/LTsHPE0OHv9xngMDbTBqJ5Q
         xJ4Q==
X-Gm-Message-State: ABy/qLZyBYtnqRFp1bp/k248xC/qs0VUTLXEgBRq4YpEwbL6Kdgx67VJ
        vszvv1+VgC7CGwGVHFBvYSfF9hFKwWN+EAKQK1nm
X-Google-Smtp-Source: APBJJlGqdtbTPga9QJm8ffVaUw6WvKONQskr2t33RDHlmoUv4ugqzz1h75IhlcTDYghh9LVvfKAy5QaL8bfvdcxVM2r/
X-Received: from axel.svl.corp.google.com ([2620:15c:2a3:200:bec3:2b1c:87a:fca2])
 (user=axelrasmussen job=sendgmr) by 2002:a25:b193:0:b0:c01:e1c0:3b8f with
 SMTP id h19-20020a25b193000000b00c01e1c03b8fmr16283ybj.6.1688683864381; Thu,
 06 Jul 2023 15:51:04 -0700 (PDT)
Date:   Thu,  6 Jul 2023 15:50:35 -0700
In-Reply-To: <20230706225037.1164380-1-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20230706225037.1164380-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230706225037.1164380-8-axelrasmussen@google.com>
Subject: [PATCH v3 7/8] selftests/mm: refactor uffd_poll_thread to allow
 custom fault handlers
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

Previously, we had "one fault handler to rule them all", which used
several branches to deal with all of the scenarios required by all of
the various tests.

In upcoming patches, I plan to add a new test, which has its own
slightly different fault handling logic. Instead of continuing to add
cruft to the existing fault handler, let's allow tests to define custom
ones, separate from other tests.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 tools/testing/selftests/mm/uffd-common.c |  5 ++++-
 tools/testing/selftests/mm/uffd-common.h |  3 +++
 tools/testing/selftests/mm/uffd-stress.c | 12 +++++++-----
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
index ba20d7504022..02b89860e193 100644
--- a/tools/testing/selftests/mm/uffd-common.c
+++ b/tools/testing/selftests/mm/uffd-common.c
@@ -499,6 +499,9 @@ void *uffd_poll_thread(void *arg)
 	int ret;
 	char tmp_chr;
 
+	if (!args->handle_fault)
+		args->handle_fault = uffd_handle_page_fault;
+
 	pollfd[0].fd = uffd;
 	pollfd[0].events = POLLIN;
 	pollfd[1].fd = pipefd[cpu*2];
@@ -527,7 +530,7 @@ void *uffd_poll_thread(void *arg)
 			err("unexpected msg event %u\n", msg.event);
 			break;
 		case UFFD_EVENT_PAGEFAULT:
-			uffd_handle_page_fault(&msg, args);
+			args->handle_fault(&msg, args);
 			break;
 		case UFFD_EVENT_FORK:
 			close(uffd);
diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/selftests/mm/uffd-common.h
index 197f5262fe0d..7c4fa964c3b0 100644
--- a/tools/testing/selftests/mm/uffd-common.h
+++ b/tools/testing/selftests/mm/uffd-common.h
@@ -77,6 +77,9 @@ struct uffd_args {
 	unsigned long missing_faults;
 	unsigned long wp_faults;
 	unsigned long minor_faults;
+
+	/* A custom fault handler; defaults to uffd_handle_page_fault. */
+	void (*handle_fault)(struct uffd_msg *msg, struct uffd_args *args);
 };
 
 struct uffd_test_ops {
diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
index 995ff13e74c7..50b1224d72c7 100644
--- a/tools/testing/selftests/mm/uffd-stress.c
+++ b/tools/testing/selftests/mm/uffd-stress.c
@@ -189,10 +189,8 @@ static int stress(struct uffd_args *args)
 				   locking_thread, (void *)cpu))
 			return 1;
 		if (bounces & BOUNCE_POLL) {
-			if (pthread_create(&uffd_threads[cpu], &attr,
-					   uffd_poll_thread,
-					   (void *)&args[cpu]))
-				return 1;
+			if (pthread_create(&uffd_threads[cpu], &attr, uffd_poll_thread, &args[cpu]))
+				err("uffd_poll_thread create");
 		} else {
 			if (pthread_create(&uffd_threads[cpu], &attr,
 					   uffd_read_thread,
@@ -247,9 +245,13 @@ static int userfaultfd_stress(void)
 {
 	void *area;
 	unsigned long nr;
-	struct uffd_args args[nr_cpus];
+	struct uffd_args *args;
 	uint64_t mem_size = nr_pages * page_size;
 
+	args = calloc(nr_cpus, sizeof(struct uffd_args));
+	if (!args)
+		err("allocating args array failed");
+
 	if (uffd_test_ctx_init(UFFD_FEATURE_WP_UNPOPULATED, NULL))
 		err("context init failed");
 
-- 
2.41.0.255.g8b1d071c50-goog

