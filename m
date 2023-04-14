Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5DC6E18A9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 02:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjDNAME (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Apr 2023 20:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjDNAMC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Apr 2023 20:12:02 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA737359A
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Apr 2023 17:11:59 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 65-20020a250244000000b00b8f53d3e51cso4873482ybc.20
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Apr 2023 17:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681431119; x=1684023119;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i+pweVgTeWv08z0ELDTsB0Ltp1Ye2bcZK0KHo4GqVbw=;
        b=SxumLiXBZqVvPSsO4nE95gXtUUxXVcRm2giZRY9/5ORZ+OjADqAAbFJkobyKcqmfCt
         ePUsZvwKG04KkaahIzuPRZeniJUEzn01e6frQqq0jAgCaSwlASsR29xtCtNlSjb+T5pj
         VEWY0EVxAPptAmO48HG5tvNAJPPxntiFot3tECFeEreHjLrDdGnAKPlTKHy30+MbbqI8
         64DeVDk4CEwT4IFGcaTIdQJJ7t2C3BZm2t+9Gp59h71CPchlPnK0jhl4w3WF/G3NQ2HG
         SBMasteYkoK5+FJ8YkRnsN77u+ShB1rljGgMoVKQvjdG4NVzxFbFqiD01CFCoQkbIqFa
         aeNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681431119; x=1684023119;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+pweVgTeWv08z0ELDTsB0Ltp1Ye2bcZK0KHo4GqVbw=;
        b=FBdDDmK0V97JYE5/ZNuykEGJSv4jEWSPz75iYWBcb2bM/AiojTUbPZt1DHyl4VTCIi
         RbLea4Sf6RsAyDO0Cs3pYO2tD0+kDdndXXdcaVNS+RZoLTWdzR6ofDlWjVrwcHTf6atB
         TgrcKZBnIZ2B9p4f4PyfB8+4efAu/vP2VCgUvNE48P+R1g3WYBLfRawfB5YVxokP7P3o
         GY1wpu8F7OzFW6HYvl/Ep8O/K0sUyR8ARbaWmZprkCDI3J9RINpaYPr9/IdLyshkfrML
         G/7xOu/R2kQIjNIF3Xit397LBzpShNfvdZSV+MdGVlddBHXzkZOLamhq8t2/mFx+qv1y
         jKfg==
X-Gm-Message-State: AAQBX9cPlA5d+pxR79BAN/dnXTqTn69qTly9UME4HyVJF9regeQTqkH/
        nahz4rkU/CAk88tm5DCmUtuOU02Ahj59IzAaKg==
X-Google-Smtp-Source: AKy350aFyMPBdyqRFopcQD1OOk7RIztiWHN973sMgROTFTwCsBiX6bTJGMx6PuL8Cu3fjd47w7zygKuC4QNdUU7X4w==
X-Received: from ackerleytng-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1f5f])
 (user=ackerleytng job=sendgmr) by 2002:a25:72d6:0:b0:b8f:55f6:e50f with SMTP
 id n205-20020a2572d6000000b00b8f55f6e50fmr2609596ybc.1.1681431119162; Thu, 13
 Apr 2023 17:11:59 -0700 (PDT)
Date:   Fri, 14 Apr 2023 00:11:49 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <cover.1681430907.git.ackerleytng@google.com>
Subject: [RFC PATCH 0/6] Setting memory policy for restrictedmem file
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
        muchun.song@linux.dev, feng.tang@intel.com, brgerst@gmail.com,
        rdunlap@infradead.org, masahiroy@kernel.org,
        mailhol.vincent@wanadoo.fr, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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
series [1].

The tree can be found at:
https://github.com/googleprodkernel/linux-cc/tree/restrictedmem-set-memory-=
policy

In this patchset, a new syscall is introduced, which allows userspace
to set the memory policy (e.g. NUMA bindings) for a restrictedmem
file, to the granularity of offsets within the file.

The offset/length tuple is termed a file_range which is passed to the
kernel via a pointer to get around the limit of 6 arguments for a
syscall.

The following other approaches were also considered:

1. Pre-configuring a mount with a memory policy and providing that
   mount to memfd_restricted() as proposed at [2].
    + Pro: It allows choice of a specific backing mount with custom
      memory policy configurations
    + Con: Will need to create an entire new mount just to set memory
      policy for a restrictedmem file; files on the same mount cannot
      have different memory policies.

2. Passing memory policy to the memfd_restricted() syscall at creation time=
.
    + Pro: Only need to make a single syscall to create a file with a
      given memory policy
    + Con: At creation time, the kernel doesn=E2=80=99t know the size of th=
e
      restrictedmem file. Given that memory policy is stored in the
      inode based on ranges (start, end), it is awkward for the kernel
      to store the memory policy and then add hooks to set the memory
      policy when allocation is done.

3. A more generic fbind(): it seems like this new functionality is
   really only needed for restrictedmem files, hence a separate,
   specific syscall was proposed to avoid complexities with handling
   conflicting policies that may be specified via other syscalls like
   mbind()

TODOs

+ Return -EINVAL if file_range is not within the size of the file and
  tests for this

Dependencies:

+ Chao=E2=80=99s work on UPM [3]

[1] https://lore.kernel.org/lkml/20221202061347.1070246-1-chao.p.peng@linux=
.intel.com/T/
[2] https://lore.kernel.org/lkml/cover.1681176340.git.ackerleytng@google.co=
m/T/
[3] https://github.com/chao-p/linux/commits/privmem-v11.5

---

Ackerley Tng (6):
  mm: shmem: Refactor out shmem_shared_policy() function
  mm: mempolicy: Refactor out mpol_init_from_nodemask
  mm: mempolicy: Refactor out __mpol_set_shared_policy()
  mm: mempolicy: Add and expose mpol_create
  mm: restrictedmem: Add memfd_restricted_bind() syscall
  selftests: mm: Add selftest for memfd_restricted_bind()

 arch/x86/entry/syscalls/syscall_32.tbl        |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl        |   1 +
 include/linux/mempolicy.h                     |   4 +
 include/linux/shmem_fs.h                      |   7 +
 include/linux/syscalls.h                      |   5 +
 include/uapi/asm-generic/unistd.h             |   5 +-
 include/uapi/linux/mempolicy.h                |   7 +-
 kernel/sys_ni.c                               |   1 +
 mm/mempolicy.c                                | 100 ++++++++++---
 mm/restrictedmem.c                            |  75 ++++++++++
 mm/shmem.c                                    |  10 +-
 scripts/checksyscalls.sh                      |   1 +
 tools/testing/selftests/mm/.gitignore         |   1 +
 tools/testing/selftests/mm/Makefile           |   8 +
 .../selftests/mm/memfd_restricted_bind.c      | 139 ++++++++++++++++++
 .../mm/restrictedmem_testmod/Makefile         |  21 +++
 .../restrictedmem_testmod.c                   |  89 +++++++++++
 tools/testing/selftests/mm/run_vmtests.sh     |   6 +
 18 files changed, 454 insertions(+), 27 deletions(-)
 create mode 100644 tools/testing/selftests/mm/memfd_restricted_bind.c
 create mode 100644 tools/testing/selftests/mm/restrictedmem_testmod/Makefi=
le
 create mode 100644 tools/testing/selftests/mm/restrictedmem_testmod/restri=
ctedmem_testmod.c

--
2.40.0.634.g4ca3ef3211-goog
