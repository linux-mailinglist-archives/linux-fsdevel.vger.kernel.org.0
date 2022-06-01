Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF9653AF31
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jun 2022 00:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbiFAVKV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jun 2022 17:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbiFAVJ5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jun 2022 17:09:57 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C914525C47
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jun 2022 14:09:55 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id m11-20020a25710b000000b0065d4a4abca1so2429019ybc.18
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Jun 2022 14:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=eoJzH/fmzFvACjVcvXMxe/8zwQW+mPMqokRQV/WBtz0=;
        b=I4e1nXx9RXm7sY0HmftB536BjJPeFCp3BQy7eEqPUaXM9dJP5nxl/iX3HWy6ta8/po
         aSntDJ87OZUR0FtlBzM4E3l1cBvHdn/FHX8nlxwNJxOL22ZrI6SfY23BjXbX1q0kvav3
         xk9J2O1V7l+QEjeclGH2UOIg8sra7op/dGXQsjM8JyhYNakRkeSH7KTyXd9giDnge1CU
         rclyMxF2ETuh7Oo61zDK5B5zsqJeq7XreghYR6/8bhFkca1C+bklF8YWphFZIi+G7CMp
         yTvTw+o1tJwJeoGsNXDRp2XEs1aWOU+sdJ5VsjYnISHAHHVhMPpnN/p3IytQmXHpnaFA
         NcGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=eoJzH/fmzFvACjVcvXMxe/8zwQW+mPMqokRQV/WBtz0=;
        b=ek921E19TGTW60gUgp9azN70+eBPQnWgG5sCyEF98S4fXWM5VbJgzX/Kn8KexBer5t
         Ta7PMEs2aeUDnKZ9EGrYkGSZXArfYP6TJIeoLxs5O/NhCtql3HkNvK6YPwZ4GpLcBZiU
         hp2LJRqXgXcvDf/jUzsxZXx/xFDr/yA/X74OWuhkn59HdGw3sa2/pme3sLWS+7fubKQM
         e/E7opbhIrkTGU2g1sd0eZp4JkNxfWJIsRhMTdGWdzPx99PZGOqf6v5Yd1qiIRwtmgk/
         vnqmS1VAeahBC0k9V3nFGIIvca1MwfvAKtuvojct+9L47lVKIIxIy4RcCVItZx1Z8AsR
         Wlqg==
X-Gm-Message-State: AOAM531mbiPocOMr6wjRDqSRpIzd//fODBCeenPdoBX+V+gvuk3w/b8l
        0QY1l3uyeqAoanYbrcOvRurpLfzvgqSeniQ0Ox2L
X-Google-Smtp-Source: ABdhPJxCWt56mzfA5CD6MeujZ27HxUTABufO/zQyWKERxfd0WM6O2BB0EgrhAOZyTRsf3KYc/T1JMlERUDmdwQvdDW0w
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:aaec:e358:9f0e:2b26])
 (user=axelrasmussen job=sendgmr) by 2002:a81:4a02:0:b0:2fe:d277:2b47 with
 SMTP id x2-20020a814a02000000b002fed2772b47mr1708755ywa.169.1654117794963;
 Wed, 01 Jun 2022 14:09:54 -0700 (PDT)
Date:   Wed,  1 Jun 2022 14:09:45 -0700
Message-Id: <20220601210951.3916598-1-axelrasmussen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v3 0/6] userfaultfd: add /dev/userfaultfd for fine grained
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This series is based on linux-next/akpm-base.

The series is split up like so:
- Patch 1 is a simple fixup which we should take in any case (even by itself).
- Patches 2-4 add the feature, basic support for it to the selftest, and docs.
- Patches 5-6 make the selftest configurable, so you can test one or the other
  instead of always both. If we decide this is overcomplicated, we could just
  drop these two patches and take the rest of the series.

Changelog:

v2->v3:
  - Rebased onto linux-next/akpm-base, in order to be based on top of the
    run_vmtests.sh refactor which was merged previously.
  - Picked up some Reviewed-by's.
  - Fixed ioctl definition (_IO instead of _IOWR), and stopped using
    compat_ptr_ioctl since it is unneeded for ioctls which don't take a pointer.
  - Removed the "handle_kernel_faults" bool, simplifying the code. The result is
    logically equivalent, but simpler.
  - Fixed userfaultfd selftest so it returns KSFT_SKIP appropriately.
  - Reworded documentation per Shuah's feedback on v2.
  - Improved example usage for userfaultfd selftest.

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

 Documentation/admin-guide/mm/userfaultfd.rst | 40 ++++++++++-
 Documentation/admin-guide/sysctl/vm.rst      |  3 +
 fs/userfaultfd.c                             | 76 ++++++++++++++++----
 include/uapi/linux/userfaultfd.h             |  4 ++
 tools/testing/selftests/vm/run_vmtests.sh    | 11 ++-
 tools/testing/selftests/vm/userfaultfd.c     | 66 ++++++++++++++---
 6 files changed, 172 insertions(+), 28 deletions(-)

--
2.36.1.255.ge46751e96f-goog

