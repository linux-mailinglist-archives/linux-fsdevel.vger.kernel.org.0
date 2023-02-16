Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E08869895A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Feb 2023 01:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbjBPAld (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Feb 2023 19:41:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjBPAlc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Feb 2023 19:41:32 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7231942DEF
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Feb 2023 16:41:30 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id y28-20020a056a001c9c00b005a8c5cd5ae9so303729pfw.22
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Feb 2023 16:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KyDL7aG5vadqxs1ZDVMtNmlMp6h+pTwRitO0Vsd+xXA=;
        b=UlyGz18Rq6eKdsAzT90nvKAGzObDlWojIa+4RUu1raCFtQqRUYcy3SspX0jxdJ9rb0
         Nw7weHMdrBLZ31wvo1gRWxGi06bUObPJDZmDnyE3qo/jMx6/HDaZTvkl6TQazEiCG569
         utifp/LkZIaUBLsxN8fp/8hujvgldojhDyaXNaI8MeFAbY3JeVjvD0NkW2/MUJ28e42V
         ZMWfGCIgfQWx7Q2YfH7HNWCie5aE+GUgO/fc5leiKryY6MB/sRZht4uh4VjIQkc1sgzj
         o5tcKSvOUm3vBr0kx5kdnMHT1xneMoUIuFwr5LQO2CkBOhtS2iifTcqrX4jc6sGsYjIC
         IkyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KyDL7aG5vadqxs1ZDVMtNmlMp6h+pTwRitO0Vsd+xXA=;
        b=Qjc/sL2wlchBw5z7KvZVhgMvkQOWIGCRPSoBySBtz2FrGWtLQMRWzGxpkqLZmgjzjk
         eHS86yzGaGdqfpv/d5KJmBfBGWWTgcVjmrP8dkaspmTiTM26TNpVRf3a78Ql7xdjM+9N
         J31B8R3OSvCj6EYR45JlVYiaGoJ9GXuQA1Npb8UbnO8e7z2sd3dA3g/7qUWIuCrtBTYl
         /Z4gD7q/OL2VqqmEWs3ck+ZMsgfkYcd79a2JUaVGKAl6GWWaGvHymkwtpA98p/tmEVr1
         L9ri0++PH9ZL26pQjnlPFZc1HBDYLLsNhZM4YWolnS3jQ2RLfuO8KiO7snEucyIPl20K
         2c8A==
X-Gm-Message-State: AO0yUKWVo9mco5yyOAUVM7/l91lMem9JNMeA61qn+TWqlUX0oyAUbiT0
        snQ5wcGlEmfXiPfRJj2RBPPfd6B3yWohmq/GyA==
X-Google-Smtp-Source: AK7set9ULYqZvTPKnXy7w+XwzeOZWCcMQ4uqZfm4qVlxGYvM8N3GKtC4fbQQyb++BnxdRdIQAt0St6aX14Ha/b9zJw==
X-Received: from ackerleytng-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1f5f])
 (user=ackerleytng job=sendgmr) by 2002:a63:7a1c:0:b0:4fb:ab27:fa7 with SMTP
 id v28-20020a637a1c000000b004fbab270fa7mr637750pgc.0.1676508089776; Wed, 15
 Feb 2023 16:41:29 -0800 (PST)
Date:   Thu, 16 Feb 2023 00:41:15 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.637.g21b0678d19-goog
Message-ID: <cover.1676507663.git.ackerleytng@google.com>
Subject: [RFC PATCH 0/2] Providing mount for memfd_restricted() syscall
From:   Ackerley Tng <ackerleytng@google.com>
To:     kvm@vger.kernel.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, qemu-devel@nongnu.org
Cc:     chao.p.peng@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, akpm@linux-foundation.org, arnd@arndb.de,
        bfields@fieldses.org, bp@alien8.de, corbet@lwn.net,
        dave.hansen@intel.com, david@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, hpa@zytor.com, hughd@google.com,
        jlayton@kernel.org, jmattson@google.com, joro@8bytes.org,
        jun.nakajima@intel.com, kirill.shutemov@linux.intel.com,
        linmiaohe@huawei.com, luto@kernel.org, mail@maciej.szmigiero.name,
        mhocko@suse.com, michael.roth@amd.com, mingo@redhat.com,
        naoya.horiguchi@nec.com, pbonzini@redhat.com, qperret@google.com,
        rppt@kernel.org, seanjc@google.com, shuah@kernel.org,
        steven.price@arm.com, tabba@google.com, tglx@linutronix.de,
        vannapurve@google.com, vbabka@suse.cz, vkuznets@redhat.com,
        wanpengli@tencent.com, wei.w.wang@intel.com, x86@kernel.org,
        yu.c.zhang@linux.intel.com, Ackerley Tng <ackerleytng@google.com>
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

This patchset builds upon the memfd_restricted() system call that has
been discussed in the =E2=80=98KVM: mm: fd-based approach for supporting KV=
M=E2=80=99
patch series, at
https://lore.kernel.org/lkml/20221202061347.1070246-1-chao.p.peng@linux.int=
el.com/T/#m7e944d7892afdd1d62a03a287bd488c56e377b0c

The tree can be found at:
https://github.com/googleprodkernel/linux-cc/tree/restrictedmem-provide-mou=
nt-path

In this patchset, a modification to the memfd_restricted() syscall is
proposed, which allows userspace to provide a mount, on which the file
will be created and returned from the memfd_restricted().

Allowing userspace to provide a mount allows userspace to control
various memory binding policies via tmpfs mount options, such as
Transparent HugePage memory allocation policy through
=E2=80=98huge=3Dalways/never=E2=80=99 and NUMA memory allocation policy thr=
ough
=E2=80=98mpol=3Dlocal/bind:*=E2=80=99.

Dependencies:
+ Sean=E2=80=99s iteration of the =E2=80=98KVM: mm: fd-based approach for s=
upporting
  KVM=E2=80=99 patch series at
  https://github.com/sean-jc/linux/tree/x86/upm_base_support
+ Proposed fixes for these issues mentioned on the mailing list:
    + https://lore.kernel.org/lkml/diqzzga0fv96.fsf@ackerleytng-cloudtop-sg=
.c.googlers.com/

Future work/TODOs:
+ man page for the memfd_restricted() syscall
+ Support for per file Transparent HugePage allocation hints
+ Support for per file NUMA binding hints

Ackerley Tng (2):
  mm: restrictedmem: Allow userspace to specify mount_path for
    memfd_restricted
  selftests: restrictedmem: Check hugepage-ness of shmem file backing
    restrictedmem fd

 include/linux/syscalls.h                      |   2 +-
 include/uapi/linux/restrictedmem.h            |   8 +
 mm/restrictedmem.c                            |  63 +++-
 tools/testing/selftests/Makefile              |   1 +
 .../selftests/restrictedmem/.gitignore        |   3 +
 .../testing/selftests/restrictedmem/Makefile  |  14 +
 .../testing/selftests/restrictedmem/common.c  |   9 +
 .../testing/selftests/restrictedmem/common.h  |   8 +
 .../restrictedmem_hugepage_test.c             | 344 ++++++++++++++++++
 9 files changed, 445 insertions(+), 7 deletions(-)
 create mode 100644 include/uapi/linux/restrictedmem.h
 create mode 100644 tools/testing/selftests/restrictedmem/.gitignore
 create mode 100644 tools/testing/selftests/restrictedmem/Makefile
 create mode 100644 tools/testing/selftests/restrictedmem/common.c
 create mode 100644 tools/testing/selftests/restrictedmem/common.h
 create mode 100644 tools/testing/selftests/restrictedmem/restrictedmem_hug=
epage_test.c

--
2.39.1.637.g21b0678d19-goog
