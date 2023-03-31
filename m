Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60EA6D2BC1
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Apr 2023 01:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbjCaXus (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Mar 2023 19:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbjCaXur (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Mar 2023 19:50:47 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C571C1D2
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Mar 2023 16:50:45 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id y186-20020a62cec3000000b00627df3d6ec4so11125347pfg.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Mar 2023 16:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680306645;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MX7MCqmj1YYihUkBpAVlEeGMviJT2cJPKDZIN4OR+eI=;
        b=rs2Oji081/y9n1X5EoKWy+YAnL83qBuCdumcenLPrxwfD9FhAIw4hlVj4XP7/Y5Csq
         lU5b9UIB/trmNN3L2g1BONn/YlWj6kHwCJvT6fd05AaijB3WMTF8/D+hd3HfgCkafQDu
         NbHJ0a1bnlAMC3KxpgtTUZNOqAMxuDxYtesuddpHrX/ENLS89CzH5G+JzzOmQK4jvnd5
         5mTrfkQj806FnvEE68QrxmzAe0mZ26vs2memR3hQ+yGRR4Hz54qvdF34OtXX2se9Qkq6
         yuJZ+avzEi827lI5ZZjCExL+izen0tkcmYbNDaEC2FQNPb5gMHAwJLc2JI7bg+7pOI5w
         M4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680306645;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MX7MCqmj1YYihUkBpAVlEeGMviJT2cJPKDZIN4OR+eI=;
        b=PbM0RqZD5KaUuizGEahB9FXeoIRvCkufZx0asUukcZY6aiO3SHm+w2H/53TYDTtQI2
         opAn8blBXTXi74G6OwpCCQVtjkC6fUCCPmQ4O2VUXdmEPwjW2DVHpXv89AtY7wqAy62S
         Mo0lgjRo21JE6b+TdwA68pRUeEEE2g+CUco71n/uKo7yUi/DmSns8ufW7XbAYqLZYxLm
         3jeefV0C8rj4upxd7Ac/cuwK8toM6DPve/BT2zfmNUa7xCNZbOcLkiAkrpoqMXGrtmq3
         nQEOWT5qU0Z6NcliBokTCKdfxCe0Goz94Uh/KK7jcA+1obrjYH9jxrMXk0cJrd+6KRqp
         PqOg==
X-Gm-Message-State: AAQBX9fFRiXZaqtt54PiSbvzi2dnfjv9oJwEsF87Cfv+a9eUTR9sUDGb
        GGAaYej5kkcUmEtlHU1cLtfdpI9DKmkwLw2A2g==
X-Google-Smtp-Source: AKy350ZJqTbZ16YecPSOF6v5SkmsCRDk16kOZmltq0SjCslWgUg34hFI5HGJzZ+7T5IgczsqwP1P6KdxKJ0KIpzgeg==
X-Received: from ackerleytng-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1f5f])
 (user=ackerleytng job=sendgmr) by 2002:a05:6a00:a12:b0:62d:9bea:2a0c with
 SMTP id p18-20020a056a000a1200b0062d9bea2a0cmr8375791pfh.4.1680306645245;
 Fri, 31 Mar 2023 16:50:45 -0700 (PDT)
Date:   Fri, 31 Mar 2023 23:50:38 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <cover.1680306489.git.ackerleytng@google.com>
Subject: [RFC PATCH v3 0/2] Providing mount in memfd_restricted() syscall
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
discussed in the =E2=80=98KVM: mm: fd-based approach for supporting KVM=E2=
=80=99 patch
series, at
https://lore.kernel.org/lkml/20221202061347.1070246-1-chao.p.peng@linux.int=
el.com/T/

The tree can be found at:
https://github.com/googleprodkernel/linux-cc/tree/restrictedmem-provide-mou=
nt-fd-rfc-v3

In this patchset, a modification to the memfd_restricted() syscall is
proposed, which allows userspace to provide a mount, on which the
restrictedmem file will be created and returned from the
memfd_restricted().

Allowing userspace to provide a mount allows userspace to control
various memory binding policies via tmpfs mount options, such as
Transparent HugePage memory allocation policy through
=E2=80=98huge=3Dalways/never=E2=80=99 and NUMA memory allocation policy thr=
ough
=E2=80=98mpol=3Dlocal/bind:*=E2=80=99.

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
+ Sean=E2=80=99s iteration of the =E2=80=98KVM: mm: fd-based approach for s=
upporting
  KVM=E2=80=99 patch series at
  https://github.com/sean-jc/linux/tree/x86/upm_base_support
+ Proposed fixes for these issues mentioned on the mailing list:
    + https://lore.kernel.org/lkml/diqzzga0fv96.fsf@ackerleytng-cloudtop-sg=
.c.googlers.com/

Links to earlier patch series:
+ RFC v2: https://lore.kernel.org/lkml/cover.1679428901.git.ackerleytng@goo=
gle.com/T/
+ RFC v1: https://lore.kernel.org/lkml/cover.1676507663.git.ackerleytng@goo=
gle.com/T/

---

Ackerley Tng (2):
  mm: restrictedmem: Allow userspace to specify mount for
    memfd_restricted
  selftests: restrictedmem: Check hugepage-ness of shmem file backing
    restrictedmem fd

 include/linux/syscalls.h                      |   2 +-
 include/uapi/linux/restrictedmem.h            |   8 +
 mm/restrictedmem.c                            |  74 ++-
 tools/testing/selftests/Makefile              |   1 +
 .../selftests/restrictedmem/.gitignore        |   3 +
 .../testing/selftests/restrictedmem/Makefile  |  15 +
 .../testing/selftests/restrictedmem/common.c  |   9 +
 .../testing/selftests/restrictedmem/common.h  |   8 +
 .../restrictedmem_hugepage_test.c             | 486 ++++++++++++++++++
 9 files changed, 599 insertions(+), 7 deletions(-)
 create mode 100644 include/uapi/linux/restrictedmem.h
 create mode 100644 tools/testing/selftests/restrictedmem/.gitignore
 create mode 100644 tools/testing/selftests/restrictedmem/Makefile
 create mode 100644 tools/testing/selftests/restrictedmem/common.c
 create mode 100644 tools/testing/selftests/restrictedmem/common.h
 create mode 100644 tools/testing/selftests/restrictedmem/restrictedmem_hug=
epage_test.c

--
2.40.0.348.gf938b09366-goog
