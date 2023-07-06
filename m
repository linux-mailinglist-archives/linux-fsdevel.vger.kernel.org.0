Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC2F74A72E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jul 2023 00:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjGFWuw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 18:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjGFWuv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 18:50:51 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AB81994
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Jul 2023 15:50:50 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c595cadae4bso1271816276.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Jul 2023 15:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688683849; x=1691275849;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n8zmkhTUTSLpfAyl7/UNU2Do+ozC8p34im9h+iKQJzc=;
        b=XNNbwIV//0t27QtIOlhCug+a1paGkIprej7/5tHl5NNn5KUEQh78vpB8hSgjpHgtml
         SHVQw3iJV4o2JiJrhBDuJIcmXz3dhskaIu5jpZoYHvMoFHMN6dOyuK+gts/4KV47wAdF
         AVwnH9YNrhfFTLUcC8hUifJ+Wg9tetdDYhfm0QOYMEa6yqrvPsN54eNgMW652Y9t7dsn
         4bBAzinND5wZDeIb6WWSVMvGD/yFFBONlGlbJzg6Yw5yde8xFCyvT/xKxlAA9Dw84boG
         X9157aATBdSKF3LfFE3ppzGxi+pKdgj65AAT3C9RqpCsGlIodHhiOdCG2Uk9JuBh9llq
         LOxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688683849; x=1691275849;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n8zmkhTUTSLpfAyl7/UNU2Do+ozC8p34im9h+iKQJzc=;
        b=FQ/8LFXq2EyUUK62UwEe0mRW24WwnskdxpQf1lyjqIAXM3W3CeEBpAQ0MHx3CwXXuu
         a8pNAWs4R1UKw5Kfrtv3Ti8KrCKtErfV8PsiIVydcQhhJ88pNj0Qro3Ec7rvS828IeTe
         ONWgtzvuPic+xxPsfucf6n2lzc7se69JK9G04UvJj8RfjQEUGk+BC18Mjqg2IaSYEoKo
         6Z40M/9ieAzhBu6TIBXP7gGcDD/jh0vutVXRxeNZUsaZQvf7TpsO/e4EVftvK5mUC7wj
         ErU3ZfMECIcm7LTlYFA/g/+LeKq2IxzgxhP9xnZY6cFJ3PQ3suZCYXdAtt5VuhOHPLbv
         Lunw==
X-Gm-Message-State: ABy/qLaATHQsSmy1/zL4ucBMZaaLWnitOgFxgTeFjM4Uyz0RwTz0Gbx7
        9A3IbpFFlgV2EFkMXJN4wkGvuj21iNKcDmUo7kNS
X-Google-Smtp-Source: APBJJlFbLqWUavEdkD+jz9r/bjiqpKIWeClwQb49Ydc52jFFjwqSAI72wtmf2+hUlHqaQBcSWvtJMNcnMXeulK/4C2EZ
X-Received: from axel.svl.corp.google.com ([2620:15c:2a3:200:bec3:2b1c:87a:fca2])
 (user=axelrasmussen job=sendgmr) by 2002:a25:3189:0:b0:c4f:43d7:7dbd with
 SMTP id x131-20020a253189000000b00c4f43d77dbdmr18242ybx.12.1688683849213;
 Thu, 06 Jul 2023 15:50:49 -0700 (PDT)
Date:   Thu,  6 Jul 2023 15:50:28 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230706225037.1164380-1-axelrasmussen@google.com>
Subject: [PATCH v3 0/8] add UFFDIO_POISON to simulate memory poisoning with UFFD
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

This series adds a new userfaultfd feature, UFFDIO_POISON. See commit 4
for a detailed description of the feature.

The series is based on Linus master (partial 6.5 merge window), and
structured like this:

- Patches 1-3 are preparation / refactoring
- Patches 4-6 implement and advertise the new feature
- Patches 7-8 implement a unit test for the new feature

Changelog:

v2 -> v3:
 - Rebase onto current Linus master.
 - Don't overwrite existing PTE markers for non-hugetlb UFFDIO_POISON.
   Before, non-hugetlb would override them, but hugetlb would not. I don't
   think there's a use case where we *want* to override a UFFD_WP marker
   for example, so take the more conservative behavior for all kinds of
   memory.
 - [Peter] Drop hugetlb mfill atomic refactoring, since it isn't needed
   for this series (we don't touch that code directly anyway).
 - [Peter] Switch to re-using PTE_MARKER_SWAPIN_ERROR instead of defining
   new PTE_MARKER_UFFD_POISON.
 - [Peter] Extract start / len range overflow check into existing
   validate_range helper; this fixes the style issue of unnecessary braces
   in the UFFDIO_POISON implementation, because this code is just deleted.
 - [Peter] Extract file size check out into a new helper.
 - [Peter] Defer actually "enabling" the new feature until the last commit
   in the series; combine this with adding the documentation. As a
   consequence, move the selftest commits after this one.
 - [Randy] Fix typo in documentation.

v1 -> v2:
 - [Peter] Return VM_FAULT_HWPOISON not VM_FAULT_SIGBUS, to yield the
   correct behavior for KVM (guest MCE).
 - [Peter] Rename UFFDIO_SIGBUS to UFFDIO_POISON.
 - [Peter] Implement hugetlbfs support for UFFDIO_POISON.

Axel Rasmussen (8):
  mm: make PTE_MARKER_SWAPIN_ERROR more general
  mm: userfaultfd: check for start + len overflow in validate_range
  mm: userfaultfd: extract file size check out into a helper
  mm: userfaultfd: add new UFFDIO_POISON ioctl
  mm: userfaultfd: support UFFDIO_POISON for hugetlbfs
  mm: userfaultfd: document and enable new UFFDIO_POISON feature
  selftests/mm: refactor uffd_poll_thread to allow custom fault handlers
  selftests/mm: add uffd unit test for UFFDIO_POISON

 Documentation/admin-guide/mm/userfaultfd.rst |  15 +++
 fs/userfaultfd.c                             |  73 ++++++++++--
 include/linux/mm_inline.h                    |  19 +++
 include/linux/swapops.h                      |  10 +-
 include/linux/userfaultfd_k.h                |   4 +
 include/uapi/linux/userfaultfd.h             |  25 +++-
 mm/hugetlb.c                                 |  51 ++++++--
 mm/madvise.c                                 |   2 +-
 mm/memory.c                                  |  15 ++-
 mm/mprotect.c                                |   4 +-
 mm/shmem.c                                   |   4 +-
 mm/swapfile.c                                |   2 +-
 mm/userfaultfd.c                             |  83 ++++++++++---
 tools/testing/selftests/mm/uffd-common.c     |   5 +-
 tools/testing/selftests/mm/uffd-common.h     |   3 +
 tools/testing/selftests/mm/uffd-stress.c     |  12 +-
 tools/testing/selftests/mm/uffd-unit-tests.c | 117 +++++++++++++++++++
 17 files changed, 377 insertions(+), 67 deletions(-)

--
2.41.0.255.g8b1d071c50-goog

