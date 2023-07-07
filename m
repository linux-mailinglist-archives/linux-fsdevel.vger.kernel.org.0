Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0BE174B8F8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jul 2023 23:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbjGGV42 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jul 2023 17:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbjGGV4W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jul 2023 17:56:22 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5217326A3
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jul 2023 14:55:57 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c704df12425so636562276.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Jul 2023 14:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688766956; x=1691358956;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gK2BPE6zTmiKkfK2gtxYAq2cBVrZ0W+ejTntqdgctKA=;
        b=mSszojzKEahxrcX9TmdDeq6BffcUFhBof3Wfa2NSLReCESkfHCMI7XDPflqSMkDGpn
         ouiK/1EZIjxsDpq0jMwqD9m1X62FyMq4nDzBgb6M7/ML2imJB1U5v1dc1l+ah8jMdnJe
         PB5xOLeeNwdXhcD53UzfTcq44+hoXfPErYaXguCDFgNeDDRdB2ZRmDfpfqDhBFUErms9
         b4UKo5d1K8Kn+ry9fkThfTtz75Zrd1GT+xA0NJx4QctBIIrNfwI5B6zi4Oqa1PV6Le9z
         CZ6qPQtNTcVthIO6ODY++3/5NAu2trU9W9ps5V5xHMzx1D8Foq0j24NK0X2aUZ74o34R
         JWeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688766956; x=1691358956;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gK2BPE6zTmiKkfK2gtxYAq2cBVrZ0W+ejTntqdgctKA=;
        b=JKgClJIflZt6ovEiraDSFoYs/mAEvAT9Qnzn2vQqh7areFcY3KwqLMtebm/WEhgaAh
         xgBJZi3FWHEeJuOtY5NxFRSeeXEJIdxBlMJQtRIZjaM4czFs0/1ceZqxye3jLMfQkvtA
         +R/yrlo+6agWamP/UaJGLsliH6y2wJ+d0FWuV4ly4IgbH2e0zDRP0LroZaQ9MX3eLkkm
         4d/+r8WCPAPK4pk+j5FmrLusIa+AqiAKptQ8l4SBtv6Lu2cqFpBf5taggqAW/UwQcG8Z
         1yizClSXgnjBI86XJRgaCucsFjEN88SefgwPBiYY+ouIBZGaxCoCyEPDUo8hI784G1hL
         oqLA==
X-Gm-Message-State: ABy/qLYA0BGYWhAjCNd+FvceLpmdfOyAwc58xk4Wr2eabvaY5Vfnm4x7
        G4/BF6aj0/W/2rwSnjqILZuWK+UpWX/jKmS5V1b8
X-Google-Smtp-Source: APBJJlFFlaqfrCAHxFCqM3Bx4zG+dvuvfGgO5ZnIbPvaXcko0/wlrp48kEZGBI/2IRBZ3QqzAWog232RIOlbEqwMvlQB
X-Received: from axel.svl.corp.google.com ([2620:15c:2a3:200:c201:5125:39d1:ef3f])
 (user=axelrasmussen job=sendgmr) by 2002:a25:f448:0:b0:bac:adb8:a605 with
 SMTP id p8-20020a25f448000000b00bacadb8a605mr43005ybe.2.1688766956303; Fri,
 07 Jul 2023 14:55:56 -0700 (PDT)
Date:   Fri,  7 Jul 2023 14:55:39 -0700
In-Reply-To: <20230707215540.2324998-1-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20230707215540.2324998-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230707215540.2324998-8-axelrasmussen@google.com>
Subject: [PATCH v4 7/8] selftests/mm: refactor uffd_poll_thread to allow
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
 tools/testing/selftests/mm/uffd-common.c | 5 ++++-
 tools/testing/selftests/mm/uffd-common.h | 3 +++
 tools/testing/selftests/mm/uffd-stress.c | 8 ++++----
 3 files changed, 11 insertions(+), 5 deletions(-)

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
index 995ff13e74c7..73ebb97c7026 100644
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
@@ -250,6 +248,8 @@ static int userfaultfd_stress(void)
 	struct uffd_args args[nr_cpus];
 	uint64_t mem_size = nr_pages * page_size;
 
+	memset(args, 0, sizeof(struct uffd_args) * nr_cpus);
+
 	if (uffd_test_ctx_init(UFFD_FEATURE_WP_UNPOPULATED, NULL))
 		err("context init failed");
 
-- 
2.41.0.255.g8b1d071c50-goog

