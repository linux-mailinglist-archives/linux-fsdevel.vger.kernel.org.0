Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF1E59792F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 23:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235796AbiHQVrh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 17:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241744AbiHQVrf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 17:47:35 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BE8AB197
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Aug 2022 14:47:33 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3282fe8f48fso173114937b3.17
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Aug 2022 14:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=ZccKepyy+mkkFUP/9kxuvptYUZUbOq684Zg6ooxPEl8=;
        b=oAdGHMBIBRjGZoLLA6VlX+94im86xq9mmys56n9di740YtF0BsvAgpxpdRGW7ioWJ9
         efJ4cZQsGoUWRIkGaAOqaRiwkNNqOkVw1OKvOeFHQbrACOK52MhHZO3la1555gKKAt6q
         yzBKJj2rjhmFApIEejIm2MLfg+AxYxL4fHi6H4nfI4G8cz9U2Q7F5NT64EJuA3xiSmUQ
         izE2YWr3delvoaf5cw2raoNjAS43v6W550GMyLNT4tJgveQY+FV8shQdQg+x6AkbgUYz
         retvQtg8mO4CmiutKEyqBp6+JFE/pIyHLxykKY8G7w5n/QIKIuHSHSD28Cpx0Uu/lUD2
         3H7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=ZccKepyy+mkkFUP/9kxuvptYUZUbOq684Zg6ooxPEl8=;
        b=woT+G+DJTzgb9ssJ0htrYixcjj0ZV0eN8LIVtjDrDnhR1Hw0XBGa4xGOOQYgUAgUt3
         x9F0PelUPAPHV1SAeUyzxXViyImewBDHonI8ljYo3Uq2fYO1RbQ6Qdpxd2NueLahqeCH
         eFrT03wbbdA4gx0ijlmFOHRqMpoMBvfLomxQ2Ej8uWEewQvTHDyKc0TWSm6FCW9lBlUN
         aaQfJRUWjXGTAWNk9UUYjWZUjyuk2QsCi7VJqb8AZMB9CcH1pKqpAzLu/XQ0lIXAd9XW
         0TMw6rtlepdBBlZzlbCOY7MdLSfGEqoF92ehVJNdkqCYX68VshOQvhT4wnBS7WUCxZOM
         gmZw==
X-Gm-Message-State: ACgBeo1U8KaXbLATdAyS2R3z8rbKC3LYCleEOghJU7I+DxygMaftdMMc
        7/eo5TqHn0l7/ki4cWACrrTc5Pe0FwbjioYmjMzI
X-Google-Smtp-Source: AA6agR41kshahHzOHokRZUKnpIW9g/i+LTC2cDfWo+NhTdS+UTJkI+SoWb4uW6VK9HAabIEYe6Ct3OITfI8JzSknsvQH
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2d4:203:2f41:f176:4bac:b729])
 (user=axelrasmussen job=sendgmr) by 2002:a05:6902:722:b0:679:7ff8:1471 with
 SMTP id l2-20020a056902072200b006797ff81471mr240843ybt.352.1660772852878;
 Wed, 17 Aug 2022 14:47:32 -0700 (PDT)
Date:   Wed, 17 Aug 2022 14:47:23 -0700
Message-Id: <20220817214728.489904-1-axelrasmussen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH v6 0/5] userfaultfd: add /dev/userfaultfd for fine grained
 access control
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-security-module@vger.kernel.org
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

This series is based on torvalds/master.

The series is split up like so:
- Patch 1 is a simple fixup which we should take in any case (even by itself).
- Patches 2-5 add the feature, configurable selftest support, and docs.

Why not ...?
============

- Why not /proc/[pid]/userfaultfd? Two main points (additional discussion [1]):

    - /proc/[pid]/* files are all owned by the user/group of the process, and
      they don't really support chmod/chown. So, without extending procfs it
      doesn't solve the problem this series is trying to solve.

    - The main argument *for* this was to support creating UFFDs for remote
      processes. But, that use case clearly calls for CAP_SYS_PTRACE, so to
      support this we could just use the UFFD syscall as-is.

- Why not use a syscall? Access to syscalls is generally controlled by
  capabilities. We don't have a capability which is used for userfaultfd access
  without also granting more / other permissions as well, and adding a new
  capability was rejected [2].

    - It's possible a LSM could be used to control access instead, but I have
      some concerns. I don't think this approach would be as easy to use,
      particularly if we were to try to solve this with something heavyweight
      like SELinux. Maybe we could pursue adding a new LSM specifically for
      this user case, but it may be too narrow of a case to justify that.

Changelog
=========

v5->v6:
  - Modified selftest to exit with KSFT_SKIP *only* when features are
    unsupported, exiting with 1 in other error cases. [Mike]
  - Improved wording in two spots in the documentation. [Mike]
  - Picked up some Acked-by's.

v4->v5:
  - Call userfaultfd_syscall_allowed() directly in the syscall, so we don't
    have to plumb a flag into new_userfaultfd(). [Nadav]
  - Refactored run_vmtests.sh to loop over UFFD test mods. [Nadav]
  - Reworded cover letter.
  - Picked up some Acked-by's.

v3->v4:
  - Picked up an Acked-by on 5/5.
  - Updated cover letter to cover "why not ...".
  - Refactored userfaultfd_allowed() into userfaultfd_syscall_allowed(). [Peter]
  - Removed obsolete comment from a previous version. [Peter]
  - Refactored userfaultfd_open() in selftest. [Peter]
  - Reworded admin-guide documentation. [Mike, Peter]
  - Squashed 2 commits adding /dev/userfaultfd to selftest and making selftest
    configurable. [Peter]
  - Added "syscall" test modifier (the default behavior) to selftest. [Peter]

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

[1]: https://patchwork.kernel.org/project/linux-mm/cover/20220719195628.3415852-1-axelrasmussen@google.com/
[2]: https://lore.kernel.org/lkml/686276b9-4530-2045-6bd8-170e5943abe4@schaufler-ca.com/T/

Axel Rasmussen (5):
  selftests: vm: add hugetlb_shared userfaultfd test to run_vmtests.sh
  userfaultfd: add /dev/userfaultfd for fine grained access control
  userfaultfd: selftests: modify selftest to use /dev/userfaultfd
  userfaultfd: update documentation to describe /dev/userfaultfd
  selftests: vm: add /dev/userfaultfd test cases to run_vmtests.sh

 Documentation/admin-guide/mm/userfaultfd.rst | 41 ++++++++++-
 Documentation/admin-guide/sysctl/vm.rst      |  3 +
 fs/userfaultfd.c                             | 73 ++++++++++++++-----
 include/uapi/linux/userfaultfd.h             |  4 ++
 tools/testing/selftests/vm/run_vmtests.sh    | 15 ++--
 tools/testing/selftests/vm/userfaultfd.c     | 76 +++++++++++++++++---
 6 files changed, 178 insertions(+), 34 deletions(-)

--
2.37.1.595.g718a3a8f04-goog

