Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A076DCF3F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 03:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjDKB3k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Apr 2023 21:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjDKB3j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Apr 2023 21:29:39 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603681712
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Apr 2023 18:29:37 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id o19-20020a254113000000b00b8ed021361bso7467850yba.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Apr 2023 18:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1681176576;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u35FXb24rxXsoG0aCEe4m7ddoHISWHWt5V4ebjSzsz4=;
        b=o2tU5lXa5GgaaWuGTbd5bbvKtG3z3RSme5Cet24inDTS7nOrViJmL/iq51gozQkU0w
         fSc14g51lyAN7EZ2W2YdqFHXsQ6fhtJt3Ww8txhLuuaqZ7otipQp1kY2GirbtpvPd8tz
         qOFtr4vKJdNigycQsXduABdE6Mx/1K8btlYWEfUtLHRYy5H01FBzkck2ffnGkGbDsNsT
         ZbsMLLNEojFf+Yy7PynOmDitIMxxEZiFMr4qBeOETiKphih3BdTfUf4XHIT8Qtk4z1z+
         d9h/ldEYXKqGvPbthLo+j90zJo0SUaeonPgvSapyQgn4pLlBWcLiJxpQI3QivbmMF29i
         8afA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681176576;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u35FXb24rxXsoG0aCEe4m7ddoHISWHWt5V4ebjSzsz4=;
        b=YCbi2amgnPFRqxaNPRRkTfI4lwhvfg1sO8F//frxC+MBbGjBIJr/veaWQDkOUTGWIL
         ZAapa+P9JqxCYl0bKXPbI3DXrM6g/aaLVg16Q5dJO4Zaa8VakZVe1p8rOWimCTxBH5OK
         mulPdM06s7L3nq+iS8nMyQHHPpeoOvrG8QxKya5tS4iixbb3RlpcNIMcUF2xIQwYWREC
         c1pCIkE8bgDqxMShJTk03D/H/j2FDhu3862VqhelmHbLAB8X3/LbtyLf0Af14xvY7ccH
         cq0bWxiU7l0cFaHuc5KYdj0z3LjlsHtc9awM69JGjMFPvecF399LUaKdzwFwOr0Gk+dp
         vCRA==
X-Gm-Message-State: AAQBX9ceKkdFW7ORU1oEYf1Q1hyysx/NcWclG5cm7UrZlVaAnaCWKQfR
        XQBdoF6IjcoIn8IbKyYoUfCxcMipiArMYCcTRw==
X-Google-Smtp-Source: AKy350avHjLsg9mTzZAWYFqY+XYZP5h/AOkdol2OZ6k0pfwzqyIYSmwhwrM4doSRB7oAHOnKfLu7oA90tp2KCOA+fw==
X-Received: from ackerleytng-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1f5f])
 (user=ackerleytng job=sendgmr) by 2002:a05:690c:1:b0:544:bbd2:74be with SMTP
 id bc1-20020a05690c000100b00544bbd274bemr8286702ywb.4.1681176576562; Mon, 10
 Apr 2023 18:29:36 -0700 (PDT)
Date:   Tue, 11 Apr 2023 01:29:31 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <cover.1681176340.git.ackerleytng@google.com>
Subject: [RFC PATCH v4 0/2] Providing mount in memfd_restricted() syscall
From:   Ackerley Tng <ackerleytng@google.com>
To:     kvm@vger.kernel.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, qemu-devel@nongnu.org
Cc:     aarcange@redhat.com, ak@linux.intel.com, akpm@linux-foundation.org,
        arnd@arndb.de, bfields@fieldses.org, bp@alien8.de,
        chao.p.peng@linux.intel.com, corbet@lwn.net, dave.hansen@intel.com,
        david@redhat.com, ddutile@redhat.com, dhildenb@redhat.com,
        hpa@zytor.com, hughd@google.com, jlayton@kernel.org,
        jmattson@google.com, joro@8bytes.org, jun.nakajima@intel.com,
        kirill.shutemov@linux.intel.com, linmiaohe@huawei.com,
        luto@kernel.org, mail@maciej.szmigiero.name, mhocko@suse.com,
        michael.roth@amd.com, mingo@redhat.com, naoya.horiguchi@nec.com,
        pbonzini@redhat.com, qperret@google.com, rppt@kernel.org,
        seanjc@google.com, shuah@kernel.org, steven.price@arm.com,
        tabba@google.com, tglx@linutronix.de, vannapurve@google.com,
        vbabka@suse.cz, vkuznets@redhat.com, wanpengli@tencent.com,
        wei.w.wang@intel.com, x86@kernel.org, yu.c.zhang@linux.intel.com,
        Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

This patchset builds upon the memfd_restricted() system call that was
discussed in the 'KVM: mm: fd-based approach for supporting KVM' patch
series, at
https://lore.kernel.org/lkml/20221202061347.1070246-1-chao.p.peng@linux.int=
el.com/T/

The tree can be found at:
https://github.com/googleprodkernel/linux-cc/tree/restrictedmem-provide-mou=
nt-fd-rfc-v4

In this patchset, a modification to the memfd_restricted() syscall is
proposed, which allows userspace to provide a mount, on which the
restrictedmem file will be created and returned from the
memfd_restricted().

Allowing userspace to provide a mount allows userspace to control
various memory binding policies via tmpfs mount options, such as
Transparent HugePage memory allocation policy through
'huge=3Dalways/never' and NUMA memory allocation policy through
'mpol=3Dlocal/bind:*'.

Changes since RFCv3:
+ Added check to ensure that bind mounts must be bind mounts of the
  whole filesystem
+ Removed inappropriate check on fd=E2=80=99s permissions as Christian
  suggested
+ Renamed RMFD_USERMNT to MEMFD_RSTD_USERMNT as David suggested
+ Added selftest to check that bind mounts must be bind mounts of the
  whole filesystem

Changes since RFCv2:
+ Tightened semantics to accept only fds of the root of a tmpfs mount,
  as Christian suggested
+ Added permissions check on the inode represented by the fd to guard
  against creation of restrictedmem files on read-only tmpfs
  filesystems or mounts
+ Renamed RMFD_TMPFILE to RMFD_USERMNT to better represent providing a
  userspace mount to create a restrictedmem file on
+ Updated selftests for tighter semantics and added selftests to check
  for permissions

Changes since RFCv1:
+ Use fd to represent mount instead of path string, as Kirill
  suggested. I believe using fds makes this syscall interface more
  aligned with the other syscalls like fsopen(), fsconfig(), and
  fsmount() in terms of using and passing around fds
+ Remove unused variable char *orig_shmem_enabled from selftests

Dependencies:
+ Chao=E2=80=99s work on UPM, at
  https://github.com/chao-p/linux/commits/privmem-v11.5

Links to earlier patch series:
+ RFC v3: https://lore.kernel.org/lkml/cover.1680306489.git.ackerleytng@goo=
gle.com/T/
+ RFC v2: https://lore.kernel.org/lkml/cover.1679428901.git.ackerleytng@goo=
gle.com/T/
+ RFC v1: https://lore.kernel.org/lkml/cover.1676507663.git.ackerleytng@goo=
gle.com/T/

Ackerley Tng (2):
  mm: restrictedmem: Allow userspace to specify mount for
    memfd_restricted
  selftests: restrictedmem: Check memfd_restricted()'s handling of
    provided userspace mount

 include/linux/syscalls.h                      |   2 +-
 include/uapi/linux/restrictedmem.h            |   8 +
 mm/restrictedmem.c                            |  73 ++-
 tools/testing/selftests/mm/.gitignore         |   1 +
 tools/testing/selftests/mm/Makefile           |   1 +
 .../selftests/mm/memfd_restricted_usermnt.c   | 529 ++++++++++++++++++
 tools/testing/selftests/mm/run_vmtests.sh     |   3 +
 7 files changed, 611 insertions(+), 6 deletions(-)
 create mode 100644 include/uapi/linux/restrictedmem.h
 create mode 100644 tools/testing/selftests/mm/memfd_restricted_usermnt.c

--
2.40.0.577.gac1e443424-goog
