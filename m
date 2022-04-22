Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3570950C382
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Apr 2022 01:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233342AbiDVWia (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 18:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbiDVWh2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:37:28 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7899A1F3131
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Apr 2022 14:29:51 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id j11-20020a05690212cb00b006454988d225so8177988ybu.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Apr 2022 14:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=2OUrHBVQ2XGsiWEMmpN9lcaXOoCh5x5IHeSwakaqCjU=;
        b=Aow8LWdbHQ8mE+wjvovuTbsPF39TiJA6sPYxg2JQZd+23m8l/+XB1F9qkMvdVXNRg0
         fZev5Etdz1q0hIsgyZWbSaFZjTBdJ9VWCFBRU8eBVfHaxsBOGqI7cDhN5oo9gC413a3m
         gvWZRS9e7nI30010ze8OFrC8V0LO6LXC6C5UwdqfIs2kLN7U21jZtH7KzWi2ief0rAaS
         CYQdE1MI7oRVde8cp8DeJ4sP2q24P5vdBoqq4mORARm3WuCFCIS7zNqsMlQPsYyrhUDe
         LO3euRkIUxqJygFfIefkCW2M4IxKVAvFPsRkNRhJwmmkIG9+Oudn+R7bw4c5wsDDt67i
         rj5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=2OUrHBVQ2XGsiWEMmpN9lcaXOoCh5x5IHeSwakaqCjU=;
        b=x01H7FFGmgxzHpWPWtxEep/lIbcWd06akWI3rRmm7f0c0in0GOxOAeQ+cpbT5D609F
         JlDxDLXt8gCg6p1JuLtSQneFNAcpUQYVGVq+OPrAAZ8Up0mkZWQV4m5gsmEkSomKaDZw
         csUyxMq3fOUI9MM8zOp/wS8fP5xVY7mBts2n+nve6FxeRd+aIhoh3ZVKV5sxJJlSMb9o
         oIjf9O71pBY5/FQIuhD8m90UY1IE/xnVw4RWgJt1gLV6qZnAdW87nVKHYZDVZwiLyn7w
         6Bs4obnvV+poZdmqVxPUsc3fZt1sgMlFjcwEIv8ftnjdLwWZqsd+S5OweAHd4hVKIiJe
         SGPg==
X-Gm-Message-State: AOAM530jN/TlNwtcgmnBweYscXoswZWXI9SjtvwAiJ/OOYu39/JGjaJ8
        fe3eZAF1w7x817dXL+H/CSzJVtkwAR3aTrZU88lc
X-Google-Smtp-Source: ABdhPJzN20+x39HHCgsQ8s+XetICyuwHBA/K5CIlhrR9l07xTY2TvqCOCgmubuPwmhK7ht8/vTRA3nNCJmwDMnx0uVbs
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:7ba6:20ac:a8f7:1dbd])
 (user=axelrasmussen job=sendgmr) by 2002:a25:9f90:0:b0:624:521e:d4a5 with
 SMTP id u16-20020a259f90000000b00624521ed4a5mr6505440ybq.230.1650662990723;
 Fri, 22 Apr 2022 14:29:50 -0700 (PDT)
Date:   Fri, 22 Apr 2022 14:29:39 -0700
Message-Id: <20220422212945.2227722-1-axelrasmussen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v2 0/6] userfaultfd: add /dev/userfaultfd for fine grained
 access control
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Charan Teja Reddy <charante@codeaurora.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, zhangyi <yi.zhang@huawei.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
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

This series is based on torvalds/master, but additionally the run_vmtests.sh
changes assume my refactor [1] has been applied first.

The series is split up like so:
- Patch 1 is a simple fixup which we should take in any case (even by itself).
- Patches 2-4 add the feature, basic support for it to the selftest, and docs.
- Patches 5-6 make the selftest configurable, so you can test one or the other
  instead of always both. If we decide this is overcomplicated, we could just
  drop these two patches and take the rest of the series.

[1]: https://patchwork.kernel.org/project/linux-mm/patch/20220421224928.1848230-1-axelrasmussen@google.com/

Changelog:
v1->v2:
  - Add documentation update.
  - Test *both* userfaultfd(2) and /dev/userfaultfd via the selftest.

Axel Rasmussen (6):
  selftests: vm: add hugetlb_shared userfaultfd test to run_vmtests.sh
  userfaultfd: add /dev/userfaultfd for fine grained access control
  userfaultfd: selftests: modify selftest to use /dev/userfaultfd
  userfaultfd: update documentation to describe /dev/userfaultfd
  userfaultfd: selftests: make /dev/userfaultfd testing configurable
  selftests: vm: add /dev/userfaultfd test cases to run_vmtests.sh

 Documentation/admin-guide/mm/userfaultfd.rst | 38 +++++++++-
 Documentation/admin-guide/sysctl/vm.rst      |  3 +
 fs/userfaultfd.c                             | 79 ++++++++++++++++----
 include/uapi/linux/userfaultfd.h             |  4 +
 tools/testing/selftests/vm/run_vmtests.sh    | 11 ++-
 tools/testing/selftests/vm/userfaultfd.c     | 60 +++++++++++++--
 6 files changed, 170 insertions(+), 25 deletions(-)

--
2.36.0.rc2.479.g8af0fa9b8e-goog

